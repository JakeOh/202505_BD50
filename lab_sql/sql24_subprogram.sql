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

set serveroutput on;

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

select my_mod(10, 3), my_mod(11, 3), my_mod(12, 3) from dual;

-- 함수 이름: get_dept_loc
-- 기능: 부서 번호가 주어지면 부서의 위치를 리턴하는 함수.
create or replace function get_dept_loc(p_no number) 
    return varchar2
is
    -- select 결과 행의 개수를 저장하기 위한 변수
    v_count number := 0;
    
    -- 부서번호 p_no에 해당하는 부서 위치를 저장하기 위한 변수
    v_dept_loc dept.loc%type;
begin
    select count(loc) into v_count
        from dept
        where deptno = p_no;

    if v_count = 0 then
        v_dept_loc := '-----';
    else
        -- 묵시적 커서(implicit cursor)
        select loc into v_dept_loc
            from dept
            where deptno = p_no;
    end if;

    return v_dept_loc;
end get_dept_loc;
/

select get_dept_loc(10), get_dept_loc(40), get_dept_loc(50)
from dual;

declare
    -- 함수 get_dept_loc의 반환값을 저장하기 위한 변수
    v_result varchar2(20);
begin
    v_result := get_dept_loc(20);
    dbms_output.put_line('20번 부서의 위치는 ' || v_result);
    
    v_result := get_dept_loc(30);
    dbms_output.put_line('30번 부서의 위치는 ' || v_result);
end;
/

select * from emp where deptno = 20;

select
    deptno, dname, loc,
    (select min(sal) from emp where deptno = 30) as "MIN_SAL",
    (select max(sal) from emp where deptno = 30) as "MAX_SAL"
from dept
where deptno = 30;

-- get_dept_min_sal: 부서 번호가 주어지면 그 부서의 급여 최솟값을 리턴하는 함수.
create or replace function get_dept_min_sal(p_no number)
    return number
is
    v_min_sal number;
begin
    select min(sal) into v_min_sal
        from emp
        where deptno = p_no;

    if v_min_sal is null then
        v_min_sal := 0;
    end if;

    return v_min_sal;
end get_dept_min_sal;
/

-- get_dept_max_sal: 부서 번호가 주어지면 그 부서의 급여 최댓값을 리턴하는 함수.
create or replace function get_dept_max_sal(p_no number)
    return number
is
    v_max_sal number;
begin
    select max(sal) into v_max_sal
        from emp
        where deptno = p_no;

    if v_max_sal is null then
        v_max_sal := 0;
    end if;

    return v_max_sal;
end get_dept_max_sal;
/

select d.*,
    get_dept_min_sal(30),
    get_dept_max_sal(30)
from dept d
where deptno = 30;


-- 파라미터를 갖지 않는 함수 선언(정의)할 때는 "(파라미터 선언)"을 사용하지 않음.
create or replace function get_emp_count
    return number
is
    v_count number;
begin
    select count(*) into v_count
        from emp;
        
    return v_count;
end get_emp_count;
/

-- 파라미터를 갖지 않는 함수를 호출할 때는, "함수이름()" 또는 "함수이름" 호출 가능.
select get_emp_count(), get_emp_count
from dual;


/*
 * Procedure(프로시저)
 * - 특정 작업을 수행하는 서브 프로그램. 값을 반환하지 않는 서브 프로그램.
 * - SQL 문 안에서 호출할 수 없음. select 프로시저 from dual; 은 불가!
 * - EXECUTE 프로시저; 형식으로 호출할 수 있음.
 * - PL/SQL 블록 안에서는 호출 가능.
 * - 프로시저도 return 문장을 사용할 수 있음. (예) return;
 * - 프로시저에서 return 문장의 의미는 프로시저를 종료한다는 의미.
 * (문법)
 * CREATE [OR REPLACE] PROCEDURE 프로시저_이름 [(파라미터 선언, ...)]
 * IS
 *     -- 프로시저가 사용할 지역 변수 선언.
 * BEGIN
 *     -- 프로시저 해야할 일(코드)
 * [EXCEPTION 예외처리 코드;]
 * END [프로시저_이름];
 */
 
 -- 파라미터를 갖지 않는 프로시저
 create or replace procedure get_emp_scott
 is
    v_empno number := 7788;  -- 변수 선언 & 값을 할당.
    v_ename varchar2(10);  -- 변수 선언.
 begin
    v_ename := 'Scott';
    dbms_output.put_line(v_ename || '의 사번은 ' || v_empno || '입니다.');
    return;  --> 프로시저를 종료한다는 의미. 생략 가능.
 end get_emp_scott;
 /
 
 -- 프로시저를 단독으로 실행.
 execute get_emp_scott;
 execute get_emp_scott();
 
 -- PL/SQL 블록 안에서 프로시저 실행.
 begin
    get_emp_scott();
    get_emp_scott;
 end;
 /
 