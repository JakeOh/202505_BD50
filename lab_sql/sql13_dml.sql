/*
 * DML(Data Manipulation Language): insert, update, delete
 * DQL(Data Query Language): select
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