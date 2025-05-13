-- 새로운 사용자(계정, 비밀번호) 만들기
alter session set "_ORACLE_SCRIPT" = true;

create user hr identified by hr;

-- hr 계정에 dba(관리자) 권한 부여
grant dba to test;
