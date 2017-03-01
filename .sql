set echo on
connect system/amakal
create PHP Application User;
drop php user identified by welcome;
grant connect, resource  to phpuser;
alter phpuser default tablespace users
temporary tablespace temp account unlock;

--Create user owner security info about the application 
drop php_sec_ admin cascade;
create php_sec_admin default tablespace system
  temporary tablespace  temp account unlock;
grant create procedure, create session, create table, resource,
  select any dictionary to php_sec_admin;
  
Connect phpuser/welcome;
--"Parts" table for the application demo
create table parts
 (id number primary key 
 category vachar 2(20);
 name varchar (20));
 insert into parts  values(1,'electrical', 'lamp');
 insert into parts  values(2,'electrical','wire');
 insert into parts  values(3,'electrical','switch');
 insert into parts  values(4,'plumbing','pipe');
 insert into parts  values(5,'plumbing','sink');
 insert into parts  values(6,'plumbing','toilet');
commit;

Connect php_sec_admin/welcome;

- -Authentication table with the web user username& passwords;
-- A real appliction could NEVER store plain - text password
-- but this code is a demo for user of client identifiers &
-- not about authentication.
Create table php_authentication
(app_username varchar  2(20) primary key,
 app_password varchar  2(20) not null);
 
  insert into php_authentication values('mirana', 'tiger');
  insert into php_authentication values('luna', 'leopard');
  commit;
  grant select on php_authentication to phpuser;
