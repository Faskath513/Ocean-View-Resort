<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports - Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

    <style>
        /* ==================== REPORT PAGE STYLES ==================== */
        .page-header {
            background: linear-gradient(135deg, #14b8a6, #2dd4bf);
            color: white;
            padding: 25px 30px;
            border-radius: 14px;
            box-shadow: 0 12px 40px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .page-header h2 {
            font-weight: 800;
            margin: 0;
        }

        .report-actions {
            margin-bottom: 25px;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .report-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 12px 40px rgba(0,0,0,0.08);
            margin-top: 20px;
            border: 1px solid #e5e7eb;
        }

        .report-card h4 {
            font-weight: 700;
            margin-bottom: 15px;
            color: #0f766e;
        }

        .btn-report {
            font-weight: 600;
            border-radius: 10px;
            padding: 10px 18px;
            transition: all 0.25s ease;
        }

        .btn-report:hover {
            transform: translateY(-2px);
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

        .empty-state h5 {
            color: #999;
            margin-bottom: 15px;
        }

        .alert {
            border-radius: 10px;
        }
    </style>
</head>

<body>
<div class="container-fluid px-4 py-4">

    <!-- PAGE HEADER -->
    <div class="page-header fade-in">
        <h2><i class="bi bi-bar-chart-line me-2"></i> Reports & Analytics</h2>
        <p class="mb-0">View and analyze system data for reservations, guests, and revenue.</p>
    </div>

    <!-- BACK BUTTON -->
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <!-- REPORT ACTION BUTTONS -->
    <div class="report-actions fade-in">
        <a href="reports?type=revenue" class="btn btn-report btn-outline-primary">
            <i class="bi bi-cash-stack me-1"></i> Revenue Report
        </a>
        <a href="reports?type=guest" class="btn btn-report btn-outline-primary">
            <i class="bi bi-person-lines-fill me-1"></i> Guest Report
        </a>
        <a href="reports?type=occupancy" class="btn btn-report btn-outline-primary">
            <i class="bi bi-house-door-fill me-1"></i> Occupancy Report
        </a>
        <a href="reports?type=payments" class="btn btn-report btn-outline-primary">
            <i class="bi bi-credit-card-2-front me-1"></i> Payments Report
        </a>
    </div>

    <!-- REPORT CONTENT -->
    <c:choose>
        <c:when test="${not empty reportContent}">
            <div class="report-card fade-in">
                <h4>${reportName}</h4>
                <hr>
                <div>
                    ${reportContent}
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state fade-in">
                <i class="bi bi-inbox"></i>
                <h5>No reports to display</h5>
                <p class="text-muted">Select a report type from above to generate analytics.</p>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- ERROR MESSAGE -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger fade-in mt-4">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
        </div>
    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>