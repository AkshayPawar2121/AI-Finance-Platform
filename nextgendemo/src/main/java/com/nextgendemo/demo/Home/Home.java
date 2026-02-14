package com.nextgendemo.demo.Home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nextgendemo.demo.Home.Repository.HomeRepository;
import com.nextgendemo.demo.Home.User.User;

@Service
public class Home {

	
	 @Autowired
	    private HomeRepository homeRepository;

	    public boolean validateLogin(String email, String password) {
	        User user = homeRepository.findByEmail(email); // Fetch user by email

	        if (user != null && user.getPassword().equals(password)) {
	            return true; // Valid credentials
	        }
	        return false; // Invalid credentials
	    }
	    
	    public String getUserNameByEmail(String email) {
	        User user = homeRepository.findByEmail(email);
	        return user != null ? user.getEmail() : null;
	    }
	
}
