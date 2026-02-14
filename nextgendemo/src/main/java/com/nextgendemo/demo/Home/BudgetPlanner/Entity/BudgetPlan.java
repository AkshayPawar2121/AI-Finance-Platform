package com.nextgendemo.demo.Home.BudgetPlanner.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Budget_Planner")
public class BudgetPlan {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name="UserName",nullable=false)
	private String userName;
	@Column(name="Budget_Name",nullable=false)
	private String budget_name;
	@Column(name="Budget_Amount",nullable=false)
	private int budget_amount;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBudget_name() {
		return budget_name;
	}
	public void setBudget_name(String budget_name) {
		this.budget_name = budget_name;
	}
	public int getBudget_amount() {
		return budget_amount;
	}
	public void setBudget_amount(int budget_amount) {
		this.budget_amount = budget_amount;
	}
	@Override
	public String toString() {
		return "BudgetPlan [Id=" + id + ", budget_name=" + budget_name + ", budget_amount=" + budget_amount + "]";
	}
	public BudgetPlan() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BudgetPlan(int id, String budget_name, int budget_amount) {
		super();
		this.id = id;
		this.budget_name = budget_name;
		this.budget_amount = budget_amount;
	}
}
