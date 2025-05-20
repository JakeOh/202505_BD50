/*
 * 제약조건(Contraints)
 * 1. primary key(PK, 고유키):
 *    - 테이블에서 유일한 1개의 행(row)을 선택할 수 있는 컬럼(들).
 *    - PK인 컬럼(들)은 null이 될 수 없고, 중복된 값을 가질 수 없음.
 * 2. not null(NN)
 *    - 반드시 값을 가져야 하는 컬럼. null이 될 수 없는 컬럼.
 * 3. unique
 *    - 중복된 값을 가질 수 없는 컬럼.
 *    - null은 여러 개가 있을 수도 있음.
 * 4. check
 *    - 컬럼의 값을 조건을 만족하는 값들로만 제한.
 *    - not null 제약조건(check column is not null)은 check 제약조건의 특수한 경우.
 * 5. foreign key(FK, 외래키)
 *    - 다른 테이블의 PK를 참조하는 컬럼.
 *    - (예) DEPT 테이블의 DEPTNO 컬럼 - PK, EMP 테이블의 DEPTNO 컬럼 - FK
 *    - FK 제약조건이 있는 컬럼에는 연관 테이블의 PK에 있는 값들로만 insert를 할 수 있음.
 */
