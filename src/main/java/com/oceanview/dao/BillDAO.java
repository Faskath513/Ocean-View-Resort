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

    public java.util.List<Bill> findAll() {
        java.util.List<Bill> list = new java.util.ArrayList<>();
        String sql = "SELECT b.*, r.guest_name, rm.room_number FROM bills b LEFT JOIN reservations r ON b.reservation_id = r.id LEFT JOIN rooms rm ON r.room_id = rm.id ORDER BY b.generated_at DESC";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Bill bill = new Bill();
                bill.setId(rs.getInt("id"));
                bill.setReservationId(rs.getInt("reservation_id"));
                bill.setRoomCharge(rs.getBigDecimal("room_charge"));
                bill.setTaxAmount(rs.getBigDecimal("tax_amount"));
                bill.setServiceCharge(rs.getBigDecimal("service_charge"));
                bill.setTotalAmount(rs.getBigDecimal("total_amount"));
                bill.setPaymentStatus(rs.getString("payment_status"));
                bill.setGeneratedAt(rs.getTimestamp("generated_at"));

                // minimal reservation info
                com.oceanview.model.Reservation res = new com.oceanview.model.Reservation();
                res.setId(rs.getInt("reservation_id"));
                res.setGuestName(rs.getString("guest_name"));
                com.oceanview.model.Room room = new com.oceanview.model.Room();
                room.setRoomNumber(rs.getString("room_number"));
                res.setRoom(room);
                bill.setReservation(res);

                list.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
