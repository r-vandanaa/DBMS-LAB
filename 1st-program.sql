-- Create and use database
CREATE DATABASE insurance;
USE insurance;

-- Table: person
CREATE TABLE person (
    driver_id VARCHAR(50),
    name VARCHAR(50),
    address VARCHAR(50),
    PRIMARY KEY (driver_id)
);

-- Inserting into person
INSERT INTO person (driver_id, name, address) VALUES
('A01', 'Richard', 'Srinivas nagar'),
('A02', 'Pradeep', 'Rajaji nagar'),
('A03', 'Smith', 'Ashok nagar'),
('A04', 'Venu', 'N R colony'),
('A05', 'Jhon', 'Hanumanth nagar');

-- Table: car
CREATE TABLE car (
    reg_num VARCHAR(50),
    model VARCHAR(50),
    year INT,
    PRIMARY KEY (reg_num)
);

-- Inserting into car
INSERT INTO car (reg_num, model, year) VALUES
('KA052250', 'indica', 1990),
('KA031181', 'Lancer', 1957),
('KA095477', 'toyota', 1998),
('KA053408', 'honda', 2008),
('KA041702', 'audi', 2005);

-- Table: accident
CREATE TABLE accident (
    report_num INT,
    accident_date DATE,
    location VARCHAR(50),
    PRIMARY KEY (report_num)
);

-- Inserting into accident
INSERT INTO accident (report_num, accident_date, location) VALUES
(11, '2003-01-01', 'Mysore Road'),
(12, '2004-02-02', 'South end Circle'),
(13, '2003-01-21', 'Bull temple road'),
(14, '2008-02-17', 'Mysore Road'),
(15, '2005-03-04', 'Kanakpura Road');

-- Table: owns
CREATE TABLE owns (
    driver_id VARCHAR(50),
    reg_num VARCHAR(50),
    PRIMARY KEY (driver_id, reg_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES car(reg_num)
);

INSERT INTO owns (driver_id, reg_num) VALUES
('A01', 'KA052250'),
('A02', 'KA053408'),
('A03', 'KA095477'),
('A04', 'KA031181'),
('A05', 'KA041702');

-- Table: participated
CREATE TABLE participated (
    driver_id VARCHAR(50),
    reg_num VARCHAR(50),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, reg_num, report_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES car(reg_num),
    FOREIGN KEY (report_num) REFERENCES accident(report_num)
);

-- Inserting into participated
INSERT INTO participated (driver_id, reg_num, report_num, damage_amount) VALUES
('A01', 'KA052250', 11, 10000),
('A02', 'KA053408', 12, 50000),
('A03', 'KA095477', 13, 25000),
('A04', 'KA031181', 14, 3000),
('A05', 'KA041702', 15, 5000);


SELECT accident_date, location
FROM accident;

UPDATE participated
SET damage_amount = 25000
WHERE driver_id = 'A02' AND reg_num = 'KA053408' AND report_num =12;

INSERT INTO accident (report_num, accident_date, location)
VALUES (16, '2025-09-25', 'MG Road');

SELECT DISTINCT driver_id
FROM participated
WHERE damage_amount >= 25000;