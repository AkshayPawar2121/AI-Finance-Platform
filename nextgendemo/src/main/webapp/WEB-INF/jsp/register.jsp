<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | NextGen Finance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link
        href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,300&display=swap"
        rel="stylesheet">
    <style>
        /* ── TOKENS ─────────────────────────────────── */
        :root {
            --ink: #07080a;
            --ink-2: #12151a;
            --ink-3: #1c2029;
            --border: rgba(255, 255, 255, 0.07);
            --border-md: rgba(255, 255, 255, 0.12);
            --surface: rgba(255, 255, 255, 0.03);
            --text: #f0f2f5;
            --text-2: #8b909e;
            --text-3: #4d5261;
            --accent: #4fffb0;
            --accent-2: #00d4ff;
            --accent-3: #a855f7;
            --danger: #ff6b6b;
        }

        *,
        *::before,
        *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html {
            height: 100%;
        }

        body {
            background: var(--ink);
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: stretch;
            -webkit-font-smoothing: antialiased;
            overflow-x: hidden;
        }

        /* ── NOISE OVERLAY ──────────────────────────── */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 9999;
            opacity: 0.35;
        }

        /* ── SPLIT LAYOUT ───────────────────────────── */
        .page-left {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 48px 56px;
            position: relative;
            overflow: hidden;
            background: var(--ink-2);
            border-right: 1px solid var(--border);
        }

        .page-right {
            width: 520px;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 48px 56px;
            position: relative;
        }

        /* Ambient blobs on left panel */
        .blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(100px);
            pointer-events: none;
            animation: blobDrift 16s ease-in-out infinite alternate;
        }

        .blob-1 {
            width: 500px;
            height: 500px;
            background: rgba(79, 255, 176, 0.05);
            top: -180px;
            left: -180px;
        }

        .blob-2 {
            width: 400px;
            height: 400px;
            background: rgba(168, 85, 247, 0.07);
            bottom: -100px;
            right: -100px;
            animation-delay: -8s;
        }

        @keyframes blobDrift {
            0% {
                transform: translate(0, 0) scale(1);
            }

            100% {
                transform: translate(30px, 25px) scale(1.06);
            }
        }

        /* ── LEFT PANEL ─────────────────────────────── */
        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-family: 'Syne', sans-serif;
            font-weight: 800;
            font-size: 1.1rem;
            color: var(--text);
            text-decoration: none;
        }

        .brand-icon {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--accent), var(--accent-2));
            border-radius: 9px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .brand-icon svg {
            width: 20px;
            height: 20px;
        }

        .left-hero {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px 0;
            max-width: 480px;
        }

        .left-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(79, 255, 176, 0.08);
            border: 1px solid rgba(79, 255, 176, 0.18);
            border-radius: 50px;
            padding: 5px 14px 5px 7px;
            font-size: 0.78rem;
            font-weight: 500;
            color: var(--accent);
            margin-bottom: 28px;
            width: fit-content;
            animation: fadeUp 0.5s ease 0.1s both;
        }

        .badge-dot {
            width: 20px;
            height: 20px;
            background: rgba(79, 255, 176, 0.15);
            border-radius: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .badge-dot::after {
            content: '';
            width: 7px;
            height: 7px;
            background: var(--accent);
            border-radius: 50%;
            box-shadow: 0 0 8px var(--accent);
        }

        .left-title {
            font-family: 'Syne', sans-serif;
            font-size: clamp(2rem, 3vw, 2.8rem);
            font-weight: 800;
            line-height: 1.1;
            letter-spacing: -1.5px;
            margin-bottom: 20px;
            animation: fadeUp 0.6s ease 0.2s both;
        }

        .left-title .grad {
            background: linear-gradient(100deg, var(--accent) 0%, var(--accent-2) 60%, var(--accent-3) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .left-sub {
            color: var(--text-2);
            font-size: 1rem;
            font-weight: 300;
            line-height: 1.7;
            max-width: 380px;
            margin-bottom: 40px;
            animation: fadeUp 0.6s ease 0.3s both;
        }

        /* Feature list */
        .feature-list {
            display: flex;
            flex-direction: column;
            gap: 14px;
            animation: fadeUp 0.6s ease 0.4s both;
        }

        .feature-item {
            display: flex;
            align-items: flex-start;
            gap: 14px;
        }

        .feature-check {
            width: 22px;
            height: 22px;
            border-radius: 6px;
            background: rgba(79, 255, 176, 0.1);
            border: 1px solid rgba(79, 255, 176, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            margin-top: 1px;
        }

        .feature-check svg {
            width: 12px;
            height: 12px;
        }

        .feature-text {
            font-size: 0.9rem;
            color: var(--text-2);
            font-weight: 300;
            line-height: 1.5;
        }

        .feature-text strong {
            color: var(--text);
            font-weight: 500;
        }

        /* Social proof */
        .social-proof {
            display: flex;
            align-items: center;
            gap: 16px;
            padding-top: 40px;
            animation: fadeUp 0.6s ease 0.5s both;
        }

        .avatars {
            display: flex;
        }

        .avatar {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            border: 2px solid var(--ink-2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Syne', sans-serif;
            font-weight: 700;
            font-size: 0.7rem;
            margin-left: -8px;
        }

        .avatar:first-child {
            margin-left: 0;
        }

        .social-text {
            font-size: 0.82rem;
            color: var(--text-2);
            line-height: 1.4;
        }

        .social-text strong {
            color: var(--text);
            font-weight: 500;
        }

        .stars {
            color: #f5c842;
            font-size: 0.75rem;
            letter-spacing: 1px;
        }

        /* Left footer */
        .left-footer {
            font-size: 0.78rem;
            color: var(--text-3);
            animation: fadeUp 0.5s ease 0.6s both;
        }

        .left-footer a {
            color: var(--text-3);
            text-decoration: none;
        }

        .left-footer a:hover {
            color: var(--text-2);
        }

        /* ── RIGHT PANEL (FORM) ──────────────────────── */
        .form-panel {
            width: 100%;
            max-width: 400px;
        }

        .form-head {
            margin-bottom: 32px;
            animation: fadeUp 0.6s ease 0.15s both;
        }

        .form-head-title {
            font-family: 'Syne', sans-serif;
            font-size: 1.6rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 6px;
        }

        .form-head-sub {
            color: var(--text-2);
            font-size: 0.88rem;
            font-weight: 300;
        }

        .form-head-sub a {
            color: var(--accent);
            text-decoration: none;
            font-weight: 400;
        }

        .form-head-sub a:hover {
            text-decoration: underline;
        }

        /* Step indicator */
        .step-indicator {
            display: flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 28px;
            animation: fadeUp 0.6s ease 0.25s both;
        }

        .step-dot {
            width: 28px;
            height: 4px;
            border-radius: 2px;
            background: var(--border-md);
            transition: background 0.3s;
        }

        .step-dot.active {
            background: var(--accent);
        }

        .step-dot.done {
            background: rgba(79, 255, 176, 0.4);
        }

        /* Form fields */
        .field-group {
            margin-bottom: 16px;
            animation: fadeUp 0.5s ease both;
        }

        .field-group:nth-child(1) {
            animation-delay: 0.3s;
        }

        .field-group:nth-child(2) {
            animation-delay: 0.35s;
        }

        .field-group:nth-child(3) {
            animation-delay: 0.4s;
        }

        .field-group:nth-child(4) {
            animation-delay: 0.45s;
        }

        .field-label {
            display: block;
            font-size: 0.78rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            color: var(--text-3);
            margin-bottom: 7px;
        }

        .field-wrap {
            position: relative;
        }

        .field-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-3);
            pointer-events: none;
            transition: color 0.2s;
            display: flex;
            align-items: center;
        }

        .field-icon svg {
            width: 16px;
            height: 16px;
        }

        .form-control {
            width: 100%;
            background: rgba(255, 255, 255, 0.04) !important;
            border: 1px solid var(--border-md) !important;
            border-radius: 10px !important;
            color: var(--text) !important;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.9rem;
            padding: 12px 16px 12px 42px !important;
            transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
            outline: none;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.06) !important;
            border-color: rgba(79, 255, 176, 0.4) !important;
            box-shadow: 0 0 0 3px rgba(79, 255, 176, 0.08) !important;
            color: var(--text) !important;
        }

        .form-control:focus+.field-icon-right,
        .field-wrap:focus-within .field-icon {
            color: var(--accent);
        }

        .form-control::placeholder {
            color: var(--text-3) !important;
        }

        /* Password strength */
        .pwd-strength {
            margin-top: 8px;
            display: none;
        }

        .pwd-strength.visible {
            display: block;
        }

        .strength-bars {
            display: flex;
            gap: 4px;
            margin-bottom: 5px;
        }

        .strength-bar {
            flex: 1;
            height: 3px;
            border-radius: 2px;
            background: var(--border-md);
            transition: background 0.3s;
        }

        .strength-bar.filled.weak {
            background: var(--danger);
        }

        .strength-bar.filled.fair {
            background: #f5c842;
        }

        .strength-bar.filled.strong {
            background: var(--accent);
        }

        .strength-label {
            font-size: 0.72rem;
            color: var(--text-3);
        }

        /* Submit button */
        .btn-submit {
            width: 100%;
            background: var(--accent);
            color: var(--ink);
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            font-weight: 500;
            padding: 13px 24px;
            border-radius: 50px;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 8px;
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            animation: fadeUp 0.5s ease 0.55s both;
        }

        .btn-submit:hover {
            background: #7affc5;
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(79, 255, 176, 0.25);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .btn-submit svg {
            transition: transform 0.2s;
        }

        .btn-submit:hover svg {
            transform: translateX(3px);
        }

        /* Divider */
        .divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 20px 0;
            animation: fadeUp 0.5s ease 0.6s both;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--border);
        }

        .divider span {
            font-size: 0.75rem;
            color: var(--text-3);
            white-space: nowrap;
        }

        /* OAuth buttons */
        .oauth-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            animation: fadeUp 0.5s ease 0.65s both;
        }

        .btn-oauth {
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--border-md);
            border-radius: 10px;
            color: var(--text-2);
            font-family: 'DM Sans', sans-serif;
            font-size: 0.82rem;
            font-weight: 400;
            padding: 10px 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-oauth:hover {
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(255, 255, 255, 0.18);
            color: var(--text);
        }

        .btn-oauth svg {
            width: 16px;
            height: 16px;
            flex-shrink: 0;
        }

        /* Terms */
        .terms-note {
            text-align: center;
            font-size: 0.74rem;
            color: var(--text-3);
            margin-top: 20px;
            line-height: 1.5;
            animation: fadeUp 0.5s ease 0.7s both;
        }

        .terms-note a {
            color: var(--text-2);
            text-decoration: none;
        }

        .terms-note a:hover {
            color: var(--text);
            text-decoration: underline;
        }

        /* ── ANIMATIONS ─────────────────────────────── */
        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(16px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ── MOBILE RESPONSIVE ──────────────────────── */
        @media (max-width: 900px) {
            .page-left {
                display: none;
            }

            .page-right {
                width: 100%;
                padding: 40px 24px;
                min-height: 100vh;
                justify-content: flex-start;
                padding-top: 60px;
            }

            .form-panel {
                max-width: 100%;
            }
        }

        @media (max-width: 480px) {
            .page-right {
                padding: 32px 20px;
            }

            .oauth-row {
                grid-template-columns: 1fr;
            }
        }

        /* scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
        }

        ::-webkit-scrollbar-track {
            background: transparent;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--border-md);
            border-radius: 3px;
        }
    </style>
</head>

<body>

    <!-- ░░ LEFT PANEL ░░ -->
    <div class="page-left">
        <div class="blob blob-1"></div>
        <div class="blob blob-2"></div>

        <!-- Brand -->
        <a href="/" class="brand">
            <span class="brand-icon">
                <svg viewBox="0 0 20 20" fill="none">
                    <path d="M10 2L17 6V14L10 18L3 14V6L10 2Z" fill="#07080a" stroke="#07080a" stroke-width="0.5" />
                    <path d="M10 2L17 6V14L10 18L3 14V6L10 2Z" fill="#4fffb0" opacity="0.9" />
                </svg>
            </span>
            NextGen Finance
        </a>

        <!-- Hero copy -->
        <div class="left-hero">
            <div class="left-badge">
                <span class="badge-dot"></span>
                Free forever · No credit card needed
            </div>
            <h1 class="left-title">
                Take control of<br>
                your <span class="grad">financial future</span>
            </h1>
            <p class="left-sub">
                Join 50,000+ people who've replaced spreadsheets with intelligent, AI-powered financial clarity.
            </p>

            <div class="feature-list">
                <div class="feature-item">
                    <div class="feature-check">
                        <svg viewBox="0 0 12 12" fill="none">
                            <path d="M2 6l3 3 5-5" stroke="#4fffb0" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                        </svg>
                    </div>
                    <div class="feature-text"><strong>AI-powered forecasting</strong> &ndash; know your spending before
                        it
                        happens</div>
                </div>
                <div class="feature-item">
                    <div class="feature-check">
                        <svg viewBox="0 0 12 12" fill="none">
                            <path d="M2 6l3 3 5-5" stroke="#4fffb0" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                        </svg>
                    </div>
                    <div class="feature-text"><strong>Goal tracking</strong> &ndash; milestones, deadlines, and smart
                        nudges
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-check">
                        <svg viewBox="0 0 12 12" fill="none">
                            <path d="M2 6l3 3 5-5" stroke="#4fffb0" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                        </svg>
                    </div>
                    <div class="feature-text"><strong>Bank-grade security</strong> &ndash; 256-bit encrypted, read-only
                        connections</div>
                </div>
                <div class="feature-item">
                    <div class="feature-check">
                        <svg viewBox="0 0 12 12" fill="none">
                            <path d="M2 6l3 3 5-5" stroke="#4fffb0" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                        </svg>
                    </div>
                    <div class="feature-text"><strong>Zero ads, ever</strong> &ndash; your data is yours alone</div>
                </div>
            </div>

            <div class="social-proof">
                <div class="avatars">
                    <div class="avatar" style="background:rgba(79,255,176,0.12);color:#4fffb0">SM</div>
                    <div class="avatar" style="background:rgba(0,212,255,0.12);color:#00d4ff">JK</div>
                    <div class="avatar" style="background:rgba(168,85,247,0.12);color:#a855f7">AW</div>
                    <div class="avatar" style="background:rgba(245,200,66,0.12);color:#f5c842">PR</div>
                </div>
                <div class="social-text">
                    <div class="stars">&#9733;&#9733;&#9733;&#9733;&#9733;
                    </div>
                    <div><strong>4.9/5</strong> from 2,400+ reviews</div>
                </div>
            </div>
        </div>

        <div class="left-footer">
            © 2026 NextGen Finance · <a href="#">Privacy</a> · <a href="#">Terms</a>
        </div>
    </div>

    <!-- ░░ RIGHT PANEL (FORM) ░░ -->
    <div class="page-right">
        <div class="form-panel">

            <div class="form-head">
                <h2 class="form-head-title">Create your account</h2>
                <p class="form-head-sub">Already have one? <a href="/">Log in instead</a></p>
            </div>

            <div class="step-indicator">
                <div class="step-dot active"></div>
                <div class="step-dot"></div>
                <div class="step-dot"></div>
            </div>

            <!-- PRESERVING BACKEND LOGIC: action="/register", inputs: name, mobile, email, password -->
            <form action="/register" method="post" id="regForm" novalidate>

                <div class="field-group">
                    <label for="name" class="field-label">Full Name</label>
                    <div class="field-wrap">
                        <span class="field-icon">
                            <svg viewBox="0 0 16 16" fill="none">
                                <circle cx="8" cy="5.5" r="2.5" stroke="currentColor" stroke-width="1.3" />
                                <path d="M2.5 13.5c0-3.038 2.462-5.5 5.5-5.5s5.5 2.462 5.5 5.5" stroke="currentColor"
                                    stroke-width="1.3" stroke-linecap="round" />
                            </svg>
                        </span>
                        <input type="text" class="form-control" name="name" id="name" placeholder="John Doe" required
                            autocomplete="name">
                    </div>
                </div>

                <div class="field-group">
                    <label for="mobile" class="field-label">Mobile Number</label>
                    <div class="field-wrap">
                        <span class="field-icon">
                            <svg viewBox="0 0 16 16" fill="none">
                                <rect x="4" y="1" width="8" height="14" rx="2" stroke="currentColor"
                                    stroke-width="1.3" />
                                <circle cx="8" cy="12.5" r="0.75" fill="currentColor" />
                            </svg>
                        </span>
                        <input type="tel" class="form-control" name="mobile" id="mobile" placeholder="+1 234 567 8900"
                            required autocomplete="tel">
                    </div>
                </div>

                <div class="field-group">
                    <label for="email" class="field-label">Email Address</label>
                    <div class="field-wrap">
                        <span class="field-icon">
                            <svg viewBox="0 0 16 16" fill="none">
                                <rect x="1.5" y="3.5" width="13" height="9" rx="1.5" stroke="currentColor"
                                    stroke-width="1.3" />
                                <path d="M1.5 5.5l6.5 4 6.5-4" stroke="currentColor" stroke-width="1.3"
                                    stroke-linecap="round" />
                            </svg>
                        </span>
                        <input type="email" class="form-control" name="email" id="email" placeholder="name@company.com"
                            required autocomplete="email">
                    </div>
                </div>

                <div class="field-group">
                    <label for="password" class="field-label">Password</label>
                    <div class="field-wrap">
                        <span class="field-icon">
                            <svg viewBox="0 0 16 16" fill="none">
                                <rect x="3" y="7" width="10" height="7.5" rx="1.5" stroke="currentColor"
                                    stroke-width="1.3" />
                                <path d="M5.5 7V5a2.5 2.5 0 015 0v2" stroke="currentColor" stroke-width="1.3"
                                    stroke-linecap="round" />
                                <circle cx="8" cy="10.5" r="1" fill="currentColor" />
                            </svg>
                        </span>
                        <input type="password" class="form-control" name="password" id="password"
                            placeholder="Min. 8 characters" required autocomplete="new-password">
                    </div>
                    <div class="pwd-strength" id="pwdStrength">
                        <div class="strength-bars">
                            <div class="strength-bar" id="sb1"></div>
                            <div class="strength-bar" id="sb2"></div>
                            <div class="strength-bar" id="sb3"></div>
                            <div class="strength-bar" id="sb4"></div>
                        </div>
                        <span class="strength-label" id="strengthLabel">Enter a password</span>
                    </div>
                </div>

                <button type="submit" class="btn-submit">
                    Create free account
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                        <path d="M3 8h10M8.5 4L13 8l-4.5 4" stroke="currentColor" stroke-width="1.5"
                            stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                </button>

            </form>

            <div class="divider"><span>or continue with</span></div>

            <div class="oauth-row">
                <a href="#" class="btn-oauth">
                    <!-- Google icon -->
                    <svg viewBox="0 0 16 16" fill="none">
                        <path
                            d="M15.36 8.18c0-.57-.05-1.11-.14-1.64H8v3.1h4.11c-.18.96-.73 1.77-1.55 2.31v1.92h2.52c1.47-1.35 2.28-3.35 2.28-5.69z"
                            fill="#4285F4" />
                        <path
                            d="M8 16c2.07 0 3.8-.69 5.07-1.86l-2.52-1.92c-.7.47-1.59.74-2.55.74-1.96 0-3.62-1.32-4.21-3.1H1.19v1.97C2.46 14.19 5.04 16 8 16z"
                            fill="#34A853" />
                        <path
                            d="M3.79 9.86C3.63 9.39 3.54 8.89 3.54 8.37s.09-1.02.25-1.49V4.91H1.19A7.97 7.97 0 000 8.37c0 1.29.31 2.51.86 3.59l2.93-2.1z"
                            fill="#FBBC05" />
                        <path
                            d="M8 3.27c1.1 0 2.09.38 2.87 1.12l2.15-2.15C11.79 1.03 10.06.27 8 .27 5.04.27 2.46 2.08 1.19 4.72l2.6 1.94C4.38 4.6 6.04 3.27 8 3.27z"
                            fill="#EA4335" />
                    </svg>
                    Google
                </a>
                <a href="#" class="btn-oauth">
                    <!-- Apple icon -->
                    <svg viewBox="0 0 16 16" fill="currentColor">
                        <path
                            d="M11.18 8.56c-.02-1.82 1.49-2.7 1.56-2.74-.85-1.24-2.17-1.41-2.64-1.43-1.12-.11-2.19.66-2.76.66-.57 0-1.45-.64-2.39-.62-1.22.02-2.35.71-2.98 1.8-1.28 2.21-.33 5.49.91 7.28.61.88 1.33 1.87 2.28 1.83.92-.04 1.26-.59 2.37-.59 1.1 0 1.41.59 2.37.57.99-.02 1.61-.9 2.21-1.78.7-1.02.99-2.01 1-2.06-.02-.01-1.92-.73-1.93-2.92zM9.4 2.82c.51-.62.85-1.47.75-2.32-.73.03-1.61.49-2.13 1.1-.47.54-.88 1.41-.77 2.24.81.06 1.64-.41 2.15-1.02z" />
                    </svg>
                    Apple
                </a>
            </div>

            <p class="terms-note">
                By creating an account you agree to our <a href="#">Terms of Service</a> and <a href="#">Privacy
                    Policy</a>. We'll never share your data.
            </p>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // ── Password strength meter
        const pwdInput = document.getElementById('password');
        const pwdStrength = document.getElementById('pwdStrength');
        const strengthLabel = document.getElementById('strengthLabel');
        const bars = [document.getElementById('sb1'), document.getElementById('sb2'), document.getElementById('sb3'), document.getElementById('sb4')];

        function getStrength(pwd) {
            let score = 0;
            if (pwd.length >= 8) score++;
            if (pwd.length >= 12) score++;
            if (/[A-Z]/.test(pwd) && /[0-9]/.test(pwd)) score++;
            if (/[^A-Za-z0-9]/.test(pwd)) score++;
            return score;
        }

        pwdInput.addEventListener('input', () => {
            const pwd = pwdInput.value;
            if (!pwd) { pwdStrength.classList.remove('visible'); return; }
            pwdStrength.classList.add('visible');

            const score = getStrength(pwd);
            const tier = score <= 1 ? 'weak' : score <= 2 ? 'fair' : 'strong';
            const labels = ['', 'Weak', 'Fair', 'Good', 'Strong'];

            bars.forEach((bar, i) => {
                bar.className = 'strength-bar' + (i < score ? ` filled ${tier}` : '');
            });
            strengthLabel.textContent = labels[score] || 'Weak';
            strengthLabel.style.color = tier === 'weak' ? 'var(--danger)' : tier === 'fair' ? '#f5c842' : 'var(--accent)';
        });

        // ── Focus-within label glow
        document.querySelectorAll('.field-wrap').forEach(wrap => {
            const inp = wrap.querySelector('input');
            const icon = wrap.querySelector('.field-icon');
            inp.addEventListener('focus', () => { if (icon) icon.style.color = 'var(--accent)'; });
            inp.addEventListener('blur', () => { if (icon) icon.style.color = ''; });
        });
    </script>
</body>

</html>