# Database Demo Guide for Teacher

## Setup Information
- **Database Type:** MySQL 9.6
- **Database Name:** ai_finance_platform
- **Application:** AI Finance Platform (Spring Boot)
- **Port:** 8081

---

## Part 1: Show Application Running

### Step 1: Open Application in Browser
- URL: http://localhost:8081
- Show the homepage/login page

### Step 2: Create Sample Data
1. **Register a new user:**
   - Name: Demo User
   - Email: demo@test.com
   - Mobile: 1234567890
   - Password: password123

2. **Login with the user**

3. **Add Budget:**
   - Budget Name: Monthly Savings
   - Amount: 50000

4. **Add Expense:**
   - Expense Name: Groceries
   - Amount: 5000

5. **Add Goal:**
   - Goal Name: Laptop Purchase
   - Target Amount: 80000

---

## Part 2: Show Database (MySQL Command Line)

### Open Command Prompt and run:

```bash
# Login to MySQL
"C:\Program Files\MySQL\MySQL Server 9.6\bin\mysql" -u root -proot123 ai_finance_platform
```

### Then execute these commands one by one:

```sql
-- 1. Show all tables
SHOW TABLES;
```
**Explain:** "Yeh saare tables hain jo humne JPA entities se automatically create kiye"

```sql
-- 2. Show table structures
DESCRIBE register;
DESCRIBE budget_planner;
DESCRIBE expense_tracker;
DESCRIBE goal_setter;
```
**Explain:** "Yeh table ka structure hai - columns, data types, aur constraints"

```sql
-- 3. Show actual data
SELECT * FROM register;
```
**Explain:** "Yeh wo user hai jo humne abhi register kiya. Password encrypted hai."

```sql
SELECT * FROM budget_planner;
```
**Explain:** "User ka budget data stored hai with user_name reference"

```sql
SELECT * FROM expense_tracker;
```
**Explain:** "User ke expenses track ho rahe hain"

```sql
SELECT * FROM goal_setter;
```
**Explain:** "Financial goals stored hain"

```sql
-- 4. Show Data Persistence (Important!)
-- First, check current data count
SELECT COUNT(*) as Total_Users FROM register;
SELECT COUNT(*) as Total_Budgets FROM budget_planner;
SELECT COUNT(*) as Total_Expenses FROM expense_tracker;
```
**Explain:** "MySQL me data permanent hai - application restart karne ke baad bhi rahega"

---

## Part 3: Key Points to Explain

### 1. **H2 vs MySQL Migration**
- **Before (H2):** In-memory database - data lost on restart
- **After (MySQL):** Persistent database - data survives restarts
- **Why MySQL?** Production-ready, reliable, ACID compliance

### 2. **Database Schema**
- **4 Tables:** register, budget_planner, expense_tracker, goal_setter
- **Primary Keys:** Auto-increment IDs
- **Constraints:** Unique email constraint in register table
- **Relations:** user_name field links data to users

### 3. **JPA/Hibernate Integration**
- Tables automatically created from Entity classes
- No manual SQL needed for table creation
- Hibernate handles CRUD operations

### 4. **Configuration Changes**
Show in `application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/ai_finance_platform
spring.datasource.username=root
spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect
spring.jpa.hibernate.ddl-auto=update
```

### 5. **Data Flow**
1. User submits form → Controller receives data
2. Service layer processes → Repository saves to DB
3. JPA converts Java objects → MySQL INSERT/UPDATE queries
4. Data permanently stored in MySQL

---

## Part 4: Advanced Queries (Bonus Points)

```sql
-- Join example (if time permits)
SELECT
    r.name as User_Name,
    r.email,
    COUNT(DISTINCT b.id) as Total_Budgets,
    COUNT(DISTINCT e.id) as Total_Expenses
FROM register r
LEFT JOIN budget_planner b ON r.name = b.user_name
LEFT JOIN expense_tracker e ON r.name = e.user_name
GROUP BY r.name, r.email;
```
**Explain:** "Yeh complex query hai jo multiple tables ka data combine karke dikha rahi hai"

---

## Troubleshooting (Just in Case)

### If application is not running:
```bash
cd C:\Users\aksha\OneDrive\Documents\GitHub\AI-Finance-Platform\nextgendemo
./mvnw spring-boot:run
```

### If MySQL is not accessible:
- Check MySQL service is running in Windows Services
- Or start from Start Menu → MySQL Server 9.6

---

## Presentation Flow (Recommended Order)

1. ✅ Show application running in browser
2. ✅ Create sample data (user, budget, expense, goal)
3. ✅ Open MySQL command line
4. ✅ Show tables and structure
5. ✅ Show actual data in database
6. ✅ Explain the migration from H2 to MySQL
7. ✅ Highlight data persistence benefit
8. ✅ (Bonus) Show join query if time permits

---

**Good Luck! 🎯**
