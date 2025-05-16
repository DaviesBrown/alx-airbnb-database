-- First, let's create a backup of the original booking table before partitioning
CREATE TABLE booking_backup AS SELECT * FROM booking;

-- We need to ensure the table has the appropriate structure for partitioning
-- Add the partition key to the primary key if it's not already there
ALTER TABLE booking
MODIFY COLUMN booking_id INT NOT NULL,
MODIFY COLUMN start_date DATE NOT NULL,
DROP PRIMARY KEY,
ADD PRIMARY KEY (booking_id, start_date);

-- Now we can partition the table by RANGE based on start_date
ALTER TABLE booking
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION future VALUES LESS THAN MAXVALUE
);

-- Let's create an index on the partitioned table to further improve performance
CREATE INDEX idx_booking_date_range ON booking(start_date, end_date);

-- Test query 1: Find all bookings for 2023
-- This will only scan the p2023 partition
EXPLAIN SELECT * 
FROM booking 
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Test query 2: Find bookings across multiple years
-- This will scan only the relevant partitions
EXPLAIN SELECT * 
FROM booking 
WHERE start_date BETWEEN '2023-06-01' AND '2024-06-01';

-- Test query 3: Find bookings for a specific property in a date range
-- This combines partitioning benefits with other filters
EXPLAIN SELECT 
    b.booking_id, b.user_id, b.start_date, b.end_date, 
    p.title, p.location
FROM 
    booking b
JOIN 
    property p ON b.property_id = p.property_id
WHERE 
    b.start_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND p.location = 'New York';

-- Alternative partitioning approach using RANGE COLUMNS
-- If we wanted to partition by month instead of year:
-- First restore from backup if needed
-- CREATE TABLE booking AS SELECT * FROM booking_backup;

/*
ALTER TABLE booking
PARTITION BY RANGE COLUMNS(start_date) (
    PARTITION p_2023_Q1 VALUES LESS THAN ('2023-04-01'),
    PARTITION p_2023_Q2 VALUES LESS THAN ('2023-07-01'),
    PARTITION p_2023_Q3 VALUES LESS THAN ('2023-10-01'),
    PARTITION p_2023_Q4 VALUES LESS THAN ('2024-01-01'),
    PARTITION p_2024_Q1 VALUES LESS THAN ('2024-04-01'),
    PARTITION p_2024_Q2 VALUES LESS THAN ('2024-07-01'),
    PARTITION p_2024_Q3 VALUES LESS THAN ('2024-10-01'),
    PARTITION p_2024_Q4 VALUES LESS THAN ('2025-01-01'),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);
*/

-- If we need to check partition usage:
EXPLAIN PARTITIONS
SELECT * FROM booking 
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Cleanup commands (commented out - use only if needed)
-- DROP TABLE booking;
-- RENAME TABLE booking_backup TO booking;
