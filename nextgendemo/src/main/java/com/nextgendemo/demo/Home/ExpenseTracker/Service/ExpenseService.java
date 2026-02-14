package com.nextgendemo.demo.Home.ExpenseTracker.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nextgendemo.demo.Home.BudgetPlanner.Entity.BudgetPlan;
import com.nextgendemo.demo.Home.ExpenseTracker.Entity.ExpenseTrack;
import com.nextgendemo.demo.Home.ExpenseTracker.Repository.ExpenseRepository;

@Service
public class ExpenseService {
	
	@Autowired
	private ExpenseRepository expenseRepository;

	public boolean setExpense(String username, String expenseName, int expenseAmount) {
		try {
            // Create a new Goal object
			ExpenseTrack expense = new ExpenseTrack();
			expense.setUserName(username);
			expense.setExpenseName(expenseName);
			expense.setExpenseAmount(expenseAmount);
			expenseRepository.save(expense);
			


            return true; // Successfully saved
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Error occurred
        }
		
	}

	public List<ExpenseTrack> getExpensesByUserName(String userName) {
		return expenseRepository.findByUserName(userName);
	}
	
	public boolean updateExpensePayment(Long expenseId, int expenseAmount) {
		 Optional<ExpenseTrack> expenseOpt = expenseRepository.findById(expenseId);		    
		    System.out.println(expenseId);
		    System.out.println(expenseAmount);
		    if (expenseOpt.isPresent()) {
		       ExpenseTrack  expense = expenseOpt.get();
		        
		       expense.setExpenseAmount(expenseAmount);
		        expenseRepository.save(expense);
		        return true;
		    }
		return false;
	}
	
	 public void deleteExpense(Long id) {
	        expenseRepository.deleteById(id);
	    }
	

}
