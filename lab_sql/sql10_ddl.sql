/*
 * SQL 문장의 종류:
 * 1. DQL(Data Query Language): select 문.
 * 2. DDL(Data Definition Language): create, alter, truncate, drop 문.
 * 3. DML(Data Manipulation Language): insert, update, delete 문.
 * 4. TCL(Transaction Control Language): commit, rollback 문.
 *
 * 테이블 생성:
 * create table 테이블이름 (
 *     컬럼이름 데이터타입 [[기본값] [제약조건]],
 *     ...
 * );
 *
 * 데이터 타입으로 사용되는 키워드는 데이터베이스 종류에 따라서 다를 수 있음.
 * Oracle 데이터 타입: number, varchar2(가변길이 문자열), date, timestamp,
 *   clob(character large object), blob(binary large object), ...
 */

/* 
 * 학생 테이블: ex_students
 * 컬럼: 
 * (1) stu_no: 아이디(학번). 숫자(6자리 정수).
 * (2) stu_name: 학생 이름. 문자열(최대 10글자).
 * (3) birthday: 생일. 날짜.
 */
create table ex_students (
    stu_no      number(6, 0),
    stu_name    varchar2(10 char),
    birthday    date
);


/*
 * 테이블에 행(row)을 추가(삽입):
 * insert into 테이블이름 (컬럼1, 컬럼2, ...) values (값1, 값2, ...);
 *
 * 테이블에 삽입하는 값들의 개수가 컬럼 개수와 같고, 값들의 순서가 테이블 컬럼 순서와 같으면,
 * insert into 테이블이름 values(값1, 값2, ...);
 */
 insert into ex_students (stu_no, stu_name, birthday)
 values (102030, '홍길동', '2001/01/01');
 
 insert into ex_students
 values (102031, '오쌤', '2000/05/19');

--insert into ex_students
--values (102032, 'Scott');
--> ORA-00947: 테이블의 컬럼은 3개인데, 삽입하는 값은 2개여서(값이 부족해서) 에러.

insert into ex_students (stu_no, stu_name)
values (102032, 'Scott');

-- insert into ex_students (stu_no) values (1234567);
--> ORA-01438: stu_no 컬럼은 6자리 정수인데 7자리 정수를 삽입하려고 해서 에러.

-- insert into ex_students (stu_name) values ('abcdefghijk');
--> ORA-12899: 문자열 길이가 너무 커서 에러.

insert into ex_students (stu_name, stu_no, birthday)
values ('홍길동', 123456, sysdate);

select * from ex_students;

commit; -- 테이블 변경 내용(insert, update, delete)을 데이터베이스에 영구 저장.


-- varchar2 타입의 단위: char vs byte(기본값)
-- 오라클에서 문자열을 저장할 때 인코딩 타입으로 'UTF-8'을 사용.
-- 영문, 숫자, 특수기호 -> 1 byte.
-- 한글 -> 3 byte.
create table ex_byte (
    col_name varchar2(5 byte)
);

insert into ex_byte values ('abc');

insert into ex_byte values ('홍');
-- insert into ex_byte values ('길동');
--> 한글 1글자를 저장하기 위해서 3 byte가 필요하기 때문에, 2글자는 6 byte가 됨.
--> varchar2 (5 byte) 타입에서 저장할 수 있는 범위를 넘음.

select * from ex_byte;
commit;


-- create table 연습:
-- emp와 똑같은 컬럼들을 갖는 ex_emp 테이블을 생성
create table ex_emp (
    empno       number(4, 0),
    ename       varchar2(10 byte),
    job         varchar2(9), /* varchar2(9 byte)와 동일 */
    mgr         number(4, 0),
    hiredate    date,
    sal         number(7, 2),
    comm        number(7, 2),
    deptno      number(2, 0)
);

-- dept -> ex_dept
create table ex_dept (
    deptno  number(2, 0),
    dname   varchar2(14),
    loc     varchar2(13)
);

-- salgrade -> ex_salgrade
create table ex_salgrade (
    grade   number,
    losal   number,
    hisal   number
);

-- bonus -> ex_bonus
create table ex_bonus (
    ename   varchar2(10),
    job     varchar2(9),
    sal     number,
    comm    number
);
