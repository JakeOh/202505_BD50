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
    
    -- 연관 배열의 인덱스를 저장할 변수 선언
    key pls_integer;
begin
    -- 연관 배열에 데이터 저장.
    v_names(7788) := 'Scott';
    v_names(7600) := 'King';
    v_names(7889) := '홍길동';
    
    dbms_output.put_line('COUNT: ' || v_names.count);
    dbms_output.put_line('FIRST: ' || v_names.first);
    dbms_output.put_line('LAST: ' || v_names.last);
    --> 연관 배열은 키(인덱스)를 (오름차순) 정렬해서 사용.
    
    -- 반복문과 컬렉션 함수를 사용한 데이터 읽기
    key := v_names.first;  -- 연관 배열의 첫번째 인덱스를 변수 key에 저장.
    while key is not null loop
        dbms_output.put_line(key || ' : ' || v_names(key));
        key := v_names.next(key);  -- key 다음의 인덱스를 변수 key에 저장.
    end loop;
end;
/

declare
    -- 문자열을 인덱스로 갖고, 정수를 값으로 갖는 연관 배열을 선언.
    type assoc_arr is table of pls_integer index by varchar2(50);
    
    -- 연관 배열 타입 변수 선언
    v_menu assoc_arr;
    
    -- 연관 배열의 인덱스를 저장하기 위한 변수 선언
    key varchar2(50);
begin
    -- 연관 배열에 데이터 저장
    v_menu('아메리카노') := 1000;
    v_menu('라떼') := 1500;
    v_menu('카푸치노') := 1500;
    v_menu('에이드') := 2000;
    
    -- 반복문을 사용해서 연관 배열 v_menu의 데이터(키-값)들을 출력.
    key := v_menu.first;
    while key is not null loop
        dbms_output.put_line(key || ' : ' || v_menu(key));
        key := v_menu.next(key);
    end loop;
    
end;
/


/*
 * VARRAY: variable-size array. 가변 길이 배열.
 * - 인덱스는 1부터 시작하고, 연속된 정수를 인덱스로 가짐.
 * - 저장하는 값의 타입은 제한이 없음.
 * - VARRAY는 선언할 때 배열의 최대 크기를 지정해야만 함.
 * - 변수 선언과 동시에 값들을 초기화할 수 있음.
 * - VARRAY의 크기(길이)가 지정된 최대 크기보다 작다면 크기를 늘릴 수 있음.
 * (문법)
 * TYPE 배열이름 IS VARRAY(최대크기) OF 값_타입;
 */
 
 declare
    -- 문자열을 최대 5개까지 저장할 수 있는 VARRAY를 선언
    type varr is varray(5) of varchar2(50);
    
    -- VARRAY 타입의 변수를 선언과 초기화
    -- varr(): 빈(empty) 배열이 생성.
    v_fruits varr := varr('apple', 'banana', 'cherry');
 begin
    dbms_output.put_line('COUNT: ' || v_fruits.count);
    dbms_output.put_line('FIRST: ' || v_fruits.first);
    dbms_output.put_line('LAST: ' || v_fruits.last);
    --> varray에서 count와 last의 반환값은 항상 같음.
    
    for i in 1..v_fruits.count loop
        dbms_output.put_line('index ' || i || ': ' || v_fruits(i));
    end loop;
    
    -- 배열 크기 늘리기: EXTEND(개수)
    -- 아규먼트를 전달하지 않으면 배열 크기를 1개만 늘려줌.
    v_fruits.extend(2);  -- 배열에 2개의 빈 공간(null)을 추가.
    dbms_output.put_line('EXTEND 후 COUNT: ' || v_fruits.count);
    
    v_fruits(4) := '수박';
    v_fruits(5) := '참외';
    
    -- 바뀐 배열의 내용을 출력
    for i in 1 .. v_fruits.count loop
        dbms_output.put_line(i || ' : ' || v_fruits(i));
    end loop;
    
    -- v_fruits.extend();
    --> v_fruits 변수는 최대 5개까지 저장할 수 있는 VARRAY.
    --> COUNT가 최댓값에 도달했기 때문에 더이상 확장(extend)할 수 없음.
    --> ORA-06532: 첨자(suscriptor, 인덱스)가 한계치(5)를 넘었습니다
 end;
 /
 

