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
    v_num number := 27;
begin
    case mod(v_num, 2)
        when 0 then
            dbms_output.put_line('짝수');
        else
            dbms_output.put_line('홀수');
    end case;
end;
/

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
