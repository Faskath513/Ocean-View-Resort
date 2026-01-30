<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .login-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            background: linear-gradient(135deg, #1e5fa8 0%, #0d6efd 100%);
            position: relative;
            overflow: hidden;
        }

        .login-page::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 600px;
            height: 600px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
        }

        .login-page::after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -5%;
            width: 400px;
            height: 400px;
            background: rgba(255,255,255,0.05);
            border-radius: 50%;
        }

        .login-wrapper {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            align-items: center;
            max-width: 1000px;
            width: 100%;
            position: relative;
            z-index: 1;
        }

        .login-brand {
            color: white;
            text-align: left;
        }

        .login-brand h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .login-brand p {
            font-size: 1.2rem;
            opacity: 0.95;
            margin-bottom: 30px;
        }

        .login-brand-features {
            list-style: none;
        }

        .login-brand-features li {
            padding: 10px 0;
            font-size: 1rem;
            opacity: 0.9;
        }

        .login-brand-features i {
            margin-right: 12px;
            color: #ffc107;
        }

        .login-container {
            max-width: none;
            margin: 0;
            padding: 40px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            margin-top: 0;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h3 {
            color: #1e5fa8;
            font-weight: 700;
            margin-bottom: 5px;
            font-size: 1.8rem;
        }

        .login-header p {
            color: #666;
            font-size: 0.95rem;
        }

        @media (max-width: 768px) {
            .login-wrapper {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .login-brand {
                text-align: center;
                margin-bottom: 20px;
            }

            .login-brand h1 {
                font-size: 2.5rem;
            }

            .login-page {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-page">
        <div class="container">
            <div class="login-wrapper">
                <!-- Brand Section -->
                <div class="login-brand">
                    <h1><i class="bi bi-water"></i> Ocean View</h1>
                    <p>Resort Management System</p>
                    <ul class="login-brand-features">
                        <li><i class="bi bi-check-circle"></i> Easy Reservation Management</li>
                        <li><i class="bi bi-check-circle"></i> Real-time Room Availability</li>
                        <li><i class="bi bi-check-circle"></i> Revenue Reports & Analytics</li>
                        <li><i class="bi bi-check-circle"></i> Guest Information Management</li>
                        <li><i class="bi bi-check-circle"></i> Billing & Invoicing System</li>
                    </ul>
                </div>

                <!-- Login Form -->
                <div class="login-container fade-in">
                    <div class="login-header">
                        <h3>Welcome Back</h3>
                        <p>Sign in to your account</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth" method="post" novalidate>
                        <input type="hidden" name="action" value="login">
                        
                        <div class="mb-3">
                            <label for="username" class="form-label">
                                <i class="bi bi-person"></i> Username
                            </label>
                            <input type="text" class="form-control" id="username" name="username" 
                                   placeholder="Enter your username" required>
                        </div>

                        <div class="mb-4">
                            <label for="password" class="form-label">
                                <i class="bi bi-lock"></i> Password
                            </label>
                            <input type="password" class="form-control" id="password" name="password" 
                                   placeholder="Enter your password" required>
                        </div>

                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="bi bi-box-arrow-in-right"></i> Sign In
                            </button>
                        </div>
                    </form>

                    <div class="alert alert-info" role="alert">
                        <i class="bi bi-info-circle"></i>
                        <small>
                            <strong>Demo Credentials:</strong><br>
                            Admin: <code>admin</code> / <code>password123</code><br>
                            Staff: <code>staff</code> / <code>password123</code>
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
