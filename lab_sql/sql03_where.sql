/*
 * 조건 검색 where
 *
 * 테이블에서 데이터 검색:
 * (1) projection: 테이블에서 원하는 컬럼(들) 선택. select column1, column2, ...
 * (2) selection: 테이블에서 조건을 만족하는 행(들) 선택. where 조건식
 *
 * 문법:
 * SELECT column1, column2, ... FROM table WHERE 조건식 ORDER BY sort_column, ...;
 *
 * 조건식에서 사용되는 연산자들:
 * (1) 비교 연산자: =, !=, >, >=, <, <=, is null, is not null, ...
 * (2) 논리 연산자: and, or, not
 */
 
 -- 10번 부서에서 근무하는 직원들의 부서번호, 사번, 이름을 검색.
 select deptno, empno, ename
 from emp
 where deptno = 10;
 
 -- 수당(comm)이 null이 아닌 직원들의 부서번호, 사번, 이름, 급여, 수당을 검색.
 -- 정렬 순서: (1) 부서번호 오름차순, (2) 사번 오름차순
 select deptno, empno, ename, sal, comm
 from emp
 where comm is not null
 order by deptno, empno;
 --> (주의) SQL에서는 null 여부를 비교할 때 =, != 연산자는 사용할 수 없음!
 --> 반드시 column is null, column is not null을 사용해야 함.
 
 -- 급여가 2000 이상인 직원들의 이름, 업무, 급여를 출력.
 -- 정렬 순서: (1) 급여 내림차순, (2) 이름 오름차순
 select ename, job, sal
 from emp
 where sal >= 2000
 order by sal desc, ename;
 
-- 급여가 2000 이상 3000 이하인 직원들의 이름, 업무, 급여를 출력.
-- 정렬 순서: 급여 내림차순.

-- 10번 또는 20번 부서에서 근무하는 직원들의 부서번호, 이름, 급여를 출력.
-- 정렬: (1) 부서번호 오름차순, (2) 급여 내림차순.

-- 업무가 'CLERK'인 직원들의 이름, 업무, 급여를 출력. 이름순으로 출력.

-- 업무가 'CLERK' 또는 'MANAGER'인 직원들의 이름, 업무, 급여를 출력.
-- 정렬: (1) 업무, (2) 급여

-- 20번 부서에서 근무하는 'CLERK'의 모든 레코드(모든 컬럼)를 출력.

-- CLERK, ANALYST, MANAGER가 아닌 직원들의 사번, 이름, 업무, 급여를 사번순 출력.

