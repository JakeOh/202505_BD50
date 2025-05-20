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
commit;


-- 테이블을 생성할 때 제약조건 만들기 2: 제약조건의 이름을 설정.
-- (1) 컬럼 정의(선언)에서 제약조건 이름 설정
create table ex_emp2 (
    id      number(4) 
            constraint ex_emp2_pk_id primary key,
    name    varchar2(20) 
            constraint ex_emp2_nn_name not null,
    email   varchar2(100) 
            constraint ex_emp2_uq_email unique,
    salary  number(7, 2) 
            constraint ex_emp2_ck_salary check (salary >= 0),
    memo    varchar2(1000)
);

-- (2) 컬럼 정의(선언) 따로, 제약조건 설정 따로.
create table ex_emp3 (
    /* 컬럼 정의(선언): 컬럼 이름, 데이터 타입 */
    id      number(4),
    name    varchar2(10),
    email   varchar2(100),
    salary  number(7, 2),
    memo    varchar2(1000),
    
    /* 제약조건 설정: 제약조건 이름, 내용 */
    constraint ex_emp3_pk_id primary key (id),
    constraint ex_emp3_nn_name check (name is not null), /* 주의: not null (column) 형식은 불가 */
    constraint ex_emp3_uq_email unique (email),
    constraint ex_emp3_ck_salary check (salary >= 0)
);

insert into ex_emp3
values (1234, null, 'hgd@test.com', 100, '테스트'); --> check not null 위배


-- Foreign Key: (다른) 테이블의 PK를 참조하는 제약조건.
-- (1) PK를 갖는 테이블을 먼저 생성, 그 PK를 참조하는 FK를 갖는 테이블을 생성.
-- (2) 테이블들을 생성한 후, 필요한 제약조건(들)을 나중에 추가.

create table ex_dept1 (
    /* 컬럼 선언 */
    deptno  number(2),
    dname   varchar2(20) not null,
    /* 제약조건 선언 */
    constraint ex_dept1_pk_deptno primary key (deptno)
);

create table ex_emp4 (
    /* 컬럼 선언 & 제약조건 설정 */
    empno   number(4)
            constraint ex_emp4_pk_empno primary key,
    ename   varchar2(20) not null,
    deptno  number(2)
            constraint ex_emp4_fk_deptno references ex_dept1 (deptno)
);

insert into ex_emp4
values (1100, '홍길동', 10);
--> ex_dept1 테이블에 deptno=10인 자료(레코드)가 없기 때문에 insert가 실패!

insert into ex_emp4 (empno, ename)
values (1100, '홍길동');
--> FK가 설정된 컬럼은 null은 될 수 있음.

insert into ex_dept1 values (11, 'IT');
insert into ex_dept1 values (12, 'HR');
select * from ex_dept1;

insert into ex_emp4
values (1200, '오쌤', 11);
--> ex_dept1 테이블에 deptno=11인 자료가 있기 때문에 insert가 성공.

select * from ex_emp4;

create table ex_emp5 (
    /* 컬럼 선언 */
    empno   number(4),
    ename   varchar2(20) not null,
    deptno  number(2),
    
    /* 제약조건 선언 */
    constraint ex_emp5_pk_empno primary key (empno),
    constraint ex_emp5_fk_deptno foreign key (deptno) references ex_dept1 (deptno)
);


-- 기본값을 갖는 컬럼
create table ex_test (
    id              number(6)
                    constraint ex_test_pk_id primary key,
    content         varchar2(1000) not null,
    view_cnt        number(6)
                    default 0 /* 기본값 설정 */
                    constraint ex_test_ck_view_cnt check (view_cnt >= 0),
    created_time    date
                    default sysdate /* 기본값 설정 */
);

insert into ex_test (id, content)
values (2, 'Hello, SQL!');
--> default 값이 설정된 컬럼에 값을 insert하지 않는 경우에는 기본값이 자동으로 insert됨.

insert into ex_test 
values (3, '컨텐트 입력', 100, '2025/05/19');
--> default 값이 설정된 컬럼 값을 insert하면, 기본값은 무시하고 삽입하려는 값이 insert됨.

select * from ex_test;
