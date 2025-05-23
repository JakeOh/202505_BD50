/*
 * 1. github의 gapminder.tsv 파일 다운로드
 * 2. 파일의 내용을 저장할 수 있는 테이블을 생성.
 *    테이블 이름: GAPMINDER
 *    컬럼: COUNTRY, CONTINENT, YEAR, LIFE_EXP, POP, GDP_PERCAP
 * 3. SQLDeveloper의 데이터 임포트 기능을 사용해서 파일의 내용을 테이블에 임포트
 * 4. 테이블에는 모두 몇 개의 나라가 있을까요?
 * 5. 테이블에는 모두 몇 개의 대륙이 있을까요?
 * 6. 테이블에는 저장된 데이터는 몇년도부터 몇년도까지 조사한 내용일까요?
 * 7. 기대 수명이 최댓값인 레코드(row)를 찾으세요.
 * 8. 인구가 최댓값인 레코드(row)를 찾으세요.
 * 9. 1인당 GDP가 최댓값인 레코드(row)를 찾으세요.
 * 10. 우리나라의 통계 자료만 출력하세요.
 * 11. 연도별 1인당 GDP의 최댓값인 레코드를 찾으세요.
 * 12. 대륙별 1인당 GDP의 최댓값인 레코드를 찾으세요.
 * 13. 연도별, 대륙별 인구수를 출력하세요.
 *     인구수가 가장 많은 연도와 대륙은 어디인가요?
 * 14. 연도별, 대륙별 기대 수명의 평균을 출력하세요.
 *     기대 수명이 가장 긴 연도와 대륙은 어디인가요?
 * 15. 연도별, 대륙별 1인당 GDP의 평균을 출력하세요.
 *     1인당 GDP의 평균이 가장 큰 연도와 대륙은 어디인가요?
 * 16. 13번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 * 17. 14번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 * 18. 15번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
 */

create table gapminder (
    country     varchar2(100),
    continent   varchar2(100),
    year        number(4),
    life_exp    number,
    pop         number,
    gdp_percap  number
);

-- 데이터 확인
-- 테이블 행의 개수, 각 컬럼에 null이 아닌 데이터 개수
select count(*), count(country), count(continent),
    count(year), count(life_exp), count(pop), count(gdp_percap)
from gapminder;
--> 결과: null이 있는 컬럼은 없음.

-- 국가 이름 개수
select distinct country from gapminder;
select count(distinct country) from gapminder;

-- 대륙 이름 개수
select distinct continent from gapminder;
select count(distinct continent) from gapminder;

-- 연도 개수
select min(year), max(year) from gapminder;
select distinct year from gapminder;

-- 기대 수명(life_exp) 변수(컬럼)의 기술 통계량
select 
    round(avg(life_exp), 2) as "평균", 
    round(variance(life_exp), 2) as "분산", 
    round(stddev(life_exp), 2) as "표준편차",
    min(life_exp) as "최솟값",
    median(life_exp) as "중앙값",
    max(life_exp) as "최댓값"
from gapminder;

-- 인구(pop) 변수의 기술 통계량
select 
    round(avg(pop), 2) as "평균", 
    round(variance(pop), 2) as "분산", 
    round(stddev(pop), 2) as "표준편차",
    min(pop) as "최솟값",
    median(pop) as "중앙값",
    max(pop) as "최댓값"
from gapminder;

-- 1인당 GDP 변수의 기술 통계량
select 
    round(avg(gdp_percap), 2) as "평균", 
    round(variance(gdp_percap), 2) as "분산", 
    round(stddev(gdp_percap), 2) as "표준편차",
    min(gdp_percap) as "최솟값",
    median(gdp_percap) as "중앙값",
    max(gdp_percap) as "최댓값"
from gapminder;

-- 기대수명(life_exp) 최댓값인 레코드(행)
select *
from gapminder
where life_exp = (
    select max(life_exp) from gapminder
);


-- 인구(pop) 최댓값인 레코드
select *
from gapminder
where pop = (
    select max(pop) from gapminder
);


-- 1인당 GDP 최댓값인 레코드
select *
from gapminder
where gdp_percap = (
    select max(gdp_percap) from gapminder
);

-- 우리나라의 통계 자료
select distinct country from gapminder
where lower(country) like '%kor%';

select * from gapminder
where country = 'Korea, Rep.';

-- 대륙별 1인당 GDP 최댓값 레코드
select continent, max(gdp_percap)
from gapminder
group by continent;

select *
from gapminder
where (continent, gdp_percap) in (
    select continent, max(gdp_percap)
    from gapminder
    group by continent
);

-- 연도별, 대륙별 인구수
select
    year, continent, sum(pop)
from gapminder
group by year, continent
order by year, continent;

select
    continent, year, sum(pop)
from gapminder
group by continent, year
order by continent, year;

-- 연도별 대륙별 인구수 최댓값
select
    year, continent, sum(pop) as "TOTAL_POP"
from gapminder    
group by year, continent
order by "TOTAL_POP" desc
offset 0 rows
fetch next 1 rows only;

with t as (
    select year, continent, sum(pop) as "TOTAL_POP"
    from gapminder
    group by year, continent
)
select *
from t
where TOTAL_POP = (
    select max(TOTAL_POP) from t
);

