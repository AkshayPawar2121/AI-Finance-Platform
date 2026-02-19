<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | NextGen Finance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
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
        }

        body {
            background-color: var(--bg-body) !important;
            color: var(--text-main) !important;
            font-family: 'Inter', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
        }

        .auth-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 3rem;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 4px 24px rgba(0, 0, 0, 0.2);
        }

        .auth-title {
            text-align: center;
            font-size: 1.75rem;
            font-weight: 600;
            margin-bottom: 2rem;
            color: var(--text-main);
        }

        .form-label {
            color: var(--text-muted) !important;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .form-control {
            background-color: #2d2d2d !important;
            border: 1px solid var(--border) !important;
            color: var(--text-main) !important;
            border-radius: 12px;
            padding: 12px 16px;
            margin-bottom: 1.25rem;
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
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            color: #202124 !important;
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
    </style>
</head>

<body>

    <div class="auth-card">
        <h3 class="auth-title">Create your account</h3>
        <form action="/register" method="post">
            <div>
                <label for="name" class="form-label">Full Name</label>
                <input type="text" class="form-control" name="name" id="name" placeholder="John Doe" required>
            </div>
            <div>
                <label for="mobile" class="form-label">Mobile Number</label>
                <input type="tel" class="form-control" name="mobile" id="mobile" placeholder="+1 234 567 8900" required>
            </div>
            <div>
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" name="email" id="email" placeholder="name@company.com"
                    required>
            </div>
            <div>
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" name="password" id="password"
                    placeholder="Min. 8 characters" required>
            </div>

            <button type="submit" class="btn btn-primary">Create account</button>

            <div class="auth-footer">
                Already have an account? <a href="/">Log in</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>