# UML Design Diagrams

## 1. Class Diagram
Visualizes the static structure of the system's core models and services.

```mermaid
classDiagram
    class User {
        +int id
        +String username
        +String role
        +String passwordHash
    }

    class Room {
        +int id
        +String roomNumber
        +String type
        +BigDecimal price
    }

    class Reservation {
        +int id
        +String guestName
        +String guestAddress
        +Date checkIn
        +Date checkOut
        +BigDecimal total
    }

    class ReservationService {
        +checkAvailability()
        +createReservation()
        +cancelReservation()
    }

    ReservationService --> Reservation : manages
    Reservation --> Room : books
```

## 2. Sequence Diagram: Reservation Creation with Overbooking Check
Visualizes the flow of creating a reservation and checking availability.

```mermaid
sequenceDiagram
    actor Guest
    participant Controller as ReservationServlet
    participant Service as ReservationService
    participant DAO as ReservationDAO
    participant DB as Database

    Guest->>Controller: Submit Form (Dates, Room)
    Controller->>Service: createReservation(res)
    Service->>DAO: checkAvailability(room, dates)
    DAO->>DB: SELECT COUNT... overlap
    DB-->>DAO: result (0 or >0)
    DAO-->>Service: boolean available

    alt is available
        Service->>DAO: save(res)
        DAO->>DB: INSERT reservation
        DB-->>DAO: success
        Service-->>Controller: success
        Controller-->>Guest: Redirect to Dashboard
    else is occupied
        Service-->>Controller: failure
        Controller-->>Guest: Show Error Message
    end
```

## 3. Activity Diagram: Overbooking Prevention Logic
Visualizes the decision logic for validating a reservation.

```mermaid
stateDiagram-v2
    [*] --> RecieveRequest
    RecieveRequest --> CheckOverlap
    
    state "Check Date Overlap" as CheckOverlap {
        [*] --> CompareDates
        CompareDates --> OverlapFound : EndA > StartB AND StartA < EndB
        CompareDates --> NoOverlap : Else
    }

    OverlapFound --> RejectReservation
    NoOverlap --> CalculatePrice
    CalculatePrice --> SaveToDB
    SaveToDB --> [*]
    RejectReservation --> [*]
```
