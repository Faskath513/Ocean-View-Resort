<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <% if(session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/jsp/login.jsp" );
            return; } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Reservation Management</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            </head>

            <body>
                <div class="container mt-4">
                    <h2>Reservation Management</h2>
                    <a href="${pageContext.request.contextPath}/reservations?action=new"
                        class="btn btn-success mb-3">New
                        Reservation</a>
                    <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-secondary mb-3">Back to
                        Dashboard</a>

                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Guest</th>
                                <th>Room</th>
                                <th>Check In</th>
                                <th>Check Out</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="res" items="${listReservations}">
                                <tr>
                                    <td>
                                        <c:out value="${res.id}" />
                                    </td>
                                    <td>
                                        <c:out value="${res.guestName}" />
                                    </td>
                                    <td>
                                        <c:out value="${res.room.roomNumber}" />
                                    </td>
                                    <td>
                                        <c:out value="${res.checkInDate}" />
                                    </td>
                                    <td>
                                        <c:out value="${res.checkOutDate}" />
                                    </td>
                                    <td>
                                        <c:out value="${res.totalAmount}" />
                                    </td>
                                    <td>
                                        <span
                                            class="badge bg-${res.status == 'CONFIRMED' ? 'success' : (res.status == 'CANCELLED' ? 'danger' : 'warning')}">
                                            <c:out value="${res.status}" />
                                        </span>
                                    </td>
                                    <td>
                                        <c:if test="${res.status == 'PENDING'}">
                                            <a href="${pageContext.request.contextPath}/reservations?action=confirm&id=${res.id}"
                                                class="btn btn-sm btn-info">Confirm</a>
                                        </c:if>
                                        <c:if test="${res.status != 'CANCELLED'}">
                                            <a href="${pageContext.request.contextPath}/reservations?action=cancel&id=${res.id}"
                                                class="btn btn-sm btn-danger"
                                                onclick="return confirm('Cancel reservation?')">Cancel</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </body>

            </html>