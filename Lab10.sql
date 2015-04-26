----------------------------------------------------------------------------------------
-- Katharine Craven
-- Databases Lab 10
-- 4/26/15
----------------------------------------------------------------------------------------

-- Part 1

create or replace function PreReqsFor(int) returns refcursor as
$$
declare
   course_Num int :=$1;
   resultset refcursor = 'prereqsforresult';
begin
  open resultset for 
     select Courses.name
     from Courses inner join
       ( select prereqnum
         from Prerequisites
         where coursenum = course_Num) prerq
     on prerq.prereqnum = Courses.num;
  return resultset;
end;
$$
language plpgsql;

select PreReqsFor(308);
Fetch all from prereqsforresult;

close prereqsforresult;

select PreReqsFor(499);
Fetch all from prereqsforresult;

close prereqsforresult;

select PreReqsFor(221);
Fetch all from prereqsforresult;
