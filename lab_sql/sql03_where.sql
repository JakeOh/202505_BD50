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
select ename, job, sal
from emp
where sal >= 2000 and sal <= 3000
order by sal desc;

select ename, job, sal
from emp
where sal between 2000 and 3000
order by sal desc;

-- 10번 또는 20번 부서에서 근무하는 직원들의 부서번호, 이름, 급여를 출력.
-- 정렬: (1) 부서번호 오름차순, (2) 급여 내림차순.
select deptno, ename, sal
from emp
where deptno = 10 or deptno = 20
order by deptno, sal desc;

select deptno, ename, sal
from emp
where deptno in (10, 20)
order by deptno, sal desc;

-- 업무가 'CLERK'인 직원들의 이름, 업무, 급여를 출력. 이름순으로 출력.
select ename, job, sal
from emp
where job = 'CLERK'
order by ename;
--> SQL에서 문자열은 작은따옴표('')를 사용.
--> 비교하려는 문자열은 대/소문자를 구분.

-- 업무가 'CLERK' 또는 'MANAGER'인 직원들의 이름, 업무, 급여를 출력.
-- 정렬: (1) 업무, (2) 급여
select ename, job, sal
from emp
where job = 'CLERK' or job = 'MANAGER'
order by job, sal;

select ename, job, sal
from emp
where job in ('CLERK', 'MANAGER')
order by job, sal;

-- 20번 부서에서 근무하는 'CLERK'의 모든 레코드(모든 컬럼)를 출력.
select * from emp
where deptno = 20 and job = 'CLERK';

-- CLERK, ANALYST, MANAGER가 아닌 직원들의 사번, 이름, 업무, 급여를 사번순 출력.
select empno, ename, job, sal
from emp
where job != 'CLERK' and job != 'ANALYST' and job != 'MANAGER'
order by empno;

select empno, ename, job, sal
from emp
where job not in ('CLERK', 'ANALYST', 'MANAGER')
order by empno;


-- like 검색: 특정 문자열로 시작하거나 또는 특정 문자열이 포함된 값(들)을 찾는 검색
-- like 검색에서 사용되는 wildcard:
-- (1) %: 글자수 제한이 없음.
-- (2) _: 밑줄(underscore)이 있는 자리에 한 글자가 어떤 문자이더라도 상관 없음.

select * from emp where job like '_LERK'; --> 4개 행
select * from emp where job like '_ERK';  --> 0개 행
select * from emp where job like '__ERK'; --> 4개 행
select * from emp where job like 'C____'; --> 4개 행
select * from emp where job like 'C%'; -- 'C'로 시작하는 모든 단어
select * from emp where job like '%K'; -- 'K'로 끝나는 모든 단어

-- 이름에 'A'가 포함된 직원들의 모든 레코드(행과 열)을 출력.
select * from emp where ename like '%A%';

-- 업무에 'MAN' 문자열이 포함된 직원들의 모든 레코드를 출력.
select * from emp where job like '%MAN%';

insert into emp (empno, ename, job)
values (1001, '홍길동', 'sa_le%man');
commit;

select * from emp;
select * from emp where job like '%\_%' escape '\';
-- like '%[escaple문자][검색할 특수기호]%' escape '[escape문자]'


select * from emp where empno = 7369;
select * from emp where empno = '7369';  -- 암묵적 타입 변환
--> 오라클에서 숫자 타입 컬럼과 문자열 타입 값을 비교할 때 
-- 문자열을 숫자로 변환한 후 컬럼의 값들과 비교.

-- 명시적 타입 변환
select * from emp where empno = to_number('7369');

-- 날짜 타입에서도 크기 비교 가능: 과거(2024년) < 현재(2025년) < 미래(2026년)
-- 1982/01/01 이후에 입사한 직원들
select * from emp 
where hiredate > '1982/01/01'
order by hiredate;
--> where 구문에서 암묵적 타입 변환
-- 오라클은 날짜(DATE) 타입 컬럼과 문자열 값을 비교할 때
-- 문자열을 날짜 타입으로 (자동) 변환 후에 컬럼의 값들과 비교.
