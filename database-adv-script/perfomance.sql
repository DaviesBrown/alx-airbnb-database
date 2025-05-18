-- Initial query retrieving all bookings with user details, property details, and payment details
SELECT 
    b.*,
    u.user_id, u.first_name, u.last_name, u.email, u.phone_number, u.profile_picture,
    p.property_id, p.title, p.description, p.location, p.price_per_night, p.property_type, p.max_guests, p.bedrooms, p.bathrooms,
    py.payment_id, py.amount, py.payment_date, py.payment_status
FROM 
    booking b
LEFT JOIN 
    user u ON u.user_id = b.user_id
LEFT JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment py ON b.booking_id = py.booking_id;

-- Check query performance
EXPLAIN ANALYZE SELECT 
    b.*,
    u.user_id, u.first_name, u.last_name, u.email, u.phone_number, u.profile_picture,
    p.property_id, p.title, p.description, p.location, p.price_per_night, p.property_type, p.max_guests, p.bedrooms, p.bathrooms,
    py.payment_id, py.amount, py.payment_date, py.payment_status
FROM 
    booking b
LEFT JOIN 
    user u ON u.user_id = b.user_id
LEFT JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment py ON b.booking_id = py.booking_id;

-- Create indexes to optimize the query
CREATE INDEX IF NOT EXISTS idx_booking_user ON booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property ON booking(property_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking ON payment(booking_id);

-- Refactored query - Selecting only necessary columns
EXPLAIN ANALYZE SELECT 
    b.booking_id, b.check_in_date, b.check_out_date, b.status,
    u.first_name, u.last_name, u.email,
    p.title, p.location, p.price_per_night,
    py.amount, py.payment_status
FROM 
    booking b
LEFT JOIN 
    user u ON u.user_id = b.user_id
LEFT JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment py ON b.booking_id = py.booking_id;

-- Alternative approach - Using subqueries for lazy loading when only specific data is needed
EXPLAIN ANALYZE SELECT 
    b.booking_id, b.check_in_date, b.check_out_date, b.status,
    (SELECT CONCAT(first_name, ' ', last_name) FROM user WHERE user_id = b.user_id) AS customer_name,
    (SELECT title FROM property WHERE property_id = b.property_id) AS property_name,
    (SELECT SUM(amount) FROM payment WHERE booking_id = b.booking_id) AS total_payment
FROM 
    booking b
WHERE 
    b.status = 'confirmed';  -- Adding a filter condition to further improve performance
