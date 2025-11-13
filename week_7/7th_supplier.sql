create database if not exists supplie;
use supplie;

create table supplier(
	sid int,
    sname varchar(50),
    city varchar(50),
    primary key (sid));

insert into supplier (sid,sname,city)values
(10001, 'Acme Widget', 'Bangalore'),
(10002, 'Johns', 'Kolkata'),
(10003, 'Vimal', 'Mumbai'),
(10004, 'Reliance', 'Delhi');

create table parts(
	pid int,
    pname varchar(20),
    color varchar(50),
    primary key(pid));
    
insert into parts (pid,pname,color)values
(20001, 'Book', 'Red'),
(20002, 'Pen', 'Red'),
(20003, 'Pencil', 'Green'),
(20004, 'Mobile', 'Green'),
(20005, 'Charger', 'Black');

create table catalog(
	sid int,
	pid int,
    cost int,
    FOREIGN KEY (sid) REFERENCES supplier(sid),
    FOREIGN KEY (pid) REFERENCES parts(pid));
    
insert into catalog(sid,pid,cost)values
(10001 ,20001, 10),
(10001, 20002 ,10),
(10001, 20003, 30),
(10001 ,20004 ,10),
(10001 ,20005, 10),
(10002 ,20001, 10),
(10002, 20002, 20),
(10003 ,20003 ,30),
(10004 ,20003 ,40);

SELECT DISTINCT P.pname
FROM Parts P
JOIN Catalog C ON P.pid = C.pid;

SELECT S.sname
FROM Supplier S
WHERE NOT EXISTS (
    SELECT P.pid
    FROM Parts P
    WHERE P.pid NOT IN (
        SELECT C.pid
        FROM Catalog C
        WHERE C.sid = S.sid
    )
);

SELECT S.sname
FROM Supplier S
WHERE NOT EXISTS (
    SELECT P.pid
    FROM Parts P
    WHERE P.color = 'Red'
    AND P.pid NOT IN (
        SELECT C.pid
        FROM Catalog C
        WHERE C.sid = S.sid
    )
);

SELECT P.pname
FROM Parts P
WHERE P.pid IN (
    SELECT C.pid
    FROM Catalog C
    JOIN Supplier S ON C.sid = S.sid
    WHERE S.sname = 'Acme Widget'
)
AND P.pid NOT IN (
    SELECT C2.pid
    FROM Catalog C2
    JOIN Supplier S2 ON C2.sid = S2.sid
    WHERE S2.sname <> 'Acme Widget'
);

SELECT DISTINCT C1.sid
FROM Catalog C1
WHERE C1.cost > (
    SELECT AVG(C2.cost)
    FROM Catalog C2
    WHERE C2.pid = C1.pid
);

SELECT P.pid ,S.sname, C.cost
FROM Catalog C
JOIN Supplier S ON C.sid = S.sid
JOIN Parts P ON C.pid = P.pid
WHERE C.cost = (
    SELECT MAX(C2.cost)
    FROM Catalog C2
    WHERE C2.pid = C.pid
);