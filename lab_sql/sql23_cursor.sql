/*
 * Cursor(커서):
 * SQL 문장을 처리한 결과를 담고 있는 메모리 영역.
 * select 문장이면 테이블에서 검색한 행과 열, 
 * DML(insert, update, delete) 문장이면 삽입/수정/삭제된 행의 개수가 처리 결과.
 * 커서의 종류:
 * (1) 명시적 커서(explicit cursor)
 * (2) 암묵적 커서(implicit cursor)
 */

set SERVEROUTPUT on;

/*
 * 명시적 커서 사용 순서:
 * 1. 선언(declaration): CURSOR 커서_이름 [파라미터 리스트] IS SQL문장;
 * 2. open: 커서 열기
 * 3. fetch: 커서에서 데이터를 읽어옴
 * 4. close: 커서 닫기
 */

-- 1개 행을 반환하는 명시적 커서 사용하기
declare
    -- Step 1. 선언
    cursor c is
        select * from dept where deptno = 10;
        
    -- SQL 실행 결과(커서의 내용)을 저장할 변수 선언
    v_row dept%rowtype;
begin
    -- Step 2. open
    open c;
    
    -- Step 3. fetch
    fetch c into v_row;
    dbms_output.put_line(v_row.deptno || ' : '
                        || v_row.dname || ' : '
                        || v_row.loc);
    
    -- Step 4. close
    close c;

end;
/

-- 여러 개의 행들을 반환하는 커서 예제
declare
    -- Step 1. 선언
    cursor c is
        select * from dept;

    -- 1개 행을 저장할 수 있는 변수 선언
    v_row dept%rowtype;
begin
    -- Step 2. open
    open c;
    
    loop
        -- Step 2 fetch
        fetch c into v_row;
        
        -- 반복문(loop)의 종료 조건
        exit when c%notfound;  -- 커서에 더이상 fetch 할(읽어 올) 결과가 없을 때
        
        dbms_output.put_line(v_row.deptno || ' : '
                            || v_row.dname || ' : '
                            || v_row.loc);
    end loop;
    
    -- Step 4. close
    close c;
end;
/

-- 파라미터를 갖는 커서 선언 예제
declare
    -- 커서 선언: CURSOR 커서_이름(파라미터_이름 파라미터_타입, ...) IS SQL문;
    cursor c(p_no dept.deptno%type) is
        select * from dept where deptno = p_no;
    
    -- 행 1개 데이터를 저장하기 위한 변수.
    v_row dept%rowtype;
begin
    -- 파라미터를 갖는 커서 열기(open)
    open c(10);
    -- fetch
    fetch c into v_row;
    dbms_output.put_line(v_row.deptno || ' : '
                        || v_row.dname || ' : '
                        || v_row.loc);
    -- 커서 닫기(close)
    close c;
    
    open c(20);
    fetch c into v_row;
    dbms_output.put_line(v_row.deptno || ' : '
                        || v_row.dname || ' : '
                        || v_row.loc);
    close c;
end;
/

-- 명시적 커서와 FOR-IN LOOP(반복문)
-- FOR 변수 IN 커서 LOOP ... END LOOP;
-- 명시적으로 open, fetch, close를 호출하지 않아도 자동으로 실행됨.
-- open, fetch, close 과정이 암묵적으로 실행됨.
declare
    -- 명시적 커서 선언
    cursor c is
        select * from dept;
begin
    -- for-in 구문에서 커서 사용하기
    for v_row in c loop
        dbms_output.put_line(v_row.deptno || ' : '
                            || v_row.dname || ' : '
                            || v_row.loc);
    end loop;
end;
/


-- 명시적 커서 선언 없이 FOR-IN LOOP 사용
begin
    for r in (select * from dept) loop
        dbms_output.put_line(r.deptno || ' : '
                            || r.dname || ' : '
                            || r.loc);
    end loop;
end;
/

declare
    cursor c(p_no emp.empno%type) is
        select * from emp where empno = p_no;
begin
    for r in c(7369) loop
        dbms_output.put_line(r.empno || ' : '
                            || r.ename || ' : '
                            || r.job || ' : '
                            || r.deptno);
    end loop;
end;
/


/*
 * 암묵적(묵시적) 커서(implicit cursor)
 * 명시적인 커서 선언 없이 PL/SQL 블록 안에서 SQL문을 사용했을 때 자동으로 선언되는 커서.
 * OPEN, FETCH, CLOSE를 명시적으로 사용하지 않음.
 * 묵시적 커서의 속성:
 * - SQL%FOUND: 묵시적 커서가 추출(select)한 행이 있거나, DML 문으로 변경(insert/update/delete)된 행이 있으면 true.
 * - SQL%NOTFOUND: 묵시적 커서가 추출한 행이 없거나, DML 문으로 변경된 행이 없을 때 true.
 * - SQL%ROWCOUNT: 묵시적 커거사 추출한 행의 개수 또는 DML 문으로 영향을 받은 행의 개수.
 * - SQL%ISOPEN: 커서가 open된 상태이면 true, close된 상태이면 false.
 *   -- 묵시적 커서는 SQL 문이 실행된 후 자동으로 close가 되기 때문에 ISOPEN 속성은 항상 false를 반환.
 */

declare
    v_no emp.empno%type := 7788;
    v_row emp%rowtype;
