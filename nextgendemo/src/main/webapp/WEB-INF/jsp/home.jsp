<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en" data-bs-theme="dark" id="html-root">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="_csrf" content="${_csrf.token}" />
        <title>Dashboard | NextGen Finance</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
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

            /* Light theme variables */
            [data-bs-theme="light"] {
                --bg-body: #f5f5f5;
                --surface: #ffffff;
                --surface-hover: #f0f0f0;
                --primary: #1a73e8;
                --primary-hover: #1557b0;
                --success: #1e8e3e;
                --danger: #d93025;
                --text-main: #202124;
                --text-muted: #5f6368;
                --border: #dadce0;
                --sidebar-width: 260px;
            }

            /* Light mode specific overrides */
            [data-bs-theme="light"] .form-control,
            [data-bs-theme="light"] .form-select {
                background-color: #ffffff !important;
                color: var(--text-main) !important;
            }

            [data-bs-theme="light"] .form-control:focus,
            [data-bs-theme="light"] .form-select:focus {
                background-color: #ffffff !important;
                box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2) !important;
            }

            [data-bs-theme="light"] .btn-close {
                filter: invert(0);
            }

            [data-bs-theme="light"] .modal-content {
                background-color: #ffffff;
                border: 1px solid var(--border);
            }

            [data-bs-theme="light"] .stat-card {
                background-color: #ffffff;
                border: 1px solid var(--border);
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            [data-bs-theme="light"] .table {
                --bs-table-bg: #ffffff;
            }

            [data-bs-theme="light"] #sidebar {
                background-color: #ffffff;
                border-right: 1px solid var(--border);
                box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
            }

            /* Light mode button overrides */
            [data-bs-theme="light"] .btn-outline-light {
                color: var(--text-main);
                border-color: var(--border);
                background-color: transparent;
            }

            [data-bs-theme="light"] .btn-outline-light:hover {
                color: #ffffff;
                background-color: var(--text-main);
                border-color: var(--text-main);
            }

            [data-bs-theme="light"] .btn-outline-secondary {
                color: var(--text-muted);
                border-color: var(--border);
            }

            [data-bs-theme="light"] .btn-outline-secondary:hover {
                color: #ffffff;
                background-color: var(--text-muted);
                border-color: var(--text-muted);
            }

            [data-bs-theme="light"] .btn-outline-danger {
                color: #d93025;
                border-color: #d93025;
            }

            [data-bs-theme="light"] .btn-outline-danger:hover {
                background-color: #d93025;
                color: #ffffff;
            }

            [data-bs-theme="light"] .btn-primary {
                background-color: var(--primary);
                color: #ffffff !important;
                font-weight: 500;
            }

            [data-bs-theme="light"] .btn-primary:hover {
                background-color: var(--primary-hover);
                color: #ffffff !important;
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

            /* Chart Cards */
            .chart-card {
                background-color: var(--surface);
                border: 1px solid var(--border);
                border-radius: 12px;
                padding: 1.5rem;
                height: 100%;
            }

            .chart-title {
                font-size: 1.1rem;
                font-weight: 600;
                margin-bottom: 1.5rem;
                color: var(--text-main);
            }

            canvas {
                max-height: 300px !important;
            }

            /* AI Insights Styling */
            .ai-insights-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 1rem;
            }

            .insight-card {
                background-color: var(--surface);
                border-left: 4px solid var(--primary);
                padding: 1rem 1.25rem;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .insight-card:hover {
                transform: translateX(5px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

            .insight-card.success {
                border-left-color: #81c995;
            }

            .insight-card.warning {
                border-left-color: #fdd663;
            }

            .insight-card.danger {
                border-left-color: #f28b82;
            }

            .insight-card.info {
                border-left-color: var(--primary);
            }

            .insight-icon {
                font-size: 1.25rem;
                margin-right: 0.75rem;
            }

            .insight-title {
                font-weight: 600;
                font-size: 0.95rem;
                margin-bottom: 0.5rem;
                color: var(--text-main);
                display: flex;
                align-items: center;
            }

            .insight-description {
                font-size: 0.875rem;
                color: var(--text-muted);
                line-height: 1.5;
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

            /* Theme toggle button */
            .btn-theme-toggle {
                background-color: transparent;
                border: 1px solid var(--border);
                color: var(--text-muted);
                border-radius: 8px;
                padding: 8px 12px;
                transition: all 0.2s;
                cursor: pointer;
                width: 100%;
                text-align: left;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .btn-theme-toggle:hover {
                background-color: var(--surface-hover);
                color: var(--text-main);
                border-color: var(--text-muted);
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
                <a href="#" class="nav-link active" id="dashboard-link">
                    <i class="bi bi-graph-up"></i> Dashboard
                </a>
                <a href="#" class="nav-link" id="goal-setter-link">
                    <i class="bi bi-bullseye"></i> Goal Setter
                </a>
                <a href="#" class="nav-link" id="budget-planner-link">
                    <i class="bi bi-wallet2"></i> Budget Planner
                </a>
                <a href="#" class="nav-link" id="expense-tracker-link">
                    <i class="bi bi-receipt"></i> Expense Tracker
                </a>
            </div>
            <div style="position: absolute; bottom: 6rem; width: calc(100% - 3rem);">
                <button id="themeToggle" class="btn-theme-toggle nav-link" aria-label="Toggle theme">
                    <i id="themeIcon" class="bi bi-sun-fill"></i> <span id="themeText">Light Mode</span>
                </button>
            </div>
            <div style="position: absolute; bottom: 2rem; width: calc(100% - 3rem);">
                <a href="/" class="nav-link text-danger">
                    <i class="bi bi-box-arrow-left"></i> Logout
                </a>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Dashboard Overview Stats -->
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

            <!-- DASHBOARD SECTION WITH CHARTS -->
            <div id="dashboard" class="content-section active-section">
                <h2 class="page-title">Financial Dashboard</h2>

                <div class="row g-4 mb-4">
                    <!-- Expense Breakdown Chart -->
                    <div class="col-md-6">
                        <div class="chart-card">
                            <h5 class="chart-title">Expense Breakdown</h5>
                            <canvas id="expenseDonutChart"></canvas>
                        </div>
                    </div>

                    <!-- Goal Progress Chart -->
                    <div class="col-md-6">
                        <div class="chart-card">
                            <h5 class="chart-title">Goal Progress</h5>
                            <canvas id="goalProgressChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- AI Insights Section -->
                <div class="row g-4">
                    <div class="col-12">
                        <div class="chart-card" style="background: linear-gradient(135deg, var(--surface) 0%, var(--surface-hover) 100%);">
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-lightbulb-fill" style="font-size: 1.5rem; color: var(--primary); margin-right: 0.75rem;"></i>
                                <h5 class="chart-title mb-0">AI Financial Insights</h5>
                            </div>

                            <div id="aiInsightsContent" class="ai-insights-container">
                                <!-- Insights will be dynamically generated here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 1. GOAL SETTER SECTION -->
            <div id="goal-setter" class="content-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="page-title">Goal Setter</h2>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-light rounded-pill px-4" onclick="openAISuggestionModal()"
                            title="Get AI-powered savings allocation suggestions">
                            <i class="bi bi-magic"></i> AI Suggestion
                        </button>
                        <button class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal"
                            data-bs-target="#addGoalModal">
                            <i class="bi bi-plus-lg"></i> New Goal
                        </button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Goal Name</th>
                                <th>Target Amount</th>
                                <th>Remaining</th>
                                <th>Priority</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="goal" items="${userGoals}">
                                <tr>
                                    <td>${goal.goalName}</td>
                                    <td>&#8377;${goal.target}</td>
                                    <td>&#8377;${goal.target - (goal.remainingAmount != null ? goal.remainingAmount :
                                        0)}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${goal.priority == 1}"><span class="badge"
                                                    style="background:#f28b82;">1 - Highest</span></c:when>
                                            <c:when test="${goal.priority == 2}"><span class="badge"
                                                    style="background:#fbbc04; color:#202124;">2 - High</span></c:when>
                                            <c:when test="${goal.priority == 3}"><span class="badge"
                                                    style="background:#8ab4f8; color:#202124;">3 - Medium</span>
                                            </c:when>
                                            <c:when test="${goal.priority == 4}"><span class="badge"
                                                    style="background:#81c995; color:#202124;">4 - Low</span></c:when>
                                            <c:otherwise><span class="badge" style="background:#3c4043;">5 -
                                                    Lowest</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-primary btn-sm rounded-pill"
                                            onclick="openPayModal('${goal.goalName}', '${goal.target - (goal.remainingAmount != null ? goal.remainingAmount : 0)}', '${goal.id}')">
                                            Pay
                                        </button>
                                        <button class="btn btn-outline-danger btn-sm rounded-pill ms-2"
                                            onclick="deleteGoal('${goal.id}')">
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
                                                onclick="openBudgetPayModal('${budget.budget_amount}', '${budget.id}')">Edit</button>
                                            <button class="btn btn-sm btn-outline-danger rounded-pill ms-2"
                                                onclick="deleteBudget('${budget.id}')">Delete</button>
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
                                <label class="form-label text-muted small d-block mb-3">Lifestyle Exclusions (check to
                                    redirect to savings)</label>
                                <div class="row g-3">
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="own_house"
                                                name="own_house">
                                            <label class="form-check-label small text-muted" for="own_house">Own House
                                                <small class="d-block" style="font-size:0.7rem;">(no
                                                    rent)</small></label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="self_sufficient_food"
                                                name="self_sufficient_food">
                                            <label class="form-check-label small text-muted"
                                                for="self_sufficient_food">Self-Sufficient Food
                                                <small class="d-block" style="font-size:0.7rem;">(no
                                                    groceries)</small></label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="no_transport"
                                                name="no_transport">
                                            <label class="form-check-label small text-muted" for="no_transport">No
                                                Transport
                                                <small class="d-block" style="font-size:0.7rem;"></small></label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="no_eating_out"
                                                name="no_eating_out">
                                            <label class="form-check-label small text-muted" for="no_eating_out">No
                                                Eating Out
                                                <small class="d-block" style="font-size:0.7rem;"></small></label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="no_entertainment"
                                                name="no_entertainment">
                                            <label class="form-check-label small text-muted" for="no_entertainment">No
                                                Entertainment
                                                <small class="d-block" style="font-size:0.7rem;"></small></label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="no_utilities"
                                                name="no_utilities">
                                            <label class="form-check-label small text-muted" for="no_utilities">No
                                                Utilities
                                                <small class="d-block" style="font-size:0.7rem;"></small></label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="no_healthcare"
                                                name="no_healthcare">
                                            <label class="form-check-label small text-muted" for="no_healthcare">No
                                                Healthcare
                                                <small class="d-block" style="font-size:0.7rem;"></small></label>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="no_education"
                                                name="no_education">
                                            <label class="form-check-label small text-muted" for="no_education">No
                                                Education
                                                <small class="d-block" style="font-size:0.7rem;"></small></label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-primary rounded-pill px-5 py-2" id="predictBtn">
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
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-light rounded-pill px-4" onclick="openAIScanModal()"
                            title="Upload a bill photo and let AI extract the expense details">
                            <i class="bi bi-camera"></i> AI Scan Bill
                        </button>
                        <button class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal"
                            data-bs-target="#addExpenseModal">
                            <i class="bi bi-plus-lg"></i> New Expense
                        </button>
                    </div>
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
                                            onclick="openExpensePayModal('${expense.expenseAmount}', '${expense.id}')">Edit</button>
                                        <button class="btn btn-outline-danger btn-sm rounded-pill ms-2"
                                            onclick="deleteExpense('${expense.id}')">Delete</button>
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
                        <form id="goalForm">
                            <div class="mb-3">
                                <label class="form-label">Goal Name</label>
                                <input type="text" class="form-control" id="goalname" name="goalname" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Target Amount</label>
                                <input type="number" class="form-control" id="goalTarget" name="target" min="1"
                                    required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Priority <small class="text-muted">(1 = Most Important, 5 =
                                        Least Important)</small></label>
                                <select class="form-select" id="goalPriority" name="priority" required>
                                    <option value="1">Highest Priority (e.g. Emergency Fund)</option>
                                    <option value="2">High Priority</option>
                                    <option value="3" selected>Medium Priority (Default)</option>
                                    <option value="4">Low Priority</option>
                                    <option value="5">Lowest Priority (Nice to have)</option>
                                </select>
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
                        <form id="budgetForm">
                            <div class="mb-3">
                                <label class="form-label">Budget Name</label>
                                <input type="text" class="form-control" id="budgetName" name="budgetName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Amount</label>
                                <input type="number" class="form-control" id="newBudgetAmount" name="budgetAmount"
                                    min="1" required>
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
                        <form id="expenseForm">
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <input type="text" class="form-control" id="expenseName" name="expenseName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Amount</label>
                                <input type="number" class="form-control" id="newExpenseAmount" name="expenseAmount"
                                    min="1" required>
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
                        <form id="paymentForm">
                            <input type="hidden" id="goalId" name="goalId">
                            <div class="mb-3">
                                <label class="form-label">Goal</label>
                                <input type="text" class="form-control" id="modalGoalName" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Amount Paid So Far</label>
                                <input type="text" class="form-control" id="modalRemainingAmount" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Amount to Contribute</label>
                                <input type="number" class="form-control" id="paymentAmount" name="paymentAmount"
                                    min="1" required>
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
                        <form id="paymentBudgetForm">
                            <input type="hidden" id="budgetId" name="budgetId">
                            <div class="mb-3">
                                <label class="form-label">New Amount</label>
                                <input type="number" class="form-control" id="budgetAmount" name="budgetAmount" step="1"
                                    min="1" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 rounded-pill">Update Budget</button>
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
                        <form id="paymentExpenseForm">
                            <input type="hidden" id="expenseId" name="expenseId">
                            <div class="mb-3">
                                <label class="form-label">New Amount</label>
                                <input type="number" class="form-control" id="expenseAmount" name="expenseAmount"
                                    step="1" min="1" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 rounded-pill">Update Expense</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Prediction Result Modal -->
        <div id="responseModal" class="modal fade" tabindex="-1" aria-labelledby="responseModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="responseModalLabel">AI Prediction Result</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="modalContent"></div>
                    </div>
                    <div class="modal-footer">
                        <button onclick="downloadAsPDF()" class="btn btn-success btn-sm"><i class="bi bi-download"></i>
                            PDF</button>
                        <button onclick="printTable()" class="btn btn-primary btn-sm"><i class="bi bi-printer"></i>
                            Print</button>
                        <button type="button" class="btn btn-outline-secondary btn-sm"
                            data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- AI Goal Allocation Suggestion Modal -->
        <div class="modal fade" id="aiSuggestionModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="bi bi-magic"></i> AI-Powered Goal Allocation
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div id="aiSuggestionInputSection">
                            <p class="text-muted mb-3">
                                Our Q-learning based AI model will analyze your goals and suggest the optimal way to
                                allocate your savings.
                            </p>
                            <div class="mb-3">
                                <label class="form-label">Available Savings Amount (&#8377;)</label>
                                <input type="number" class="form-control" id="availableSavings"
                                    placeholder="Enter amount you want to allocate" min="1" required>
                            </div>
                            <button onclick="getAISuggestions()" class="btn btn-primary w-100 rounded-pill">
                                <i class="bi bi-robot"></i> Get AI Suggestions
                            </button>
                        </div>

                        <div id="aiSuggestionResultSection" style="display: none;">
                            <div class="alert alert-info mb-3">
                                <i class="bi bi-lightbulb"></i>
                                <strong>AI Recommendation (Q-Learning Model):</strong>
                                Based on your goal priorities and remaining amounts, here's the optimal allocation.
                            </div>
                            <div id="suggestionTableContainer"></div>
                            <div class="mt-3">
                                <button onclick="applyAISuggestion()" class="btn btn-success w-100 rounded-pill">
                                    <i class="bi bi-check-circle"></i> Apply This Allocation
                                </button>
                                <button onclick="resetAIModal()"
                                    class="btn btn-outline-secondary w-100 rounded-pill mt-2">
                                    <i class="bi bi-arrow-left"></i> Try Different Amount
                                </button>
                            </div>
                        </div>

                        <div id="aiSuggestionLoadingSection" style="display: none;" class="text-center py-4">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-2 text-muted">AI is analyzing your goals...</p>
                        </div>

                        <div id="aiSuggestionErrorSection" style="display: none;">
                            <div class="alert alert-danger">
                                <i class="bi bi-exclamation-triangle"></i>
                                <span id="aiErrorMessage"></span>
                            </div>
                            <button onclick="resetAIModal()" class="btn btn-outline-secondary w-100 rounded-pill">
                                Try Again
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- AI Bill Scanner Modal -->
        <div class="modal fade" id="aiScanModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="bi bi-camera"></i> AI Bill Scanner</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">

                        <!-- Input Section -->
                        <div id="aiScanInputSection">
                            <p class="text-muted small mb-3">
                                Upload a photo of your bill or receipt (handwritten or printed).
                                Our AI will read the store name and total amount automatically.
                            </p>
                            <!-- Drag-and-drop / click-to-upload area -->
                            <div id="aiScanDropZone"
                                style="border: 2px dashed var(--border); border-radius: 12px; padding: 2rem; text-align: center; cursor: pointer; transition: border-color 0.2s;"
                                onclick="document.getElementById('billImageInput').click()"
                                ondragover="event.preventDefault(); this.style.borderColor='var(--primary)';"
                                ondragleave="this.style.borderColor='var(--border)';"
                                ondrop="handleScanDrop(event)">
                                <i class="bi bi-cloud-upload" style="font-size: 2.5rem; color: var(--primary);"></i>
                                <p class="mt-2 mb-0" style="color: var(--text-muted);">Click or drag &amp; drop your bill image here</p>
                                <small style="color: var(--text-muted);">Supports JPG, PNG, HEIC, WEBP</small>
                            </div>
                            <input type="file" id="billImageInput" accept="image/*" style="display: none;"
                                onchange="previewBillImage(this)">

                            <!-- Image Preview -->
                            <div id="aiScanPreviewContainer" style="display: none; margin-top: 1rem; text-align: center;">
                                <img id="aiScanPreviewImg"
                                    style="max-width: 100%; max-height: 200px; border-radius: 8px; border: 1px solid var(--border);">
                                <p id="aiScanFileName" class="mt-2 small" style="color: var(--text-muted);"></p>
                            </div>

                            <button onclick="submitBillForScan()"
                                class="btn btn-primary w-100 rounded-pill mt-3" id="aiScanBtn" disabled>
                                <i class="bi bi-robot"></i> Extract Details with AI
                            </button>
                        </div>

                        <!-- Loading Section -->
                        <div id="aiScanLoadingSection" style="display: none; text-align: center; padding: 2rem;">
                            <div class="spinner-border text-primary" role="status"></div>
                            <p class="mt-3" style="color: var(--text-muted);">AI is reading your bill...</p>
                            <small style="color: var(--text-muted);">This may take a few seconds.</small>
                        </div>

                        <!-- Error Section -->
                        <div id="aiScanErrorSection" style="display: none;">
                            <div class="alert alert-danger">
                                <i class="bi bi-exclamation-triangle"></i>
                                <span id="aiScanErrorMessage"></span>
                            </div>
                            <button onclick="resetAIScanModal()" class="btn btn-outline-secondary w-100 rounded-pill">Try Again</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>


        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // ================================================
            // SECTION SWITCHER — persists active tab in localStorage
            // ================================================
            function showSection(sectionId, linkId) {
                document.querySelectorAll('.content-section').forEach(el => el.classList.remove('active-section'));
                document.getElementById(sectionId).classList.add('active-section');
                document.querySelectorAll('.nav-link').forEach(el => el.classList.remove('active'));
                document.getElementById(linkId).classList.add('active');
                // Save active tab so page reloads restore it
                localStorage.setItem('activeSection', sectionId);
                localStorage.setItem('activeLinkId', linkId);
            }

            // Restore active tab on page load
            (function restoreTab() {
                const savedSection = localStorage.getItem('activeSection');
                const savedLink = localStorage.getItem('activeLinkId');
                if (savedSection && savedLink && document.getElementById(savedSection) && document.getElementById(savedLink)) {
                    showSection(savedSection, savedLink);
                } else {
                    showSection('dashboard', 'dashboard-link');
                }
            })();

            document.getElementById('dashboard-link').addEventListener('click', (e) => {
                e.preventDefault();
                showSection('dashboard', 'dashboard-link');
            });
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

            // ================================================
            // CHART.JS DASHBOARD INITIALIZATION
            // ================================================

            // Prepare expense data from JSP
            const expenseData = {
                labels: [],
                amounts: []
            };

            <c:forEach var="expense" items="${userExpenses}">
                expenseData.labels.push('${expense.expenseName}');
                expenseData.amounts.push(${expense.expenseAmount});
            </c:forEach>

            // Prepare budget data from JSP
            const budgetData = {
                totalBudget: 0
            };

            <c:forEach var="budget" items="${userBudgets}">
                budgetData.totalBudget += ${budget.budget_amount};
            </c:forEach>

            // Prepare goal data from JSP
            const goalData = {
                names: [],
                progress: [],
                targets: []
            };

            <c:forEach var="goal" items="${userGoals}">
                goalData.names.push('${goal.goalName}');
                var target = ${goal.target};
                // NOTE: Despite the field name, remainingAmount actually stores the PAID/ACHIEVED amount!
                var achieved = ${goal.remainingAmount != null ? goal.remainingAmount : 0};
                var percentage = target > 0 ? (achieved / target) * 100 : 0;
                goalData.progress.push(Math.min(100, Math.max(0, percentage)));
                goalData.targets.push(target);
            </c:forEach>

            // Store chart instances globally for theme switching
            let chartInstances = {};

            // Theme-aware colors function
            function getChartColors() {
                const theme = document.getElementById('html-root').getAttribute('data-bs-theme');
                const isDark = theme === 'dark';

                return {
                    textColor: isDark ? '#e8eaed' : '#202124',
                    gridColor: isDark ? '#3c4043' : '#dadce0',
                    colors: [
                        '#8ab4f8', '#81c995', '#fdd663', '#f28b82',
                        '#c58af9', '#78d9ec', '#ff8bcb', '#f9ab00'
                    ]
                };
            }

            // 1. Create Expense Donut Chart
            function createExpenseDonutChart() {
                const ctx = document.getElementById('expenseDonutChart');
                if (!ctx) return null;

                const colors = getChartColors();

                // Aggregate expenses by name
                const aggregated = {};
                for (let i = 0; i < expenseData.labels.length; i++) {
                    const name = expenseData.labels[i];
                    const amount = expenseData.amounts[i];
                    aggregated[name] = (aggregated[name] || 0) + amount;
                }

                const labels = Object.keys(aggregated);
                const data = Object.values(aggregated);

                return new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: colors.colors,
                            borderWidth: 2,
                            borderColor: colors.gridColor
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        plugins: {
                            legend: {
                                position: 'right',
                                labels: {
                                    color: colors.textColor,
                                    padding: 15,
                                    font: { size: 12 }
                                }
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        const label = context.label || '';
                                        const value = context.parsed || 0;
                                        const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                        const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                        return label + ': ₹' + value + ' (' + percentage + '%)';
                                    }
                                }
                            }
                        }
                    }
                });
            }

            // 2. Create Goal Progress Horizontal Bar Chart
            function createGoalProgressChart() {
                const ctx = document.getElementById('goalProgressChart');
                if (!ctx) return null;

                const colors = getChartColors();

                return new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: goalData.names,
                        datasets: [{
                            label: 'Completion %',
                            data: goalData.progress,
                            backgroundColor: goalData.progress.map(p =>
                                p >= 75 ? '#81c995' : p >= 50 ? '#fdd663' : '#f28b82'
                            ),
                            borderRadius: 6
                        }]
                    },
                    options: {
                        indexAxis: 'y',
                        responsive: true,
                        maintainAspectRatio: true,
                        plugins: {
                            legend: { display: false },
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        return context.parsed.x.toFixed(1) + '% complete';
                                    }
                                }
                            }
                        },
                        scales: {
                            x: {
                                ticks: { color: colors.textColor },
                                grid: { color: colors.gridColor },
                                max: 100
                            },
                            y: {
                                ticks: { color: colors.textColor },
                                grid: { display: false }
                            }
                        }
                    }
                });
            }

            // Initialize all charts
            function initializeCharts() {
                // Destroy existing charts if they exist
                Object.values(chartInstances).forEach(chart => {
                    if (chart) chart.destroy();
                });

                // Create new charts
                chartInstances.expenseDonut = createExpenseDonutChart();
                chartInstances.goalProgress = createGoalProgressChart();
            }

            // Generate AI Financial Insights
            function generateAIInsights() {
                const insights = [];

                // Safety check: ensure data is available
                if (!expenseData || !budgetData || !goalData) {
                    console.error('Data not available for insights');
                    return;
                }

                // Calculate totals
                const totalExpenses = expenseData.amounts.length > 0 ? expenseData.amounts.reduce((a, b) => a + b, 0) : 0;
                const totalBudget = budgetData.totalBudget || 0;
                const totalGoalTargets = goalData.targets.length > 0 ? goalData.targets.reduce((a, b) => a + b, 0) : 0;
                let totalGoalAchieved = 0;
                for (let i = 0; i < goalData.targets.length; i++) {
                    totalGoalAchieved += (goalData.targets[i] * goalData.progress[i]) / 100;
                }

                // Insight 1: Budget Utilization
                if (totalBudget > 0) {
                    const budgetUsed = (totalExpenses / totalBudget) * 100;
                    if (budgetUsed < 20) {
                        insights.push({
                            type: 'success',
                            icon: 'bi-check-circle-fill',
                            title: 'Excellent Budget Management',
                            description: 'You have only spent ' + budgetUsed.toFixed(1) + '% of your total budget (Rs.' + totalExpenses.toLocaleString('en-IN') + ' out of Rs.' + totalBudget.toLocaleString('en-IN') + '). You are doing great at controlling expenses!'
                        });
                    } else if (budgetUsed < 50) {
                        insights.push({
                            type: 'success',
                            icon: 'bi-check-circle',
                            title: 'Good Budget Control',
                            description: 'You have used ' + budgetUsed.toFixed(1) + '% of your budget. Keep monitoring your spending to stay on track.'
                        });
                    } else if (budgetUsed < 80) {
                        insights.push({
                            type: 'warning',
                            icon: 'bi-exclamation-triangle',
                            title: 'Moderate Budget Usage',
                            description: 'You have used ' + budgetUsed.toFixed(1) + '% of your budget. Consider reviewing non-essential expenses.'
                        });
                    } else {
                        insights.push({
                            type: 'danger',
                            icon: 'bi-exclamation-circle-fill',
                            title: 'Budget Alert',
                            description: 'You have used ' + budgetUsed.toFixed(1) + '% of your budget. Review your spending immediately to avoid overspending.'
                        });
                    }
                }

                // Insight 2: Goal Progress
                if (goalData.progress.length > 0) {
                    const avgGoalProgress = goalData.progress.reduce((a, b) => a + b, 0) / goalData.progress.length;
                    if (avgGoalProgress >= 75) {
                        insights.push({
                            type: 'success',
                            icon: 'bi-trophy-fill',
                            title: 'Outstanding Goal Achievement',
                            description: 'Your goals are ' + avgGoalProgress.toFixed(1) + '% complete on average! You are on track to achieve your financial targets.'
                        });
                    } else if (avgGoalProgress >= 50) {
                        insights.push({
                            type: 'info',
                            icon: 'bi-flag',
                            title: 'Steady Progress on Goals',
                            description: 'You have achieved ' + avgGoalProgress.toFixed(1) + '% of your goals on average. Keep up the momentum!'
                        });
                    } else if (avgGoalProgress >= 25) {
                        insights.push({
                            type: 'warning',
                            icon: 'bi-flag',
                            title: 'Goal Progress Needs Attention',
                            description: 'Your goals are ' + avgGoalProgress.toFixed(1) + '% complete. Consider increasing your savings to meet your targets faster.'
                        });
                    } else {
                        insights.push({
                            type: 'info',
                            icon: 'bi-flag',
                            title: 'Early Stage Goals',
                            description: 'You are ' + avgGoalProgress.toFixed(1) + '% towards your goals. Start saving consistently to build momentum.'
                        });
                    }
                }

                // Insight 3: Expense Pattern Analysis
                if (expenseData.labels.length > 0) {
                    // Find highest expense
                    let maxExpenseIndex = 0;
                    let maxAmount = expenseData.amounts[0];
                    for (let i = 1; i < expenseData.amounts.length; i++) {
                        if (expenseData.amounts[i] > maxAmount) {
                            maxAmount = expenseData.amounts[i];
                            maxExpenseIndex = i;
                        }
                    }
                    const maxExpensePercentage = (maxAmount / totalExpenses) * 100;

                    insights.push({
                        type: 'info',
                        icon: 'bi-pie-chart-fill',
                        title: 'Top Spending Category',
                        description: '"' + expenseData.labels[maxExpenseIndex] + '" is your highest expense at Rs.' + maxAmount.toLocaleString('en-IN') + ' (' + maxExpensePercentage.toFixed(1) + '% of total spending).'
                    });
                }

                // Insight 4: Savings Potential
                const savingsPotential = totalBudget - totalExpenses;
                if (savingsPotential > 0 && totalBudget > 0) {
                    const savingsRate = (savingsPotential / totalBudget) * 100;
                    insights.push({
                        type: 'success',
                        icon: 'bi-piggy-bank-fill',
                        title: 'Savings Opportunity',
                        description: 'You have Rs.' + savingsPotential.toLocaleString('en-IN') + ' (' + savingsRate.toFixed(1) + '% of budget) available for savings or investments. Consider allocating this towards your goals!'
                    });
                }

                // Insight 5: Goal Recommendations
                const remainingGoalAmount = totalGoalTargets - totalGoalAchieved;
                if (remainingGoalAmount > 0) {
                    insights.push({
                        type: 'info',
                        icon: 'bi-bullseye',
                        title: 'Goal Target Remaining',
                        description: 'You need Rs.' + remainingGoalAmount.toLocaleString('en-IN') + ' more to complete all your goals. Focus on your highest priority goals first!'
                    });
                }

                // Render insights
                const container = document.getElementById('aiInsightsContent');
                if (container) {
                    if (insights.length === 0) {
                        container.innerHTML = '<div class="text-center text-muted py-4"><i class="bi bi-info-circle me-2"></i>Add expenses, budgets, and goals to see AI-powered insights!</div>';
                        return;
                    }

                    let html = '';
                    insights.forEach(function(insight) {
                        let iconColor = 'var(--primary)';
                        if (insight.type === 'success') iconColor = '#81c995';
                        else if (insight.type === 'warning') iconColor = '#fdd663';
                        else if (insight.type === 'danger') iconColor = '#f28b82';

                        html += '<div class="insight-card ' + insight.type + '">';
                        html += '<div class="insight-title">';
                        html += '<i class="insight-icon ' + insight.icon + '" style="color: ' + iconColor + '"></i>';
                        html += insight.title;
                        html += '</div>';
                        html += '<div class="insight-description">' + insight.description + '</div>';
                        html += '</div>';
                    });
                    container.innerHTML = html;
                }
            }

            // Initialize charts and insights when DOM is ready
            document.addEventListener('DOMContentLoaded', function () {
                initializeCharts();
                generateAIInsights();
            });

            // Re-render charts and insights on theme change
            const themeToggleBtn = document.getElementById('themeToggle');
            if (themeToggleBtn) {
                const originalOnClick = themeToggleBtn.onclick;
                themeToggleBtn.addEventListener('click', function () {
                    setTimeout(() => {
                        initializeCharts();
                        generateAIInsights();
                    }, 100);
                });
            }

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

            // ================================================
            // DELETE FUNCTIONS — use DELETE method + path variable
            // ================================================
            function deleteGoal(id) {
                if (confirm('Are you sure you want to delete this goal?')) {
                    fetch('/home/goalsetter/delete/' + id, { method: 'DELETE' })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                window.location.reload();
                            } else {
                                alert('Failed to delete goal. Please try again.');
                            }
                        })
                        .catch(() => alert('Error deleting goal. Please try again.'));
                }
            }
            function deleteBudget(id) {
                if (confirm('Delete this budget?')) {
                    fetch('/home/budgetplanner/delete/' + id, { method: 'DELETE' })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                window.location.reload();
                            } else {
                                alert('Failed to delete budget. Please try again.');
                            }
                        })
                        .catch(() => alert('Error deleting budget. Please try again.'));
                }
            }
            function deleteExpense(id) {
                if (confirm('Delete this expense?')) {
                    fetch('/home/expensetracker/delete/' + id, { method: 'DELETE' })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                window.location.reload();
                            } else {
                                alert('Failed to delete expense. Please try again.');
                            }
                        })
                        .catch(() => alert('Error deleting expense. Please try again.'));
                }
            }

            // ================================================
            // PAYMENT FORM HANDLERS — use AJAX instead of HTML form POST
            // ================================================
            document.getElementById('paymentForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const goalId = document.getElementById('goalId').value;
                const paymentAmount = document.getElementById('paymentAmount').value;
                const formData = new URLSearchParams();
                formData.append('goalId', goalId);
                formData.append('paymentAmount', paymentAmount);

                fetch('/home/goalsetter/payment', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData.toString()
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            bootstrap.Modal.getInstance(document.getElementById('paymentModal')).hide();
                            window.location.reload();
                        } else {
                            alert('Payment failed: ' + (data.error || 'Unknown error'));
                        }
                    })
                    .catch(() => alert('Error processing payment. Please try again.'));
            });

            document.getElementById('paymentBudgetForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const budgetId = document.getElementById('budgetId').value;
                const budgetAmount = document.getElementById('budgetAmount').value;
                const formData = new URLSearchParams();
                formData.append('budgetId', budgetId);
                formData.append('budgetAmount', budgetAmount);

                fetch('/home/budgetplanner/payment', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData.toString()
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            bootstrap.Modal.getInstance(document.getElementById('paymentBudgetModal')).hide();
                            window.location.reload();
                        } else {
                            alert('Update failed: ' + (data.error || 'Unknown error'));
                        }
                    })
                    .catch(() => alert('Error updating budget. Please try again.'));
            });

            // ================================================
            // CREATE FORM HANDLERS — AJAX (no page redirect, tab preserved)
            // ================================================
            document.getElementById('goalForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const formData = new URLSearchParams();
                formData.append('goalname', document.getElementById('goalname').value);
                formData.append('target', document.getElementById('goalTarget').value);
                formData.append('priority', document.getElementById('goalPriority').value);

                fetch('/home/goalsetter', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData.toString()
                })
                    .then(response => {
                        if (response.ok || response.redirected) {
                            bootstrap.Modal.getInstance(document.getElementById('addGoalModal')).hide();
                            this.reset();
                            window.location.reload();
                        } else {
                            alert('Failed to create goal. Please try again.');
                        }
                    })
                    .catch(() => alert('Error creating goal. Please try again.'));
            });

            document.getElementById('budgetForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const formData = new URLSearchParams();
                formData.append('budgetName', document.getElementById('budgetName').value);
                formData.append('budgetAmount', document.getElementById('newBudgetAmount').value);

                fetch('/home/budgetplanner', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData.toString()
                })
                    .then(response => {
                        if (response.ok || response.redirected) {
                            bootstrap.Modal.getInstance(document.getElementById('addBudgetModal')).hide();
                            this.reset();
                            window.location.reload();
                        } else {
                            alert('Failed to create budget. Please try again.');
                        }
                    })
                    .catch(() => alert('Error creating budget. Please try again.'));
            });

            document.getElementById('expenseForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const formData = new URLSearchParams();
                formData.append('expenseName', document.getElementById('expenseName').value);
                formData.append('expenseAmount', document.getElementById('newExpenseAmount').value);

                fetch('/home/expensetracker', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData.toString()
                })
                    .then(response => {
                        if (response.ok || response.redirected) {
                            bootstrap.Modal.getInstance(document.getElementById('addExpenseModal')).hide();
                            this.reset();
                            window.location.reload();
                        } else {
                            alert('Failed to add expense. Please try again.');
                        }
                    })
                    .catch(() => alert('Error adding expense. Please try again.'));
            });

            document.getElementById('paymentExpenseForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const expenseId = document.getElementById('expenseId').value;
                const expenseAmount = document.getElementById('expenseAmount').value;
                const formData = new URLSearchParams();
                formData.append('expenseId', expenseId);
                formData.append('expenseAmount', expenseAmount);

                fetch('/home/expensetracker/payment', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData.toString()
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            bootstrap.Modal.getInstance(document.getElementById('paymentExpenseModal')).hide();
                            window.location.reload();
                        } else {
                            alert('Update failed: ' + (data.error || 'Unknown error'));
                        }
                    })
                    .catch(() => alert('Error updating expense. Please try again.'));
            });

            // ================================================
            // AI PREDICTION LOGIC
            // ================================================
            document.getElementById('predictForm').addEventListener('submit', function (event) {
                event.preventDefault();
                // Show loading state
                const btn = document.getElementById('predictBtn');
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Predicting...';

                const formData = new URLSearchParams(new FormData(this)).toString();

                fetch('/home/budgetplanner/predict', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData
                })
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('predictBtn').disabled = false;
                        document.getElementById('predictBtn').innerHTML = '<i class="bi bi-stars"></i> Generate Prediction';
                        if (data.success) {
                            const roundedData = roundValues(data.data);
                            showTable(roundedData);
                            const resultModal = new bootstrap.Modal(document.getElementById('responseModal'));
                            resultModal.show();
                        } else {
                            alert('Prediction Error: ' + (data.error || 'Could not connect to the AI model. Make sure the Python API is running on port 5000.'));
                        }
                    })
                    .catch(error => {
                        document.getElementById('predictBtn').disabled = false;
                        document.getElementById('predictBtn').innerHTML = '<i class="bi bi-stars"></i> Generate Prediction';
                        console.error('Error:', error);
                        alert('Network error: Could not reach the prediction service. Please ensure the Python API is running.');
                    });
            });

            // Store prediction data globally for PDF export
            let _lastPredictionData = {};
            let _lastPredictionInput = {};

            function showTable(data) {
                _lastPredictionData = data;
                const modalContent = document.getElementById('modalContent');

                // Category display config
                const categoryConfig = {
                    'Rent': { icon: '\uD83C\uDFE0', label: 'Rent / Housing' },
                    'Groceries': { icon: '\uD83D\uDED2', label: 'Groceries' },
                    'Transport': { icon: '\uD83D\uDE97', label: 'Transport' },
                    'Eating_Out': { icon: '\uD83C\uDF7D', label: 'Eating Out' },
                    'Entertainment': { icon: '\uD83C\uDFAD', label: 'Entertainment' },
                    'Utilities': { icon: '\uD83D\uDCA1', label: 'Utilities' },
                    'Healthcare': { icon: '\uD83C\uDFE5', label: 'Healthcare' },
                    'Education': { icon: '\uD83D\uDCDA', label: 'Education' },
                    'Desired_Savings': { icon: '\uD83D\uDCB0', label: 'Recommended Savings' }
                };

                var rowsHtml = '';
                Object.entries(data).forEach(function (entry) {
                    var key = entry[0], value = entry[1];
                    var cfg = categoryConfig[key] || { icon: '\uD83D\uDCCA', label: key.replace(/_/g, ' ') };
                    var isSavings = key === 'Desired_Savings';
                    var formatted = '\u20B9 ' + Number(value).toLocaleString('en-IN');
                    var rowStyle = isSavings ? 'background:linear-gradient(90deg,#0f4c3a,#1a7a5e);color:#fff;font-weight:700;' : '';
                    var amtContent = isSavings ? '<span style="color:#4fffb0">' + formatted + '</span>' : formatted;
                    rowsHtml += '<tr style="' + rowStyle + '">' +
                        '<td style="padding:12px 16px;border-bottom:1px solid #2a2a3a;">' +
                        '<span style="font-size:1.1rem;margin-right:8px;">' + cfg.icon + '</span>' + cfg.label +
                        '</td>' +
                        '<td style="padding:12px 16px;text-align:right;font-weight:600;border-bottom:1px solid #2a2a3a;font-family:monospace;font-size:1rem;">' +
                        amtContent + '</td></tr>';
                });

                modalContent.innerHTML =
                    '<div style="font-family:\'Inter\',sans-serif;color:#e8eaed;">' +
                    '<div style="display:flex;align-items:center;margin-bottom:20px;padding-bottom:16px;border-bottom:2px solid #2a2a3a;">' +
                    '<div style="background:linear-gradient(135deg,#4fffb0,#00b4ff);width:42px;height:42px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.4rem;margin-right:14px;flex-shrink:0;">\uD83E\uDD16</div>' +
                    '<div>' +
                    '<div style="font-size:1.1rem;font-weight:700;color:#fff;">AI Budget Allocation</div>' +
                    '<div style="font-size:0.8rem;color:#9aa0a6;margin-top:2px;">Personalized monthly spending forecast</div>' +
                    '</div></div>' +
                    '<table style="width:100%;border-collapse:collapse;">' +
                    '<thead><tr style="background:#1a1a2e;">' +
                    '<th style="padding:12px 16px;text-align:left;font-size:0.75rem;text-transform:uppercase;letter-spacing:0.08em;color:#9aa0a6;border-bottom:2px solid #4fffb0;">Category</th>' +
                    '<th style="padding:12px 16px;text-align:right;font-size:0.75rem;text-transform:uppercase;letter-spacing:0.08em;color:#9aa0a6;border-bottom:2px solid #4fffb0;">Recommended Amount</th>' +
                    '</tr></thead><tbody>' + rowsHtml + '</tbody></table>' +
                    '<p style="font-size:0.72rem;color:#5f6368;margin-top:16px;text-align:center;">' +
                    '\u26A0\uFE0F This is an AI-generated estimate based on your financial profile. Actual allocations may vary.' +
                    '</p></div>';
            }

            // Legacy functions kept for backwards compatibility (now handled by Bootstrap Modal)
            function openModal() {
                // No-op: handled by Bootstrap Modal API in the fetch callback
            }

            function closeModal() {
                const el = document.getElementById('responseModal');
                const m = bootstrap.Modal.getInstance(el);
                if (m) m.hide();
            }

            function roundValues(data) {
                for (let key in data) {
                    if (typeof data[key] === 'number') {
                        data[key] = Math.round(data[key]);
                    }
                }
                return data;
            }

            function downloadAsPDF() {
                var jsPDFLib = window.jspdf;
                var doc = new jsPDFLib.jsPDF({ orientation: 'portrait', unit: 'mm', format: 'a4' });

                var pageW = 210;
                var pageH = 297;
                var mL = 16;   // left margin
                var mR = 16;   // right margin
                var cW = pageW - mL - mR; // content width
                var rX = pageW - mR;      // right edge of content

                // ── Safe Indian number formatter (ASCII only, no Unicode spaces) ────
                function fmtINR(n) {
                    n = Math.round(Number(n));
                    if (isNaN(n)) return 'Rs. 0';
                    var s = Math.abs(n).toString();
                    if (s.length <= 3) return 'Rs. ' + s;
                    var last3 = s.slice(-3);
                    var rest = s.slice(0, -3);
                    var parts = [];
                    while (rest.length > 2) { parts.unshift(rest.slice(-2)); rest = rest.slice(0, -2); }
                    if (rest.length) parts.unshift(rest);
                    return 'Rs. ' + parts.join(',') + ',' + last3;
                }

                // ── Date (ASCII-safe) ─────────────────────────────────────────────
                var d = new Date();
                var mo = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                var dateStr = d.getDate() + ' ' + mo[d.getMonth()] + ' ' + d.getFullYear();

                // ── Ordered label map ─────────────────────────────────────────────
                var labelMap = {
                    'Rent': 'Rent / Housing', 'Groceries': 'Groceries', 'Transport': 'Transport',
                    'Eating_Out': 'Eating Out', 'Entertainment': 'Entertainment', 'Utilities': 'Utilities',
                    'Healthcare': 'Healthcare', 'Education': 'Education', 'Desired_Savings': 'Recommended Savings'
                };
                var order = ['Rent', 'Groceries', 'Transport', 'Eating_Out', 'Entertainment', 'Utilities', 'Healthcare', 'Education', 'Desired_Savings'];
                var data = _lastPredictionData;
                var sortedEntries = [];
                order.forEach(function (k) { if (data[k] !== undefined) sortedEntries.push([k, data[k]]); });
                Object.keys(data).forEach(function (k) { if (order.indexOf(k) < 0) sortedEntries.push([k, data[k]]); });

                // ══════════════════════════════════════════════════════════════════
                // HEADER
                // ══════════════════════════════════════════════════════════════════
                // Main header bar
                doc.setFillColor(17, 45, 60);
                doc.rect(0, 0, pageW, 40, 'F');
                // Thin emerald accent strip at bottom of header
                doc.setFillColor(16, 185, 129);
                doc.rect(0, 37, pageW, 3, 'F');

                // Logo / brand
                doc.setFont('helvetica', 'bold');
                doc.setFontSize(19);
                doc.setTextColor(255, 255, 255);
                doc.text('NextGen Finance', mL, 17);

                doc.setFont('helvetica', 'normal');
                doc.setFontSize(9.5);
                doc.setTextColor(130, 200, 170);
                doc.text('AI Financial Budget Report', mL, 26);

                doc.setFontSize(8);
                doc.setTextColor(100, 160, 140);
                doc.text('Generated: ' + dateStr, mL, 33);

                // Right-side metadata
                doc.setFont('helvetica', 'bold');
                doc.setFontSize(8);
                doc.setTextColor(200, 230, 215);
                doc.text('PERSONAL USE ONLY', rX, 17, { align: 'right' });
                doc.setFont('helvetica', 'normal');
                doc.setTextColor(100, 160, 140);
                doc.text('AI-generated estimate', rX, 24, { align: 'right' });

                // ══════════════════════════════════════════════════════════════════
                // BODY
                // ══════════════════════════════════════════════════════════════════
                var y = 52;

                // Section heading
                doc.setFont('helvetica', 'bold');
                doc.setFontSize(12);
                doc.setTextColor(20, 40, 55);
                doc.text('Monthly Budget Allocation', mL, y);
                y += 2;
                // Short accent underline
                doc.setDrawColor(16, 185, 129);
                doc.setLineWidth(0.7);
                doc.line(mL, y, mL + 55, y);
                y += 6;

                doc.setFont('helvetica', 'normal');
                doc.setFontSize(8);
                doc.setTextColor(100, 110, 125);
                doc.text('Personalized spending forecast based on your financial profile', mL, y);
                y += 8;

                // ── Column header row ─────────────────────────────────────────────
                var rowH = 9;
                doc.setFillColor(30, 41, 59);
                doc.rect(mL, y, cW, rowH + 1, 'F');
                doc.setFont('helvetica', 'bold');
                doc.setFontSize(7.5);
                doc.setTextColor(148, 163, 184);
                doc.text('EXPENSE CATEGORY', mL + 5, y + 6.2);
                doc.text('AMOUNT (Rs.)', rX - 5, y + 6.2, { align: 'right' });
                y += rowH + 2;

                // ── Data rows (skip Desired_Savings) ─────────────────────────────
                var totalExpenses = 0;
                var savingsAmount = 0;
                var rowIdx = 0;

                sortedEntries.forEach(function (pair) {
                    var key = pair[0];
                    var value = pair[1];
                    var amount = Number(value);
                    var label = labelMap[key] || key.replace(/_/g, ' ');

                    if (key === 'Desired_Savings') {
                        savingsAmount = amount;
                        return; // draw after total
                    }

                    totalExpenses += amount;

                    // Alternating background
                    if (rowIdx % 2 === 0) {
                        doc.setFillColor(247, 249, 252);
                        doc.rect(mL, y, cW, rowH, 'F');
                    } else {
                        doc.setFillColor(255, 255, 255);
                        doc.rect(mL, y, cW, rowH, 'F');
                    }

                    // Left-side category indicator bar
                    doc.setFillColor(16, 185, 129);
                    doc.rect(mL, y, 2.5, rowH, 'F');

                    // Category label
                    doc.setFont('helvetica', 'normal');
                    doc.setFontSize(9);
                    doc.setTextColor(35, 50, 65);
                    doc.text(label, mL + 7, y + 6);

                    // Amount — right-aligned, bold
                    doc.setFont('helvetica', 'bold');
                    doc.setTextColor(20, 30, 50);
                    doc.text(fmtINR(amount), rX - 5, y + 6, { align: 'right' });

                    // Bottom rule
                    doc.setDrawColor(220, 228, 236);
                    doc.setLineWidth(0.15);
                    doc.line(mL, y + rowH, rX, y + rowH);

                    y += rowH;
                    rowIdx++;
                });

                // ── Total Expenses bar ────────────────────────────────────────────
                y += 5;
                doc.setFillColor(30, 64, 175);
                doc.roundedRect(mL, y, cW, 11, 1.5, 1.5, 'F');
                doc.setFont('helvetica', 'bold');
                doc.setFontSize(9.5);
                doc.setTextColor(255, 255, 255);
                doc.text('Total Projected Expenses', mL + 6, y + 7.5);
                doc.text(fmtINR(totalExpenses), rX - 6, y + 7.5, { align: 'right' });
                y += 15;

                // ── Recommended Savings bar ───────────────────────────────────────
                if (savingsAmount > 0) {
                    // Fill light green
                    doc.setFillColor(236, 253, 245);
                    doc.roundedRect(mL, y, cW, 11, 1.5, 1.5, 'F');
                    // Green border
                    doc.setDrawColor(16, 185, 129);
                    doc.setLineWidth(0.6);
                    doc.roundedRect(mL, y, cW, 11, 1.5, 1.5, 'S');
                    // Text
                    doc.setFont('helvetica', 'bold');
                    doc.setFontSize(9.5);
                    doc.setTextColor(6, 95, 70);
                    doc.text('Recommended Savings', mL + 6, y + 7.5);
                    doc.text(fmtINR(savingsAmount), rX - 6, y + 7.5, { align: 'right' });
                    y += 15;
                }

                // ── Disclaimer ────────────────────────────────────────────────────
                y += 6;
                doc.setDrawColor(215, 222, 232);
                doc.setLineWidth(0.25);
                doc.line(mL, y, rX, y);
                y += 6;

                doc.setFont('helvetica', 'italic');
                doc.setFontSize(7.5);
                doc.setTextColor(130, 140, 155);
                doc.text('This report is generated by the NextGen Finance AI model based on the inputs provided.', pageW / 2, y, { align: 'center' });
                doc.text('Figures are projections only. Consult a certified financial advisor for guidance.', pageW / 2, y + 5, { align: 'center' });

                // ── Page footer ───────────────────────────────────────────────────
                doc.setFont('helvetica', 'normal');
                doc.setFontSize(7);
                doc.setTextColor(170, 178, 190);
                doc.text('NextGen Finance Platform  |  AI Budget Report  |  Page 1 of 1', pageW / 2, pageH - 9, { align: 'center' });

                // Bottom dark bar
                doc.setFillColor(17, 45, 60);
                doc.rect(0, pageH - 4, pageW, 4, 'F');

                doc.save('NextGenFinance-Budget-' + dateStr.replace(/ /g, '-') + '.pdf');
            }


            function printTable() {
                var data = _lastPredictionData;
                var labelMap = {
                    'Rent': 'Rent / Housing', 'Groceries': 'Groceries', 'Transport': 'Transport',
                    'Eating_Out': 'Eating Out', 'Entertainment': 'Entertainment', 'Utilities': 'Utilities',
                    'Healthcare': 'Healthcare', 'Education': 'Education', 'Desired_Savings': 'Recommended Savings'
                };
                var order = ['Rent', 'Groceries', 'Transport', 'Eating_Out', 'Entertainment', 'Utilities', 'Healthcare', 'Education'];

                var totalExpenses = 0;
                var rows = '';
                var rowIdx = 0;

                function fmt(n) {
                    n = Math.round(Number(n));
                    if (isNaN(n)) return 'Rs. 0';
                    var s = Math.abs(n).toString();
                    if (s.length <= 3) return 'Rs. ' + s;
                    var last3 = s.slice(-3);
                    var rest = s.slice(0, -3);
                    var parts = [];
                    while (rest.length > 2) { parts.unshift(rest.slice(-2)); rest = rest.slice(0, -2); }
                    if (rest.length) parts.unshift(rest);
                    return 'Rs. ' + parts.join(',') + ',' + last3;
                }

                // Normal expense rows
                order.forEach(function (key) {
                    if (data[key] !== undefined) {
                        var amount = Number(data[key]);
                        totalExpenses += amount;
                        var bg = (rowIdx % 2 === 0) ? '#f8fafc' : '#ffffff';
                        rows += '<tr style="background:' + bg + ';"><td>' + labelMap[key] + '</td><td style="text-align:right;font-weight:600;">' + fmt(amount) + '</td></tr>';
                        rowIdx++;
                    }
                });

                // Total Row
                rows += '<tr style="background:#1e40af;color:#ffffff;font-weight:700;"><td style="padding:12px 14px;">TOTAL PROJECTED EXPENSES</td><td style="text-align:right;padding:12px 14px;">' + fmt(totalExpenses) + '</td></tr>';

                // Savings Row (if exists)
                if (data['Desired_Savings'] !== undefined) {
                    var savings = Number(data['Desired_Savings']);
                    rows += '<tr style="background:#ecfdf5;color:#065f46;font-weight:700;border:2px solid #10b981;"><td>RECOMMENDED SAVINGS</td><td style="text-align:right;">' + fmt(savings) + '</td></tr>';
                }

                var now = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'long', year: 'numeric' });
                var printWindow = window.open('', '', 'height=800,width=900');
                var html = '<!DOCTYPE html><html><head><title>NextGen Finance Report</title>' +
                    '<style>' +
                    '@import url(\'https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap\');' +
                    'body{font-family:\'Inter\',sans-serif;margin:0;padding:20px;color:#1e293b;line-height:1.5;}' +
                    '.header{background:#112d3c;color:white;padding:30px;border-radius:8px 8px 0 0;border-bottom:4px solid #10b981;}' +
                    '.header h1{margin:0;font-size:24px;letter-spacing:-0.02em;}' +
                    '.header p{margin:5px 0 0;font-size:13px;color:#82c8aa;opacity:0.9;}' +
                    '.content{background:white;padding:30px;border:1px solid #e2e8f0;border-top:none;border-radius:0 0 8px 8px;}' +
                    '.section-title{font-size:18px;font-weight:700;color:#0f172a;margin-bottom:20px;display:inline-block;border-bottom:2px solid #10b981;padding-bottom:4px;}' +
                    'table{width:100%;border-collapse:collapse;margin:20px 0;border:1px solid #e2e8f0;}' +
                    'th{background:#1e293b;color:#f8fafc;padding:12px 15px;text-align:left;font-size:11px;text-transform:uppercase;letter-spacing:0.05em;}' +
                    'td{padding:12px 15px;font-size:14px;border-bottom:1px solid #e2e8f0;}' +
                    '.footer{margin-top:40px;text-align:center;font-size:12px;color:#64748b;border-top:1px solid #e2e8f0;padding-top:20px;}' +
                    '@media print{body{padding:0;}.header{-webkit-print-color-adjust:exact;}}' +
                    '</style></head><body>' +
                    '<div class="header"><h1>NextGen Finance</h1><p>AI Budget Prediction Report &nbsp;|&nbsp; ' + now + '</p></div>' +
                    '<div class="content">' +
                    '<div class="section-title">Monthly Budget Allocation</div>' +
                    '<table><thead><tr><th>EXPENSE CATEGORY</th><th style="text-align:right">RECOMMENDED AMOUNT</th></tr></thead>' +
                    '<tbody>' + rows + '</tbody></table>' +
                    '<div class="footer">This report was generated by the NextGen Finance AI model.<br><strong>Confidentially prepared for user</strong></div>' +
                    '</div></body></html>';

                printWindow.document.write(html);
                printWindow.document.close();
                printWindow.focus();
                setTimeout(function () { printWindow.print(); }, 500);
            }

            // ================================================
            // AI GOAL ALLOCATION SYSTEM (Q-Learning RL)
            // ================================================

            let currentAISuggestion = null;

            function openAISuggestionModal() {
                // Check if user has at least 2 goals
                const goalTable = document.querySelector('#goal-setter tbody');
                const goalRows = goalTable.querySelectorAll('tr');

                if (goalRows.length < 2) {
                    alert('You need at least 2 goals to get AI allocation suggestions.\n\nPlease create more goals first!');
                    return;
                }

                resetAIModal();
                const modal = new bootstrap.Modal(document.getElementById('aiSuggestionModal'));
                modal.show();
            }

            function resetAIModal() {
                document.getElementById('aiSuggestionInputSection').style.display = 'block';
                document.getElementById('aiSuggestionResultSection').style.display = 'none';
                document.getElementById('aiSuggestionLoadingSection').style.display = 'none';
                document.getElementById('aiSuggestionErrorSection').style.display = 'none';
                document.getElementById('availableSavings').value = '';
                currentAISuggestion = null;
            }

            async function getAISuggestions() {
                const savingsAmount = document.getElementById('availableSavings').value;

                if (!savingsAmount || savingsAmount <= 0) {
                    alert('Please enter a valid savings amount');
                    return;
                }

                // Show loading
                document.getElementById('aiSuggestionInputSection').style.display = 'none';
                document.getElementById('aiSuggestionLoadingSection').style.display = 'block';

                try {
                    const response = await fetch('/home/goals/suggest?savings=' + savingsAmount, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    });

                    const data = await response.json();

                    if (data.success) {
                        currentAISuggestion = {
                            totalSavings: data.totalSavings,
                            suggestions: data.suggestions
                        };
                        displayAISuggestions(data);
                    } else {
                        showAIError(data.error || 'Failed to get AI suggestions');
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showAIError('Failed to connect to AI service. Make sure Python API is running on port 5001.');
                }
            }

            function displayAISuggestions(data) {
                document.getElementById('aiSuggestionLoadingSection').style.display = 'none';
                document.getElementById('aiSuggestionResultSection').style.display = 'block';

                const suggestions = data.suggestions;
                let tableHTML = '<table class="table table-bordered">';
                tableHTML += '<thead><tr>';
                tableHTML += '<th>Goal Name</th>';
                tableHTML += '<th>Recommended %</th>';
                tableHTML += '<th>Recommended Amount</th>';
                tableHTML += '</tr></thead><tbody>';

                let totalPercent = 0;

                for (const goalName in suggestions) {
                    const suggestion = suggestions[goalName];
                    const percentage = suggestion.percentage;
                    const amount = suggestion.amount;

                    totalPercent += percentage;

                    tableHTML += '<tr>';
                    tableHTML += '<td><strong>' + goalName + '</strong></td>';
                    tableHTML += '<td><span class="badge bg-primary">' + percentage.toFixed(1) + '%</span></td>';
                    tableHTML += '<td><strong>&#8377; ' + Math.round(amount).toLocaleString('en-IN') + '</strong></td>';
                    tableHTML += '</tr>';
                }

                tableHTML += '</tbody>';
                tableHTML += '<tfoot><tr class="table-active">';
                tableHTML += '<td><strong>Total</strong></td>';
                tableHTML += '<td><strong>' + totalPercent.toFixed(1) + '%</strong></td>';
                tableHTML += '<td><strong>&#8377; ' + data.totalSavings.toLocaleString('en-IN') + '</strong></td>';
                tableHTML += '</tr></tfoot>';
                tableHTML += '</table>';

                tableHTML += '<div class="alert alert-success mt-3">';
                tableHTML += '<i class="bi bi-info-circle"></i> ';
                tableHTML += '<strong>How it works:</strong> Our Q-learning reinforcement learning model ';
                tableHTML += 'analyzed your goal priorities and remaining amounts to find the optimal distribution ';
                tableHTML += 'that maximizes your chances of achieving all goals efficiently.';
                tableHTML += '</div>';

                document.getElementById('suggestionTableContainer').innerHTML = tableHTML;
            }

            function showAIError(errorMessage) {
                document.getElementById('aiSuggestionLoadingSection').style.display = 'none';
                document.getElementById('aiSuggestionErrorSection').style.display = 'block';
                document.getElementById('aiErrorMessage').textContent = errorMessage;
            }

            async function applyAISuggestion() {
                if (!currentAISuggestion) {
                    alert('No suggestion to apply');
                    return;
                }

                if (!confirm('This will update your goal contributions. Continue?')) {
                    return;
                }

                try {
                    // Prepare allocation data
                    const allocation = {};
                    for (const goalName in currentAISuggestion.suggestions) {
                        allocation[goalName] = currentAISuggestion.suggestions[goalName].amount;
                    }

                    const response = await fetch('/home/goals/apply-suggestion', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(allocation)
                    });

                    const data = await response.json();

                    if (data.success) {
                        alert('✅ AI allocation applied successfully!\n\nYour goals have been updated.');
                        location.reload(); // Reload to show updated goals
                    } else {
                        alert('Failed to apply allocation: ' + (data.error || 'Unknown error'));
                    }
                } catch (error) {
                    console.error('Error:', error);
                    alert('Failed to apply allocation');
                }
            }

            // ================================================
            // AI BILL SCANNER FUNCTIONS
            // ================================================

            function openAIScanModal() {
                resetAIScanModal();
                new bootstrap.Modal(document.getElementById('aiScanModal')).show();
            }

            function resetAIScanModal() {
                document.getElementById('aiScanInputSection').style.display = 'block';
                document.getElementById('aiScanLoadingSection').style.display = 'none';
                document.getElementById('aiScanErrorSection').style.display = 'none';
                document.getElementById('aiScanPreviewContainer').style.display = 'none';
                document.getElementById('aiScanDropZone').style.borderColor = 'var(--border)';
                document.getElementById('billImageInput').value = '';
                document.getElementById('aiScanBtn').disabled = true;
            }

            function previewBillImage(input) {
                if (input.files && input.files[0]) {
                    const file = input.files[0];
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('aiScanPreviewImg').src = e.target.result;
                        document.getElementById('aiScanFileName').textContent = file.name + ' (' + (file.size / 1024).toFixed(1) + ' KB)';
                        document.getElementById('aiScanPreviewContainer').style.display = 'block';
                        document.getElementById('aiScanDropZone').style.borderColor = 'var(--primary)';
                        document.getElementById('aiScanBtn').disabled = false;
                    };
                    reader.readAsDataURL(file);
                }
            }

            function handleScanDrop(event) {
                event.preventDefault();
                document.getElementById('aiScanDropZone').style.borderColor = 'var(--border)';
                const files = event.dataTransfer.files;
                if (files.length > 0) {
                    // Assign the dropped file to the input and trigger preview
                    const dataTransfer = new DataTransfer();
                    dataTransfer.items.add(files[0]);
                    const input = document.getElementById('billImageInput');
                    input.files = dataTransfer.files;
                    previewBillImage(input);
                }
            }

            async function submitBillForScan() {
                const input = document.getElementById('billImageInput');
                if (!input.files || input.files.length === 0) {
                    alert('Please select a bill image first.');
                    return;
                }

                // Show loading state
                document.getElementById('aiScanInputSection').style.display = 'none';
                document.getElementById('aiScanLoadingSection').style.display = 'block';

                try {
                    const formData = new FormData();
                    formData.append('billImage', input.files[0]);

                    const response = await fetch('/home/expensetracker/ai-scan', {
                        method: 'POST',
                        body: formData
                        // Do NOT set Content-Type header — browser sets it automatically with boundary for multipart
                    });

                    const data = await response.json();

                    if (data.success) {
                        // Close the scan modal
                        const scanModal = bootstrap.Modal.getInstance(document.getElementById('aiScanModal'));
                        if (scanModal) scanModal.hide();

                        // Small delay to let scan modal close cleanly before opening expense modal
                        setTimeout(function() {
                            // Pre-fill the existing New Expense modal with the AI-extracted data
                            document.getElementById('expenseName').value = data.expenseName || '';
                            document.getElementById('newExpenseAmount').value = data.expenseAmount || '';

                            // Open the New Expense modal for user verification
                            new bootstrap.Modal(document.getElementById('addExpenseModal')).show();
                        }, 400);

                    } else {
                        // Show error
                        document.getElementById('aiScanLoadingSection').style.display = 'none';
                        document.getElementById('aiScanErrorSection').style.display = 'block';
                        document.getElementById('aiScanErrorMessage').textContent = data.error || 'AI could not extract details from this image.';
                    }

                } catch (error) {
                    console.error('AI Scan error:', error);
                    document.getElementById('aiScanLoadingSection').style.display = 'none';
                    document.getElementById('aiScanErrorSection').style.display = 'block';
                    document.getElementById('aiScanErrorMessage').textContent = 'Network error. Please ensure the server is running.';
                }
            }

            // Theme Toggle Functionality
            (function() {
                const htmlRoot = document.getElementById('html-root');
                const themeToggleBtn = document.getElementById('themeToggle');
                const themeIcon = document.getElementById('themeIcon');
                const themeText = document.getElementById('themeText');

                // Load saved theme or default to dark
                const savedTheme = localStorage.getItem('theme') || 'dark';
                htmlRoot.setAttribute('data-bs-theme', savedTheme);
                updateThemeIcon(savedTheme);

                // Toggle theme on button click
                themeToggleBtn.addEventListener('click', function() {
                    const currentTheme = htmlRoot.getAttribute('data-bs-theme');
                    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';

                    htmlRoot.setAttribute('data-bs-theme', newTheme);
                    localStorage.setItem('theme', newTheme);
                    updateThemeIcon(newTheme);
                });

                // Update icon and text based on current theme
                function updateThemeIcon(theme) {
                    if (themeIcon && themeText) {
                        if (theme === 'dark') {
                            themeIcon.className = 'bi bi-sun-fill';
                            themeText.textContent = 'Light Mode';
                        } else {
                            themeIcon.className = 'bi bi-moon-fill';
                            themeText.textContent = 'Dark Mode';
                        }
                    }
                }
            })();

        </script>
    </body>

    </html>