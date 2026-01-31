<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <title>
        <c:choose>
            <c:when test="${room != null}">Edit Room</c:when>
            <c:otherwise>Add New Room</c:otherwise>
        </c:choose>
    </title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Ocean View Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<div class="container mt-5 fade-in">

    <!-- Header Card -->
    <div class="dashboard-hero mb-4">
        <h2 class="mb-1">
            <c:choose>
                <c:when test="${room != null}">Edit Room</c:when>
                <c:otherwise>Add New Room</c:otherwise>
            </c:choose>
        </h2>
        <p class="mb-0">
            Manage room details, pricing, and availability
        </p>
    </div>

    <!-- Form Card -->
    <div class="dashboard-card">

        <form action="${pageContext.request.contextPath}/rooms" method="post">

            <!-- Hidden ID for Edit -->
            <c:if test="${room != null}">
                <input type="hidden" name="id" value="${room.id}">
            </c:if>

            <div class="row g-4">

                <!-- Room Number -->
                <div class="col-md-6">
                    <label class="form-label">Room Number</label>
                    <input type="text"
                           name="roomNumber"
                           class="form-control"
                           placeholder="e.g. 101"
                           value="${room.roomNumber}"
                           required>
                </div>

                <!-- Room Type -->
                <div class="col-md-6">
                    <label class="form-label">Room Type</label>
                    <select name="type" class="form-select" required>
                        <option value="">Select Type</option>

                        <option value="SINGLE"
                            <c:if test="${room.type == 'SINGLE'}">selected</c:if>>
                            Single
                        </option>

                        <option value="DOUBLE"
                            <c:if test="${room.type == 'DOUBLE'}">selected</c:if>>
                            Double
                        </option>

                        <option value="SUITE"
                            <c:if test="${room.type == 'SUITE'}">selected</c:if>>
                            Suite
                        </option>
                    </select>
                </div>

                <!-- Price -->
                <div class="col-md-6">
                    <label class="form-label">Price Per Night (LKR)</label>
                    <input type="number"
                           step="0.01"
                           name="price"
                           class="form-control"
                           placeholder="15000.00"
                           value="${room.pricePerNight}"
                           required>
                </div>

                <!-- Status -->
                <div class="col-md-6">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select" required>

                        <option value="AVAILABLE"
                            <c:if test="${room.status == 'AVAILABLE'}">selected</c:if>>
                            Available
                        </option>

                        <option value="OCCUPIED"
                            <c:if test="${room.status == 'OCCUPIED'}">selected</c:if>>
                            Occupied
                        </option>

                        <option value="MAINTENANCE"
                            <c:if test="${room.status == 'MAINTENANCE'}">selected</c:if>>
                            Maintenance
                        </option>

                    </select>
                </div>

            </div>

            <!-- Actions -->
            <div class="d-flex justify-content-end gap-2 mt-4">
                <a href="${pageContext.request.contextPath}/rooms"
                   class="btn btn-outline-primary">
                    Cancel
                </a>

                <button type="submit" class="btn btn-primary px-4">
                    Save Room
                </button>
            </div>

        </form>
    </div>
</div>

</body>
</html>