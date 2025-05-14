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

select
    substr(ename, 1, 1) || '*' || substr(ename, 3) as "EMP_NAME"
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

-- round(): 반올림
select 
    10 / 3,
    round(10 / 3),     -- round(arg): arg(숫자 타입)의 소숫점 첫번째 자리에서 반올림 -> 정수
    round(10 / 3, 1),  -- round(arg, 양의 정수): 양의 정수까지의 소숫점 이하 자리를 표현.
    round(10 / 3, 2)
from dual;

-- round(arg, 음의 정수): 정수 자릿수에서 반올림.
select round(153, -1), round(153, -2) from dual;

-- trunc(): 버림.
select trunc(3.141592, 2), trunc(3.141592, 3) from dual;

-- decode(var, value, ret_val1, ret_val2):
-- var의 값이 value와 같으면 ret_val1을 반환, 그렇지 않으면 ret_val2을 반환
-- 부서번호가 10이면 보너스 1000, 그렇지 않으면 0.
select
    ename, deptno, decode(deptno, 10, 1000, 0) as "BONUS"
from emp;

-- decode(var, value1, ret_val1, value2, ret_val2, ret_val3)
-- var의 값이 value1이면 ret_val1을 반환(if var = value1: bonus = ret_val1)
-- var의 값이 value2이면 ret_val2를 반환(else if var = value2: bonus = ret_val2) 
-- 그렇지 않으며 ret_val3을 반환(else bonus = ret_val3)
select
    ename, deptno,
    decode(deptno, 10, 1000, 20, 500, 0) as "BONUS"
from emp;

-- 10번 부서는 보너스 1000, 20번 부서는 보너스 500, 30번 부서는 100, 그 이외에는 0
select
    ename, deptno,
    decode(deptno, 10, 1000, 20, 500, 30, 100, 0) as "BONUS"
from emp;

-- case-when-end 구문: decode() 함수를 대신할 수 있는 구문
select
    ename, deptno,
    case when deptno = 10 then 1000
         when deptno = 20 then 500
         when deptno = 30 then 100
         else 0
    end as "BONUS"
from emp;

-- 급여가 3000 이상이면 보너스 100
-- 급여가 2000 이상이면 보너스 110
-- 급여가 1000 이상이면 보너스 150
-- 나머지는 보너스 200
select
    ename, deptno, sal,
    case when sal >= 3000 then 100
         when sal >= 2000 then 110
         when sal >= 1000 then 150
         else 200
    end as "BONUS"
from emp;
