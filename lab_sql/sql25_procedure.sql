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
 
 -- 파라미터를 갖는 프로시저 선언
 create or replace procedure insert_new_dept(
        p_deptno number,   -- p_deptno dept.deptno%type,
        p_dname varchar2,  -- p_dname dept.dname%type,
        p_loc varchar2     -- p_loc dept.loc%type
 )
 is
    v_count number := 0;
 begin
    if p_deptno is null then
        dbms_output.put_line('부서번호 deptno는 null이 될 수 없습니다.');
        return;  -- 프로시저 종료
    end if;
 
    select count(*) into v_count
        from dept
        where deptno = p_deptno;
    
    if v_count != 0 then
        dbms_output.put_line('부서 번호 deptno가 이미 존재합니다.');
        return;  -- 프로시저를 종료
    end if;
 
    -- 묵시적 커서를 사용한 insert
    insert into dept 
        values (p_deptno, p_dname, p_loc);
    
    dbms_output.put_line(sql%rowcount || '개 행이 삽입됨.');
 end insert_new_dept;
 /
 
 execute insert_new_dept(null, 'Database', 'Seoul');
 select * from dept;
 
 -- 부서 번호를 전달받아서 해당 부서를 삭제하는 프로시저
 create or replace procedure delete_dept(p_deptno number)
 is
 begin
    delete from dept
        where deptno = p_deptno;
    dbms_output.put_line(sql%rowcount || '개 행이 삭제됨.');
 end delete_dept;
 /
 
 execute delete_dept(50);
 select * from dept;
 
 create or replace procedure print_line(msg varchar2)
 is
 begin
    dbms_output.put_line(msg);
 end print_line;
 /
 
 execute print_line('안녕하세요' || ' 여러분!');

/*
 * 파라미터 선언에서 사용할 수 있는 키워드:
 * - IN: 호출하는 곳에서 값을 전달할 때. 생략 가능.
 * - OUT: 함수/프로시저가 호출한 곳으로 값을 전달할 때.
 * - IN OUT: 호출하는 곳에서 아규먼트를 전달할 수도 있고, 호출한 곳으로 값을 내보낼 수도 있음.
 * (문법) 파라미터_이름 [IN | OUT | IN OUT] 파라미터_타입 [:= 기본값]
 */

create or replace procedure get_emp_name_sal(
        p_empno in number,  -- 키워드 in은 생략 가능
        p_ename out varchar2,
        p_sal out number
)
is
begin
    select ename, sal 
        into p_ename, p_sal
        from emp
        where empno = p_empno;
end get_emp_name_sal;
/

declare
    v_empno number := 7900;  -- 프로시저에게 사번으로 전달할 변수
    v_ename varchar2(20);  -- 사원 이름을 프로시저로부터 전달받기 위한 변수
    v_sal number;  -- 급여를 프로시저로부터 전달받기 위한 변수
begin
    print_line('호출 전 v_empno = ' || v_empno);
    print_line('호출 전 v_ename = ' || v_ename);
    print_line('호출 전 v_sal = ' || v_sal);
    
    get_emp_name_sal(v_empno, v_ename, v_sal);
    
    print_line('호출 후 v_empno = ' || v_empno);
    print_line('호출 후 v_ename = ' || v_ename);
    print_line('호출 후 v_sal = ' || v_sal);
end;
/

create or replace procedure double_number(p_num in out number)
is
begin
    p_num := p_num * 2;
end double_number;
/

declare
    v_number number := 123;
begin
    print_line('호출 전 v_number = ' || v_number);
    
    double_number(v_number);
    
    print_line('호출 후 v_number = ' || v_number);
end;
/
