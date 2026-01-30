package com.oceanview.strategy;

import java.math.BigDecimal;

public interface PricingStrategy {
    BigDecimal calculateTax(BigDecimal roomCharge);

    BigDecimal calculateServiceCharge(BigDecimal roomCharge);
}
