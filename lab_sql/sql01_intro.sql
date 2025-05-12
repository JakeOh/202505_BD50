/*
 * 블록 주석(block comment)
 * SQL 워크시트: SQL 문장(코드)을 저장하는 파일. 스트립트(script).
 * Alt+F10: 새 SQL 워크시트(빈 파일) 만듦.
 * Ctrl+Enter: 명령문 실행
 *   (1) 커서가 있는 위치의 한 문장을 실행.
 *   (2) 마우스 드래그로 선택한 문장(들)을 실행.
 * F5: 스크립트(워크시트) 파일의 첫번째 문장부터 마지막 문장까지 순서대로 실행.
 
 * SQL(Structured Query Language):
 * 관계형 데이터베이스 관리 시스템(RDBMS, Relational Database Management System)에서
 * 데이터를 관리/조작하기 위한 언어.
 * SQL 키워드(명령어)는 대/소문자를 구분하지 않음.
 * (주의) 문자열들을 비교할 때는 대/소문자를 구분함.
 * SQL 문장을 세미콜론(;)으로 끝남.
 */

-- inline comment(한 줄 주석)
SELECT sysdate FROM dual;
select SYSDATE from DUAL;
SELECT SYSDATE FROM DUAL;
select sysdate from dual;
select systimestamp 
from dual;
