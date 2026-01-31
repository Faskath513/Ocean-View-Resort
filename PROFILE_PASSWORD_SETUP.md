# Reset Password & Profile Page Setup

## Overview
Complete reset password and user profile implementation with navbar integration.

## Files Created

### 1. **Profile Page** - `src/main/webapp/jsp/profile.jsp`
- Displays user information (username, ID, role, status)
- Links to reset password page
- Back to dashboard button
- Clean, modern UI with gradient styling
- Session authentication required

### 2. **Reset Password Page** - `src/main/webapp/jsp/reset-password.jsp`
- Current password verification
- New password input with strength indicator
- Password confirmation field
- Real-time password validation with requirements checklist:
  - Minimum 8 characters
  - At least one uppercase letter
  - At least one lowercase letter
  - At least one number
  - At least one special character (!@#$%^&*)
- Visual feedback for password strength (weak/medium/strong)
- Session authentication required

## Files Modified

### 1. **Navbar** - `src/main/webapp/jsp/includes/navbar.jsp`
- Converted user display to dropdown menu with:
  - "My Profile" link
  - "Reset Password" link
  - Logout option with separator

### 2. **User Model** - `src/main/java/com/oceanview/model/User.java`
- Added optional fields for future use:
  - `email`
  - `phone`
  - `fullName`
  - `createdAt`

### 3. **UserDAO** - `src/main/java/com/oceanview/dao/UserDAO.java`
- Added `findById(int id)` method for user lookup
- Added `updatePassword(int userId, String newPasswordHash)` method

### 4. **AuthService** - `src/main/java/com/oceanview/service/AuthService.java`
- Added `resetPassword()` method to verify and update password
- Added `isValidPassword()` method for password strength validation

### 5. **AuthServlet** - `src/main/java/com/oceanview/controller/AuthServlet.java`
- Added `handleResetPassword()` method to process password reset
- Validates current password
- Validates new password meets requirements
- Updates password in database using BCrypt hashing

## Features

✅ **Profile Page:**
- User avatar with initials
- Display user information
- Quick access to password reset
- Responsive design
- Session protection

✅ **Reset Password:**
- Current password verification using BCrypt
- Strong password requirements validation
- Real-time password strength indicator
- Password match validation
- Comprehensive error messages
- Success confirmation

✅ **Navbar Integration:**
- User dropdown menu instead of static text
- Quick access to profile and reset password
- Clean, organized layout

✅ **Security:**
- Session authentication on both pages
- BCrypt password hashing
- Comprehensive input validation
- Strong password requirements
- Current password verification

## Usage

1. **To Access Profile:**
   - Click on username in navbar → "My Profile"
   - URL: `/jsp/profile.jsp`

2. **To Reset Password:**
   - Click on username in navbar → "Reset Password"
   - OR from profile page → "Reset Password" button
   - URL: `/jsp/reset-password.jsp`

## Password Requirements
- Minimum 8 characters
- At least one uppercase letter (A-Z)
- At least one lowercase letter (a-z)
- At least one number (0-9)
- At least one special character (!@#$%^&*)

## Database Updates
If needed, the users table can be extended with:
```sql
ALTER TABLE users ADD COLUMN email VARCHAR(255);
ALTER TABLE users ADD COLUMN phone VARCHAR(20);
ALTER TABLE users ADD COLUMN full_name VARCHAR(255);
ALTER TABLE users ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
```

## Testing
1. Compile the project: `mvn clean compile`
2. Build and deploy to Tomcat
3. Navigate to profile page through navbar
4. Test password reset with valid/invalid inputs
