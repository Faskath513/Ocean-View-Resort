package com.oceanview.factory;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import jakarta.servlet.http.HttpServletRequest;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class OccupancyReport implements Report {
    private ReservationDAO reservationDAO = new ReservationDAO();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    public String generate(HttpServletRequest req) {
        List<Reservation> reservations = reservationDAO.findAll();
        List<Room> rooms = roomDAO.findAll();

        int totalRooms = rooms.size();

        LocalDate today = LocalDate.now();
        Date sqlToday = Date.valueOf(today);

        Set<Integer> occupiedRoomIds = new HashSet<>();
        StringBuilder rows = new StringBuilder();

        for (Reservation r : reservations) {
            if (r.getCheckInDate() == null || r.getCheckOutDate() == null) continue;
            // Check overlap: checkIn <= today < checkOut
            if (!"CANCELLED".equalsIgnoreCase(r.getStatus())
                    && (r.getCheckInDate().compareTo(sqlToday) <= 0)
                    && (r.getCheckOutDate().compareTo(sqlToday) > 0)) {
                occupiedRoomIds.add(r.getRoomId());
                rows.append("<tr>")
                        .append("<td>#").append(r.getRoom() != null ? r.getRoom().getRoomNumber() : r.getRoomId()).append("</td>")
                        .append("<td>").append(r.getGuestName()).append("</td>")
                        .append("<td>").append(r.getCheckInDate()).append("</td>")
                        .append("<td>").append(r.getCheckOutDate()).append("</td>")
                        .append("</tr>");
            }
        }

        int occupied = occupiedRoomIds.size();
        double occupancyRate = totalRooms == 0 ? 0 : (occupied * 100.0) / totalRooms;

        StringBuilder sb = new StringBuilder();
        sb.append("<div class='card p-3'>");
        sb.append("<h4>Occupancy Report</h4>");
        sb.append("<p>Current occupancy as of ").append(sqlToday).append(": <strong>").append(occupied).append(" / ").append(totalRooms).append("</strong> (<strong>")
                .append(String.format("%.1f", occupancyRate)).append("%%</strong>)</p>");

        if (occupied > 0) {
            sb.append("<div class='table-responsive'><table class='table table-striped'><thead><tr><th>Room</th><th>Guest</th><th>Check-in</th><th>Check-out</th></tr></thead><tbody>");
            sb.append(rows.toString());
            sb.append("</tbody></table></div>");
        } else {
            sb.append("<div class='empty-state'><h5>No currently occupied rooms</h5></div>");
        }

        sb.append("</div>");
        return sb.toString();
    }

    @Override
    public String getName() {
        return "Occupancy Report";
    }
}
