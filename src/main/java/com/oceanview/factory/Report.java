package com.oceanview.factory;

import jakarta.servlet.http.HttpServletRequest;

public interface Report {
    String generate(HttpServletRequest req); // Returns HTML content or data

    String getName();
}
