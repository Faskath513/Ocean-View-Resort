# Requirement Traceability Matrix (RTM)

This matrix maps the functional requirements of the Ocean View Resort system to their corresponding Design Diagrams, Code Components, and Test Verification cases. This ensures that every requirement has been designed, implemented, and tested.

| Req ID | Requirement Description | UML Diagram | Code Component | Test Case |
|:-------|:------------------------|:------------|:---------------|:----------|
| **FR-01** | **User Authentication** | Sequence Diagram (Login) | `AuthService.java`, `AuthServlet.java` | `AuthServiceTest.testAuthenticateSuccess` |
| **FR-02** | **Role-Based Access** | Class Diagram (User) | `User.java`, `dashboard.jsp` (Session Check) | Manual Verification (Admin vs Staff) |
| **FR-03** | **Guest Registration** | Class Diagram (Reservation) | `Reservation.java`, `ReservationDAO.java` | `ReservationDAOTest` |
| **FR-04** | **Room Management** | Class Diagram (Room) | `RoomService.java`, `RoomDAO.java` | `RoomServiceTest` |
| **FR-05** | **Overbooking Prevention** | Activity Diagram (Check Logic) | `ReservationService.createReservation`, `ReservationDAO.checkAvailability` | `ReservationServiceTest.testOverbooking` |
| **FR-06** | **Guest Address Capture** | Class Diagram (Reservation) | `Reservation.java` (fields added), `reservation-form.jsp` | Manual Verification (Form Submit) |
| **FR-07** | **Billing & Taxation** | Class Diagram (Bill) | `BillingService.java`, `ListingServlet.java` | `BillingServiceTest.testTaxCalculation` |
| **FR-08** | **System Exit / Logout** | Sequence Diagram (Logout) | `AuthServlet.handleLogout`, `dashboard.jsp` | Manual Verification |
| **FR-09** | **Distributed Architecture** | Component Diagram | `API_DOCUMENTATION.md` | N/A (Architecture Doc) |

## ✅ Requirement Coverage Summary

-   **Business Logic**: Covered by Service Layer & Unit Tests.
-   **Data Persistence**: Covered by DAO Layer & SQL Schema.
-   **Security**: Covered by Auth Service & Session Management.
-   **User Interface**: Covered by JSPs & Bootstrap.
