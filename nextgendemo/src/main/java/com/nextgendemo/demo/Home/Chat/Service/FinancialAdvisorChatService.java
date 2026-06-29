package com.nextgendemo.demo.Home.Chat.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Service that provides AI-powered financial advice using Google Gemini API.
 * Analyzes user's financial data and answers questions about budgeting, expenses, and goals.
 */
@Service
public class FinancialAdvisorChatService {

    private static final Logger logger = LoggerFactory.getLogger(FinancialAdvisorChatService.class);

    @Value("${gemini.api.key}")
    private String geminiApiKey;

    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=";

    /**
     * Generates AI response based on user's question and financial context
     * @param userMessage The user's question
     * @param context Financial context (expenses, goals, budgets)
     * @return AI-generated response
     */
    public String getFinancialAdvice(String userMessage, Map<String, Object> context) {
        try {
            // Build context-aware prompt
            String systemPrompt = buildSystemPrompt(context);
            String fullPrompt = systemPrompt + "\n\nUser Question: " + userMessage;

            logger.info("Processing chat query: {}", userMessage);

            // Build request
            Map<String, Object> textPart = new HashMap<>();
            textPart.put("text", fullPrompt);

            Map<String, Object> content = new HashMap<>();
            content.put("parts", List.of(textPart));

            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("contents", List.of(content));

            // Generation config
            Map<String, Object> generationConfig = new HashMap<>();
            generationConfig.put("temperature", 0.7);
            generationConfig.put("topP", 0.8);
            generationConfig.put("maxOutputTokens", 500);
            requestBody.put("generationConfig", generationConfig);

            // Call Gemini API
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(requestBody, headers);
            String apiUrl = GEMINI_API_URL + geminiApiKey;

            logger.info("Calling Gemini Chat API...");
            @SuppressWarnings("rawtypes")
            ResponseEntity<Map> apiResponse = restTemplate.postForEntity(apiUrl, httpEntity, Map.class);
            @SuppressWarnings("unchecked")
            Map<String, Object> responseBody = apiResponse.getBody();

            if (responseBody == null) {
                throw new RuntimeException("Empty response from Gemini API");
            }

            // Parse response
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");
            if (candidates == null || candidates.isEmpty()) {
                throw new RuntimeException("No candidates in Gemini response");
            }

            @SuppressWarnings("unchecked")
            Map<String, Object> responseContent = (Map<String, Object>) candidates.get(0).get("content");
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> parts = (List<Map<String, Object>>) responseContent.get("parts");
            String response = (String) parts.get(0).get("text");

            logger.info("Generated response successfully");
            return response.trim();

        } catch (Exception e) {
            logger.error("Error calling Gemini API", e);
            return "I apologize, but I'm having trouble processing your request right now. Please try again.";
        }
    }

    /**
     * Builds a context-aware system prompt with user's financial data
     */
    private String buildSystemPrompt(Map<String, Object> context) {
        StringBuilder prompt = new StringBuilder();

        prompt.append("You are an AI Financial Advisor for NextGen Finance app. ");
        prompt.append("You provide friendly, helpful, and accurate financial advice. ");
        prompt.append("Keep responses concise (2-4 sentences). Use a warm, supportive tone.\n\n");

        prompt.append("USER'S FINANCIAL DATA:\n");

        // Total expenses
        Object totalExpenses = context.get("totalExpenses");
        if (totalExpenses != null) {
            prompt.append("- Total Expenses: Rs.").append(totalExpenses).append("\n");
        }

        // Expense breakdown
        @SuppressWarnings("unchecked")
        List<String> categories = (List<String>) context.get("expenseCategories");
        @SuppressWarnings("unchecked")
        List<Integer> amounts = (List<Integer>) context.get("expenseAmounts");

        if (categories != null && amounts != null && !categories.isEmpty()) {
            prompt.append("- Expense Breakdown:\n");
            for (int i = 0; i < Math.min(categories.size(), amounts.size()); i++) {
                prompt.append("  * ").append(categories.get(i)).append(": Rs.").append(amounts.get(i)).append("\n");
            }
        }

        // Goals
        Object totalGoals = context.get("totalGoals");
        if (totalGoals != null) {
            prompt.append("- Number of Financial Goals: ").append(totalGoals).append("\n");
        }

        @SuppressWarnings("unchecked")
        List<String> goalNames = (List<String>) context.get("goalNames");
        @SuppressWarnings("unchecked")
        List<Double> goalProgress = (List<Double>) context.get("goalProgress");

        if (goalNames != null && goalProgress != null && !goalNames.isEmpty()) {
            prompt.append("- Goal Progress:\n");
            for (int i = 0; i < Math.min(goalNames.size(), goalProgress.size()); i++) {
                double progress = 0.0;
                Object progressObj = goalProgress.get(i);
                if (progressObj instanceof Number) {
                    progress = ((Number) progressObj).doubleValue();
                }
                prompt.append("  * ").append(goalNames.get(i)).append(": ")
                      .append(String.format("%.1f", progress)).append("% complete\n");
            }
        }

        // Budget
        Object totalBudget = context.get("totalBudget");
        if (totalBudget != null && ((Number)totalBudget).doubleValue() > 0) {
            prompt.append("- Total Budget: Rs.").append(totalBudget).append("\n");
        }

        prompt.append("\nProvide helpful, specific advice based on this data. ");
        prompt.append("If asked about spending, mention specific categories. ");
        prompt.append("If asked about goals, reference actual goal names and progress. ");
        prompt.append("Always be encouraging and constructive.");

        return prompt.toString();
    }
}
