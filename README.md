# Football Ticket Booking System

## Overview

This project is a simple database design for a Football Ticket Booking System. It demonstrates database schema creation, ERD design, and SQL query implementation using PostgreSQL concepts.

## Database Tables

### Users

Stores information about football fans and ticket managers.

### Matches

Stores football match details, tournament categories, ticket prices, and match status.

### Bookings

Stores ticket booking records and links users with matches.

## Relationships

* One User can have Many Bookings.
* One Match can have Many Bookings.
* Each Booking belongs to exactly one User and one Match.

## Features

* Primary Keys and Foreign Keys
* Referential Integrity
* Check Constraints
* Unique Constraints
* JOIN Operations
* Subqueries
* NULL Handling
* Aggregation Functions
* Pagination using LIMIT and OFFSET

## Technologies Used

* PostgreSQL
* SQL
* ERD (Draw.io / Lucidchart)

## Project Structure

```text
Football-Ticket-Booking-System/
│
├── queries.sql
├── ERD.png
└── README.md
```

## Author

Mahfuz
Competitive Programmer | Full Stack Web Developer
