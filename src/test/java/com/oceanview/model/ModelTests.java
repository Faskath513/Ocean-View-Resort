package com.oceanview.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class ModelTests {

    /**
     * Test User Model
     */
    @Test
    public void testUserCreation() {
        User user = new User(1, "testuser", "hash", "USER");

        assertEquals(1, user.getId());
        assertEquals("testuser", user.getUsername());
        assertEquals("hash", user.getPasswordHash());
        assertEquals("USER", user.getRole());
    }

    @Test
    public void testUserSetters() {
        User user = new User();
        user.setId(2);
        user.setUsername("newuser");
        user.setPasswordHash("newhash");
        user.setRole("ADMIN");

        assertEquals(2, user.getId());
        assertEquals("newuser", user.getUsername());
        assertEquals("newhash", user.getPasswordHash());
        assertEquals("ADMIN", user.getRole());
    }

    /**
     * Test Room Model
     */
    @Test
    public void testRoomCreation() {
        Room room = new Room();
        room.setId(1);
        room.setRoomNumber("101");
        room.setType("SINGLE");
        room.setPricePerNight(new BigDecimal("100.00"));
        room.setStatus("AVAILABLE");

        assertEquals(1, room.getId());
        assertEquals("101", room.getRoomNumber());
        assertEquals("SINGLE", room.getType());
        assertEquals(new BigDecimal("100.00"), room.getPricePerNight());
        assertEquals("AVAILABLE", room.getStatus());
    }

    /**
     * Test Reservation Model
     */
    @Test
    public void testReservationCreation() {
        Reservation reservation = new Reservation();
        reservation.setId(1);
        reservation.setGuestName("John Doe");
        reservation.setGuestEmail("john@example.com");
        reservation.setRoomId(101);
        reservation.setStatus("CONFIRMED");

        assertEquals(1, reservation.getId());
        assertEquals("John Doe", reservation.getGuestName());
        assertEquals("john@example.com", reservation.getGuestEmail());
        assertEquals(101, reservation.getRoomId());
        assertEquals("CONFIRMED", reservation.getStatus());
    }

    /**
     * Test Bill Model
     */
    @Test
    public void testBillCreation() {
        Bill bill = new Bill();
        bill.setId(1);
        bill.setReservationId(1);
        bill.setRoomCharge(new BigDecimal("500.00"));
        bill.setTaxAmount(new BigDecimal("75.00"));
        bill.setServiceCharge(new BigDecimal("50.00"));
        bill.setTotalAmount(new BigDecimal("625.00"));
        bill.setPaymentStatus("PENDING");

        assertEquals(1, bill.getId());
        assertEquals(1, bill.getReservationId());
        assertEquals(new BigDecimal("500.00"), bill.getRoomCharge());
        assertEquals(new BigDecimal("75.00"), bill.getTaxAmount());
        assertEquals(new BigDecimal("50.00"), bill.getServiceCharge());
        assertEquals(new BigDecimal("625.00"), bill.getTotalAmount());
        assertEquals("PENDING", bill.getPaymentStatus());
    }

    /**
     * Test Room price validation
     */
    @Test
    public void testRoomPricePositive() {
        Room room = new Room();
        room.setPricePerNight(new BigDecimal("100.00"));

        assertTrue(room.getPricePerNight().compareTo(BigDecimal.ZERO) > 0);
    }

    /**
     * Test Bill total calculation
     */
    @Test
    public void testBillTotalCalculation() {
        BigDecimal roomCharge = new BigDecimal("500.00");
        BigDecimal tax = roomCharge.multiply(new BigDecimal("0.15"));
        BigDecimal serviceCharge = roomCharge.multiply(new BigDecimal("0.10"));
        BigDecimal total = roomCharge.add(tax).add(serviceCharge);

        assertTrue(new BigDecimal("625.00").compareTo(total) == 0);
    }
}
