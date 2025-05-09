# Airbnb Database Normalization to 3NF

## ✅ First Normal Form (1NF)

- All attributes already contain only atomic values.
- Each record is unique, and no repeating groups exist.

## ✅ Second Normal Form (2NF)

- All non-key attributes are fully functionally dependent on the entire primary key.
- Composite keys avoided except where strictly necessary (not needed in current schema).

## ✅ Third Normal Form (3NF)

### Violation Identified:
- The `location` in the `Property` table could have redundant address data if multiple properties share the same location.
- This violates 3NF because `location` is a transitive dependency — dependent on a surrogate key (`property_id`) but actually descriptive of a separate entity.

### Resolution:
- Created a separate `Location` table.
- Linked `Property.location_id` to `Location.location_id`.

This separation ensures:
- No transitive dependencies.
- Improved data consistency and elimination of redundancy.
- Simplified updates (e.g., city name changes).

## 🔧 Indexing

- All primary keys are automatically indexed.
- Indexed:
  - `email` in `User`
  - `property_id` in `Property` and `Booking`
  - `booking_id` in `Booking` and `Payment`

## 🎯 Result

The database is now in 3NF:
- Atomic values ✅
- Full functional dependency ✅
- No transitive dependencies ✅
