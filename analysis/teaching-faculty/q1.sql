ATTACH '../databases/2017-01-10.sqlite3' as db1;
ATTACH './TF.sqlite3' as db2;

CREATE TEMP TABLE grouping(semester text, s text);

INSERT INTO grouping 
VALUES ('201701', '2016-2017'),
       ('201609', '2016-2017'),
       ('201601', '2015-2016'),
       ('201509', '2015-2016'),
       ('201501', '2014-2015'),
       ('201409', '2014-2015');

CREATE temp table load AS
select 
    s as year,
    tf.lastname, tf.firstname, 
    S.code,
    S.schtype,
    S.actual as students
from db2.tf as TF left join db1.schedule S
  on instructor = TF.firstname || " " ||TF.lastname
  left join grouping
  on S.semester = grouping.semester
where S.semester >= '201409';


.header on
.mode column


.output details.txt
.width 10 20 15 10 20 10
SELECT * FROM load;


.output individual.txt
.width 10 20 15 20
select year, lastname, firstname, schtype, sum(students) as students
from load
group by year, lastname, firstname, schtype;

.output labs.txt
.width 10 20
select year, count(*) as labs
from load
where schtype like '%lab%'
group by year
order by year;

.output courses.txt
.width 10 20
select year, count(distinct code) as courses
from load
group by year
order by year;

.output students.txt
.width 10 20
select year, sum(students) as students
from load
group by year
order by year;
