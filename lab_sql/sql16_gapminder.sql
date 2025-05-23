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
