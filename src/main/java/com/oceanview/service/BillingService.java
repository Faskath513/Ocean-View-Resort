package com.oceanview.service;

import com.oceanview.dao.BillDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import com.oceanview.strategy.PricingStrategy;
import com.oceanview.strategy.StandardPricingStrategy;
import java.math.BigDecimal;
import java.util.Optional;

public class BillingService {
    private BillDAO billDAO;
    private ReservationDAO reservationDAO;
    private PricingStrategy pricingStrategy;

    public BillingService() {
        this.billDAO = new BillDAO();
        this.reservationDAO = new ReservationDAO();
        this.pricingStrategy = new StandardPricingStrategy(); // Default strategy
    }

    public void setPricingStrategy(PricingStrategy strategy) {
        this.pricingStrategy = strategy;
    }

    public Optional<Bill> generateBill(int reservationId) {
        // Check if bill already exists
        Optional<Bill> existing = billDAO.findByReservationId(reservationId);
        if (existing.isPresent())
            return existing;

        // Get Reservation
        Optional<Reservation> resOpt = reservationDAO.findAll().stream()
                .filter(r -> r.getId() == reservationId).findFirst(); // Inefficient, should add findById to DAO

        if (resOpt.isPresent()) {
            Reservation res = resOpt.get();
            Bill bill = new Bill();
            bill.setReservationId(reservationId);

            BigDecimal roomCharge = res.getTotalAmount();
            BigDecimal tax = pricingStrategy.calculateTax(roomCharge);
            BigDecimal service = pricingStrategy.calculateServiceCharge(roomCharge);
            BigDecimal total = roomCharge.add(tax).add(service);

            bill.setRoomCharge(roomCharge);
            bill.setTaxAmount(tax);
            bill.setServiceCharge(service);
            bill.setTotalAmount(total);
            bill.setPaymentStatus("UNPAID");

            if (billDAO.save(bill)) {
                return Optional.of(bill); // Re-fetch to get ID/Timestamp ideally, but simplified here
            }
        }
        return Optional.empty();
    }

    public Optional<Bill> getBill(int reservationId) {
        return billDAO.findByReservationId(reservationId);
    }
}
