<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <% if(session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/jsp/login.jsp" );
            return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Room Management</title>
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

                    .room-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                        gap: 25px;
                        margin-bottom: 30px;
                    }

                    .room-card {
                        background: white;
                        border-radius: 12px;
                        overflow: hidden;
                        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                        transition: all 0.3s ease;
                        border-top: 4px solid #0d6efd;
                    }

                    .room-card:hover {
                        transform: translateY(-8px);
                        box-shadow: 0 12px 30px rgba(0,0,0,0.15);
                    }

                    .room-image {
                        width: 100%;
                        height: 200px;
                        background: linear-gradient(135deg, #1e5fa8 0%, #0d6efd 100%);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-size: 3rem;
                    }

                    .room-info {
                        padding: 20px;
                    }

                    .room-number {
                        font-size: 1.8rem;
                        font-weight: 700;
                        color: #1e5fa8;
                        margin-bottom: 10px;
                    }

                    .room-type {
                        display: inline-block;
                        background: #f0f0f0;
                        padding: 6px 12px;
                        border-radius: 6px;
                        font-weight: 600;
                        color: #666;
                        margin-bottom: 15px;
                    }

                    .room-price {
                        font-size: 1.5rem;
                        font-weight: 700;
                        color: #17a2b8;
                        margin-bottom: 15px;
                    }

                    .room-status {
                        margin-bottom: 15px;
                    }

                    .room-actions {
                        display: flex;
                        gap: 8px;
                    }

                    .room-actions .btn {
                        flex: 1;
                        padding: 8px 12px;
                        font-size: 0.85rem;
                        border-radius: 6px;
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

                    .empty-state {
                        text-align: center;
                        padding: 60px 20px;
                    }

                    .empty-state i {
                        font-size: 3rem;
                        color: #ddd;
                        margin-bottom: 15px;
                    }
                </style>
            </head>

            <body>
                <div class="container-fluid px-4 py-4">
                    <!-- Page Header -->
                    <div class="page-header fade-in">
                        <h2><i class="bi bi-door-closed"></i> Room Management</h2>
                        <p>Manage room inventory and availability</p>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons fade-in">
                        <a href="${pageContext.request.contextPath}/rooms?action=new" class="btn btn-success">
                            <i class="bi bi-plus-circle"></i> Add New Room
                        </a>
                        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> Back to Dashboard
                        </a>
                    </div>

                    <!-- Room Grid View -->
                    <c:choose>
                        <c:when test="${empty listRooms}">
                            <div class="table-wrapper">
                                <div class="empty-state">
                                    <i class="bi bi-door-closed"></i>
                                    <h5>No rooms found</h5>
                                    <p class="text-muted">Start by adding a new room to your property</p>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="room-grid fade-in">
                                <c:forEach var="room" items="${listRooms}">
                                    <div class="room-card">
                                        <!-- Room Image -->
                                        <div class="room-image">
                                            <i class="bi bi-door-closed"></i>
                                        </div>

                                        <!-- Room Info -->
                                        <div class="room-info">
                                            <div class="room-number">${room.roomNumber}</div>
                                            <div class="room-type">${room.type}</div>

                                            <div class="room-price">
                                                $${room.pricePerNight}
                                                <small style="font-size: 0.6rem; color: #999;">/night</small>
                                            </div>

                                            <div class="room-status">
                                                <c:choose>
                                                    <c:when test="${room.status == 'AVAILABLE'}">
                                                        <span class="badge bg-success">
                                                            <i class="bi bi-check-circle"></i> Available
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">
                                                            <i class="bi bi-x-circle"></i> Occupied
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- Actions -->
                                            <div class="room-actions">
                                                <a href="${pageContext.request.contextPath}/rooms?action=edit&id=${room.id}"
                                                    class="btn btn-outline-primary btn-sm">
                                                    <i class="bi bi-pencil"></i> Edit
                                                </a>
                                                <a href="${pageContext.request.contextPath}/rooms?action=delete&id=${room.id}"
                                                    class="btn btn-outline-danger btn-sm"
                                                    onclick="return confirm('Are you sure you want to delete this room?')">
                                                    <i class="bi bi-trash"></i> Delete
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>