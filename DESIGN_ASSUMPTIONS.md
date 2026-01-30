# Design Assumptions & Business Rules

This document outlines the critical assumptions and business rules that govern the design and implementation of the Ocean View Resort system. These decisions align with the assessment requirements and standard hospitality management practices.

## 1. User Roles & Permissions

| Role | Permissions |
|:-----|:------------|
| **ADMIN** | Full access to all system features (Rooms, Users, Reports, Reservations). Can create/delete rooms and users. |
| **STAFF** | Operational access. Can view and manage Reservations and Billing. Cannot delete Rooms or manage Users. |

**Assumption**: Authentication is session-based and roles are static (defined in database).

## 2. Billing & Financial Rules

-   **Base Logic**: `Total = Room Price * Nights`
-   **Tax Rate**: Fixed at **15%** of the base room charge.
-   **Service Charge**: Fixed at **10%** of the base room charge.
-   **Currency**: All amounts are processed in **USD ($)**.
-   **Payment**: Payment logic is simulated. In a real system, this would integrate with a Payment Gateway (Stripe/PayPal).

## 3. Reservation Policies

-   **Minimum Stay**: 1 Night.
-   **Check-In/Out**:
    -   Standard Check-in Time: 14:00 (Logic assumed, not enforced in code).
    -   Standard Check-out Time: 11:00 (Logic assumed).
-   **Availability**: A room is "Occupied" for the entire duration from `check_in_date` to `check_out_date`.
-   **Cancellation**:
    -   Reservations can be cancelled at any time before check-in.
    -   Cancelled reservations release the room availability immediately.

## 4. Security Assumptions

-   **Passwords**: All user passwords are hashed using **BCrypt** before storage. Plain text passwords are never stored.
-   **Session**: User sessions expire automatically after 30 minutes of inactivity (Container default).
-   **Access Control**: URL-based protection is implemented via Session checks in JSPs and Servlets.

## 5. Data Validation

-   **Address**: All address fields (Street, City, Zip, Country) are mandatory for new guests to ensure legal compliance.
-   **Email**: Basic format validation is expected on the client side.
-   **Dates**: `Check-Out` date must be strictly greater than `Check-In` date.
