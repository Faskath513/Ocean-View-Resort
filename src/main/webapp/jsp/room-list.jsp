<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Room Management - Ocean View Resort</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body>

<jsp:include page="/jsp/includes/navbar.jsp" />

<div class="container-fluid px-4 py-4">

    <div class="dashboard-hero fade-in">
        <h2><i class="bi bi-door-closed"></i> Room Management</h2>
        <p>Manage room inventory and availability</p>
    </div>

    <div class="d-flex gap-3 mb-4">
        <a href="${pageContext.request.contextPath}/rooms?action=new" class="btn btn-primary">
            <i class="bi bi-plus-circle"></i> Add New Room
        </a>
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-outline-primary">
            <i class="bi bi-arrow-left"></i> Back
        </a>
    </div>

    <c:choose>

        <c:when test="${empty listRooms}">
            <div class="dashboard-card text-center fade-in">
                <i class="bi bi-door-closed fs-1 text-muted"></i>
                <h5 class="mt-3">No Rooms Available</h5>
                <p class="text-muted">Add your first room to get started</p>
            </div>
        </c:when>

        <c:otherwise>
            <div class="dashboard-grid fade-in">

                <c:forEach var="room" items="${listRooms}">
                    <div class="dashboard-card">

                        <div class="dashboard-icon">
                            <i class="bi bi-door-closed"></i>
                        </div>

                        <h5>${room.roomNumber}</h5>
                        <p class="text-muted">${room.type}</p>

                        <p class="fw-bold">
                            LKR ${room.pricePerNight}
                            <small class="text-muted">/ night</small>
                        </p>

                        <c:choose>
                            <c:when test="${room.status eq 'AVAILABLE'}">
                                <span class="badge bg-success">Available</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">Occupied</span>
                            </c:otherwise>
                        </c:choose>

                        <div class="mt-3 d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/rooms?action=edit&id=${room.id}"
                               class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-pencil"></i> Edit
                            </a>

                            <a href="${pageContext.request.contextPath}/rooms?action=delete&id=${room.id}"
                               class="btn btn-outline-danger btn-sm"
                               onclick="return confirm('Delete this room?');">
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