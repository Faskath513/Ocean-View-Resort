<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Bill - Ocean View Resort</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
            <style>
                .bill-box {
                    border: 1px solid #ddd;
                    padding: 30px;
                    background: white;
                    box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
                }
            </style>
        </head>

        <body>
            <div class="container mt-5">
                <div class="d-flex justify-content-between mb-4">
                    <h2>Guest Bill</h2>
                    <button onclick="window.print()" class="btn btn-primary">Print Bill</button>
                </div>

                <div class="bill-box">
                    <h3 class="text-center mb-4">Ocean View Resort</h3>
                    <p class="text-center text-muted">123 Ocean Drive, Paradise City</p>
                    <hr>

                    <div class="row mb-4">
                        <div class="col-6">
                            <strong>Bill To:</strong><br>
                            Reservation ID: #${bill.reservationId}
                        </div>
                        <div class="col-6 text-end">
                            <strong>Bill Date:</strong><br>
                            ${bill.generatedAt}
                        </div>
                    </div>

                    <table class="table">
                        <tbody>
                            <tr>
                                <td>Room Charges</td>
                                <td class="text-end">$${bill.roomCharge}</td>
                            </tr>
                            <tr>
                                <td>Tax (15%)</td>
                                <td class="text-end">$${bill.taxAmount}</td>
                            </tr>
                            <tr>
                                <td>Service Charge (10%)</td>
                                <td class="text-end">$${bill.serviceCharge}</td>
                            </tr>
                            <tr class="table-dark">
                                <td><strong>Total Amount</strong></td>
                                <td class="text-end"><strong>$${bill.totalAmount}</strong></td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="mt-4 text-center">
                        <p>Status: <span class="badge bg-warning text-dark">${bill.paymentStatus}</span></p>
                    </div>
                </div>

                <div class="mt-3 text-center">
                    <a href="${pageContext.request.contextPath}/reservations" class="btn btn-secondary">Back to
                        Reservations</a>
                </div>
            </div>
        </body>

        </html>