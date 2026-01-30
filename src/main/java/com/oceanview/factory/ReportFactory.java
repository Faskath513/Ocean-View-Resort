package com.oceanview.factory;

public class ReportFactory {
    public static Report getReport(String type) {
        if ("revenue".equalsIgnoreCase(type)) {
            return new RevenueReport();
        } else if ("guest".equalsIgnoreCase(type)) {
            return new GuestReport();
        }
        throw new IllegalArgumentException("Unknown report type");
    }
}
