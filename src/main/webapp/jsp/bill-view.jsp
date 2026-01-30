<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Guest Bill | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Global Theme -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body>

<div class="container-fluid px-4 py-4">

    <!-- PAGE HEADER -->
    <div class="dashboard-hero mb-4">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2><i class="bi bi-receipt"></i> Guest Bill</h2>
                <p class="mb-0">Invoice summary for reservation</p>
            </div>
            <button onclick="window.print()" class="btn btn-light">
                <i class="bi bi-printer"></i> Print
            </button>
        </div>
    </div>

    <!-- BILL CARD -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-4">

            <!-- HEADER -->
            <div class="text-center mb-4">
                <h3 class="fw-bold">
                    <i class="bi bi-water"></i> Ocean View Resort
                </h3>
                <p class="text-muted mb-0">123 Ocean Drive, Paradise City</p>
            </div>

            <hr>

            <!-- BILL INFO -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <p class="mb-1"><strong>Reservation ID:</strong></p>
                    <p class="text-muted">#${bill.reservationId}</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-1"><strong>Bill Date:</strong></p>
                    <p class="text-muted">${bill.generatedAt}</p>
                </div>
            </div>

            <!-- BILL TABLE -->
            <div class="table-responsive">
                <table class="table align-middle">
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
                        <tr class="table-primary">
                            <td class="fw-bold">Total Amount</td>
                            <td class="text-end fw-bold">$${bill.totalAmount}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- STATUS -->
            <div class="text-center mt-4">
                <span class="badge 
                    ${bill.paymentStatus == 'PAID' ? 'bg-success' : 'bg-warning text-dark'}">
                    Payment Status: ${bill.paymentStatus}
                </span>
            </div>

        </div>
    </div>

    <!-- BACK BUTTON -->
    <div class="mt-4 text-center">
        <a href="${pageContext.request.contextPath}/reservations"
           class="btn btn-outline-secondary">
            ← Back to Reservations
        </a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>