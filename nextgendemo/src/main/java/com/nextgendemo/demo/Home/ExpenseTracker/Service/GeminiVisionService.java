package com.nextgendemo.demo.Home.ExpenseTracker.Service;

import java.util.Base64;
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
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Service that integrates with Google Gemini 1.5 Flash Vision API
 * to extract expense details (name and amount) from an uploaded bill image.
 */
@Service
public class GeminiVisionService {

    private static final Logger logger = LoggerFactory.getLogger(GeminiVisionService.class);

    @Value("${gemini.api.key}")
    private String geminiApiKey;

    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=";
    // Strict prompt designed to get clean, parseable JSON with no markdown or extra
    // text
    private static final String EXTRACTION_PROMPT = "You are a bill/receipt OCR expert. Analyze this image carefully. "
            +
            "Your task: Extract ONLY TWO things: " +
            "1) The establishment/store/restaurant/hotel name (call it 'expenseName'). " +
            "2) The FINAL total amount the customer must pay (call it 'expenseAmount', as a plain number, no currency symbols). "
            +
            "Rules: " +
            "- If the bill has subtotal, taxes, and grand total, use the GRAND TOTAL. " +
            "- If text is handwritten, do your best to read it accurately. " +
            "- If you cannot find the name, use 'Unknown Vendor'. " +
            "- If you cannot find the amount, use 0. " +
            "Return ONLY a raw JSON object with no markdown, no code blocks, no explanation. " +
            "Example output: {\"expenseName\": \"Hotel Taj\", \"expenseAmount\": 1500}";

    /**
     * Sends the uploaded bill image to the Gemini Vision API and returns
     * extracted expense details (name and amount).
     *
     * @param file The uploaded image file (handwritten or printed bill)
     * @return Map containing "expenseName" (String) and "expenseAmount" (double)
     * @throws Exception if the API call fails or response cannot be parsed
     */
    public Map<String, Object> extractExpenseDetails(MultipartFile file) throws Exception {

        // 1. Encode the image to Base64
        byte[] imageBytes = file.getBytes();
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
        String mimeType = file.getContentType() != null ? file.getContentType() : "image/jpeg";

        logger.info("Processing bill image: name={}, size={} bytes, mimeType={}", file.getOriginalFilename(),
                imageBytes.length, mimeType);

        // 2. Build the Gemini API request payload
        Map<String, Object> textPart = new HashMap<>();
        textPart.put("text", EXTRACTION_PROMPT);

        Map<String, Object> inlineData = new HashMap<>();
        inlineData.put("mimeType", mimeType);
        inlineData.put("data", base64Image);

        Map<String, Object> imagePart = new HashMap<>();
        imagePart.put("inlineData", inlineData);

        Map<String, Object> content = new HashMap<>();
        content.put("parts", List.of(textPart, imagePart));

        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("contents", List.of(content));

        // Add generation config to enforce stricter output
        Map<String, Object> generationConfig = new HashMap<>();
        generationConfig.put("temperature", 0.1); // Very low temperature = more deterministic/accurate
        generationConfig.put("topP", 0.8);

        generationConfig.put("responseMimeType", "application/json");
        requestBody.put("generationConfig", generationConfig);

        // 3. Send the request to Gemini API
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(requestBody, headers);

        String apiUrl = GEMINI_API_URL + geminiApiKey;
        logger.info("Calling Gemini Vision API...");

        ResponseEntity<Map> apiResponse = restTemplate.postForEntity(apiUrl, httpEntity, Map.class);
        Map<String, Object> responseBody = apiResponse.getBody();

        // 4. Parse the Gemini response
        if (responseBody == null) {
            throw new RuntimeException("Empty response from Gemini API");
        }

        // Navigate: candidates[0].content.parts[0].text
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");
        if (candidates == null || candidates.isEmpty()) {
            throw new RuntimeException("No candidates in Gemini response");
        }

        @SuppressWarnings("unchecked")
        Map<String, Object> responseContent = (Map<String, Object>) candidates.get(0).get("content");
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> parts = (List<Map<String, Object>>) responseContent.get("parts");
        String rawText = (String) parts.get(0).get("text");

        logger.info("Gemini raw response: {}", rawText);

        // 5. Clean and parse the JSON — strip any accidental markdown fences
        String cleanedJson = rawText.trim();
        if (cleanedJson.startsWith("```")) {
            cleanedJson = cleanedJson.replaceAll("```[a-zA-Z]*", "").replace("```", "").trim();
        }

        // 6. Parse JSON into result map
        ObjectMapper mapper = new ObjectMapper();
        @SuppressWarnings("unchecked")
        Map<String, Object> extracted = mapper.readValue(cleanedJson, Map.class);

        // Ensure expenseName is a non-null string
        String expenseName = extracted.getOrDefault("expenseName", "Unknown Vendor").toString();

        // Ensure expenseAmount is a valid number
        double expenseAmount = 0.0;
        Object amountObj = extracted.get("expenseAmount");
        if (amountObj != null) {
            try {
                expenseAmount = Double.parseDouble(amountObj.toString());
            } catch (NumberFormatException e) {
                logger.warn("Could not parse expenseAmount '{}', defaulting to 0", amountObj);
                expenseAmount = 0.0;
            }
        }

        logger.info("Extracted: expenseName='{}', expenseAmount={}", expenseName, expenseAmount);

        Map<String, Object> result = new HashMap<>();
        result.put("expenseName", expenseName);
        result.put("expenseAmount", Math.round(expenseAmount)); // Round to integer for consistency
        return result;
    }
}
