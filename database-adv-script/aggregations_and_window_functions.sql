-- query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause
SELECT 
    u.user_id, 
    u.email, 
    COUNT(b.booking_id) AS booking_count
FROM user u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.email;