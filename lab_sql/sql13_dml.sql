/*
 * DML(Data Manipulation Language): insert, update, delete
 * DQL(Data Query Language): select
 * TCL(Transaction Control Language): commit, rollback
 */
 
 -- INSERT INTO table_name VALUES (value, ...);
 -- 삽입하려는 값의 개수는 컬럼의 개수와 같아야 하고, 
 -- 값의 순서는 테이블에서 컬럼들의 순서와 같아야 함.
 -- bonus 테이블에 이름, 업무, 급여, 수당을 삽입(insert).
 insert into bonus values ('오쌤', '강의', 100, 10);
 
 -- INSERT INTO table_name (column_name, ...) VALUES (value, ...);
 -- bonus 테이블에 이름, 급여를 삽입(insert).
 insert into bonus (ename, sal) values ('홍길동', 150);
 
 -- insert into ~ values (); 문장은 1개의 행을 삽입(insert)함.
 -- insert ~ select 문장: 다른 테이블에서 검색한 행(들)을 테이블에 삽입(insert).
 -- insert 문장에서 values 구문을 select 구문으로 대체.
 
 -- emp 테이블에서 30번 부서 직원들의 이름, 업무, 급여, 수당을 bonus 테이블 삽입.
 insert into bonus (ename, job, sal, comm)
 select ename, job, sal, comm
    from emp
    where deptno = 30;
 
 -- 급여가 3000 이상인 직원들의 이름, 업무, 급여, 수당을 bonus 테이블에 삽입.
 insert into bonus
 select ename, job, sal, comm
    from emp
    where sal >= 3000;
 
select * from bonus;

commit;


-- update 문장: 테이블의 특정 컬럼의 값(들)을 수정(업데이트).
-- UPDATE table_name 
-- SET column_name = value, ... 
-- WHERE condition_expression;
-- where 절은 생략 가능. where 절을 생략하면 테이블의 모든 행들이 업데이트됨.

--create table emp_copy 
--as select * from emp;
select * from emp_copy;

-- 사번이 7369 직원의 급여를 1000, 수당을 100으로 업데이트
update emp_copy
set sal = 1000, comm = 100
where empno = 7369;

commit;  --> 직전 commit 이후의 변경된 모든 내용을 데이터베이스에 영구 저장.

update emp_copy set sal = 1000;
select * from emp_copy;  --> 모든 행의 sal 값이 변경됨.

rollback; --> 직전 commit 이후의 변경된 내용을 원래대로 복원(원복).
select * from emp_copy;  --> update 하기 전의 내용을 되돌리기.

-- insert, update 연습
-- emp_copy 테이블에 사번(1004), 이름(오쌤), 부서번호(50) 직원 정보를 insert.
insert into emp_copy (empno, ename, deptno)
values (1004, '오쌤', 50);

select * from emp_copy;
commit;

-- 사번 1004인 직원의 업무를 MANAGER, 급여를 6000, 입사날짜를 '2025/05/12'로 업데이트.
update emp_copy
set job = 'MANAGER', sal = 6000, hiredate = to_date('2025/05/12', 'YYYY/MM/DD')
where empno = 1004;

commit;

-- 1982/01/01 이후에 입사한 직원들의 급여를 10% 인상.
update emp_copy
set sal = sal * 1.1
where hiredate >= to_date('1982-01-01', 'YYYY-MM-DD');

commit;

-- ACCOUNTING 부서에서 일하는 직원들의 급여를 10% 인상.
update emp_copy
set sal = sal * 1.1
where deptno = (
    select deptno from dept where dname = 'ACCOUNTING'
    );

commit;

select distinct d.deptno
from emp_copy e
    join dept d on e.deptno = d.deptno
where d.dname = 'ACCOUNTING';

-- salgrade가 1인 직원들의 급여를 25% 인상.
update emp_copy
set sal = sal * 1.25  /* sal = sal + sal * 0.25 */
where sal between (select losal from salgrade where grade = 1)
    and (select hisal from salgrade where grade = 1);

rollback;

select e.empno
from emp_copy e
    join salgrade s on e.sal between s.losal and s.hisal
where s.grade = 1;

update emp_copy
set sal = sal * 1.25
where empno in (
    select e.empno
    from emp_copy e
        join salgrade s on e.sal between s.losal and s.hisal
    where s.grade = 1
);

commit;