-- ============================================
-- MySQL Workbench - Teacher Demo Queries
-- AI Finance Platform Database
-- ============================================

-- Run these queries ONE BY ONE during demo
-- Select query and press Ctrl+Shift+Enter

-- ============================================
-- QUERY 1: Show All Tables
-- ============================================
SHOW TABLES;
-- Expected Output: 4 tables


-- ============================================
-- QUERY 2: View Registered Users
-- ============================================
SELECT
    id as 'User ID',
    name as 'Name',
    email as 'Email',
    mobile as 'Mobile Number'
FROM register
ORDER BY id DESC;
-- Shows all registered users (password excluded for security)


-- ============================================
-- QUERY 3: View All Budgets
-- ============================================
SELECT
    id as 'Budget ID',
    user_name as 'User Name',
    budget_name as 'Budget Category',
    budget_amount as 'Amount (₹)'
FROM budget_planner
ORDER BY budget_amount DESC;


-- ============================================
-- QUERY 4: View All Expenses
-- ============================================
SELECT
    id as 'Expense ID',
    user_name as 'User Name',
    expense_name as 'Expense Category',
    expense_amount as 'Amount (₹)'
FROM expense_tracker
ORDER BY expense_amount DESC;


-- ============================================
-- QUERY 5: View All Goals
-- ============================================
SELECT
    id as 'Goal ID',
    user_name as 'User Name',
    goal_name as 'Goal',
    target as 'Target Amount',
    remaining_amount as 'Remaining (₹)'
FROM goal_setter;


-- ============================================
-- QUERY 6: Database Summary (Counts)
-- ============================================
SELECT
    (SELECT COUNT(*) FROM register) as 'Total Users',
    (SELECT COUNT(*) FROM budget_planner) as 'Total Budgets',
    (SELECT COUNT(*) FROM expense_tracker) as 'Total Expenses',
    (SELECT COUNT(*) FROM goal_setter) as 'Total Goals';
-- Shows overall statistics


-- ============================================
-- QUERY 7: User-wise Data Count
-- ============================================
SELECT
    r.name as 'User Name',
    r.email as 'Email',
    COUNT(DISTINCT b.id) as 'Budgets',
    COUNT(DISTINCT e.id) as 'Expenses',
    COUNT(DISTINCT g.id) as 'Goals'
FROM register r
LEFT JOIN budget_planner b ON r.name = b.user_name
LEFT JOIN expense_tracker e ON r.name = e.user_name
LEFT JOIN goal_setter g ON r.name = g.user_name
GROUP BY r.name, r.email;
-- Shows how many budgets/expenses/goals each user has


-- ============================================
-- QUERY 8: Financial Summary Per User
-- ============================================
SELECT
    r.name as 'User Name',
    COALESCE(SUM(b.budget_amount), 0) as 'Total Budget (₹)',
    COALESCE(SUM(e.expense_amount), 0) as 'Total Spent (₹)',
    COALESCE(SUM(b.budget_amount), 0) - COALESCE(SUM(e.expense_amount), 0) as 'Balance (₹)'
FROM register r
LEFT JOIN budget_planner b ON r.name = b.user_name
LEFT JOIN expense_tracker e ON r.name = e.user_name
GROUP BY r.name;
-- Shows financial status of each user


-- ============================================
-- QUERY 9: Top 5 Expenses (All Users)
-- ============================================
SELECT
    user_name as 'User',
    expense_name as 'Expense',
    expense_amount as 'Amount (₹)'
FROM expense_tracker
ORDER BY expense_amount DESC
LIMIT 5;
-- Shows highest expenses


-- ============================================
-- QUERY 10: Top 5 Budgets (All Users)
-- ============================================
SELECT
    user_name as 'User',
    budget_name as 'Budget Category',
    budget_amount as 'Amount (₹)'
FROM budget_planner
ORDER BY budget_amount DESC
LIMIT 5;
-- Shows highest budgets


-- ============================================
-- QUERY 11: Check Data Integrity
-- ============================================
-- Check if all emails are unique
SELECT
    email,
    COUNT(*) as count
FROM register
GROUP BY email
HAVING COUNT(*) > 1;
-- Should return empty result (no duplicate emails)


-- ============================================
-- QUERY 12: Recent Activity (Last 10 entries)
-- ============================================
SELECT
    'Expense' as Type,
    user_name as User,
    expense_name as Description,
    expense_amount as Amount
FROM expense_tracker
ORDER BY id DESC
LIMIT 10;


-- ============================================
-- BONUS QUERIES (For Advanced Demo)
-- ============================================

-- Budget vs Expense Analysis
SELECT
    b.user_name as 'User',
    SUM(b.budget_amount) as 'Total Budget',
    SUM(e.expense_amount) as 'Total Expense',
    SUM(b.budget_amount) - SUM(e.expense_amount) as 'Savings',
    ROUND((SUM(e.expense_amount) / SUM(b.budget_amount)) * 100, 2) as 'Expense %'
FROM budget_planner b
LEFT JOIN expense_tracker e ON b.user_name = e.user_name
GROUP BY b.user_name;


-- Users who are over budget
SELECT
    b.user_name as 'User (Over Budget)',
    SUM(b.budget_amount) as 'Budget',
    SUM(e.expense_amount) as 'Spent',
    SUM(e.expense_amount) - SUM(b.budget_amount) as 'Over by'
FROM budget_planner b
LEFT JOIN expense_tracker e ON b.user_name = e.user_name
GROUP BY b.user_name
HAVING SUM(e.expense_amount) > SUM(b.budget_amount);


-- ============================================
-- How to Use in Workbench:
-- ============================================
-- 1. Open this file in Workbench: File → Open SQL Script
-- 2. Select a query (click on it)
-- 3. Press Ctrl+Shift+Enter to run
-- 4. Results appear in "Result Grid" below
-- 5. You can export results: Right-click result → Export
-- ============================================
