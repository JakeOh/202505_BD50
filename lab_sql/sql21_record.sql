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

