-- Users Table (Admin & Staff)
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL, -- 'ADMIN', 'STAFF'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Rooms Table
CREATE TABLE IF NOT EXISTS rooms (
    id SERIAL PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    type VARCHAR(50) NOT NULL, -- 'SINGLE', 'DOUBLE', 'SUITE'
    price_per_night DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'AVAILABLE', -- 'AVAILABLE', 'OCCUPIED', 'MAINTENANCE'
    description TEXT
);

-- Reservations Table
CREATE TABLE IF NOT EXISTS reservations (
    id SERIAL PRIMARY KEY,
    guest_name VARCHAR(100) NOT NULL,
    guest_email VARCHAR(100),
    guest_phone VARCHAR(20),
    guest_address_street VARCHAR(255),
    guest_address_city VARCHAR(100),
    guest_address_state VARCHAR(50),
    guest_address_zip VARCHAR(20),
    guest_address_country VARCHAR(50),
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20) DEFAULT 'PENDING', -- 'PENDING', 'CONFIRMED', 'CHECKED_IN', 'CHECKED_OUT', 'CANCELLED'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

-- Bills Table
CREATE TABLE IF NOT EXISTS bills (
    id SERIAL PRIMARY KEY,
    reservation_id INT NOT NULL,
    room_charge DECIMAL(10, 2) NOT NULL,
    tax_amount DECIMAL(10, 2) NOT NULL,
    service_charge DECIMAL(10, 2) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'UNPAID', -- 'PAID', 'UNPAID'
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reservation_id) REFERENCES reservations(id)
);

-- Sample Data
-- Password is 'password123' hashed with BCrypt
INSERT INTO users (username, password_hash, role) VALUES 
('admin', '$2a$10$6X8PkqjNtbQbfL8hjyNU8OA5Or/g.SvQp3q3KASklwS2wcSnafgMG', 'ADMIN'), 
('staff', '$2a$10$6X8PkqjNtbQbfL8hjyNU8OA5Or/g.SvQp3q3KASklwS2wcSnafgMG', 'STAFF')
ON CONFLICT (username) DO NOTHING;

INSERT INTO rooms (room_number, type, price_per_night, status) VALUES 
('101', 'SINGLE', 100.00, 'AVAILABLE'),
('102', 'SINGLE', 100.00, 'AVAILABLE'),
('201', 'DOUBLE', 150.00, 'AVAILABLE'),
('301', 'SUITE', 300.00, 'AVAILABLE')
ON CONFLICT (room_number) DO NOTHING;
