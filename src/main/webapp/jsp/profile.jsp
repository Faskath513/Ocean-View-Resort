<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanview.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Ocean View Resort</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <!-- Ocean View Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Navbar -->
    <%@ include file="includes/navbar.jsp" %>

    <!-- Main Container -->
    <div class="container mt-5 fade-in">

        <!-- Dashboard Header -->
        <!-- <div class="dashboard-hero text-center mb-4">
            <h2>My Profile</h2>
            <p>Manage your account details and security settings</p>
        </div> -->

        <!-- Profile Card -->
        <div class="dashboard-card mx-auto" style="max-width: 600px;">

            <!-- Avatar -->
            <div class="room-image mb-4">
                <i class="bi bi-person-circle"></i>
            </div>

            <!-- Name & Role -->
            <div class="text-center mb-4">
                <h3 class="room-number"><%= user.getUsername() %></h3>
                <p class="room-type text-uppercase"><%= user.getRole() %></p>
            </div>

            <!-- Success/Error Messages -->
            <% String successMessage = (String) request.getAttribute("successMessage");
               String errorMessage = (String) request.getAttribute("errorMessage");
            %>
            <% if (successMessage != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle"></i> <%= successMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle"></i> <%= errorMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <!-- Profile Info -->
            <div class="info-group">
                <div class="info-label">Username</div>
                <div class="info-value"><%= user.getUsername() %></div>
            </div>

            <div class="info-group">
                <div class="info-label">User ID</div>
                <div class="info-value"><%= user.getId() %></div>
            </div>

            <div class="info-group">
                <div class="info-label">Role</div>
                <div class="info-value">
                    <span class="room-status available"><%= user.getRole() %></span>
                </div>
            </div>

            <div class="info-group">
                <div class="info-label">Account Status</div>
                <div class="info-value">
                    <span class="room-status available">Active</span>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="room-actions mt-3">
                <a href="<%= request.getContextPath() %>/reset-password.jsp" class="btn btn-primary">
                    <i class="bi bi-lock"></i> Reset Password
                </a>
                <a href="<%= request.getContextPath() %>/dashboard.jsp" class="btn btn-outline-primary">
                    <i class="bi bi-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Footer -->
        <div class="text-center mt-5 mb-4">
            <p>&copy; 2026 Ocean View Resort. All rights reserved.</p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>