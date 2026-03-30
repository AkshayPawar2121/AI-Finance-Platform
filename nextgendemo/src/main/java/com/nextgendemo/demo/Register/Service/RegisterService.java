package com.nextgendemo.demo.Register.Service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nextgendemo.demo.Register.Repository.RegisterRepository;
import com.nextgendemo.demo.Register.User.User;
import com.nextgendemo.demo.util.PasswordUtil;

@Service
public class RegisterService {

	@Autowired
	private RegisterRepository rr;

	/**
	 * Registers a new user with validation and password hashing
	 * @return RegistrationResult containing success status and error message if any
	 */
	public RegistrationResult registerUser(String name, String mobile, String email, String password) {
		try {
			// Check if email already exists
			if (rr.existsByEmail(email)) {
				return new RegistrationResult(false, "This email is already registered. Please use a different email or login.");
			}

			// Validate password strength
			String passwordError = PasswordUtil.getPasswordValidationError(password);
			if (passwordError != null) {
				return new RegistrationResult(false, passwordError);
			}

			// Hash the password before saving
			String hashedPassword = PasswordUtil.hashPassword(password);

			// Create a new User object
			User user = new User();
			user.setName(name);
			user.setMobile(mobile);
			user.setEmail(email);
			user.setPassword(hashedPassword); // Store hashed password

			// Save the user in the database
			rr.save(user);

			return new RegistrationResult(true, null);
		} catch (Exception e) {
			e.printStackTrace();
			return new RegistrationResult(false, "Registration failed. Please try again.");
		}
	}

	/**
	 * Inner class to hold registration result
	 */
	public static class RegistrationResult {
		private final boolean success;
		private final String errorMessage;

		public RegistrationResult(boolean success, String errorMessage) {
			this.success = success;
			this.errorMessage = errorMessage;
		}

		public boolean isSuccess() {
			return success;
		}

		public String getErrorMessage() {
			return errorMessage;
		}
	}
}