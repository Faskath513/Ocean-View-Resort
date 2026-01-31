<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanview.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - Ocean View Resort</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <!-- Ocean View Theme CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Navbar -->
    <%@ include file="includes/navbar.jsp" %>

    <!-- Main Container -->
    <div class="container mt-5 fade-in">

        <!-- Dashboard Header -->
        <!-- <div class="dashboard-hero text-center mb-4">
            <h2>Reset Password</h2>
            <p>Update your account password</p>
        </div> -->

        <!-- Reset Password Card -->
        <div class="dashboard-card mx-auto" style="max-width: 500px;">

            <!-- Form Icon -->
            <div class="room-image mb-4">
                <i class="bi bi-shield-lock"></i>
            </div>

            <!-- Success/Error Messages -->
            <% String successMessage = (String) request.getAttribute("successMessage");
               String errorMessage = (String) request.getAttribute("errorMessage");
            %>
            <% if (successMessage != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle"></i> <%= successMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle"></i> <%= errorMessage %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <!-- Password Reset Form -->
            <form method="POST" action="<%= request.getContextPath() %>/auth?action=resetPassword" id="resetPasswordForm">

                <!-- Current Password -->
                <div class="form-group mb-3">
                    <label for="currentPassword" class="form-label">
                        <i class="bi bi-lock"></i> Current Password
                    </label>
                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                </div>

                <!-- New Password -->
                <div class="form-group mb-3">
                    <label for="newPassword" class="form-label">
                        <i class="bi bi-key"></i> New Password
                    </label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    <div class="password-strength" id="passwordStrength"></div>
                </div>

                <!-- Confirm Password -->
                <div class="form-group mb-3">
                    <label for="confirmPassword" class="form-label">
                        <i class="bi bi-key-fill"></i> Confirm New Password
                    </label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    <div id="passwordMatch" style="margin-top: 8px; font-size: 0.85rem; color: var(--danger); display: none;">
                        <i class="bi bi-x-circle"></i> Passwords do not match
                    </div>
                </div>

                <!-- Password Requirements -->
                <div class="password-requirements mb-3">
                    <div style="font-weight: 600; margin-bottom: 10px;">Password Requirements:</div>
                    <div class="requirement unmet" id="req-length">
                        <i class="bi bi-circle-fill"></i> At least 8 characters
                    </div>
                    <div class="requirement unmet" id="req-uppercase">
                        <i class="bi bi-circle-fill"></i> At least one uppercase letter
                    </div>
                    <div class="requirement unmet" id="req-lowercase">
                        <i class="bi bi-circle-fill"></i> At least one lowercase letter
                    </div>
                    <div class="requirement unmet" id="req-number">
                        <i class="bi bi-circle-fill"></i> At least one number
                    </div>
                    <div class="requirement unmet" id="req-special">
                        <i class="bi bi-circle-fill"></i> At least one special character (!@#$%^&*)
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary w-100 mb-2" id="submitBtn">
                    <i class="bi bi-check-circle"></i> Update Password
                </button>

                <a href="<%= request.getContextPath() %>/jsp/profile.jsp" class="btn btn-outline-primary w-100">
                    <i class="bi bi-arrow-left"></i> Back to Profile
                </a>
            </form>
        </div>

        <!-- Footer -->
        <div class="text-center mt-5 mb-4">
            <p>&copy; 2026 Ocean View Resort. All rights reserved.</p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const newPasswordInput = document.getElementById('newPassword');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const passwordStrength = document.getElementById('passwordStrength');
        const passwordMatch = document.getElementById('passwordMatch');
        const submitBtn = document.getElementById('submitBtn');

        // Password requirements checker
        function checkPasswordRequirements(password) {
            const requirements = {
                length: password.length >= 8,
                uppercase: /[A-Z]/.test(password),
                lowercase: /[a-z]/.test(password),
                number: /\d/.test(password),
                special: /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)
            };

            document.getElementById('req-length').classList.toggle('met', requirements.length);
            document.getElementById('req-length').classList.toggle('unmet', !requirements.length);

            document.getElementById('req-uppercase').classList.toggle('met', requirements.uppercase);
            document.getElementById('req-uppercase').classList.toggle('unmet', !requirements.uppercase);

            document.getElementById('req-lowercase').classList.toggle('met', requirements.lowercase);
            document.getElementById('req-lowercase').classList.toggle('unmet', !requirements.lowercase);

            document.getElementById('req-number').classList.toggle('met', requirements.number);
            document.getElementById('req-number').classList.toggle('unmet', !requirements.number);

            document.getElementById('req-special').classList.toggle('met', requirements.special);
            document.getElementById('req-special').classList.toggle('unmet', !requirements.special);

            return Object.values(requirements).every(v => v);
        }

        // Update password strength indicator
        function updatePasswordStrength() {
            const password = newPasswordInput.value;
            if (!password) {
                passwordStrength.className = 'password-strength';
                return;
            }

            const hasLength = password.length >= 8;
            const hasUppercase = /[A-Z]/.test(password);
            const hasLowercase = /[a-z]/.test(password);
            const hasNumber = /\d/.test(password);
            const hasSpecial = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password);

            let strength = 0;
            if (hasLength) strength++;
            if (hasUppercase) strength++;
            if (hasLowercase) strength++;
            if (hasNumber) strength++;
            if (hasSpecial) strength++;

            passwordStrength.className = 'password-strength';
            if (strength <= 2) {
                passwordStrength.classList.add('weak');
                passwordStrength.innerHTML = '<i class="bi bi-exclamation-circle"></i> Weak password';
            } else if (strength <= 3) {
                passwordStrength.classList.add('medium');
                passwordStrength.innerHTML = '<i class="bi bi-info-circle"></i> Medium strength password';
            } else {
                passwordStrength.classList.add('strong');
                passwordStrength.innerHTML = '<i class="bi bi-check-circle"></i> Strong password';
            }
        }

        // Check password match
        function checkPasswordMatch() {
            if (confirmPasswordInput.value && newPasswordInput.value !== confirmPasswordInput.value) {
                passwordMatch.style.display = 'block';
                submitBtn.disabled = true;
            } else {
                passwordMatch.style.display = 'none';
                submitBtn.disabled = false;
            }
        }

        // Form validation
        function validateForm(e) {
            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = newPasswordInput.value;
            const confirmPassword = confirmPasswordInput.value;

            if (!currentPassword) {
                alert('Please enter your current password');
                e.preventDefault();
                return false;
            }

            if (!checkPasswordRequirements(newPassword)) {
                alert('New password does not meet all requirements');
                e.preventDefault();
                return false;
            }

            if (newPassword !== confirmPassword) {
                alert('Passwords do not match');
                e.preventDefault();
                return false;
            }

            return true;
        }

        newPasswordInput.addEventListener('input', updatePasswordStrength);
        confirmPasswordInput.addEventListener('input', checkPasswordMatch);
        document.getElementById('resetPasswordForm').addEventListener('submit', validateForm);
    </script>
</body>
</html>