<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <% // Basic session check if(session.getAttribute("user")==null) { response.sendRedirect("jsp/login.jsp");
            return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Dashboard - Ocean View Resort</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom">
                    <div class="container">
                        <a class="navbar-brand" href="#">Ocean View Resort</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav ms-auto">
                                <li class="nav-item"><a class="nav-link" href="#">Reservations</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Rooms</a></li>
                                <li class="nav-item"><a class="nav-link" href="#">Reports</a></li>
                                <li class="nav-item">
                                    <span class="nav-link active">Welcome, ${user.username} (${user.role})</span>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link btn btn-danger text-white ms-2 px-3"
                                        href="${pageContext.request.contextPath}/auth?action=logout">Exit System</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>

                <div class="container mt-4">
                    <h2>Dashboard</h2>
                    <div class="row mt-4">
                        <div class="col-md-4">
                            <div class="card p-3 mb-2">
                                <h5>Reservations</h5>
                                <p>Manage guest reservations</p>
                                <a href="${pageContext.request.contextPath}/reservations"
                                    class="btn btn-outline-primary">View All</a>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card p-3 mb-2">
                                <h5>Rooms</h5>
                                <p>Manage room availability</p>
                                <a href="${pageContext.request.contextPath}/rooms"
                                    class="btn btn-outline-primary">Manage</a>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card p-3 mb-2">
                                <h5>Reports</h5>
                                <p>View revenue and occupancy</p>
                                <a href="${pageContext.request.contextPath}/reports"
                                    class="btn btn-outline-primary">View Reports</a>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-12">
                            <div class="card p-3 mb-2">
                                <h5>Help & Support</h5>
                                <p>System documentation and usage guide.</p>
                                <a href="${pageContext.request.contextPath}/jsp/help.jsp"
                                    class="btn btn-outline-secondary">View Help</a>
                            </div>
                        </div>
                    </div>
                </div>
            </body>

            </html>