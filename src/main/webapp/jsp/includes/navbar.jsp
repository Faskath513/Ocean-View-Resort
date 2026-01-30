<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard.jsp">
            <i class="bi bi-water"></i> Ocean View Resort
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/reservations">
                        <i class="bi bi-calendar-event"></i> Reservations
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/rooms">
                        <i class="bi bi-door-closed"></i> Rooms
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/reports">
                        <i class="bi bi-bar-chart"></i> Reports
                    </a>
                </li>

                <li class="nav-item">
                    <span class="nav-link welcome-badge">
                        <i class="bi bi-person-circle"></i>
                        ${user.username} (${user.role})
                    </span>
                </li>

                <li class="nav-item">
                    <a class="btn btn-danger btn-sm ms-lg-2"
                        href="${pageContext.request.contextPath}/auth?action=logout">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>