package com.nextgendemo.demo.Home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nextgendemo.demo.Home.Repository.HomeRepository;
import com.nextgendemo.demo.Home.User.User;
import com.nextgendemo.demo.util.PasswordUtil;

@Service
public class Home {

	
	 @Autowired
	    private HomeRepository homeRepository;

	    /**
	     * Validates login credentials with hashed password comparison
	     * @param email User's email
	     * @param password Plain text password from login form
	     * @return true if credentials are valid, false otherwise
	     */
	    public boolean validateLogin(String email, String password) {
	        User user = homeRepository.findByEmail(email); // Fetch user by email

	        if (user != null) {
	            // Verify password using PasswordUtil (compares hashed passwords)
	            return PasswordUtil.verifyPassword(password, user.getPassword());
	        }
	        return false; // Invalid credentials
	    }
	    
	    public String getUserNameByEmail(String email) {
	        User user = homeRepository.findByEmail(email);
	        return user != null ? user.getEmail() : null;
	    }
	
}
