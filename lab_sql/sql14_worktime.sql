/*
 * 연평균_근로시간_OECD.xlsx 파일의 내용을 테이블에 저장. 분석.
 */

-- 엑셀 파일의 내용을 저장할 수 있는 테이블을 생성.
create table work_time (
    country varchar2(60),
    y2014   number(5),
    y2015   number(5),
    y2016   number(5),
    y2017   number(5),
    y2018   number(5)
);

desc work_time;

-- [접속 패널] -> 테이블 -> 마우스 오른쪽 클릭 -> 데이터 임포트(import)

select * from work_time;

select * from work_time where country = '한국';
select * from work_time where country like '%한국';

select substr('대한민국', 3) from dual;

select substr(country, length('　　　') + 1) from work_time;

update work_time
set country = substr(country, length('　　　') + 1);
commit;

select * from work_time;

-- 2018년 한국의 평균 근로 시간보다 평균 근로 시간이 더 긴 국가는?
select y2018 from work_time
where country = '한국';

-- 2018년의 연평균 근로시간이 2018년 한국 연평균 근로시간보다 더 긴 국가(들).
select country, y2018
from work_time
where y2018 > (
    select y2018 from work_time
    where country = '한국'
);

-- 연평균 근로시간이 2018년 한국 연평균 근로시간보다 더 긴 국가(들), 연도.
select * from work_time
where y2018 > (select y2018 from work_time
                where country = '한국')
    or y2017 > (select y2018 from work_time
                where country = '한국')
    or y2016 > (select y2018 from work_time
                where country = '한국')
    or y2015 > (select y2018 from work_time
                where country = '한국')
    or y2014 > (select y2018 from work_time
                where country = '한국');


-- 2018년 평균 근로 시간 (큰 순서로) 상위 5개국 찾기.

-- (1) offset-fetch
select country, y2018 from work_time
order by y2018 desc
offset 0 rows
fetch next 5 rows only
;

-- (2) rank() 함수
select
    wt.*,
    rank() over (order by y2018 desc) as "RNK"
from work_time wt;

with t as (
    select wt.*,
        rank() over (order by y2018 desc) as "RNK"
    from work_time wt
)
select "RNK", country, y2018
from t
where "RNK" <= 5;

-- row_number() 함수 사용
select
    wt.*,
    row_number() over (order by y2018 desc) as "RN"
from work_time wt;

with t as (
    select wt.*,
        row_number() over (order by y2018 desc) as "RN"
    from work_time wt
)
select "RN", country, y2018
from t
where "RN" <= 5;

-- rownum: 행 번호를 표시하기 위해서 오라클에서 제공하는 가상 컬럼(pseudo column)
select
    rownum as "RN",
    wt.*
from work_time wt
order by y2018 desc;

select
    rownum as "RN",
    t.*
from (
    select * from work_time order by y2018 desc
) t;

with v as (
    select rownum as "RN", t.*
    from (
        select * from work_time order by y2018 desc
    ) t
)
select "RN", country, y2018 
from v
where "RN" <= 5;


-- unpivot(): 컬럼의 내용들을 행으로 변경. 가로 데이터 -> 세로 데이터.
-- unpivot(var_x for var_y in (column1, column2, ...))
select * from work_time
unpivot(time for year in (y2014, y2015, y2016, y2017, y2018));

create view vw_work_time_long
as
select * from work_time
unpivot(time for year in (y2014, y2015, y2016, y2017, y2018));

select time
from vw_work_time_long
where country = '한국' and year = 'Y2018';

select *
from vw_work_time_long
where time > (
    select time from vw_work_time_long
    where country = '한국' and year = 'Y2018'
);

-- 각각의 연도에서 평균 근로 시간이 가장 긴 나라는?
select year, max(time)
from vw_work_time_long
group by year;

select *
from vw_work_time_long
where (year, time) in (
    select year, max(time) from vw_work_time_long
    group by year
);

-- 각각의 연도에서 평균 근로 시간이 가장 짧은 나라는?
select * 
from vw_work_time_long
where (year, time) in (
    select year, min(time) from vw_work_time_long
    group by year
);
