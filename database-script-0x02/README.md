# AirBnB Database Seed Data

This directory contains the SQL script to populate the AirBnB clone database with sample data.

## Sample Data Overview

The seed script (`seed.sql`) provides test data for all tables:

- **Users**: 4 sample users
  - 1 host (John Doe)
  - 2 guests (Jane Smith, Mary Johnson)
  - 1 admin user

- **Properties**: 2 properties
  - Luxury Beach Villa in Miami Beach
  - Mountain Cabin in Aspen

- **Bookings**: 2 bookings
  - One confirmed booking
  - One pending booking

- **Payments**: 1 payment record
  - Linked to the confirmed booking

- **Reviews**: 2 property reviews
  - 5-star review for the Beach Villa
  - 4-star review for the Mountain Cabin

- **Messages**: 2 message exchanges
  - Conversation between a guest and host

## Usage

To populate the database with seed data:

1. First ensure the schema is created using the schema.sql script
2. Then run the seed script:

```bash
mysql -u your_username -p your_database < seed.sql
```

## Data Relationships

The seed data demonstrates:
- Host-Property relationships
- Guest-Booking relationships
- Booking-Payment linkage
- User-Review connections
- Message threads between users

All records use UUID format for primary keys and maintain referential integrity.
