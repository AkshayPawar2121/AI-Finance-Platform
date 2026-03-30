package com.nextgendemo.demo.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Pattern;

/**
 * Utility class for password hashing and validation.
 * Uses SHA-256 for basic password hashing (suitable for academic projects).
 *
 * Security Note: For production applications, consider using BCrypt or similar.
 */
public class PasswordUtil {

    // Password validation patterns
    private static final Pattern UPPERCASE_PATTERN = Pattern.compile(".*[A-Z].*");
    private static final Pattern LOWERCASE_PATTERN = Pattern.compile(".*[a-z].*");
    private static final Pattern DIGIT_PATTERN = Pattern.compile(".*[0-9].*");
    private static final int MIN_PASSWORD_LENGTH = 8;

    /**
     * Hashes a plain text password using SHA-256 algorithm.
     *
     * @param plainPassword The plain text password to hash
     * @return The hashed password as a hexadecimal string
     * @throws RuntimeException if SHA-256 algorithm is not available
     */
    public static String hashPassword(String plainPassword) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(plainPassword.getBytes(StandardCharsets.UTF_8));

            // Convert byte array to hexadecimal string
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error: SHA-256 algorithm not available", e);
        }
    }

    /**
     * Verifies if a plain text password matches a hashed password.
     *
     * @param plainPassword The plain text password to verify
     * @param hashedPassword The hashed password to compare against
     * @return true if passwords match, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        String hashOfInput = hashPassword(plainPassword);
        return hashOfInput.equals(hashedPassword);
    }

    /**
     * Validates if a password meets the strength requirements:
     * - Minimum 8 characters
     * - At least 1 uppercase letter
     * - At least 1 lowercase letter
     * - At least 1 digit
     *
     * @param password The password to validate
     * @return true if password meets all requirements, false otherwise
     */
    public static boolean validatePasswordStrength(String password) {
        if (password == null || password.length() < MIN_PASSWORD_LENGTH) {
            return false;
        }

        return UPPERCASE_PATTERN.matcher(password).matches()
                && LOWERCASE_PATTERN.matcher(password).matches()
                && DIGIT_PATTERN.matcher(password).matches();
    }

    /**
     * Gets a detailed error message for password validation failures.
     *
     * @param password The password to check
     * @return Error message describing what requirements are not met, or null if valid
     */
    public static String getPasswordValidationError(String password) {
        if (password == null || password.isEmpty()) {
            return "Password is required";
        }

        if (password.length() < MIN_PASSWORD_LENGTH) {
            return "Password must be at least " + MIN_PASSWORD_LENGTH + " characters long";
        }

        if (!UPPERCASE_PATTERN.matcher(password).matches()) {
            return "Password must contain at least one uppercase letter";
        }

        if (!LOWERCASE_PATTERN.matcher(password).matches()) {
            return "Password must contain at least one lowercase letter";
        }

        if (!DIGIT_PATTERN.matcher(password).matches()) {
            return "Password must contain at least one number";
        }

        return null; // Password is valid
    }

    /**
     * Calculates password strength level for UI feedback.
     *
     * @param password The password to evaluate
     * @return Strength level: 0 (weak), 1 (medium), 2 (strong)
     */
    public static int getPasswordStrength(String password) {
        if (password == null || password.length() < MIN_PASSWORD_LENGTH) {
            return 0; // Weak
        }

        int strength = 0;

        // Check various criteria
        if (password.length() >= MIN_PASSWORD_LENGTH) strength++;
        if (UPPERCASE_PATTERN.matcher(password).matches()) strength++;
        if (LOWERCASE_PATTERN.matcher(password).matches()) strength++;
        if (DIGIT_PATTERN.matcher(password).matches()) strength++;

        // 0-1: Weak, 2-3: Medium, 4: Strong
        if (strength <= 1) return 0;
        if (strength <= 3) return 1;
        return 2;
    }
}
