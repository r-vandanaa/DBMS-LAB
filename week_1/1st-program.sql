create database if not exists first;
show databases;
use first;
create table person
(
	driver_id varchar(10),
    name varchar(20),
	address varchar(30),
    primary key(driver_id)
);
create table car
(
	reg_num varchar(10),
    model varchar(10),
    year int,
    primary key(reg_num)
);
create table accident
(
	report_num int,
    accident_date date,
    location varchar(30),
    primary key(report_num)
);
create table owns
(
	driver_id varchar(10),
    reg_num varchar(10),
    primary key(driver_id,reg_num),
    foreign key(driver_id) references person(driver_id),
    foreign key(reg_num) references car(reg_num)
);
create table participated
(
	driver_id varchar(10),
    reg_num varchar(10),
    report_num int,
    damage_amount int,
    primary key(driver_id,reg_num,report_num),
    foreign key(driver_id) references person(driver_id),
    foreign key(reg_num) references car(reg_num),
    foreign key(report_num) references accident(report_num)
);
insert into person values('A01','Richard','Srinavas nagar');
insert into person values('A02','pradeep','rajaji nagar');
insert into person values('A03','Smith','Ashok nagar');
insert into person values('A04','Venu','N R Colony');
insert into person values('A05','Jhon','Hanumanth nagar');
insert into car values('KA052250','INDICA',1990);
INSERT INTO car VALUES('KA031181','LANCER',1957);
INSERT INTO car VALUES('KA095477','TOYOTA',1998);
INSERT INTO car VALUES('KA053408','HANDA',2008);
INSERT INTO car VALUES('KA041702','AUDI',2005);
INSERT INTO owns VALUES('A01','KA052250');
INSERT INTO owns VALUES('A02','KA031181');
INSERT INTO owns VALUES('A03','KA095477');
INSERT INTO owns VALUES('A04','KA053408');
INSERT INTO owns VALUES('A05','KA041702');
INSERT INTO participated values('A01','KA052250',11,10000);
INSERT INTO participated values('A02','KA031181',12,50000);
INSERT INTO participated values('A03','KA095477',13,25000);
INSERT INTO participated values('A04','KA053408',14,3000);
INSERT INTO participated values('A05','KA041702',15,5000);
INSERT INTO accident values(11,'2003-01-01','mysore road');
insert into accident values(12,'2004-02-02','soutn end circle');
insert into accident values(13,'2003-01-21','bull temple');
insert into accident values(14,'2008-02-17','mysore road');
insert into accident values(15,'2005-03-04','kanakapura');
update participated set damage_amount=25000 
where reg_num='KA031181' and report_num=12;
select count(distinct driver_id) CNT
	from participated a, accident b
	where a.report_num=b.report_num and b.accident_date like '%08';
insert into accident values(16,'2008-03-08','domluip');
select * from accident;
select accident_date,location from accident;
select driver_id from participated where damage_amount >=25000;


