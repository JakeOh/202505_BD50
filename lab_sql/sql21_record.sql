/*
 * 레코드(record)
 * - 데이터 타입이 다른 여러 개의 값들을 하나의 변수에 저장하기 위해서 정의하는 데이터 타입.
 * - 테이블의 행(row).
 * - 선언한 레코드의 이름은 변수를 선언할 때 변수 타입으로 사용할 수 있음.
 * (문법)
 * TYPE 레코드_이름 IS RECORD (
 *     변수_이름  변수타입 [NOT NULL] [:= 기본값],
 *     ...
 * );
 */

set SERVEROUTPUT on;

-- 레코드를 정의할 수 없다면
declare
    -- DEPT 테이블에서 1개 행의 정보(레코드)를 저장하기 위해서
    v_dept_no number;  -- 부서 번호
    v_dept_name varchar2(20);  -- 부서 이름
    v_location varchar2(20);  -- 부서 위치
begin
    select deptno, dname, loc
        into v_dept_no, v_dept_name, v_location
        from dept
        where deptno = 10;
        
    dbms_output.put_line(v_dept_no || ' : '
                        || v_dept_name || ' : '
                        || v_location);
end;
/

-- 레코드를 정의하고 사용하기
declare
    -- 레코드 선언(정의)
    type rec_dept is record (
        dept_no number(2) not null := 99,
        dept_name varchar2(20),
        location varchar2(20)
    );
    
    -- 선언한 레코드 타입으로 변수를 선언
    v_dept rec_dept;
begin
    -- select 문장에서 레코드 이용하기
    select deptno, dname, loc
        into v_dept
        from dept
        where deptno = 20;
        
    -- 레코드의 원소(아이템)들을 참조: 레코드이름.변수이름
    dbms_output.put_line(v_dept.dept_no);
    dbms_output.put_line(v_dept.dept_name);
    dbms_output.put_line(v_dept.location);
end;
/

declare
    v_name1 varchar2(100);
    v_phone1 varchar2(100);
    v_contact_name varchar2(100);
    v_contact_phone varchar2(100);
begin
    v_name1 := '홍길동';
    v_phone1 := '010-1234-5678';
    v_contact_name := '오쌤';
    v_contact_phone := '010-0000-0000';
end;
/

declare
    -- 연락처 레코드 선언
    type rec_contact is record (
        name varchar2(100),
        phone varchar2(100),
        birthday date
    );
    
    -- 레코드 타입 변수 선언
    v_contact1 rec_contact;
    v_contact2 rec_contact;
begin
    -- 레코드 타입 변수에 값을 할당.
    v_contact1.name := '홍길동';
    v_contact1.phone := '010-1234-5678';
    v_contact1.birthday := sysdate;
    
    -- 레코드에 저장된 값들을 출력.
    dbms_output.put_line(v_contact1.name || ', '
                        || v_contact1.phone || ', '
                        || v_contact1.birthday);
    
    v_contact2.name := '오쌤';
    v_contact2.phone := '010-0000-0000';
    dbms_output.put_line(v_contact2.name || ', '
                        || v_contact2.phone || ', '
                        || v_contact2.birthday);
end;
/

-- rec_emp 이름의 레코드 선언
-- 레코드의 필드(아이템): 사번(empno), 이름(ename), 업무(job), 급여(sal)
-- 레코드 타입 rec_emp으로 변수 선언
-- 사번이 7788인 사원의 사번, 이름, 업무, 급여를 레코드 타입 변수에 저장.
-- 레코드 타입 변수의 내용을 출력.
declare
    type rec_emp is record (
        empno emp.empno%type,
        ename emp.ename%type,
        job emp.job%type,
        sal emp.sal%type
    );
    
    v_emp rec_emp;
begin
    select empno, ename, job, sal
        into v_emp
        from emp
        where empno = 7788;
        
    dbms_output.put_line(v_emp.empno || ', '
                        || v_emp.ename || ', '
                        || v_emp.job || ', '
                        || v_emp.sal);
end;
/

-- 레코드를 사용한 insert, update를 하기 위한 임시 테이블 생성
create table dept_temp
as
select * from dept;

select * from dept_temp;

declare
    -- dept_temp 테이블 형태의 레코드를 선언(정의).
    type rec_dept is record (
        no dept_temp.deptno%type,
        name dept_temp.dname%type,
        loc dept_temp.loc%type
    );
    
    -- rec_dept 타입의 변수 선언
    v_dept_ins rec_dept;  -- 테이블에 insert할 레코드
    v_dept_sel rec_dept;  -- 테이블에서 select한 정보를 저장할 레코드
begin
    -- insert할 레코드를 생성
    v_dept_ins.no := 99;
    v_dept_ins.name := 'DB';
    v_dept_ins.loc := 'Seoul';
    
    -- insert DML을 실행
    insert into dept_temp 
        values v_dept_ins;
        -- values (v_dept_ins.no, v_dept_ins.name, v_dept_ins.loc);
    
    dbms_output.put_line(SQL%ROWCOUNT || '개 행이 삽입됨');
    
    -- select 문을 실행
    select * into v_dept_sel
        from dept_temp
        where deptno = 99;
    
    dbms_output.put_line(v_dept_sel.no || ', '
                        || v_dept_sel.name || ', '
                        || v_dept_sel.loc);

    -- update를 하기 위해서 v_dept_sel의 일부 필드(값)을 변경
    v_dept_sel.name := 'Database';
    v_dept_sel.loc := '서울';
    
    -- update DML 문장을 실행.
    update dept_temp
        set row = v_dept_sel
        /* set deptno = v_dept_sel.no, dname = v_dept_sel.name, loc = v_dept_sel.loc */
        where deptno = v_dept_sel.no;
    
    dbms_output.put_line(SQL%ROWCOUNT || '개 행이 업데이트됨.');
end;
/

select * from dept_temp;

drop table dept_temp;
