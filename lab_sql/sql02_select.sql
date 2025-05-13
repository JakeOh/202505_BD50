/*
 * 기본 Query 문법: 테이블에 데이터를 검색.
 * (문법) select 컬럼이름, 컬럼이름, ... from 테이블이름;
 * 테이블의 모든 컬럼을 검색: select * from 테이블이름;
 */

-- 직원 테이블(emp)에서 사번(empno)과 이름(ename)을 검색:
select empno, ename from emp;

-- 직원 테이블의 모든 레코드(행과 열)를 검색:
select * from emp;
--> 테이블이 만들어진 컬럼 순서대로 출력.

-- 직원 테이블에서 부서번호, 사번, 이름, 업무, 급여, 상여, 입사일, 매니저사번을 검색.
select deptno, empno, ename, job, sal, comm, hiredate, mgr
from emp;

-- 컬럼 이름에 별명(alias) 주기: 컬럼이름 AS "별명"
-- as 키워드는 생략 가능.
-- 별명에 공백이 없는 경우에는 큰따옴표("")를 생략 가능.
-- 별명에는 큰따옴표("")만 사용 가능. 작은따옴표('')는 사용 불가.
-- (주의) SQL에서 작은따옴표는 문자열(string)에서 사용.
select
    empno as "사번",
    ename as "직원 이름",
    sal 급여
from emp;

-- 사번, 이름, 매니저사번을 검색. 컬럼 이름은 한글로 별명을 설정.
select 
    empno as "사번",
    ename as  "이름",
    mgr as "매니저 사번"
from emp;

-- 연결 연산자(||): 2개 이상의 컬럼 값들을 합쳐서 하나의 문자열로 만듦.
-- ename은 급여가 sal입니다.
select
    ename || '은(는) 급여가 ' || sal || '입니다.' as "이름-급여"
from emp;

-- 부서 테이블(dept)에서 부서 번호, 부서 이름, 위치를 검색.
-- 컬럼 이름 대신 별명을 사용해서 출력.
select
    deptno as "부서 번호",
    dname as "부서 이름",
    loc as "위치"
from dept;

-- 부서 테이블에서 부서 번호와 부서 이름을 '10-ACCOUNTING'와 같은 형식으로 출력.
select
    deptno || '-' || dname as "no-name"
from dept;

-- 검색 결과를 (오름차순, 내림차순) 정렬해서 출력:
-- (문법) select ... from table order by 정렬기준컬럼 [asc/desc], ...;
-- asc: ascending order. 오름차순. 기본값. 생략 가능.
-- desc: descending order. 내림차순.

-- 사번, 이름을 검색, 사번 오름차순 정렬 출력.
select empno, ename from emp order by empno;  -- order by empno asc

-- 사번, 이름을 사번의 내림차순 정렬해서 출력.
select empno, ename from emp order by empno desc;

-- 사번, 이름, 급여를 급여의 내림차순으로 출력.
select empno, ename, sal
from emp
order by sal desc;

-- 부서번호, 사번, 이름을 검색
-- 정렬 조건: (1) 부서번호 오름차순, (2) 사번 오름차순.
select deptno, empno, ename
from emp
order by deptno, empno;

-- 부서번호, 이름, 급여를 검색
-- 정렬 조건: (1) 부서번호 오름차순, (2) 급여 내림차순.
select deptno, ename, sal
from emp
order by deptno, sal desc;  -- order by deptno asc, sal desc

-- 직원 테이블에서 부서번호 컬럼 선택 출력
select deptno from emp;

-- 직원 테이블에서 중복되지 않는 부서번호를 검색
select distinct deptno from emp;

-- 직원 테이블에서 중복되지 않는 부서번호/업무를 검색.
select distinct deptno, job from emp;

-- select distinct deptno, distinct job from emp;
--> distinct 키워드는 컬럼 이름들 앞에서 한 번만 사용할 수 있음.
