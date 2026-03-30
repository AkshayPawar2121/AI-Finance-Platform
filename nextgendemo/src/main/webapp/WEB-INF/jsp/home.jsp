<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="_csrf" content="${_csrf.token}" />
        <title>Dashboard | NextGen Finance</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap"
            rel="stylesheet">
        <style>
            /* ─── DESIGN TOKENS ─────────────────────────────────── */
            :root {
                --bg: #07080a;
                --surface: #0e1014;
                --surface-2: #14171d;
                --surface-3: #1a1e27;
                --border: rgba(255, 255, 255, 0.07);
                --border-hover: rgba(255, 255, 255, 0.14);

                --blue: #4f8cff;
                --blue-glow: rgba(79, 140, 255, 0.18);
                --blue-muted: rgba(79, 140, 255, 0.08);
                --teal: #00d4aa;
                --teal-glow: rgba(0, 212, 170, 0.15);
                --amber: #f59e0b;
                --red: #ff5b5b;

                --text: #eef0f4;
                --text-2: #8891a4;
                --text-3: #4e5669;

                --sidebar-w: 256px;
                --radius: 14px;
                --radius-sm: 9px;
                --radius-lg: 20px;

                --font: 'Sora', sans-serif;
                --font-mono: 'DM Mono', monospace;

                --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.5);
                --shadow: 0 4px 20px rgba(0, 0, 0, 0.6);
                --shadow-glow: 0 0 40px rgba(79, 140, 255, 0.12);
            }

            /* ─── RESET & BASE ───────────────────────────────────── */
            *,
            *::before,
            *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            html {
                scroll-behavior: smooth;
            }

            body {
                background: var(--bg);
                color: var(--text);
                font-family: var(--font);
                font-size: 14px;
                line-height: 1.6;
                overflow-x: hidden;
                -webkit-font-smoothing: antialiased;
            }

            /* ─── NOISE TEXTURE ──────────────────────────────────── */
            body::before {
                content: '';
                position: fixed;
                inset: 0;
                background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.03'/%3E%3C/svg%3E");
                pointer-events: none;
                z-index: 9999;
                opacity: 0.4;
            }

            /* ─── SCROLLBAR ──────────────────────────────────────── */
            ::-webkit-scrollbar {
                width: 4px;
            }

            ::-webkit-scrollbar-track {
                background: transparent;
            }

            ::-webkit-scrollbar-thumb {
                background: var(--surface-3);
                border-radius: 99px;
            }

            /* ─── SIDEBAR ────────────────────────────────────────── */
            #sidebar {
                position: fixed;
                top: 0;
                left: 0;
                height: 100vh;
                width: var(--sidebar-w);
                background: var(--surface);
                border-right: 1px solid var(--border);
                display: flex;
                flex-direction: column;
                padding: 28px 16px;
                z-index: 200;
                transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            .brand {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 0 10px;
                margin-bottom: 36px;
                text-decoration: none;
            }

            .brand-icon {
                width: 34px;
                height: 34px;
                background: linear-gradient(135deg, var(--blue), var(--teal));
                border-radius: 9px;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-shrink: 0;
                box-shadow: 0 4px 16px var(--blue-glow);
            }

            .brand-icon svg {
                width: 17px;
                height: 17px;
            }

            .brand-name {
                font-size: 15px;
                font-weight: 700;
                color: var(--text);
                letter-spacing: -0.3px;
            }

            .brand-name span {
                color: var(--blue);
            }

            .nav-section-label {
                font-size: 10px;
                font-weight: 600;
                letter-spacing: 1.2px;
                text-transform: uppercase;
                color: var(--text-3);
                padding: 0 12px;
                margin-bottom: 6px;
            }

            .nav-item {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 9px 12px;
                border-radius: var(--radius-sm);
                color: var(--text-2);
                text-decoration: none;
                font-size: 13.5px;
                font-weight: 500;
                margin-bottom: 2px;
                transition: all 0.18s ease;
                position: relative;
                cursor: pointer;
            }

            .nav-item svg {
                width: 16px;
                height: 16px;
                flex-shrink: 0;
            }

            .nav-item:hover {
                background: var(--surface-3);
                color: var(--text);
            }

            .nav-item.active {
                background: var(--blue-muted);
                color: var(--blue);
            }

            .nav-item.active::before {
                content: '';
                position: absolute;
                left: 0;
                top: 50%;
                transform: translateY(-50%);
                width: 3px;
                height: 60%;
                background: var(--blue);
                border-radius: 0 3px 3px 0;
            }

            .nav-badge {
                margin-left: auto;
                background: var(--surface-3);
                color: var(--text-2);
                font-size: 10px;
                font-family: var(--font-mono);
                padding: 1px 7px;
                border-radius: 99px;
                font-weight: 500;
            }

            .nav-item.active .nav-badge {
                background: rgba(79, 140, 255, 0.15);
                color: var(--blue);
            }

            .sidebar-footer {
                margin-top: auto;
                padding-top: 16px;
                border-top: 1px solid var(--border);
            }

            .logout-btn {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 9px 12px;
                border-radius: var(--radius-sm);
                color: var(--red);
                opacity: 0.7;
                text-decoration: none;
                font-size: 13.5px;
                font-weight: 500;
                transition: all 0.18s;
            }

            .logout-btn:hover {
                opacity: 1;
                background: rgba(255, 91, 91, 0.08);
            }

            .logout-btn svg {
                width: 16px;
                height: 16px;
            }

            /* ─── MAIN ───────────────────────────────────────────── */
            .main {
                margin-left: var(--sidebar-w);
                min-height: 100vh;
                padding: 36px 40px;
                max-width: calc(100vw - var(--sidebar-w));
            }

            /* ─── TOPBAR ─────────────────────────────────────────── */
            .topbar {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 36px;
            }

            .topbar-left h1 {
                font-size: 22px;
                font-weight: 700;
                letter-spacing: -0.5px;
                color: var(--text);
            }

            .topbar-left p {
                font-size: 13px;
                color: var(--text-2);
                margin-top: 2px;
            }

            .topbar-right {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .avatar {
                width: 34px;
                height: 34px;
                background: linear-gradient(135deg, #4f8cff, #00d4aa);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 13px;
                font-weight: 700;
                color: #fff;
                flex-shrink: 0;
            }

            /* ─── STAT CARDS ─────────────────────────────────────── */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 16px;
                margin-bottom: 36px;
            }

            .stat-card {
                background: var(--surface);
                border: 1px solid var(--border);
                border-radius: var(--radius);
                padding: 22px 24px;
                position: relative;
                overflow: hidden;
                transition: border-color 0.2s, transform 0.2s;
            }

            .stat-card:hover {
                border-color: var(--border-hover);
                transform: translateY(-2px);
            }

            .stat-card::after {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                width: 120px;
                height: 120px;
                border-radius: 50%;
                opacity: 0.06;
                transform: translate(30%, -30%);
            }

            .stat-card:nth-child(1)::after {
                background: var(--blue);
            }

            .stat-card:nth-child(2)::after {
                background: var(--teal);
            }

            .stat-card:nth-child(3)::after {
                background: var(--amber);
            }

            .stat-icon {
                width: 36px;
                height: 36px;
                border-radius: 9px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 14px;
            }

            .stat-icon svg {
                width: 17px;
                height: 17px;
            }

            .stat-icon.blue {
                background: var(--blue-muted);
                color: var(--blue);
            }

            .stat-icon.teal {
                background: var(--teal-glow);
                color: var(--teal);
            }

            .stat-icon.amber {
                background: rgba(245, 158, 11, 0.1);
                color: var(--amber);
            }

            .stat-label {
                font-size: 12px;
                color: var(--text-2);
                font-weight: 500;
                letter-spacing: 0.2px;
                margin-bottom: 6px;
            }

            .stat-value {
                font-size: 28px;
                font-weight: 700;
                font-family: var(--font-mono);
                color: var(--text);
                letter-spacing: -1px;
            }

            .stat-sub {
                font-size: 11px;
                color: var(--text-3);
                margin-top: 6px;
            }

            /* ─── SECTION ────────────────────────────────────────── */
            .content-section {
                display: none;
                animation: fadeUp 0.3s ease;
            }

            .content-section.active-section {
                display: block;
            }

            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(12px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* ─── SECTION HEADER ─────────────────────────────────── */
            .section-header {
                display: flex;
                align-items: flex-end;
                justify-content: space-between;
                margin-bottom: 24px;
            }

            .section-title {
                font-size: 18px;
                font-weight: 700;
                letter-spacing: -0.4px;
                color: var(--text);
            }

            .section-desc {
                font-size: 13px;
                color: var(--text-2);
                margin-top: 3px;
            }

            /* ─── BUTTONS ────────────────────────────────────────── */
            .btn-primary-ng {
                display: inline-flex;
                align-items: center;
                gap: 7px;
                background: var(--blue);
                color: #fff;
                font-family: var(--font);
                font-size: 13px;
                font-weight: 600;
                padding: 9px 18px;
                border: none;
                border-radius: 99px;
                cursor: pointer;
                transition: all 0.2s;
                box-shadow: 0 4px 14px var(--blue-glow);
                text-decoration: none;
            }

            .btn-primary-ng:hover {
                background: #6fa0ff;
                transform: translateY(-1px);
                box-shadow: 0 6px 20px var(--blue-glow);
                color: #fff;
            }

            .btn-primary-ng svg {
                width: 14px;
                height: 14px;
            }

            .btn-ghost {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                background: transparent;
                color: var(--text-2);
                font-family: var(--font);
                font-size: 12.5px;
                font-weight: 500;
                padding: 7px 14px;
                border: 1px solid var(--border);
                border-radius: 99px;
                cursor: pointer;
                transition: all 0.18s;
            }

            .btn-ghost:hover {
                border-color: var(--border-hover);
                color: var(--text);
                background: var(--surface-3);
            }

            .btn-ghost svg {
                width: 12px;
                height: 12px;
            }

            .btn-danger-ng {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                background: transparent;
                color: var(--red);
                font-family: var(--font);
                font-size: 12.5px;
                font-weight: 500;
                padding: 7px 14px;
                border: 1px solid rgba(255, 91, 91, 0.25);
                border-radius: 99px;
                cursor: pointer;
                transition: all 0.18s;
            }

            .btn-danger-ng:hover {
                background: rgba(255, 91, 91, 0.08);
                border-color: rgba(255, 91, 91, 0.5);
            }

            .btn-danger-ng svg {
                width: 12px;
                height: 12px;
            }

            /* ─── CARD / PANEL ───────────────────────────────────── */
            .panel {
                background: var(--surface);
                border: 1px solid var(--border);
                border-radius: var(--radius);
                overflow: hidden;
            }

            .panel-header {
                padding: 18px 24px;
                border-bottom: 1px solid var(--border);
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .panel-title {
                font-size: 13px;
                font-weight: 600;
                color: var(--text);
                letter-spacing: -0.1px;
            }

            .panel-count {
                font-size: 11px;
                color: var(--text-3);
                font-family: var(--font-mono);
                background: var(--surface-3);
                padding: 2px 8px;
                border-radius: 99px;
            }

            /* ─── TABLE ──────────────────────────────────────────── */
            .ng-table {
                width: 100%;
                border-collapse: collapse;
            }

            .ng-table thead tr {
                border-bottom: 1px solid var(--border);
            }

            .ng-table th {
                font-size: 11px;
                font-weight: 600;
                letter-spacing: 0.8px;
                text-transform: uppercase;
                color: var(--text-3);
                padding: 12px 24px;
                text-align: left;
                white-space: nowrap;
            }

            .ng-table td {
                padding: 14px 24px;
                font-size: 13.5px;
                color: var(--text);
                border-bottom: 1px solid var(--border);
                vertical-align: middle;
            }

            .ng-table tbody tr:last-child td {
                border-bottom: none;
            }

            .ng-table tbody tr {
                transition: background 0.15s;
            }

            .ng-table tbody tr:hover {
                background: var(--surface-2);
            }

            .cell-mono {
                font-family: var(--font-mono);
                font-size: 13px;
                color: var(--teal);
                font-weight: 500;
            }

            .actions {
                display: flex;
                gap: 8px;
                align-items: center;
            }

            .empty-state {
                text-align: center;
                padding: 60px 24px;
            }

            .empty-state-icon {
                width: 48px;
                height: 48px;
                background: var(--surface-3);
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 14px;
            }

            .empty-state-icon svg {
                width: 22px;
                height: 22px;
                color: var(--text-3);
            }

            .empty-state p {
                color: var(--text-3);
                font-size: 13px;
            }

            /* ─── AI PREDICTOR ───────────────────────────────────── */
            .ai-card {
                background: var(--surface);
                border: 1px solid var(--border);
                border-radius: var(--radius);
                padding: 36px;
                margin-top: 20px;
                position: relative;
                overflow: hidden;
            }

            .ai-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 60%;
                height: 1px;
                background: linear-gradient(90deg, transparent, var(--blue), transparent);
            }

            .ai-card::after {
                content: '';
                position: absolute;
                top: -60px;
                right: -60px;
                width: 200px;
                height: 200px;
                background: radial-gradient(circle, var(--blue-glow), transparent 70%);
                pointer-events: none;
            }

            .ai-header {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-bottom: 32px;
            }

            .ai-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                background: var(--blue-muted);
                border: 1px solid rgba(79, 140, 255, 0.2);
                color: var(--blue);
                font-size: 11px;
                font-weight: 600;
                letter-spacing: 0.5px;
                text-transform: uppercase;
                padding: 4px 12px;
                border-radius: 99px;
                margin-bottom: 14px;
            }

            .ai-badge svg {
                width: 11px;
                height: 11px;
            }

            .ai-title {
                font-size: 22px;
                font-weight: 700;
                letter-spacing: -0.5px;
                margin-bottom: 8px;
                text-align: center;
            }

            .ai-desc {
                font-size: 13px;
                color: var(--text-2);
                text-align: center;
            }

            /* ─── FORM ELEMENTS ──────────────────────────────────── */
            .form-grid {
                display: grid;
                gap: 16px;
                margin-bottom: 20px;
            }

            .form-grid.cols-3 {
                grid-template-columns: repeat(3, 1fr);
            }

            .form-grid.cols-2 {
                grid-template-columns: repeat(2, 1fr);
            }

            .field {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .field label {
                font-size: 11.5px;
                font-weight: 600;
                color: var(--text-2);
                letter-spacing: 0.2px;
            }

            .field input,
            .field select {
                background: var(--surface-2);
                border: 1px solid var(--border);
                color: var(--text);
                font-family: var(--font);
                font-size: 13.5px;
                padding: 10px 14px;
                border-radius: var(--radius-sm);
                outline: none;
                transition: border-color 0.18s, box-shadow 0.18s;
                appearance: none;
            }

            .field input:focus,
            .field select:focus {
                border-color: var(--blue);
                box-shadow: 0 0 0 3px var(--blue-muted);
            }

            .field input::placeholder {
                color: var(--text-3);
            }

            .field select option {
                background: var(--surface-2);
            }

            /* Checkbox group */
            .checkbox-group {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 10px;
                margin-bottom: 28px;
            }

            .check-item {
                display: flex;
                align-items: center;
                gap: 8px;
                background: var(--surface-2);
                border: 1px solid var(--border);
                border-radius: var(--radius-sm);
                padding: 10px 12px;
                cursor: pointer;
                transition: all 0.18s;
            }

            .check-item:hover {
                border-color: var(--border-hover);
            }

            .check-item:has(input:checked) {
                border-color: var(--blue);
                background: var(--blue-muted);
            }

            .check-item input[type="checkbox"] {
                width: 14px;
                height: 14px;
                accent-color: var(--blue);
                cursor: pointer;
            }

            .check-item span {
                font-size: 12.5px;
                color: var(--text-2);
                font-weight: 500;
            }

            .check-item:has(input:checked) span {
                color: var(--blue);
            }

            .divider-label {
                font-size: 11px;
                font-weight: 600;
                letter-spacing: 0.8px;
                text-transform: uppercase;
                color: var(--text-3);
                margin-bottom: 12px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .divider-label::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--border);
            }

            .submit-area {
                display: flex;
                justify-content: center;
            }

            /* ─── MODAL ──────────────────────────────────────────── */
            .modal-overlay {
                position: fixed;
                inset: 0;
                background: rgba(0, 0, 0, 0.7);
                backdrop-filter: blur(4px);
                z-index: 500;
                display: none;
                align-items: center;
                justify-content: center;
            }

            .modal-overlay.open {
                display: flex;
            }

            .modal-box {
                background: var(--surface);
                border: 1px solid var(--border);
                border-radius: var(--radius-lg);
                width: 100%;
                max-width: 460px;
                padding: 28px;
                position: relative;
                animation: modalIn 0.25s cubic-bezier(0.34, 1.56, 0.64, 1);
            }

            .modal-box.wide {
                max-width: 680px;
            }

            @keyframes modalIn {
                from {
                    opacity: 0;
                    transform: scale(0.94) translateY(10px);
                }

                to {
                    opacity: 1;
                    transform: scale(1) translateY(0);
                }
            }

            .modal-title {
                font-size: 16px;
                font-weight: 700;
                letter-spacing: -0.3px;
                margin-bottom: 4px;
            }

            .modal-subtitle {
                font-size: 12.5px;
                color: var(--text-2);
                margin-bottom: 24px;
            }

            .modal-close {
                position: absolute;
                top: 20px;
                right: 20px;
                width: 28px;
                height: 28px;
                background: var(--surface-3);
                border: none;
                border-radius: 50%;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--text-2);
                transition: all 0.15s;
            }

            .modal-close:hover {
                background: var(--border-hover);
                color: var(--text);
            }

            .modal-close svg {
                width: 13px;
                height: 13px;
            }

            .modal-form {
                display: flex;
                flex-direction: column;
                gap: 14px;
            }

            .modal-field {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .modal-field label {
                font-size: 11.5px;
                font-weight: 600;
                color: var(--text-2);
            }

            .modal-field input {
                background: var(--surface-2);
                border: 1px solid var(--border);
                color: var(--text);
                font-family: var(--font);
                font-size: 13.5px;
                padding: 10px 14px;
                border-radius: var(--radius-sm);
                outline: none;
                transition: border-color 0.18s, box-shadow 0.18s;
            }

            .modal-field input:focus {
                border-color: var(--blue);
                box-shadow: 0 0 0 3px var(--blue-muted);
            }

            .modal-field input[readonly] {
                color: var(--text-2);
                cursor: default;
            }

            .modal-actions {
                display: flex;
                gap: 10px;
                margin-top: 6px;
            }

            .modal-actions .btn-primary-ng {
                flex: 1;
                justify-content: center;
                border-radius: var(--radius-sm);
            }

            /* Prediction result table inside modal */
            .result-table {
                width: 100%;
                border-collapse: collapse;
            }

            .result-table th,
            .result-table td {
                padding: 10px 14px;
                text-align: left;
                font-size: 13px;
                border-bottom: 1px solid var(--border);
            }

            .result-table th {
                color: var(--text-3);
                font-size: 11px;
                text-transform: uppercase;
                letter-spacing: 0.6px;
                font-weight: 600;
                background: var(--surface-2);
            }

            .result-table td {
                color: var(--text);
            }

            .result-table td:last-child {
                font-family: var(--font-mono);
                color: var(--teal);
            }

            .result-table tbody tr:last-child td {
                border-bottom: none;
            }

            .result-table tbody tr:hover td {
                background: var(--surface-2);
            }

            .modal-footer-btns {
                display: flex;
                gap: 8px;
                margin-top: 18px;
                padding-top: 18px;
                border-top: 1px solid var(--border);
            }

            /* ─── BOOTSTRAP MODAL OVERRIDE ───────────────────────── */
            .modal-content {
                background: var(--surface) !important;
                border: 1px solid var(--border) !important;
                border-radius: var(--radius-lg) !important;
            }

            .modal-header {
                border-bottom: 1px solid var(--border) !important;
                padding: 20px 24px !important;
            }

            .modal-body {
                padding: 24px !important;
            }

            .modal-footer {
                border-top: 1px solid var(--border) !important;
                padding: 16px 24px !important;
            }

            .modal-title {
                font-size: 15px !important;
                font-weight: 700 !important;
                letter-spacing: -0.3px !important;
            }

            .btn-close {
                filter: invert(0.5);
            }

            /* Bootstrap modal form fields */
            .modal-body .form-label {
                font-size: 11.5px !important;
                font-weight: 600 !important;
                color: var(--text-2) !important;
            }

            .modal-body .form-control {
                background: var(--surface-2) !important;
                border: 1px solid var(--border) !important;
                color: var(--text) !important;
                border-radius: var(--radius-sm) !important;
                font-family: var(--font) !important;
                font-size: 13.5px !important;
            }

            .modal-body .form-control:focus {
                border-color: var(--blue) !important;
                box-shadow: 0 0 0 3px var(--blue-muted) !important;
            }

            .modal-body .btn-primary {
                background: var(--blue) !important;
                border: none !important;
                font-family: var(--font) !important;
                font-weight: 600 !important;
                font-size: 13px !important;
                border-radius: 99px !important;
                padding: 10px 20px !important;
                transition: all 0.2s !important;
            }

            .modal-body .btn-primary:hover {
                background: #6fa0ff !important;
            }

            /* ─── RESPONSIVE ─────────────────────────────────────── */
            @media (max-width: 900px) {
                #sidebar {
                    transform: translateX(-100%);
                }

                #sidebar.open {
                    transform: translateX(0);
                }

                .main {
                    margin-left: 0;
                    padding: 24px 20px;
                    max-width: 100vw;
                }

                .stats-grid {
                    grid-template-columns: 1fr;
                }

                .form-grid.cols-3,
                .form-grid.cols-2 {
                    grid-template-columns: 1fr;
                }

                .checkbox-group {
                    grid-template-columns: repeat(2, 1fr);
                }

                .ai-card {
                    padding: 24px;
                }
            }

            @media (max-width: 600px) {
                .topbar {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 12px;
                }

                .section-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 12px;
                }

                .ng-table th,
                .ng-table td {
                    padding: 10px 14px;
                }
            }
        </style>
    </head>

    <body>

        <!-- ═══════════════════════════════════════════════════════════ -->
        <!--  SIDEBAR                                                  -->
        <!-- ═══════════════════════════════════════════════════════════ -->
        <nav id="sidebar">
            <a href="#" class="brand">
                <div class="brand-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.2" stroke-linecap="round"
                        stroke-linejoin="round">
                        <polyline points="22 7 13.5 15.5 8.5 10.5 2 17" />
                        <polyline points="16 7 22 7 22 13" />
                    </svg>
                </div>
                <span class="brand-name">Next<span>Gen</span></span>
            </a>

            <div style="margin-bottom:8px;">
                <p class="nav-section-label">Workspace</p>
                <a href="#" class="nav-item active" id="goal-setter-link">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10" />
                        <circle cx="12" cy="12" r="6" />
                        <circle cx="12" cy="12" r="2" />
                    </svg>
                    Goal Setter
                    <span class="nav-badge">${userGoals.size()}</span>
                </a>
                <a href="#" class="nav-item" id="budget-planner-link">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round">
                        <rect x="2" y="5" width="20" height="14" rx="2" />
                        <line x1="2" y1="10" x2="22" y2="10" />
                    </svg>
                    Budget Planner
                    <span class="nav-badge">${userBudgets.size()}</span>
                </a>
                <a href="#" class="nav-item" id="expense-tracker-link">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
                        <polyline points="14 2 14 8 20 8" />
                        <line x1="16" y1="13" x2="8" y2="13" />
                        <line x1="16" y1="17" x2="8" y2="17" />
                        <polyline points="10 9 9 9 8 9" />
                    </svg>
                    Expense Tracker
                    <span class="nav-badge">${userExpenses.size()}</span>
                </a>
            </div>

            <div class="sidebar-footer">
                <a href="/" class="logout-btn">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round">
                        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                        <polyline points="16 17 21 12 16 7" />
                        <line x1="21" y1="12" x2="9" y2="12" />
                    </svg>
                    Sign Out
                </a>
            </div>
        </nav>

        <!-- ═══════════════════════════════════════════════════════════ -->
        <!--  MAIN                                                     -->
        <!-- ═══════════════════════════════════════════════════════════ -->
        <main class="main">

            <!-- TOPBAR -->
            <div class="topbar">
                <div class="topbar-left">
                    <h1>Financial Dashboard</h1>
                    <p>Track goals, manage budgets, and predict your financial future.</p>
                </div>
                <div class="topbar-right">
                    <div class="avatar">U</div>
                </div>
            </div>

            <!-- STATS -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"
                            stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="10" />
                            <circle cx="12" cy="12" r="3" />
                        </svg>
                    </div>
                    <div class="stat-label">Total Goals</div>
                    <div class="stat-value">${userGoals.size()}</div>
                    <div class="stat-sub">Active financial targets</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon teal">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"
                            stroke-linecap="round" stroke-linejoin="round">
                            <rect x="2" y="5" width="20" height="14" rx="2" />
                            <line x1="2" y1="10" x2="22" y2="10" />
                        </svg>
                    </div>
                    <div class="stat-label">Active Budgets</div>
                    <div class="stat-value">${userBudgets.size()}</div>
                    <div class="stat-sub">Budget categories tracked</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon amber">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"
                            stroke-linecap="round" stroke-linejoin="round">
                            <line x1="12" y1="1" x2="12" y2="23" />
                            <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6" />
                        </svg>
                    </div>
                    <div class="stat-label">Total Expenses</div>
                    <div class="stat-value">${userExpenses.size()}</div>
                    <div class="stat-sub">Logged expense entries</div>
                </div>
            </div>

            <!-- ─── 1. GOAL SETTER ─────────────────────────────────── -->
            <div id="goal-setter" class="content-section active-section">
                <div class="section-header">
                    <div>
                        <div class="section-title">Goal Setter</div>
                        <div class="section-desc">Define and track your long-term financial targets.</div>
                    </div>
                    <button class="btn-primary-ng" data-bs-toggle="modal" data-bs-target="#addGoalModal">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"
                            stroke-linecap="round" stroke-linejoin="round">
                            <line x1="12" y1="5" x2="12" y2="19" />
                            <line x1="5" y1="12" x2="19" y2="12" />
                        </svg>
                        New Goal
                    </button>
                </div>
                <div class="panel">
                    <div class="panel-header">
                        <span class="panel-title">All Goals</span>
                        <span class="panel-count">${userGoals.size()} items</span>
                    </div>
                    <div class="table-responsive">
                        <table class="ng-table">
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
                                        <td class="cell-mono">Rs. ${goal.target}</td>
                                        <td class="cell-mono">Rs. ${goal.target - (goal.remainingAmount != null ?
                                            goal.remainingAmount : 0)}</td>
                                        <td>
                                            <div class="actions">
                                                <button class="btn-ghost"
                                                    onclick="openPayModal('${goal.goalName}', ${goal.target - (goal.remainingAmount != null ? goal.remainingAmount : 0)}, ${goal.id})">
                                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2.2" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <circle cx="12" cy="12" r="10" />
                                                        <line x1="12" y1="8" x2="12" y2="16" />
                                                        <line x1="8" y1="12" x2="16" y2="12" />
                                                    </svg>
                                                    Contribute
                                                </button>
                                                <button class="btn-danger-ng" onclick="deleteGoal(${goal.id})">
                                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2.2" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <polyline points="3 6 5 6 21 6" />
                                                        <path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6" />
                                                        <path d="M10 11v6" />
                                                        <path d="M14 11v6" />
                                                    </svg>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty userGoals}">
                                    <tr>
                                        <td colspan="4">
                                            <div class="empty-state">
                                                <div class="empty-state-icon">
                                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="1.5" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <circle cx="12" cy="12" r="10" />
                                                        <circle cx="12" cy="12" r="3" />
                                                    </svg>
                                                </div>
                                                <p>No goals yet. Set your first financial goal.</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- ─── 2. BUDGET PLANNER ──────────────────────────────── -->
            <div id="budget-planner" class="content-section">
                <div class="section-header">
                    <div>
                        <div class="section-title">Budget Planner</div>
                        <div class="section-desc">Allocate and manage your monthly spending limits.</div>
                    </div>
                    <button class="btn-primary-ng" data-bs-toggle="modal" data-bs-target="#addBudgetModal">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"
                            stroke-linecap="round" stroke-linejoin="round">
                            <line x1="12" y1="5" x2="12" y2="19" />
                            <line x1="5" y1="12" x2="19" y2="12" />
                        </svg>
                        New Budget
                    </button>
                </div>

                <div class="panel" style="margin-bottom:20px;">
                    <div class="panel-header">
                        <span class="panel-title">Active Budgets</span>
                        <span class="panel-count">${userBudgets.size()} items</span>
                    </div>
                    <div class="table-responsive">
                        <table class="ng-table">
                            <thead>
                                <tr>
                                    <th>Budget Name</th>
                                    <th>Amount</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="budget" items="${userBudgets}">
                                    <tr>
                                        <td>${budget.budget_name}</td>
                                        <td class="cell-mono">Rs. ${budget.budget_amount}</td>
                                        <td>
                                            <div class="actions">
                                                <button class="btn-ghost"
                                                    onclick="openBudgetPayModal(${budget.budget_amount}, ${budget.id})">
                                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2.2" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <path
                                                            d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                        <path
                                                            d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                                    </svg>
                                                    Edit
                                                </button>
                                                <button class="btn-danger-ng" onclick="deleteBudget(${budget.id})">
                                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2.2" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <polyline points="3 6 5 6 21 6" />
                                                        <path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6" />
                                                    </svg>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty userBudgets}">
                                    <tr>
                                        <td colspan="3">
                                            <div class="empty-state">
                                                <div class="empty-state-icon">
                                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="1.5" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <rect x="2" y="5" width="20" height="14" rx="2" />
                                                        <line x1="2" y1="10" x2="22" y2="10" />
                                                    </svg>
                                                </div>
                                                <p>No budgets yet. Create your first budget allocation.</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- AI Predictor -->
                <div class="ai-card">
                    <div class="ai-header">
                        <div class="ai-badge">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" stroke-linejoin="round">
                                <polygon
                                    points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
                            </svg>
                            AI Powered
                        </div>
                        <div class="ai-title">Financial Predictor</div>
                        <div class="ai-desc">Enter your profile details and our probability model will generate a
                            personalized financial breakdown.</div>
                    </div>

                    <form id="predictForm">
                        <div class="form-grid cols-3">
                            <div class="field">
                                <label>Annual Income</label>
                                <input type="number" name="income" id="income" placeholder="e.g. 800000" required>
                            </div>
                            <div class="field">
                                <label>Age</label>
                                <input type="number" name="age" id="age" placeholder="e.g. 30" required>
                            </div>
                            <div class="field">
                                <label>Dependents</label>
                                <input type="number" name="dependents" id="dependents" placeholder="e.g. 2" required>
                            </div>
                        </div>

                        <div class="form-grid cols-2">
                            <div class="field">
                                <label>Occupation</label>
                                <select name="occupation" id="occupation" required>
                                    <option value="1">Self Employed</option>
                                    <option value="2">Professional</option>
                                    <option value="3">Retired</option>
                                    <option value="4">Student</option>
                                </select>
                            </div>
                            <div class="field">
                                <label>City Tier</label>
                                <select name="city_tier" id="city_tier" required>
                                    <option value="1">Tier 1</option>
                                    <option value="2">Tier 2</option>
                                    <option value="3">Tier 3</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-grid cols-2">
                            <div class="field">
                                <label>Loan Repayment (monthly)</label>
                                <input type="number" name="loan_repayment" id="loan_repayment" placeholder="e.g. 15000"
                                    required>
                            </div>
                            <div class="field">
                                <label>Insurance (annual)</label>
                                <input type="number" name="insurance" id="insurance" placeholder="e.g. 20000" required>
                            </div>
                        </div>

                        <div class="divider-label">Exclusions</div>
                        <div class="checkbox-group">
                            <label class="check-item">
                                <input type="checkbox" id="own_house" name="own_house">
                                <span>Own House</span>
                            </label>
                            <label class="check-item">
                                <input type="checkbox" id="no_transport" name="no_transport">
                                <span>No Transport</span>
                            </label>
                            <label class="check-item">
                                <input type="checkbox" id="no_eating_out" name="no_eating_out">
                                <span>No Eating Out</span>
                            </label>
                            <label class="check-item">
                                <input type="checkbox" id="no_entertainment" name="no_entertainment">
                                <span>No Entertainment</span>
                            </label>
                        </div>

                        <div class="submit-area">
                            <button type="submit" class="btn-primary-ng"
                                style="padding:11px 32px;font-size:14px;border-radius:10px;">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"
                                    stroke-linecap="round" stroke-linejoin="round" style="width:15px;height:15px;">
                                    <polygon
                                        points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
                                </svg>
                                Generate Prediction
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- ─── 3. EXPENSE TRACKER ─────────────────────────────── -->
            <div id="expense-tracker" class="content-section">
                <div class="section-header">
                    <div>
                        <div class="section-title">Expense Tracker</div>
                        <div class="section-desc">Log and monitor all your spending in one place.</div>
                    </div>
                    <button class="btn-primary-ng" data-bs-toggle="modal" data-bs-target="#addExpenseModal">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"
                            stroke-linecap="round" stroke-linejoin="round">
                            <line x1="12" y1="5" x2="12" y2="19" />
                            <line x1="5" y1="12" x2="19" y2="12" />
                        </svg>
                        Log Expense
                    </button>
                </div>
                <div class="panel">
                    <div class="panel-header">
                        <span class="panel-title">All Expenses</span>
                        <span class="panel-count">${userExpenses.size()} items</span>
                    </div>
                    <div class="table-responsive">
                        <table class="ng-table">
                            <thead>
                                <tr>
                                    <th>Description</th>
                                    <th>Amount</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="expense" items="${userExpenses}">
                                    <tr>
                                        <td>${expense.expenseName}</td>
                                        <td class="cell-mono">Rs. ${expense.expenseAmount}</td>
                                        <td>
                                            <div class="actions">
                                                <button class="btn-ghost"
                                                    onclick="openExpensePayModal(${expense.expenseAmount}, ${expense.id})">
                                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2.2" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <path
                                                            d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                                                        <path
                                                            d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                                                    </svg>
                                                    Edit
                                                </button>
                                                <button class="btn-danger-ng" onclick="deleteExpense(${expense.id})">
                                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="2.2" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <polyline points="3 6 5 6 21 6" />
                                                        <path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6" />
                                                    </svg>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty userExpenses}">
                                    <tr>
                                        <td colspan="3">
                                            <div class="empty-state">
                                                <div class="empty-state-icon">
                                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="1.5" stroke-linecap="round"
                                                        stroke-linejoin="round">
                                                        <path
                                                            d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
                                                        <polyline points="14 2 14 8 20 8" />
                                                    </svg>
                                                </div>
                                                <p>No expenses logged yet.</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </main>

        <!-- ═══════════════════════════════════════════════════════════ -->
        <!--  BOOTSTRAP MODALS (Add/Edit forms)                        -->
        <!-- ═══════════════════════════════════════════════════════════ -->

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
                                <input type="text" class="form-control" name="goalname"
                                    placeholder="e.g. Emergency Fund" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label">Target Amount</label>
                                <input type="number" class="form-control" name="target" placeholder="e.g. 500000"
                                    required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Create Goal</button>
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
                                <input type="text" class="form-control" name="budgetName" placeholder="e.g. Groceries"
                                    required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label">Amount</label>
                                <input type="number" class="form-control" name="budgetAmount" placeholder="e.g. 10000"
                                    required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Save Budget</button>
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
                                <input type="text" class="form-control" name="expenseName"
                                    placeholder="e.g. Electricity bill" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label">Amount</label>
                                <input type="number" class="form-control" name="expenseAmount" placeholder="e.g. 2500"
                                    required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Add Expense</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Goal Payment -->
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
                            <div class="mb-4">
                                <label class="form-label">Amount to Contribute</label>
                                <input type="number" class="form-control" name="paymentAmount"
                                    placeholder="Enter amount" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Confirm Contribution</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Budget Edit -->
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
                            <div class="mb-4">
                                <label class="form-label">New Amount</label>
                                <input type="number" class="form-control" id="budgetAmount" name="budgetAmount"
                                    step="0.01" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Update Budget</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Expense Edit -->
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
                            <div class="mb-4">
                                <label class="form-label">New Amount</label>
                                <input type="number" class="form-control" id="expenseAmount" name="expenseAmount"
                                    step="0.01" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Update Expense</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- ─── AI PREDICTION RESULT MODAL (custom) ──────────────── -->
        <div id="responseModal" class="modal-overlay" tabindex="-1">
            <div class="modal-box wide">
                <div class="modal-title">Prediction Result</div>
                <div class="modal-subtitle">AI-generated financial breakdown based on your profile.</div>
                <button class="modal-close" onclick="closeModal()">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"
                        stroke-linejoin="round">
                        <line x1="18" y1="6" x2="6" y2="18" />
                        <line x1="6" y1="6" x2="18" y2="18" />
                    </svg>
                </button>
                <div id="modalContent" style="max-height:50vh;overflow-y:auto;"></div>
                <div class="modal-footer-btns">
                    <button onclick="downloadAsPDF()" class="btn-primary-ng" style="border-radius:8px;">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"
                            stroke-linecap="round" stroke-linejoin="round" style="width:13px;height:13px;">
                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" />
                            <polyline points="7 10 12 15 17 10" />
                            <line x1="12" y1="15" x2="12" y2="3" />
                        </svg>
                        Download PDF
                    </button>
                    <button onclick="printTable()" class="btn-ghost" style="border-radius:8px;">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"
                            stroke-linecap="round" stroke-linejoin="round" style="width:13px;height:13px;">
                            <polyline points="6 9 6 2 18 2 18 9" />
                            <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2" />
                            <rect x="6" y="14" width="12" height="8" />
                        </svg>
                        Print
                    </button>
                    <button onclick="closeModal()" class="btn-ghost"
                        style="border-radius:8px;margin-left:auto;">Close</button>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // ── Section switcher ───────────────────────────────────
            function showSection(sectionId, linkId) {
                document.querySelectorAll('.content-section').forEach(el => el.classList.remove('active-section'));
                document.getElementById(sectionId).classList.add('active-section');
                document.querySelectorAll('.nav-item').forEach(el => el.classList.remove('active'));
                document.getElementById(linkId).classList.add('active');
            }

            document.getElementById('goal-setter-link').addEventListener('click', e => { e.preventDefault(); showSection('goal-setter', 'goal-setter-link'); });
            document.getElementById('budget-planner-link').addEventListener('click', e => { e.preventDefault(); showSection('budget-planner', 'budget-planner-link'); });
            document.getElementById('expense-tracker-link').addEventListener('click', e => { e.preventDefault(); showSection('expense-tracker', 'expense-tracker-link'); });

            // ── Modal helpers ──────────────────────────────────────
            function openPayModal(goalName, remainingAmount, goalId) {
                document.getElementById('modalGoalName').value = goalName;
                document.getElementById('modalRemainingAmount').value = remainingAmount;
                document.getElementById('goalId').value = goalId;
                new bootstrap.Modal(document.getElementById('paymentModal')).show();
            }

            function openBudgetPayModal(budgetAmount, budgetId) {
                document.getElementById('budgetAmount').value = budgetAmount;
                document.getElementById('budgetId').value = budgetId;
                new bootstrap.Modal(document.getElementById('paymentBudgetModal')).show();
            }

            function openExpensePayModal(expenseAmount, expenseId) {
                document.getElementById('expenseAmount').value = expenseAmount;
                document.getElementById('expenseId').value = expenseId;
                new bootstrap.Modal(document.getElementById('paymentExpenseModal')).show();
            }

            // ── Delete helpers ─────────────────────────────────────
            function deleteGoal(id) {
                if (confirm('Delete this goal?')) fetch('/home/goalsetter/delete?id=' + id).then(() => location.reload());
            }
            function deleteBudget(id) {
                if (confirm('Delete this budget?')) fetch('/home/budgetplanner/delete?id=' + id).then(() => location.reload());
            }
            function deleteExpense(id) {
                if (confirm('Delete this expense?')) fetch('/home/expensetracker/delete?id=' + id).then(() => location.reload());
            }

            // ── Prediction ─────────────────────────────────────────
            document.getElementById('predictForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const btn = this.querySelector('button[type="submit"]');
                btn.disabled = true;
                btn.innerHTML = `<svg style="width:15px;height:15px;animation:spin 1s linear infinite" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="2" x2="12" y2="6"/><line x1="12" y1="18" x2="12" y2="22"/><line x1="4.93" y1="4.93" x2="7.76" y2="7.76"/><line x1="16.24" y1="16.24" x2="19.07" y2="19.07"/><line x1="2" y1="12" x2="6" y2="12"/><line x1="18" y1="12" x2="22" y2="12"/><line x1="4.93" y1="19.07" x2="7.76" y2="16.24"/><line x1="16.24" y1="7.76" x2="19.07" y2="4.93"/></svg> Analyzing...`;

                const formData = new URLSearchParams(new FormData(this)).toString();
                fetch('/home/budgetplanner/predict', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData
                })
                    .then(r => r.json())
                    .then(data => {
                        if (data.success) {
                            showTable(roundValues(data.data));
                            openModal();
                        } else {
                            alert('Error: ' + (data.error || 'Unknown error'));
                        }
                    })
                    .catch(err => alert('Error: ' + err))
                    .finally(() => {
                        btn.disabled = false;
                        btn.innerHTML = `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" style="width:15px;height:15px;"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg> Generate Prediction`;
                    });
            });

            function showTable(data) {
                const container = document.getElementById('modalContent');
                container.innerHTML = '';
                const table = document.createElement('table');
                table.className = 'result-table';
                table.innerHTML = `<thead><tr><th>Category</th><th>Amount</th></tr></thead>`;
                const tbody = document.createElement('tbody');
                Object.entries(data).forEach(([key, value]) => {
                    const tr = document.createElement('tr');
                    tr.innerHTML = `<td>\${key}</td><td>\${typeof value === 'object' ? JSON.stringify(value) : 'Rs. ' + value}</td>`;
                    tbody.appendChild(tr);
                });
                table.appendChild(tbody);
                container.appendChild(table);
            }

            function openModal() {
                document.getElementById('responseModal').classList.add('open');
                document.body.style.overflow = 'hidden';
            }

            function closeModal() {
                document.getElementById('responseModal').classList.remove('open');
                document.body.style.overflow = '';
            }

            document.getElementById('responseModal').addEventListener('click', function (e) {
                if (e.target === this) closeModal();
            });

            function roundValues(data) {
                for (let key in data) {
                    if (typeof data[key] === 'number') data[key] = Math.round(data[key]);
                }
                return data;
            }

            // ── PDF & Print ────────────────────────────────────────
            async function downloadAsPDF() {
                const { jsPDF } = window.jspdf;
                const canvas = await html2canvas(document.getElementById('modalContent'));
                const pdf = new jsPDF();
                pdf.addImage(canvas.toDataURL('image/png'), 'PNG', 10, 10, 180, 0);
                pdf.save('nextgen-prediction.pdf');
            }

            function printTable() {
                const w = window.open('', '', 'height=600,width=800');
                w.document.write(`<html><head><title>Prediction Result</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head><body class="p-4">\${document.getElementById('modalContent').innerHTML}</body></html>`);
                w.document.close();
                w.print();
            }

            // ── Spin keyframe (inline) ─────────────────────────────
            const style = document.createElement('style');
            style.textContent = `@keyframes spin { to { transform: rotate(360deg); } }`;
            document.head.appendChild(style);
        </script>
    </body>

    </html>