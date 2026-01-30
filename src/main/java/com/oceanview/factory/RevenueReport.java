package com.oceanview.factory;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import jakarta.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.List;

public class RevenueReport implements Report {
    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    public String generate(HttpServletRequest req) {
        List<Reservation> reservations = reservationDAO.findAll();
        BigDecimal totalRevenue = reservations.stream()
                .filter(r -> "CONFIRMED".equals(r.getStatus()) || "CHECKED_IN".equals(r.getStatus())
                        || "CHECKED_OUT".equals(r.getStatus()))
                .map(Reservation::getTotalAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        StringBuilder sb = new StringBuilder();
        sb.append("<div class='card p-3'>");
        sb.append("<h4>Revenue Report</h4>");
        sb.append("<p>Total Revenue generated from confirmed reservations:</p>");
        sb.append("<h2>$").append(totalRevenue).append("</h2>");
        sb.append("</div>");
        return sb.toString();
    }

    @Override
    public String getName() {
        return "Revenue Report";
    }
}
