/*
 * 예외(Exception) 처리:
 * 문법적으로 오류가 없는 문장을 실행할 때 발생할 수 있는 예외 상황을 처리해서
 * PL/SQL 프로시저(블록) 정상적으로 종료될 수 있도록 하는 것.
 */

set SERVEROUTPUT on;

-- 사용자 입력을 변수에 저장.
accept p_num1 prompt '첫번째 숫자 입력.';
accept p_num2 prompt '두번째 숫자 입력.';

declare
    v_num1 number := &p_num1;
    v_num2 number := &p_num2;
    v_result number;
begin
    dbms_output.put_line('v_num1 = ' || v_num1 || ', v_num2 = ' || v_num2);
    v_result := v_num1 / v_num2;
    dbms_output.put_line('v_num1 / v_num2 = ' || v_result);
end;
/

