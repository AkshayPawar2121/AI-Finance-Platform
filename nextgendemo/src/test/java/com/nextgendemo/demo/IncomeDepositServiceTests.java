package com.nextgendemo.demo;

import static org.junit.jupiter.api.Assertions.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import com.nextgendemo.demo.Home.GoalSetter.Entity.AmountSet;
import com.nextgendemo.demo.Home.GoalSetter.Repository.GoalRepository;
import com.nextgendemo.demo.Home.IncomeDeposit.Entity.AccountSettings;
import com.nextgendemo.demo.Home.IncomeDeposit.Entity.Notification;
import com.nextgendemo.demo.Home.IncomeDeposit.Repository.AccountSettingsRepository;
import com.nextgendemo.demo.Home.IncomeDeposit.Repository.NotificationRepository;
import com.nextgendemo.demo.Home.IncomeDeposit.Service.IncomeDepositService;

@SpringBootTest
@Transactional
public class IncomeDepositServiceTests {

    @Autowired
    private IncomeDepositService incomeDepositService;

    @Autowired
    private AccountSettingsRepository accountSettingsRepository;

    @Autowired
    private GoalRepository goalRepository;

    @Autowired
    private NotificationRepository notificationRepository;

    private final String testUser = "testuser_income_deposit@example.com";
    private AmountSet goal1;
    private AmountSet goal2;

    @BeforeEach
    public void setup() {
        accountSettingsRepository.deleteAll();
        goalRepository.deleteAll();
        notificationRepository.deleteAll();

        // Create initial settings
        AccountSettings settings = new AccountSettings(testUser, 2000.0, 1000.0, 100.0);
        accountSettingsRepository.save(settings);

        // Create test goals
        goal1 = new AmountSet();
        goal1.setUserName(testUser);
        goal1.setGoalName("Emergency Fund");
        goal1.setTarget("10000");
        goal1.setRemainingAmount(0.0);
        goal1.setAllocationPercentage(20.0);
        goal1 = goalRepository.save(goal1);

        goal2 = new AmountSet();
        goal2.setUserName(testUser);
        goal2.setGoalName("Vacation");
        goal2.setTarget("5000");
        goal2.setRemainingAmount(0.0);
        goal2.setAllocationPercentage(10.0);
        goal2 = goalRepository.save(goal2);
    }

    @Test
    public void testSaveSettings_ValidPercentages_Success() {
        Map<Long, Double> allocations = new HashMap<>();
        allocations.put(goal1.getId(), 30.0);
        allocations.put(goal2.getId(), 40.0); // Total 70% <= 100%

        AccountSettings updated = incomeDepositService.updateSettingsAndAllocations(
                testUser, 1500.0, 200.0, 3000.0, allocations);

        assertNotNull(updated);
        assertEquals(1500.0, updated.getSafetyFloor());
        assertEquals(200.0, updated.getMinDepositAmount());
        assertEquals(3000.0, updated.getAccountBalance());

        AmountSet updatedG1 = goalRepository.findById(goal1.getId()).orElseThrow();
        AmountSet updatedG2 = goalRepository.findById(goal2.getId()).orElseThrow();
        assertEquals(30.0, updatedG1.getAllocationPercentage());
        assertEquals(40.0, updatedG2.getAllocationPercentage());
    }

    @Test
    public void testSaveSettings_Exceeds100Percent_ThrowsException() {
        Map<Long, Double> allocations = new HashMap<>();
        allocations.put(goal1.getId(), 60.0);
        allocations.put(goal2.getId(), 50.0); // Total 110% > 100%

        IllegalArgumentException ex = assertThrows(IllegalArgumentException.class, () -> {
            incomeDepositService.updateSettingsAndAllocations(testUser, 1000.0, 100.0, 2000.0, allocations);
        });

        assertTrue(ex.getMessage().contains("cannot exceed 100%"),
                "Expected error message regarding 100% limit, got: " + ex.getMessage());
    }

