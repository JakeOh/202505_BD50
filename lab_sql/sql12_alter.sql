/*
 * alter table: 테이블 (정의) 변경.
 * 1. 이름 변경: alter table ... rename ... to ...;
 * 2. 추가: alter table ... add ...;
 * 3. 삭제: alter table ... drop ...;
 * 4. 수정: alter table ... modify ...;
 */

-- 1. 이름 변경(rename): 테이블 이름, 컬럼 이름, 제약 조건 이름 변경.
-- (1) 테이블 이름 변경: ex_students 테이블을 students로 이름 변경.
-- ALTER TABLE table_name RENAME TO new_table_name;  
alter table ex_students rename to students;

-- (2) 테이블 컬럼 이름 변경: 
-- 테이블 students의 stu_no 컬럼을 student_id로 이름 변경.
-- ALTER TABLE table_name RENAME COLUMN column_name TO new_column_name;
alter table students rename column stu_no to student_id;

-- stu_name 컬럼을 student_name으로 이름 변경
alter table students rename column stu_name to student_name;

-- 테이블의 컬럼이름, null 가능 여부, 데이터 타입을 보여주는 오라클 명령어.
describe students;

-- (3) 제약조건 이름 변경
-- ALTER TABLE table_name RENAME CONSTRAINT constraint_name TO new_constraint_name;
-- 테이블 ex_emp1의 제약조건 SYS_C008351의 이름을 ex_emp1_pk_eno로 변경
alter table ex_emp1 rename constraint SYS_C008351 to ex_emp1_pk_eno;


-- 2. 추가(add): 컬럼, 제약조건 추가.
-- (1) 컬럼 추가
-- ALTER TABLE table_name ADD new_column data_type [default constraint];
-- 테이블 students에 department_id(정수 3자리) 컬럼을 추가.
alter table students add department_id number(3);
desc students; --> desc = describe

-- (2) 제약조건 추가
-- ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_detail;
-- 테이블 students에서 student_id 컬럼에 primary key 제약조건을 추가
--delete from students where student_id = 102032;
--commit;
alter table students add constraint students_pk primary key (student_id);

-- 테이블 students에서 student_name 컬럼에 not null 제약조건을 추가
alter table students add constraint students_nn_name check (student_name is not null);


-- 3. 삭제: 컬럼, 제약조건 삭제
-- (1) 컬럼 삭제
-- ALTER TABLE table_name DROP COLUMN column_name;
-- 테이블 students에서 birthday 컬럼 삭제
desc students;
alter table students drop column birthday;

-- (2) 제약조건 삭제
-- ALTER TABLE table_name DROP CONSTRAINT constraint_name;
-- 테이블 students에서 제약조건 students_nn_name를 삭제
alter table students drop constraint students_nn_name;

-- 오라클에서 테이블을 관리하기 위한 테이블(메타 테이블): user_tables, user_constraints
select table_name from user_tables;
select constraint_name from user_constraints;
select constraint_name from user_constraints 
where upper(constraint_name) like upper('students%');

-- 4. 수정: 컬럼 정의(데이터 타입, 기본값, null 여부, ...)를 수정.
-- ALTER TABLE table_name MODIFY column_name data_type [default, ...];
-- students 테이블에서 student_name 컬럼의 데이터 타입을
-- varchar2(10 char)에서 varchar2(40 char)로 변경 & NN 제약조건 추가.
alter table students modify student_name varchar2(40 char) not null;
desc students;

-- students 테이블에서 department_id 컬럼의 데이터 타입을 5자리 정수로 변경하면서
-- check (department_id between 10000 and 99999) 제약조건을 추가.
alter table students 
modify department_id number(5) 
    constraint students_ck_deptid check (department_id between 10000 and 99999);

desc students;

update students set department_id = 10000;
select * from students;

alter table students
add check (department_id is not null);


-- DDL(Data Definition Language): create, alter, truncate, drop
-- truncate table 테이블이름;  --> 테이블의 모든 행을 삭제하는 DDL
select * from students;
truncate table students;

-- drop table 테이블 이름;  --> 테이블을 삭제하는 DDL
drop table students;
