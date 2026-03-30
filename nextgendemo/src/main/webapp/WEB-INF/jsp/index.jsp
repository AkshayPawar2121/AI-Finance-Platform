<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <!DOCTYPE html>
  <html lang="en" data-bs-theme="dark">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Intelligent financial planning for the modern era.">
    <title>NextGen Finance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
      :root {
        --bg-body: #121212;
        --surface: #1e1e1e;
        --surface-hover: #2d2d2d;
        --primary: #8ab4f8;
        /* Google Blue */
        --primary-hover: #aecbfa;
        --text-main: #e8eaed;
        --text-muted: #9aa0a6;
        --border: #3c4043;
      }

      body {
        background-color: var(--bg-body) !important;
        color: var(--text-main) !important;
        font-family: 'Inter', sans-serif;
        overflow-x: hidden;
      }

      /* Navbar */
      .navbar {
        background-color: transparent;
        padding: 1.5rem 0;
        border-bottom: 1px solid transparent;
        transition: background 0.3s;
      }

      .navbar-brand {
        color: var(--text-main) !important;
        font-weight: 600;
        font-size: 1.25rem;
        letter-spacing: -0.5px;
      }

      .btn-nav-login {
        color: var(--text-main);
        font-weight: 500;
      }

      .btn-nav-signup {
        background-color: var(--primary);
        color: #202124;
        border-radius: 20px;
        padding: 8px 24px;
        font-weight: 500;
        border: none;
        transition: all 0.2s;
      }

      .btn-nav-signup:hover {
        background-color: var(--primary-hover);
        color: #202124;
      }

      /* Hero */
      .hero {
        padding: 8rem 0 6rem;
        text-align: center;
      }

      .hero h1 {
        font-size: 3.5rem;
        font-weight: 600;
        letter-spacing: -1px;
        margin-bottom: 1.5rem;
        background: linear-gradient(180deg, #ffffff, #9aa0a6);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        color: transparent;
      }

      .hero p {
        color: var(--text-muted);
        font-size: 1.25rem;
        max-width: 600px;
        margin: 0 auto 3rem;
        line-height: 1.6;
      }

      .btn-hero {
        background-color: var(--primary);
        color: #202124;
        padding: 12px 32px;
        border-radius: 24px;
        font-size: 1.1rem;
        font-weight: 500;
        text-decoration: none;
        transition: transform 0.2s;
        display: inline-block;
      }

      .btn-hero:hover {
        background-color: var(--primary-hover);
        transform: translateY(-2px);
        color: #202124;
      }

      /* Features */
      .feature-card {
        background-color: var(--surface);
        border: 1px solid var(--border);
        border-radius: 16px;
        padding: 2rem;
        height: 100%;
        transition: border-color 0.3s, transform 0.3s;
      }

      .feature-card:hover {
        border-color: var(--text-muted);
        transform: translateY(-4px);
      }

      .feature-icon {
        font-size: 2rem;
        margin-bottom: 1.5rem;
        color: var(--primary);
      }

      .feature-title {
        font-size: 1.25rem;
        font-weight: 600;
        margin-bottom: 1rem;
      }

      .feature-text {
        color: var(--text-muted);
        line-height: 1.5;
      }

      /* Footer */
      .footer {
        border-top: 1px solid var(--border);
        padding: 4rem 0;
        margin-top: 6rem;
        text-align: center;
        color: var(--text-muted);
        font-size: 0.9rem;
      }

      /* Modal */
      .modal-content {
        background-color: var(--surface);
        border: 1px solid var(--border);
        border-radius: 16px;
        color: var(--text-main);
      }

      .modal-header {
        border-bottom: 1px solid var(--border);
      }

      .modal-footer {
        border-top: 1px solid var(--border);
      }

      .form-control {
        background-color: #2d2d2d !important;
        border: 1px solid var(--border) !important;
        color: var(--text-main) !important;
        border-radius: 8px;
        padding: 12px;
      }

      .form-control:focus {
        background-color: #2d2d2d !important;
        border-color: var(--primary) !important;
        color: var(--text-main) !important;
        box-shadow: 0 0 0 2px rgba(138, 180, 248, 0.2) !important;
      }

      .form-label {
        color: var(--text-muted) !important;
      }

      .btn-primary {
        background-color: var(--primary);
        border: none;
        color: #202124 !important;
        font-weight: 500;
        padding: 10px;
      }

      .btn-primary:hover {
        background-color: var(--primary-hover);
        color: #202124 !important;
      }

      .btn-close {
        filter: invert(1);
      }

      /* Password toggle for login modal */
      .password-wrapper {
        position: relative;
      }

      .password-toggle {
        position: absolute;
        right: 12px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        color: var(--text-muted);
        cursor: pointer;
        padding: 0;
        font-size: 0.9rem;
        transition: color 0.2s;
      }

      .password-toggle:hover {
        color: var(--text-main);
      }

      /* Alert styles in modal */
      .alert {
        border-radius: 12px;
        padding: 12px 16px;
        margin-bottom: 1rem;
        font-size: 0.9rem;
        border: 1px solid;
      }

      .alert-success {
        background-color: #1f3d2c;
        border-color: #2d5a3f;
        color: #5ec878;
      }

      .alert-danger {
        background-color: #3d1f1f;
        border-color: #6e2828;
        color: #ff6b6b;
      }
    </style>
  </head>

  <body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
      <div class="container">
        <a class="navbar-brand" href="#">NextGen Finance</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
          <span class="navbar-toggler-icon" style="filter: invert(1)"></span>
        </button>
        <div class="collapse navbar-collapse" id="navContent">
          <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item me-3">
              <button class="btn btn-nav-login btn-link text-decoration-none" data-bs-toggle="modal"
                data-bs-target="#loginModal">
                Log in
              </button>
            </li>
            <li class="nav-item">
              <a href="/register" class="btn btn-nav-signup">Get Started</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Hero -->
    <section class="hero">
      <div class="container">
        <h1>Financial intelligence,<br>simplified.</h1>
        <p>Experience the next generation of personal finance management. <br>AI-driven insights for smarter budgeting,
          expense tracking, and goal setting.</p>
        <a href="/register" class="btn-hero">Start your journey</a>
      </div>
    </section>

    <!-- Features -->
    <section class="container py-5">
      <div class="row g-4">
        <div class="col-md-4">
          <div class="feature-card">
            <div class="feature-icon">✨</div>
            <div class="feature-title">AI Predictions</div>
            <div class="feature-text">
              Leverage our advanced machine learning probability models to forecast your future expenses and plan
              smarter budgets.
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="feature-card">
            <div class="feature-icon">📊</div>
            <div class="feature-title">Expense Tracking</div>
            <div class="feature-text">
              Gain complete visibility into your spending habits. Categorize, analyze, and optimize your monthly
              outflow.
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="feature-card">
            <div class="feature-icon">🎯</div>
            <div class="feature-title">Goal Setter</div>
            <div class="feature-text">
              Define your financial targets and track progress. We help you stay disciplined and reach your milestones
              faster.
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
      <div class="container">
        <p>&copy; 2026 NextGen Finance. Built for the future.</p>
      </div>
    </footer>

    <!-- Login Modal -->
    <!-- PRESERVING BACKEND LOGIC: ID="loginModal", Action="/verify", Inputs "email", "password" -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title">Welcome back</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body pt-4">
            <c:if test="${not empty successMessage}">
              <div class="alert alert-success" role="alert">
                <i class="fas fa-check-circle me-2"></i>${successMessage}
              </div>
            </c:if>
            <c:if test="${not empty loginError}">
              <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${loginError}
              </div>
            </c:if>
            <form action="/verify" method="post" id="loginForm">
              <div class="mb-3">
                <label for="loginEmail" class="form-label small">Email address</label>
                <input type="email" class="form-control" name="email" id="loginEmail" required
                  placeholder="name@example.com">
              </div>
              <div class="mb-4">
                <label for="loginPassword" class="form-label small">Password</label>
                <div class="password-wrapper">
                  <input type="password" class="form-control" name="password" id="loginPassword" required
                    placeholder="Enter your password" style="padding-right: 40px;">
                  <button type="button" class="password-toggle" id="loginPasswordToggle">
                    <i class="fas fa-eye"></i>
                  </button>
                </div>
              </div>
              <button type="submit" class="btn btn-primary w-100 rounded-pill">Log in</button>
            </form>
          </div>
          <div class="modal-footer border-0 justify-content-center">
            <p class="small text-muted">Don't have an account? <a href="/register" class="text-decoration-none"
                style="color: var(--primary);">Sign up</a></p>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // Auto-open login modal if success or error message exists
      window.addEventListener('DOMContentLoaded', function() {
        const hasSuccessMessage = document.querySelector('.alert-success');
        const hasLoginError = document.querySelector('.alert-danger');

        // Check for URL parameter
        const urlParams = new URLSearchParams(window.location.search);
        const shouldOpenLogin = urlParams.get('openLogin') === 'true';

        if (hasSuccessMessage || hasLoginError || shouldOpenLogin) {
          const loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
          loginModal.show();

          // Clean URL by removing the parameter (optional, for cleaner URLs)
          if (shouldOpenLogin) {
            window.history.replaceState({}, document.title, '/');
          }
        }
      });

      // Password toggle for login modal
      document.getElementById('loginPasswordToggle').addEventListener('click', function() {
        const passwordInput = document.getElementById('loginPassword');
        const icon = this.querySelector('i');

        if (passwordInput.type === 'password') {
          passwordInput.type = 'text';
          icon.classList.remove('fa-eye');
          icon.classList.add('fa-eye-slash');
        } else {
          passwordInput.type = 'password';
          icon.classList.remove('fa-eye-slash');
          icon.classList.add('fa-eye');
        }
      });
    </script>
  </body>

  </html>