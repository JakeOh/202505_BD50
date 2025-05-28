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
