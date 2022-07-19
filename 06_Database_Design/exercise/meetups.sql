DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS interest_group;
DROP TABLE IF EXISTS group_member;
DROP TABLE IF EXISTS event;
DROP TABLE IF EXISTS event_member;
/************/
CREATE TABLE members(
member_id serial NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
phone_number VARCHAR(10) NULL,
dob DATE NOT NULL,
wants_reminder BOOlEAN NOT NULL,
CONSTRAINT pk_member_number PRIMARY KEY (member_id)
);
/************/
CREATE TABLE interest_group(
group_id serial NOT NULL,
name VARCHAR(100) NOT NULL,
CONSTRAINT pk_group PRIMARY KEY (group_id),
CONSTRAINT uc_name UNIQUE (name)
);
/************/
CREATE TABLE group_member(
group_id int NOT NULL,
member_id int NOT NULL,
CONSTRAINT pk_group_member PRIMARY KEY (group_id,member_id),
CONSTRAINT fk_member_id FOREIGN KEY (member_id) REFERENCES members (member_id),
CONSTRAINT fk_group_id FOREIGN KEY (group_id) REFERENCES interest_group (group_id)
);
/************/
CREATE TABLE event(
event_id serial NOT NULL,
name VARCHAR(100) NOT NULL,
description text NOT NULL,
start_dt TIMESTAMP NOT NULL,
length_minutes int DEFAULT 30,
group_id int NOT NULL,
CONSTRAINT pk_event_id PRIMARY KEY(event_id),
CONSTRAINT FK_group_id FOREIGN KEY(group_id) REFERENCES interest_group (group_id)
);
/************/
CREATE TABLE event_member(
event_id int NOT NULL,
member_id int NOT NULL,
CONSTRAINT pk_event_member PRIMARY KEY (event_id,member_id),
CONSTRAINT fk_event_id FOREIGN KEY (event_id) REFERENCES event(event_id),
CONSTRAINT fk_member_id FOREIGN KEY (member_id) REFERENCES members(member_id)
);
/************/
INSERT INTO members(last_name, first_name, email, phone_number, dob, wants_reminder)
VALUES
('Bishush','John','johnB@gmail.com','6619824000','1952-05-27','no'),
('Hexagul','Ted','tedH@gmail.com','6619823000','1962-03-05','yes'),
('Milly','Daisy','daisyM@gmail.com','6619829000','1991-09-03','yes'),
('Ramos','Ricardo','ricardo.r.p@gmail.com','6619827000','1996-09-08','yes'),
('Willis','Jaron','jaronWillis33@gmail.com','6619826000','2001-12-15','yes'),
('Salt','Epson','epsonS@gmail.com','6619828000','1978-10-25','no'),
('Kaneki','Ken','kenK@gmail.com','6619821000','3001-12-15','yes'),
('Jostar','Johnathan','johnathanJ@gmail.com','6619824000','1915-06-08','no');
/************/
INSERT INTO interest_group(name)
VALUES
('Code Conquers'),
('Duelist League'),
('Californian Market'),
('Rocky MT Hounding'),
('Hellfire');
/************/
INSERT INTO event(name, description, start_dt, length_minutes, group_id)
VALUES
('3rd Annual Hackathon', 'This event has coders from all across the world to put their skills to the test', '2012-02-13 08:30:00', '60', (SELECT group_id FROM interest_group WHERE name='Code Conquers')),
('KC Cup', 'This event has around 100 top duelists globally who will put their skills to the test to win', '2022-01-20 12:30:00', '300', (SELECT group_id FROM interest_group WHERE name='Duelist League')),
('Lancaster ave Farmers Market', 'This event features live performances,local food,and drinks', '2012-02-13 04:15:00', '60', (SELECT group_id FROM interest_group WHERE name='Californian Market')),
('California Gem Show', 'This event has gemstones from all across the world,make sure bring your family and friends ', '2012-02-13 06:45:00', '45', (SELECT group_id FROM interest_group WHERE name='Rocky MT Hounding')),
('D&D campaign', 'a game top notch fantasy game, new and pro players welcome', '2015-12-13 05:22:00', '420', (SELECT group_id FROM interest_group WHERE name='Hellfire'));
/************/
INSERT INTO group_member(group_id,member_id)
VALUES
((SELECT group_id FROM interest_group WHERE name='Code Conquers'),(SELECT member_id FROM members WHERE first_name='Epson')),
((SELECT group_id FROM interest_group WHERE name='Code Conquers'),(SELECT member_id FROM members WHERE first_name='Ricardo')),
((SELECT group_id FROM interest_group WHERE name='Code Conquers'),(SELECT member_id FROM members WHERE first_name='Jaron')),
((SELECT group_id FROM interest_group WHERE name='Code Conquers'),(SELECT member_id FROM members WHERE first_name='Ken')),
((SELECT group_id FROM interest_group WHERE name='Duelist League'),(SELECT member_id FROM members WHERE first_name='Daisy')),
((SELECT group_id FROM interest_group WHERE name='Duelist League'),(SELECT member_id FROM members WHERE first_name='Johnathon')),
((SELECT group_id FROM interest_group WHERE name='Duelist League'),(SELECT member_id FROM members WHERE first_name='Ted')),
((SELECT group_id FROM interest_group WHERE name='Duelist League'),(SELECT member_id FROM members WHERE first_name='John')),
((SELECT group_id FROM interest_group WHERE name='Duelist League'),(SELECT member_id FROM members WHERE first_name='Jaron')),
((SELECT group_id FROM interest_group WHERE name='Duelist League'),(SELECT member_id FROM members WHERE first_name='Ricardo')),
((SELECT group_id FROM interest_group WHERE name='Californian Market'),(SELECT member_id FROM members WHERE first_name='Daisy')),
((SELECT group_id FROM interest_group WHERE name='Californian Market'),(SELECT member_id FROM members WHERE first_name='Ted')),
((SELECT group_id FROM interest_group WHERE name='Californian Market'),(SELECT member_id FROM members WHERE first_name='Ken')),
((SELECT group_id FROM interest_group WHERE name='Californian Market'),(SELECT member_id FROM members WHERE first_name='Epson')),
((SELECT group_id FROM interest_group WHERE name='Hellfire'),(SELECT member_id FROM members WHERE first_name='Jaron')),
((SELECT group_id FROM interest_group WHERE name='Hellfire'),(SELECT member_id FROM members WHERE first_name='Jaron'));
/************/
INSERT INTO event_member(event_id,member_id)
VALUES
((SELECT event_id FROM event WHERE name='3rd Annual Hackathon'),(SELECT member_id FROM members WHERE first_name='Epson')),
((SELECT event_id FROM event WHERE name='3rd Annual Hackathon'),(SELECT member_id FROM members WHERE first_name='Ricardo')),
((SELECT event_id FROM event WHERE name='3rd Annual Hackathon'),(SELECT member_id FROM members WHERE first_name='Jaron')),
((SELECT event_id FROM event WHERE name='3rd Annual Hackathon'),(SELECT member_id FROM members WHERE first_name='Ken')),
((SELECT event_id FROM event WHERE name='KC Cup'),(SELECT member_id FROM members WHERE first_name='Daisy')),
((SELECT event_id FROM event WHERE name='KC Cup'),(SELECT member_id FROM members WHERE first_name='Johnathon')),
((SELECT event_id FROM event WHERE name='KC Cup'),(SELECT member_id FROM members WHERE first_name='Ted')),
((SELECT event_id FROM event WHERE name='KC Cup'),(SELECT member_id FROM members WHERE first_name='John')),
((SELECT event_id FROM event WHERE name='KC Cup'),(SELECT member_id FROM members WHERE first_name='jaron')),
((SELECT event_id FROM event WHERE name='KC Cup'),(SELECT member_id FROM members WHERE first_name='Ricardo')),
((SELECT event_id FROM event WHERE name='Lancaster ave Farmers Market'),(SELECT member_id FROM members WHERE first_name='Daisy')),
((SELECT event_id FROM event WHERE name='Lancaster ave Farmers Market'),(SELECT member_id FROM members WHERE first_name='Ted')),
((SELECT event_id FROM event WHERE name='Lancaster ave Farmers Market'),(SELECT member_id FROM members WHERE first_name='Ken')),
((SELECT event_id FROM event WHERE name='Lancaster ave Farmers Market'),(SELECT member_id FROM members WHERE first_name='Epson')),
((SELECT event_id FROM event WHERE name='California Gem Show'),(SELECT member_id FROM members WHERE first_name='Jaron')),
((SELECT event_id FROM event WHERE name='California Gem Show'),(SELECT member_id FROM members WHERE first_name='Johnathan')),
((SELECT event_id FROM event WHERE name='California Gem Show'),(SELECT member_id FROM members WHERE first_name='Ted')),
((SELECT event_id FROM event WHERE name='D&D campaign'),(SELECT member_id FROM members WHERE first_name='Jaron')),
((SELECT event_id FROM event WHERE name='D&D campaign'),(SELECT member_id FROM members WHERE first_name='Ricardo'));



