2024-1104-01)Stored procedure(procedure)
  - 반환값이 없다.(function과의 차이점)
  - 자바에서 사용할때에는 CallableStatement 객체를 사용해야함.
    (일반 select, insert, update, delete문은 Statement 나 PreparedStatement객체 사용)
사용형식)
  CREATE [OR REPLACE] PROCEDURE 프로시저명 [(
    변수명 [IN|OUT|INOUT] 데이터타입 [,]
                :
    변수명 [IN|OUT|INOUT] 데이터타입)]
  IS|AS
     선언영역;
  BEGIN
     실행영역
      [EXCEPTION
        예외처리영역;]
    END;
    . 'IN|OUT|INOUT' : 변수의 기능(IN:입력용, OUT:출력용, INOUT: 입출력 공용 변수 선언)
    . '데이터타입' : 크기를 지정하면 안됨
    
 실행명령)
   1) OUT 매개변수가 없는 경우
     . 독립적 실행: EXEC | EXECUTE 프로시저명(매개변수list)
     . 블록 내부에서 실행 : 프로시져명(매개변수list)
 
   2) OUT 매개변수가 있는 경우
     . 블록 내부에서 실행 : 프로시져명(매개변수list) -> 매개변수list에 데이터를 전달 받을 변수명이 와야함
     
    
    
사용예) 다음 매입자료를 처리하는 프로시져를 작성하시오.
----------------------------------------------------
     일자           상품코드        수량
----------------------------------------------------
  2024-11-05      P201000007       20
  EXECUTE proc_insert_buyprod(SYSDATE, 'P201000007', 20);
  (REMAIN에서                 기초 매입 매출 현재고
              2020 P201000007 9    19   0   28  2020/01/31
              2020 P201000007 9    39   0   48  2024/11/04
              
      ""          P201000011        5
  EXEC  proc_insert_buyprod(SYSDATE,'P202000011',5);
  
                2020    P2020000011    35     91     0     126    2020/01/31
                2020    P2020000011    35     96     0     131    2024/11/03                

      ""          P201000011        12   
    EXEC  proc_insert_buyprod(SYSDATE,'P202000011',12);
                2020    P2020000011    35     96     0     131    2024/11/03 
                2020    P2020000011    35     118     0     143    2024/11/03    
      
   CREATE OR REPLACE PROCEDURE proc_insert_buyprod(
    P_DATE IN DATE, P_PID PROD.PROD_ID%TYPE, P_QTY NUMBER)
   IS
   
   BEGIN
      INSERT INTO BUYPROD VALUES(P_DATE,P_PID,P_QTY);
      UPDATE REMAIN A
         SET A.REMAIN_I=A.REMAIN_I+P_QTY,
             A.REMAIN_J_99=A.REMAIN_J_99+P_QTY,
             A.REMAIN_DATE=P_DATE
       WHERE A.PROD_ID=P_PID;
       
       COMMIT;
   END;
      
사용예) 년도와 월을 회원번호를 입력받아 해당 회원의 구매금액합계를 반환 받는 프로시져를 작성하시오.

    CREATE OR REPLACE PROCEDURE proc_cart_sum01(
        P_PERIOD IN VARCHAR2, P_MID MEMBER.MEM_ID%TYPE,P_AMT OUT NUMBER)
    IS 
      --L_AMT NUMBER:=0;
    BEGIN
      --구매금액 합계 계산해서 P_AMT에 할당
      SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO P_AMT
        FROM CART A, PROD B
       WHERE A.PROD_ID=B.PROD_ID
         AND A.MEM_ID = P_MID
         AND SUBSTR(A.CART_NO,1,6)=P_PERIOD;
    END;
      
 [실행]
   DECLARE
   L_AMT NUMBER :=0;
   BEGIN
     proc_cart_sum01('202005','c001',L_AMT);
     
     DBMS_OUTPUT.PUT_LINE('구매금액 : '||L_AMT);
   END;
 
 
 
사용예) 상품의 분류코드를 키보드로 입력 받아 2020년 1~3월 해당 분류코드에 포함된 상품들의 매입 수량합계를
        출력하는 프로시져를 작성하시오.
(프로시져 : 상품코드 입력 받아 2020년 1~3월 까지 매입수량 합계를 반환)
  CREATE OR REPLACE PROCEDURE proc_buyprod_qtysum(
     P_PID IN PROD.PROD_ID%TYPE, P_QTY OUT NUMBER)
  IS
  BEGIN
     SELECT SUM(BUY_QTY) INTO P_QTY
       FROM BUYPROD
      WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200331')
        AND PROD_ID=P_PID;
  END;
(실행블록: 분류코드 입력받아 해당 분류에 속한 상품코드를 프로시져에 전달)
  ACCEPT P_LPROD PROMPT '분류코드 입력 : '
  DECLARE
  L_AMT NUMBER :=0; --  매입수량 전달받을 변수
    CURSOR cur_lprod_prod IS 
        SELECT PROD_ID, PROD_NAME
          FROM PROD
         WHERE LPROD_GU='P201';
  BEGIN
    FOR REC IN cur_lprod_prod LOOP
    DBMS_OUTPUT.PUT_LINE('상품코드 : '||REC.PROD_ID);
    DBMS_OUTPUT.PUT_LINE('상품명 : '||REC.PROD_NAME);
    proc_buyprod_qtysum(REC.PROD_ID,L_AMT);
    DBMS_OUTPUT.PUT_LINE('매입수량 : '||L_AMT);
     DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
    END LOOP;
  END;
        
        
    
      
      
      