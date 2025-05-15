/*
 * join: 2개 이상의 테이블에서 데이터를 검색하는 방법.
 * join의 종류
 * 1. (inner) join
 * 2. outer join
 *    (1) left (outer) join
 *    (2) right (outer) join
 *    (3) full (outer) join
 * join 문법
 * 1. ANSI 표준 문법
 *    select 컬럼, ...
 *    from 테이블1 join종류 테이블2 on join조건식;
 * 2. Oracle 문법
 *    select 컬럼, ...
 *    from 테이블1, 테이블2, ...
 *    where join조건식;
 */

select * from emp;
select * from dept;

-- 사번, 직원이름, 부서번호, 부서이름 검색
-- ANSI 문법
select
    emp.empno, emp.ename, emp.deptno, dept.dname
from emp inner join dept on emp.deptno = dept.deptno;
--> inner join에서 inner는 생략 가능.
