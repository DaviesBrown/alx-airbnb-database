-- join_queries.sql
-- This script demonstrates various types of joins in SQL.

-- INNER JOIN
-- this query retrieves all bookings and the respective users who made those bookings
SELECT 
    b.booking_id,
    u.first_name,
    p.name AS property_name,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price 
FROM `user` AS u 
INNER JOIN booking AS b 
    ON u.user_id = b.user_id
INNER JOIN property AS p
    ON b.property_id = p.property_id;


-- LEFT JOIN
-- this query retrieve all properties and their reviews, including properties that have no reviews.
SELECT 
    p.name,
    r.rating,
    r.comment
FROM property p
LEFT JOIN review r
    ON p.property_id = r.property_id;


-- FULL OUTER JOIN
-- this query retrieves all users and their bookings, including users who have not made any bookings and bookings that do not belong to any user.
(SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date
FROM `user` AS u
LEFT JOIN booking AS b
    ON u.user_id = b.user_id)
UNION
(SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date
FROM `booking` AS b
RIGHT JOIN `user` AS u
    ON u.user_id = b.user_id);