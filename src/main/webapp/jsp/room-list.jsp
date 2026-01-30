<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <% if(session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/jsp/login.jsp" );
            return; } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Room Management</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            </head>

            <body>
                <div class="container mt-4">
                    <h2>Room Management</h2>
                    <a href="${pageContext.request.contextPath}/rooms?action=new" class="btn btn-success mb-3">Add New
                        Room</a>
                    <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-secondary mb-3">Back to
                        Dashboard</a>

                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Room No</th>
                                <th>Type</th>
                                <th>Price</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="room" items="${listRooms}">
                                <tr>
                                    <td>
                                        <c:out value="${room.id}" />
                                    </td>
                                    <td>
                                        <c:out value="${room.roomNumber}" />
                                    </td>
                                    <td>
                                        <c:out value="${room.type}" />
                                    </td>
                                    <td>
                                        <c:out value="${room.pricePerNight}" />
                                    </td>
                                    <td>
                                        <span class="badge bg-${room.status == 'AVAILABLE' ? 'success' : 'danger'}">
                                            <c:out value="${room.status}" />
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/rooms?action=edit&id=${room.id}"
                                            class="btn btn-sm btn-primary">Edit</a>
                                        <a href="${pageContext.request.contextPath}/rooms?action=delete&id=${room.id}"
                                            class="btn btn-sm btn-danger"
                                            onclick="return confirm('Are you sure?')">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </body>

            </html>