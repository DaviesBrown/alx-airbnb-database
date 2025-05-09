-- Users data (including hosts, guests, and admin)
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('a1b2c3d4-e5f6-4321-8765-123456789abc', 'John', 'Doe', 'john.doe@email.com', 'hashed_password_1', '+1234567890', 'host'),
('b2c3d4e5-f6a1-8765-4321-234567890abc', 'Jane', 'Smith', 'jane.smith@email.com', 'hashed_password_2', '+2345678901', 'guest'),
('c3d4e5f6-a1b2-1234-5678-345678901abc', 'Admin', 'User', 'admin@airbnb.com', 'hashed_password_3', '+3456789012', 'admin'),
('d4e5f6a1-b2c3-8765-1234-456789012abc', 'Mary', 'Johnson', 'mary.j@email.com', 'hashed_password_4', '+4567890123', 'guest');

-- Properties data
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night) VALUES
('e5f6a1b2-c3d4-5678-4321-567890123abc', 'a1b2c3d4-e5f6-4321-8765-123456789abc', 'Luxury Beach Villa', 'Beautiful beachfront villa with ocean view', 'Miami Beach, FL', 299.99),
('f6a1b2c3-d4e5-4321-8765-678901234abc', 'a1b2c3d4-e5f6-4321-8765-123456789abc', 'Mountain Cabin', 'Cozy cabin in the mountains', 'Aspen, CO', 199.99);

-- Bookings data
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('a1b2c3d4-e5f6-1234-5678-789012345abc', 'e5f6a1b2-c3d4-5678-4321-567890123abc', 'b2c3d4e5-f6a1-8765-4321-234567890abc', '2024-03-15', '2024-03-20', 1499.95, 'confirmed'),
('b2c3d4e5-f6a1-5678-1234-890123456abc', 'f6a1b2c3-d4e5-4321-8765-678901234abc', 'd4e5f6a1-b2c3-8765-1234-456789012abc', '2024-04-01', '2024-04-05', 799.96, 'pending');

-- Payments data
INSERT INTO payments (payment_id, booking_id, amount, payment_method) VALUES
('c3d4e5f6-a1b2-8765-4321-901234567abc', 'a1b2c3d4-e5f6-1234-5678-789012345abc', 1499.95, 'credit_card');

-- Reviews data
INSERT INTO reviews (review_id, property_id, user_id, rating, comment) VALUES
('d4e5f6a1-b2c3-4321-8765-012345678abc', 'e5f6a1b2-c3d4-5678-4321-567890123abc', 'b2c3d4e5-f6a1-8765-4321-234567890abc', 5, 'Amazing beachfront property! Will definitely come back.'),
('e5f6a1b2-c3d4-8765-4321-123456789abc', 'f6a1b2c3-d4e5-4321-8765-678901234abc', 'd4e5f6a1-b2c3-8765-1234-456789012abc', 4, 'Great mountain views and cozy atmosphere.');

-- Messages data
INSERT INTO messages (message_id, sender_id, recipient_id, message_body) VALUES
('f6a1b2c3-d4e5-1234-8765-234567890abc', 'b2c3d4e5-f6a1-8765-4321-234567890abc', 'a1b2c3d4-e5f6-4321-8765-123456789abc', 'Hi, is the beach villa available next month?'),
('a1b2c3d4-e5f6-5678-1234-345678901abc', 'a1b2c3d4-e5f6-4321-8765-123456789abc', 'b2c3d4e5-f6a1-8765-4321-234567890abc', 'Yes, it is available. When would you like to book?');
