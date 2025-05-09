# AirBnB Database Schema Generation

This directory contains the SQL scripts to generate the AirBnB clone database schema.

## Project Structure

```
database-script-0x01/
├── schema.sql          # Main database schema creation script
└── README.md          # This documentation file
```

## Schema Overview

The database schema includes the following tables:

- Users (guests, hosts, admins)
- Properties
- Bookings
- Payments
- Reviews
- Messages

## Usage

To generate the database schema:

1. Ensure you have MySQL installed and running
2. Connect to your MySQL server
3. Run the schema creation script:

```bash
mysql -u your_username -p < schema.sql
```

## Schema Details

The schema implements:
- UUID primary keys for all tables
- Appropriate foreign key relationships
- Required constraints and validations
- Timestamp tracking for relevant tables
- Proper indexing for performance
- ENUM types for status fields

## Entity Relationships

- Users can be hosts or guests
- Properties belong to hosts
- Bookings link guests to properties
- Payments are linked to bookings
- Reviews are linked to properties and users
- Messages connect users for communication

For detailed entity specifications, refer to the [requirements documentation](../ERD/requirements.md).
