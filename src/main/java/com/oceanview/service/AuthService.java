package com.oceanview.service;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import org.mindrot.jbcrypt.BCrypt;
import java.util.Optional;

public class AuthService {
    private UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }

    // Constructor for testing
    public AuthService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public Optional<User> authenticate(String username, String password) {
        Optional<User> userOpt = userDAO.findByUsername(username);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (BCrypt.checkpw(password, user.getPasswordHash())) {
                return Optional.of(user);
            }
        }
        return Optional.empty();
    }

    public boolean resetPassword(int userId, String currentPassword, String newPassword) {
        Optional<User> userOpt = userDAO.findById(userId);
        
        if (!userOpt.isPresent()) {
            return false;
        }

        User user = userOpt.get();
        
        // Verify current password
        if (!BCrypt.checkpw(currentPassword, user.getPasswordHash())) {
            return false;
        }

        // Hash new password
        String newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        // Update password in database
        return userDAO.updatePassword(userId, newPasswordHash);
    }

    public boolean isValidPassword(String password) {
        // Password must be at least 8 characters
        if (password.length() < 8) {
            return false;
        }
        
        // Must contain uppercase
        if (!password.matches(".*[A-Z].*")) {
            return false;
        }
        
        // Must contain lowercase
        if (!password.matches(".*[a-z].*")) {
            return false;
        }
        
        // Must contain number
        if (!password.matches(".*\\d.*")) {
            return false;
        }
        
        // Must contain special character
        if (!password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?].*")) {
            return false;
        }
        
        return true;
    }
}
