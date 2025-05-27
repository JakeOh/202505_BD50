/*
 * 예외(Exception) 처리:
 * 문법적으로 오류가 없는 문장을 실행할 때 발생할 수 있는 예외 상황을 처리해서
 * PL/SQL 프로시저(블록) 정상적으로 종료될 수 있도록 하는 것.
 * (문법)
 * DECLARE
 *     ...
 * BEGIN
 *     ...
 * EXCEPTION
 *     WHEN 예외이름1 THEN
 *         (예외1)이 발생했을 때 처리하는 문장;
 *     WHEN 예외이름2 THEN
 *         (예외2)이 발생했을 때 처리하는 문장;
 *     ...
 *     WHEN OTHERS THEN
 *         나머지 모든 예외 상황일 때 실행할 문장;
 * END;
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
exception
    when zero_divide then
        dbms_output.put_line('0으로 나눌 수는 없습니다.');
    when others then
        dbms_output.put_line('예외 발생');
end;
/
--> 사용자가 입력한 두번째 숫자(나누는 수)에 따라서 예외가 발생할 수도 있음.

/* 예외 처리 구문에서 사용할 수 있는 정보:
 * - SQLCODE: 예외 코드.
 * - SQLERRM: 에러 메시지.
 * - DBMS_UTILITY.FORMAT_ERROR_BACKTRACE: 에러가 발생한 위치.
 */
declare
    v_divisor number := 0;
    v_result number;
begin
    v_result := 100 / v_divisor;
    dbms_output.put_line('v_result = ' || v_result);
exception
    when others then
        dbms_output.put_line('SQLCODE = ' || sqlcode);
        dbms_output.put_line('SQLERRM = ' || sqlerrm);
        dbms_output.put_line('BACKTRACE = ' || dbms_utility.format_error_backtrace);
end;
/
