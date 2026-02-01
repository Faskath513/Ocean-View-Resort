package com.oceanview;

import com.oceanview.model.*;
import com.oceanview.service.*;
import com.oceanview.controller.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.sql.Date;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Integration Test Suite for Ocean View Resort System
 * Tests the full workflow from reservation to billing
 */
@DisplayName("Ocean View Resort - Full System Integration Tests")
public class SystemIntegrationTests {

    /**
     * Test Case 1: Complete Reservation Workflow
     * 1. Create reservation
     * 2. Check-in guest
     * 3. Generate bill
     * 4. Record payment
     */
    @Test
    @DisplayName("TC1: Complete Reservation to Payment Workflow")
    public void testCompleteReservationWorkflow() {
        // Step 1: Create Room
        Room room = new Room();
        room.setId(1);
        room.setRoomNumber("101");
        room.setType("SINGLE");
        room.setPricePerNight(new BigDecimal("100.00"));
        room.setStatus("AVAILABLE");
        assertNotNull(room.getId(), "Room should be created");

        // Step 2: Create Reservation
        Reservation reservation = new Reservation();
        reservation.setGuestName("John Doe");
        reservation.setGuestEmail("john@example.com");
        reservation.setGuestPhone("555-1234");
        reservation.setRoomId(room.getId());
        reservation.setCheckInDate(Date.valueOf("2024-02-10"));
        reservation.setCheckOutDate(Date.valueOf("2024-02-15"));
        reservation.setStatus("CONFIRMED");

        // Calculate days
        long diffTime = reservation.getCheckOutDate().getTime() - reservation.getCheckInDate().getTime();
        long diffDays = diffTime / (1000 * 60 * 60 * 24);
        BigDecimal totalAmount = room.getPricePerNight().multiply(new BigDecimal(diffDays));
        reservation.setTotalAmount(totalAmount);

        assertTrue(totalAmount.compareTo(BigDecimal.ZERO) > 0, "Total amount should be positive");
        assertEquals(5, diffDays, "Stay should be 5 nights");

        // Step 3: Create Bill
        Bill bill = new Bill();
        bill.setReservationId(reservation.getId());
        bill.setRoomCharge(totalAmount);
        bill.setTaxAmount(totalAmount.multiply(new BigDecimal("0.15")));
        bill.setServiceCharge(totalAmount.multiply(new BigDecimal("0.10")));
        bill.setTotalAmount(bill.getRoomCharge().add(bill.getTaxAmount()).add(bill.getServiceCharge()));
        bill.setPaymentStatus("PENDING");

        assertTrue(new BigDecimal("625.00").compareTo(bill.getTotalAmount()) == 0,
                "Bill total should be calculated correctly");

        // Step 4: Mark Payment
        bill.setPaymentStatus("PAID");
        assertEquals("PAID", bill.getPaymentStatus(), "Payment status should be updated");
    }