-- 연도별, 대륙별 기대 수명의 평균
select 
    year, continent, round(avg(life_exp), 2) as "AVG_LIFE_EXP"
from gapminder
group by year, continent
order by year, continent;
--order by continent, year;

select 
    year, continent, round(avg(life_exp), 2) as "AVG_LIFE_EXP"
from gapminder
group by year, continent
order by AVG_LIFE_EXP desc
offset 0 rows
fetch next 1 rows only;

with t as (
    select 
        year, continent, avg(life_exp) as "AVG_LIFE_EXP"
    from gapminder
    group by year, continent
)
select *
from t
where "AVG_LIFE_EXP" = (
    select max("AVG_LIFE_EXP") from t
);

-- 연도별 대륙별 1인당 GDP 평균
select
    year, continent, round(avg(gdp_percap), 2) as "AVG_GDP_PERCAP"
from gapminder
group by year, continent
--order by year, continent;
order by continent, year;

select
    year, continent, round(avg(gdp_percap), 2) as "AVG_GDP_PERCAP"
from gapminder
group by year, continent
order by "AVG_GDP_PERCAP" desc
offset 0 rows
fetch next 1 rows only;

with t as (
    select
        year, continent, avg(gdp_percap) as "AVG_GDP_PERCAP"
    from gapminder
    group by year, continent
)
select *
from t
where AVG_GDP_PERCAP = (
    select max(AVG_GDP_PERCAP) from t
);


-- row_number() over ([partition by ...] order by ...)
-- rank() over ([partition by ...] order by ...)

-- 테이블에서 급여 순위
select 
    deptno, ename, sal,
    rank() over (order by sal desc nulls last) as "RNK"
from emp;

-- emp 테이블에서 급여가 가장 많은 직원
with t as (
    select deptno, ename, sal,
        rank() over (order by sal desc nulls last) as "RNK"
    from emp
)
select *
from t
where RNK = 1;

-- 부서별 급여 순위
select
    deptno, ename, sal,
    rank() over (partition by deptno order by sal desc nulls last) as "RNK"
from emp;

-- 각 부서에서 급여가 가장 많은 직원들.
with t as (
    select deptno, ename, sal,
        rank() over (partition by deptno
                        order by sal desc nulls last) as "RNK"
    from emp
)
select *
from t
where RNK = 1 and sal is not null;

select deptno, ename, sal
from emp
where (deptno, sal) in (
    select deptno, max(sal)
    from emp
    group by deptno
)
order by deptno;

-- 연도별 1인당 GDP의 최댓값인 레코드
select
    g.*,
    rank() over (partition by year 
                    order by g.gdp_percap desc) as "RNK"
from gapminder g;

with t as (
    select
        g.*,
        rank() over (partition by year 
                        order by g.gdp_percap desc) as "RNK"
    from gapminder g
)
select *
from t
where RNK = 1;


-- pivot(집계함수 for 변수 in (변수의 값들))
-- 부서별 급여 합계 -> 부서번호들을 컬럼 이름으로
select *
from (
    select deptno, sal from emp
)
pivot(sum(sal) as "TOTAL_SAL"
        for deptno in (10 as "D10", 20 as "D20", 30 as "D30"));

-- 부서별 급여 합계 --> 부서번호들을 행으로.
select 
    deptno, sum(sal)
from emp
where deptno is not null
group by deptno
order by deptno;

-- 업무별 급여 합계: (1) group by, (2) pivot
select job, sum(sal)
from emp
where job is not null and sal is not null
group by job
order by job;

select *
from (
    select job, sal from emp
    where job is not null and sal is not null
)
pivot(sum(sal) 
        for job in (
                'ANALYST' as "ANALYST", 
                'CLERK' as "CLERK", 
                'MANAGER' as "MANAGER", 
                'SALESMAN' as "SALESMAN", 
                'PRESIDENT' as "PRESIDENT")
    );


-- pivot()을 사용한 연도별, 대륙별 인구수
with t as (
    select year, continent, pop
    from gapminder
)
select * from t
pivot(sum(pop) 
        for continent in ('Africa' as "AFRICA", 
                            'Americas' as "AMERICAS", 
                            'Asia' as "ASIA", 
                            'Europe' as "EUROPE", 
                            'Oceania' as "OCEANIA")
)
order by year;

-- pivot() 사용한 연도별, 대륙별 1인당 GDP의 평균
with t as (
    select year, continent, gdp_percap
    from gapminder
)
select 
    year, round(africa, 2), round(americas, 2), 
    round(asia, 2), round(europe, 2), round(oceania, 2)
from t
pivot(avg(gdp_percap)
        for continent in ('Africa' as "AFRICA", 
                            'Americas' as "AMERICAS", 
                            'Asia' as "ASIA", 
                            'Europe' as "EUROPE", 
                            'Oceania' as "OCEANIA")
)
order by year;

with t as (
    select 
        year, continent, round(avg(gdp_percap), 2) as "AVG_GDP_PERCAP"
    from gapminder
    group by year, continent
)
select * from t
pivot(sum(AVG_GDP_PERCAP) 
        for continent in ('Africa' as "AFRICA", 
                            'Americas' as "AMERICAS", 
                            'Asia' as "ASIA", 
                            'Europe' as "EUROPE", 
                            'Oceania' as "OCEANIA")
);
