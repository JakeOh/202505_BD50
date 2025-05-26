/*
 * PL/SQL 조건문: 조건을 만족하는 경우 실행할 코드와 만족하지 않을 때 실행할 코드를 작성.
 * (1) IF ~ END IF;
 * (2) IF ~ ELSE ~ END IF;
 * (3) IF ~ ELSIF ~ ELSE ~ END IF;
 */

set SERVEROUTPUT on;

/*
 * if 조건식 then
 *     조건식을 만족할 때 실행할 코드;
 * end if;
 */

declare
    v_num number := 25;
begin
    if mod(v_num, 2) = 1 then
        dbms_output.put_line(v_num || ' = 홀수');
    end if;
    
    dbms_output.put_line('if-end if 종료');
end;
/

/*
 * if 조건식 then
 *     조건식이 참일 때 실행할 코드(들);
 * else
 *     조건식이 거짓일 때 실행할 코드(들);
 * end if;
 */

declare
    v_num number := 61;
begin
    if mod(v_num, 2) = 1 then
        dbms_output.put_line('홀수');
    else
        dbms_output.put_line('짝수');
    end if;
    
    dbms_output.put_line('if-else-end if 종료');
end;
/

/*
 * if 조건식1 then
 *     (조건식1)이 참인 경우에 실행할 코드(들);
 * elsif 조건식2 then
 *     (조건식2)가 참인 경우에 실행할 코드(들);
 * [elsif ... then ...]
 * else
 *     위의 모든 조건식들이 false일 때 실행할 코드(들);
 * end if;
 */
 
 declare
    v_num number := 0;
 begin
    if v_num > 0 then
        dbms_output.put_line('양수');
    elsif v_num = 0 then
        dbms_output.put_line('zero');
    else
        dbms_output.put_line('음수');
    end if;
    
    dbms_output.put_line('if-elsif-else-end if 종료');
 end;
 /
 
 /*
  * case-when 조건문:
  * case 식
  *     when 값1 then
  *         식=값1 일 때 실행할 코드;
  *     when 값2 then
  *         식=값2 일 때 실행할 코드;
  *     ...
  *     else
  *         식을 계산했을 때 일치하는 값을 찾을 수 없을 때 실행할 코드;
  * end case;
  */
declare
    v_score number := 77;
begin
    case trunc(v_score / 10)
        when 10 then
            dbms_output.put_line('A');
        when 9 then
            dbms_output.put_line('A');
        when 8 then
            dbms_output.put_line('B');
        when 7 then
            dbms_output.put_line('C');
        when 6 then
            dbms_output.put_line('D');
        else
            dbms_output.put_line('F');
    end case;
end;
/
 
/*
 * case
 *      when 조건식1 then
 *          (조건식1)을 만족할 때 실행할 코드;
 *      when 조건식2 then
 *          (조건식2)를 만족할 때 실행할 코드;
 *      ...
 *      else
 *          위의 모든 조건식을 만족하지 못할 때 실행할 코드;
 * end case;
 */
declare
    v_score number := 87;
begin
    case
        when v_score >= 90 then
            dbms_output.put_line('A');
        when v_score >= 80 then
            dbms_output.put_line('B');
        when v_score >= 70 then
            dbms_output.put_line('C');
        when v_score >= 60 then
            dbms_output.put_line('D');
        else
            dbms_output.put_line('F');
    end case;
end;
/


/* 반복문 
 * (1) LOOP
 * (2) WHILE ~ LOOP
 * (3) FOR ~ LOOP
 */

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
            n := n + 1;
        end if;
        
    end loop;
 end;
 /
 