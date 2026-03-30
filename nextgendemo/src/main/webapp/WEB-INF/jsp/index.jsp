<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Intelligent financial planning for the modern era.">
        <title>NextGen Finance</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600;700;800&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,300&display=swap"
            rel="stylesheet">
        <style>
            /* ── TOKENS ─────────────────────────────────── */
            :root {
                --ink: #07080a;
                --ink-2: #1a1d23;
                --ink-3: #2b303a;
                --border: rgba(255, 255, 255, 0.07);
                --border-md: rgba(255, 255, 255, 0.12);
                --surface: rgba(255, 255, 255, 0.035);
                --surface-md: rgba(255, 255, 255, 0.07);
                --text: #f0f2f5;
                --text-2: #8b909e;
                --text-3: #565c6e;
                --accent: #4fffb0;
                /* vivid mint */
                --accent-2: #00d4ff;
                /* cyan */
                --accent-3: #a855f7;
                /* violet */
                --gold: #f5c842;
                --r-sm: 10px;
                --r-md: 16px;
                --r-lg: 24px;
                --r-xl: 32px;
            }

            /* ── RESET / BASE ───────────────────────────── */
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
                background: var(--ink);
                color: var(--text);
                font-family: 'DM Sans', sans-serif;
                font-size: 16px;
                line-height: 1.6;
                overflow-x: hidden;
                -webkit-font-smoothing: antialiased;
            }

            /* ── NOISE OVERLAY ──────────────────────────── */
            body::before {
                content: '';
                position: fixed;
                inset: 0;
                background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.035'/%3E%3C/svg%3E");
                pointer-events: none;
                z-index: 9999;
                opacity: 0.4;
            }

            /* ── GLOW BLOBS ─────────────────────────────── */
            .blob {
                position: fixed;
                border-radius: 50%;
                filter: blur(120px);
                pointer-events: none;
                z-index: 0;
                animation: blobDrift 18s ease-in-out infinite alternate;
            }

            .blob-1 {
                width: 700px;
                height: 700px;
                background: rgba(78, 255, 176, 0.05);
                top: -200px;
                left: -200px;
                animation-delay: 0s;
            }

            .blob-2 {
                width: 600px;
                height: 600px;
                background: rgba(168, 85, 247, 0.06);
                top: 40%;
                right: -250px;
                animation-delay: -6s;
            }

            .blob-3 {
                width: 500px;
                height: 500px;
                background: rgba(0, 212, 255, 0.04);
                bottom: -150px;
                left: 30%;
                animation-delay: -12s;
            }

            @keyframes blobDrift {
                0% {
                    transform: translate(0, 0) scale(1);
                }

                100% {
                    transform: translate(40px, 30px) scale(1.08);
                }
            }

            /* ── CONTAINER ──────────────────────────────── */
            .container {
                max-width: 1160px;
                margin: 0 auto;
                padding: 0 24px;
            }

            /* ── NAVBAR ─────────────────────────────────── */
            .navbar {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                padding: 0;
                transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .navbar.scrolled .nav-inner {
                background: rgba(7, 8, 10, 0.85);
                backdrop-filter: blur(20px) saturate(180%);
                -webkit-backdrop-filter: blur(20px) saturate(180%);
                border-color: var(--border-md);
            }

            .nav-inner {
                max-width: 1160px;
                margin: 16px auto 0;
                padding: 14px 24px;
                border-radius: var(--r-xl);
                border: 1px solid var(--border);
                display: flex;
                align-items: center;
                justify-content: space-between;
                transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .nav-brand {
                font-family: 'Syne', sans-serif;
                font-weight: 800;
                font-size: 1.2rem;
                color: var(--text) !important;
                text-decoration: none;
                letter-spacing: -0.3px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .nav-brand-icon {
                width: 32px;
                height: 32px;
                background: linear-gradient(135deg, var(--accent), var(--accent-2));
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .nav-brand-icon svg {
                width: 18px;
                height: 18px;
            }

            .nav-links {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .btn-login {
                background: transparent;
                border: none;
                color: var(--text-2);
                font-family: 'DM Sans', sans-serif;
                font-size: 0.9rem;
                font-weight: 400;
                padding: 8px 16px;
                border-radius: var(--r-sm);
                cursor: pointer;
                transition: color 0.2s;
            }

            .btn-login:hover {
                color: var(--text);
            }

            .btn-cta-nav {
                background: var(--accent);
                color: var(--ink) !important;
                font-family: 'DM Sans', sans-serif;
                font-size: 0.875rem;
                font-weight: 500;
                padding: 9px 20px;
                border-radius: 50px;
                border: none;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .btn-cta-nav:hover {
                background: #7affc5;
                transform: translateY(-1px);
                box-shadow: 0 8px 24px rgba(79, 255, 176, 0.25);
                color: var(--ink) !important;
            }

            .btn-cta-nav svg {
                transition: transform 0.2s;
            }

            .btn-cta-nav:hover svg {
                transform: translateX(2px);
            }

            /* ── HERO ───────────────────────────────────── */
            .hero {
                position: relative;
                padding: 180px 0 120px;
                text-align: center;
                z-index: 1;
                overflow: hidden;
            }

            .hero-badge {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: rgba(79, 255, 176, 0.08);
                border: 1px solid rgba(79, 255, 176, 0.2);
                border-radius: 50px;
                padding: 6px 16px 6px 8px;
                font-size: 0.82rem;
                font-weight: 500;
                color: var(--accent);
                margin-bottom: 32px;
                opacity: 0;
                animation: fadeUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) 0.1s forwards;
            }

            .hero-badge-dot {
                width: 22px;
                height: 22px;
                background: rgba(79, 255, 176, 0.15);
                border-radius: 50px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .hero-badge-dot::after {
                content: '';
                width: 8px;
                height: 8px;
                background: var(--accent);
                border-radius: 50%;
                box-shadow: 0 0 8px var(--accent);
            }

            .hero h1 {
                font-family: 'Syne', sans-serif;
                font-size: clamp(2.6rem, 6vw, 5rem);
                font-weight: 800;
                line-height: 1.08;
                letter-spacing: -2px;
                margin-bottom: 24px;
                opacity: 0;
                animation: fadeUp 0.7s cubic-bezier(0.16, 1, 0.3, 1) 0.2s forwards;
            }

            .hero h1 .line-plain {
                display: block;
                color: var(--text);
            }

            .hero h1 .line-grad {
                display: block;
                background: linear-gradient(90deg, var(--accent) 0%, var(--accent-2) 50%, var(--accent-3) 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .hero p {
                color: var(--text-2);
                font-size: 1.125rem;
                font-weight: 300;
                max-width: 520px;
                margin: 0 auto 40px;
                line-height: 1.7;
                opacity: 0;
                animation: fadeUp 0.7s cubic-bezier(0.16, 1, 0.3, 1) 0.35s forwards;
            }

            .hero-ctas {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 14px;
                flex-wrap: wrap;
                opacity: 0;
                animation: fadeUp 0.7s cubic-bezier(0.16, 1, 0.3, 1) 0.5s forwards;
            }

            .btn-hero-primary {
                background: var(--accent);
                color: var(--ink);
                font-family: 'DM Sans', sans-serif;
                font-size: 1rem;
                font-weight: 500;
                padding: 14px 32px;
                border-radius: 50px;
                border: none;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .btn-hero-primary:hover {
                background: #7affc5;
                color: var(--ink);
                transform: translateY(-3px);
                box-shadow: 0 16px 40px rgba(79, 255, 176, 0.3);
            }

            .btn-hero-secondary {
                background: var(--surface-md);
                color: var(--text-2);
                font-family: 'DM Sans', sans-serif;
                font-size: 1rem;
                font-weight: 400;
                padding: 14px 28px;
                border-radius: 50px;
                border: 1px solid var(--border-md);
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .btn-hero-secondary:hover {
                background: rgba(255, 255, 255, 0.1);
                color: var(--text);
                border-color: rgba(255, 255, 255, 0.2);
            }

            /* ── HERO VISUAL / DASHBOARD MOCKUP ─────────── */
            .hero-visual {
                margin: 72px auto 0;
                max-width: 900px;
                position: relative;
                opacity: 0;
                animation: fadeUp 0.9s cubic-bezier(0.16, 1, 0.3, 1) 0.7s forwards;
            }

            .hero-visual::before {
                content: '';
                position: absolute;
                bottom: -1px;
                left: 0;
                right: 0;
                height: 200px;
                background: linear-gradient(to top, var(--ink), transparent);
                z-index: 2;
                pointer-events: none;
            }

            .dashboard-card {
                background: rgba(26, 29, 35, 0.9);
                border: 1px solid var(--border-md);
                border-radius: var(--r-xl);
                padding: 28px;
                backdrop-filter: blur(24px);
                box-shadow:
                    0 0 0 1px rgba(255, 255, 255, 0.04),
                    0 40px 80px rgba(0, 0, 0, 0.6),
                    0 0 120px rgba(79, 255, 176, 0.06);
            }

            .dashboard-topbar {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 24px;
            }

            .dashboard-dots {
                display: flex;
                gap: 8px;
            }

            .dashboard-dots span {
                width: 12px;
                height: 12px;
                border-radius: 50%;
            }

            .dot-r {
                background: #ff5f57;
            }

            .dot-y {
                background: #febc2e;
            }

            .dot-g {
                background: #28c840;
            }

            .dashboard-tabs {
                display: flex;
                gap: 4px;
            }

            .dashboard-tab {
                font-size: 0.78rem;
                padding: 5px 14px;
                border-radius: 50px;
                color: var(--text-3);
                cursor: pointer;
            }

            .dashboard-tab.active {
                background: var(--surface-md);
                color: var(--text);
            }

            .dashboard-grid {
                display: grid;
                grid-template-columns: 2fr 1fr 1fr;
                gap: 16px;
                margin-bottom: 20px;
            }

            .dash-stat {
                background: var(--surface);
                border: 1px solid var(--border);
                border-radius: var(--r-md);
                padding: 20px;
            }

            .dash-stat-label {
                font-size: 0.75rem;
                color: var(--text-3);
                margin-bottom: 8px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .dash-stat-value {
                font-family: 'Syne', sans-serif;
                font-size: 1.6rem;
                font-weight: 700;
            }

            .dash-stat-value.green {
                color: var(--accent);
            }

            .dash-stat-value.white {
                color: var(--text);
            }

            .dash-stat-change {
                font-size: 0.78rem;
                color: var(--accent);
                margin-top: 4px;
            }

            .dash-stat-change.neg {
                color: #ff6b6b;
            }

            /* Mini bar chart */
            .mini-chart {
                display: flex;
                align-items: flex-end;
                gap: 5px;
                height: 52px;
                margin-top: 12px;
            }

            .mini-bar {
                flex: 1;
                border-radius: 4px 4px 0 0;
                background: var(--surface-md);
                transition: background 0.3s;
            }

            .mini-bar.highlight {
                background: linear-gradient(to top, var(--accent), var(--accent-2));
            }

            .dash-list {
                display: flex;
                flex-direction: column;
                gap: 10px;
                margin-top: 4px;
            }

            .dash-list-item {
                display: flex;
                align-items: center;
                justify-content: space-between;
                background: var(--surface);
                border: 1px solid var(--border);
                border-radius: var(--r-sm);
                padding: 12px 16px;
                font-size: 0.85rem;
            }

            .dash-list-left {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .dash-list-icon {
                width: 32px;
                height: 32px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.9rem;
            }

            .dash-amount {
                font-weight: 500;
                color: var(--text);
            }

            .dash-amount.green {
                color: var(--accent);
            }

            /* ── SOCIAL PROOF LOGOS ─────────────────────── */
            .logos-strip {
                padding: 48px 0;
                border-top: 1px solid var(--border);
                border-bottom: 1px solid var(--border);
                position: relative;
                z-index: 1;
            }

            .logos-strip-label {
                text-align: center;
                font-size: 0.78rem;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                color: var(--text-3);
                margin-bottom: 24px;
            }

            .logos-row {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 48px;
                flex-wrap: wrap;
            }

            .logo-item {
                font-family: 'Syne', sans-serif;
                font-weight: 700;
                font-size: 1rem;
                color: var(--text-3);
                letter-spacing: -0.5px;
                transition: color 0.2s;
            }

            .logo-item:hover {
                color: var(--text-2);
            }

            /* ── SECTION UTILITY ────────────────────────── */
            section {
                position: relative;
                z-index: 1;
            }

            .section-label {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                font-size: 0.78rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                color: var(--accent);
                margin-bottom: 16px;
            }

            .section-label::before {
                content: '';
                width: 20px;
                height: 1px;
                background: var(--accent);
            }

            .section-title {
                font-family: 'Syne', sans-serif;
                font-size: clamp(1.8rem, 3.5vw, 2.8rem);
                font-weight: 800;
                letter-spacing: -1px;
                line-height: 1.15;
                margin-bottom: 16px;
                color: var(--text);
            }

            .section-sub {
                color: var(--text-2);
                font-size: 1.05rem;
                font-weight: 300;
                max-width: 480px;
                line-height: 1.7;
            }

            /* ── FEATURES ───────────────────────────────── */
            .features {
                padding: 100px 0;
            }

            .features-header {
                text-align: center;
                margin-bottom: 64px;
            }

            .features-header .section-sub {
                margin: 0 auto;
            }

            .features-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 16px;
            }

            .feature-card {
                background: var(--surface);
                border: 1px solid var(--border);
                border-radius: var(--r-lg);
                padding: 32px;
                position: relative;
                overflow: hidden;
                transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
                cursor: default;
            }

            .feature-card::after {
                content: '';
                position: absolute;
                inset: 0;
                border-radius: var(--r-lg);
                opacity: 0;
                transition: opacity 0.4s;
                background: radial-gradient(600px circle at var(--mouse-x, 50%) var(--mouse-y, 50%), rgba(79, 255, 176, 0.06), transparent 40%);
            }

            .feature-card:hover {
                border-color: rgba(79, 255, 176, 0.2);
                transform: translateY(-4px);
            }

            .feature-card:hover::after {
                opacity: 1;
            }

            .feature-card.large {
                grid-column: span 2;
            }

            .feature-icon-wrap {
                width: 48px;
                height: 48px;
                border-radius: var(--r-sm);
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 20px;
            }

            .icon-mint {
                background: rgba(79, 255, 176, 0.1);
            }

            .icon-cyan {
                background: rgba(0, 212, 255, 0.1);
            }

            .icon-violet {
                background: rgba(168, 85, 247, 0.1);
            }

            .icon-gold {
                background: rgba(245, 200, 66, 0.1);
            }

            .feature-title {
                font-family: 'Syne', sans-serif;
                font-size: 1.15rem;
                font-weight: 700;
                margin-bottom: 10px;
                color: var(--text);
            }

            .feature-text {
                color: var(--text-2);
                font-size: 0.9rem;
                line-height: 1.65;
                font-weight: 300;
            }

            .feature-tag {
                display: inline-block;
                font-size: 0.72rem;
                font-weight: 500;
                padding: 3px 10px;
                border-radius: 50px;
                margin-top: 16px;
                letter-spacing: 0.3px;
            }

            .tag-mint {
                background: rgba(79, 255, 176, 0.1);
                color: var(--accent);
            }

            .tag-cyan {
                background: rgba(0, 212, 255, 0.1);
                color: var(--accent-2);
            }

            .tag-violet {
                background: rgba(168, 85, 247, 0.1);
                color: var(--accent-3);
            }

            /* ── BENTO / SHOWCASE ───────────────────────── */
            .showcase {
                padding: 0 0 100px;
            }

            .bento-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                grid-template-rows: auto;
                gap: 16px;
            }

            .bento-card {
                background: var(--surface);
                border: 1px solid var(--border);
                border-radius: var(--r-xl);
                padding: 36px;
                overflow: hidden;
                position: relative;
                transition: border-color 0.3s;
            }

            .bento-card:hover {
                border-color: var(--border-md);
            }

            .bento-card.tall {
                grid-row: span 2;
                display: flex;
                flex-direction: column;
            }

            .bento-title {
                font-family: 'Syne', sans-serif;
                font-size: 1.35rem;
                font-weight: 700;
                margin-bottom: 10px;
            }

            .bento-body {
                color: var(--text-2);
                font-size: 0.9rem;
                line-height: 1.6;
                font-weight: 300;
            }

            /* Radial progress ring */
            .ring-wrap {
                margin: 28px auto 0;
                width: 160px;
                height: 160px;
                position: relative;
            }

            .ring-wrap svg {
                transform: rotate(-90deg);
            }

            .ring-bg {
                fill: none;
                stroke: var(--border-md);
                stroke-width: 8;
            }

            .ring-fill {
                fill: none;
                stroke: url(#ringGrad);
                stroke-width: 8;
                stroke-linecap: round;
                stroke-dasharray: 408;
                stroke-dashoffset: 102;
                /* 75% */
                animation: ringAnim 1.4s cubic-bezier(0.16, 1, 0.3, 1) 0.8s both;
            }

            @keyframes ringAnim {
                from {
                    stroke-dashoffset: 408;
                }

                to {
                    stroke-dashoffset: 102;
                }
            }

            .ring-center {
                position: absolute;
                inset: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }

            .ring-pct {
                font-family: 'Syne', sans-serif;
                font-size: 2rem;
                font-weight: 800;
                color: var(--accent);
            }

            .ring-label {
                font-size: 0.72rem;
                color: var(--text-3);
            }

            /* Sparkline */
            .sparkline-wrap {
                margin-top: 24px;
            }

            .sparkline-row {
                display: flex;
                align-items: flex-end;
                gap: 4px;
                height: 80px;
            }

            .spark-bar {
                flex: 1;
                border-radius: 4px 4px 0 0;
                background: var(--surface-md);
                position: relative;
            }

            .spark-bar.lit {
                background: linear-gradient(to top, var(--accent-3), #c084fc);
            }

            .spark-bar .tip {
                position: absolute;
                top: -24px;
                left: 50%;
                transform: translateX(-50%);
                background: var(--ink-3);
                border: 1px solid var(--border-md);
                font-size: 0.68rem;
                white-space: nowrap;
                padding: 3px 8px;
                border-radius: 4px;
                color: var(--text);
                opacity: 0;
                transition: opacity 0.2s;
            }

            .spark-bar:hover .tip {
                opacity: 1;
            }

            .sparkline-xaxis {
                display: flex;
                justify-content: space-between;
                margin-top: 8px;
                font-size: 0.7rem;
                color: var(--text-3);
            }

            /* Goal bars */
            .goal-list {
                display: flex;
                flex-direction: column;
                gap: 16px;
                margin-top: 24px;
            }

            .goal-row {}

            .goal-top {
                display: flex;
                justify-content: space-between;
                font-size: 0.82rem;
                margin-bottom: 6px;
            }

            .goal-name {
                color: var(--text-2);
            }

            .goal-pct {
                color: var(--text);
                font-weight: 500;
            }

            .goal-track {
                height: 6px;
                background: var(--surface-md);
                border-radius: 50px;
                overflow: hidden;
            }

            .goal-fill {
                height: 100%;
                border-radius: 50px;
            }

            /* AI insight card */
            .insight-chip {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: rgba(168, 85, 247, 0.08);
                border: 1px solid rgba(168, 85, 247, 0.2);
                border-radius: var(--r-sm);
                padding: 12px 16px;
                font-size: 0.85rem;
                color: var(--text-2);
                margin-top: 24px;
                line-height: 1.5;
            }

            .insight-chip svg {
                flex-shrink: 0;
            }

            /* ── TESTIMONIALS ───────────────────────────── */
            .testimonials {
                padding: 100px 0;
                background: var(--surface);
                border-top: 1px solid var(--border);
                border-bottom: 1px solid var(--border);
            }

            .testi-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 16px;
                margin-top: 56px;
            }

            .testi-card {
                background: var(--ink-2);
                border: 1px solid var(--border);
                border-radius: var(--r-lg);
                padding: 28px;
                transition: border-color 0.3s, transform 0.3s;
            }

            .testi-card:hover {
                border-color: var(--border-md);
                transform: translateY(-3px);
            }

            .testi-stars {
                display: flex;
                gap: 3px;
                margin-bottom: 16px;
            }

            .testi-stars span {
                color: var(--gold);
                font-size: 0.9rem;
            }

            .testi-text {
                color: var(--text-2);
                font-size: 0.9rem;
                line-height: 1.7;
                font-weight: 300;
                margin-bottom: 20px;
            }

            .testi-author {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .testi-avatar {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Syne', sans-serif;
                font-weight: 700;
                font-size: 0.85rem;
            }

            .testi-name {
                font-weight: 500;
                font-size: 0.88rem;
                color: var(--text);
            }

            .testi-role {
                font-size: 0.78rem;
                color: var(--text-3);
            }

            /* ── CTA SECTION ────────────────────────────── */
            .cta-section {
                padding: 120px 0;
                text-align: center;
            }

            .cta-box {
                background: linear-gradient(135deg, rgba(79, 255, 176, 0.04) 0%, rgba(168, 85, 247, 0.04) 100%);
                border: 1px solid var(--border-md);
                border-radius: var(--r-xl);
                padding: 80px 48px;
                position: relative;
                overflow: hidden;
            }

            .cta-box::before {
                content: '';
                position: absolute;
                top: -80px;
                left: 50%;
                transform: translateX(-50%);
                width: 600px;
                height: 300px;
                background: radial-gradient(ellipse, rgba(79, 255, 176, 0.08) 0%, transparent 70%);
                pointer-events: none;
            }

            .cta-box .section-title {
                font-size: clamp(2rem, 4vw, 3.2rem);
            }

            .cta-box .section-sub {
                margin: 0 auto 40px;
                font-size: 1.1rem;
            }

            .cta-form {
                display: flex;
                align-items: center;
                gap: 12px;
                max-width: 440px;
                margin: 0 auto;
            }

            .cta-input {
                flex: 1;
                background: rgba(255, 255, 255, 0.04);
                border: 1px solid var(--border-md);
                border-radius: 50px;
                padding: 13px 20px;
                color: var(--text);
                font-family: 'DM Sans', sans-serif;
                font-size: 0.9rem;
                outline: none;
                transition: border-color 0.2s, box-shadow 0.2s;
            }

            .cta-input:focus {
                border-color: rgba(79, 255, 176, 0.4);
                box-shadow: 0 0 0 3px rgba(79, 255, 176, 0.08);
            }

            .cta-input::placeholder {
                color: var(--text-3);
            }

            .btn-cta-submit {
                background: var(--accent);
                color: var(--ink);
                font-family: 'DM Sans', sans-serif;
                font-size: 0.9rem;
                font-weight: 500;
                padding: 13px 24px;
                border-radius: 50px;
                border: none;
                cursor: pointer;
                white-space: nowrap;
                transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .btn-cta-submit:hover {
                background: #7affc5;
                transform: translateY(-2px);
                box-shadow: 0 12px 28px rgba(79, 255, 176, 0.25);
            }

            .cta-footnote {
                font-size: 0.78rem;
                color: var(--text-3);
                margin-top: 16px;
            }

            /* ── FOOTER ─────────────────────────────────── */
            .footer {
                border-top: 1px solid var(--border);
                padding: 56px 0 40px;
                position: relative;
                z-index: 1;
            }

            .footer-grid {
                display: grid;
                grid-template-columns: 1.6fr 1fr 1fr 1fr;
                gap: 40px;
                margin-bottom: 56px;
            }

            .footer-brand {
                font-family: 'Syne', sans-serif;
                font-weight: 800;
                font-size: 1.1rem;
                margin-bottom: 12px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .footer-brand-tagline {
                color: var(--text-3);
                font-size: 0.85rem;
                line-height: 1.6;
                font-weight: 300;
                max-width: 240px;
            }

            .footer-col-title {
                font-size: 0.78rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: var(--text-3);
                margin-bottom: 16px;
            }

            .footer-links {
                list-style: none;
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .footer-links a {
                color: var(--text-2);
                font-size: 0.88rem;
                text-decoration: none;
                transition: color 0.2s;
            }

            .footer-links a:hover {
                color: var(--text);
            }

            .footer-bottom {
                border-top: 1px solid var(--border);
                padding-top: 28px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 16px;
                flex-wrap: wrap;
            }

            .footer-copy {
                color: var(--text-3);
                font-size: 0.82rem;
            }

            .footer-legal {
                display: flex;
                gap: 20px;
            }

            .footer-legal a {
                color: var(--text-3);
                font-size: 0.82rem;
                text-decoration: none;
                transition: color 0.2s;
            }

            .footer-legal a:hover {
                color: var(--text-2);
            }

            /* ── MODAL ──────────────────────────────────── */
            .modal-backdrop {
                --bs-backdrop-opacity: 0.7;
            }

            .modal-content {
                background: var(--ink-2);
                border: 1px solid var(--border-md);
                border-radius: var(--r-xl);
                color: var(--text);
                backdrop-filter: blur(24px);
                box-shadow: 0 40px 80px rgba(0, 0, 0, 0.6);
            }

            .modal-header {
                border-bottom: 1px solid var(--border);
                padding: 24px 28px 20px;
            }

            .modal-body {
                padding: 28px;
            }

            .modal-footer {
                border-top: 1px solid var(--border);
                padding: 20px 28px;
            }

            .modal-title {
                font-family: 'Syne', sans-serif;
                font-weight: 700;
                font-size: 1.25rem;
                letter-spacing: -0.3px;
            }

            .modal-subtitle {
                color: var(--text-2);
                font-size: 0.85rem;
                margin-top: 4px;
            }

            .form-label {
                color: var(--text-3);
                font-size: 0.8rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 6px;
            }

            .form-control {
                background: rgba(255, 255, 255, 0.04) !important;
                border: 1px solid var(--border-md) !important;
                color: var(--text) !important;
                border-radius: var(--r-sm);
                padding: 12px 16px;
                font-family: 'DM Sans', sans-serif;
                font-size: 0.9rem;
                transition: border-color 0.2s, box-shadow 0.2s;
            }

            .form-control:focus {
                border-color: rgba(79, 255, 176, 0.4) !important;
                box-shadow: 0 0 0 3px rgba(79, 255, 176, 0.08) !important;
                outline: none;
            }

            .form-control::placeholder {
                color: var(--text-3) !important;
            }

            .btn-modal-submit {
                background: var(--accent);
                color: var(--ink);
                font-family: 'DM Sans', sans-serif;
                font-size: 0.95rem;
                font-weight: 500;
                padding: 12px;
                border-radius: 50px;
                border: none;
                width: 100%;
                cursor: pointer;
                transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .btn-modal-submit:hover {
                background: #7affc5;
                transform: translateY(-1px);
                box-shadow: 0 8px 24px rgba(79, 255, 176, 0.2);
            }

            .btn-close {
                filter: invert(0.7) brightness(1.5);
            }

            .modal-footer-note {
                font-size: 0.82rem;
                color: var(--text-3);
                text-align: center;
            }

            .modal-footer-note a {
                color: var(--accent);
                text-decoration: none;
            }

            .modal-footer-note a:hover {
                text-decoration: underline;
            }

            /* ── ANIMATIONS ─────────────────────────────── */
            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(24px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .reveal {
                opacity: 0;
                transform: translateY(28px);
                transition: opacity 0.7s cubic-bezier(0.16, 1, 0.3, 1), transform 0.7s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .reveal.in-view {
                opacity: 1;
                transform: translateY(0);
            }

            .reveal-delay-1 {
                transition-delay: 0.1s;
            }

            .reveal-delay-2 {
                transition-delay: 0.2s;
            }

            .reveal-delay-3 {
                transition-delay: 0.3s;
            }

            .reveal-delay-4 {
                transition-delay: 0.4s;
            }

            .reveal-delay-5 {
                transition-delay: 0.5s;
            }

            /* ── RESPONSIVE ─────────────────────────────── */
            @media (max-width: 900px) {
                .features-grid {
                    grid-template-columns: 1fr 1fr;
                }

                .feature-card.large {
                    grid-column: span 2;
                }

                .bento-grid {
                    grid-template-columns: 1fr;
                }

                .bento-card.tall {
                    grid-row: span 1;
                }

                .testi-grid {
                    grid-template-columns: 1fr;
                }

                .footer-grid {
                    grid-template-columns: 1fr 1fr;
                }

                .dashboard-grid {
                    grid-template-columns: 1fr 1fr;
                }
            }

            @media (max-width: 600px) {
                .features-grid {
                    grid-template-columns: 1fr;
                }

                .feature-card.large {
                    grid-column: span 1;
                }

                .footer-grid {
                    grid-template-columns: 1fr;
                }

                .cta-form {
                    flex-direction: column;
                }

                .cta-input,
                .btn-cta-submit {
                    width: 100%;
                    text-align: center;
                }

                .hero h1 {
                    letter-spacing: -1px;
                }

                .dashboard-grid {
                    grid-template-columns: 1fr;
                }

                .nav-inner {
                    margin: 10px 16px 0;
                    padding: 12px 16px;
                    border-radius: var(--r-lg);
                }
            }
        </style>
    </head>

    <body>

        <!-- Ambient blobs -->
        <div class="blob blob-1"></div>
        <div class="blob blob-2"></div>
        <div class="blob blob-3"></div>

        <!-- ░░ NAVBAR ░░ -->
        <nav class="navbar" id="navbar">
            <div class="nav-inner">
                <a href="#" class="nav-brand">
                    <span class="nav-brand-icon">
                        <svg viewBox="0 0 18 18" fill="none">
                            <path d="M9 2L15.5 6V12L9 16L2.5 12V6L9 2Z" stroke="#07080a" stroke-width="1.5"
                                fill="#4fffb0" />
                        </svg>
                    </span>
                    NextGen Finance
                </a>
                <div class="nav-links">
                    <button class="btn-login" data-bs-toggle="modal" data-bs-target="#loginModal">Log in</button>
                    <a href="/register" class="btn-cta-nav">
                        Get Started
                        <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
                            <path d="M3 7h8M7.5 3.5L11 7l-3.5 3.5" stroke="currentColor" stroke-width="1.5"
                                stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </a>
                </div>
            </div>
        </nav>

        <!-- ░░ HERO ░░ -->
        <section class="hero">
            <div class="container">
                <div class="hero-badge">
                    <span class="hero-badge-dot"></span>
                    Now with AI forecasting 97% accuracy
                </div>
                <h1>
                    <span class="line-plain">Financial intelligence,</span>
                    <span class="line-grad">simplified.</span>
                </h1>
                <p>Experience the next generation of personal finance. AI-driven insights for smarter budgeting, expense
                    tracking, and goal-setting — all in one place.</p>
                <div class="hero-ctas">
                    <a href="/register" class="btn-hero-primary">
                        Start free today
                        <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                            <path d="M3 8h10M8.5 4L13 8l-4.5 4" stroke="currentColor" stroke-width="1.5"
                                stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </a>
                    <button class="btn-hero-secondary" data-bs-toggle="modal" data-bs-target="#loginModal">
                        <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                            <circle cx="8" cy="8" r="6" stroke="currentColor" stroke-width="1.3" />
                            <path d="M6.5 6C6.5 5.17 7.17 4.5 8 4.5S9.5 5.17 9.5 6C9.5 6.83 8.83 7.5 8 7.5"
                                stroke="currentColor" stroke-width="1.3" stroke-linecap="round" />
                            <circle cx="8" cy="10.5" r="0.75" fill="currentColor" />
                        </svg>
                        Sign in
                    </button>
                </div>

                <!-- Dashboard Mockup -->
                <div class="hero-visual">
                    <div class="dashboard-card">
                        <div class="dashboard-topbar">
                            <div class="dashboard-dots">
                                <span class="dot-r"></span>
                                <span class="dot-y"></span>
                                <span class="dot-g"></span>
                            </div>
                            <div class="dashboard-tabs">
                                <span class="dashboard-tab active">Overview</span>
                                <span class="dashboard-tab">Analytics</span>
                                <span class="dashboard-tab">Goals</span>
                            </div>
                            <div style="font-size:0.75rem;color:var(--text-3)">March 2026</div>
                        </div>

                        <div class="dashboard-grid">
                            <div class="dash-stat">
                                <div class="dash-stat-label">Net Worth</div>
                                <div class="dash-stat-value green">Rs. 84,230</div>
                                <div class="dash-stat-change">↑ 12.4% this month</div>
                                <div class="mini-chart">
                                    <div class="mini-bar" style="height:40%"></div>
                                    <div class="mini-bar" style="height:55%"></div>
                                    <div class="mini-bar" style="height:48%"></div>
                                    <div class="mini-bar" style="height:63%"></div>
                                    <div class="mini-bar" style="height:70%"></div>
                                    <div class="mini-bar" style="height:58%"></div>
                                    <div class="mini-bar highlight" style="height:85%"></div>
                                </div>
                            </div>
                            <div class="dash-stat">
                                <div class="dash-stat-label">Monthly Spend</div>
                                <div class="dash-stat-value white">Rs. 3,412</div>
                                <div class="dash-stat-change neg">UP 4.1% vs last month</div>
                            </div>
                            <div class="dash-stat">
                                <div class="dash-stat-label">Savings Rate</div>
                                <div class="dash-stat-value green">34%</div>
                                <div class="dash-stat-change">UP 6% vs target</div>
                            </div>
                        </div>

                        <div class="dash-list">
                            <div class="dash-list-item">
                                <div class="dash-list-left">
                                    <div class="dash-list-icon" style="background:rgba(79,255,176,0.1)">🛒</div>
                                    <div>
                                        <div style="color:var(--text);font-size:0.85rem">Grocery Store</div>
                                        <div style="color:var(--text-3);font-size:0.72rem">Today, 11:23 AM</div>
                                    </div>
                                </div>
                                <div class="dash-amount" style="color:#ff6b6b">- Rs. 64.20</div>
                            </div>
                            <div class="dash-list-item">
                                <div class="dash-list-left">
                                    <div class="dash-list-icon" style="background:rgba(0,212,255,0.1)">💰</div>
                                    <div>
                                        <div style="color:var(--text);font-size:0.85rem">Salary Deposit</div>
                                        <div style="color:var(--text-3);font-size:0.72rem">Today, 09:00 AM</div>
                                    </div>
                                </div>
                                <div class="dash-amount green">+ Rs. 5,200.00</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ░░ LOGO STRIP ░░ -->
        <div class="logos-strip">
            <div class="container">
                <p class="logos-strip-label">Trusted by forward-thinking individuals</p>
                <div class="logos-row">
                    <span class="logo-item">Coinbase</span>
                    <span class="logo-item">Revolut</span>
                    <span class="logo-item">N26</span>
                    <span class="logo-item">Wealthfront</span>
                    <span class="logo-item">Betterment</span>
                    <span class="logo-item">Robinhood</span>
                </div>
            </div>
        </div>

        <!-- ░░ FEATURES ░░ -->
        <section class="features">
            <div class="container">
                <div class="features-header reveal">
                    <div class="section-label">Core Features</div>
                    <h2 class="section-title">Everything you need to<br>master your money</h2>
                    <p class="section-sub">Built with the tools and intelligence to take you from surviving to thriving
                        — financially.</p>
                </div>

                <div class="features-grid">
                    <div class="feature-card large reveal reveal-delay-1">
                        <div class="feature-icon-wrap icon-mint">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <path d="M12 2L2 7l10 5 10-5-10-5z" stroke="#4fffb0" stroke-width="1.5"
                                    stroke-linejoin="round" />
                                <path d="M2 17l10 5 10-5" stroke="#4fffb0" stroke-width="1.5" stroke-linejoin="round" />
                                <path d="M2 12l10 5 10-5" stroke="#4fffb0" stroke-width="1.5" stroke-linejoin="round" />
                            </svg>
                        </div>
                        <div class="feature-title">AI Predictions & Forecasting</div>
                        <div class="feature-text">Leverage advanced machine learning models trained on millions of
                            spending patterns to forecast your future expenses with 97% accuracy. Get proactive alerts
                            before you overspend.</div>
                        <span class="feature-tag tag-mint">Powered by ML</span>
                    </div>

                    <div class="feature-card reveal reveal-delay-2">
                        <div class="feature-icon-wrap icon-cyan">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <path d="M18 20V10M12 20V4M6 20v-6" stroke="#00d4ff" stroke-width="1.5"
                                    stroke-linecap="round" />
                            </svg>
                        </div>
                        <div class="feature-title">Expense Tracking</div>
                        <div class="feature-text">Gain full visibility into your spending. Auto-categorize transactions
                            and spot patterns instantly.</div>
                        <span class="feature-tag tag-cyan">Real-time</span>
                    </div>

                    <div class="feature-card reveal reveal-delay-3">
                        <div class="feature-icon-wrap icon-violet">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <circle cx="12" cy="12" r="9" stroke="#a855f7" stroke-width="1.5" />
                                <path d="M12 7v5l3 3" stroke="#a855f7" stroke-width="1.5" stroke-linecap="round" />
                            </svg>
                        </div>
                        <div class="feature-title">Goal Setter</div>
                        <div class="feature-text">Define financial milestones and let our engine chart your fastest path
                            to reaching them.</div>
                        <span class="feature-tag tag-violet">Adaptive</span>
                    </div>

                    <div class="feature-card reveal reveal-delay-4">
                        <div class="feature-icon-wrap icon-gold">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" stroke="#f5c842"
                                    stroke-width="1.5" stroke-linejoin="round" />
                            </svg>
                        </div>
                        <div class="feature-title">Bank-grade Security</div>
                        <div class="feature-text">256-bit encryption and read-only bank connections. Your data is always
                            protected.</div>
                    </div>

                    <div class="feature-card reveal reveal-delay-5">
                        <div class="feature-icon-wrap icon-mint">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <path d="M17 8C8 10 5.9 16.17 3.82 19.5" stroke="#4fffb0" stroke-width="1.5"
                                    stroke-linecap="round" />
                                <path d="M14 11.5C14 11.5 13 15 7 18" stroke="#4fffb0" stroke-width="1.5"
                                    stroke-linecap="round" />
                                <circle cx="19" cy="6" r="2" stroke="#4fffb0" stroke-width="1.5" />
                            </svg>
                        </div>
                        <div class="feature-title">Smart Insights</div>
                        <div class="feature-text">Weekly digest emails and push notifications keep you informed without
                            the noise.</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ░░ BENTO SHOWCASE ░░ -->
        <section class="showcase">
            <div class="container">
                <div class="reveal" style="margin-bottom:48px">
                    <div class="section-label">Product</div>
                    <h2 class="section-title">Built for clarity,<br>designed for action</h2>
                </div>

                <div class="bento-grid">
                    <!-- Savings ring -->
                    <div class="bento-card tall reveal reveal-delay-1">
                        <div class="section-label">Goal Progress</div>
                        <div class="bento-title">Emergency Fund</div>
                        <div class="bento-body">You're 75% of the way to your Rs. 10,000 target. At your current rate,
                            you'll hit it in 6 weeks.</div>
                        <div class="ring-wrap">
                            <svg width="160" height="160" viewBox="0 0 160 160">
                                <defs>
                                    <linearGradient id="ringGrad" x1="0%" y1="0%" x2="100%" y2="0%">
                                        <stop offset="0%" stop-color="#4fffb0" />
                                        <stop offset="100%" stop-color="#00d4ff" />
                                    </linearGradient>
                                </defs>
                                <circle class="ring-bg" cx="80" cy="80" r="65" />
                                <circle class="ring-fill" cx="80" cy="80" r="65" />
                            </svg>
                            <div class="ring-center">
                                <div class="ring-pct">75%</div>
                                <div class="ring-label">FUNDED</div>
                            </div>
                        </div>
                        <div class="insight-chip">
                            <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                                <path d="M8 1l1.8 3.6L14 5.4l-3 2.9.7 4.1L8 10.4l-3.7 2 .7-4.1L2 5.4l4.2-.8L8 1z"
                                    stroke="#a855f7" stroke-width="1.2" stroke-linejoin="round" />
                            </svg>
                            AI suggests increasing savings by Rs. 80/mo to hit your goal 2 weeks early.
                        </div>
                    </div>

                    <!-- Spending sparkline -->
                    <div class="bento-card reveal reveal-delay-2">
                        <div class="section-label">Spending Trend</div>
                        <div class="bento-title">Monthly Overview</div>
                        <div class="bento-body">Your spending is 14% below the national average for your income bracket.
                        </div>
                        <div class="sparkline-wrap">
                            <div class="sparkline-row">
                                <div class="spark-bar" style="height:55%"><span class="tip">Rs. 2,810</span></div>
                                <div class="spark-bar" style="height:70%"><span class="tip">Rs. 3,200</span></div>
                                <div class="spark-bar" style="height:45%"><span class="tip">Rs. 2,600</span></div>
                                <div class="spark-bar" style="height:80%"><span class="tip">Rs. 3,500</span></div>
                                <div class="spark-bar" style="height:60%"><span class="tip">Rs. 3,100</span></div>
                                <div class="spark-bar lit" style="height:72%"><span class="tip">Rs. 3,412</span></div>
                            </div>
                            <div class="sparkline-xaxis">
                                <span>Oct</span><span>Nov</span><span>Dec</span><span>Jan</span><span>Feb</span><span>Mar</span>
                            </div>
                        </div>
                    </div>

                    <!-- Goal bars -->
                    <div class="bento-card reveal reveal-delay-3">
                        <div class="section-label">Milestones</div>
                        <div class="bento-title">Your Goals</div>
                        <div class="goal-list">
                            <div class="goal-row">
                                <div class="goal-top"><span class="goal-name">Emergency Fund</span><span
                                        class="goal-pct">75%</span></div>
                                <div class="goal-track">
                                    <div class="goal-fill"
                                        style="width:75%;background:linear-gradient(90deg,#4fffb0,#00d4ff)"></div>
                                </div>
                            </div>
                            <div class="goal-row">
                                <div class="goal-top"><span class="goal-name">Vacation to Japan</span><span
                                        class="goal-pct">42%</span></div>
                                <div class="goal-track">
                                    <div class="goal-fill"
                                        style="width:42%;background:linear-gradient(90deg,#a855f7,#00d4ff)"></div>
                                </div>
                            </div>
                            <div class="goal-row">
                                <div class="goal-top"><span class="goal-name">Down Payment</span><span
                                        class="goal-pct">18%</span></div>
                                <div class="goal-track">
                                    <div class="goal-fill"
                                        style="width:18%;background:linear-gradient(90deg,#f5c842,#f87171)"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ░░ TESTIMONIALS ░░ -->
        <section class="testimonials">
            <div class="container">
                <div class="reveal" style="text-align:center">
                    <div class="section-label" style="justify-content:center">Social Proof</div>
                    <h2 class="section-title">Loved by thousands<br>of smart savers</h2>
                </div>

                <div class="testi-grid">
                    <div class="testi-card reveal reveal-delay-1">
                        <div class="testi-stars">
                            <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                        </div>
                        <p class="testi-text">"I finally understand where my money is going. The AI predictions are
                            eerily accurate — it flagged I was trending toward overspending a week before I realised it
                            myself."</p>
                        <div class="testi-author">
                            <div class="testi-avatar" style="background:rgba(79,255,176,0.1);color:var(--accent)">SM
                            </div>
                            <div>
                                <div class="testi-name">Sarah M.</div>
                                <div class="testi-role">Product Designer, NYC</div>
                            </div>
                        </div>
                    </div>

                    <div class="testi-card reveal reveal-delay-2">
                        <div class="testi-stars">
                            <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                        </div>
                        <p class="testi-text">"Went from zero savings to a fully-funded emergency fund in 8 months. The
                            goal tracker and weekly insights kept me on track when motivation dipped."</p>
                        <div class="testi-author">
                            <div class="testi-avatar" style="background:rgba(0,212,255,0.1);color:var(--accent-2)">JK
                            </div>
                            <div>
                                <div class="testi-name">James K.</div>
                                <div class="testi-role">Software Engineer, London</div>
                            </div>
                        </div>
                    </div>

                    <div class="testi-card reveal reveal-delay-3">
                        <div class="testi-stars">
                            <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                        </div>
                        <p class="testi-text">"The dashboard is the most beautiful finance app I've ever used. But more
                            importantly, it's the first one I've actually stuck with for more than a month."</p>
                        <div class="testi-author">
                            <div class="testi-avatar" style="background:rgba(168,85,247,0.1);color:var(--accent-3)">AW
                            </div>
                            <div>
                                <div class="testi-name">Aisha W.</div>
                                <div class="testi-role">Freelance Consultant, Toronto</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ░░ CTA SECTION ░░ -->
        <section class="cta-section">
            <div class="container">
                <div class="cta-box reveal">
                    <div class="section-label" style="justify-content:center">Get Started</div>
                    <h2 class="section-title">Your financial future<br>starts today</h2>
                    <p class="section-sub">Join 50,000+ people who have taken control of their money with NextGen
                        Finance. Free to start — always.</p>
                    <div class="cta-form">
                        <input type="email" class="cta-input" placeholder="Enter your email address">
                        <a href="/register" class="btn-cta-submit">Start free</a>
                    </div>
                    <p class="cta-footnote">No credit card required · Free plan available · Cancel anytime</p>
                </div>
            </div>
        </section>

        <!-- ░░ FOOTER ░░ -->
        <footer class="footer">
            <div class="container">
                <div class="footer-grid">
                    <div>
                        <div class="footer-brand">
                            <span class="nav-brand-icon">
                                <svg viewBox="0 0 18 18" fill="none">
                                    <path d="M9 2L15.5 6V12L9 16L2.5 12V6L9 2Z" stroke="#07080a" stroke-width="1.5"
                                        fill="#4fffb0" />
                                </svg>
                            </span>
                            NextGen Finance
                        </div>
                        <p class="footer-brand-tagline">Intelligent financial planning for the modern era. Built for
                            clarity, designed for action.</p>
                    </div>
                    <div>
                        <div class="footer-col-title">Product</div>
                        <ul class="footer-links">
                            <li><a href="#">Features</a></li>
                            <li><a href="#">Pricing</a></li>
                            <li><a href="#">Security</a></li>
                            <li><a href="#">Roadmap</a></li>
                        </ul>
                    </div>
                    <div>
                        <div class="footer-col-title">Company</div>
                        <ul class="footer-links">
                            <li><a href="#">About</a></li>
                            <li><a href="#">Blog</a></li>
                            <li><a href="#">Careers</a></li>
                            <li><a href="#">Press</a></li>
                        </ul>
                    </div>
                    <div>
                        <div class="footer-col-title">Support</div>
                        <ul class="footer-links">
                            <li><a href="#">Help Center</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">Status</a></li>
                            <li><a href="#">Community</a></li>
                        </ul>
                    </div>
                </div>

                <div class="footer-bottom">
                    <span class="footer-copy">© 2026 NextGen Finance. Built for the future.</span>
                    <div class="footer-legal">
                        <a href="#">Privacy</a>
                        <a href="#">Terms</a>
                        <a href="#">Cookies</a>
                    </div>
                </div>
            </div>
        </footer>

        <!-- ░░ LOGIN MODAL ░░ -->
        <!-- PRESERVING BACKEND LOGIC: ID="loginModal", Action="/verify", Inputs "email", "password" -->
        <div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <div>
                            <h5 class="modal-title">Welcome back</h5>
                            <p class="modal-subtitle">Sign in to your account</p>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/verify" method="post">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email address</label>
                                <input type="email" class="form-control" name="email" id="email" required
                                    placeholder="name@example.com">
                            </div>
                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" id="password" required
                                    placeholder="Enter your password">
                            </div>
                            <button type="submit" class="btn-modal-submit">Log in</button>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <p class="modal-footer-note">Don't have an account? <a href="/register">Sign up for free</a></p>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // ── Navbar scroll effect
            const navbar = document.getElementById('navbar');
            window.addEventListener('scroll', () => {
                navbar.classList.toggle('scrolled', window.scrollY > 40);
            }, { passive: true });

            // ── Intersection Observer for reveal animations
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('in-view'); });
            }, { threshold: 0.12 });
            document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

            // ── Card magnetic glow on mouse move
            document.querySelectorAll('.feature-card').forEach(card => {
                card.addEventListener('mousemove', e => {
                    const rect = card.getBoundingClientRect();
                    card.style.setProperty('--mouse-x', `${e.clientX - rect.left}px`);
                    card.style.setProperty('--mouse-y', `${e.clientY - rect.top}px`);
                });
            });
        </script>
    </body>

    </html>