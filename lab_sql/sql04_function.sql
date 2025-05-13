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
select substr('hello', 2, 2) from dual;
select substr(ename, 1, 2) from emp;