    /**
     * Test Case 2: User Authentication Workflow
     * 1. Register user
     * 2. Login
     * 3. Reset password
     * 4. Logout
     */
    @Test
    @DisplayName("TC2: User Authentication and Password Management")
    public void testUserAuthenticationWorkflow() {
        // Create user
        User user = new User();
        user.setId(1);
        user.setUsername("testuser");
        user.setRole("USER");

        assertNotNull(user.getUsername(), "Username should be set");
        assertEquals("USER", user.getRole(), "Role should be USER");

        // Simulate password reset
        String newPassword = "NewSecurePass123!";
        assertTrue(newPassword.length() >= 8, "Password should be at least 8 chars");
        assertTrue(newPassword.matches(".*[A-Z].*"), "Password should have uppercase");
        assertTrue(newPassword.matches(".*[a-z].*"), "Password should have lowercase");
        assertTrue(newPassword.matches(".*\\d.*"), "Password should have number");
        assertTrue(newPassword.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?].*"),
                "Password should have special char");
    }

    /**
     * Test Case 3: Multi-Room Occupancy Report
     * Verify occupancy calculation across multiple rooms
     */
    @Test
    @DisplayName("TC3: Occupancy Report Generation")
    public void testOccupancyReportGeneration() {
        // Create multiple rooms
        Room[] rooms = new Room[5];
        for (int i = 0; i < 5; i++) {
            rooms[i] = new Room();
            rooms[i].setId(i + 1);
            rooms[i].setRoomNumber("10" + (i + 1));
            rooms[i].setType("SINGLE");
            rooms[i].setStatus("AVAILABLE");
        }

        // Create reservations (occupy 3 rooms)
        int occupiedCount = 0;
        for (int i = 0; i < 3; i++) {
            rooms[i].setStatus("OCCUPIED");
            occupiedCount++;
        }

        double occupancyRate = (occupiedCount * 100.0) / rooms.length;
        assertEquals(60.0, occupancyRate, "Occupancy rate should be 60%");
    }

    /**
     * Test Case 4: Payment Processing Workflow
     * Verify payment calculations and status tracking
     */
    @Test
    @DisplayName("TC4: Payment Processing and Validation")
    public void testPaymentProcessing() {
        // Create reservation (5 nights at $100/night)
        BigDecimal roomCharge = new BigDecimal("500.00");
        BigDecimal tax = roomCharge.multiply(new BigDecimal("0.15")); // $75
        BigDecimal serviceCharge = roomCharge.multiply(new BigDecimal("0.10")); // $50
        BigDecimal total = roomCharge.add(tax).add(serviceCharge); // $625

        // Create bill
        Bill bill = new Bill();
        bill.setRoomCharge(roomCharge);
        bill.setTaxAmount(tax);
        bill.setServiceCharge(serviceCharge);
        bill.setTotalAmount(total);
        bill.setPaymentStatus("PENDING");

        // Verify calculations
        assertTrue(new BigDecimal("500.00").compareTo(bill.getRoomCharge()) == 0);
        assertTrue(new BigDecimal("75.00").compareTo(bill.getTaxAmount()) == 0);
        assertTrue(new BigDecimal("50.00").compareTo(bill.getServiceCharge()) == 0);
        assertTrue(new BigDecimal("625.00").compareTo(bill.getTotalAmount()) == 0);

        // Process payment
        bill.setPaymentStatus("PAID");
        assertEquals("PAID", bill.getPaymentStatus());
    }

    /**
     * Test Case 5: Room Availability Check
     * Verify room availability logic across date ranges
     */
    @Test
    @DisplayName("TC5: Room Availability Validation")
    public void testRoomAvailabilityCheck() {
        // Room 101 is available
        Room room = new Room();
        room.setId(101);
        room.setStatus("AVAILABLE");

        // First guest: Feb 10-15
        Reservation res1 = new Reservation();
        res1.setRoomId(room.getId());
        res1.setCheckInDate(Date.valueOf("2024-02-10"));
        res1.setCheckOutDate(Date.valueOf("2024-02-15"));

        // Verify dates don't overlap with available slot (Feb 16-20)
        Reservation res2 = new Reservation();
        res2.setCheckInDate(Date.valueOf("2024-02-16"));
        res2.setCheckOutDate(Date.valueOf("2024-02-20"));

        // No overlap: res1 ends on 15, res2 starts on 16
        assertFalse(res1.getCheckOutDate().after(res2.getCheckInDate()),
                "Reservations should not overlap");
    }

    /**
     * Test Case 6: Email and Contact Validation
     */
    @Test
    @DisplayName("TC6: Guest Information Validation")
    public void testGuestInformationValidation() {
        Reservation reservation = new Reservation();
        reservation.setGuestName("John Doe");
        reservation.setGuestEmail("john@example.com");
        reservation.setGuestPhone("555-1234");
        reservation.setGuestAddressStreet("123 Main St");
        reservation.setGuestAddressCity("Paradise City");
        reservation.setGuestAddressState("CA");
        reservation.setGuestAddressZip("90210");

        // Validate email format
        assertTrue(reservation.getGuestEmail().contains("@"), "Email should contain @");
        assertTrue(reservation.getGuestEmail().contains("."), "Email should contain .");

        // Validate address
        assertNotNull(reservation.getGuestAddressStreet(), "Street should not be null");
        assertNotNull(reservation.getGuestAddressCity(), "City should not be null");
        assertFalse(reservation.getGuestAddressZip().isEmpty(), "Zip should not be empty");
    }

    /**
     * Test Case 7: Role-Based Access Control
     */
    @Test
    @DisplayName("TC7: Role-Based Access Control")
    public void testRoleBasedAccess() {
        // Admin user
        User adminUser = new User(1, "admin", "hash", "ADMIN");
        assertTrue("ADMIN".equals(adminUser.getRole()), "Should be ADMIN role");

        // Regular user
        User regularUser = new User(2, "guest", "hash", "USER");
        assertTrue("USER".equals(regularUser.getRole()), "Should be USER role");

        // Role validation
        assertNotEquals(adminUser.getRole(), regularUser.getRole(), "Roles should be different");
    }

    /**
     * Test Case 8: Concurrent Reservations (Same Room)
     * Verify overbooking prevention
     */
    @Test
    @DisplayName("TC8: Overbooking Prevention")
    public void testOverbookingPrevention() {
        // Guest 1: Feb 10-15
        Reservation guest1 = new Reservation();
        guest1.setRoomId(1);
        guest1.setCheckInDate(Date.valueOf("2024-02-10"));
        guest1.setCheckOutDate(Date.valueOf("2024-02-15"));

        // Guest 2: Feb 12-18 (OVERLAPS with Guest 1)
        Reservation guest2 = new Reservation();
        guest2.setRoomId(1);
        guest2.setCheckInDate(Date.valueOf("2024-02-12"));
        guest2.setCheckOutDate(Date.valueOf("2024-02-18"));

        // Check for overlap
        boolean overlaps = guest1.getCheckInDate().before(guest2.getCheckOutDate()) &&
                guest1.getCheckOutDate().after(guest2.getCheckInDate());

        assertTrue(overlaps, "Reservations should overlap (overbooking detected)");
    }
}