begin
    -- 묵시적 커서
    select * into v_row
        from emp
        where empno = v_no;
    
    if sql%isopen then
        dbms_output.put_line('OPEN');
    else
        dbms_output.put_line('CLOSED');
    end if;
    
    dbms_output.put_line('row count: ' || sql%rowcount);
    
    if sql%found then
        dbms_output.put_line('FOUND');
        dbms_output.put_line(v_row.empno || ' : ' || v_row.ename);
    end if;
    
    if sql%notfound then
        dbms_output.put_line('NOT FOUND');
    end if;
end;
/

-- 묵시적 커서를 사용한 DELETE 문 실행과 처리 결과
begin
    -- 묵시적 커서
    delete from emp_copy where empno = 7844;
    
    -- delete 문 실행 결과 -> 삭제된 행의 개수
    dbms_output.put_line(sql%rowcount || '개 행이 삭제됨.');
end;
/

-- DEPT 테이블의 행들을 저장할 수 있는 연관 배열(index-by table)을 선언.
-- FOR-IN LOOP와 묵시적 커서를 사용해서
-- DEPT 테이블에서 select한 내용을 연관 배열에 순서대로 저장.
-- 연관 배열의 내용을 출력.
declare
    -- 정수를 인덱스로 갖고, DEPT 테이블의 행을 값으로 갖는 연관 배열을 선언.
    type index_table is table of dept%rowtype index by pls_integer;
    
    -- 연관 배열 타입의 변수 선언
    v_dept_tbl index_table;
    
    -- 연관 배열에서 레코드(행 1개)를 저장할 위치(인덱스)로 사용하기 위한 변수.
    i pls_integer := 1;
begin
    -- 묵시적 커서를 사용해서 DEPT 테이블의 레코드들을 읽어옴.
    for r in (select * from dept) loop
        -- 묵시적 커서에서 fetch한 데이터를 연관 배열에 저장.
        v_dept_tbl(i) := r;
        
        -- 다을 레코드를 저장하기 위해서 인덱스 값을 1 증가.
        i := i + 1;
    end loop;
    
    dbms_output.put_line('DEPT 레코드 개수 = ' || v_dept_tbl.count);
    
    for i in 1 .. v_dept_tbl.count loop
        dbms_output.put_line(v_dept_tbl(i).deptno || ' : '
                            || v_dept_tbl(i).dname || ' : '
                            || v_dept_tbl(i).loc);
    end loop;
end;
/

-- 연습 문제 1.
declare
    -- empno, ename, job, sal을 저장하는 레코드 타입을 선언.
    type rec_emp is record (
        empno emp.empno%type,
        ename emp.ename%type,
        job emp.job%type,
        sal emp.sal%type
    );
    
    -- 정수를 인덱스로 갖고, rec_emp 타입으로 값으로 갖는 연관 배열을 선언.
    type itab_emp is table of rec_emp index by pls_integer;
    
    -- 연관 배열 타입의 변수를 선언.
    emp_tbl itab_emp;
    
    -- emp 테이블에서 empno, ename, job, sal을 검색하는 커서를 선언.
    cursor c is 
        select empno, ename, job, sal from emp;
    
    -- 연관 배열의 인덱스로 사용할 변수. 배열에 레코드를 저장할 때마다 1씩 증가.
    i pls_integer := 1;
begin
    -- for-in loop을 사용해서 커서를 실행하고, 그 결과들을 연관 배열 emp_tbl에 저장.
    for r in c loop
        emp_tbl(i) := r;
        i := i + 1;
    end loop;
    
    -- 연관 배열 emp_tbl의 내용을 출력.
    for i in 1 .. emp_tbl.count loop
        dbms_output.put_line(emp_tbl(i).empno || ' : '
                            || emp_tbl(i).ename || ' : '
                            || emp_tbl(i).job || ' : '
                            || emp_tbl(i).sal);
    end loop;
end;
/

-- 연습 문제 2.
declare
    -- empno, ename, job, dname을 저장하는 레코드 타입을 선언.
    type rec_emp is record (
        empno number,
        ename varchar2(40),
        job varchar2(40),
        dname varchar2(20)
    );
    
    -- 정수를 인덱스로 갖고, rec_emp 타입으로 값으로 갖는 연관 배열을 선언.
    type itab_emp is table of rec_emp index by pls_integer;
    
    -- 연관 배열 타입의 변수를 선언.
    emp_tbl itab_emp;
    
    -- 부서번호(deptno)를 파라미터로 전달받아서,
    -- emp 테이블과 dept 테이블에서 empno, ename, job, dname을 검색하는 커서를 선언.
    cursor c(p_no dept.deptno%type) is 
        select e.empno, e.ename, e.job, d.dname
            from emp e
                join dept d on e.deptno = d.deptno
            where e.deptno = p_no;
    
    i pls_integer := 1;
begin
    -- for-in loop을 사용해서 커서를 실행하고, 그 결과들을 연관 배열 emp_tbl에 저장.
    for r in c(20) loop
        emp_tbl(i) := r;
        i := i + 1;
    end loop;
    
    dbms_output.put_line('# of rows: ' || emp_tbl.count);
    
    -- 연관 배열 emp_tbl의 내용을 출력.
    for i in 1 .. emp_tbl.count loop
        dbms_output.put_line(emp_tbl(i).empno || ' : '
                            || emp_tbl(i).ename || ' : '
                            || emp_tbl(i).job || ' : '
                            || emp_tbl(i).dname);
    end loop;
end;
/
