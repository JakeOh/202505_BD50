 /*
  * 패키지(Package)
  * - 타입 또는 서브 프로그램(함수, 프로시저)들을 그룹화하기 위해서 사용.
  * - 유사한 또는 관련된 기능들을 패키지로 묶음.
  * - 패키지는 두 부분으로 구성.
  *   (1) 패키지 사양: 타입 선언. 함수 또는 프로시저의 선언만 있고, 구현부가 없음.
  *   (2) 패키지 몸체(body): 함수 또는 프로시저의 구현부(IS-BEGIN-END)를 작성.
  *
  * (문법) 패키지 사양
  * CREATE [OR REPLACE] PACKAGE 패키지_이름
  * IS
  *     -- 타입 선언(레코드, 컬렉션)
  *     -- 함수, 프로시저의 선언부
  * END [패키지_이름];
  *
  * (문법) 패키지 몸체
  * CREATE [OR REPLACE] PACKAGE BODY 패키지_이름
  * IS
  *     -- 패키지 사양에서 선언된 함수 또는 프로시저를 구현
  * END [패키지_이름];
  */
 begin
    dbms_output.put('Hello');
    dbms_output.put('안녕');
    dbms_output.put_line('SQL');
    dbms_output.put_line('PL/SQL');
    
    print_line('value() 난수: ' || dbms_random.value());
    print_line('value() 난수: ' || dbms_random.value(1, 10));
    print_line('random() 난수: ' || dbms_random.random());
 end;
 /
 
 -- 패키지 사양 작성.
 create or replace package my_pkg
 is
    -- 레코드 선언
    type rec_emp is record (
        empno   emp.empno%type,
        ename   emp.ename%type,
        job     emp.job%type,
        sal     emp.sal%type,
        dname   dept.dname%type
    );
    
    -- 연관 배열 선언
    type itab_emp is table of rec_emp index by pls_integer;
    
    -- 함수 선언
    -- 사번을 주면, 직원 레코드를 리턴.
    function get_emp_record(p_empno emp.empno%type) 
        return rec_emp;
    
    -- 부서 번호를 주면, 그 부서에서 근무하는 직원들의 레코드를 리턴.
    function get_emp_list(p_deptno emp.deptno%type) 
        return itab_emp;
    
 end my_pkg;
 /
 
 -- 패키지 몸체 작성.
 create or replace package body my_pkg
 is
    -- get_emp_record 함수 구현
    function get_emp_record(p_empno emp.empno%type)
        return rec_emp
    is
        v_emp rec_emp;  -- 파라미터 p_empno를 갖는 직원 정보를 저장하기 위해서.
    begin
        select e.empno, e.ename, e.job, e.sal, d.dname
            into v_emp
            from emp e
                join dept d on e.deptno = d.deptno
            where e.empno = p_empno;
        
        return v_emp;
    end get_emp_record;
    
    -- get_emp_list 함수 구현
    function get_emp_list(p_deptno emp.deptno%type)
        return itab_emp
    is
        v_emp_list itab_emp;  -- 부서에 근무하는 직원들 레코드를 저장, 리턴.
        v_idx pls_integer := 1;  -- 연관 배열의 인덱스.
        
        cursor cursor_emp_list is
            select e.empno, e.ename, e.job, e.sal, d.dname
            from emp e
                join dept d on e.deptno = d.deptno
            where e.deptno = p_deptno
            order by e.empno;
    begin
        for r in cursor_emp_list loop
            v_emp_list(v_idx) := r;
            v_idx := v_idx + 1;
        end loop;
        
        return v_emp_list;
    end get_emp_list;
 end my_pkg;
 /
 
 -- 패키지에서 선언한 타입, 함수, 프로시저 사용하기
 -- 패키지_이름.타입, 패키지_이름.함수, 패키지_이름.프로시저
 declare
    v_emp       my_pkg.rec_emp;
    v_emp_list  my_pkg.itab_emp;
 begin
    v_emp := my_pkg.get_emp_record(7788);
    print_line('사번: ' || v_emp.empno 
                || ', 이름: ' || v_emp.ename
                || ', 업무: ' || v_emp.job
                || ', 급여: ' || v_emp.sal
                || ', 부서: ' || v_emp.dname);
    
    v_emp_list := my_pkg.get_emp_list(30);
    for i in 1 .. v_emp_list.count loop
        print_line('사번: ' || v_emp_list(i).empno 
                    || ', 이름: ' || v_emp_list(i).ename
                    || ', 업무: ' || v_emp_list(i).job
                    || ', 급여: ' || v_emp_list(i).sal
                    || ', 부서: ' || v_emp_list(i).dname);
    end loop;
 end;
 /
 