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

            /* Date input wrapper */
            .date-input-wrapper {
                position: relative;
            }

            .date-filter-input {
                cursor: pointer;
            }

            /* Make mm/dd/yyyy INVISIBLE (transparent) */
            .date-filter-input::-webkit-datetime-edit-text,
            .date-filter-input::-webkit-datetime-edit-month-field,
            .date-filter-input::-webkit-datetime-edit-day-field,
            .date-filter-input::-webkit-datetime-edit-year-field {
                color: transparent !important;
            }

            /* Show actual date when selected */
            .date-filter-input:valid::-webkit-datetime-edit-text,
            .date-filter-input:valid::-webkit-datetime-edit-month-field,
            .date-filter-input:valid::-webkit-datetime-edit-day-field,
            .date-filter-input:valid::-webkit-datetime-edit-year-field {
                color: var(--text-main) !important;
            }

            /* "From Date" / "To Date" LABEL - clickable */
            .date-placeholder {
                position: absolute;
                left: 0;
                right: 0;
                top: 0;
                bottom: 0;
                display: flex;
                align-items: center;
                padding-left: 12px;
                color: #9aa0a6;
                font-size: 1rem;
                pointer-events: none;
                z-index: 1;
            }

            /* Hide when date selected */
            .date-filter-input:valid + .date-placeholder {
                display: none;
            }

            /* Calendar icon */
            .date-filter-input::-webkit-calendar-picker-indicator {
                position: relative;
                z-index: 2;
                cursor: pointer;
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

            /* Chatbot Styles */
            .chat-button {
                position: fixed;
                bottom: 2rem;
                right: 2rem;
                width: 60px;
                height: 60px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--primary), var(--primary-hover));
                border: none;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s;
                z-index: 1000;
            }

            .chat-button:hover {
                transform: scale(1.1);
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.4);
            }

            .chat-button i {
                font-size: 28px;
                color: #ffffff;
            }

            .chat-modal {
                position: fixed;
                bottom: 5rem;
                right: 2rem;
                width: 400px;
                height: 600px;
                background-color: var(--surface);
                border: 1px solid var(--border);
                border-radius: 16px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
                display: none;
                flex-direction: column;
                z-index: 1001;
                overflow: hidden;
            }

            [data-bs-theme="dark"] .chat-modal {
                background-color: #0d1117;
                border: 1px solid #30363d;
                box-shadow: 0 12px 48px rgba(0, 0, 0, 0.8);
            }

            .chat-modal.active {
                display: flex;
            }

            .chat-header {
                background: linear-gradient(135deg, var(--primary), var(--primary-hover));
                padding: 1.25rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                border-radius: 16px 16px 0 0;
            }

            [data-bs-theme="dark"] .chat-header {
                background: linear-gradient(135deg, #1f6feb, #1a56db);
            }

            .chat-header-content {
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .chat-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: rgba(255, 255, 255, 0.2);
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .chat-avatar i {
                font-size: 20px;
                color: #ffffff;
            }

            .chat-title {
                color: #ffffff;
                font-weight: 600;
                font-size: 1.1rem;
                margin: 0;
            }

            .chat-subtitle {
                color: rgba(255, 255, 255, 0.8);
                font-size: 0.75rem;
                margin: 0;
            }

            .chat-close {
                background: transparent;
                border: none;
                color: #ffffff;
                font-size: 24px;
                cursor: pointer;
                padding: 0;
                width: 32px;
                height: 32px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                transition: background 0.2s;
            }

            .chat-close:hover {
                background-color: rgba(255, 255, 255, 0.2);
            }

            .chat-body {
                flex: 1;
                padding: 1.5rem;
                overflow-y: auto;
                background-color: var(--bg-body);
            }

            [data-bs-theme="dark"] .chat-body {
                background-color: #010409;
            }

            .chat-message {
                margin-bottom: 1.25rem;
                display: flex;
                align-items: flex-start;
                gap: 0.75rem;
            }

            .chat-message.user {
                flex-direction: row-reverse;
            }

            .message-avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-shrink: 0;
            }

            .message-avatar.bot {
                background: linear-gradient(135deg, var(--primary), var(--primary-hover));
            }

            .message-avatar.user {
                background-color: var(--text-muted);
            }

            .message-avatar i {
                font-size: 16px;
                color: #ffffff;
            }

            .message-content {
                max-width: 75%;
                padding: 0.875rem 1.125rem;
                border-radius: 16px;
                line-height: 1.5;
                font-size: 0.9rem;
            }

            .message-content.bot {
                background-color: var(--surface);
                color: var(--text-main);
                border: 1px solid var(--border);
            }

            [data-bs-theme="dark"] .message-content.bot {
                background-color: #161b22;
                color: #c9d1d9;
                border: 1px solid #30363d;
            }

            .message-content.user {
                background: linear-gradient(135deg, var(--primary), var(--primary-hover));
                color: #ffffff;
            }

            .typing-indicator {
                display: flex;
                gap: 0.35rem;
                padding: 0.875rem 1.125rem;
                background-color: var(--surface);
                border: 1px solid var(--border);
                border-radius: 16px;
                width: fit-content;
            }

            [data-bs-theme="dark"] .typing-indicator {
                background-color: #161b22;
                border: 1px solid #30363d;
            }

            .typing-dot {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                background-color: var(--text-muted);
                animation: typing 1.4s infinite;
            }

            .typing-dot:nth-child(2) {
                animation-delay: 0.2s;
            }

            .typing-dot:nth-child(3) {
                animation-delay: 0.4s;
            }

            @keyframes typing {
                0%, 60%, 100% {
                    transform: translateY(0);
                    opacity: 0.7;
                }
                30% {
                    transform: translateY(-10px);
                    opacity: 1;
                }
            }

            .chat-suggestions {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                margin-top: 1rem;
            }

            .suggestion-chip {
                background-color: var(--surface);
                border: 1px solid var(--border);
                color: var(--text-main);
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-size: 0.85rem;
                cursor: pointer;
                transition: all 0.2s;
            }

            .suggestion-chip:hover {
                background-color: var(--primary);
                color: #ffffff;
                border-color: var(--primary);
            }

            .chat-input-container {
                padding: 1rem;
                background-color: var(--surface);
                border-top: 1px solid var(--border);
                display: flex;
                gap: 0.75rem;
            }

            [data-bs-theme="dark"] .chat-input-container {
                background-color: #0d1117;
                border-top: 1px solid #21262d;
            }

            .chat-input {
                flex: 1;
                background-color: var(--bg-body);
                border: 1px solid var(--border);
                color: var(--text-main);
                border-radius: 24px;
                padding: 0.75rem 1.25rem;
                font-size: 0.9rem;
                outline: none;
                transition: border-color 0.2s;
            }

            [data-bs-theme="dark"] .chat-input {
                background-color: #0d1117;
                border: 1px solid #30363d;
                color: #c9d1d9;
            }

            [data-bs-theme="dark"] .chat-input::placeholder {
                color: #8b949e;
            }

            [data-bs-theme="dark"] .chat-input:focus {
                border-color: #58a6ff;
                box-shadow: 0 0 0 3px rgba(88, 166, 255, 0.1);
            }

            .chat-input:focus {
                border-color: var(--primary);
            }

            .chat-send-btn {
                width: 44px;
                height: 44px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--primary), var(--primary-hover));
                border: none;
                color: #ffffff;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: transform 0.2s;
            }

            .chat-send-btn:hover {
                transform: scale(1.05);
            }

            .chat-send-btn:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            .chat-send-btn i {
                font-size: 18px;
            }

            @media (max-width: 768px) {
                .chat-modal {
                    width: calc(100vw - 2rem);
                    height: calc(100vh - 8rem);
                    right: 1rem;
                }
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
                    <i class="bi bi-robot"></i> AI Budget Predictor
                </a>
                <a href="#" class="nav-link" id="expense-tracker-link">
                    <i class="bi bi-receipt"></i> Expense Tracker
                </a>
                <a href="#" class="nav-link" id="income-deposit-link">
                    <i class="bi bi-wallet2"></i> Percentage Transfers
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
                <div class="col-md-6">
                    <div class="stat-card">
                        <div class="stat-label">Total Goals</div>
                        <div class="stat-value">${userGoals.size()}</div>
                    </div>
                </div>
                <div class="col-md-6">
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
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h5 class="chart-title mb-0">Expense Breakdown</h5>
                                <select id="expenseTimeRange" class="form-select form-select-sm" style="width: auto;" onchange="updateExpenseChart()">
                                    <option value="all">All Time</option>
                                    <option value="today">Today</option>
                                    <option value="week">This Week</option>
                                    <option value="month" selected>This Month</option>
                                    <option value="year">This Year</option>
                                    <option value="custom">Custom Range</option>
                                </select>
                            </div>
                            <div id="customRangeInputs" style="display: none; margin-bottom: 1rem;">
                                <div class="row g-2">
                                    <div class="col-6">
                                        <input type="date" id="customStartDate" class="form-control form-control-sm" onchange="updateExpenseChart()">
                                    </div>
                                    <div class="col-6">
                                        <input type="date" id="customEndDate" class="form-control form-control-sm" onchange="updateExpenseChart()">
                                    </div>
                                </div>
                            </div>
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

                <!-- Tabs for Ongoing/Achieved Goals -->
                <ul class="nav nav-pills mb-3" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="ongoing-goals-tab" data-bs-toggle="pill"
                                data-bs-target="#ongoing-goals" type="button" role="tab"
                                aria-controls="ongoing-goals" aria-selected="true">
                            <i class="bi bi-hourglass-split"></i> Ongoing
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="achieved-goals-tab" data-bs-toggle="pill"
                                data-bs-target="#achieved-goals" type="button" role="tab"
                                aria-controls="achieved-goals" aria-selected="false">
                            <i class="bi bi-trophy-fill"></i> Achieved
                        </button>
                    </li>
                </ul>

                <!-- Tab Content -->
                <div class="tab-content">
                    <!-- Ongoing Goals Tab -->
                    <div class="tab-pane fade show active" id="ongoing-goals" role="tabpanel" aria-labelledby="ongoing-goals-tab">
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
                                        <c:set var="remaining" value="${goal.target - (goal.remainingAmount != null ? goal.remainingAmount : 0)}" />
                                        <c:if test="${remaining > 0}">
                                            <tr>
                                                <td>${goal.goalName}</td>
                                                <td>&#8377;${goal.target}</td>
                                                <td>&#8377;${remaining}</td>
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
                                                        onclick="openPayModal('${goal.goalName}', '${remaining}', '${goal.id}')">
                                                        Pay
                                                    </button>
                                                    <button class="btn btn-outline-danger btn-sm rounded-pill ms-2"
                                                        onclick="deleteGoal('${goal.id}')">
                                                        Delete
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Achieved Goals Tab -->
                    <div class="tab-pane fade" id="achieved-goals" role="tabpanel" aria-labelledby="achieved-goals-tab">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Goal Name</th>
                                        <th>Target Amount</th>
                                        <th>Achieved</th>
                                        <th>Priority</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="goal" items="${userGoals}">
                                        <c:set var="remaining" value="${goal.target - (goal.remainingAmount != null ? goal.remainingAmount : 0)}" />
                                        <c:if test="${remaining <= 0}">
                                            <tr>
                                                <td>
                                                    <i class="bi bi-trophy-fill text-warning me-2"></i>
                                                    ${goal.goalName}
                                                </td>
                                                <td>&#8377;${goal.target}</td>
                                                <td>
                                                    <span class="badge" style="background:#81c995;">
                                                        <i class="bi bi-check-circle-fill"></i> Completed
                                                    </span>
                                                </td>
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
                                                    <button class="btn btn-outline-danger btn-sm rounded-pill"
                                                        onclick="deleteGoal('${goal.id}')">
                                                        Delete
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 2. AI BUDGET PREDICTOR SECTION -->
            <div id="budget-planner" class="content-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="page-title">AI Budget Predictor</h2>
                </div>

                <!-- AI Prediction Form -->
                <div class="card" style="background-color: var(--surface); border: 1px solid var(--border);">
                    <div class="card-body p-4">
                        <div class="text-center mb-4">
                            <div class="mb-2">
                                <i class="bi bi-robot" style="font-size: 2rem; color: var(--primary);"></i>
                            </div>
                            <h4 class="fw-normal">AI Budget Predictor</h4>
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

                <!-- Search Section -->
                <div class="card mb-4" style="background-color: var(--surface); border: 1px solid var(--border);">
                    <div class="card-body p-3">
                        <div class="row g-3">
                            <div class="col-md-10">
                                <div class="input-group">
                                    <span class="input-group-text" style="background-color: var(--bg-body); border-color: var(--border);">
                                        <i class="bi bi-search"></i>
                                    </span>
                                    <input type="text" id="expenseSearchInput" class="form-control"
                                           placeholder="Search by name or amount..."
                                           onkeyup="filterExpenses()">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-outline-secondary w-100" onclick="clearExpenseFilters()">
                                    <i class="bi bi-x-circle"></i> Clear
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table" id="expensesTable">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Expense Name</th>
                                <th>Amount</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="expense" items="${userExpenses}">
                                <tr class="expense-row"
                                    data-name="${expense.expenseName}"
                                    data-amount="${expense.expenseAmount}"
                                    data-date="${expense.expenseDate}">
                                    <td class="expense-date">
                                        <c:choose>
                                            <c:when test="${expense.expenseDate != null}">
                                                ${expense.expenseDate}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">No date</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${expense.expenseName}</td>
                                    <td>Rs.${expense.expenseAmount}</td>
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

                <!-- No results message -->
                <div id="noExpensesFound" class="text-center py-5" style="display: none;">
                    <i class="bi bi-search" style="font-size: 3rem; color: var(--text-muted);"></i>
                    <p class="text-muted mt-3">No expenses found matching your criteria</p>
                </div>
            </div>

            <!-- 5. PERCENTAGE-BASED INCOME DEPOSIT TRANSFERS SECTION -->
            <div id="income-deposit" class="content-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="page-title">Percentage-Based Income Transfers</h2>
                        <p class="text-muted mb-0">Automate goal savings immediately upon incoming external deposits while protecting your checking balance safety floor.</p>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-light rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#configureIncomeRulesModal">
                            <i class="bi bi-gear-fill"></i> Configure Rules & Floor
                        </button>
                        <button class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#triggerDepositModal">
                            <i class="bi bi-wallet2"></i> Process Incoming Deposit
                        </button>
                    </div>
                </div>

                <!-- Balance & Guardrails Summary Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-md-4">
                        <div class="stat-card">
                            <div class="stat-label"><i class="bi bi-bank"></i> Checking Account Balance</div>
                            <div class="h3 fw-bold mb-0 text-success" id="displayCheckingBalance">₹${accountSettings != null ? accountSettings.accountBalance : '10000.00'}</div>
                            <small class="text-muted">Available checking funds</small>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card">
                            <div class="stat-label"><i class="bi bi-shield-lock"></i> Overdraft Safety Floor</div>
                            <div class="h3 fw-bold mb-0 text-warning" id="displaySafetyFloor">₹${accountSettings != null ? accountSettings.safetyFloor : '1000.00'}</div>
                            <small class="text-muted">Minimum protected balance floor</small>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card">
                            <div class="stat-label"><i class="bi bi-funnel"></i> Minimum Deposit Trigger</div>
                            <div class="h3 fw-bold mb-0 text-info" id="displayMinDepositTrigger">₹${accountSettings != null ? accountSettings.minDepositAmount : '100.00'}</div>
                            <small class="text-muted">External deposit threshold trigger</small>
                        </div>
                    </div>
                </div>

                <!-- Goal Percentage Allocation Rules -->
                <div class="card bg-surface border-0 shadow-sm mb-4">
                    <div class="card-header bg-transparent border-0 d-flex justify-content-between align-items-center pt-3 pb-0">
                        <h5 class="mb-0"><i class="bi bi-percent"></i> Active Goal Percentage Allocation Rules</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table align-middle">
                                <thead>
                                    <tr>
                                        <th>Goal Name</th>
                                        <th>Target Amount</th>
                                        <th>Current Paid Amount</th>
                                        <th>Priority</th>
                                        <th>Deposit Percentage Allocation</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="goal" items="${userGoals}">
                                        <tr>
                                            <td class="fw-semibold">${goal.goalName}</td>
                                            <td>₹${goal.target}</td>
                                            <td>₹${goal.remainingAmount}</td>
                                            <td>
                                                <span class="badge bg-secondary">Priority ${goal.priority}</span>
                                            </td>
                                            <td>
                                                <span class="badge bg-primary px-3 py-2 fs-6">
                                                    ${goal.allocationPercentage != null ? goal.allocationPercentage : 0.0}%
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty userGoals}">
                                        <tr>
                                            <td colspan="5" class="text-center text-muted py-3">No active goals configured. Create goals in Goal Setter to configure percentage rules.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Immediate Post-Execution Notifications Feed -->
                <div class="card bg-surface border-0 shadow-sm">
                    <div class="card-header bg-transparent border-0 pt-3 pb-0">
                        <h5 class="mb-0"><i class="bi bi-bell-fill"></i> Immediate Transfer Notifications & Audit Log</h5>
                    </div>
                    <div class="card-body">
                        <div id="notificationListFeed">
                            <c:forEach var="notif" items="${notifications}">
                                <div class="alert ${notif.type == 'EXECUTED' ? 'alert-success' : (notif.type == 'REDUCED' ? 'alert-warning' : 'alert-secondary')} mb-3 shadow-sm">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <h6 class="alert-heading mb-0 fw-bold">${notif.title}</h6>
                                        <small class="text-muted">${notif.createdAt}</small>
                                    </div>
                                    <pre class="mb-0 fs-7" style="white-space: pre-wrap; font-family: inherit;">${notif.message}</pre>
                                </div>
                            </c:forEach>
                            <c:if test="${empty notifications}">
                                <div class="text-center text-muted py-4">No transfer notifications logged yet. Process an incoming deposit to see real-time execution results.</div>
                            </c:if>
                        </div>
                    </div>
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
                                <label class="form-label">Category</label>
                                <select class="form-select" id="expenseCategory" name="expenseCategory" required>
                                    <option value="">Select category...</option>
                                    <option value="Food & Dining">Food & Dining</option>
                                    <option value="Transport">Transport</option>
                                    <option value="Shopping">Shopping</option>
                                    <option value="Entertainment">Entertainment</option>
                                    <option value="Healthcare">Healthcare</option>
                                    <option value="Bills & Utilities">Bills & Utilities</option>
                                    <option value="Education">Education</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Amount</label>
                                <input type="number" class="form-control" id="newExpenseAmount" name="expenseAmount"
                                    min="1" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" id="expenseDate" name="expenseDate" required>
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
                                <label class="form-label">Category</label>
                                <select class="form-select" id="editExpenseCategory" name="expenseCategory" required>
                                    <option value="">Select category...</option>
                                    <option value="Food & Dining">Food & Dining</option>
                                    <option value="Transport">Transport</option>
                                    <option value="Shopping">Shopping</option>
                                    <option value="Entertainment">Entertainment</option>
                                    <option value="Healthcare">Healthcare</option>
                                    <option value="Bills & Utilities">Bills & Utilities</option>
                                    <option value="Education">Education</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
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


        <!-- AI Financial Advisor Chatbot -->
        <button class="chat-button" id="chatButton" title="AI Financial Advisor">
            <i class="bi bi-chat-dots-fill"></i>
        </button>

        <div class="chat-modal" id="chatModal">
            <div class="chat-header">
                <div class="chat-header-content">
                    <div class="chat-avatar">
                        <i class="bi bi-robot"></i>
                    </div>
                    <div>
                        <h6 class="chat-title">AI Financial Advisor</h6>
                        <p class="chat-subtitle">Ask me anything about your finances</p>
                    </div>
                </div>
                <button class="chat-close" id="chatClose">
                    <i class="bi bi-x"></i>
                </button>
            </div>

            <div class="chat-body" id="chatBody">
                <div class="chat-message">
                    <div class="message-avatar bot">
                        <i class="bi bi-robot"></i>
                    </div>
                    <div class="message-content bot">
                        Hi! I'm your AI Financial Advisor. I can help you with budgeting, expense analysis, and financial planning. What would you like to know?
                    </div>
                </div>

                <div class="chat-suggestions">
                    <div class="suggestion-chip" data-question="How much have I spent this month?">
                        How much have I spent?
                    </div>
                    <div class="suggestion-chip" data-question="Am I on track with my goals?">
                        Goal progress?
                    </div>
                    <div class="suggestion-chip" data-question="Where should I cut expenses?">
                        Savings tips?
                    </div>
                    <div class="suggestion-chip" data-question="Give me a financial health summary">
                        Health check
                    </div>
                </div>
            </div>

            <div class="chat-input-container">
                <input type="text" class="chat-input" id="chatInput" placeholder="Type your question..." />
                <button class="chat-send-btn" id="chatSendBtn">
                    <i class="bi bi-send-fill"></i>
                </button>
            </div>
        </div>

        <!-- Configure Income Rules & Safety Floor Modal -->
        <div class="modal fade" id="configureIncomeRulesModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="bi bi-sliders"></i> Configure Income Transfer Rules & Safety Floor</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="incomeSettingsForm">
                            <div class="row g-3 mb-4">
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold">Checking Balance (₹)</label>
                                    <input type="number" step="0.01" min="0" class="form-control" id="cfgAccountBalance" value="${accountSettings != null ? accountSettings.accountBalance : '10000.00'}" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold">Safety Floor (₹)</label>
                                    <input type="number" step="0.01" min="0" class="form-control" id="cfgSafetyFloor" value="${accountSettings != null ? accountSettings.safetyFloor : '1000.00'}" required>
                                    <small class="text-muted">Protected balance floor</small>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold">Min Deposit Trigger (₹)</label>
                                    <input type="number" step="0.01" min="0" class="form-control" id="cfgMinDeposit" value="${accountSettings != null ? accountSettings.minDepositAmount : '100.00'}" required>
                                    <small class="text-muted">Trigger threshold</small>
                                </div>
                            </div>

                            <h6 class="fw-bold mb-3"><i class="bi bi-percent"></i> Goal Percentage Allocation Rules</h6>
                            <div id="cfgGoalAllocationsContainer" class="mb-3">
                                <c:forEach var="goal" items="${userGoals}">
                                    <div class="row align-items-center mb-2">
                                        <div class="col-6">
                                            <span class="fw-semibold">${goal.goalName}</span>
                                            <small class="text-muted ms-2">(Target: ₹${goal.target})</small>
                                        </div>
                                        <div class="col-6">
                                            <div class="input-group">
                                                <input type="number" step="0.1" min="0" max="100" class="form-control goal-pct-input" data-goal-id="${goal.id}" value="${goal.allocationPercentage != null ? goal.allocationPercentage : 0.0}">
                                                <span class="input-group-text">%</span>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty userGoals}">
                                    <p class="text-muted">No goals available. Create goals first in Goal Setter.</p>
                                </c:if>
                            </div>

                            <div class="alert alert-info d-flex justify-content-between align-items-center mb-3" id="cfgAllocationSumBanner">
                                <span>Cumulative Allocation Total:</span>
                                <span class="fw-bold fs-5" id="cfgTotalPctDisplay">0%</span>
                            </div>

                            <div id="cfgAllocationErrorAlert" class="alert alert-danger mb-3" style="display: none;"></div>

                            <button type="submit" class="btn btn-primary w-100 rounded-pill py-2" id="cfgSaveBtn">Save Transfer Rules</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Trigger Incoming Deposit Modal -->
        <div class="modal fade" id="triggerDepositModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="bi bi-wallet2"></i> Process External Income Deposit</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="incomeDepositForm">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Incoming Deposit Amount (₹)</label>
                                <input type="number" step="0.01" min="0.01" class="form-control form-control-lg" id="depositAmountInput" placeholder="e.g. 5000.00" required>
                                <small class="text-muted">External paycheck or direct deposit confirmation</small>
                            </div>

                            <div id="depositResultAlert" class="alert mb-3" style="display: none;"></div>

                            <button type="submit" class="btn btn-primary w-100 rounded-pill py-2" id="btnConfirmDeposit">Confirm Deposit & Execute Transfers</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Percentage Transfers JS Handler
            function calcGoalPercentageTotal() {
                let sum = 0;
                document.querySelectorAll('.goal-pct-input').forEach(input => {
                    let val = parseFloat(input.value) || 0;
                    sum += val;
                });
                const display = document.getElementById('cfgTotalPctDisplay');
                const banner = document.getElementById('cfgAllocationSumBanner');
                const errAlert = document.getElementById('cfgAllocationErrorAlert');
                const saveBtn = document.getElementById('cfgSaveBtn');

                if (display) display.textContent = sum.toFixed(1) + '% / 100%';

                if (sum > 100) {
                    if (banner) {
                        banner.classList.remove('alert-info', 'alert-success');
                        banner.classList.add('alert-danger');
                    }
                    if (errAlert) {
                        errAlert.style.display = 'block';
                        errAlert.textContent = 'Validation Error: Cumulative goal allocation percentage cannot exceed 100% (Current: ' + sum.toFixed(1) + '%).';
                    }
                    if (saveBtn) saveBtn.disabled = true;
                    return false;
                } else {
                    if (banner) {
                        banner.classList.remove('alert-danger');
                        banner.classList.add('alert-info');
                    }
                    if (errAlert) errAlert.style.display = 'none';
                    if (saveBtn) saveBtn.disabled = false;
                    return true;
                }
            }

            document.addEventListener('DOMContentLoaded', () => {
                document.querySelectorAll('.goal-pct-input').forEach(input => {
                    input.addEventListener('input', calcGoalPercentageTotal);
                });
                calcGoalPercentageTotal();

                const incomeDepositLink = document.getElementById('income-deposit-link');
                if (incomeDepositLink) {
                    incomeDepositLink.addEventListener('click', (e) => {
                        e.preventDefault();
                        showSection('income-deposit', 'income-deposit-link');
                    });
                }

                // Income Settings Form Submission
                const settingsForm = document.getElementById('incomeSettingsForm');
                if (settingsForm) {
                    settingsForm.addEventListener('submit', function(e) {
                        e.preventDefault();
                        if (!calcGoalPercentageTotal()) return;

                        const goalAllocations = {};
                        document.querySelectorAll('.goal-pct-input').forEach(input => {
                            const goalId = input.getAttribute('data-goal-id');
                            goalAllocations[goalId] = parseFloat(input.value) || 0;
                        });

                        const payload = {
                            safetyFloor: parseFloat(document.getElementById('cfgSafetyFloor').value) || 0,
                            minDepositAmount: parseFloat(document.getElementById('cfgMinDeposit').value) || 0,
                            accountBalance: parseFloat(document.getElementById('cfgAccountBalance').value) || 0,
                            goalAllocations: goalAllocations
                        };

                        fetch('/home/income/settings', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify(payload)
                        })
                        .then(res => res.json())
                        .then(data => {
                            if (data.success) {
                                alert('Income transfer rules and safety floor updated successfully!');
                                window.location.reload();
                            } else {
                                const errAlert = document.getElementById('cfgAllocationErrorAlert');
                                if (errAlert) {
                                    errAlert.style.display = 'block';
                                    errAlert.textContent = data.error || 'Failed to update settings';
                                }
                            }
                        })
                        .catch(err => {
                            alert('An error occurred while saving settings: ' + err);
                        });
                    });
                }

                // Process Income Deposit Form Submission
                const depositForm = document.getElementById('incomeDepositForm');
                if (depositForm) {
                    depositForm.addEventListener('submit', function(e) {
                        e.preventDefault();
                        const amount = parseFloat(document.getElementById('depositAmountInput').value) || 0;
                        if (amount <= 0) return;

                        const resAlert = document.getElementById('depositResultAlert');
                        const confirmBtn = document.getElementById('btnConfirmDeposit');
                        if (confirmBtn) confirmBtn.disabled = true;

                        fetch('/home/income/deposit?amount=' + amount, {
                            method: 'POST'
                        })
                        .then(res => res.json())
                        .then(data => {
                            if (confirmBtn) confirmBtn.disabled = false;
                            if (resAlert) {
                                resAlert.style.display = 'block';
                                if (data.status === 'EXECUTED') {
                                    resAlert.className = 'alert alert-success shadow-sm mb-3';
                                } else if (data.status === 'REDUCED') {
                                    resAlert.className = 'alert alert-warning shadow-sm mb-3';
                                } else {
                                    resAlert.className = 'alert alert-secondary shadow-sm mb-3';
                                }
                                resAlert.innerHTML = '<strong>' + (data.status || 'PROCESSED') + ':</strong><br><pre class="mb-0 mt-1 fs-7" style="white-space: pre-wrap; font-family: inherit;">' + data.message + '</pre>';
                            }

                            setTimeout(() => {
                                window.location.reload();
                            }, 2500);
                        })
                        .catch(err => {
                            if (confirmBtn) confirmBtn.disabled = false;
                            if (resAlert) {
                                resAlert.style.display = 'block';
                                resAlert.className = 'alert alert-danger shadow-sm mb-3';
                                resAlert.textContent = 'Error processing deposit: ' + err;
                            }
                        });
                    });
                }
            });

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
                amounts: [],
                categories: [],
                dates: []
            };

            <c:forEach var="expense" items="${userExpenses}">
                expenseData.labels.push('${expense.expenseName}');
                expenseData.amounts.push(${expense.expenseAmount});
                expenseData.categories.push('${expense.category != null ? expense.category : "Other"}');
                expenseData.dates.push('${expense.expenseDate != null ? expense.expenseDate : ""}');
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

            // Filter expenses by date range
            function getFilteredExpenses() {
                const timeRange = document.getElementById('expenseTimeRange').value;
                const today = new Date();
                today.setHours(0, 0, 0, 0);

                let startDate = null;
                let endDate = new Date(today);
                endDate.setHours(23, 59, 59, 999);

                if (timeRange === 'all') {
                    return { indices: Array.from({ length: expenseData.dates.length }, (_, i) => i) };
                }

                if (timeRange === 'today') {
                    startDate = new Date(today);
                } else if (timeRange === 'week') {
                    startDate = new Date(today);
                    startDate.setDate(today.getDate() - today.getDay()); // Start of week (Sunday)
                } else if (timeRange === 'month') {
                    startDate = new Date(today.getFullYear(), today.getMonth(), 1);
                } else if (timeRange === 'year') {
                    startDate = new Date(today.getFullYear(), 0, 1);
                } else if (timeRange === 'custom') {
                    const customStart = document.getElementById('customStartDate').value;
                    const customEnd = document.getElementById('customEndDate').value;
                    if (customStart && customEnd) {
                        startDate = new Date(customStart);
                        endDate = new Date(customEnd);
                        endDate.setHours(23, 59, 59, 999);
                    } else {
                        return { indices: [] };
                    }
                }

                const filteredIndices = [];
                for (let i = 0; i < expenseData.dates.length; i++) {
                    const dateStr = expenseData.dates[i];
                    if (!dateStr) continue;
                    const expenseDate = new Date(dateStr);
                    if (expenseDate >= startDate && expenseDate <= endDate) {
                        filteredIndices.push(i);
                    }
                }

                return { indices: filteredIndices };
            }

            // 1. Create Expense Donut Chart
            function createExpenseDonutChart(filteredIndices = null) {
                const ctx = document.getElementById('expenseDonutChart');
                if (!ctx) return null;

                const colors = getChartColors();

                // Use filtered indices or all data
                const indices = filteredIndices || Array.from({ length: expenseData.labels.length }, (_, i) => i);

                // Aggregate expenses by category
                const aggregated = {};
                for (let i of indices) {
                    const category = expenseData.categories[i] || 'Other';
                    const amount = expenseData.amounts[i];
                    aggregated[category] = (aggregated[category] || 0) + amount;
                }

                // Sort by amount (descending)
                const sorted = Object.entries(aggregated)
                    .sort((a, b) => b[1] - a[1]);

                // Take top 7, group rest as "Others"
                const TOP_N = 7;
                let labels = [];
                let data = [];

                if (sorted.length <= TOP_N) {
                    // Show all if less than limit
                    labels = sorted.map(e => e[0]);
                    data = sorted.map(e => e[1]);
                } else {
                    // Top N + Others
                    labels = sorted.slice(0, TOP_N).map(e => e[0]);
                    data = sorted.slice(0, TOP_N).map(e => e[1]);

                    // Sum remaining into "Others"
                    const othersTotal = sorted.slice(TOP_N).reduce((sum, e) => sum + e[1], 0);
                    if (othersTotal > 0) {
                        labels.push('Others');
                        data.push(othersTotal);
                    }
                }

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
                                        return label + ': Rs.' + value + ' (' + percentage + '%)';
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

            // Update expense chart based on time range filter
            function updateExpenseChart() {
                const timeRange = document.getElementById('expenseTimeRange').value;
                const customRangeInputs = document.getElementById('customRangeInputs');

                // Show/hide custom date inputs
                if (timeRange === 'custom') {
                    customRangeInputs.style.display = 'block';
                    // Set default dates if empty
                    if (!document.getElementById('customStartDate').value) {
                        const today = new Date();
                        const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
                        document.getElementById('customStartDate').value = firstDay.toISOString().split('T')[0];
                        document.getElementById('customEndDate').value = today.toISOString().split('T')[0];
                    }
                } else {
                    customRangeInputs.style.display = 'none';
                }

                // Get filtered data
                const { indices } = getFilteredExpenses();

                // Destroy existing chart
                if (chartInstances.expenseDonut) {
                    chartInstances.expenseDonut.destroy();
                }

                // Create new chart with filtered data
                chartInstances.expenseDonut = createExpenseDonutChart(indices);
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
                if (!expenseData || !goalData) {
                    console.error('Data not available for insights');
                    return;
                }

                // Calculate totals
                const totalExpenses = expenseData.amounts.length > 0 ? expenseData.amounts.reduce((a, b) => a + b, 0) : 0;
                const totalGoalTargets = goalData.targets.length > 0 ? goalData.targets.reduce((a, b) => a + b, 0) : 0;
                let totalGoalAchieved = 0;
                for (let i = 0; i < goalData.targets.length; i++) {
                    totalGoalAchieved += (goalData.targets[i] * goalData.progress[i]) / 100;
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

                // Insight 3: Expense Pattern Analysis by Category
                if (expenseData.categories.length > 0) {
                    // Aggregate by category
                    const categoryTotals = {};
                    for (let i = 0; i < expenseData.categories.length; i++) {
                        const cat = expenseData.categories[i] || 'Other';
                        categoryTotals[cat] = (categoryTotals[cat] || 0) + expenseData.amounts[i];
                    }

                    // Find highest category
                    let maxCategory = '';
                    let maxAmount = 0;
                    for (const [cat, amount] of Object.entries(categoryTotals)) {
                        if (amount > maxAmount) {
                            maxAmount = amount;
                            maxCategory = cat;
                        }
                    }

                    if (maxAmount > 0) {
                        const maxExpensePercentage = (maxAmount / totalExpenses) * 100;
                        insights.push({
                            type: 'info',
                            icon: 'bi-pie-chart-fill',
                            title: 'Top Spending Category',
                            description: '"' + maxCategory + '" is your highest expense category at Rs.' + maxAmount.toLocaleString('en-IN') + ' (' + maxExpensePercentage.toFixed(1) + '% of total spending).'
                        });
                    }
                }

                // Insight 4: Total Expenses Summary
                if (totalExpenses > 0) {
                    insights.push({
                        type: 'info',
                        icon: 'bi-cash-stack',
                        title: 'Total Expenses',
                        description: 'You have spent Rs.' + totalExpenses.toLocaleString('en-IN') + ' in total across ' + expenseData.amounts.length + ' expense' + (expenseData.amounts.length === 1 ? '' : 's') + '.'
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
                        container.innerHTML = '<div class="text-center text-muted py-4"><i class="bi bi-info-circle me-2"></i>Add expenses and goals to see AI-powered insights!</div>';
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

            document.getElementById('expenseForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const formData = new URLSearchParams();
                formData.append('expenseName', document.getElementById('expenseName').value);
                formData.append('expenseCategory', document.getElementById('expenseCategory').value);
                formData.append('expenseAmount', document.getElementById('newExpenseAmount').value);
                formData.append('expenseDate', document.getElementById('expenseDate').value);

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
                const expenseCategory = document.getElementById('editExpenseCategory').value;
                const formData = new URLSearchParams();
                formData.append('expenseId', expenseId);
                formData.append('expenseAmount', expenseAmount);
                formData.append('expenseCategory', expenseCategory);

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
                            // Clear form after successful prediction
                            document.getElementById('predictForm').reset();
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

        <script>
            // ================================================
            // EXPENSE SEARCH AND FILTER
            // ================================================
            function filterExpenses() {
                const searchText = document.getElementById('expenseSearchInput').value.toLowerCase();
                const rows = document.querySelectorAll('.expense-row');
                let visibleCount = 0;

                rows.forEach(row => {
                    const name = row.getAttribute('data-name').toLowerCase();
                    const amount = row.getAttribute('data-amount');

                    // Search filter only
                    const matchesSearch = !searchText ||
                        name.includes(searchText) ||
                        amount.includes(searchText);

                    // Show/hide row
                    if (matchesSearch) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });

                // Show/hide "no results" message
                const noResultsDiv = document.getElementById('noExpensesFound');
                const tableDiv = document.getElementById('expensesTable');
                if (visibleCount === 0) {
                    noResultsDiv.style.display = 'block';
                    tableDiv.style.display = 'none';
                } else {
                    noResultsDiv.style.display = 'none';
                    tableDiv.style.display = 'table';
                }
            }

            function clearExpenseFilters() {
                document.getElementById('expenseSearchInput').value = '';
                filterExpenses();
            }

            // Set today's date as default when adding new expense
            document.addEventListener('DOMContentLoaded', function() {
                const addExpenseModal = document.getElementById('addExpenseModal');
                if (addExpenseModal) {
                    addExpenseModal.addEventListener('show.bs.modal', function() {
                        const dateInput = document.getElementById('expenseDate');
                        if (dateInput && !dateInput.value) {
                            const today = new Date().toISOString().split('T')[0];
                            dateInput.value = today;
                        }
                    });
                }
            });
        </script>

        <script>
            // ================================================
            // AI FINANCIAL ADVISOR CHATBOT
            // ================================================
            (function() {
                const chatButton = document.getElementById('chatButton');
                const chatModal = document.getElementById('chatModal');
                const chatClose = document.getElementById('chatClose');
                const chatBody = document.getElementById('chatBody');
                const chatInput = document.getElementById('chatInput');
                const chatSendBtn = document.getElementById('chatSendBtn');

                // Toggle chat modal
                chatButton.addEventListener('click', function() {
                    chatModal.classList.toggle('active');
                    if (chatModal.classList.contains('active')) {
                        chatInput.focus();
                    }
                });

                chatClose.addEventListener('click', function() {
                    chatModal.classList.remove('active');
                });

                // Handle suggestion chips
                document.querySelectorAll('.suggestion-chip').forEach(chip => {
                    chip.addEventListener('click', function() {
                        const question = this.getAttribute('data-question');
                        sendMessage(question);
                    });
                });

                // Send message on button click
                chatSendBtn.addEventListener('click', function() {
                    const message = chatInput.value.trim();
                    if (message) {
                        sendMessage(message);
                    }
                });

                // Send message on Enter key
                chatInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        const message = chatInput.value.trim();
                        if (message) {
                            sendMessage(message);
                        }
                    }
                });

                function sendMessage(message) {
                    // Add user message to chat
                    addMessage(message, 'user');
                    chatInput.value = '';

                    // Show typing indicator
                    showTypingIndicator();

                    // Prepare context data
                    const contextData = {
                        totalExpenses: expenseData.amounts.reduce((a, b) => a + b, 0),
                        expenseCategories: expenseData.categories,
                        expenseAmounts: expenseData.amounts,
                        totalGoals: goalData.names.length,
                        goalNames: goalData.names,
                        goalProgress: goalData.progress
                    };

                    // Send to backend
                    fetch('/home/chat', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            message: message,
                            context: contextData
                        })
                    })
                    .then(response => response.json())
                    .then(data => {
                        removeTypingIndicator();
                        if (data.success) {
                            addMessage(data.response, 'bot');
                        } else {
                            addMessage('Sorry, I encountered an error. Please try again.', 'bot');
                        }
                    })
                    .catch(error => {
                        removeTypingIndicator();
                        console.error('Chat error:', error);
                        addMessage('Sorry, I am having trouble connecting. Please try again later.', 'bot');
                    });
                }

                function addMessage(text, type) {
                    const messageDiv = document.createElement('div');
                    messageDiv.className = 'chat-message ' + type;

                    const avatarDiv = document.createElement('div');
                    avatarDiv.className = 'message-avatar ' + type;
                    const icon = document.createElement('i');
                    icon.className = type === 'bot' ? 'bi bi-robot' : 'bi bi-person-fill';
                    avatarDiv.appendChild(icon);

                    const contentDiv = document.createElement('div');
                    contentDiv.className = 'message-content ' + type;
                    contentDiv.textContent = text;

                    messageDiv.appendChild(avatarDiv);
                    messageDiv.appendChild(contentDiv);

                    // Remove suggestions after first user message
                    const suggestions = chatBody.querySelector('.chat-suggestions');
                    if (suggestions && type === 'user') {
                        suggestions.remove();
                    }

                    chatBody.appendChild(messageDiv);
                    chatBody.scrollTop = chatBody.scrollHeight;
                }

                function showTypingIndicator() {
                    const typingDiv = document.createElement('div');
                    typingDiv.className = 'chat-message';
                    typingDiv.id = 'typingIndicator';

                    const avatarDiv = document.createElement('div');
                    avatarDiv.className = 'message-avatar bot';
                    const icon = document.createElement('i');
                    icon.className = 'bi bi-robot';
                    avatarDiv.appendChild(icon);

                    const indicatorDiv = document.createElement('div');
                    indicatorDiv.className = 'typing-indicator';
                    for (let i = 0; i < 3; i++) {
                        const dot = document.createElement('div');
                        dot.className = 'typing-dot';
                        indicatorDiv.appendChild(dot);
                    }

                    typingDiv.appendChild(avatarDiv);
                    typingDiv.appendChild(indicatorDiv);

                    chatBody.appendChild(typingDiv);
                    chatBody.scrollTop = chatBody.scrollHeight;
                }

                function removeTypingIndicator() {
                    const typingIndicator = document.getElementById('typingIndicator');
                    if (typingIndicator) {
                        typingIndicator.remove();
                    }
                }
            })();
        </script>
    </body>

    </html>