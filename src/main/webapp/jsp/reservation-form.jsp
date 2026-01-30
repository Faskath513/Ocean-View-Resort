<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>New Reservation - Ocean View Resort</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

            <style>
                .reservation-card {
                    background: white;
                    padding: 30px;
                    border-radius: 15px;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
                }

                .reservation-header {
                    text-align: center;
                    margin-bottom: 25px;
                }

                .reservation-header h2 {
                    font-weight: 700;
                    color: #1e5fa8;
                }

                .form-section-title {
                    font-weight: 600;
                    margin-top: 30px;
                    margin-bottom: 15px;
                    color: #0d6efd;
                }

                .btn-submit {
                    min-width: 150px;
                }

                @media (max-width: 768px) {
                    .reservation-card {
                        padding: 20px;
                    }
                }
            </style>
        </head>

        <body>
            <jsp:include page="/jsp/includes/navbar.jsp" />
            <div class="container mt-5">
                <div class="reservation-card">
                    <div class="reservation-header">
                        <h2><i class="bi bi-calendar-plus"></i> New Reservation</h2>
                        <p>Fill in the guest and booking details below</p>
                    </div>

                    <!-- Error Message -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/reservations" method="post">
                        <!-- Guest Info -->
                        <h5 class="form-section-title">Guest Information</h5>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label>Guest Name</label>
                                <input type="text" name="guestName" class="form-control"
                                    value="${reservation.guestName}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>Guest Email</label>
                                <input type="email" name="guestEmail" class="form-control"
                                    value="${reservation.guestEmail}" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label>Phone</label>
                            <input type="text" name="guestPhone" class="form-control" value="${reservation.guestPhone}"
                                required>
                        </div>

                        <!-- Address Info -->
                        <h5 class="form-section-title">Guest Address</h5>
                        <div class="mb-3">
                            <label>Street Address</label>
                            <input type="text" name="guestAddressStreet" class="form-control"
                                value="${reservation.guestAddressStreet}" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label>City</label>
                                <input type="text" name="guestAddressCity" class="form-control"
                                    value="${reservation.guestAddressCity}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>State/Province</label>
                                <input type="text" name="guestAddressState" class="form-control"
                                    value="${reservation.guestAddressState}" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label>Zip/Postal Code</label>
                                <input type="text" name="guestAddressZip" class="form-control"
                                    value="${reservation.guestAddressZip}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>Country</label>
                                <input type="text" name="guestAddressCountry" class="form-control"
                                    value="${reservation.guestAddressCountry}" required>
                            </div>
                        </div>

                        <!-- Room & Dates -->
                        <h5 class="form-section-title">Booking Details</h5>
                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label>Room</label>
                                <select id="roomSelect" name="roomId" class="form-control" required
                                    onchange="updateRoomType()">
                                    <option value="">Select Room</option>
                                    <c:forEach var="room" items="${rooms}">
                                        <option value="${room.id}" data-type="${room.type}"
                                            ${reservation.roomId==room.id ? 'selected' : '' }>
                                            Room ${room.roomNumber} (${room.type}) - $${room.pricePerNight}/night
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>Room Type</label>
                                <input type="text" id="roomType" name="roomType" class="form-control" readonly>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label>Check In</label>
                                <input type="date" name="checkIn" class="form-control"
                                    value="${reservation.checkInDate}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>Check Out</label>
                                <input type="date" name="checkOut" class="form-control"
                                    value="${reservation.checkOutDate}" required>
                            </div>
                        </div>

                        <div class="d-flex gap-2 mt-4">
                            <button type="submit" class="btn btn-primary btn-submit">
                                <i class="bi bi-check2-circle"></i> Create Reservation
                            </button>
                            <a href="${pageContext.request.contextPath}/reservations" class="btn btn-secondary">
                                <i class="bi bi-x-circle"></i> Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                function updateRoomType() {
                    const select = document.getElementById('roomSelect');
                    const selectedOption = select.options[select.selectedIndex];
                    const roomType = selectedOption.getAttribute('data-type') || '';
                    document.getElementById('roomType').value = roomType;
                }
                document.addEventListener('DOMContentLoaded', updateRoomType);
            </script>

            <jsp:include page="/jsp/includes/footer.jsp" />
        </body>

        </html>