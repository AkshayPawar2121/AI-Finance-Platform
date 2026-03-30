-- Sample Data for Demo (Run this ONLY if you need quick demo data)
-- WARNING: This is for demonstration only. In production, data comes from application.

-- Note: In real application, data is inserted via web interface
-- This script is just for quick demo if needed

-- Sample User (Password: test123)
-- INSERT INTO register (name, mobile, email, password)
-- VALUES ('Test User', '9876543210', 'test@example.com', 'test123');

-- After you register a user via web application, you can insert sample budget/expenses:

-- Sample Budget (Replace 'username' with actual registered user name)
-- INSERT INTO budget_planner (user_name, budget_name, budget_amount)
-- VALUES ('Test User', 'Monthly Grocery', 15000);

-- INSERT INTO budget_planner (user_name, budget_name, budget_amount)
-- VALUES ('Test User', 'Transportation', 5000);

-- Sample Expenses
-- INSERT INTO expense_tracker (user_name, expense_name, expense_amount)
-- VALUES ('Test User', 'Vegetables', 2000);

-- INSERT INTO expense_tracker (user_name, expense_name, expense_amount)
-- VALUES ('Test User', 'Petrol', 1500);

-- Sample Goals
-- INSERT INTO goal_setter (user_name, goal_name, target, remaining_amount)
-- VALUES ('Test User', 'Buy Laptop', '80000', 80000);

-- INSERT INTO goal_setter (user_name, goal_name, target, remaining_amount)
-- VALUES ('Test User', 'Emergency Fund', '100000', 100000);

-- ============================================
-- BETTER APPROACH: Use the Web Application!
-- ============================================
-- 1. Go to http://localhost:8081
-- 2. Register a new user
-- 3. Login
-- 4. Add budgets, expenses, and goals through UI
-- 5. Then run demo_queries.sql to show the data
-- ============================================
