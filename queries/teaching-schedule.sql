.mode column
.header on

select
    instructor,
    semester,
    code,
    weekday,
    printf('%.2d:%.2d', starthour, startmin) as start,
    printf('%.2d:%.2d', endhour, endmin) as end,
    room,
    actual,
    capacity
from schedule
where
    code like 'CSCI%' and
    instructor not like '%tba%' and
    instructor like 'Ken%'
order by 
    instructor,
    case when weekday = 'M' then 1
              when weekday = 'T' then 2
              when weekday = 'W' then 3
              when weekday = 'R' then 4
              when weekday = 'F' then 5
              else 10
    end,
    start
    ;

