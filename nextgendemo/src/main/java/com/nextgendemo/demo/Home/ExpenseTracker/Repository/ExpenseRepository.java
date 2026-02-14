package com.nextgendemo.demo.Home.ExpenseTracker.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nextgendemo.demo.Home.BudgetPlanner.Entity.BudgetPlan;
import com.nextgendemo.demo.Home.ExpenseTracker.Entity.ExpenseTrack;

@Repository
public interface ExpenseRepository extends JpaRepository<ExpenseTrack, Long> {
	 List<ExpenseTrack> findByUserName(String userName);
	 
	 
}