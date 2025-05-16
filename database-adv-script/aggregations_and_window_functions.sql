-- query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause
SELECT 
    u.user_id, 
    u.email, 
    COUNT(b.booking_id) AS booking_count
FROM user u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.email;


-- window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT
    b.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS booking_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_num,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_value
FROM property p
LEFT JOIN booking b
ON p.property_id = b.property_id
GROUP BY property_id, property_name;
