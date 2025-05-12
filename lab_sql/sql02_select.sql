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
