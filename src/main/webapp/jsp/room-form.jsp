<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>${room != null ? 'Edit Room' : 'New Room'}</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-4">
                <h2>${room != null ? 'Edit Room' : 'Add New Room'}</h2>
                <form action="${pageContext.request.contextPath}/rooms" method="post">
                    <c:if test="${room != null}">
                        <input type="hidden" name="id" value="${room.id}">
                    </c:if>

                    <div class="mb-3">
                        <label>Room Number</label>
                        <input type="text" name="roomNumber" class="form-control" value="${room.roomNumber}" required>
                    </div>

                    <div class="mb-3">
                        <label>Type</label>
                        <select name="type" class="form-control">
                            <option value="SINGLE" ${room.type=='SINGLE' ? 'selected' : '' }>Single</option>
                            <option value="DOUBLE" ${room.type=='DOUBLE' ? 'selected' : '' }>Double</option>
                            <option value="SUITE" ${room.type=='SUITE' ? 'selected' : '' }>Suite</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label>Price Per Night</label>
                        <input type="number" step="0.01" name="price" class="form-control" value="${room.pricePerNight}"
                            required>
                    </div>

                    <div class="mb-3">
                        <label>Status</label>
                        <select name="status" class="form-control">
                            <option value="AVAILABLE" ${room.status=='AVAILABLE' ? 'selected' : '' }>Available</option>
                            <option value="OCCUPIED" ${room.status=='OCCUPIED' ? 'selected' : '' }>Occupied</option>
                            <option value="MAINTENANCE" ${room.status=='MAINTENANCE' ? 'selected' : '' }>Maintenance
                            </option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-success">Save</button>
                    <a href="${pageContext.request.contextPath}/rooms" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </body>

        </html>