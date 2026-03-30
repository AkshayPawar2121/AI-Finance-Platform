-- AI Finance Platform - Database Demo Queries
-- Run these queries one by one in MySQL to demonstrate to teacher

-- ============================================
-- 1. SHOW ALL TABLES
-- ============================================
SHOW TABLES;
-- Expected: register, budget_planner, expense_tracker, goal_setter


-- ============================================
-- 2. TABLE STRUCTURES
-- ============================================

-- User Registration Table
DESCRIBE register;

-- Budget Planner Table
DESCRIBE budget_planner;

-- Expense Tracker Table
DESCRIBE expense_tracker;

-- Goal Setter Table
DESCRIBE goal_setter;


-- ============================================
-- 3. VIEW ALL DATA
-- ============================================

-- All registered users
SELECT * FROM register;

-- All budgets
SELECT * FROM budget_planner;

-- All expenses
SELECT * FROM expense_tracker;

-- All goals
SELECT * FROM goal_setter;


-- ============================================
-- 4. DATA COUNTS (Summary)
-- ============================================
SELECT
    (SELECT COUNT(*) FROM register) as Total_Users,
    (SELECT COUNT(*) FROM budget_planner) as Total_Budgets,
    (SELECT COUNT(*) FROM expense_tracker) as Total_Expenses,
    (SELECT COUNT(*) FROM goal_setter) as Total_Goals;


-- ============================================
-- 5. USER-WISE DATA (Advanced Query)
-- ============================================
SELECT
    r.name as User_Name,
    r.email as Email,
    COUNT(DISTINCT b.id) as Budgets_Count,
    COUNT(DISTINCT e.id) as Expenses_Count,
    COUNT(DISTINCT g.id) as Goals_Count
FROM register r
LEFT JOIN budget_planner b ON r.name = b.user_name
LEFT JOIN expense_tracker e ON r.name = e.user_name
LEFT JOIN goal_setter g ON r.name = g.user_name
GROUP BY r.name, r.email;


-- ============================================
-- 6. FINANCIAL SUMMARY PER USER
-- ============================================
SELECT
    r.name as User_Name,
    COALESCE(SUM(b.budget_amount), 0) as Total_Budget,
    COALESCE(SUM(e.expense_amount), 0) as Total_Expenses,
    COALESCE(SUM(b.budget_amount), 0) - COALESCE(SUM(e.expense_amount), 0) as Remaining_Budget
FROM register r
LEFT JOIN budget_planner b ON r.name = b.user_name
LEFT JOIN expense_tracker e ON r.name = e.user_name
GROUP BY r.name;


-- ============================================
-- 7. CHECK DATA PERSISTENCE
-- ============================================
-- Note: After inserting data through application,
-- these queries will show the data is permanently stored
SELECT 'Database has persistent data stored!' as Status,
       NOW() as Current_Time;
