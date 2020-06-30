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
        where code like 'CHEM%U' 
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
select year, actual as 'first_year'
from S
where code = 'CHEM 1010U';

-- total students taught
select year, sum(actual) as 'total_in_lectures'
from S
group by year;

-- total non-lectures

select 
    substr(semester, 1, 4) as year,
    count(*) as 'lab_or_tutorial'
from schedule
where code like 'CHEM%U'
    and code < 'CHEM 3'
    and schtype is not 'Lecture'
    and semester >= '2015'
group by year
;
