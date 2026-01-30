<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
    // Basic session check 
    if(session.getAttribute("user")==null) { 
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return; 
    } 
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .dashboard-hero {
            background: linear-gradient(135deg, #1e5fa8 0%, #0d6efd 100%);
            color: white;
            padding: 40px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .dashboard-hero h2 {
            font-weight: 700;
            margin-bottom: 10px;
        }

        .dashboard-hero p {
            opacity: 0.95;
            font-size: 1.1rem;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .dashboard-card {
            position: relative;
            overflow: hidden;
            min-height: 220px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border-top: 4px solid #0d6efd;
        }

        .dashboard-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }

        .dashboard-card::before {
            content: '';
            position: absolute;
            top: -30px;
            right: -30px;
            width: 120px;
            height: 120px;
            background: rgba(13, 110, 253, 0.08);
            border-radius: 50%;
        }

        .dashboard-card-content {
            position: relative;
            z-index: 1;
            padding: 25px;
        }

        .dashboard-icon {
            font-size: 2.8rem;
            margin-bottom: 15px;
            color: #0d6efd;
        }

        .dashboard-icon.icon-rooms {
            color: #17a2b8;
        }

        .dashboard-icon.icon-reports {
            color: #ffc107;
        }

        .dashboard-icon.icon-help {
            color: #28a745;
        }

        .dashboard-card h5 {
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 12px;
            font-size: 1.3rem;
        }

        .dashboard-card p {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 15px;
        }

        .btn-dashboard {
            border-radius: 8px;
            font-weight: 600;
            padding: 10px 20px;
            transition: all 0.3s ease;
            align-self: flex-start;
        }

        .btn-dashboard:hover {
            transform: translateX(3px);
        }

        .welcome-badge {
            background: rgba(255,255,255,0.2);
            border-radius: 20px;
            padding: 8px 16px;
            font-size: 0.9rem;
            display: inline-block;
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="#">
                <i class="bi bi-water"></i> Ocean View Resort
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/reservations">
                            <i class="bi bi-calendar-event"></i> Reservations
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/rooms">
                            <i class="bi bi-door-closed"></i> Rooms
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/reports">
                            <i class="bi bi-bar-chart"></i> Reports
                        </a>
                    </li>
                    <li class="nav-item">
                        <span class="nav-link welcome-badge">
                            <i class="bi bi-person-circle"></i> ${user.username} (${user.role})
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-danger text-white ms-2 px-3"
                            href="${pageContext.request.contextPath}/auth?action=logout">
                            <i class="bi bi-box-arrow-right"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container-fluid px-4 py-4">
        <!-- Welcome Section -->
        <div class="dashboard-hero fade-in">
            <div class="row align-items-center">
                <div class="col">
                    <h2><i class="bi bi-speedometer2"></i> Dashboard</h2>
                    <p>Welcome to Ocean View Resort Management System</p>
                </div>
            </div>
        </div>

        <!-- Dashboard Cards -->
        <div class="dashboard-grid">
            <!-- Reservations Card -->
            <div class="dashboard-card fade-in">
                <div class="dashboard-card-content">
                    <div class="dashboard-icon">
                        <i class="bi bi-calendar-event"></i>
                    </div>
                    <h5>Reservations</h5>
                    <p>Manage guest reservations, check-ins, and check-outs</p>
                </div>
                <div style="padding: 0 25px 25px;">
                    <a href="${pageContext.request.contextPath}/reservations" 
                       class="btn btn-primary btn-dashboard">
                        <i class="bi bi-arrow-right"></i> Manage
                    </a>
                </div>
            </div>

            <!-- Rooms Card -->
            <div class="dashboard-card fade-in">
                <div class="dashboard-card-content">
                    <div class="dashboard-icon icon-rooms">
                        <i class="bi bi-door-closed"></i>
                    </div>
                    <h5>Rooms</h5>
                    <p>View and manage room inventory and availability</p>
                </div>
                <div style="padding: 0 25px 25px;">
                    <a href="${pageContext.request.contextPath}/rooms" 
                       class="btn btn-outline-primary btn-dashboard">
                        <i class="bi bi-arrow-right"></i> Manage
                    </a>
                </div>
            </div>

            <!-- Reports Card -->
            <div class="dashboard-card fade-in">
                <div class="dashboard-card-content">
                    <div class="dashboard-icon icon-reports">
                        <i class="bi bi-bar-chart"></i>
                    </div>
                    <h5>Reports</h5>
                    <p>View revenue analytics and occupancy reports</p>
                </div>
                <div style="padding: 0 25px 25px;">
                    <a href="${pageContext.request.contextPath}/reports" 
                       class="btn btn-outline-primary btn-dashboard">
                        <i class="bi bi-arrow-right"></i> View
                    </a>
                </div>
            </div>

            <!-- Help Card -->
            <div class="dashboard-card fade-in">
                <div class="dashboard-card-content">
                    <div class="dashboard-icon icon-help">
                        <i class="bi bi-question-circle"></i>
                    </div>
                    <h5>Help & Support</h5>
                    <p>Access system documentation and usage guides</p>
                </div>
                <div style="padding: 0 25px 25px;">
                    <a href="${pageContext.request.contextPath}/jsp/help.jsp" 
                       class="btn btn-outline-secondary btn-dashboard">
                        <i class="bi bi-arrow-right"></i> Help
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
