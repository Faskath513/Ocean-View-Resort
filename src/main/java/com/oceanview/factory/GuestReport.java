package com.oceanview.factory;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

public class GuestReport implements Report {
    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    public String generate(HttpServletRequest req) {
        List<Reservation> reservations = reservationDAO.findAll();
        long totalGuests = reservations.stream().count(); // Simplified for now

        StringBuilder sb = new StringBuilder();
        sb.append("<div class='card p-3'>");
        sb.append("<h4>Guest Report</h4>");
        sb.append("<table class='table table-striped'>");
        sb.append("<thead><tr><th>Guest Name</th><th>Email</th><th>Phone</th></tr></thead><tbody>");

        for (Reservation r : reservations) {
            sb.append("<tr>");
            sb.append("<td>").append(r.getGuestName()).append("</td>");
            sb.append("<td>").append(r.getGuestEmail()).append("</td>");
            sb.append("<td>").append(r.getGuestPhone()).append("</td>");
            sb.append("</tr>");
        }
        sb.append("</tbody></table>");
        sb.append("</div>");
        return sb.toString();
    }

    @Override
    public String getName() {
        return "Guest Report";
    }
}
