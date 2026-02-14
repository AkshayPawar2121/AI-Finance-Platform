package com.nextgendemo.demo.Home.ExpenseTracker.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Expense_Tracker")
public class ExpenseTrack {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name="UserName",nullable=false)
	private String userName;
	@Column(name="Expense_Name",nullable=false)	
	private String expenseName;
	@Column(name="Expense_Amount",nullable=false)
	private int expenseAmount;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getExpenseName() {
		return expenseName;
	}
	public void setExpenseName(String expenseNname) {
		this.expenseName = expenseNname;
	}
	public int getExpenseAmount() {
		return expenseAmount;
	}
	public void setExpenseAmount(int expenseAmount) {
		this.expenseAmount = expenseAmount;
	}
	public ExpenseTrack(int id, String userName, String expenseName, int expenseAmount) {
		super();
		this.id = id;
		this.userName = userName;
		this.expenseName = expenseName;
		this.expenseAmount = expenseAmount;
	}
	public ExpenseTrack() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "ExpenseTrack [id=" + id + ", userName=" + userName + ", expenseName=" + expenseName + ", expenseAmount="
				+ expenseAmount + "]";
	}
}
