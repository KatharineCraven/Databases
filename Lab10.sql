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
        --prerq is selecting all prerequisites of the inputted course number
       ( select prereqnum
         from Prerequisites
         where coursenum = course_Num) prerq
     on prerq.prereqnum = Courses.num;
  return resultset;
end;
$$
language plpgsql;

--Tests

select PreReqsFor(308);
Fetch all from prereqsforresult;

close prereqsforresult;

select PreReqsFor(499);
Fetch all from prereqsforresult;

close prereqsforresult;

select PreReqsFor(220);
Fetch all from prereqsforresult;

--Part 2


create or replace function IsPreReqFor(int) returns refcursor as
$$
declare
   course_Num int :=$1;
   resultset refcursor = 'isprereqforresult';
begin
  open resultset for 
     select Courses.name
     from Courses inner join
      ( select coursenum 
        from prerequisites 
        where prereqnum = course_Num) prerq
     on prerq.coursenum = Courses.num;
  return resultset;
end;
$$
language plpgsql;

--Tests
select IsPreReqFor(120);
Fetch all from isprereqforresult;

close isprereqforresult;

select IsPreReqFor(220);
Fetch all from isprereqforresult;



