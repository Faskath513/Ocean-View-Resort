<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Reports</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-4">
                <h2>System Reports</h2>
                <div class="mb-4">
                    <a href="reports?type=revenue" class="btn btn-outline-primary">Revenue Report</a>
                    <a href="reports?type=guest" class="btn btn-outline-primary">Guest Report</a>
                    <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-secondary">Back to
                        Dashboard</a>
                </div>

                <c:if test="${not empty reportContent}">
                    <h3>${reportName}</h3>
                    <div class="mt-3">
                        ${reportContent}
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
            </div>
        </body>

        </html>