    @Test
    public void testProcessIncomeDeposit_BelowMinTrigger_NoTransfersExecuted() {
        // minDepositAmount is 100, deposit is 50
        Map<String, Object> result = incomeDepositService.processIncomeDeposit(testUser, 50.0);

        assertEquals("BELOW_MINIMUM", result.get("status"));
        assertEquals(0.0, result.get("totalTransferred"));
        assertEquals(2050.0, result.get("newBalance"));

        List<Notification> notifs = notificationRepository.findByUserNameOrderByCreatedAtDesc(testUser);
        assertFalse(notifs.isEmpty());
        assertEquals("BELOW_MINIMUM", notifs.get(0).getType());
    }

    @Test
    public void testProcessIncomeDeposit_BalancePriorBelowSafetyFloor_TransfersHalted() {
        // Set prior balance to 500, safety floor to 1000
        AccountSettings settings = incomeDepositService.getAccountSettings(testUser);
        settings.setAccountBalance(500.0);
        settings.setSafetyFloor(1000.0);
        accountSettingsRepository.save(settings);

        // Deposit 500 arrives
        Map<String, Object> result = incomeDepositService.processIncomeDeposit(testUser, 500.0);

        assertEquals("PAUSED", result.get("status"));
        assertEquals(0.0, result.get("totalTransferred"));
        assertEquals(1000.0, result.get("newBalance")); // 500 prior + 500 deposit = 1000

        List<Notification> notifs = notificationRepository.findByUserNameOrderByCreatedAtDesc(testUser);
        assertFalse(notifs.isEmpty());
        assertTrue(notifs.get(0).getMessage().contains("HALTED"));
    }

    @Test
    public void testProcessIncomeDeposit_SufficientBalance_TransfersExecutedInFull() {
        // Prior balance = 2000, safety floor = 1000, deposit = 1000
        // Goal1 = 20% (₹200), Goal2 = 10% (₹100), total transfer = ₹300
        // Available after deposit = 3000, after transfer = 2700 >= 1000
        Map<String, Object> result = incomeDepositService.processIncomeDeposit(testUser, 1000.0);

        assertEquals("EXECUTED", result.get("status"));
        assertEquals(300.0, result.get("totalTransferred"));
        assertEquals(2700.0, result.get("newBalance"));

        AmountSet updatedG1 = goalRepository.findById(goal1.getId()).orElseThrow();
        AmountSet updatedG2 = goalRepository.findById(goal2.getId()).orElseThrow();
        assertEquals(200, updatedG1.getRemainingAmount());
        assertEquals(100, updatedG2.getRemainingAmount());

        List<Notification> notifs = notificationRepository.findByUserNameOrderByCreatedAtDesc(testUser);
        assertFalse(notifs.isEmpty());
        assertEquals("EXECUTED", notifs.get(0).getType());
        assertTrue(notifs.get(0).getMessage().contains("Emergency Fund"));
    }

    @Test
    public void testProcessIncomeDeposit_GoalTargetCap_TransfersCappedAtTarget() {
        // Goal1 target is 1000, current paid is 900 -> remaining target needed is 100
        // Goal1 allocation = 30% (intended ₹300 on ₹1000 deposit)
        // Goal2 allocation = 10% (intended ₹100 on ₹1000 deposit)
        // Goal1 gets capped at ₹100, Goal2 gets full ₹100
        // Total transferred = ₹200
        goal1.setTarget("1000");
        goal1.setRemainingAmount(900.0);
        goal1.setAllocationPercentage(30.0);
        goalRepository.save(goal1);

        goal2.setAllocationPercentage(10.0);
        goalRepository.save(goal2);

        Map<String, Object> result = incomeDepositService.processIncomeDeposit(testUser, 1000.0);

        assertEquals("EXECUTED", result.get("status"));
        assertEquals(200.0, (Double) result.get("totalTransferred"), 0.01);

        AmountSet updatedG1 = goalRepository.findById(goal1.getId()).orElseThrow();
        AmountSet updatedG2 = goalRepository.findById(goal2.getId()).orElseThrow();
        assertEquals(1000, updatedG1.getRemainingAmount()); // Reached target cap
        assertEquals(100, updatedG2.getRemainingAmount());
    }
}
