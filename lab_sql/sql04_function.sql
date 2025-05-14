/*
 * 오라클 함수(function)
 * 1. 단일 행 함수:
 *    행(row)이 하나씩 함수의 아규먼트로 전달되고, 행마다 결과값이 반환되는 함수.
 *    (예) to_date, to_char, to_number, ...
 * 2. 다중 행 함수:
 *    테이블에서 여러 개의 행이 함수의 아규먼트로 전달되고, 하나의 결과값이 반환되는 함수.
 *    통계 관련 함수. (예) count, sum, avg, ...
 */

-- 단일 행 함수
-- lower(문자열 타입 컬럼) -> 소문자로 변환.
select ename, lower(ename) from emp;

-- upper(문자열 타입 컬럼) -> 대문자로 변환
select upper(ename) from emp;

select * from emp where lower(ename) like '%a%';
select * from emp where ename like upper('%a%');

-- initcap(문자열 타입 컬럼) -> 단어의 첫글자만 대문자, 나머지는 소문자로 변환.
select initcap(ename) from emp;

-- to_char(컬럼, '포맷'): 컬럼의 값들을 '포맷' 형식의 문자열로 변환.
select to_char(hiredate, 'YYYY-MM-DD') from emp;

-- replace(문자열 컬럼, 원래 문자, 바꿀 문자)
select replace('smith', 'i', '-') from dual;
select replace(ename, 'A', '*') from emp;

-- substr(문자열 컬럼, 시작 인덱스, 자를 문자 개수)
select substr('hello', 2, 3) from dual;
select substr(ename, 1, 2) from emp;

-- substr(문자열, 시작 인덱스): 문자열에서 시작 인덱스 위치부터 끝까지 자름.
select substr('Hello, SQL!', 5) from dual;

-- emp 테이블에서 ename의 두번째 문자를 '*'로 바꿔서 출력.
select ename, substr(ename, 2, 1) from emp;
select 
    replace(ename, substr(ename, 2, 1), '*') as "EMP_NAME"
from emp;

-- nvl(var, value): var의 값이 null이면 value를 반환(return)하고, 그렇지 않으면 var를 반환.
select comm, nvl(comm, -1) from emp;

-- nvl2(var, value1, value2): var의 값이 null이 아니면 value1를 반환하고, null이면 value2를 반환.
select comm, nvl2(comm, 9999, 0) from emp;
select comm, nvl2(comm, comm, -1) from emp;

-- 사번, 이름, 급여, 수당, 연봉(sal * 12 + comm)을 출력.
-- comm이 null인 경우는 comm을 0으로 계산,
select
    empno, ename, sal, comm,
    nvl(sal, 0) * 12 + nvl(comm, 0) as "ANUAL_SAL"
from emp
order by ANUAL_SAL desc; -- select에서 설정한 alias(별명)을 order by에서 사용 가능.
