<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <% if(session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/jsp/login.jsp" );
            return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Reservation Management</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
                <style>
                    .page-header {
                        background: linear-gradient(135deg, #1e5fa8 0%, #0d6efd 100%);
                        color: white;
                        padding: 30px;
                        border-radius: 12px;
                        margin-bottom: 30px;
                        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
                    }

                    .page-header h2 {
                        font-weight: 700;
                        margin-bottom: 10px;
                    }

                    .action-buttons {
                        display: flex;
                        gap: 10px;
                        margin-bottom: 25px;
                        flex-wrap: wrap;
                    }

                    .table-wrapper {
                        background: white;
                        border-radius: 12px;
                        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                        overflow: hidden;
                    }

                    .table {
                        margin: 0;
                    }

                    .table thead {
                        background: linear-gradient(135deg, #1e5fa8 0%, #0d6efd 100%);
                        color: white;
                        font-weight: 600;
                    }

                    .table tbody tr {
                        border-bottom: 1px solid #f0f0f0;
                        transition: all 0.2s ease;
                    }

                    .table tbody tr:hover {
                        background: rgba(13, 110, 253, 0.05);
                    }

                    .badge {
                        padding: 8px 12px;
                        font-weight: 600;
                        border-radius: 6px;
                    }

                    .btn-action {
                        padding: 6px 12px;
                        font-size: 0.85rem;
                        font-weight: 600;
                        border-radius: 6px;
                        margin: 2px;
                        transition: all 0.2s ease;
                    }

                    .btn-action:hover {
                        transform: translateY(-2px);
                    }

                    .empty-state {
                        text-align: center;
                        padding: 60px 20px;
                    }

                    .empty-state i {
                        font-size: 3rem;
                        color: #ddd;
                        margin-bottom: 15px;
                    }

                    .empty-state h5 {
                        color: #999;
                        margin-bottom: 20px;
                    }
                </style>
            </head>

            <body>
                <div class="container-fluid px-4 py-4">
                    <!-- Page Header -->
                    <div class="page-header fade-in">
                        <h2><i class="bi bi-calendar-event"></i> Reservation Management</h2>
                        <p>Manage and track guest reservations</p>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons fade-in">
                        <a href="${pageContext.request.contextPath}/reservations?action=new"
                            class="btn btn-success">
                            <i class="bi bi-plus-circle"></i> New Reservation
                        </a>
                        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> Back to Dashboard
                        </a>
                    </div>

                    <!-- Reservations Table -->
                    <div class="table-wrapper fade-in">
                        <c:choose>
                            <c:when test="${empty listReservations}">
                                <div class="empty-state">
                                    <i class="bi bi-inbox"></i>
                                    <h5>No reservations found</h5>
                                    <p class="text-muted">Start by creating a new reservation</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th><i class="bi bi-hash"></i> ID</th>
                                                <th><i class="bi bi-person"></i> Guest Name</th>
                                                <th><i class="bi bi-door-closed"></i> Room</th>
                                                <th><i class="bi bi-tag"></i> Room Type</th>
                                                <th><i class="bi bi-calendar"></i> Check In</th>
                                                <th><i class="bi bi-calendar"></i> Check Out</th>
                                                <th><i class="bi bi-cash"></i> Total</th>
                                                <th><i class="bi bi-info-circle"></i> Status</th>
                                                <th>Bill</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="res" items="${listReservations}">
                                                <tr>
                                                    <td><strong>#${res.id}</strong></td>
                                                    <td>${res.guestName}</td>
                                                    <td><strong>Room ${res.room.roomNumber}</strong></td>
                                                    <td><span class="badge bg-info">${res.roomType}</span></td>
                                                    <td>${res.checkInDate}</td>
                                                    <td>${res.checkOutDate}</td>
                                                    <td><strong>$${res.totalAmount}</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${res.status == 'CONFIRMED'}">
                                                                <span class="badge bg-success">
                                                                    <i class="bi bi-check-circle"></i> ${res.status}
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${res.status == 'CANCELLED'}">
                                                                <span class="badge bg-danger">
                                                                    <i class="bi bi-x-circle"></i> ${res.status}
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-warning text-dark">
                                                                    <i class="bi bi-clock"></i> ${res.status}
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/billing?action=generate&reservationId=${res.id}"
                                                            class="btn btn-action btn-outline-info">
                                                            <i class="bi bi-file-pdf"></i> View
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <c:if test="${res.status == 'PENDING'}">
                                                            <a href="${pageContext.request.contextPath}/reservations?action=confirm&id=${res.id}"
                                                                class="btn btn-action btn-success btn-sm"
                                                                title="Confirm this reservation">
                                                                <i class="bi bi-check"></i> Confirm
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${res.status != 'CANCELLED'}">
                                                            <a href="${pageContext.request.contextPath}/reservations?action=cancel&id=${res.id}"
                                                                class="btn btn-action btn-danger btn-sm"
                                                                onclick="return confirm('Are you sure you want to cancel this reservation?')"
                                                                title="Cancel this reservation">
                                                                <i class="bi bi-x"></i> Cancel
                                                            </a>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>