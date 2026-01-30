package com.oceanview.service;

import com.oceanview.dao.BillDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import com.oceanview.strategy.StandardPricingStrategy;
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

public class BillingServiceTest {

    private BillingService billingService;

    @Mock
    private BillDAO billDAO;

    @Mock
    private ReservationDAO reservationDAO;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        billingService = new BillingService(billDAO, reservationDAO);
    }

    @Test
    public void testGenerateBill() {
        int reservationId = 1;
        BigDecimal roomCharge = new BigDecimal("100.00");

        Reservation mockRes = new Reservation();
        mockRes.setId(reservationId);
        mockRes.setTotalAmount(roomCharge);

        when(reservationDAO.findById(reservationId)).thenReturn(Optional.of(mockRes));
        when(billDAO.findByReservationId(reservationId)).thenReturn(Optional.empty());
        when(billDAO.save(any(Bill.class))).thenReturn(true);

        Optional<Bill> result = billingService.generateBill(reservationId);

        assertTrue(result.isPresent());
        Bill bill = result.get();
        assertEquals(new BigDecimal("100.00"), bill.getRoomCharge());
        assertEquals(new BigDecimal("15.0000"), bill.getTaxAmount()); // 15%
        assertEquals(new BigDecimal("10.0000"), bill.getServiceCharge()); // 10%
        // Total = 100 + 15 + 10 = 125
        assertEquals(new BigDecimal("125.0000"), bill.getTotalAmount());
    }
}
