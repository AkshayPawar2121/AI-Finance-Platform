package com.nextgendemo.demo.Home.IncomeDeposit.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nextgendemo.demo.Home.GoalSetter.Entity.AmountSet;
import com.nextgendemo.demo.Home.GoalSetter.Repository.GoalRepository;
import com.nextgendemo.demo.Home.IncomeDeposit.Entity.AccountSettings;
import com.nextgendemo.demo.Home.IncomeDeposit.Entity.Notification;
import com.nextgendemo.demo.Home.IncomeDeposit.Repository.AccountSettingsRepository;
import com.nextgendemo.demo.Home.IncomeDeposit.Repository.NotificationRepository;

@Service
public class IncomeDepositService {

    @Autowired
    private AccountSettingsRepository accountSettingsRepository;

    @Autowired
    private GoalRepository goalRepository;

    @Autowired
    private NotificationRepository notificationRepository;

    public AccountSettings getAccountSettings(String userName) {
        Optional<AccountSettings> opt = accountSettingsRepository.findByUserName(userName);
        if (opt.isPresent()) {
            return opt.get();
        }
        AccountSettings settings = new AccountSettings(userName, 10000.0, 1000.0, 100.0);
        return accountSettingsRepository.save(settings);
    }

    public List<Notification> getUserNotifications(String userName) {
        return notificationRepository.findByUserNameOrderByCreatedAtDesc(userName);
    }

    @Transactional
    public AccountSettings updateSettingsAndAllocations(
            String userName,
            Double safetyFloor,
            Double minDepositAmount,
            Double accountBalance,
            Map<Long, Double> goalAllocations) {

        if (safetyFloor != null && safetyFloor < 0) {
            throw new IllegalArgumentException("Safety floor threshold cannot be negative");
        }
        if (minDepositAmount != null && minDepositAmount < 0) {
            throw new IllegalArgumentException("Minimum deposit trigger cannot be negative");
        }
        if (accountBalance != null && accountBalance < 0) {
            throw new IllegalArgumentException("Account balance cannot be negative");
        }

        // Validate cumulative allocation percentage <= 100%
        double totalPercent = 0.0;
        if (goalAllocations != null) {
            for (Map.Entry<Long, Double> entry : goalAllocations.entrySet()) {
                Double pct = entry.getValue();
                if (pct != null) {
                    if (pct < 0 || pct > 100) {
                        throw new IllegalArgumentException("Goal allocation percentage must be between 0% and 100%");
                    }
                    totalPercent += pct;
                }
            }
        }

        if (totalPercent > 100.0 + 1e-6) {
            throw new IllegalArgumentException(
                String.format("Total cumulative allocation percentage cannot exceed 100%%. (Current total: %.2f%%)", totalPercent));
        }

        AccountSettings settings = getAccountSettings(userName);
        if (safetyFloor != null) {
            settings.setSafetyFloor(safetyFloor);
        }
        if (minDepositAmount != null) {
            settings.setMinDepositAmount(minDepositAmount);
        }
        if (accountBalance != null) {
            settings.setAccountBalance(accountBalance);
        }
        settings = accountSettingsRepository.save(settings);

        if (goalAllocations != null) {
            for (Map.Entry<Long, Double> entry : goalAllocations.entrySet()) {
                Optional<AmountSet> gOpt = goalRepository.findById(entry.getKey());
                if (gOpt.isPresent() && userName.equals(gOpt.get().getUserName())) {
                    AmountSet goal = gOpt.get();
                    goal.setAllocationPercentage(entry.getValue() != null ? entry.getValue() : 0.0);
                    goalRepository.save(goal);
                }
            }
        }

        return settings;
    }

