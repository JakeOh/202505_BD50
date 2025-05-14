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

-- 단일 행 함수와 다중 행 함수(그룹 함수)는 함께 사용할 수 없음!
-- select count(comm), nvl(comm, 0) from emp;  --> 에러 발생
-- select empno, count(empno) from emp;  --> 에러 발생

/*
 * 그룹별 쿼리
 * (예) 부서별 급여 평균, 부서별 직원수, ...
 * 
 * select 컬럼, 함수, ...
 * from 테이블, ...
 * where 조건식(1)
 * group by 컬럼(그룹을 묶을 수 있는 변수), ...
 * having 조건식(2)
 * order by 컬럼(정렬 기중이 된느 변수), ...;
 *
 * where 조건식(1): 그룹을 묶기 전에 조건을 만족하는 행들을 선택하기 위한 조건식.
 * having 조건식(2): 그룹을 묶은 후에 조건을 만족하는 그룹들을 선택하기 위한 조건식.
 *
 * (주의) group by에서 지정하지 않은 컬럼 이름은 select할 수 없음.
 */
 
 -- 부서별 인원수
 select deptno, count(*)
 from emp
 group by deptno
 order by deptno;
 
 -- 부서별 급여 평균
 select 
    deptno, round(avg(sal), 2) as "AVG_SAL"
 from emp
 group by deptno
 order by deptno;
 
 -- 급여가 null이 아닌 직원들 중에서 부서별 급여 평균
 select 
    deptno, round(avg(sal), 2) as "AVG_SAL"
 from emp
 where sal is not null
 group by deptno
 order by deptno;
 
 -- 급여가 null이 아닌 직원들 중에서 부서별 직원수, 급여 평균/최솟값/최댓값
 select 
    deptno, 
    count(*) as "COUNT_EMP", 
    round(avg(sal), 2) as "AVG_SAL",
    min(sal) as "MIN_SAL",
    max(sal) as "MAX_SAL"
 from emp
 where sal is not null
 group by deptno
 order by deptno;
 
 -- 업무가 null이 아닌 직원들 중에서 업무별 직원수, 급여 평균/표준편차
 select
    job
    count(*) as "COUNT_EMP",
    round(avg(sal), 2) as "AVG_SAL",
    round(stddev(sal), 2) as "STD_SAL"
 from emp
 where job is not null
 group by job
 order by job;
 
 -- 부서별 업무별 직원수, 급여 평균/최솟값/최댓값
 -- 업무가 null인 직원, 급여가 null인 직원 제외.
 select
    deptno, job,
    round(avg(sal), 2) as "AVG_SAL",
    min(sal) as "MIN_SAL",
    max(sal) as "MAX_SAL"
 from emp
 where (job is not null) and (sal is not null)
 -- where not (job is null or sal is null)
 group by deptno, job
 order by deptno, "AVG_SAL";
 -- select에서 설정한 별명(alias)는 order by 에서 사용할 수 있음.
 -- where, group by, having에서는 사용할 수 없음!
 
 -- 업무 중에서 PRESIDENT는 제외하고, 업무별 사원수를 출력.
 -- 업무별 사원수가 3명 이상인 업무들만 출력.
 select
    job, count(*) as "COUNT"
 from emp
 where job != 'PRESIDENT'
 group by job
 having count(*) >= 3
 order by "COUNT";
 
 select
    job, count(*) as "COUNT"
from emp
group by job
having job != 'PRESIDENT' and count(*) >= 3
order by "COUNT";
 
 -- 업무별 직원수, 급여 합계 출력.
 -- 입사일이 null인 직원 제외. 업무별 급여 합계가 5000 이상인 그룹만 출력.
 select
    job, count(*) as "COUNT", sum(sal) as "SUM_SAL"
 from emp
 where hiredate is not null
 group by job
 having sum(sal) >= 5000
 order by "SUM_SAL" desc;
 
 -- 입사연도별 직원수를 출력. (Hint) to_char(hiredate, 'YYYY')
 select
    to_char(hiredate, 'YYYY') as "YEAR",
    count(*) as "NUM_OF_EMP"
from emp
group by to_char(hiredate, 'YYYY')
order by "YEAR";

select
    substr(hiredate, 1, 4) as "YEAR",
    count(*) as "COUNT"
from emp
group by substr(hiredate, 1, 4)
;
--> substr(hiredate, 1, 4) 함수는 hiredate(날짜 타입)을 암묵적으로 문자열 타입으로 변환한 후, 문자열 자르기를 수행.
--> 환경설정 NLS 날짜 포맷의 영향을 받음.

 -- 입사연도별 부서별 직원수를 출력. 1980년은 제외.
 select
    to_char(hiredate, 'YYYY') as "YEAR",
    deptno,
    count(*) AS "COUNT"
 from emp
 where to_char(hiredate, 'YYYY') != '1980'
 group by to_char(hiredate, 'YYYY'), deptno
 order by "YEAR", deptno;
 