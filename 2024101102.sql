2024-1011-02)ALTER 문
  - 이름 변경(테이블, 컬럼, 제약조건), 추가(컬럼, 제약조건), 타입변경(컬럼의 자료타입), 삭제(컬럼, 제약조건)
  - ALTER RENAME, ALTER ADD, ALTER MODIFY, ALTER DROP
  
1)ALTER RENAME
 - 테이블명, 컬럼명, 제약조건 이름을 변경
 (사용형식)
 ALTER TABLE OLD_테이블명 RENAME TO NEW_테이블명;  --테이블명 변경
 
 (사용예) BUYPROD테이블 이름을 PURCHASE로 변경해라.
   ALTER TABLE PURCHASE RENAME TO BUYPROD;
  
 
 ALTER TABLE 테이블명 RENAME COLUMN OLD_컬럼명 TO NEW_컬럼명;  --컬럼명 변경
 사용예) PROD테이블의 PROD_LGU컬럼을 LPROD_GU로, PROD_BUYER_ID로 변경 
  ALTER TABLE PROD RENAME COLUMN PROD_LGU TO LPROD_GU;
   -- 왼쪽 접속에서 파일 오른쪽 클릭해서 파일명, 클론명 변경 가능.

 ALTER TABLE 테이블명 RENAME CONSTRAINTS OLD_제약명 TO NEW_제약명; -- 제약명 변경
사용예) BUYER테이블의 외래키 설정명(FR_BUYER_LGU)를  (KF_BUYER_LG)로 변경
 ALTER TABLE BUYER RENAME CONSTRAINTS KF_BUYER_LG TO FK_LPROD_LG;
 
 2) ALTER ADD
  - 컬럼, 제약조건을 추가
 (사용형식) 
  ALTER TABLE 테이블명 ADD (컬럼 정의문); 
 (사용예) HR계정의 EMPLOYEE테이블에 EMP_NAME VARCHAR2(45)을 추가하시오.
 ALTER TABLE HR.EMPLOYEES ADD(EMP_NAME VARCHAR2(45));
 
 UPDATE HR.EMPLOYEES
    SET EMP_NAME=FIRST_NAME||' '||LAST_NAME;        --|| = 이 기호가 +임
   COMMIT;
 

사용예) 학과테이블(DEPARTMENT), 교수테이블(PROFESSOR)을 생성
 CREATE TABLE PROFESSOR(
   P_ID NUMBER(3),
   P_NAME VARCHAR(30),
   P_MAJOR VARCHAR2(50),
   P_TEL VARCHAR2(30),
   DEPT_ID NUMBER(5));
   
 CREATE TABLE DEPARTMENT(
    DEPT_ID NUMBER(5),
    DEPT_NAME VARCHAR2(30),
    DEPT_TEL VARCHAR2(30));
 
기본키 생성 -- 테이블 생성해서 2개 기본키 설정하고 교수 테이블에 학과키를 외래키로 줌.
  ALTER TABLE PROFESSOR ADD CONSTRAINTS pk_professor primary key(P_ID);
  
  ALTER TABLE DEPARTMENT ADD CONSTRAINTS pk_dept primary key(DEPT_ID);
  
  ALTER TABLE PROFESSOR ADD CONSTRAINTS Fk_profe_dept FOREIGN key(DEPT_ID)
                                        REFERENCES DEPARTMENT(DEPT_ID);
                                        
                                        
                                        
3) ALTER MODIFY
  - 컬럼의 자료타입이나 크기변경
사용형식)
  ALTER TABLE 테이블명 MODIFY 컬럼정의문;
  
사용예) HR계정의 EMPLOYEES테이블의 EMP_NAME컬럼을 CHAR(50)으로 변경하시오.

ALTER TABLE HR.EMPLOYEES MODIFY EMP_NAME CHAR(50);
ALTER TABLE HR.EMPLOYEES MODIFY EMP_NAME VARCHAR2(50);
-- 위 처럼 CHAR (고정길이)로 되있는걸 VARCHAR로 변경해도 크기가 꽉 차있음.
-- 그럴땐 업데이트 필요.
UPDATE HR.EMPLOYEES
    SET EMP_NAME=TRIM(EMP_NAME);
    COMMIT;
  
  