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
