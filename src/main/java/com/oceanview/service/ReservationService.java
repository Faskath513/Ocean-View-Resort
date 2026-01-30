package com.oceanview.service;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

public class ReservationService {
    private ReservationDAO reservationDAO;
    private RoomDAO roomDAO;

    public ReservationService() {
        this.reservationDAO = new ReservationDAO();
        this.roomDAO = new RoomDAO();
    }

    public List<Reservation> getAllReservations() {
        return reservationDAO.findAll();
    }

    public boolean createReservation(Reservation res) {
        // 1. Check Availability
        boolean available = reservationDAO.checkAvailability(res.getRoomId(), res.getCheckInDate(),
                res.getCheckOutDate());
        if (!available) {
            return false;
        }

        // 2. Calculate Total Price
        Optional<Room> roomOpt = roomDAO.findById(res.getRoomId());
        if (roomOpt.isPresent()) {
            Room room = roomOpt.get();
            long days = ChronoUnit.DAYS.between(res.getCheckInDate().toLocalDate(),
                    res.getCheckOutDate().toLocalDate());
            if (days < 1)
                days = 1; // Minimum 1 night

            BigDecimal total = room.getPricePerNight().multiply(new BigDecimal(days));
            res.setTotalAmount(total);
            res.setStatus("PENDING");

            return reservationDAO.save(res);
        }
        return false;
    }

    public boolean cancelReservation(int id) {
        return reservationDAO.updateStatus(id, "CANCELLED");
    }

    public boolean confirmReservation(int id) {
        return reservationDAO.updateStatus(id, "CONFIRMED");
    }
}
