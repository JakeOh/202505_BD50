/*
 * 서브 쿼리(Sub Query):
 * SQL 문장의 일부로 다른 SQL 문이 포함되는 것.
 * (1) select 절의 서브 쿼리
 * (2) from 절의 서브 쿼리
 * (3) where 절의 서브 쿼리
 * (4) group by, having 절의 서브 쿼리
 * (주의) 서브 쿼리는 () 안에 작성. 서브 쿼리에서는 세미콜론(;)을 사용하지 않음.
 */

-- ALLEN의 급여보다 더 많은 급여를 받는 사원들.
-- ALLEN의 급여
select sal from emp where ename = 'ALLEN';  --> 1600

-- ALLEN의 급여보다 더 큰 급여
select * from emp where sal > 1600;

-- 서브쿼리
select *
from emp
where sal > (select sal
             from emp
             where ename = 'ALLEN'
             )
;

-- 전체 사원의 급여 평균보다 더 많은 급여를 받는 사원들.
-- 급여 평균
select avg(sal) from emp;  --> 2073.214...

-- 급여가 평균보다 많은
select * from emp where sal > 2073.21;

-- 서브쿼리
select * from emp
where sal > (
    select avg(sal) from emp
);

-- 1. ALLEN보다 적은 급여를 받는 직원들의 사번, 이름, 급여를 출력.
-- 2. ALLEN과 같은 업무를 담당하는 직원들의 사번, 이름, 부서번호, 업무, 급여를 출력.
-- 3. SALESMAN의 급여 최댓값보다 더 많은 급여를 받는 직원들의 사번, 이름, 급여, 업무를 출력.
-- 4. WARD의 연봉보다 더 많은 연봉을 받는 직원들의 이름, 급여, 수당, 연봉을 출력.
--    연봉 = sal * 12 + comm. comm(수당)이 null인 경우에는 0으로 계산.
--    연봉 내림차순 정렬.
-- 5. SCOTT과 같은 급여를  받는 직원들의 이름과 급여를 출력. 단, SCOTT은 제외.
-- 6. ALLEN보다 늦게 입사한 직원들의 이름, 입사날짜를 최근입사일부터 출력.
-- 7. 매니저가 KING인 직원들의 사번, 이름, 매니저 사번을 검색.
-- 8. ACCOUNTING 부서에 일하는 직원들의 이름, 급여, 부서번호를 검색.
-- 9. CHICAGO에서 근무하는 직원들의 이름, 급여, 부서 번호를 검색.
