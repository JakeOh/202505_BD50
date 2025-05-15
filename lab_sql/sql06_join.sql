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

-- inner join: 사번, 직원이름, 부서번호, 부서이름 검색
-- ANSI 문법
select
    e.empno, e.ename, e.deptno, d.dname
from emp e
    inner join dept d on e.deptno = d.deptno;
--> inner join에서 inner는 생략 가능.

-- Oracle 문법
select
    e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno;


-- left join: 사번, 직원이름, 부서번호, 부서이름
-- ANSI 문법
select
    e.empno, e.ename, e.deptno, d.dname
from emp e
    left outer join dept d on e.deptno = d.deptno;
--> left outer join에서 outer는 생략 가능.

-- Oracle 문법
select
    e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno(+);


-- right (outer) join: 사번, 직원이름, 부서번호, 부서이름
-- ANSI 문법
select
    e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e
    right join dept d on e.deptno = d.deptno;

-- Oracle 문법
select
    e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno;

-- full (outer) join
-- ANSI 문법
select
    e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e
    full join dept d on e.deptno = d.deptno;

-- Oracle은 full outer join 문법을 제공하지 않음!
-- Oracle에서는 left join의 결과와 right join의 결과를 "union(합집합)"
select
    e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno(+)
union
select
    e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno;

-- 교집합(intersect)
select
    e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno(+)
intersect
select
    e.empno, e.ename, e.deptno, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno;
