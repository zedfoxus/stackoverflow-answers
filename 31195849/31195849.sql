-- http://sqlfiddle.com/#!3/20417/1
create table TBL_TEMP1 (
	id int identity(1,1) not null primary key,
	inv_no int not null,
	ck_no int
);

create table TBL_TEMP2 (
	id int identity(1,1) not null primary key,
	invoice int not null,
	ck_no int
);

insert into tbl_temp1 (inv_no, ck_no) values
(100, 10), (100, 20),
(200, 10), (200, 20), (200, 30),
(600, null),
(700, null);

insert into tbl_temp2 (invoice, ck_no) values
(100, 20), (100, 30),
(200, 20), (200, 30), 
(300, 60),
(700, null);

delete a
from tbl_temp2 a 
inner join tbl_temp1 b
	on a.invoice = b.inv_no
	and case when a.ck_no is null then -1 else a.ck_no end 
	= case when b.ck_no is null then -1 else b.ck_no end ;

-- this should give the same results as VBA, just a lot faster
select * from tbl_temp2;
