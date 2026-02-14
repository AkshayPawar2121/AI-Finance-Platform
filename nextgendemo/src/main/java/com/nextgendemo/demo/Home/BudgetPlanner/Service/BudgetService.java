package com.nextgendemo.demo.Home.BudgetPlanner.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nextgendemo.demo.Home.BudgetPlanner.Entity.BudgetPlan;
import com.nextgendemo.demo.Home.BudgetPlanner.Repository.BudgetRepository;

@Service
public class BudgetService {
	
	 @Autowired
	 private BudgetRepository budgetRepository;
	 public boolean setBudget(String userName,String budgetName, int  budgetAmount) {
		try {
            // Create a new Goal object
			BudgetPlan budget = new BudgetPlan();
			budget.setUserName(userName); // Set the userName field
			budget.setBudget_name(budgetName);
			budget.setBudget_amount(budgetAmount);
			budgetRepository.save(budget);


            return true; // Successfully saved
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Error occurred
        }
		
	}
	 
	 public List<BudgetPlan> getBudgetsByUserName(String userName) {
	        return budgetRepository.findByUserName(userName);
	 }
	 
	
	public boolean updateBudgetPayment(Long budgetId, int budgetAmount) {
		 Optional<BudgetPlan> budgetOpt = budgetRepository.findById(budgetId);		    
		    System.out.println(budgetId);
		    System.out.println(budgetAmount);
		    if (budgetOpt.isPresent()) {
		       BudgetPlan  budget = budgetOpt.get();
		        
		        budget.setBudget_amount(budgetAmount);
		        budgetRepository.save(budget);
		        return true;
		    }
		return false;
	}

	public void deleteBudget(Long id) {
		budgetRepository.deleteById(id);
		
	}

}
