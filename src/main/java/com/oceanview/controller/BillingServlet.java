package com.oceanview.controller;

import com.oceanview.model.Bill;
import com.oceanview.service.BillingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/billing")
public class BillingServlet extends HttpServlet {
    private BillingService billingService;

    @Override
    public void init() {
        this.billingService = new BillingService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("generate".equals(action)) {
            int reservationId = Integer.parseInt(req.getParameter("reservationId"));
            Optional<Bill> bill = billingService.generateBill(reservationId);

            if (bill.isPresent()) {
                req.setAttribute("bill", bill.get());
                req.getRequestDispatcher("jsp/bill-view.jsp").forward(req, resp);
            } else {
                resp.sendRedirect("reservations"); // Or error page
            }
        }
    }
}
