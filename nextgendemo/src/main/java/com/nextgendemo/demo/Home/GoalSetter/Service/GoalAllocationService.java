package com.nextgendemo.demo.Home.GoalSetter.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.nextgendemo.demo.Home.GoalSetter.Entity.AmountSet;
import com.nextgendemo.demo.Home.GoalSetter.Repository.GoalRepository;

@Service
public class GoalAllocationService {

    @Autowired
    private GoalRepository goalRepository;

    /**
     * Get AI-powered savings allocation suggestions for user's goals
     * Uses Q-learning reinforcement learning model via Python API
     *
     * @param userName The logged-in user's name
     * @param availableSavings The amount user wants to allocate
     * @return Map containing allocation suggestions with percentages and amounts
     */
    public Map<String, Object> getSuggestions(String userName, double availableSavings) {
        try {
            // Fetch user's goals from database
            List<AmountSet> userGoals = goalRepository.findByUserName(userName);

            // Validate - need at least 2 goals for allocation
            if (userGoals == null || userGoals.size() < 2) {
                Map<String, Object> errorResponse = new HashMap<>();
                errorResponse.put("success", false);
                errorResponse.put("error", "You need at least 2 goals for AI allocation suggestions");
                return errorResponse;
            }

            // Prepare request data for Python RL API
            Map<String, Object> requestData = new HashMap<>();
            requestData.put("income", availableSavings);

            List<Map<String, Object>> goalsData = new ArrayList<>();
            for (AmountSet goal : userGoals) {
                Map<String, Object> goalMap = new HashMap<>();
                goalMap.put("goalName", goal.getGoalName());

                // Priority: Default to 1 for now (can be enhanced later)
                goalMap.put("priority", 1);

                // Target amount
                double targetAmount = 0;
                try {
                    targetAmount = Double.parseDouble(goal.getTarget());
                } catch (NumberFormatException e) {
                    targetAmount = 0;
                }
                goalMap.put("targetAmount", targetAmount);

                // Remaining amount
                goalMap.put("remainingAmount", goal.getRemainingAmount());

                goalsData.add(goalMap);
            }
            requestData.put("goals", goalsData);

            // Call Python RL API (Q-learning model)
            RestTemplate restTemplate = new RestTemplate();
            String pythonApiUrl = "http://localhost:5001/suggest";

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(requestData, headers);

            // Make the API call
            @SuppressWarnings("unchecked")
            ResponseEntity<Map<String, Object>> apiResponse = (ResponseEntity<Map<String, Object>>)
                (ResponseEntity<?>) restTemplate.postForEntity(
                    pythonApiUrl,
                    httpEntity,
                    Map.class
                );

            // Process response
            Map<String, Object> pythonResponse = apiResponse.getBody();

            if (pythonResponse != null) {
                Map<String, Object> successResponse = new HashMap<>();
                successResponse.put("success", true);
                successResponse.put("suggestions", pythonResponse);
                successResponse.put("totalSavings", availableSavings);
                successResponse.put("method", "Q-Learning Reinforcement Learning");
                successResponse.put("goalsCount", userGoals.size());
                return successResponse;
            } else {
                Map<String, Object> errorResponse = new HashMap<>();
                errorResponse.put("success", false);
                errorResponse.put("error", "No response from AI model");
                return errorResponse;
            }

        } catch (Exception e) {
            // Handle errors gracefully
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("error", "Failed to get AI suggestions: " + e.getMessage());
            errorResponse.put("hint", "Make sure Python API is running on port 5001");
            return errorResponse;
        }
    }

    /**
     * Apply suggested allocation to user's goals
     * Updates the paid amounts (remainingAmount field stores amount PAID, not remaining!)
     */
    public boolean applySuggestion(String userName, Map<String, Double> allocation) {
        try {
            List<AmountSet> userGoals = goalRepository.findByUserName(userName);

            for (AmountSet goal : userGoals) {
                String goalName = goal.getGoalName();
                if (allocation.containsKey(goalName)) {
                    double allocatedAmount = allocation.get(goalName);

                    // remainingAmount actually stores PAID amount, not remaining!
                    double currentPaid = goal.getRemainingAmount();
                    double newPaid = currentPaid + allocatedAmount;

                    // Cap at target amount (can't pay more than target)
                    double targetAmount = Double.parseDouble(goal.getTarget());
                    double finalPaid = Math.min(newPaid, targetAmount);

                    goal.setRemainingAmount((int) finalPaid);
                    goalRepository.save(goal);
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace(); // Log error for debugging
            return false;
        }
    }
}
