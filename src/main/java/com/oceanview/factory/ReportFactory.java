package com.oceanview.factory;

public class ReportFactory {
    public static Report getReport(String type) {
        if ("revenue".equalsIgnoreCase(type)) {
            return new RevenueReport();
        } else if ("guest".equalsIgnoreCase(type)) {
            return new GuestReport();
        } else if ("occupancy".equalsIgnoreCase(type)) {
            return new OccupancyReport();
        } else if ("payments".equalsIgnoreCase(type)) {
            return new PaymentsReport();
        }
        throw new IllegalArgumentException("Unknown report type");
    }
}
