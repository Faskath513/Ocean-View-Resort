# Ocean View Resort - Room Reservation System

A complete Java Enterprise web application for managing hotel reservations, rooms, billing, and reporting.

## 🏗 Architecture
The system follows a strict **Three-Tier Architecture**:
1.  **Presentation Layer**: JSP, JSTL, Bootstrap 5.
2.  **Application Layer**: Jakarta Servlets, Services (Business Logic).
3.  **Data Layer**: DAO Pattern, JDBC, MySQL.

### Design Patterns Used
-   **Singleton**: `DatabaseConnection` for managing JDBC resources.
-   **DAO**: Data Access Objects for User, Room, Reservation, and Bill.
-   **Factory**: `ReportFactory` for generating different report types.
-   **Strategy**: `PricingStrategy` for flexible tax and service charge calculations.
-   **MVC**: Strict Model-View-Controller separation.

## 🚀 Tech Stack
-   **Backend**: Java 17, Jakarta EE 10 (Servlet API), JDBC.
-   **Frontend**: JSP, JSTL, HTML5, Bootstrap 5, CSS3.
-   **Database**: MySQL 8.
-   **Build Tool**: Maven.
-   **Testing**: JUnit 5, Mockito.

## 🛠 Setup Instructions

### 1. Database Setup (PostgreSQL)
1.  Install PostgreSQL Server.
2.  Create the database:
    ```bash
    createdb ocean_vieew_resort
    ```
3.  Run the `src/main/resources/schema.sql` script to create tables and seed data:
    ```bash
    psql -d ocean_vieew_resort -f src/main/resources/schema.sql
    ```
4.  Update database credentials in `src/main/resources/db.properties` if needed.
    ```properties
    db.url=jdbc:postgresql://localhost:5432/ocean_vieew_resort
    db.user=postgres
    db.password=postgres
    ```

### 2. Build & Run
1.  Clone the repository.
2.  Build the project using Maven:
    ```bash
    mvn clean install
    ```
3.  **Run with Jetty** (Recommended for development):
    ```bash
    mvn jetty:run
    ```
    Access at `http://localhost:8080/oceanview/`

4.  **Or Deploy to Tomcat**:
    -   Deploy the generated `.war` file to **Apache Tomcat 10+**.
    -   Or Copy `target/oceanview.war` to Tomcat's `webapps` folder.
    -   Access the application at: `http://localhost:8080/oceanview/`

## 🔑 Default Credentials
-   **Admin**: `admin` / `password123`
-   **Staff**: `staff` / `password123`

## 📂 Project Structure
```
src/main/java/com/oceanview/
├── controller/  # Servlets
├── service/     # Business Logic
├── dao/         # Data Access
├── model/       # Entities
├── util/        # Helpers (DB, Auth)
├── factory/     # Report Factory
└── strategy/    # Pricing Strategies
```

## ✅ Features
-   User Authentication (BCrypt).
-   Role-based access (Admin/Staff).
-   Room Management (CRUD).
-   Reservation System with Date Validation.
-   Automated Billing (Tax & Service Charge).
-   Reporting (Revenue, Guest List).