    @Transactional
    public Map<String, Object> processIncomeDeposit(String userName, Double depositAmount) {
        if (depositAmount == null || depositAmount <= 0) {
            throw new IllegalArgumentException("Deposit amount must be greater than zero");
        }

        AccountSettings settings = getAccountSettings(userName);
        List<AmountSet> userGoals = goalRepository.findByUserName(userName);

        double minDeposit = settings.getMinDepositAmount();
        double safetyFloor = settings.getSafetyFloor();
        double priorBalance = settings.getAccountBalance();

        // 1. Check if external deposit is below configured minimum deposit trigger amount
        if (depositAmount < minDeposit) {
            double newBalance = priorBalance + depositAmount;
            settings.setAccountBalance(newBalance);
            accountSettingsRepository.save(settings);

            String msg = String.format(
                "Deposit of ₹%.2f received, but it is below your minimum deposit trigger threshold of ₹%.2f. No automated goal transfers were initiated.",
                depositAmount, minDeposit);
            
            Notification notif = new Notification(
                userName, "Deposit Received (Below Trigger Threshold)", msg, "BELOW_MINIMUM", depositAmount, 0.0);
            notificationRepository.save(notif);

            return buildResultMap("BELOW_MINIMUM", msg, depositAmount, 0.0, priorBalance, newBalance, new ArrayList<>(), notif);
        }

        // 2. Guardrail: Never initiate transfer if account balance is already below safety floor prior to deposit
        if (priorBalance < safetyFloor) {
            double newBalance = priorBalance + depositAmount;
            settings.setAccountBalance(newBalance);
            accountSettingsRepository.save(settings);

            String msg = String.format(
                "Deposit of ₹%.2f received. Automated goal transfers were HALTED because your account balance prior to deposit (₹%.2f) was below your safety floor threshold (₹%.2f).",
                depositAmount, priorBalance, safetyFloor);

            Notification notif = new Notification(
                userName, "Goal Transfers Halted (Safety Floor Breach)", msg, "PAUSED", depositAmount, 0.0);
            notificationRepository.save(notif);

            return buildResultMap("PAUSED", msg, depositAmount, 0.0, priorBalance, newBalance, new ArrayList<>(), notif);
        }

        // 3. Process percentage transfers with safety floor protection
        double totalAvailable = priorBalance + depositAmount;
        double totalIntendedTransfer = 0.0;
        List<Map<String, Object>> splits = new ArrayList<>();

        for (AmountSet goal : userGoals) {
            double pct = goal.getAllocationPercentage();
            if (pct > 0) {
                double intended = depositAmount * (pct / 100.0);
                totalIntendedTransfer += intended;
            }
        }

        double maxTransferAllowed = Math.max(0.0, totalAvailable - safetyFloor);
        double actualTotalTransfer = 0.0;
        String status = "EXECUTED";
        String statusTitle = "Income Deposit Transfers Executed";

        if (maxTransferAllowed <= 1e-6 || totalIntendedTransfer <= 1e-6) {
            if (totalIntendedTransfer > 0 && maxTransferAllowed <= 1e-6) {
                status = "PAUSED";
                statusTitle = "Goal Transfers Paused (Safety Floor Protection)";
            }
            actualTotalTransfer = 0.0;
        } else if (maxTransferAllowed >= totalIntendedTransfer) {
            actualTotalTransfer = totalIntendedTransfer;
            status = "EXECUTED";
        } else {
            actualTotalTransfer = maxTransferAllowed;
            status = "REDUCED";
            statusTitle = "Goal Transfers Scaled Down (Safety Floor Protection)";
        }

        double scaleFactor = (totalIntendedTransfer > 0) ? (actualTotalTransfer / totalIntendedTransfer) : 0.0;
        StringBuilder splitSummary = new StringBuilder();
        double sumActualTransferred = 0.0;

        for (AmountSet goal : userGoals) {
            double pct = goal.getAllocationPercentage();
            if (pct <= 0) continue;

            double intended = depositAmount * (pct / 100.0);
            double actual = intended * scaleFactor;

            double targetVal = 0.0;
            try {
                targetVal = Double.parseDouble(goal.getTarget());
            } catch (Exception ignored) {}

            double currentPaid = goal.getRemainingAmount() != null ? goal.getRemainingAmount() : 0;
            if (targetVal > 0 && currentPaid + actual > targetVal) {
                actual = Math.max(0.0, targetVal - currentPaid);
            }

            sumActualTransferred += actual;

            double newPaid = currentPaid + actual;
            goal.setRemainingAmount(newPaid);
            goalRepository.save(goal);

            Map<String, Object> splitInfo = new HashMap<>();
            splitInfo.put("goalId", goal.getId());
            splitInfo.put("goalName", goal.getGoalName());
            splitInfo.put("percentage", pct);
            splitInfo.put("intendedAmount", intended);
            splitInfo.put("actualTransferred", actual);
            splitInfo.put("targetAmount", targetVal);
            splitInfo.put("newPaidAmount", newPaid);
            splits.add(splitInfo);

            splitSummary.append(String.format("• %s (%.1f%%): ₹%.2f transferred (Paid: ₹%.2f / Target: ₹%.2f)\n",
                goal.getGoalName(), pct, actual, newPaid, targetVal));
        }

        actualTotalTransfer = sumActualTransferred;
        double finalBalance = totalAvailable - actualTotalTransfer;
        settings.setAccountBalance(finalBalance);
        accountSettingsRepository.save(settings);

        StringBuilder notifMsg = new StringBuilder();
        notifMsg.append(String.format("Incoming deposit of ₹%.2f processed.\n", depositAmount));

        if ("PAUSED".equals(status)) {
            notifMsg.append(String.format("Goal transfers were PAUSED because total intended transfers (₹%.2f) would breach your safety floor of ₹%.2f.\n", totalIntendedTransfer, safetyFloor));
        } else if ("REDUCED".equals(status)) {
            notifMsg.append(String.format("Goal transfers were REDUCED from ₹%.2f to ₹%.2f to maintain your safety floor threshold of ₹%.2f.\n", totalIntendedTransfer, actualTotalTransfer, safetyFloor));
        } else {
            notifMsg.append(String.format("Total of ₹%.2f transferred across designated goals based on percentage rules.\n", actualTotalTransfer));
        }

        if (splits.isEmpty()) {
            notifMsg.append("No active percentage allocation rules configured for your goals.\n");
        } else {
            notifMsg.append("Transfer Breakdown:\n").append(splitSummary.toString());
        }
        notifMsg.append(String.format("Updated Checking Account Balance: ₹%.2f", finalBalance));

        Notification notif = new Notification(userName, statusTitle, notifMsg.toString(), status, depositAmount, actualTotalTransfer);
        notificationRepository.save(notif);

        return buildResultMap(status, notifMsg.toString(), depositAmount, actualTotalTransfer, priorBalance, finalBalance, splits, notif);
    }

    private Map<String, Object> buildResultMap(
            String status, String message, Double depositAmount, Double totalTransferred,
            Double priorBalance, Double newBalance, List<Map<String, Object>> splits, Notification notification) {

        Map<String, Object> result = new HashMap<>();
        result.put("status", status);
        result.put("message", message);
        result.put("depositAmount", depositAmount);
        result.put("totalTransferred", totalTransferred);
        result.put("priorBalance", priorBalance);
        result.put("newBalance", newBalance);
        result.put("splits", splits);
        result.put("notification", notification);
        return result;
    }
}
