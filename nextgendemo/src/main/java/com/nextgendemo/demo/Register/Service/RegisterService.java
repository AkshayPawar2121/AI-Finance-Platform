package com.nextgendemo.demo.Register.Service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nextgendemo.demo.Register.Repository.RegisterRepository;
import com.nextgendemo.demo.Register.User.User;

@Service
public class RegisterService {
	
	@Autowired
	private RegisterRepository rr;
	
	 public boolean registerUser(String name, String mobile, String email, String password) {
	        try {
	            // Create a new User object
	            User user = new User();
	            user.setName(name);
	            user.setMobile(mobile);
	            user.setEmail(email);
	            user.setPassword(password);

	            // Save the user in the database
	            rr.save(user);

	            return true; // Return true on successful registration
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false; // Return false if an error occurs
	        }
	 }
}