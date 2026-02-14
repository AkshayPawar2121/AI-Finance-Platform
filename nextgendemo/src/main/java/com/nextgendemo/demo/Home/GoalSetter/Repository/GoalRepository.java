package com.nextgendemo.demo.Home.GoalSetter.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.nextgendemo.demo.Home.GoalSetter.Entity.AmountSet;

@Repository
public interface GoalRepository extends JpaRepository<AmountSet, Long> {
	 List<AmountSet> findByUserName(String userName);
	 
	 
}
