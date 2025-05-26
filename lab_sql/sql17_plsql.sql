/*
 * PL/SQL(Procedural Language extension to SQL)
 * SQL을 확장해서 
 * - 변수 선언, 사용
 * - 제어문(조건문, 반복문)
 * - 데이터 타입을 정의, 사용.
 * - 함수, 프로시져 정의, 사용.
 */
 
 set SERVEROUTPUT on;
 
 /* 출력문 */
 begin
    dbms_output.put_line('안녕하세요, PL/SQL!');
 end;
 /
 
 
 /* 변수 선언, 할당: var_name data_type := value; */
 declare
    v_empno number(4) := 7788;  -- 변수 선언 & 할당
    v_deptno number(2);  -- 변수 선언
 begin
    dbms_output.put_line('v_empno = ' || v_empno);
    
    v_deptno := 10;  -- (declare 구문에서 선언된) 변수에 값을 할당
    dbms_output.put_line('v_deptno = ' || v_deptno);
 end;
 /
 
 -- 변수를 테이블의 특정 컬럼 타입으로 선언: table.column%type
 declare
    -- v_dept_no number(2) := 10;
    v_dept_no dept.deptno%type := 10;
    v_dept_name dept.dname%type;
 begin
    select dname
        into v_dept_name
        from dept
        where deptno = v_dept_no;
        
    dbms_output.put_line('v_dept_name = ' || v_dept_name);
 end;
 /
 
 -- 변수 선언: emp 테이블의 empno, ename, job과 같은 타입의 변수를 선언.
 -- empno에는 7788을 할당.
 -- empno가 7788인 직원의 이름과 업무를 검색해서 출력.
 declare
    v_empno     emp.empno%type := 7788;
    v_ename     emp.ename%type;
    v_job       emp.job%type;
 begin
    select ename, job
        into v_ename, v_job
        from emp
        where empno = v_empno;
    
    dbms_output.put_line('v_ename: ' || v_ename || ', v_job: ' || v_job);
 end;
 /
 
 
 -- 변수를 테이블의 1개 행(row)의 데이터를 저장하는 타입으로 선언: table%rowtype
 declare
    v_deptno    number(2) := 10;
    v_row       dept%rowtype;  -- dept 테이블의 1개 행을 저장하기 위한 변수.
 begin
    select * into v_row
        from dept
        where deptno = v_deptno;
        
    dbms_output.put_line(v_row.deptno 
                        || ' : ' 
                        || v_row.dname 
                        || ' : ' 
                        || v_row.loc);
 end;
 /
 