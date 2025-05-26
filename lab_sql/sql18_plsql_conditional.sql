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
 

