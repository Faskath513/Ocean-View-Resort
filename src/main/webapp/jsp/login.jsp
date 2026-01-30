<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Global Theme -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

    <style>
        /* ----------------- LOGIN PAGE ENHANCEMENTS ----------------- */
        body {
            background: var(--gradient-bg);
        }

        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .brand-panel {
            background: var(--gradient-primary);
            color: white;
            border-radius: var(--radius);
            padding: 50px 30px;
            box-shadow: var(--shadow-lg);
            display: flex;
            flex-direction: column;
            justify-content: center;
            min-height: 500px;
        }

        .brand-panel h1 {
            font-weight: 800;
            margin-bottom: 20px;
        }

        .brand-panel p {
            opacity: 0.9;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }

        .brand-panel ul li {
            margin-bottom: 15px;
            font-weight: 600;
            font-size: 1rem;
        }

        .login-card {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            padding: 50px 40px;
            max-width: 450px;
            width: 100%;
            position: relative;
        }

        .login-card h3 {
            font-weight: 700;
        }

        .login-card .form-control {
            border-radius: 12px;
            padding: 14px 16px;
        }

        .login-card .btn-primary {
            background: var(--gradient-primary);
            border: none;
            font-weight: 600;
            padding: 12px;
        }

        .login-card .btn-primary:hover {
            background: linear-gradient(135deg, #0d9488, #14b8a6);
        }

        .login-card .forgot-link {
            font-size: 0.875rem;
            color: var(--primary);
            text-decoration: underline;
            float: right;
        }

        .login-card .forgot-link:hover {
            color: var(--primary-hover);
        }

        .demo-info {
            font-size: 0.85rem;
            opacity: 0.85;
        }

        /* Decorative Elements */
        .login-card::before {
            content: "";
            position: absolute;
            top: -30px;
            right: -30px;
            width: 100px;
            height: 100px;
            background: var(--primary-soft);
            border-radius: 50%;
        }

        .fade-in {
            animation: fadeUp 0.6s ease-out forwards;
        }

        @keyframes fadeUp {
            from {opacity: 0; transform: translateY(24px);}
            to {opacity: 1; transform: translateY(0);}
        }

        @media (max-width: 992px) {
            .brand-panel {margin-bottom: 30px; min-height: auto;}
        }
    </style>
</head>

<body>

<div class="container-fluid login-wrapper">
    <div class="row w-100 justify-content-center">

        <!-- ================= BRAND PANEL ================= -->
        <div class="col-lg-5">
            <div class="brand-panel fade-in text-center">
                <h1><i class="bi bi-water"></i> Ocean View Resort</h1>
                <p>Resort Room Reservation & Management System</p>

                <ul class="list-unstyled text-start mx-auto" style="max-width: 300px;">
                    <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Reservation Management</li>
                    <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Real-time Room Availability</li>
                    <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Billing & Invoicing</li>
                    <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Reports & Analytics</li>
                    <li><i class="bi bi-check-circle-fill text-warning me-2"></i> Guest Notifications & Alerts</li>
                </ul>
            </div>
        </div>

        <!-- ================= LOGIN CARD ================= -->
        <div class="col-lg-4">
            <div class="login-card fade-in">

                <div class="text-center mb-4">
                    <h3 class="text-primary">Welcome Back!</h3>
                    <p class="text-muted mb-0">Sign in to continue</p>
                </div>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Login Form -->
                <form action="${pageContext.request.contextPath}/auth" method="post">
                    <input type="hidden" name="action" value="login">

                    <div class="mb-3">
                        <label class="form-label"><i class="bi bi-person"></i> Username</label>
                        <input type="text" name="username" class="form-control" placeholder="Enter your username" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><i class="bi bi-lock"></i> Password</label>
                        <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
                        <a href="#" class="forgot-link">Forgot password?</a>
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="bi bi-box-arrow-in-right"></i> Login
                        </button>
                    </div>
                </form>

                <!-- Demo Credentials -->
                <div class="alert alert-info demo-info mt-3">
                    <strong>Demo Credentials:</strong><br>
                    Admin: <code>admin</code> / <code>password123</code><br>
                    Staff: <code>staff</code> / <code>password123</code>
                </div>

                <!-- Quick Tips -->
                <div class="mt-3 text-center text-muted" style="font-size: 0.85rem;">
                    <i class="bi bi-info-circle"></i> Use your assigned credentials. Contact support if you have trouble logging in.
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>