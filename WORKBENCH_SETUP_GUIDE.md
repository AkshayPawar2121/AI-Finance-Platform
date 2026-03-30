# MySQL Workbench Setup Guide for AI Finance Platform

## Step 1: Open MySQL Workbench
- Start Menu → MySQL Workbench 9.6

## Step 2: Create New Connection

### 2.1 On Home Screen
- Click on **"+"** button next to "MySQL Connections"
- OR click "Setup New Connection"

### 2.2 Fill Connection Details:
```
Connection Name: AI Finance Platform
Connection Method: Standard (TCP/IP)
Hostname: localhost
Port: 3306
Username: root
Password: [Click "Store in Vault" and enter: root123]
Default Schema: ai_finance_platform
```

### 2.3 Test Connection
- Click **"Test Connection"** button
- Should show: "Successfully connected to MySQL"
- Click **OK**
- Click **OK** again to save

## Step 3: Connect to Database
- Double-click on "AI Finance Platform" connection
- Workbench will open with your database

## Step 4: Verify Database

### 4.1 Check Tables (Left Panel)
- Look at left sidebar under "SCHEMAS"
- Expand **"ai_finance_platform"**
- Expand **"Tables"**
- You should see:
  - budget_planner
  - expense_tracker
  - goal_setter
  - register

### 4.2 View Table Data
Method 1: Right-click on table → "Select Rows - Limit 1000"
Method 2: Click table → Click "table" icon with magnifying glass

## Step 5: Run Demo Queries

### 5.1 Open Query Tab
- Click on **"Query 1"** tab (or create new: File → New Query Tab)

### 5.2 Copy-Paste These Queries:

```sql
-- 1. Show all tables
SHOW TABLES;

-- 2. View all users
SELECT * FROM register;

-- 3. View all budgets
SELECT * FROM budget_planner;

-- 4. View all expenses
SELECT * FROM expense_tracker;

-- 5. View all goals
SELECT * FROM goal_setter;

-- 6. Summary Report
SELECT
    (SELECT COUNT(*) FROM register) as Total_Users,
    (SELECT COUNT(*) FROM budget_planner) as Total_Budgets,
    (SELECT COUNT(*) FROM expense_tracker) as Total_Expenses,
    (SELECT COUNT(*) FROM goal_setter) as Total_Goals;

-- 7. User-wise Financial Summary
SELECT
    r.name as User_Name,
    r.email as Email,
    COALESCE(SUM(b.budget_amount), 0) as Total_Budget,
    COALESCE(SUM(e.expense_amount), 0) as Total_Spent,
    COALESCE(SUM(b.budget_amount), 0) - COALESCE(SUM(e.expense_amount), 0) as Balance
FROM register r
LEFT JOIN budget_planner b ON r.name = b.user_name
LEFT JOIN expense_tracker e ON r.name = e.user_name
GROUP BY r.name, r.email;
```

### 5.3 How to Run Queries:
- **Select a query** (highlight it with mouse)
- Click **Lightning bolt icon** ⚡ (Execute)
- OR press **Ctrl + Shift + Enter**
- Results will appear in "Result Grid" below

## Step 6: Teacher Demo Flow

### Demo Script:

1. **Open Workbench** (Already connected to ai_finance_platform)

2. **Show Tables in Left Panel:**
   > "Sir, yeh dekhe - 4 tables automatically create hui hain JPA entities se"

3. **Right-click on 'register' table → Select Rows:**
   > "Yeh user data hai jo application se register hua"

4. **Run Summary Query:**
   ```sql
   SELECT
       (SELECT COUNT(*) FROM register) as Total_Users,
       (SELECT COUNT(*) FROM budget_planner) as Total_Budgets,
       (SELECT COUNT(*) FROM expense_tracker) as Total_Expenses;
   ```
   > "Yeh overall summary hai - kitne users, budgets, expenses hain"

5. **Run Join Query (Advanced):**
   ```sql
   SELECT
       r.name,
       COUNT(DISTINCT b.id) as Budgets,
       COUNT(DISTINCT e.id) as Expenses
   FROM register r
   LEFT JOIN budget_planner b ON r.name = b.user_name
   LEFT JOIN expense_tracker e ON r.name = e.user_name
   GROUP BY r.name;
   ```
   > "Yeh complex query hai jo multiple tables ko join karke user-wise data dikha rahi hai"

6. **Show ER Diagram (Bonus):**
   - Database → Reverse Engineer
   - Click "Continue" → "Continue"
   - Select all tables → "Execute"
   - Shows visual diagram of tables and relationships

## Tips for Presentation:

### Good Points to Highlight:

✅ **Visual Interface:** "Workbench se data easy to visualize hai"

✅ **Table Structure:** Left panel me table expand karo aur columns dikhaao
   - Show PRIMARY KEY
   - Show UNIQUE constraint on email

✅ **Data Validation:**
   - Email unique hai (duplicate nahi ho sakta)
   - Auto-increment IDs

✅ **Query Builder:** "Complex queries bhi visually run kar sakte hain"

✅ **Export Data:** File → Export → Forward Engineer SQL
   - Backup ke liye SQL file generate ho sakti hai

### Shortcuts:
- **Ctrl + Enter**: Run current line
- **Ctrl + Shift + Enter**: Run selected query
- **Ctrl + T**: New query tab
- **F5**: Refresh schemas

## Troubleshooting:

### Connection Failed?
- Check MySQL service is running:
  - Windows Services → MySQL96 → Start

### Tables not visible?
- Right-click on "ai_finance_platform" → Refresh All

### Query Error?
- Make sure you're connected to correct database
- Check database name in toolbar (should show "ai_finance_platform")

---

## Before Demo Checklist:

- [ ] Workbench connection created and tested
- [ ] Can see all 4 tables in left panel
- [ ] Sample data exists (register user via app first!)
- [ ] Test queries run successfully
- [ ] Know how to execute queries (lightning bolt)
- [ ] ER diagram tried once (optional but impressive!)

**Ready to impress! 🎯**
