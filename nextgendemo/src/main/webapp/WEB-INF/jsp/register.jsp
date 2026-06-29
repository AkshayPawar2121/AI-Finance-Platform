<!DOCTYPE html>
<html lang="en" data-bs-theme="dark" id="html-root">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | NextGen Finance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <style>
        :root {
            --bg-body: #121212;
            --surface: #1e1e1e;
            --surface-hover: #2d2d2d;
            --primary: #8ab4f8;
            --primary-hover: #aecbfa;
            --text-main: #e8eaed;
            --text-muted: #9aa0a6;
            --border: #3c4043;
            --success: #34a853;
            --warning: #fbbc04;
            --danger: #ea4335;
        }

        /* Light theme variables */
        [data-bs-theme="light"] {
            --bg-body: #f5f5f5;
            --surface: #ffffff;
            --surface-hover: #f0f0f0;
            --primary: #1a73e8;
            --primary-hover: #1557b0;
            --text-main: #202124;
            --text-muted: #5f6368;
            --border: #dadce0;
            --success: #1e8e3e;
            --warning: #f9ab00;
            --danger: #d93025;
        }

        /* Light mode specific overrides */
        [data-bs-theme="light"] .form-control {
            background-color: #ffffff !important;
            color: var(--text-main) !important;
        }

        [data-bs-theme="light"] .form-control:focus {
            background-color: #ffffff !important;
            box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2) !important;
        }

        [data-bs-theme="light"] .form-control::placeholder {
            color: #80868b;
        }

        [data-bs-theme="light"] .password-strength {
            background-color: #e0e0e0;
        }

        [data-bs-theme="light"] .alert-danger {
            background-color: #fce8e6;
            border-color: #ea4335;
            color: #c5221f;
        }

        [data-bs-theme="light"] .auth-card {
            background-color: #ffffff;
            border: 1px solid var(--border);
            box-shadow: 0 4px 24px rgba(0, 0, 0, 0.1);
        }

        /* Light mode button overrides */
        [data-bs-theme="light"] .btn-primary {
            background-color: var(--primary);
            color: #ffffff !important;
            font-weight: 500;
        }

        [data-bs-theme="light"] .btn-primary:hover:not(:disabled) {
            background-color: var(--primary-hover);
            color: #ffffff !important;
        }

        body {
            background-color: var(--bg-body) !important;
            color: var(--text-main) !important;
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 2rem 1rem;
        }

        .auth-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 3rem;
            width: 100%;
            max-width: 480px;
            box-shadow: 0 4px 24px rgba(0, 0, 0, 0.2);
        }

        .auth-title {
            text-align: center;
            font-size: 1.75rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-main);
        }

        .auth-subtitle {
            text-align: center;
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-bottom: 2rem;
        }

        .form-label {
            color: var(--text-muted) !important;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .form-control {
            background-color: #2d2d2d !important;
            border: 1px solid var(--border) !important;
            color: var(--text-main) !important;
            border-radius: 12px;
            padding: 12px 16px;
            margin-bottom: 0.5rem;
            transition: all 0.2s;
        }

        .form-control:focus {
            background-color: #2d2d2d !important;
            border-color: var(--primary) !important;
            color: var(--text-main) !important;
            box-shadow: 0 0 0 2px rgba(138, 180, 248, 0.2) !important;
        }

        .form-control::placeholder {
            color: #5f6368;
        }

        .form-control.is-invalid {
            border-color: var(--danger) !important;
        }

        .form-control.is-valid {
            border-color: var(--success) !important;
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper .form-control {
            padding-right: 45px; /* Space for eye icon */
        }

        .password-toggle {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            padding: 0;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            transition: color 0.2s;
        }

        .password-toggle:hover {
            color: var(--text-main);
        }

        .password-strength {
            height: 4px;
            background-color: #3c4043;
            border-radius: 2px;
            margin-top: 0.5rem;
            margin-bottom: 0.5rem;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s, background-color 0.3s;
            border-radius: 2px;
        }

        .password-strength-bar.weak {
            width: 33%;
            background-color: var(--danger);
        }

        .password-strength-bar.medium {
            width: 66%;
            background-color: var(--warning);
        }

        .password-strength-bar.strong {
            width: 100%;
            background-color: var(--success);
        }

        .password-strength-text {
            font-size: 0.75rem;
            margin-top: 0.25rem;
            margin-bottom: 0.75rem;
        }

        .password-strength-text.weak {
            color: var(--danger);
        }

        .password-strength-text.medium {
            color: var(--warning);
        }

        .password-strength-text.strong {
            color: var(--success);
        }

        .invalid-feedback, .valid-feedback {
            font-size: 0.75rem;
            margin-top: 0.25rem;
            margin-bottom: 0.75rem;
        }

        .invalid-feedback {
            color: var(--danger);
            display: block;
        }

        .valid-feedback {
            color: var(--success);
        }

        .password-requirements {
            font-size: 0.75rem;
            color: var(--text-muted);
            margin-top: 0.5rem;
            margin-bottom: 1rem;
            padding-left: 1.25rem;
        }

        .password-requirements li {
            margin-bottom: 0.25rem;
        }

        .btn-primary {
            background-color: var(--primary);
            border: none;
            color: #202124 !important;
            font-weight: 500;
            padding: 12px;
            border-radius: 24px;
            width: 100%;
            margin-top: 1rem;
            font-size: 1rem;
            transition: all 0.2s;
        }

        .btn-primary:hover:not(:disabled) {
            background-color: var(--primary-hover);
            color: #202124 !important;
            transform: translateY(-1px);
        }

        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .auth-footer {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .auth-footer a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }

        .auth-footer a:hover {
            text-decoration: underline;
        }

        .alert {
            border-radius: 12px;
            padding: 12px 16px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            border: 1px solid;
        }

        .alert-danger {
            background-color: #3d1f1f;
            border-color: #6e2828;
            color: #ff6b6b;
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        /* Theme toggle button - floating in top right */
        .btn-theme-toggle {
            position: fixed;
            top: 2rem;
            right: 2rem;
            background-color: var(--surface);
            border: 1px solid var(--border);
            color: var(--text-muted);
            border-radius: 8px;
            padding: 10px 14px;
            transition: all 0.2s;
            cursor: pointer;
            z-index: 1000;
            font-size: 1.2rem;
        }

        .btn-theme-toggle:hover {
            background-color: var(--surface-hover);
            color: var(--text-main);
            border-color: var(--text-muted);
            transform: translateY(-2px);
        }
    </style>
</head>

<body>

    <!-- Theme Toggle Button -->
    <button id="themeToggle" class="btn-theme-toggle" aria-label="Toggle theme">
        <i id="themeIcon" class="fas fa-sun"></i>
    </button>

    <div class="auth-card">
        <h3 class="auth-title">Create your account</h3>
        <p class="auth-subtitle">Join NextGen Finance and start managing your finances intelligently</p>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
            </div>
        </c:if>

        <form action="/register" method="post" id="registerForm" novalidate>
            <div class="form-group">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" class="form-control" name="name" id="name"
                       placeholder="John Doe"
                       minlength="2"
                       maxlength="100"
                       pattern="[A-Za-z ]+"
                       required>
                <div class="invalid-feedback" id="nameError"></div>
            </div>

            <div class="form-group">
                <label for="mobile" class="form-label">Mobile Number</label>
                <input type="tel" class="form-control" name="mobile" id="mobile"
                       placeholder="+1 234 567 8900"
                       pattern="[0-9+\-() ]{10,15}"
                       required>
                <div class="invalid-feedback" id="mobileError"></div>
            </div>

            <div class="form-group">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control" name="email" id="email"
                       placeholder="name@company.com"
                       required>
                <div class="invalid-feedback" id="emailError"></div>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <div class="password-wrapper">
                    <input type="password" class="form-control" name="password" id="password"
                           placeholder="Create a strong password"
                           minlength="8"
                           required>
                    <button type="button" class="password-toggle" id="passwordToggle">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <div class="password-strength">
                    <div class="password-strength-bar" id="strengthBar"></div>
                </div>
                <div class="password-strength-text" id="strengthText"></div>
                <ul class="password-requirements">
                    <li>At least 8 characters long</li>
                    <li>At least one uppercase letter (A-Z)</li>
                    <li>At least one lowercase letter (a-z)</li>
                    <li>At least one number (0-9)</li>
                </ul>
                <div class="invalid-feedback" id="passwordError"></div>
            </div>

            <div class="form-group">
                <label for="confirmPassword" class="form-label">Confirm Password</label>
                <div class="password-wrapper">
                    <input type="password" class="form-control" id="confirmPassword"
                           placeholder="Re-enter your password"
                           required>
                    <button type="button" class="password-toggle" id="confirmPasswordToggle">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <div class="invalid-feedback" id="confirmPasswordError"></div>
            </div>

            <button type="submit" class="btn btn-primary" id="submitBtn">Create account</button>

            <div class="auth-footer">
                Already have an account? <a href="/?openLogin=true">Log in</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Password strength checker
        function checkPasswordStrength(password) {
            let strength = 0;

            if (password.length >= 8) strength++;
            if (/[A-Z]/.test(password)) strength++;
            if (/[a-z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;

            return strength;
        }

        function updatePasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');

            if (password.length === 0) {
                strengthBar.className = 'password-strength-bar';
                strengthText.textContent = '';
                return;
            }

            const strength = checkPasswordStrength(password);

            // Remove all classes
            strengthBar.className = 'password-strength-bar';
            strengthText.className = 'password-strength-text';

            if (strength <= 1) {
                strengthBar.classList.add('weak');
                strengthText.classList.add('weak');
                strengthText.textContent = 'Weak password';
            } else if (strength <= 3) {
                strengthBar.classList.add('medium');
                strengthText.classList.add('medium');
                strengthText.textContent = 'Medium password';
            } else {
                strengthBar.classList.add('strong');
                strengthText.classList.add('strong');
                strengthText.textContent = 'Strong password';
            }
        }

        // Password validation
        function validatePassword(password) {
            if (password.length < 8) {
                return 'Password must be at least 8 characters long';
            }
            if (!/[A-Z]/.test(password)) {
                return 'Password must contain at least one uppercase letter';
            }
            if (!/[a-z]/.test(password)) {
                return 'Password must contain at least one lowercase letter';
            }
            if (!/[0-9]/.test(password)) {
                return 'Password must contain at least one number';
            }
            return null;
        }

        // Show/hide password toggles
        document.getElementById('passwordToggle').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
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

        document.getElementById('confirmPasswordToggle').addEventListener('click', function() {
            const confirmInput = document.getElementById('confirmPassword');
            const icon = this.querySelector('i');

            if (confirmInput.type === 'password') {
                confirmInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                confirmInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Real-time password strength checking
        document.getElementById('password').addEventListener('input', function() {
            updatePasswordStrength();

            // Also revalidate confirm password if it has a value
            const confirmPassword = document.getElementById('confirmPassword');
            if (confirmPassword.value) {
                validateConfirmPassword();
            }
        });

        // Confirm password validation
        function validateConfirmPassword() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const confirmInput = document.getElementById('confirmPassword');
            const errorDiv = document.getElementById('confirmPasswordError');

            if (confirmPassword && password !== confirmPassword) {
                confirmInput.classList.add('is-invalid');
                confirmInput.classList.remove('is-valid');
                errorDiv.textContent = 'Passwords do not match';
                return false;
            } else if (confirmPassword) {
                confirmInput.classList.remove('is-invalid');
                confirmInput.classList.add('is-valid');
                errorDiv.textContent = '';
                return true;
            }
            return true;
        }

        document.getElementById('confirmPassword').addEventListener('input', validateConfirmPassword);

        // Form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            e.preventDefault();

            let isValid = true;

            // Name validation
            const name = document.getElementById('name');
            const nameError = document.getElementById('nameError');
            if (!name.value.trim()) {
                name.classList.add('is-invalid');
                nameError.textContent = 'Name is required';
                isValid = false;
            } else if (name.value.length < 2) {
                name.classList.add('is-invalid');
                nameError.textContent = 'Name must be at least 2 characters';
                isValid = false;
            } else if (!/^[A-Za-z ]+$/.test(name.value)) {
                name.classList.add('is-invalid');
                nameError.textContent = 'Name can only contain letters and spaces';
                isValid = false;
            } else {
                name.classList.remove('is-invalid');
                name.classList.add('is-valid');
                nameError.textContent = '';
            }

            // Mobile validation
            const mobile = document.getElementById('mobile');
            const mobileError = document.getElementById('mobileError');
            if (!mobile.value.trim()) {
                mobile.classList.add('is-invalid');
                mobileError.textContent = 'Mobile number is required';
                isValid = false;
            } else if (!/^[0-9+\-() ]{10,15}$/.test(mobile.value)) {
                mobile.classList.add('is-invalid');
                mobileError.textContent = 'Please enter a valid mobile number';
                isValid = false;
            } else {
                mobile.classList.remove('is-invalid');
                mobile.classList.add('is-valid');
                mobileError.textContent = '';
            }

            // Email validation
            const email = document.getElementById('email');
            const emailError = document.getElementById('emailError');
            if (!email.value.trim()) {
                email.classList.add('is-invalid');
                emailError.textContent = 'Email is required';
                isValid = false;
            } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
                email.classList.add('is-invalid');
                emailError.textContent = 'Please enter a valid email address';
                isValid = false;
            } else {
                email.classList.remove('is-invalid');
                email.classList.add('is-valid');
                emailError.textContent = '';
            }

            // Password validation
            const password = document.getElementById('password');
            const passwordError = document.getElementById('passwordError');
            const passwordValidationError = validatePassword(password.value);
            if (passwordValidationError) {
                password.classList.add('is-invalid');
                passwordError.textContent = passwordValidationError;
                isValid = false;
            } else {
                password.classList.remove('is-invalid');
                password.classList.add('is-valid');
                passwordError.textContent = '';
            }

            // Confirm password validation
            const confirmPassword = document.getElementById('confirmPassword');
            const confirmError = document.getElementById('confirmPasswordError');
            if (!confirmPassword.value) {
                confirmPassword.classList.add('is-invalid');
                confirmError.textContent = 'Please confirm your password';
                isValid = false;
            } else if (password.value !== confirmPassword.value) {
                confirmPassword.classList.add('is-invalid');
                confirmError.textContent = 'Passwords do not match';
                isValid = false;
            } else {
                confirmPassword.classList.remove('is-invalid');
                confirmPassword.classList.add('is-valid');
                confirmError.textContent = '';
            }

            if (isValid) {
                this.submit();
            } else {
                // Scroll to first error
                const firstError = document.querySelector('.is-invalid');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });

        // Clear validation on input
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('input', function() {
                if (this.id !== 'password' && this.id !== 'confirmPassword') {
                    this.classList.remove('is-invalid', 'is-valid');
                }
            });
        });

        // Theme Toggle Functionality
        (function() {
            const htmlRoot = document.getElementById('html-root');
            const themeToggleBtn = document.getElementById('themeToggle');
            const themeIcon = document.getElementById('themeIcon');

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

            // Update icon based on current theme
            function updateThemeIcon(theme) {
                if (themeIcon) {
                    themeIcon.className = theme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
                }
            }
        })();
    </script>
</body>

</html>
