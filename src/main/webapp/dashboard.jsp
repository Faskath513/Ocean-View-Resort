<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/jsp/login.jsp"
            ); return; } %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Dashboard | Ocean View Resort</title>
                <meta name="viewport" content="width=device-width, initial-scale=1">

                <!-- Bootstrap -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Custom Theme -->
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            </head>

            <body>

                <!-- ================= NAVBAR ================= -->
                <jsp:include page="/jsp/includes/navbar.jsp" />

                <!-- ================= CONTENT ================= -->
                <div class="container-fluid px-4 py-4">

                    <!-- HERO -->
                    <div class="dashboard-hero fade-in">
                        <h2><i class="bi bi-speedometer2"></i> Dashboard</h2>
                        <p class="mt-2 mb-0">
                            Welcome back, <strong>${user.username}</strong>.
                            Manage reservations, rooms, and reports from one place.
                        </p>
                    </div>

                    <!-- CARDS -->
                    <div class="dashboard-grid">

                        <!-- Reservations -->
                        <div class="dashboard-card fade-in">
                            <div>
                                <div class="dashboard-icon">
                                    <i class="bi bi-calendar-event"></i>
                                </div>
                                <h5>Reservations</h5>
                                <p>Create, update, and manage guest reservations.</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/reservations" class="btn btn-primary mt-3">
                                Manage Reservations →
                            </a>
                        </div>

                        <!-- Rooms -->
                        <div class="dashboard-card fade-in">
                            <div>
                                <div class="dashboard-icon">
                                    <i class="bi bi-door-closed"></i>
                                </div>
                                <h5>Rooms</h5>
                                <p>Manage room types, rates, and availability.</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/rooms" class="btn btn-outline-primary mt-3">
                                Manage Rooms →
                            </a>
                        </div>

                        <!-- Reports -->
                        <div class="dashboard-card fade-in">
                            <div>
                                <div class="dashboard-icon">
                                    <i class="bi bi-bar-chart"></i>
                                </div>
                                <h5>Reports</h5>
                                <p>View revenue, occupancy, and analytics reports.</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/reports" class="btn btn-outline-primary mt-3">
                                View Reports →
                            </a>
                        </div>

                        <!-- Help -->
                        <div class="dashboard-card fade-in">
                            <div>
                                <div class="dashboard-icon">
                                    <i class="bi bi-question-circle"></i>
                                </div>
                                <h5>Help & Support</h5>
                                <p>Learn how to use the system effectively.</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/jsp/help.jsp"
                                class="btn btn-outline-secondary mt-3">
                                Open Help →
                            </a>
                        </div>

                    </div>
                </div>

                <jsp:include page="/jsp/includes/footer.jsp" />
            </body>

            </html>