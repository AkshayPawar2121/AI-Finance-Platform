package com.nextgendemo.demo.Home.GoalSetter.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nextgendemo.demo.Home.GoalSetter.Entity.AmountSet;
import com.nextgendemo.demo.Home.GoalSetter.Repository.GoalRepository;

@Service
public class AmountSetService {

	
	 @Autowired
	 private GoalRepository goalRepository;
	 public boolean setGoal(String userName,String goalname, String target) {
		try {
            // Create a new Goal object
            AmountSet goal = new AmountSet();
            goal.setUserName(userName);
            goal.setGoalName(goalname);
            goal.setTarget(target);

            // Save the goal in the database
            goalRepository.save(goal);

            return true; // Successfully saved
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Error occurred
        }
		
	}
	 
	 public List<AmountSet> getGoalsByUserName(String userName) {
	        return goalRepository.findByUserName(userName);
	 }
	 
	 
	 public boolean updateGoalPayment(Long goalId, double paymentAmount) {
		    Optional<AmountSet> goalOpt = goalRepository.findById(goalId);
		    
		    System.out.println(goalId);
		    System.out.println(goalOpt);
		    if (goalOpt.isPresent()) {
		        AmountSet goal = goalOpt.get();
		        double currentAmount = goal.getRemainingAmount() != null ? goal.getRemainingAmount() : 0;
		        goal.setRemainingAmount(currentAmount + paymentAmount);
		        goalRepository.save(goal);
		        return true;
		    }
		    return false;
		}

	public void deleteGoal(Long id) {
		goalRepository.deleteById(id);
		
	}

}
