/*
 * 연평균_근로시간_OECD.xlsx 파일의 내용을 테이블에 저장. 분석.
 */

-- 엑셀 파일의 내용을 저장할 수 있는 테이블을 생성.
create table work_time (
    country varchar2(60),
    y2014   number(5),
    y2015   number(5),
    y2016   number(5),
    y2017   number(5),
    y2018   number(5)
);

desc work_time;

-- [접속 패널] -> 테이블 -> 마우스 우 클릭 -> 데이터 임포트(import)

select * from work_time;

select substr(country, length('　　　') + 1) from work_time;

-- 2018년 한국의 평균 근로 시간보다 평균 근로 시간이 더 긴 국가는?

-- 2018년 평균 근로 시간 (많은 순서로) 상위 5개국 찾기.

