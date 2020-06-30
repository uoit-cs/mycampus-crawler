.header on
.mode column

create temp table S as
    with S0 as (
        select 
            substr(semester, 1, 4) as year,
            semester,
            code,
            title,
            crn,
            max(actual) as actual
        from schedule
        where code like 'CSCI%U' 
            and schtype = 'Lecture' 
            and semester >= '2015'
        group by semester, code, crn
    )
    select year, semester, code, title, sum(actual) as actual
    from S0
    group by semester, code
    order by year, code
    ;

-- first year enrollment estimation
select year, actual as 'csci_1060u'
from S
where code = 'CSCI 1060U';

-- total students taught
select year, sum(actual) as 'total_in_lectures'
from S
group by year;

-- total non-lectures


select 
    substr(semester, 1, 4) as year,
    count(*) as 'lab_or_tutorial'
from schedule
where code like 'CSCI%U'
    and code < 'CSCI 3'
    and schtype is not 'Lecture'
    and semester >= '2015'
group by year
;

-- lectures and their first teaching

.width 10 10
with T as (
    select
        instructor,
        crn,
        semester,
        max(actual) as actual
    from schedule
    where code like 'CSCI%'
        and (
            instructor like '%Green' or
            instructor like '%Pu' or
            instructor like '%Bradbury' or
            instructor like '%Qureshi' or
            instructor like '%Collins' or
            instructor like '%Szlichta' or
            instructor like '%Fortier--')
    group by instructor, semester, crn
)
select substr(semester, 1, 4) as year, sum(actual) as undergrads
from T
group by year
order by year
;

-- ratio of sessionals
.width
with T as (
    select distinct semester, code, title, instructor
    from schedule
    where code like 'CSCI%U' 
        and semester > '2015'
        and schtype = 'Lecture'
),
S as (
    select * from T
    where 
    instructor like 'J%Bradbury' or
    instructor like 'J%Szlichta' or
    instructor like 'F%Qureshi' or
    instructor like 'M%Green' or
    instructor like 'K%Pu' or
    instructor like 'R%Fortier' or
    instructor like 'C%Collins' or
    instructor like 'M%Beligan' or
    instructor like 'M%Bennett' or
    instructor like 'Y%Zhu' or
    instructor like 'M%Makrehchi' or
    instructor like 'M%Ebrahimi' or
    instructor like 'L%Veen'
)
select  
    semester, 
    case when S.instructor is null then 'sessional' else 'core' end as type,
    count(distinct code)
from T left join S using (semester, code, instructor)
group by semester, type
order by semester, type, code
;

