package com.oceanview.controller;

import com.oceanview.factory.Report;
import com.oceanview.factory.ReportFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        if (type != null) {
            try {
                Report report = ReportFactory.getReport(type);
                String content = report.generate(req);
                req.setAttribute("reportContent", content);
                req.setAttribute("reportName", report.getName());
            } catch (IllegalArgumentException e) {
                req.setAttribute("error", "Invalid Report Type");
            }
        }
        req.getRequestDispatcher("jsp/reports.jsp").forward(req, resp);
    }
}
