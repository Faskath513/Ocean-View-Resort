# Test-Driven Development (TDD) Approach

The Ocean View Resort project adopts a **Test-Driven Development (TDD)** methodology to ensure code reliability, maintainability, and alignment with business requirements. This document outlines our TDD workflow and test coverage.

## 🔄 The TDD Cycle: Red-Green-Refactor

We follow the standard TDD cycle for implementing new features and logic:

1.  **Red (Write a Failing Test)**:
    -   We define the expected behavior in a test case before writing any functional code.
    -   Example: Writing a test for `createReservation` that expects failure when dates overlap.

2.  **Green (Make it Pass)**:
    -   We write the minimum amount of code necessary to make the test pass.
    -   Example: Implementing the `checkAvailability` logic in the service.

3.  **Refactor (Improve the Code)**:
    -   We optimize the code structure without changing its behavior, ensuring it passes all tests.
    -   Example: Extracting date validation logic into a helper method.

## 🧪 Test Coverage

We utilize **JUnit 5** for test structure and assertions, and **Mockito** for isolating dependencies (like DAOs).

### 1. Service Layer Tests
Core business logic is heavily tested.

-   **ReservationServiceTest**:
    -   `createReservation`: Verifies availability checks, price calculation, and persistence.
    -   **Overbooking Prevention**: Specifically tests overlapping date scenarios.
    -   `cancelReservation`: Verifies status updates.

-   **RoomServiceTest**:
    -   Room creation and validation checks.
    -   Duplicate room number prevention.

-   **AuthServiceTest**:
    -   Password hashing verification.
    -   Login authentication success/failure flows.

-   **BillingServiceTest**:
    -   Tax calculation (15%).
    -   Service charge calculation (10%).

### 2. DAO Layer Tests
-   **ReservationDAOTest**:
    -   Uses an in-memory database or mocked connection to verify SQL logic.
    -   Tests specific SQL queries for date overlaps.

## 🚀 Running Tests

### Execute All Tests
Run the following command to execute the full test suite via Maven:

```bash
mvn test
```

### View Test Reports
After execution, test reports are generated in:
`target/surefire-reports/`
