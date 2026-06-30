package com.nextgendemo.demo.Home.ExpenseTracker.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nextgendemo.demo.Home.ExpenseTracker.Entity.ExpenseTrack;
import com.nextgendemo.demo.Home.ExpenseTracker.Repository.ExpenseRepository;

@Service
public class ExpenseService {

	@Autowired
	private ExpenseRepository expenseRepository;

	public boolean setExpense(String username, String expenseName, int expenseAmount, String expenseDateStr, String category) {
		try {
            // Create a new Expense object
			ExpenseTrack expense = new ExpenseTrack();
			expense.setUserName(username);
			expense.setExpenseName(expenseName);
			expense.setExpenseAmount(expenseAmount);
			expense.setCategory(category != null && !category.isEmpty() ? category : "Other");

			// Parse and set date
			if (expenseDateStr != null && !expenseDateStr.isEmpty()) {
				try {
					LocalDate expenseDate = LocalDate.parse(expenseDateStr);
					expense.setExpenseDate(expenseDate);
				} catch (Exception e) {
					// If date parsing fails, use today's date
					expense.setExpenseDate(LocalDate.now());
				}
			} else {
				// Default to today if no date provided
				expense.setExpenseDate(LocalDate.now());
			}

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
	
	public boolean updateExpensePayment(Long expenseId, int expenseAmount, String category) {
		 Optional<ExpenseTrack> expenseOpt = expenseRepository.findById(expenseId);
		    System.out.println(expenseId);
		    System.out.println(expenseAmount);
		    if (expenseOpt.isPresent()) {
		       ExpenseTrack  expense = expenseOpt.get();

		       expense.setExpenseAmount(expenseAmount);
		       if (category != null && !category.isEmpty()) {
		           expense.setCategory(category);
		       }
		        expenseRepository.save(expense);
		        return true;
		    }
		return false;
	}
	
	 public void deleteExpense(Long id) {
	        expenseRepository.deleteById(id);
	    }
	

}
