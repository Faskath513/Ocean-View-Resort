package com.oceanview.dao;

import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import com.oceanview.util.DatabaseConnection;
import java.sql.*;
import java.util.Optional;

public class BillDAO {

    public boolean save(Bill bill) {
        String sql = "INSERT INTO bills (reservation_id, room_charge, tax_amount, service_charge, total_amount, payment_status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bill.getReservationId());
            stmt.setBigDecimal(2, bill.getRoomCharge());
            stmt.setBigDecimal(3, bill.getTaxAmount());
            stmt.setBigDecimal(4, bill.getServiceCharge());
            stmt.setBigDecimal(5, bill.getTotalAmount());
            stmt.setString(6, bill.getPaymentStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Optional<Bill> findByReservationId(int reservationId) {
        String sql = "SELECT * FROM bills WHERE reservation_id = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reservationId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Bill bill = new Bill();
                bill.setId(rs.getInt("id"));
                bill.setReservationId(rs.getInt("reservation_id"));
                bill.setRoomCharge(rs.getBigDecimal("room_charge"));
                bill.setTaxAmount(rs.getBigDecimal("tax_amount"));
                bill.setServiceCharge(rs.getBigDecimal("service_charge"));
                bill.setTotalAmount(rs.getBigDecimal("total_amount"));
                bill.setPaymentStatus(rs.getString("payment_status"));
                bill.setGeneratedAt(rs.getTimestamp("generated_at"));
                return Optional.of(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
