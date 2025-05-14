/*
 * 다중 행 함수:
 * 여러 개의 행들이 함수 아규먼트로 전달되고, 하나의 값을 반환하는 함수.
 * 통계 함수: count, sum, avg, ...
 */

-- count(var): var(컬럼)에서 null이 아닌 값들의 개수를 반환.
select count(ename), count(comm) from emp;

select count(*) from emp;  -- 테이블의 행의 개수

-- 통계 함수: null을 제외하고 계산.
-- sum(): 합계
-- avg(): average. 평균.
-- variance(): 분산.
-- stddev(): standard deviation. 표준편차.
-- max(): 최댓값.
-- min(): 최솟값.
select
    count(sal) as "개수",
    sum(sal) as "합계",
    round(avg(sal), 2) as "평균",
    round(variance(sal), 2) as "분산",
    round(stddev(sal), 2) as "표준편차",
    max(sal) as "최댓값",
    min(sal) as "최솟값"
from emp;

