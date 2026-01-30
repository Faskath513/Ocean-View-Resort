package com.oceanview.strategy;

import java.math.BigDecimal;

public class StandardPricingStrategy implements PricingStrategy {
    private static final BigDecimal TAX_RATE = new BigDecimal("0.15");
    private static final BigDecimal SERVICE_RATE = new BigDecimal("0.10");

    @Override
    public BigDecimal calculateTax(BigDecimal roomCharge) {
        return roomCharge.multiply(TAX_RATE);
    }

    @Override
    public BigDecimal calculateServiceCharge(BigDecimal roomCharge) {
        return roomCharge.multiply(SERVICE_RATE);
    }
}
