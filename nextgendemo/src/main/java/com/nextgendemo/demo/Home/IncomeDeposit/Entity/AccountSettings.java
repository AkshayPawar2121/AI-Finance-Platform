package com.nextgendemo.demo.Home.IncomeDeposit.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "account_settings")
public class AccountSettings {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_name", nullable = false, unique = true)
    private String userName;

    @Column(name = "account_balance", nullable = false)
    private Double accountBalance = 10000.0;

    @Column(name = "safety_floor", nullable = false)
    private Double safetyFloor = 1000.0;

    @Column(name = "min_deposit_amount", nullable = false)
    private Double minDepositAmount = 100.0;

    public AccountSettings() {}

    public AccountSettings(String userName, Double accountBalance, Double safetyFloor, Double minDepositAmount) {
        this.userName = userName;
        this.accountBalance = accountBalance != null ? accountBalance : 10000.0;
        this.safetyFloor = safetyFloor != null ? safetyFloor : 1000.0;
        this.minDepositAmount = minDepositAmount != null ? minDepositAmount : 100.0;
    }

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

    public Double getAccountBalance() {
        return accountBalance;
    }

    public void setAccountBalance(Double accountBalance) {
        this.accountBalance = accountBalance;
    }

    public Double getSafetyFloor() {
        return safetyFloor;
    }

    public void setSafetyFloor(Double safetyFloor) {
        this.safetyFloor = safetyFloor;
    }

    public Double getMinDepositAmount() {
        return minDepositAmount;
    }

    public void setMinDepositAmount(Double minDepositAmount) {
        this.minDepositAmount = minDepositAmount;
    }
}
