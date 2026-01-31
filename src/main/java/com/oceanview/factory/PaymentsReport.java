package com.oceanview.factory;

import com.oceanview.dao.BillDAO;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import jakarta.servlet.http.HttpServletRequest;

import java.util.List;

public class PaymentsReport implements Report {
    private BillDAO billDAO = new BillDAO();

    @Override
    public String generate(HttpServletRequest req) {
        List<Bill> bills = billDAO.findAll();

        StringBuilder sb = new StringBuilder();
        sb.append("<div class='card p-3'>");
        sb.append("<h4>Payments Report</h4>");

        if (bills.isEmpty()) {
            sb.append("<div class='empty-state'><h5>No payments found</h5></div>");
            sb.append("</div>");
            return sb.toString();
        }

        sb.append("<div class='table-responsive'><table class='table table-striped'><thead><tr><th>Reservation</th><th>Guest</th><th>Room</th><th>Amount</th><th>Status</th><th>Date</th></tr></thead><tbody>");

        for (Bill b : bills) {
            Reservation r = b.getReservation();
            String guest = r != null ? r.getGuestName() : "-";
            String room = (r != null && r.getRoom() != null) ? r.getRoom().getRoomNumber() : "-";
            sb.append("<tr>")
                    .append("<td>#").append(b.getReservationId()).append("</td>")
                    .append("<td>").append(guest).append("</td>")
                    .append("<td>").append(room).append("</td>")
                    .append("<td>$").append(b.getTotalAmount()).append("</td>")
                    .append("<td>").append(b.getPaymentStatus()).append("</td>")
                    .append("<td>").append(b.getGeneratedAt()).append("</td>")
                    .append("</tr>");
        }

        sb.append("</tbody></table></div>");
        sb.append("</div>");
        return sb.toString();
    }

    @Override
    public String getName() {
        return "Payments Report";
    }
}
