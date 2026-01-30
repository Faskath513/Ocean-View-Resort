# Ocean View Resort - Architecture & API Documentation

## 🏗 Distributed Architecture Overview

The Ocean View Resort system is designed as a **Distributed Application** using a strict **Three-Tier Architecture**. This design ensures scalability, specific separation of concerns, and maintainability.

### 1. Presentation Layer (Client)
- **Technology**: JSP (JavaServer Pages), JSTL, HTML5, Bootstrap 5.
- **Function**: Renders the user interface and handles user interactions.
- **Communication**: Sends HTTP requests (GET/POST) to the Application Layer via Servlets.

### 2. Application Layer (Business Logic & Web Services)
- **Technology**: Jakarta Servlets (acting as REST-style endpoints), Service Classes.
- **Function**:
    - **Servlets**: Act as controllers, receiving HTTP requests, extracting properties, and invoking business logic.
    - **Services**: Contain the core business rules (e.g., pricing calculations, reservation validation).
    - **REST-Style Endpoints**: The servlets expose resources via specific URLs.

### 3. Data Compatibility Layer (Persistence)
- **Technology**: JDBC, PostgreSQL, DAO Pattern.
- **Function**: Manages all database interactions.
- **Isolation**: The application layer does not know SQL; it interacts purely with DAOs.

---

## 🔌 API Endpoints (Web Services)

The system exposes business functionality through the following REST-style servlet endpoints.

### Authentication Service
**Base URL**: `/auth`

| Method | Action Param | Description | Request Body/Params |
|:-------|:-------------|:------------|:--------------------|
| POST   | `login`      | Authenticates a user | `username`, `password` |
| POST   | `logout`     | Invalidates session | None |
| GET    | `logout`     | Invalidates session | None |

### Reservation Service
**Base URL**: `/reservations`

| Method | Action Param | Description | Request Body/Params |
|:-------|:-------------|:------------|:--------------------|
| GET    | `list` (default) | Retrieves all reservations | None |
| GET    | `new`        | Returns form data for new reservation | None |
| POST   | `new`        | Creates a new reservation | `guestName`, `guestEmail`, `guestPhone`, `guestAddressStreet`, `guestAddressCity`, `guestAddressState`, `guestAddressZip`, `guestAddressCountry`, `roomId`, `checkIn`, `checkOut` |
| GET    | `cancel`     | Cancels a reservation | `id` |
| GET    | `confirm`    | Confirms a reservation | `id` |

### Room Service
**Base URL**: `/rooms`

| Method | Action Param | Description | Request Body/Params |
|:-------|:-------------|:------------|:--------------------|
| GET    | `list` (default) | Retrieves all rooms | None |
| POST   | `create`     | Creates a new room | `roomNumber`, `type`, `price` |
| POST   | `update`     | Updates an existing room | `id`, `price`, `status` |
| GET    | `delete`     | Removes a room (logical delete) | `id` |

### Reporting Service
**Base URL**: `/reports`

| Method | Action Param | Description | Request Body/Params |
|:-------|:-------------|:------------|:--------------------|
| GET    | `view`       | Generates specified report | `type` (revenue/occupancy) |

---

## 🔄 Client-Server Communication

1.  **Request**: The Client (Browser) sends an HTTP Request to a Servlet URL.
2.  **Processing**: The Servlet intercepts the request and calls the appropriate Service method.
3.  **Response**:
    -   **Success**: The Servlet forwards to a JSP for rendering or redirects to a listing page.
    -   **Error**: The Servlet forwards to the form with error messages attached to the request attributes.

This architecture allows the backend to be decoupled from the frontend, enabling future integration with mobile apps or other clients via JSON-based REST APIs if needed.
