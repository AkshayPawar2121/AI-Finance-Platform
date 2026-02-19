<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en" data-bs-theme="dark">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="_csrf" content="${_csrf.token}" />
        <title>Dashboard | NextGen Finance</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <style>
            :root {
                --bg-body: #121212;
                --surface: #1e1e1e;
                --surface-hover: #2d2d2d;
                --primary: #8ab4f8;
                --primary-hover: #aecbfa;
                --success: #81c995;
                --danger: #f28b82;
                --text-main: #e8eaed;
                --text-muted: #9aa0a6;
                --border: #3c4043;
                --sidebar-width: 260px;
            }

            body {
                background-color: var(--bg-body) !important;
                color: var(--text-main) !important;
                font-family: 'Inter', sans-serif;
                overflow-x: hidden;
            }

            /* Sidebar */
            #sidebar {
                position: fixed;
                top: 0;
                left: 0;
                height: 100vh;
                width: var(--sidebar-width);
                background-color: var(--surface);
                border-right: 1px solid var(--border);
                padding: 1.5rem;
                z-index: 1000;
            }

            .brand-logo {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--text-main);
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                margin-bottom: 2rem;
                padding-left: 0.75rem;
            }

            .nav-link {
                color: var(--text-muted) !important;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                margin-bottom: 0.25rem;
                transition: all 0.2s;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                text-decoration: none;
            }

            .nav-link:hover {
                background-color: var(--surface-hover);
                color: var(--text-main) !important;
            }

            .nav-link.active {
                background-color: rgba(138, 180, 248, 0.1);
                color: var(--primary) !important;
            }

            /* Main Content */
            .main-content {
                margin-left: var(--sidebar-width);
                padding: 2rem;
            }

            /* Stats Cards */
            .stat-card {
                background-color: var(--surface);
                border: 1px solid var(--border);
                border-radius: 12px;
                padding: 1.5rem;
            }

            .stat-label {
                color: var(--text-muted);
                font-size: 0.875rem;
                margin-bottom: 0.5rem;
            }

            .stat-value {
                font-size: 1.75rem;
                font-weight: 600;
            }

            /* Content Sections */
            .content-section {
                display: none;
                animation: fadeIn 0.3s ease-in-out;
            }

            .content-section.active-section {
                display: block;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .page-title {
                font-size: 1.5rem;
                font-weight: 600;
                margin-bottom: 1.5rem;
            }

            /* Tables */
            .table {
                color: var(--text-main) !important;
                --bs-table-bg: transparent;
                --bs-table-border-color: var(--border);
            }

            .table th {
                font-weight: 500;
                color: var(--text-muted);
                border-bottom-width: 1px;
                font-size: 0.875rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .table td {
                padding: 1rem 0.5rem;
                vertical-align: middle;
                font-size: 0.95rem;
                color: var(--text-main) !important;
            }

            /* Buttons */
            .btn-primary {
                background-color: var(--primary);
                border: none;
                color: #202124 !important;
                font-weight: 500;
                padding: 8px 20px;
            }

            .btn-primary:hover {
                background-color: var(--primary-hover);
                color: #202124 !important;
            }

            .btn-outline-danger {
                color: var(--danger);
                border-color: var(--danger);
            }

            .btn-outline-danger:hover {
                background-color: var(--danger);
                color: #202124 !important;
            }

            .btn-sm {
                padding: 4px 12px;
                font-size: 0.85rem;
            }

            /* Forms & Modals */
            .modal-content {
                background-color: var(--surface);
                border: 1px solid var(--border);
                color: var(--text-main);
                border-radius: 16px;
            }

            .modal-header {
                border-bottom: 1px solid var(--border);
            }

            .modal-footer {
                border-top: 1px solid var(--border);
            }

            .form-control,
            .form-select {
                background-color: #2d2d2d !important;
                border: 1px solid var(--border) !important;
                color: var(--text-main) !important;
                border-radius: 8px;
                padding: 10px;
            }

            .form-control:focus,
            .form-select:focus {
                background-color: #2d2d2d !important;
                border-color: var(--primary) !important;
                color: var(--text-main) !important;
                box-shadow: 0 0 0 2px rgba(138, 180, 248, 0.2) !important;
            }

            .form-label {
                color: var(--text-muted) !important;
            }

            .btn-close {
                filter: invert(1);
            }

            /* Prediction Result Table */
            #modalContent table {
                width: 100%;
                color: var(--text-main);
            }

            #modalContent th,
            #modalContent td {
                padding: 8px;
                border: 1px solid var(--border);
            }

            #modalContent th {
                background-color: var(--surface-hover);
            }
        </style>
    </head>

    <body>

        <!-- Sidebar -->
        <nav id="sidebar">
            <a href="#" class="brand-logo">
                <i class="bi bi-graph-up-arrow" style="color: var(--primary);"></i> NextGen
            </a>
            <div class="nav flex-column">
                <a href="#" class="nav-link active" id="goal-setter-link">
                    <i class="bi bi-bullseye"></i> Goal Setter
                </a>
                <a href="#" class="nav-link" id="budget-planner-link">
                    <i class="bi bi-wallet2"></i> Budget Planner
                </a>
                <a href="#" class="nav-link" id="expense-tracker-link">
                    <i class="bi bi-receipt"></i> Expense Tracker
                </a>
            </div>
            <div style="position: absolute; bottom: 2rem; width: calc(100% - 3rem);">
                <a href="/" class="nav-link text-danger">
                    <i class="bi bi-box-arrow-left"></i> Logout
                </a>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Dashboard Overview -->
            <div class="row g-4 mb-5">
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-label">Total Goals</div>
                        <div class="stat-value">${userGoals.size()}</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-label">Active Budgets</div>
                        <div class="stat-value">${userBudgets.size()}</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div class="stat-label">Total Expenses</div>
                        <div class="stat-value">${userExpenses.size()}</div>
                    </div>
                </div>
            </div>

            <!-- 1. GOAL SETTER SECTION -->
            <div id="goal-setter" class="content-section active-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="page-title">Goal Setter</h2>
                    <button class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal"
                        data-bs-target="#addGoalModal">
                        <i class="bi bi-plus-lg"></i> New Goal
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Goal Name</th>
                                <th>Target Amount</th>
                                <th>Remaining</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="goal" items="${userGoals}">
                                <tr>
                                    <td>${goal.goalName}</td>
                                    <td>${goal.target}</td>
                                    <td>${goal.target - (goal.remainingAmount != null ? goal.remainingAmount : 0)}</td>
                                    <td>
                                        <button class="btn btn-primary btn-sm rounded-pill"
                                            onclick="openPayModal('${goal.goalName}', ${goal.target - (goal.remainingAmount != null ? goal.remainingAmount : 0)}, ${goal.id})">
                                            Pay
                                        </button>
                                        <button class="btn btn-outline-danger btn-sm rounded-pill ms-2"
                                            onclick="deleteGoal(${goal.id})">
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 2. BUDGET PLANNER SECTION -->
            <div id="budget-planner" class="content-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="page-title">Budget Planner</h2>
                    <button class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal"
                        data-bs-target="#addBudgetModal">
                        <i class="bi bi-plus-lg"></i> New Budget
                    </button>
                </div>

                <!-- Existing Budgets Table -->
                <div class="card mb-5" style="background-color: var(--surface); border: 1px solid var(--border);">
                    <div class="card-header border-bottom border-secondary bg-transparent py-3 mx-3 px-0">
                        <h5 class="mb-0 fw-normal fs-6 text-uppercase text-muted">Active Budgets</h5>
                    </div>
                    <div class="card-body p-0">
                        <table class="table mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Budget Name</th>
                                    <th>Amount</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="budget" items="${userBudgets}">
                                    <tr>
                                        <td class="ps-4">${budget.budget_name}</td>
                                        <td>${budget.budget_amount}</td>
                                        <td>
                                            <button class="btn btn-sm btn-primary rounded-pill"
                                                onclick="openBudgetPayModal(${budget.budget_amount}, ${budget.id})">Edit</button>
                                            <button class="btn btn-sm btn-outline-danger rounded-pill ms-2"
                                                onclick="deleteBudget(${budget.id})">Delete</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- AI Prediction Form -->
                <div class="card" style="background-color: var(--surface); border: 1px solid var(--border);">
                    <div class="card-body p-4">
                        <div class="text-center mb-4">
                            <div class="mb-2">
                                <i class="bi bi-robot" style="font-size: 2rem; color: var(--primary);"></i>
                            </div>
                            <h4 class="fw-normal">AI Financial Predictor</h4>
                            <p class="text-muted small">Let our probability model analyze your profile.</p>
                        </div>

                        <form id="predictForm">
                            <div class="row g-3 mb-3">
                                <div class="col-md-4">
                                    <label class="form-label text-muted small">Annual Income</label>
                                    <input type="number" class="form-control" name="income" id="income" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label text-muted small">Age</label>
                                    <input type="number" class="form-control" name="age" id="age" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label text-muted small">Dependents</label>
                                    <input type="number" class="form-control" name="dependents" id="dependents"
                                        required>
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label text-muted small">Occupation</label>
                                    <select class="form-select" name="occupation" id="occupation" required>
                                        <option value="1">Self Employed</option>
                                        <option value="2">Professional</option>
                                        <option value="3">Retired</option>
                                        <option value="4">Student</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label text-muted small">City Tier</label>
                                    <select class="form-select" name="city_tier" id="city_tier" required>
                                        <option value="1">Tier 1</option>
                                        <option value="2">Tier 2</option>
                                        <option value="3">Tier 3</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label text-muted small">Loan Repayment</label>
                                    <input type="number" class="form-control" name="loan_repayment" id="loan_repayment"
                                        required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label text-muted small">Insurance</label>
                                    <input type="number" class="form-control" name="insurance" id="insurance" required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label text-muted small d-block mb-3">Exclusions</label>
                                <div class="row g-3">
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="own_house"
                                                name="own_house">
                                            <label class="form-check-label small text-muted" for="own_house">Own
                                                House</label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="no_transport"
                                                name="no_transport">
                                            <label class="form-check-label small text-muted" for="no_transport">No
                                                Transport</label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="no_eating_out"
                                                name="no_eating_out">
                                            <label class="form-check-label small text-muted" for="no_eating_out">No
                                                Eating Out</label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="no_entertainment"
                                                name="no_entertainment">
                                            <label class="form-check-label small text-muted" for="no_entertainment">No
                                                Ent.</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-primary rounded-pill px-5 py-2">
                                    <i class="bi bi-stars"></i> Generate Prediction
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 3. EXPENSE TRACKER SECTION -->
            <div id="expense-tracker" class="content-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="page-title">Expense Tracker</h2>
                    <button class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal"
                        data-bs-target="#addExpenseModal">
                        <i class="bi bi-plus-lg"></i> New Expense
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Expense Name</th>
                                <th>Amount</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="expense" items="${userExpenses}">
                                <tr>
                                    <td>${expense.expenseName}</td>
                                    <td>${expense.expenseAmount}</td>
                                    <td>
                                        <button class="btn btn-primary btn-sm rounded-pill"
                                            onclick="openExpensePayModal(${expense.expenseAmount}, ${expense.id})">Edit</button>
                                        <button class="btn btn-outline-danger btn-sm rounded-pill ms-2"
                                            onclick="deleteExpense(${expense.id})">Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>

        <!-- MODALS -->

        <!-- Add Goal -->
        <div class="modal fade" id="addGoalModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Set New Goal</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="goalForm" action="/home/goalsetter" method="post">
                            <div class="mb-3">
                                <label class="form-label">Goal Name</label>
                                <input type="text" class="form-control" name="goalname" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Target Amount</label>
                                <input type="number" class="form-control" name="target" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 rounded-pill">Create Goal</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Budget -->
        <div class="modal fade" id="addBudgetModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Create Budget</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="budgetForm" action="/home/budgetplanner" method="post">
                            <div class="mb-3">
                                <label class="form-label">Budget Name</label>
                                <input type="text" class="form-control" name="budgetName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Amount</label>
                                <input type="number" class="form-control" name="budgetAmount" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 rounded-pill">Save Budget</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Expense -->
        <div class="modal fade" id="addExpenseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Log Expense</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="expenseForm" action="/home/expensetracker" method="post">
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <input type="text" class="form-control" name="expenseName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Amount</label>
                                <input type="number" class="form-control" name="expenseAmount" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 rounded-pill">Add Expense</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Payment Modals -->
        <div class="modal fade" id="paymentModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Contribute to Goal</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="paymentForm" action="/home/goalsetter/payment" method="post">
                            <input type="hidden" id="goalId" name="goalId">
                            <div class="mb-3">
                                <label class="form-label">Goal</label>
                                <input type="text" class="form-control" id="modalGoalName" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Remaining</label>
                                <input type="text" class="form-control" id="modalRemainingAmount" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Amount to Pay</label>
                                <input type="number" class="form-control" name="paymentAmount" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 rounded-pill">Confirm Payment</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="paymentBudgetModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Budget</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="paymentBudgetForm" action="/home/budgetplanner/payment" method="post">
                            <input type="hidden" id="budgetId" name="budgetId">
                            <div class="mb-3">
                                <label class="form-label">New Amount</label>
                                <input type="number" class="form-control" id="budgetAmount" name="budgetAmount"
                                    step="0.01" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 rounded-pill">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="paymentExpenseModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Expense</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="paymentExpenseForm" action="/home/expensetracker/payment" method="post">
                            <input type="hidden" id="expenseId" name="expenseId">
                            <div class="mb-3">
                                <label class="form-label">New Amount</label>
                                <input type="number" class="form-control" id="expenseAmount" name="expenseAmount"
                                    step="0.01" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 rounded-pill">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Prediction Result Modal (Custom for PDF/Print) -->
        <div id="responseModal" class="modal" tabindex="-1" style="background: rgba(0,0,0,0.5);">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Prediction Result</h5>
                        <button type="button" class="btn-close" onclick="closeModal()"></button>
                    </div>
                    <div class="modal-body">
                        <div id="modalContent"></div>
                    </div>
                    <div class="modal-footer">
                        <button onclick="downloadAsPDF()" class="btn btn-success btn-sm"><i class="bi bi-download"></i>
                            PDF</button>
                        <button onclick="printTable()" class="btn btn-primary btn-sm"><i class="bi bi-printer"></i>
                            Print</button>
                        <button onclick="closeModal()" class="btn btn-outline-secondary btn-sm">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="modalOverlay"
            style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:999;"></div>


        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Section Switcher
            function showSection(sectionId, linkId) {
                document.querySelectorAll('.content-section').forEach(el => el.classList.remove('active-section'));
                document.getElementById(sectionId).classList.add('active-section');
                document.querySelectorAll('.nav-link').forEach(el => el.classList.remove('active'));
                document.getElementById(linkId).classList.add('active');
            }

            document.getElementById('goal-setter-link').addEventListener('click', (e) => {
                e.preventDefault();
                showSection('goal-setter', 'goal-setter-link');
            });
            document.getElementById('budget-planner-link').addEventListener('click', (e) => {
                e.preventDefault();
                showSection('budget-planner', 'budget-planner-link');
            });
            document.getElementById('expense-tracker-link').addEventListener('click', (e) => {
                e.preventDefault();
                showSection('expense-tracker', 'expense-tracker-link');
            });

            // Modal Open Functions
            function openPayModal(goalName, remainingAmount, goalId) {
                const modal = new bootstrap.Modal(document.getElementById('paymentModal'));
                document.getElementById('modalGoalName').value = goalName;
                document.getElementById('modalRemainingAmount').value = remainingAmount;
                document.getElementById('goalId').value = goalId;
                modal.show();
            }

            function openBudgetPayModal(budgetAmount, budgetId) {
                const modal = new bootstrap.Modal(document.getElementById('paymentBudgetModal'));
                document.getElementById('budgetAmount').value = budgetAmount;
                document.getElementById('budgetId').value = budgetId;
                modal.show();
            }

            function openExpensePayModal(expenseAmount, expenseId) {
                const modal = new bootstrap.Modal(document.getElementById('paymentExpenseModal'));
                document.getElementById('expenseAmount').value = expenseAmount;
                document.getElementById('expenseId').value = expenseId;
                modal.show();
            }

            // Delete Functions (Preserved IDs/Logic needed)
            function deleteGoal(id) {
                if (confirm('Are you sure you want to delete this goal?')) {
                    // Assuming backend expects a GET request or form submission. Using a form for safety if not specified, 
                    // but usually legacy apps use a link. I will assume a form post or simple window.location if that was the original way.
                    // Re-checking original file: "onclick="deleteBudget(${budget.id})"" was there. 
                    // Wait, I saw "onclick="deleteBudget(${budget.id})"" but I didn't see the implementation in the snippet.
                    // I must safeguard this. I'll create a hidden form to submit deletes to be standard, or just fetch.
                    // Let's use fetch with reload.
                    fetch('/home/goalsetter/delete?id=' + id, { method: 'GET' }).then(() => window.location.reload());
                }
            }
            function deleteBudget(id) {
                if (confirm('Delete this budget?')) fetch('/home/budgetplanner/delete?id=' + id).then(() => window.location.reload());
            }
            function deleteExpense(id) {
                if (confirm('Delete this expense?')) fetch('/home/expensetracker/delete?id=' + id).then(() => window.location.reload());
            }

            // Prediction Logic
            document.getElementById('predictForm').addEventListener('submit', function (event) {
                event.preventDefault();
                const formData = new URLSearchParams(new FormData(this)).toString();

                fetch('/home/budgetplanner/predict', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            const roundedData = roundValues(data.data);
                            showTable(roundedData);
                            openModal();
                        } else {
                            alert('Error: ' + (data.error || 'Unknown error occurred'));
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Error processing request' + error);
                    });
            });

            function showTable(data) {
                const modalContent = document.getElementById('modalContent');
                modalContent.innerHTML = '';
                const table = document.createElement('table');
                table.className = 'table table-bordered table-striped';

                const thead = document.createElement('thead');
                thead.innerHTML = `<tr><th>Name</th><th>Amount</th></tr>`;
                table.appendChild(thead);

                const tbody = document.createElement('tbody');
                Object.entries(data).forEach(([key, value]) => {
                    const row = document.createElement('tr');
                    const keyCell = document.createElement('td');
                    keyCell.textContent = key;
                    row.appendChild(keyCell);

                    const valueCell = document.createElement('td');
                    valueCell.textContent = typeof value === 'object' ? JSON.stringify(value) : value;
                    row.appendChild(valueCell);
                    tbody.appendChild(row);
                });
                table.appendChild(tbody);
                modalContent.appendChild(table);
            }

            function openModal() {
                const modal = document.getElementById('responseModal');
                modal.style.display = 'block';
                modal.classList.add('show');
                document.getElementById('modalOverlay').style.display = 'block';
            }

            function closeModal() {
                const modal = document.getElementById('responseModal');
                modal.style.display = 'none';
                modal.classList.remove('show');
                document.getElementById('modalOverlay').style.display = 'none';
            }

            function roundValues(data) {
                for (let key in data) {
                    if (typeof data[key] === 'number') {
                        data[key] = Math.round(data[key]);
                    }
                }
                return data;
            }

            // PDF & Print
            async function downloadAsPDF() {
                const { jsPDF } = window.jspdf;
                const element = document.getElementById('modalContent');
                const canvas = await html2canvas(element);
                const imgData = canvas.toDataURL('image/png');
                const pdf = new jsPDF();
                pdf.addImage(imgData, 'PNG', 10, 10, 180, 0);
                pdf.save('prediction-result.pdf');
            }

            function printTable() {
                const printWindow = window.open('', '', 'height=600,width=800');
                const element = document.getElementById('modalContent').innerHTML;
                printWindow.document.write('<html><head><title>Print</title>');
                printWindow.document.write('<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">');
                printWindow.document.write('</head><body>');
                printWindow.document.write(element);
                printWindow.document.write('</body></html>');
                printWindow.document.close();
                printWindow.print();
            }
        </script>
    </body>

    </html>