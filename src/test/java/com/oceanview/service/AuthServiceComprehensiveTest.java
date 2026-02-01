package com.oceanview.service;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mindrot.jbcrypt.BCrypt;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;

public class AuthServiceComprehensiveTest {

    @Mock
    private UserDAO userDAO;

    private AuthService authService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        authService = new AuthService(userDAO);
    }

    @Test
    public void testPasswordStrengthValidation_ValidPassword() {
        String validPassword = "SecurePass123!";
        assertTrue(authService.isValidPassword(validPassword), "Should accept strong password");
    }

    @Test
    public void testPasswordStrengthValidation_TooShort() {
        String shortPassword = "Short1!";
        assertFalse(authService.isValidPassword(shortPassword), "Should reject password < 8 chars");
    }

    @Test
    public void testPasswordStrengthValidation_NoUppercase() {
        String noUppercase = "password123!";
        assertFalse(authService.isValidPassword(noUppercase), "Should reject password without uppercase");
    }

    @Test
    public void testPasswordStrengthValidation_NoNumber() {
        String noNumber = "PasswordTest!";
        assertFalse(authService.isValidPassword(noNumber), "Should reject password without number");
    }

    @Test
    public void testPasswordStrengthValidation_NoSpecialChar() {
        String noSpecial = "Password123";
        assertFalse(authService.isValidPassword(noSpecial), "Should reject password without special char");
    }

    @Test
    public void testResetPassword_Success() {
        String currentPassword = "OldPassword123!";
        String newPassword = "NewPassword456!";
        String currentHash = BCrypt.hashpw(currentPassword, BCrypt.gensalt());
        User user = new User(1, "testuser", currentHash, "USER");

        when(userDAO.findById(1)).thenReturn(Optional.of(user));
        when(userDAO.updatePassword(eq(1), anyString())).thenReturn(true);

        boolean result = authService.resetPassword(1, currentPassword, newPassword);
        assertTrue(result, "Password reset should succeed");
    }

    @Test
    public void testResetPassword_WrongCurrentPassword() {
        String currentPassword = "OldPassword123!";
        String wrongPassword = "WrongPassword!";
        String newPassword = "NewPassword456!";
        String currentHash = BCrypt.hashpw(currentPassword, BCrypt.gensalt());
        User user = new User(1, "testuser", currentHash, "USER");

        when(userDAO.findById(1)).thenReturn(Optional.of(user));

        boolean result = authService.resetPassword(1, wrongPassword, newPassword);
        assertFalse(result, "Password reset should fail with wrong current password");
    }

    @Test
    public void testAuthenticate_Success() {
        String password = "TestPass123!";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt());
        User user = new User(1, "admin", hash, "ADMIN");

        when(userDAO.findByUsername("admin")).thenReturn(Optional.of(user));

        Optional<User> result = authService.authenticate("admin", password);
        assertTrue(result.isPresent(), "Authentication should succeed with valid credentials");
    }

    @Test
    public void testAuthenticate_InvalidPassword() {
        String password = "TestPass123!";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt());
        User user = new User(1, "admin", hash, "ADMIN");

        when(userDAO.findByUsername("admin")).thenReturn(Optional.of(user));

        Optional<User> result = authService.authenticate("admin", "wrongpassword");
        assertFalse(result.isPresent(), "Authentication should fail with invalid password");
    }

    @Test
    public void testAuthenticate_UserNotFound() {
        when(userDAO.findByUsername("unknown")).thenReturn(Optional.empty());

        Optional<User> result = authService.authenticate("unknown", "password");
        assertFalse(result.isPresent(), "Authentication should fail if user not found");
    }
}
