# Overbooking Prevention Logic

The Ocean View Resort system enforces strict **Overbooking Prevention** to ensure that no two reservations can be confirmed for the same room on overlapping dates. This logic is implemented at the **Database Layer** and enforced by the **Service Layer** before any reservation is created.

## 🛑 The Core Logic

The core algorithm checks if any existing reservation for a specific room overlaps with the requested check-in and check-out dates.

**Conflict Condition:**
A room is considered **unavailable** if there exists a reservation where:

1.  The reservation is NOT cancelled.
2.  AND the date ranges overlap.

The overlap logic is defined as:
`RequestedStart < ExistingEnd` AND `RequestedEnd > ExistingStart`

This formula covers all overlap scenarios:
-   **Enclosing**: Existing reservation completely covers requested dates.
-   **Inside**: Requested dates are completely inside an existing reservation.
-   **Partial Start**: Requested start date falls inside existing reservation.
-   **Partial End**: Requested end date falls inside existing reservation.

## 🔍 Implementation Details

### 1. SQL Query (`ReservationDAO.java`)

The logic is executed directly in the database for efficiency and consistency.

```sql
SELECT COUNT(*) FROM reservations 
WHERE room_id = ? 
AND status != 'CANCELLED' 
AND NOT (check_out_date <= ? OR check_in_date >= ?)
```

-   `check_out_date <= ?` (Existing ends before New starts) -> **No Conflict**
-   `check_in_date >= ?` (Existing starts after New ends) -> **No Conflict**
-   **NOT (...)** -> means there **IS** a conflict (Overlap).

### 2. Service Layer Check (`ReservationService.java`)

Before saving any new reservation, the service calls the DAO:

```java
public boolean createReservation(Reservation res) {
    // 1. Check Availability
    boolean available = reservationDAO.checkAvailability(res.getRoomId(), res.getCheckInDate(), res.getCheckOutDate());
    if (!available) {
        return false; // Rejects reservation immediately
    }
    // ... proceed to save
}
```

## 🧪 Testing

This logic is verified by `ReservationDAOTest` and `ReservationServiceTest`.

-   **Test Case 1**: Room is free -> Reservation Allowed.
-   **Test Case 2**: Dates overlap exactly -> Reservation Denied.
-   **Test Case 3**: Dates partially overlap -> Reservation Denied.
