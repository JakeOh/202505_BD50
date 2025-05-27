/* 반복문 
 * (1) LOOP
 * (2) WHILE ~ LOOP
 * (3) FOR ~ LOOP
 */

set SERVEROUTPUT on;

/*
 * loop
 *     반복할 문장;
 *     EXIT 문장;
 * end loop;
 */
declare
    v_num number := 1;
begin
    loop
        dbms_output.put_line(v_num);
        
        v_num := v_num + 1;
        /*
        if v_num > 5 then
            exit; -- loop를 끝냄(종료)
        end if;
        */
        exit when v_num > 5;
   end loop;
end;
/


-- 5, 4, 3, 2, 1 순서로 한 줄씩 출력.
declare
    v_num number := 5;
begin
    loop
        dbms_output.put_line(v_num);
        v_num := v_num - 1;
        exit when v_num = 0;
    end loop;
end;
/

/*
 * while 조건식 loop
 *     조건식을 만족하는 동안 실행할 코드;
 * end loop;
 */
declare
    v_num number := 1;
begin
    while v_num <= 5 loop
        dbms_output.put_line(v_num);
        v_num := v_num + 1;
    end loop;
end;
/

declare
    v_num number := 5;
begin
    while v_num > 0 loop
        dbms_output.put_line(v_num);
        v_num := v_num - 1;
    end loop;
end;
/

/*
 * for 변수 in 시작값..종료값 loop
 *     반복할 문장;
 * end loop;
 * (주의) 시작값은 반드시 종료값보다 작아야 함.
 */
 begin
    for i in 1..5 loop
        dbms_output.put_line(i);
    end loop;
 end;
 /
 
 begin
    for x in reverse 1..5 loop
        dbms_output.put_line(x);
    end loop;
 end;
 /
 
 /* coninue when 조건식; 
  * 조건식을 만족할 때 continue 아래의 문장들은 무시하고 그 다음 반복을 수행.
  */
 begin
    for x in 1..5 loop
        continue when x = 3;
        dbms_output.put_line(x);
    end loop;
 end;
 /
 
 -- 구구단 2단을 출력. 2x1=2, ..., 2x9=18.
 declare
    x number := 1;
 begin
    while x < 10 loop
        dbms_output.put_line('2 x ' || x || ' = ' || (2 * x));
        x := x + 1;
    end loop;
 end;
 /
 
 begin
    for x in 1..9 loop
        dbms_output.put_line('2 x ' || x || ' = ' || (2 * x));
    end loop;
 end;
 /
 
 -- 10 이하의 양의 정수들 중에서 짝수들만 출력. 2, 4, 6, 8, 10.
 begin
    for n in 1..10 loop /* 1..10 범위의 정수들 중에서 */
        if mod(n, 2) = 0 then  /* n을 2로 나눈 나머지가 0이면. n이 짝수이면. */
            dbms_output.put_line(n);  /* n을 출력 */
        end if;
    end loop;
 end;
 /
 
 begin
    for n in 1..5 loop
        dbms_output.put_line(2 * n);
    end loop;
 end;
 /
 
 begin
    for n in 1..10 loop
        continue when mod(n, 2) = 1;
        dbms_output.put_line(n);
    end loop;
 end;
 /
 
 declare
    n number := 1;
 begin
    while n <= 10 loop
        if mod(n, 2) = 0 then
            dbms_output.put_line(n);
        end if;

        n := n + 1;
    end loop;
 end;
 /
 
 
-- 중첩 반복문: 반복문 안에 반복문이 있는 경우.
-- 연습 1. 구구단 2단부터 9단까지 출력.
begin
    for x in 2..9 loop
        dbms_output.put_line(x || '단');
        
        for y in 1..9 loop
            dbms_output.put_line(x || ' x ' || y || ' = ' || (x * y));
        end loop;
        
        dbms_output.put_line('---------------');
    end loop;
end;
/

declare
    x number := 2;
    y number;
begin
    while x <= 9 loop
        dbms_output.put_line('--- ' || x || '단 ---');
        
        y := 1;
        while y <= 9 loop
            dbms_output.put_line(x || ' x ' || y || ' = ' || (x * y));
            y := y + 1;
        end loop;
        
        dbms_output.put_line('---------------');
        x := x + 1;
    end loop;
end;
/

-- 연습2. 구구단 2단은 2x2까지, 3단은 3x3까지, 4단은 4x4까지, ..., 9단은 9x9까지 출력.
begin
    for x in 2..9 loop
        dbms_output.put_line(x || '단');
        
        for y in 1..9 loop
            dbms_output.put_line(x || ' x ' || y || ' = ' || (x * y));
            exit when y = x;
        end loop;
        
        dbms_output.put_line('----------');
    end loop;
end;
/

begin
    for x in 2..9 loop
        dbms_output.put_line(x || '단');
        
        for y in 1..x loop
            dbms_output.put_line(x || ' x ' || y || ' = ' || (x * y));
        end loop;
        
        dbms_output.put_line('----------');
    end loop;
end;
/

declare
    x number := 2;
    y number;
begin
    while x < 10 loop
        dbms_output.put_line(x || '단');
        
        y := 1;
        while y <= x loop
            dbms_output.put_line(x || ' x ' || y || ' = ' || (x * y));
            y := y + 1;
        end loop;
        dbms_output.put_line('----------');
        
        x := x + 1;
    end loop;
end;
/

-- 연습 3. dept 테이블에서 부서번호 10 ~ 40까지의 부서 번호, 부서 이름, 위치를 출력.
declare
    v_deptno number;  -- 부서 번호(10..40)를 저장하기 위한 변수
    v_row dept%rowtype;  -- dept 테이블에서 1개 행의 데이터(번호, 이름, 위치)를 저장하기 위한 변수
begin
    for x in 1..4 loop
        v_deptno := x * 10;
        select * into v_row
            from dept
            where deptno = v_deptno;
            
        dbms_output.put_line(v_row.deptno || ' | '
                            || v_row.dname || ' | '
                            || v_row.loc);
    end loop;
end;
/
