package com.oceanview.service;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mindrot.jbcrypt.BCrypt;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;

public class AuthServiceTest {

    @Mock
    private UserDAO userDAO;

    private AuthService authService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        authService = new AuthService(userDAO);
    }

    @Test
    public void testAuthenticateSuccess() {
        // Arrange
        String password = "password123";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt());
        User user = new User(1, "admin", hash, "ADMIN");

        when(userDAO.findByUsername("admin")).thenReturn(Optional.of(user));

        // Act
        Optional<User> result = authService.authenticate("admin", password);

        // Assert
        assertTrue(result.isPresent());
        assertEquals("admin", result.get().getUsername());
    }

    @Test
    public void testAuthenticateFailureWrongPassword() {
        // Arrange
        String password = "password123";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt());
        User user = new User(1, "admin", hash, "ADMIN");

        when(userDAO.findByUsername("admin")).thenReturn(Optional.of(user));

        // Act
        Optional<User> result = authService.authenticate("admin", "wrongpassword");

        // Assert
        assertFalse(result.isPresent());
    }

    @Test
    public void testAuthenticateFailureUserNotFound() {
        // Arrange
        when(userDAO.findByUsername("unknown")).thenReturn(Optional.empty());

        // Act
        Optional<User> result = authService.authenticate("unknown", "password");

        // Assert
        assertFalse(result.isPresent());
    }
}
