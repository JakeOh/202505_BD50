/*
 * call_chicken.csv 데이터 분석
 * 1. github에 있는 CSV 파일을 다운로드.
 * 2. CSV 파일 내용을 저장할 수 있는 테이블 생성
 *    테이블 이름(call_chicken), 컬럼 이름(call_date, call_day, gu, ages, gender, calls)
 * 3. CSV 파일 데이터를 테이블로 임포트(import)
 * 4. 분석:
 *    (1) 통화 건수의 최댓값, 최솟값
 *    (2) 통화 건수가 최댓값이거나 최솟값인 레코드 출력
 *    (3) 통화 요일별 통화 건수의 평균
 *    (4) 연령대별 통화 건수의 평균
 *    (5) 통화 요일별 연령대별 통화 건수의 평균
 *    (6) 구별 성별 통화 건수의 평균
 *    (7) 요일별 구별 연령대별 통화 건수의 평균
 */

create table call_chicken (
    call_date   date,
    call_day    char(1 char),
    gu          varchar2(5 char),
    ages        varchar2(5 char),
    gender      char(1 char),
    calls       number(4)
);

select * from call_chicken;

select distinct call_day from call_chicken;

select count(*), count(call_day) from call_chicken;

select distinct gu from call_chicken;

select count(*), count(gu) from call_chicken;

select distinct ages from call_chicken;

select count(*), count(ages) from call_chicken;

select distinct gender from call_chicken;

select count(*), count(gender) from call_chicken;

-- 1. 통화 건수의 최대/최소
select max(calls), min(calls) from call_chicken;

-- 2.
select * from call_chicken
where calls = (select max(calls) from call_chicken)
    or calls = (select min(calls) from call_chicken)
;

select * from call_chicken
where calls in (
    select max(calls) as "CALLS" from call_chicken
    union
    select min(calls) as "CALLS" from call_chicken
);

-- 3. 요일별 통화 건수
select
    call_day, round(avg(calls),2) as CALLS
from call_chicken
group by call_day
order by CALLS desc;

-- 4. 연령대별
select
    ages, round(avg(calls),2) as CALLS
from call_chicken
group by ages
order by CALLS desc;

-- 5. 요일별, 연령대별
select
    call_day, ages, round(avg(calls),2) as CALLS
from call_chicken
group by call_day, ages
order by CALLS desc;

-- 6. 구별, 성별
select
    gu, gender, round(avg(calls),2) as CALLS
from call_chicken
group by gu, gender
order by CALLS desc;

-- 7. 요일, 구별, 연령대
select
    call_day, gu, ages, round(avg(calls),2) as CALLS
from call_chicken
group by call_day, gu, ages
order by CALLS desc;
