/*
 * 제약조건(Contraints)
 * 1. primary key(PK, 고유키):
 *    - 테이블에서 유일한 1개의 행(row)을 선택할 수 있는 컬럼(들).
 *    - PK인 컬럼(들)은 null이 될 수 없고, 중복된 값을 가질 수 없음.
 * 2. not null(NN)
 *    - 반드시 값을 가져야 하는 컬럼. null이 될 수 없는 컬럼.
 * 3. unique
 *    - 중복된 값을 가질 수 없는 컬럼.
 *    - null은 여러 개가 있을 수도 있음.
 * 4. check
 *    - 컬럼의 값을 조건을 만족하는 값들로만 제한.
 *    - not null 제약조건(check column is not null)은 check 제약조건의 특수한 경우.
 * 5. foreign key(FK, 외래키)
 *    - 다른 테이블의 PK를 참조하는 컬럼.
 *    - (예) DEPT 테이블의 DEPTNO 컬럼 - PK, EMP 테이블의 DEPTNO 컬럼 - FK
 *    - FK 제약조건이 있는 컬럼에는 연관 테이블의 PK에 있는 값들로만 insert를 할 수 있음.
 */

-- 테이블을 생성할 제약조건 만들기 1: 제약조건의 이름을 설정하지 않는 경우.
-- 오라클에서 제약조건의 이름을 자동으로 만들어줌. (예) SYS_C001234
create table ex_emp1 (
    eno     number(4, 0) primary key,
    ename   varchar2(20 byte) not null,
    email   varchar2(20 byte) unique,
    salary  number(7, 2) check (salary >= 0),
    memo    varchar2(1000 byte)
);

insert into ex_emp1
values (1001, '홍길동', 'hgd@itwill.com', 350, '신입사원');

select * from ex_emp1;

--insert into ex_emp1 (eno, ename)
--values (1001, '홍길동');
--> 무결성 제약 조건(PK 제약조건)을 위배: 이미 같은 값 1001이 테이블에 있기 때문에.

insert into ex_emp1 (eno, ename)
values (1002, '홍길동');

--insert into ex_emp1 (eno, ename) values (null, '홍길동');
--> PK 컬럼에는 null을 insert할 수 없음.

--insert into ex_emp1 (eno, ename) values (1003, null);
--> NN 제약조건 위배

--insert into ex_emp1 (eno, ename, email)
--values (1004, '오쌤', 'hgd@itwill.com');
--> 무결성 제약 조건(unique 제약조건) 위배: email은 중복된 값을 삽입할 수 없음.

insert into ex_emp1 (eno, ename, email)
values (1004, '오쌤', 'jake@itwill.com');

--insert into ex_emp1 (eno, ename, salary)
--values (1005, 'Scott', -500);
--> check 제약조건 위배

-- 제약 조건을 사용하는 이유: 잘못된 값들이 insert되는 것을 막기 위해서.
-- 데이터의 무결성을 유지하기 위해서.

update ex_emp1
set email = 'hgd@gmail.com', salary = 300
where eno = 1002;

select * from ex_emp1;
