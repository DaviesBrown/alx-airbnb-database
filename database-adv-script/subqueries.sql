-- Query 1: Find all properties where the average rating is greater than 4.0 using a subquery
SELECT p.property_id, p.name, p.location, 
       (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) AS average_rating
FROM Property p
WHERE (SELECT AVG(r.rating) FROM Review r WHERE r.property_id = p.property_id) > 4.0
ORDER BY average_rating DESC;

-- Query 2: Correlated subquery to find users who have made more than 3 bookings
SELECT u.user_id, u.first_name, u.last_name, u.email,
       (SELECT COUNT(*) FROM Booking b WHERE b.user_id = u.user_id) AS booking_count
FROM User u
WHERE (SELECT COUNT(*) FROM Booking b WHERE b.user_id = u.user_id) > 3
ORDER BY booking_count DESC;