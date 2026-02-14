<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="In the modern world where the financial aspect is one of the most crucial for people’s lives, technology provides effective instruments to control the financial situation and plan for the future.">
  <title>NextGen Personal Finance</title>
  <!-- Bootstrap CSS -->
  <link 
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" 
    rel="stylesheet">
  <style>
    /* General Reset */
    body, html {
      margin: 0;
      padding: 0;
      overflow-x: hidden;
    }

    /* Hero Section */
    .hero-section {
      background: url('https://media.istockphoto.com/id/494940062/photo/financial-concept-business-and-money.jpg?s=612x612&w=0&k=20&c=WXZe41O-IH8N7wRKPaU4T-fA6DlJz4U8zQRRMf_U5wk=') no-repeat center center;
      background-size: cover; /* Ensures the image covers the section */
      height: 100vh; /* Adjusted to cover full viewport */
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
    }

    /* Logo Styling */
    .logo-container {
      position: absolute;
      top: 20px;
      left: 30px;
      z-index: 10;
    }

    .logo-container .logo-img {
  width: 50%; /* Increased width */
  height: auto; /* Maintain aspect ratio */
  transition: transform 0.3s ease;
}

.logo-container .logo-img:hover {
  transform: scale(1.1); /* Slight zoom on hover */
}


    /* Hero Section: Login & Signup buttons */
    .auth-buttons {
      position: absolute;
      top: 20px;
      right: 30px;
      z-index: 10;
    }

    .auth-buttons .btn {
      font-size: 1rem;
      padding: 10px 20px;
      border-radius: 25px;
      margin-left: 10px;
      transition: all 0.3s ease;
    }

    .btn-primary {
      background-color: #0056b3;
      border: none;
    }

    .btn-primary:hover {
      background-color: #003580;
    }

    .btn-warning {
      background-color: #ffcc00;
      border: none;
      color: #003580;
    }

    .btn-warning:hover {
      background-color: #ffd633;
    }

    /* Hero Overlay */
    .hero-overlay {
      background: rgba(0, 0, 0, 0.6); /* Dark overlay for readability */
      width: 100%;
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
    }

    .hero-content {
      max-width: 700px;
      text-align: center;
    }

    .hero-content h1 {
      font-size: 3.5rem;
      color: #ffcc00;
      font-weight: bold;
      margin-bottom: 20px;
    }

    .hero-content .highlight {
      animation: pulse 2s infinite;
    }

    .hero-content p {
      font-size: 1.2rem;
      color: #f0f0f0;
      margin-bottom: 30px;
    }

    /* Center Get Started Button */
    .get-started-btn {
      margin-top: 20px;
    }

    /* Pulse Animation */
    @keyframes pulse {
      0%, 100% {
        transform: scale(1);
      }
      50% {
        transform: scale(1.1);
      }
    }

    /* Features Section */
    .features {
      background-color: #f8f9fa;
    }

    .features h2 {
      color: #0056b3;
    }

    .features h5 {
      color: #003580;
      font-weight: bold;
    }

    /* Footer */
    .footer {
      background: linear-gradient(135deg, #0056b3, #003580);
      color: white;
      padding: 2rem 0;
    }

    .footer h5 {
      font-size: 1.25rem;
      margin-bottom: 1rem;
      color: #ffcc00;
    }

    .footer p {
      font-size: 0.95rem;
      color: #f0f0f0;
    }

    .footer ul {
      padding: 0;
      list-style: none;
    }

    .footer ul li {
      margin-bottom: 0.5rem;
      color: #e0e0e0;
    }

    .footer ul li a {
      text-decoration: none;
      color: #ffcc00;
    }

    .footer ul li a:hover {
      text-decoration: underline;
      color: #ffe680;
    }

    .footer ul.list-inline {
      margin: 0;
    }

    .footer ul.list-inline li {
      display: inline;
      margin-right: 0.75rem;
    }

    .footer ul.list-inline li a {
      font-size: 1.5rem;
      color: white;
      transition: color 0.3s;
    }

    .footer ul.list-inline li a:hover {
      color: #ffcc00;
    }

    .footer .text-muted {
      font-size: 0.85rem;
    }

    .features .card-body img {
      max-width: 80px; /* Set the maximum width for the image */
      height: auto; /* Maintain the aspect ratio */
      margin-bottom: 15px; /* Add spacing below the logo */
      transition: transform 0.3s ease; /* Add a smooth transition effect */
    }

    .features .card-body img:hover {
      transform: scale(1.2); /* Slightly enlarge on hover */
    }
  </style>
</head>
<body>
  <!-- Hero Section -->
  <div class="hero-section">
    <!-- Logo Container
    <div class="logo-container">
      <a href="index.html">
      		<img src="https://drive.google.com/file/d/1Qje7SXC61GwGvReKN9cE6zbQgGWLjFSn/view?usp=sharing" alt="Image">
      </a>
    </div> -->
    <!-- Login & Sign-Up Buttons -->
    <div class="auth-buttons">
      <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
      <a href="/register" class="btn btn-warning">Sign Up</a>
    </div>
	
	<!-- Login Modal -->
		<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="loginModalLabel">Login</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="/verify" method="post">
							<div class="mb-3">
								<label for="email" class="form-label">Email address</label>
								<input type="email" class="form-control" name="email" id="email" placeholder="Enter your email">
							</div>
							<div class="mb-3">
								<label for="password" class="form-label">Password</label>
								<input type="password" class="form-control" name="password" id="password" placeholder="Enter your password">
							</div>
							
							<button type="submit" class="btn btn-primary w-100">Login</button>
						</form>
					</div>
					<div class="modal-footer">
						<div class="text-center w-100">
							<a href="#">Forgot Password?</a> | <a href="/register">Sign Up</a>
						</div>
					</div>
				</div>
			</div>
		</div>


	
    <div class="hero-overlay">
      <div class="hero-content text-center text-light">
        <h1 class="display-4"><span class="highlight" style="color: white;">NextGen </span><span style="color: #0056b3;">Finance</span></h1>
        <p class="lead mt-3">
          A smarter way to manage your finances, powered by AI insights for better financial decisions.
        </p>
        <div class="get-started-btn">
          <a href="/register" class="btn btn-light">Get Started</a>
        </div>
      </div>
    </div>
  </div>

  <section class="features py-5">
    <div class="container">
      <h2 class="text-center mb-4">Our Features</h2>
      <div class="row">
        <div class="col-md-4">
          <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
              <img src="./robot.svg" alt="AI Insights Logo" class="feature-logo">
              <h5 class="card-title text-primary">AI-Driven Insights</h5>
              <p class="card-text">Receive personalized financial advice based on your spending habits and goals.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
              <img src="./currency-rupee.svg" alt="Expense Tracking Logo" class="feature-logo">
              <h5 class="card-title text-primary">Expense Tracking</h5>
              <p class="card-text">Keep track of your expenses and optimize your budget with real-time analytics.</p>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
              <img src="./clock.svg" alt="Future Planning Logo" class="feature-logo">
              <h5 class="card-title text-primary">Future Planning</h5>
              <p class="card-text">Plan for the future with AI-generated predictions and goal-setting tools.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Contact Us Section -->
  <section class="contact-us py-5">
    <div class="container">
      <h2 class="text-center mb-4">Contact Us</h2>
      <div class="row justify-content-center">
        <div class="col-md-8">
          <form action="mailto:support@nextgenfinance.com" method="post" enctype="text/plain">
            <div class="mb-3">
              <label for="name" class="form-label">Name</label>
              <input type="text" class="form-control" id="name" name="name" placeholder="Your Name" required>
            </div>
            <div class="mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="email" class="form-control" id="email" name="email" placeholder="Your Email" required>
            </div>
            <div class="mb-3">
              <label for="message" class="form-label">Message</label>
              <textarea class="form-control" id="message" name="message" rows="5" placeholder="Your Message" required></textarea>
            </div>
            <div class="text-center">
              <button type="submit" class="btn btn-primary px-5">Send Message</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </section>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
