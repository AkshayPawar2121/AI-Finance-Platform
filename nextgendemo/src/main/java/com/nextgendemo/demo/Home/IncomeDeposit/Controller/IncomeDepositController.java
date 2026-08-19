package com.nextgendemo.demo.Home.IncomeDeposit.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nextgendemo.demo.Home.GoalSetter.Entity.AmountSet;
import com.nextgendemo.demo.Home.GoalSetter.Service.AmountSetService;
import com.nextgendemo.demo.Home.IncomeDeposit.Entity.AccountSettings;
import com.nextgendemo.demo.Home.IncomeDeposit.Entity.Notification;
import com.nextgendemo.demo.Home.IncomeDeposit.Service.IncomeDepositService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/home/income")
public class IncomeDepositController {

    @Autowired
    private IncomeDepositService incomeDepositService;

    @Autowired
    private AmountSetService amountSetService;

    private String resolveUserName(HttpSession session, HttpServletRequest request) {
        String userName = (String) session.getAttribute("userName");
        if (userName == null) {
            userName = request.getHeader("X-User-Name");
        }
        return userName;
    }

    @GetMapping("/settings")
    public ResponseEntity<Map<String, Object>> getSettings(HttpSession session, HttpServletRequest request) {
        String userName = resolveUserName(session, request);
        if (userName == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "User not logged in"));
        }

        AccountSettings settings = incomeDepositService.getAccountSettings(userName);
        List<AmountSet> goals = amountSetService.getGoalsByUserName(userName);

        double totalPercent = 0.0;
        for (AmountSet g : goals) {
            totalPercent += g.getAllocationPercentage();
        }

        Map<String, Object> response = new HashMap<>();
        response.put("settings", settings);
        response.put("goals", goals);
        response.put("totalCumulativePercentage", totalPercent);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/settings")
    public ResponseEntity<Map<String, Object>> saveSettings(
            @RequestBody Map<String, Object> payload,
            HttpSession session,
            HttpServletRequest request) {

        String userName = resolveUserName(session, request);
        if (userName == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "User not logged in"));
        }

        try {
            Double safetyFloor = payload.containsKey("safetyFloor") ? Double.valueOf(payload.get("safetyFloor").toString()) : null;
            Double minDepositAmount = payload.containsKey("minDepositAmount") ? Double.valueOf(payload.get("minDepositAmount").toString()) : null;
            Double accountBalance = payload.containsKey("accountBalance") ? Double.valueOf(payload.get("accountBalance").toString()) : null;

            Map<Long, Double> goalAllocations = new HashMap<>();
            if (payload.containsKey("goalAllocations") && payload.get("goalAllocations") instanceof Map) {
                @SuppressWarnings("unchecked")
                Map<String, Object> rawMap = (Map<String, Object>) payload.get("goalAllocations");
                for (Map.Entry<String, Object> entry : rawMap.entrySet()) {
                    Long goalId = Long.valueOf(entry.getKey());
                    Double pct = Double.valueOf(entry.getValue().toString());
                    goalAllocations.put(goalId, pct);
                }
            }

            AccountSettings updated = incomeDepositService.updateSettingsAndAllocations(
                    userName, safetyFloor, minDepositAmount, accountBalance, goalAllocations);

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "Income deposit transfer settings updated successfully");
            response.put("settings", updated);

            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            Map<String, Object> errorResp = new HashMap<>();
            errorResp.put("success", false);
            errorResp.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResp);
        } catch (Exception e) {
            Map<String, Object> errorResp = new HashMap<>();
            errorResp.put("success", false);
            errorResp.put("error", "Failed to update settings: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResp);
        }
    }

    @PostMapping("/deposit")
    public ResponseEntity<Map<String, Object>> processDeposit(
            @RequestParam(value = "amount", required = false) Double amountParam,
            @RequestBody(required = false) Map<String, Object> bodyPayload,
            HttpSession session,
            HttpServletRequest request) {

        String userName = resolveUserName(session, request);
        if (userName == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "User not logged in"));
        }

        Double depositAmount = amountParam;
        if (depositAmount == null && bodyPayload != null && bodyPayload.containsKey("depositAmount")) {
            depositAmount = Double.valueOf(bodyPayload.get("depositAmount").toString());
        } else if (depositAmount == null && bodyPayload != null && bodyPayload.containsKey("amount")) {
            depositAmount = Double.valueOf(bodyPayload.get("amount").toString());
        }

        if (depositAmount == null || depositAmount <= 0) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("error", "Valid positive deposit amount is required"));
        }

        try {
            Map<String, Object> result = incomeDepositService.processIncomeDeposit(userName, depositAmount);
            result.put("success", true);
            return ResponseEntity.ok(result);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("success", false, "error", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false, "error", e.getMessage()));
        }
    }

    @GetMapping("/notifications")
    public ResponseEntity<List<Notification>> getNotifications(HttpSession session, HttpServletRequest request) {
        String userName = resolveUserName(session, request);
        if (userName == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        List<Notification> notifications = incomeDepositService.getUserNotifications(userName);
        return ResponseEntity.ok(notifications);
    }
}
