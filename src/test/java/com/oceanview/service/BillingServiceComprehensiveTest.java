package com.oceanview.service;

import com.oceanview.dao.BillDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.math.BigDecimal;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.when;

public class BillingServiceComprehensiveTest {

    @Mock
    private BillDAO billDAO;

    @Mock
    private ReservationDAO reservationDAO;

    private BillingService billingService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        billingService = new BillingService(billDAO, reservationDAO);
    }

    @Test
    public void testGenerateBill_Success() {
        Reservation res = new Reservation();
        res.setId(1);
        res.setTotalAmount(new BigDecimal("500.00"));

        when(billDAO.findByReservationId(1)).thenReturn(Optional.empty());
        when(reservationDAO.findById(1)).thenReturn(Optional.of(res));
        when(billDAO.save(any(Bill.class))).thenReturn(true);

        Optional<Bill> result = billingService.generateBill(1);
        assertTrue(result.isPresent(), "Bill should be generated");
    }

    @Test
    public void testGenerateBill_ExistingBill() {
        Bill existingBill = new Bill();
        existingBill.setId(1);
        existingBill.setTotalAmount(new BigDecimal("625.00"));

        when(billDAO.findByReservationId(1)).thenReturn(Optional.of(existingBill));

        Optional<Bill> result = billingService.generateBill(1);
        assertTrue(result.isPresent(), "Should return existing bill");
        assertTrue(new BigDecimal("625.00").compareTo(result.get().getTotalAmount()) == 0);
    }

    @Test
    public void testTaxCalculation() {
        BigDecimal roomCharge = new BigDecimal("500.00");
        BigDecimal expectedTax = roomCharge.multiply(new BigDecimal("0.15"));
        assertTrue(new BigDecimal("75.00").compareTo(expectedTax) == 0, "Tax should be 15% of room charge");
    }

    @Test
    public void testServiceChargeCalculation() {
        BigDecimal roomCharge = new BigDecimal("500.00");
        BigDecimal expectedServiceCharge = roomCharge.multiply(new BigDecimal("0.10"));
        assertTrue(new BigDecimal("50.00").compareTo(expectedServiceCharge) == 0, "Service charge should be 10%");
    }

    @Test
    public void testTotalAmountCalculation() {
        BigDecimal roomCharge = new BigDecimal("500.00");
        BigDecimal tax = new BigDecimal("75.00");
        BigDecimal serviceCharge = new BigDecimal("50.00");
        BigDecimal expectedTotal = roomCharge.add(tax).add(serviceCharge);
        assertTrue(new BigDecimal("625.00").compareTo(expectedTotal) == 0, "Total calculation should be correct");
    }
}
