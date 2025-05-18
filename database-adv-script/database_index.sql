-- database_index.sql
-- Index optimization for AirBnB-like database

-- ========================================================================
-- PART 1: IDENTIFY HIGH-USAGE COLUMNS
-- ========================================================================
-- High-usage columns identified through query analysis:
-- 
-- User Table:
--   - email (for login/authentication)
--   - role (for filtering users by type)
--
-- Property Table:
--   - host_id (for filtering by host)
--   - location (for search by location)
--   - pricepernight (for filtering/sorting by price)
--
-- Booking Table:
--   - property_id (for joining/filtering)
--   - user_id (for joining/filtering)
--   - start_date, end_date (for availability checks)
--   - status (for filtering by booking status)

-- ========================================================================
-- PART 2: MEASURE PERFORMANCE BEFORE INDEXING
-- ========================================================================

-- Query 1: Find properties in a specific location within a price range
EXPLAIN ANALYZE
SELECT * FROM Property 
WHERE location LIKE '%New York%' 
AND pricepernight BETWEEN 100 AND 300
ORDER BY pricepernight;

-- Query 2: Find available properties for a date range
EXPLAIN ANALYZE
SELECT p.* FROM Property p
WHERE p.property_id NOT IN (
    SELECT b.property_id 
    FROM Booking b 
    WHERE b.status != 'canceled'
    AND (
        (b.start_date <= '2024-07-15' AND b.end_date >= '2024-07-10') -- Overlap with requested dates
    )
);

-- Query 3: Find all bookings for a specific user with status
EXPLAIN
SELECT b.*, p.name, p.location 
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
WHERE b.user_id = (SELECT user_id FROM User WHERE email = 'john.doe@example.com')
AND b.status = 'confirmed'
ORDER BY b.start_date;

-- Query 4: Find properties with top ratings
EXPLAIN ANALYZE
SELECT p.*, AVG(r.rating) as avg_rating
FROM Property p
JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id
HAVING avg_rating >= 4
ORDER BY avg_rating DESC;

-- ========================================================================
-- PART 3: CREATE OPTIMIZED INDEXES
-- ========================================================================

-- Indexes for User table
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);

-- Indexes for Property table
-- Note: host_id is already indexed as a foreign key
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(pricepernight);
CREATE INDEX idx_property_location_price ON Property(location, pricepernight);

-- Indexes for Booking table
-- Note: property_id and user_id are already indexed as foreign keys
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_user_status ON Booking(user_id, status);
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, end_date);

-- Index for Review table for rating queries
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- ========================================================================
-- PART 4: MEASURE PERFORMANCE AFTER INDEXING
-- ========================================================================

-- Re-run the same queries with EXPLAIN to see the improvement
EXPLAIN 
SELECT * FROM Property 
WHERE location LIKE '%New York%' 
AND pricepernight BETWEEN 100 AND 300
ORDER BY pricepernight;

EXPLAIN
SELECT p.* FROM Property p
WHERE p.property_id NOT IN (
    SELECT b.property_id 
    FROM Booking b 
    WHERE b.status != 'canceled'
    AND (
        (b.start_date <= '2024-07-15' AND b.end_date >= '2024-07-10') -- Overlap with requested dates
    )
);

EXPLAIN
SELECT b.*, p.name, p.location 
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
WHERE b.user_id = (SELECT user_id FROM User WHERE email = 'john.doe@example.com')
AND b.status = 'confirmed'
ORDER BY b.start_date;

EXPLAIN
SELECT p.*, AVG(r.rating) as avg_rating
FROM Property p
JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id
HAVING avg_rating >= 4
ORDER BY avg_rating DESC;

-- ========================================================================
-- PART 5: INDEX MAINTENANCE RECOMMENDATIONS
-- ========================================================================

-- Stored procedure to analyze and optimize tables periodically
DELIMITER //
CREATE PROCEDURE optimize_airbnb_tables()
BEGIN
    -- Analyze tables to update statistics
    ANALYZE TABLE User, Property, Booking, Payment, Review, Message;
    
    -- Optimize tables to rebuild indexes and reclaim space
    OPTIMIZE TABLE User, Property, Booking, Payment, Review, Message;
END//
DELIMITER ;

-- Create an event to run the optimization monthly during low-traffic hours
CREATE EVENT IF NOT EXISTS monthly_table_optimization
ON SCHEDULE EVERY 1 MONTH
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO CALL optimize_airbnb_tables();
