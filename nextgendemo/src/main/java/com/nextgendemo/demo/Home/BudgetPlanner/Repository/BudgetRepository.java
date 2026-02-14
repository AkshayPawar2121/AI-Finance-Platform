package com.nextgendemo.demo.Home.BudgetPlanner.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nextgendemo.demo.Home.BudgetPlanner.Entity.BudgetPlan;

@Repository
public interface BudgetRepository extends JpaRepository<BudgetPlan, Long> {
	 List<BudgetPlan> findByUserName(String userName);
	 
	 
}
