<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <% if(session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/jsp/login.jsp" );
            return; } %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Room Management - Ocean View Resort</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            </head>

            <body class="bg-muted">
                <jsp:include page="/jsp/includes/navbar.jsp" />
                <div class="container-fluid px-4 py-4">

                    <!-- Page Header -->
                    <div class="dashboard-hero fade-in">
                        <h2><i class="bi bi-door-closed"></i> Room Management</h2>
                        <p>Manage room inventory and availability</p>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex flex-wrap gap-3 mb-4 fade-in">
                        <a href="${pageContext.request.contextPath}/rooms?action=new" class="btn btn-primary">
                            <i class="bi bi-plus-circle"></i> Add New Room
                        </a>
                        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left"></i> Back to Dashboard
                        </a>
                    </div>

                    <!-- Room Grid -->
                    <c:choose>
                        <c:when test="${empty listRooms}">
                            <div class="dashboard-card text-center">
                                <i class="bi bi-door-closed" style="font-size:3rem; color:var(--text-muted);"></i>
                                <h5 class="mt-3 text-muted">No rooms found</h5>
                                <p class="text-muted">Start by adding a new room to your property</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="dashboard-grid fade-in">
                                <c:forEach var="room" items="${listRooms}">
                                    <div class="dashboard-card">
                                        <!-- Room Image -->
                                        <div class="bg-primary-soft d-flex align-items-center justify-content-center"
                                            style="height:150px; border-radius: var(--radius); margin-bottom: 15px;">
                                            <i class="bi bi-door-closed"
                                                style="font-size:2.5rem; color: var(--primary);"></i>
                                        </div>

                                        <!-- Room Info -->
                                        <h5 class="text-primary">${room.roomNumber}</h5>
                                        <p class="text-muted mb-1">${room.type}</p>
                                        <p class="fw-bold text-info mb-2">$${room.pricePerNight} <small
                                                class="text-muted">/night</small></p>
                                        <div class="mb-3">
                                            <c:choose>
                                                <c:when test="${room.status=='AVAILABLE'}">
                                                    <span class="badge bg-success"><i class="bi bi-check-circle"></i>
                                                        Available</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger"><i class="bi bi-x-circle"></i>
                                                        Occupied</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <!-- Room Actions -->
                                        <div class="d-flex gap-2">
                                            <a href="${pageContext.request.contextPath}/rooms?action=edit&id=${room.id}"
                                                class="btn btn-outline-primary btn-sm flex-fill">
                                                <i class="bi bi-pencil"></i> Edit
                                            </a>
                                            <a href="${pageContext.request.contextPath}/rooms?action=delete&id=${room.id}"
                                                class="btn btn-outline-danger btn-sm flex-fill"
                                                onclick="return confirm('Are you sure you want to delete this room?')">
                                                <i class="bi bi-trash"></i> Delete
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </div>

                <jsp:include page="/jsp/includes/footer.jsp" />
            </body>

            </html>