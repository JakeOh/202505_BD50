/*
 * Subprogram(서브 프로그램): 함수, 프로시저, 패키지, 트리거
 *
 * Function(함수)
 * - 특정 연산(코드 실행) 결과를 반환하는 서브 프로그램.
 * - PL/SQL의 함수는 반드시 값을 반환(return)해야 됨. 함수 안에는 return 문이 있어야 함.
 * - 함수는 select 문에서 호출할 수 있음.
 * - 함수는 PL/SQL 블록 안에서, 다른 함수 안에서, 프로시저 안에서 호출할 수 있음.
 * - 아규먼트(argument): 함수를 호출할 때 함수에게 전달하는 값(들).
 * - 파라미터(parameter): 매개변수. 아규먼트를 저장하기 위해서 함수 선언부에서 선언하는 변수.
 *
 * (문법)
 * CREATE [OR REPLACE] FUNCTION 함수이름 [(파라미터 선언)]
 *     RETURN 반환값_타입
 * IS
 *     변수, 상수 선언;
 * BEGIN
 *     함수 수행할 코드;
 *     RETURN 반환값;
 * [EXCEPTION 예외 처리 코드;]
 * END [함수이름];
 */

create or replace function adder(x number, y number)
    return number
is
    v_sum number;
begin
    v_sum := x + y;
    return v_sum;
end adder;
/

-- select 문에서 함수 호출
select adder(1, 2) from dual;
--> 각 아규먼트들은 파라미터가 선언된 순서대로 전달: 1 -> x, 2 -> y

-- 함수를 호출하면서 아규먼트가 전달될 파라미터 이름을 지정.
select adder(x => 10, y => 20) from dual;


create or replace function my_minus(x number, y number)
    return number
is
    -- 지역 변수를 선언하지 않더라도 IS 키워드는 반드시 사용.
begin
    return x - y;
end my_minus;
/

select my_minus(1, 2) from dual;
--> 아규먼트들이 파라미터 선언 순서대로 전달.

select my_minus(y => 1, x => 2) from dual;
--> 아규먼트들이 파라미터의 선언 순서와는 상관없이, 호출할 때 지정한 파라미터로 전달.

-- PL/SQL 블록에서 함수 호출
declare
    v_result number;
begin
    v_result := adder(11, 20);
    dbms_output.put_line('adder 결과 = ' || v_result);
    
    v_result := my_minus(10, 25);
    dbms_output.put_line('my_minus 결과 = ' || v_result);
    
    dbms_output.put_line('10 / 4 나머지 = ' || mod(10, 4));
end;
/


create or replace function my_mod(x number, y number)
    return number
is
    v_quotient number;  -- 몫
    v_remainer number;  -- 나머지
begin
    v_quotient := trunc(x / y);  -- floor(x / y)
    v_remainer := x - y * v_quotient;
    
    return v_remainer;
end my_mod;
/

select my_mod(10, 3) from dual;

