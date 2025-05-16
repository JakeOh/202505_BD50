/*
 * 서브 쿼리(Sub Query):
 * SQL 문장의 일부로 다른 SQL 문이 포함되는 것.
 * (1) select 절의 서브 쿼리
 * (2) from 절의 서브 쿼리
 * (3) where 절의 서브 쿼리
 * (4) having 절의 서브 쿼리
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
select empno, ename, sal
from emp
where sal < (select sal from emp
             where ename = 'ALLEN');

-- 2. ALLEN과 같은 업무를 담당하는 직원들의 사번, 이름, 부서번호, 업무, 급여를 출력.
select empno, ename, deptno, job, sal
from emp
where ename != 'ALLEN'
    and 
    job = (select job from emp
           where ename = 'ALLEN');

-- 3. SALESMAN의 급여 최댓값보다 더 많은 급여를 받는 직원들의 사번, 이름, 급여, 업무를 출력.
select empno, ename, sal, job
from emp
where sal > (select max(sal) from emp
             where job = 'SALESMAN');

-- 4. WARD의 연봉보다 더 많은 연봉을 받는 직원들의 이름, 급여, 수당, 연봉을 출력.
--    연봉 = sal * 12 + comm. comm(수당)이 null인 경우에는 0으로 계산.
--    연봉 내림차순 정렬.
select 
    ename, sal, comm, sal * 12 + nvl(comm, 0) as "ANUAL_SAL"
from emp
where sal * 12 + nvl(comm, 0) > (
        select sal * 12 + nvl(comm, 0)
        from emp
        where ename = 'WARD')
order by "ANUAL_SAL" desc;

-- 5. SCOTT과 같은 급여를  받는 직원들의 이름과 급여를 출력. 단, SCOTT은 제외.
select ename, sal
from emp
where ename != 'SCOTT' 
    and sal = (select sal from emp
               where ename = 'SCOTT');

-- 6. ALLEN보다 늦게 입사한 직원들의 이름, 입사날짜를 최근입사일부터 출력.
select ename, hiredate 
from emp
where hiredate > (select hiredate from emp
                  where ename = 'ALLEN')
order by hiredate desc;

-- 7. 매니저가 KING인 직원들의 사번, 이름, 매니저 사번을 검색.
select empno, ename, mgr
from emp
where mgr = (select empno from emp
             where ename = 'KING');

-- 8. ACCOUNTING 부서에 일하는 직원들의 이름, 급여, 부서번호를 검색.
select ename, sal, deptno
from emp
where deptno = (select deptno from dept
                where dname = 'ACCOUNTING');

select
    e.ename, e.sal, e.deptno
from emp e
    join dept d on e.deptno = d.deptno
where d.dname = 'ACCOUNTING';

-- 9. CHICAGO에서 근무하는 직원들의 이름, 급여, 부서 번호를 검색.
select ename, sal, deptno
from emp
where deptno = (select deptno from dept
                where loc = 'CHICAGO');

select e.ename, e.sal, e.deptno
from emp e
    join dept d on e.deptno = d.deptno
where d.loc = 'CHICAGO';


-- 단일 행 서브쿼리: 서브쿼리의 결과 행의 개수가 1개인 경우.
-- 단일 행 서브쿼리는 동등비교(=)를 사용할 수 있음.

-- 다중 행 서브쿼리: 서브쿼리의 결과 행의 개수가 2개 이상인 경우.
-- 다중 행 서브쿼리는 동등비교(=) 사용할 수 없음! in 연산자는 사용할 수 있음.
-- SALESMAN들의 급여와 같은 급여를 받는 직원들.
select sal from emp where job = 'SALESMAN';
select * from emp where sal = 1600 or sal = 1250 or sal = 1500;
select * from emp where sal in (1600, 1250, 1500);
select * from emp where sal in (
    select sal from emp where job = 'SALESMAN'
);

-- 매니저인 직원들.
select * from emp
where empno in (select distinct mgr from emp);

-- 매니저가 아닌 직원들.
select * from emp
where empno not in (select distinct mgr from emp 
                    where mgr is not null);

-- in, not in 연산자는 값을 비교할 때 동등 비교(=, !=)를 사용.
-- x = null (false), x != null (false)

-- 다중행 서브쿼리와 exists, not exists
select * from emp e1
where exists (select * from emp e2 
              where e2.mgr = e1.empno);

select * from emp e1
where not exists (select * from emp e2
                  where e2.mgr = e1.empno);

-- 부서 테이블 자료들 중에서 직원 테이블에 존재하는 부서 정보들.
select * from dept d
where exists (select * from emp e
              where e.deptno = d.deptno)
;

select distinct d.*
from dept d
    join emp e on e.deptno = d.deptno;

-- 부서 테이블 자료들 중에서 직원 테이블에 없는 부서 정보.
select * from dept d
where not exists (select * from emp e
                  where e.deptno = d.deptno)
;


-- 다중 행 서브쿼리에서 any vs all
select * from emp
where sal > any (select sal from emp
                 where job = 'SALESMAN');
--> SALESMAN들의 급여 중 최솟값보다 더 많은 급여를 받는 직원들.

-- 위의 다중 행 서브쿼리는 아래의 단일 행 서브쿼리와 같은 결과.
select * from emp
where sal > (select min(sal) from emp 
             where job = 'SALESMAN');

select * from emp
where sal > all (select sal from emp
                 where job = 'SALESMAN');
--> SALESMAN들의 급여 중 최댓값보다 더 많은 급여를 받는 직원들.


-- having 절에서의 서브쿼리
-- 업무별 급여의 합계, 영업사원들의 급여 합계보다 큰 경우만 출력.
select job, sum(sal) AS "TOTAL_SALARY"
from emp
group by job
having sum(sal) > (select sum(sal) from emp
                   where job = 'SALESMAN')
order by "TOTAL_SALARY";


-- select 절에서의 서브쿼리
-- 영업사원들의 이름, 월급을 영업사원 월급 최댓값/최솟값과 함께 출력.
select
    ename, sal,
    (select min(sal) from emp where job = 'SALESMAN') as "MIN",
    (select max(sal) from emp where job = 'SALESMAN') as "MAX"
from emp
where job = 'SALESMAN';


-- from 절에서의 서브쿼리
-- 이름, 급여, 급여 순위
select ename, sal,
    rank() over (order by sal desc nulls last) as "RANKING"
from emp;
-- 오름차순(asc) 정렬에서는 null 값이 가장 마지막에 출력.
-- 내림차순(desc) 정렬에서는 null 값이 가장 먼저 출력.
-- order by 컬럼 desc nulls last 형식으로 사용하면 내림차순에서도 null들은 가장 마지막에 출력.

-- 급여 순위 5위까지 출력
select 
    t.ename, t.sal, t."RANK"
from (select emp.*, 
          rank() over (order by sal desc nulls last) as "RANK"
      from emp
     ) t
where t."RANK" <= 5;


-- with 식별자 as (서브쿼리) 구문 --> 주 SQL 문장을 간단히 작성하기 위해서.
with t as (
    select emp.*, 
           rank() over (order by sal desc nulls last) as "RANK"
    from emp
)
select t.ename, t.sal, t."RANK"
from t
where t."RANK" <= 5;


-- 페이징(paging) 처리
-- 직원 테이블에서 사번 오름차순 정렬 상태로 5개씩 출력.

-- rownum: Oracle에서 제공되는 pseudo(가상) 컬럼
select rownum as "RN", emp.* from emp order by empno;

select
    t.empno, t.ename, t.job, t.sal
from (select rownum as "RN", emp.* from emp order by empno) t
where t."RN" between 11 and 15;

with t as (
    select rownum as "RN", emp.*
    from emp
    order by empno
)
select 
    t.empno, t.ename, t.job, t.sal
from t
where t."RN" between 1 and 5;


-- row_number() 함수를 사용한 페이징
with t as (
    select
        row_number() over (order by sal desc nulls last) as "RN",
        emp.*
    from emp
)
select t.empno, t.ename, t.sal
from t
where t."RN" between 1 and 5
;


-- Top-N 쿼리: offset-fetch 구문을 사용한 페이징.
select 
    empno, ename, sal
from emp
order by sal desc nulls last
offset 0 rows
fetch next 5 rows only
;
