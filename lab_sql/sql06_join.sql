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


-- equi-join: 조인의 조건식이 =인 경우.
-- non-equi join: 조인의 조건식이 =가 아닌 경우. 부등호 등을 이용한 경우.
-- emp 테이블과 salgrade 테이블을 조인해서 사번, 이름, 급여, 급여 등급을 검색.
-- inner join
select e.empno, e.ename, e.sal, s.grade
from emp e
    join salgrade s on e.sal between s.losal and s.hisal;
-- e.sal >= s.losal and e.sal <= s.hisal

select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s 
where e.sal between s.losal and s.hisal;

-- left (outer) join
select e.empno, e.ename, e.sal, s.grade
from emp e
    left join salgrade s on e.sal between s.losal and s.hisal;

select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s 
where e.sal between s.losal(+) and s.hisal(+);
-- e.sal >= s.losal(+) and e.sal <= s.hisal(+)
-- s.losal(+) <= e.sal and e.sal <= s.hisal(+)

-- right (outer) join
select e.empno, e.ename, e.sal, s.grade
from emp e
    right join salgrade s on e.sal between s.losal and s.hisal;

select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s 
where e.sal(+) between s.losal and s.hisal;

-- full (outer) join
select e.empno, e.ename, e.sal, s.grade
from emp e
    full join salgrade s on e.sal between s.losal and s.hisal;

select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s 
where e.sal between s.losal(+) and s.hisal(+)
union
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s 
where e.sal(+) between s.losal and s.hisal;
