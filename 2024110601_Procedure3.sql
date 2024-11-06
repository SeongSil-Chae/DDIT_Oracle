2024-1106-01)extra lec01

프로시져 예제
1. 사원테이블에서 사원의 수가 5명이상인 부서의 부서코드,부서명,관리사원명을 출력하는 프로시져 작성

  1) 사원테이블에서 사원의 수가 5명이상인 부서의 부서코드
     SELECT DEPARTMENT_ID,
            COUNT(*)
       FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID
     HAVING COUNT(*)>=5; 
     
  2) 프로시져 생성
     CREATE OR REPLACE PROCEDURE proc_dept_info(
       P_DID  IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
     IS
       L_DEPT_NAME VARCHAR2(100); --부서명
       L_MANAGER_NAME  VARCHAR2(100); --관리사원명
     BEGIN                  
       SELECT A.DEPARTMENT_NAME,B.EMP_NAME INTO L_DEPT_NAME,L_MANAGER_NAME
         FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
        WHERE A.MANAGER_ID=B.EMPLOYEE_ID
          AND A.DEPARTMENT_ID=P_DID;
       DBMS_OUTPUT.PUT('  '||P_DID||'   ');
       DBMS_OUTPUT.PUT(RPAD(L_DEPT_NAME,20));
       DBMS_OUTPUT.PUT_LINE(RPAD(L_MANAGER_NAME,9));
       DBMS_OUTPUT.PUT_LINE('--------------------------------------');
     END;
  

  3) 실행  
     DECLARE
       CURSOR cur_dept02  IS
         SELECT DEPARTMENT_ID, COUNT(*)
           FROM HR.EMPLOYEES
          GROUP BY DEPARTMENT_ID
         HAVING COUNT(*)>=5;        
     BEGIN
       FOR REC IN cur_dept02 LOOP
           proc_dept_info(REC.DEPARTMENT_ID);
       END LOOP;
     END;


2. 키보드로 연령대를 입력 받아 그 연령대에 해당하는 회원들의 2020년 구매현황을 출력
   출력할 내용은 회원번호, 회원명, 구매금액합계이며 구매금액 합계는 함수로작성하고
   출력하는부분은 프로시져로 작성하시오.
 1)익명블록
  ACCEPT P_AGE  PROMPT '연령대 입력 : '
  DECLARE
    CURSOR cur_mem04 IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10=&P_AGE; 
  BEGIN
    FOR REC IN cur_mem04 LOOP
        proc_sales_info(REC.MEM_ID, REC.MEM_NAME);
    END LOOP;
  END;

 2)프로시져  
  CREATE OR REPLACE PROCEDURE proc_sales_info(
    P_MID IN MEMBER.MEM_ID%TYPE, P_NAME IN MEMBER.MEM_NAME%TYPE)
  IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('회원번호 : '||P_MID);
    DBMS_OUTPUT.PUT_LINE('회원명 : '||P_NAME);
    DBMS_OUTPUT.PUT_LINE('구매금액합계 : '||TO_CHAR(fn_sum_member(P_MID),'99,999,999'));
    DBMS_OUTPUT.PUT_LINE('------------------------------------------');
  END;

 3)함수
  CREATE OR REPLACE FUNCTION fn_sum_member(
    P_MID  IN  MEMBER.MEM_ID%TYPE)
    RETURN NUMBER
  IS
    L_SUM NUMBER:=0; --구매금액합계
  BEGIN
    SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_SUM
      FROM CART A, PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.MEM_ID=P_MID
       AND A.CART_NO LIKE '2020%';
    
    RETURN L_SUM;   
  END;


