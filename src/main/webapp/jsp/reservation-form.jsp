<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>New Reservation</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-4">
                <h2>New Reservation</h2>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/reservations" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label>Guest Name</label>
                            <input type="text" name="guestName" class="form-control" value="${reservation.guestName}"
                                required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Guest Email</label>
                            <input type="email" name="guestEmail" class="form-control" value="${reservation.guestEmail}"
                                required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label>Phone</label>
                        <input type="text" name="guestPhone" class="form-control" value="${reservation.guestPhone}"
                            required>
                    </div>

                    <div class="mb-3">
                        <label>Room</label>
                        <select name="roomId" class="form-control" required>
                            <option value="">Select Room</option>
                            <c:forEach var="room" items="${rooms}">
                                <option value="${room.id}" ${reservation.roomId==room.id ? 'selected' : '' }>
                                    Room ${room.roomNumber} (${room.type}) - $${room.pricePerNight}/night
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label>Check In</label>
                            <input type="date" name="checkIn" class="form-control" value="${reservation.checkInDate}"
                                required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Check Out</label>
                            <input type="date" name="checkOut" class="form-control" value="${reservation.checkOutDate}"
                                required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary">Create Reservation</button>
                    <a href="${pageContext.request.contextPath}/reservations" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </body>

        </html>