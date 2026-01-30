package com.oceanview.service;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.*;

public class ReservationServiceTest {

    @Mock
    private ReservationDAO reservationDAO;

    @Mock
    private RoomDAO roomDAO;

    private ReservationService reservationService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        reservationService = new ReservationService(reservationDAO, roomDAO);
    }

    @Test
    public void testCreateReservationSuccess() {
        // Arrange
        Reservation res = new Reservation();
        res.setRoomId(101);
        res.setCheckInDate(Date.valueOf("2023-10-01"));
        res.setCheckOutDate(Date.valueOf("2023-10-05"));

        Room room = new Room();
        room.setId(101);
        room.setPricePerNight(new BigDecimal("100.00"));

        when(reservationDAO.checkAvailability(anyInt(), any(Date.class), any(Date.class))).thenReturn(true);
        when(roomDAO.findById(101)).thenReturn(Optional.of(room));
        when(reservationDAO.save(any(Reservation.class))).thenReturn(true);

        // Act
        boolean result = reservationService.createReservation(res);

        // Assert
        assertTrue(result, "Reservation should be successful");
        assertEquals(0, new BigDecimal("400.00").compareTo(res.getTotalAmount()), "Total amount should be 400.00"); // 4
                                                                                                                    // nights
                                                                                                                    // *
                                                                                                                    // 100
        verify(reservationDAO, times(1)).save(res);
    }

    @Test
    public void testCreateReservationOverbooking() {
        // Arrange
        Reservation res = new Reservation();
        res.setRoomId(101);
        res.setCheckInDate(Date.valueOf("2023-10-01"));
        res.setCheckOutDate(Date.valueOf("2023-10-05"));

        when(reservationDAO.checkAvailability(anyInt(), any(Date.class), any(Date.class))).thenReturn(false);

        // Act
        boolean result = reservationService.createReservation(res);

        // Assert
        assertFalse(result, "Reservation should fail due to overbooking");
        verify(reservationDAO, never()).save(any(Reservation.class));
    }

    @Test
    public void testCancelReservation() {
        // Arrange
        int reservationId = 1;
        when(reservationDAO.updateStatus(reservationId, "CANCELLED")).thenReturn(true);

        // Act
        boolean result = reservationService.cancelReservation(reservationId);

        // Assert
        assertTrue(result, "Cancellation should be successful");
        verify(reservationDAO, times(1)).updateStatus(reservationId, "CANCELLED");
    }
}
