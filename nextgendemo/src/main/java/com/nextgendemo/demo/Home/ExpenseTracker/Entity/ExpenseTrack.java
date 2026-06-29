package com.nextgendemo.demo.Home.ExpenseTracker.Entity;

import java.time.LocalDate;
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
	private Long id;
	@Column(name="UserName",nullable=false)
	private String userName;
	@Column(name="Expense_Name",nullable=false)
	private String expenseName;
	@Column(name="Expense_Amount",nullable=false)
	private int expenseAmount;
	@Column(name="Expense_Date")
	private LocalDate expenseDate;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
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
	public LocalDate getExpenseDate() {
		return expenseDate;
	}
	public void setExpenseDate(LocalDate expenseDate) {
		this.expenseDate = expenseDate;
	}
	public ExpenseTrack(Long id, String userName, String expenseName, int expenseAmount, LocalDate expenseDate) {
		super();
		this.id = id;
		this.userName = userName;
		this.expenseName = expenseName;
		this.expenseAmount = expenseAmount;
		this.expenseDate = expenseDate;
	}
	public ExpenseTrack() {
		super();
		this.expenseDate = LocalDate.now(); // Default to today
	}
	@Override
	public String toString() {
		return "ExpenseTrack [id=" + id + ", userName=" + userName + ", expenseName=" + expenseName + ", expenseAmount="
				+ expenseAmount + ", expenseDate=" + expenseDate + "]";
	}
}
