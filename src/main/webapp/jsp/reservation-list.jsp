<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% if(session.getAttribute("user")==null) {
    response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    return;
} %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservations - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body class="bg-muted">
<div class="container-fluid px-4 py-4">

    <!-- Page Header -->
    <div class="dashboard-hero fade-in">
        <h2><i class="bi bi-calendar-event"></i> Reservation Management</h2>
        <p>Manage and track guest reservations</p>
    </div>

    <!-- Action Buttons -->
    <div class="d-flex flex-wrap gap-3 mb-4 fade-in">
        <a href="${pageContext.request.contextPath}/reservations?action=new" class="btn btn-primary">
            <i class="bi bi-plus-circle"></i> New Reservation
        </a>
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-outline-primary">
            <i class="bi bi-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <!-- Reservations Table -->
    <div class="dashboard-card fade-in">
        <c:choose>
            <c:when test="${empty listReservations}">
                <div class="text-center py-5">
                    <i class="bi bi-inbox" style="font-size:3rem; color:var(--text-muted);"></i>
                    <h5 class="mt-3 text-muted">No reservations found</h5>
                    <p class="text-muted">Start by creating a new reservation</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                        <tr>
                            <th><i class="bi bi-hash"></i> ID</th>
                            <th><i class="bi bi-person"></i> Guest</th>
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
                                            <span class="badge bg-success"><i class="bi bi-check-circle"></i> ${res.status}</span>
                                        </c:when>
                                        <c:when test="${res.status == 'CANCELLED'}">
                                            <span class="badge bg-danger"><i class="bi bi-x-circle"></i> ${res.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning text-dark"><i class="bi bi-clock"></i> ${res.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/billing?action=generate&reservationId=${res.id}"
                                       class="btn btn-outline-primary btn-sm">
                                        <i class="bi bi-file-pdf"></i> View
                                    </a>
                                </td>
                                <td class="d-flex gap-2">
                                    <c:if test="${res.status == 'PENDING'}">
                                        <a href="${pageContext.request.contextPath}/reservations?action=confirm&id=${res.id}"
                                           class="btn btn-success btn-sm" title="Confirm this reservation">
                                            <i class="bi bi-check"></i> Confirm
                                        </a>
                                    </c:if>
                                    <c:if test="${res.status != 'CANCELLED'}">
                                        <a href="${pageContext.request.contextPath}/reservations?action=cancel&id=${res.id}"
                                           class="btn btn-danger btn-sm"
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