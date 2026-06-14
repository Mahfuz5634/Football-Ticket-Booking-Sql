-- SYSTEM: Football Ticket Booking System Database 


-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;


-- 1. CREATE USERS TABLE
CREATE TABLE Users (
    user_id int primary key,
    full_name varchar(100) not null,
    email varchar(100) unique not null,
    role varchar(30) not null
              check(role in('Football Fan','Ticket Manager')),
    phone_number varchar(20)
);


-- 2. CREATE MATCHES TABLE
CREATE TABLE Matches (
    match_id int primary key,
    fixture varchar(100) not null,
    tournament_category varchar(100) not null,
    base_ticket_price decimal(10,2) not null
                check(base_ticket_price >=0),
    match_status varchar(30) not null
                check(
              match_status in(
                 'Available',
                  'Selling Fast',
                  'Sold Out',
                   'Postponed'
              )
  
       )
  
    
);


-- 3. CREATE BOOKINGS TABLE
CREATE TABLE Bookings (
    booking_id int primary key,
    user_id int not null,
    match_id int not null,
    seat_number varchar(20),
    payment_status varchar(20)
             check(payment_status in(
                    'Pending',
                    'Confirmed',
                    'Cancelled',
                    'Refunded'
             ) or payment_status is null
     ),
    total_cost decimal(10,2) not null
          check(total_cost >=0),

   foreign key(user_id) references Users(user_id),
   foreign key (match_id) references Matches(match_id)
    
);


-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);


-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');


-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);

-- Query Start Here

--1
select match_id,fixture,base_ticket_price
from Matches
where tournament_category ='Champions League' and match_status = 'Available';

--2
select user_id,full_name,email
from Users
where full_name ilike 'Tanvir%' or full_name ilike '%Haque%';

--3
select booking_id,user_id,match_id,coalesce(payment_status,'Action Required')
as systematic_status
from Bookings
where payment_status is null;

--4
select b.booking_id,u.full_name,m.fixture,b.total_cost
from bookings as b inner join users as u on b.user_id = u.user_id
inner join matches as m on b.match_id= m.match_id;


--5
select u.user_id,u.full_name,b.booking_id
from users as u left join bookings as b on u.user_id = b.user_id;

--6
select booking_id,match_id,total_cost
from bookings
where total_cost>(
  select avg(total_cost)
  from bookings
);

--7
select match_id,fixture,base_ticket_price
from matches
order by base_ticket_price desc
limit 2 offset 1;


          
 

