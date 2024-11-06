2024-1106-02) 서브프로그램
 - 프로시져나 함수 안에서 해당 프로그램만 반복하여 사용되는 루틴이 있는 경우 
   서브프로그램을 생성 할 수 있다.
 - 서브 프로그램은 DECLARE ~ IS 사이에 프로시져나 함수를 작성한다. 
 
사용예) 키보드로 연령대를 입력 받아 그 연령대에 해당하는 회원들의 2020년 구매현황을 출력
       출력할 내용은 회원번호, 회원명, 구매금액합계
 1)익명블록
  ACCEPT P_AGE  PROMPT '연령대 입력 : '
  DECLARE
    CURSOR cur_mem04 IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10=&P_AGE; 
       
    PROCEDURE proc_inner_sales_info(
      P_MID IN MEMBER.MEM_ID%TYPE, P_NAME IN MEMBER.MEM_NAME%TYPE)
    IS
    BEGIN
      DBMS_OUTPUT.PUT_LINE('회원번호 : '||P_MID);
      DBMS_OUTPUT.PUT_LINE('회원명 : '||P_NAME);
      DBMS_OUTPUT.PUT_LINE('구매금액합계 : '||TO_CHAR(fn_sum_member(P_MID),'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('------------------------------------------');
    END;
  BEGIN
    FOR REC IN cur_mem04 LOOP
        proc_inner_sales_info(REC.MEM_ID, REC.MEM_NAME);
    END LOOP;
  END;

 2)함수
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
  
  
  
  
  SELECT TO_CHAR(0.1230) AS NUM1
    ,  TO_CHAR(0.1230, 'FM999.9999') AS NUM2
    ,  TO_CHAR(0.1230, '999.0000') AS NUM3
    ,  TO_CHAR(0.1230, 'FM000.000') AS NUM4
    ,  TO_CHAR(0.1230, 'FM000.0000') AS NUM5
  FROM DUAL

 