package com.oceanview.controller;

import com.oceanview.model.User;
import com.oceanview.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() {
        this.authService = new AuthService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("login".equals(action)) {
            handleLogin(req, resp);
        } else if ("logout".equals(action)) {
            handleLogout(req, resp);
        } else if ("resetPassword".equals(action)) {
            handleResetPassword(req, resp);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Optional<User> user = authService.authenticate(username, password);

        if (user.isPresent()) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user.get());
            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
        } else {
            req.setAttribute("error", "Invalid username or password");
            req.getRequestDispatcher("jsp/login.jsp").forward(req, resp);
        }
    }

    private void handleResetPassword(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String currentPassword = req.getParameter("currentPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        // Validate inputs
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Current password is required");
            req.getRequestDispatcher("jsp/reset-password.jsp").forward(req, resp);
            return;
        }

        if (newPassword == null || newPassword.trim().isEmpty()) {
            req.setAttribute("errorMessage", "New password is required");
            req.getRequestDispatcher("jsp/reset-password.jsp").forward(req, resp);
            return;
        }

        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Password confirmation is required");
            req.getRequestDispatcher("jsp/reset-password.jsp").forward(req, resp);
            return;
        }

        // Check if passwords match
        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("errorMessage", "New passwords do not match");
            req.getRequestDispatcher("jsp/reset-password.jsp").forward(req, resp);
            return;
        }

        // Check password strength
        if (!authService.isValidPassword(newPassword)) {
            req.setAttribute("errorMessage", "Password does not meet complexity requirements");
            req.getRequestDispatcher("jsp/reset-password.jsp").forward(req, resp);
            return;
        }

        // Reset password
        if (authService.resetPassword(user.getId(), currentPassword, newPassword)) {
            req.setAttribute("successMessage", "Password updated successfully!");
            req.getRequestDispatcher("jsp/reset-password.jsp").forward(req, resp);
        } else {
            req.setAttribute("errorMessage", "Failed to update password. Current password may be incorrect.");
            req.getRequestDispatcher("jsp/reset-password.jsp").forward(req, resp);
        }
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect("jsp/login.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("logout".equals(action)) {
            handleLogout(req, resp);
        } else {
            req.getRequestDispatcher("jsp/login.jsp").forward(req, resp);
        }
    }
}
