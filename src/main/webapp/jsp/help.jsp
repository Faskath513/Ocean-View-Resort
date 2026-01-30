<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Help & Documentation | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Global Theme -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

    <style>
        /* ==================== HELP PAGE CUSTOM STYLES ==================== */
        .dashboard-hero {
            background: var(--gradient-primary);
            color: white;
            padding: 40px;
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            margin-bottom: 30px;
        }
        .dashboard-hero h2 {
            font-weight: 800;
        }
        .dashboard-hero p {
            opacity: 0.9;
        }

        .btn-back {
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.25s ease;
        }
        .btn-back:hover {
            transform: translateY(-2px);
        }

        .card.help-card {
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            margin-bottom: 25px;
            border: none;
        }

        .accordion-button {
            border-radius: 10px;
            background: var(--bg-card);
            color: var(--text-main);
            font-weight: 600;
            transition: all 0.25s ease;
        }
        .accordion-button:not(.collapsed) {
            background: var(--primary-soft);
            color: var(--primary);
        }
        .accordion-button:focus {
            box-shadow: none;
        }

        .accordion-body {
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .accordion-item {
            margin-bottom: 10px;
            border-radius: var(--radius);
            overflow: hidden;
            border: 1px solid var(--border);
        }

        .fade-in {
            animation: fadeUp 0.5s ease-out forwards;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(24px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>

<body>

<div class="container-fluid px-4 py-4">

    <!-- PAGE HEADER -->
    <div class="dashboard-hero fade-in">
        <h2><i class="bi bi-question-circle me-2"></i> Help & Documentation</h2>
        <p class="mb-0">Learn how to use the Ocean View Resort Management System effectively.</p>
    </div>

    <!-- BACK BUTTON -->
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-outline-primary btn-back">
            <i class="bi bi-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <!-- HELP CONTENT -->
    <div class="card help-card fade-in">
        <div class="card-body">
            <div class="accordion" id="helpAccordion">

                <!-- Reservation -->
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#help1">
                            <i class="bi bi-calendar-event me-2"></i>
                            How do I create a reservation?
                        </button>
                    </h2>
                    <div id="help1" class="accordion-collapse collapse show" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            Navigate to <strong>Reservations</strong> → Click <strong>New Reservation</strong>.  
                            Select an available room and enter guest details such as name, contact info, and stay duration.  
                            Add special requests or notes for housekeeping if needed.
                        </div>
                    </div>
                </div>

                <!-- Billing -->
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#help2">
                            <i class="bi bi-receipt me-2"></i>
                            How is billing calculated?
                        </button>
                    </h2>
                    <div id="help2" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            The system calculates the total bill based on:
                            <ul class="mt-2">
                                <li>Number of nights stayed</li>
                                <li>Room rate per night</li>
                                <li>Applicable taxes (15%)</li>
                                <li>Service charges</li>
                                <li>Additional services (spa, restaurant, transportation)</li>
                            </ul>
                            Generate PDF invoices anytime via <strong>Billing</strong> tab.
                        </div>
                    </div>
                </div>

                <!-- Rooms -->
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#help3">
                            <i class="bi bi-door-closed me-2"></i>
                            Managing rooms
                        </button>
                    </h2>
                    <div id="help3" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            Only <strong>Admin users</strong> can add, update, or delete rooms.  
                            Go to <strong>Rooms</strong> → <strong>Manage Room Types</strong> to add, update, or set availability.
                        </div>
                    </div>
                </div>

                <!-- Address -->
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#help4">
                            <i class="bi bi-geo-alt me-2"></i>
                            Guest registration & address
                        </button>
                    </h2>
                    <div id="help4" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            Guest address details are mandatory when creating a reservation: Street, City, State, Zip, Country.  
                            Correct info ensures accurate billing and regulatory compliance.
                        </div>
                    </div>
                </div>

                <!-- Security -->
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#help5">
                            <i class="bi bi-shield-lock me-2"></i>
                            Security & logout
                        </button>
                    </h2>
                    <div id="help5" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            Always use the <strong>Logout</strong> button to securely end your session.  
                            Do not share credentials and lock your workstation when away.
                        </div>
                    </div>
                </div>

                <!-- Reports -->
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#help6">
                            <i class="bi bi-bar-chart-line me-2"></i>
                            Viewing reports
                        </button>
                    </h2>
                    <div id="help6" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            Reports provide insights into hotel operations:
                            <ul class="mt-2">
                                <li>Revenue trends</li>
                                <li>Guest activity and history</li>
                                <li>Room occupancy stats</li>
                            </ul>
                            Access via <strong>Reports</strong> menu and select the desired type.
                        </div>
                    </div>
                </div>

                <!-- Notifications -->
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#help7">
                            <i class="bi bi-bell me-2"></i>
                            Notifications & alerts
                        </button>
                    </h2>
                    <div id="help7" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            System alerts for:
                            <ul class="mt-2">
                                <li>New reservations</li>
                                <li>Pending payments</li>
                                <li>Room maintenance</li>
                                <li>System updates</li>
                            </ul>
                            Configure notification settings for timely alerts.
                        </div>
                    </div>
                </div>

                <!-- User Management -->
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#help8">
                            <i class="bi bi-people me-2"></i>
                            Managing users & roles
                        </button>
                    </h2>
                    <div id="help8" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            Admin users can add/edit/remove users. Roles:
                            <ul class="mt-2">
                                <li><strong>Admin:</strong> Full access</li>
                                <li><strong>Receptionist:</strong> Reservations & billing</li>
                                <li><strong>Housekeeping:</strong> View room assignments</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Support -->
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#help9">
                            <i class="bi bi-life-preserver me-2"></i>
                            Contact & support
                        </button>
                    </h2>
                    <div id="help9" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            Technical support:
                            <ul class="mt-2">
                                <li>Email: <a href="mailto:support@oceanviewresort.com">support@oceanviewresort.com</a></li>
                                <li>Phone: +94 11 234 5678</li>
                                <li>Office Hours: Mon–Fri, 8am–6pm</li>
                            </ul>
                            Use the support portal to submit and track tickets.
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>