# Git Workflow & CI/CD

This project follows professional software engineering practices for version control and continuous integration.

## 🌿 Git Workflow

We utilize a **Feature Branch Workflow** (simulated in this single-agent environment via incremental commits).

### Commit Guidelines
All commits follow the convention:
`[Component] Description of change`

Examples:
-   `[Reservation] Added guest address fields to model and DB`
-   `[Tests] Added unit tests for ReservationService`
-   `[Docs] Created API documentation`

### Development Lifecycle
1.  **Requirement Analysis**: Identify the task.
2.  **Implementation**: Write code and tests (TDD).
3.  **Validation**: Run local tests (`mvn test`).
4.  **Commit**: Save changes to version control.

## 🚀 Continuous Integration (GitHub Actions)

The project is configured to carry out automated testing on every push to the `main` branch and every Pull Request.

### Pipeline Steps (`.github/workflows/ci.yml`)

1.  **Checkout Code**: Pulls the latest code.
2.  **Set up JDK 17**: Configures the Java environment.
3.  **Set up PostgreSQL**: Spins up a service container for database tests (if integration tests are active).
4.  **Build & Test**: Runs `mvn clean test` to execute the JUnit 5 test suite.
5.  **Report**: Displays pass/fail status directly in GitHub.

This ensures that no broken code is ever merged into the production branch.
