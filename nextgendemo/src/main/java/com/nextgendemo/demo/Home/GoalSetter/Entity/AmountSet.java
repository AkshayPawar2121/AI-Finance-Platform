package com.nextgendemo.demo.Home.GoalSetter.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Goal_Setter") 
public class AmountSet {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-increment primary key
    private long id;  // Make sure field name matches the Java convention
    
    @Column(name = "UserName", nullable = false)  // Corresponds to the UserName column in the database
    private String userName;
    
    @Column(name = "GoalName", nullable = false)  // Corresponds to the GoalName column in the database
    private String goalName;
    
    @Column(name = "Target", nullable = false)  // Corresponds to the Target column in the database
    private String target;
    @Column(name = "RemainingAmount", nullable = false) 
    private Integer remainingAmount = 0; // Default value

 // Getter and Setter for spentAmount
	 public Integer getRemainingAmount() {
	     return remainingAmount;
	 }
	
	 public void setRemainingAmount(double d) {
	     this.remainingAmount = (int) d;
	 }
    
    // Getter and setter methods for each field
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getGoalName() {
        return goalName;
    }

    public void setGoalName(String goalName) {
        this.goalName = goalName;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }
    
    // Parameterized constructor for convenience
    public AmountSet(long id, String userName, String goalName, String target) {
        super();
        this.id = id;
        this.userName = userName;
        this.goalName = goalName;
        this.target = target;
    }

    // Default constructor
    public AmountSet() {
        super();
    }

    // Override toString method to display object info
    @Override
    public String toString() {
        return "AmountSet [id=" + id + ", userName=" + userName + ", goalName=" + goalName + ", target=" + target + "]";
    }

	public void setRemainingAmount1(double d) {
		
		
	}
}
