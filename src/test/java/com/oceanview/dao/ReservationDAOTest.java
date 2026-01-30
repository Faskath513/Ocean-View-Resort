package com.oceanview.dao;

import com.oceanview.util.DatabaseConnection;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.math.BigDecimal;
import com.oceanview.model.Reservation;
import static org.mockito.ArgumentMatchers.any;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

public class ReservationDAOTest {

    @Mock
    private Connection connection;

    @Mock
    private PreparedStatement preparedStatement;

    @Mock
    private ResultSet resultSet;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testCheckAvailability_RoomAvailable() throws Exception {
        try (MockedStatic<DatabaseConnection> mockedDb = Mockito.mockStatic(DatabaseConnection.class)) {
            DatabaseConnection dbInstance = mock(DatabaseConnection.class);
            mockedDb.when(DatabaseConnection::getInstance).thenReturn(dbInstance);
            when(dbInstance.getConnection()).thenReturn(connection);

            when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
            when(preparedStatement.executeQuery()).thenReturn(resultSet);
            when(resultSet.next()).thenReturn(true);
            when(resultSet.getInt(1)).thenReturn(0); // Count 0 means no conflict

            ReservationDAO dao = new ReservationDAO();
            boolean result = dao.checkAvailability(101, Date.valueOf("2023-10-01"), Date.valueOf("2023-10-05"));

            assertTrue(result, "Room should be available when count is 0");
        }
    }

    @Test
    public void testCheckAvailability_RoomOccupied() throws Exception {
        try (MockedStatic<DatabaseConnection> mockedDb = Mockito.mockStatic(DatabaseConnection.class)) {
            DatabaseConnection dbInstance = mock(DatabaseConnection.class);
            mockedDb.when(DatabaseConnection::getInstance).thenReturn(dbInstance);
            when(dbInstance.getConnection()).thenReturn(connection);

            when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
            when(preparedStatement.executeQuery()).thenReturn(resultSet);
            when(resultSet.next()).thenReturn(true);
            when(resultSet.getInt(1)).thenReturn(1); // Count > 0 means conflict

            ReservationDAO dao = new ReservationDAO();
            boolean result = dao.checkAvailability(101, Date.valueOf("2023-10-01"), Date.valueOf("2023-10-05"));

            assertFalse(result, "Room should NOT be available when count is > 0");
        }
    }

    @Test
    public void testSaveReservation() throws Exception {
        try (MockedStatic<DatabaseConnection> mockedDb = Mockito.mockStatic(DatabaseConnection.class)) {
            DatabaseConnection dbInstance = mock(DatabaseConnection.class);
            mockedDb.when(DatabaseConnection::getInstance).thenReturn(dbInstance);
            when(dbInstance.getConnection()).thenReturn(connection);

            when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
            when(preparedStatement.executeUpdate()).thenReturn(1);

            Reservation res = new Reservation();
            res.setGuestName("John Doe");
            res.setRoomId(101);
            res.setRoomType("SINGLE");
            res.setCheckInDate(Date.valueOf("2023-10-01"));
            res.setCheckOutDate(Date.valueOf("2023-10-05"));
            res.setTotalAmount(new BigDecimal("400.00"));
            res.setStatus("PENDING");

            ReservationDAO dao = new ReservationDAO();
            boolean result = dao.save(res);

            assertTrue(result, "Reservation should be saved successfully");
            verify(preparedStatement).setString(10, "SINGLE"); // Verify roomType is set at parameter 10
        }
    }
}
