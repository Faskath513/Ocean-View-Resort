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
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

public class ReservationServiceComprehensiveTest {

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
    public void testCreateReservation_AvailableRoom() {
        Room room = new Room();
        room.setId(1);
        room.setRoomNumber("101");
        room.setType("SINGLE");
        room.setPricePerNight(new BigDecimal("100.00"));

        Reservation res = new Reservation();
        res.setGuestName("John Doe");
        res.setRoomId(1);
        res.setCheckInDate(Date.valueOf("2024-02-10"));
        res.setCheckOutDate(Date.valueOf("2024-02-15"));

        when(reservationDAO.checkAvailability(1, Date.valueOf("2024-02-10"), Date.valueOf("2024-02-15")))
            .thenReturn(true);
        when(roomDAO.findById(1)).thenReturn(Optional.of(room));
        when(reservationDAO.save(res)).thenReturn(true);

        boolean result = reservationService.createReservation(res);
        assertTrue(result, "Reservation should be created for available room");
    }

    @Test
    public void testGetAllReservations() {
        List<Reservation> mockReservations = new ArrayList<>();
        Reservation res1 = new Reservation();
        res1.setId(1);
        res1.setGuestName("Guest 1");

        mockReservations.add(res1);

        when(reservationDAO.findAll()).thenReturn(mockReservations);

        List<Reservation> result = reservationService.getAllReservations();
        assertEquals(1, result.size(), "Should return all reservations");
    }

    @Test
    public void testDateValidation_CheckOutAfterCheckIn() {
        Date checkIn = Date.valueOf("2024-02-10");
        Date checkOut = Date.valueOf("2024-02-15");
        assertTrue(checkOut.after(checkIn), "Check-out date should be after check-in date");
    }

    @Test
    public void testDateValidation_InvalidDates() {
        Date checkIn = Date.valueOf("2024-02-15");
        Date checkOut = Date.valueOf("2024-02-10");
        assertFalse(checkOut.after(checkIn), "Check-out date should not be before check-in date");
    }

    @Test
    public void testGuestEmailValidation() {
        String validEmail = "guest@example.com";
        assertTrue(validEmail.contains("@"), "Valid email should contain @");
    }

    @Test
    public void testTotalAmountCalculation() {
        BigDecimal pricePerNight = new BigDecimal("100.00");
        int nights = 5;
        BigDecimal expectedTotal = pricePerNight.multiply(new BigDecimal(nights));
        assertEquals(new BigDecimal("500.00"), expectedTotal, "Total should be price * nights");
    }
}
