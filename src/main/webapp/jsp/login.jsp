<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Global Theme -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body>

<div class="container-fluid min-vh-100 d-flex align-items-center justify-content-center">
    <div class="row w-100 justify-content-center">

        <div class="col-lg-10">
            <div class="row align-items-center g-5">

                <!-- ================= BRAND PANEL ================= -->
                <div class="col-lg-6 text-white">
                    <div class="dashboard-hero">
                        <h1 class="mb-3">
                            <i class="bi bi-water"></i> Ocean View Resort
                        </h1>
                        <p class="fs-5 mb-4">
                            Resort Room Reservation & Management System
                        </p>

                        <ul class="list-unstyled">
                            <li class="mb-2">
                                <i class="bi bi-check-circle-fill text-warning"></i>
                                Reservation Management
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-check-circle-fill text-warning"></i>
                                Room Availability Tracking
                            </li>
                            <li class="mb-2">
                                <i class="bi bi-check-circle-fill text-warning"></i>
                                Billing & Invoicing
                            </li>
                            <li>
                                <i class="bi bi-check-circle-fill text-warning"></i>
                                Reports & Analytics
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- ================= LOGIN CARD ================= -->
                <div class="col-lg-6">
                    <div class="login-container fade-in">

                        <div class="text-center mb-4">
                            <h3 class="fw-bold text-primary">
                                Welcome Back
                            </h3>
                            <p class="text-muted mb-0">
                                Sign in to continue
                            </p>
                        </div>

                        <!-- Error Message -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show">
                                <i class="bi bi-exclamation-triangle"></i>
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Login Form -->
                        <form action="${pageContext.request.contextPath}/auth" method="post">
                            <input type="hidden" name="action" value="login">

                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="bi bi-person"></i> Username
                                </label>
                                <input type="text"
                                       name="username"
                                       class="form-control"
                                       placeholder="Enter username"
                                       required>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">
                                    <i class="bi bi-lock"></i> Password
                                </label>
                                <input type="password"
                                       name="password"
                                       class="form-control"
                                       placeholder="Enter password"
                                       required>
                            </div>

                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="bi bi-box-arrow-in-right"></i>
                                    Login
                                </button>
                            </div>
                        </form>

                        <!-- Demo Info -->
                        <div class="alert alert-info mt-4">
                            <small>
                                <strong>Demo Credentials</strong><br>
                                Admin: <code>admin</code> / <code>password123</code><br>
                                Staff: <code>staff</code> / <code>password123</code>
                            </small>
                        </div>

                    </div>
                </div>

            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>