/*
 * PL/SQL(Procudural Language extension to SQL)
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
    v_deptno number(20);  -- 변수 선언
 begin
    dbms_output.put_line('v_empno = ' || v_empno);
    
    v_deptno := 10;  -- (declare 구문에서 선언된) 변수에 값을 할당
    dbms_output.put_line('v_deptno = ' || v_deptno);
 end;
 /
 