/*
 * Collection(컬렉션)
 * - 같은 타입의 데이터(값) 여러 개를 하나의 변수에 저장할 수 있는 데이터 타입.
 * - 종류
 *   (1) 연관 배열(associative array), 인덱스가 있는 테이블(index-by table)
 *   (2) VARRAY: 가변 길이 배열(variable-size array)
 *   (3) 중첩 테이블(nested table)
 */

set serveroutput on;

/*
 * 연관 배열(Associative Array). Index-By Table.
 * - 인덱스(키)와 값을 쌍(key-value)으로 저장하는 데이터 타입.
 * - 인덱스(키)는 정수(PLS_INTEGER) 또는 문자열(VARCHAR2) 타입만 사용 가능.
 * - 저장하는 값은 어떤 데이터 타입도 가능.
 * - 저장할 수 있는 데이터의 개수는 제한이 없음.
 * - 인덱스는 연속적인 정수일 필요는 없음. 비연속적인 인덱스를 가질 수 있음.
 * (문법)
 * TYPE 연관배열_이름 IS TABLE OF 값_타입 INDEX BY 인덱스_타입;
 */
 
 declare
    -- 정수를 인덱스로 사용하고, 문자열을 값으로 가지는 연관 배열 선언.
    type assoc_array is table of varchar2(50) index by pls_integer;
    
    -- 선언한 연관 배열 타입의 변수 선언.
    v_fruits assoc_array;
 begin
    -- 연관 배열 타입 변수에 값(데이터) 저장: 연관배열변수(키) := 값;
    v_fruits(1) := 'Apple';
    v_fruits(2) := 'Banana';
    v_fruits(11) := '체리';
    
    -- 연관 배열 타입 변수에 저장된 값을 읽어옴: 연관배열변수(키)
    dbms_output.put_line('index 1 : ' || v_fruits(1));
    dbms_output.put_line('index 2 : ' || v_fruits(2));
    dbms_output.put_line('index 11 : ' || v_fruits(11));
 end;
 /

/*
 * Collection 함수
 * - COUNT: 컬렉션이 가지고 있는 데이터 개수를 반환(return).
 * - FIRST: 컬렉션의 첫번째 인덱스를 반환.
 * - LAST: 컬렉션의 마지막 인덱스를 반환.
 * - NEXT(key): key 다음의 인덱스를 반환. key가 마지막 인덱스인 경우에는 null을 반환.
 * - PRIOR(key): key 이전의 인덱스를 반환. key가 첫번째 인덱스인 경우에는 null을 반환.
 */

-- Collection 함수 이용 예제
declare
    -- 정수를 키(인덱스)로 갖고, 문자열을 값으로 갖는 연관 배열 선언
    type assoc_arr is table of varchar2(50) index by pls_integer;
    
    -- 연관 배열 타입 변수 선언
    v_names assoc_arr;
begin
    -- 연관 배열에 데이터 저장.
    v_names(7788) := 'Scott';
    v_names(7600) := 'King';
    v_names(7889) := '홍길동';
    
    dbms_output.put_line('COUNT: ' || v_names.count);
    dbms_output.put_line('FIRST: ' || v_names.first);
    dbms_output.put_line('LAST: ' || v_names.last);
    --> 연관 배열은 키(인덱스)를 (오름차순) 정렬해서 사용.
end;
/

