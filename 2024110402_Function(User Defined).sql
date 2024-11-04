2024-1104-02) User Defined Function(Function)
  - 사용자의 고유 결과값을 반환 받기 위한 모듈
  - 반환값이 있음
사용형식) 
  CREATE [OR REPLACE] FUNCTION 함수명 [(
    변수명 [IN|OUT|INOUT] 데이터타입 [,]
                :
    변수명 [IN|OUT|INOUT] 데이터타입)]
    RETURN 데이터 타입
  IS|AS
     선언영역;
  BEGIN
     실행영역
        :
     RETURN 값;  -- 위 리턴 데이터 타입과 일치해야됨.
      [EXCEPTION
        예외처리영역;]
    END;
    . 'IN|OUT|INOUT' : 변수의 기능(IN:입력용, OUT:출력용, INOUT: 입출력 공용 변수 선언)
    . '데이터타입' : 크기를 지정하면 안됨
    . SELECT문에서 사용한다
    . 실행영역 내부에 적어도 1개 이상의 RETURN 문이 존재해야 함
    . 보통 OUT 매개변수는 사용하지 않음
    
    
사용예) 상품코드를 입력받아 2020년 해당 상품의 매출수량 합계를 반환하는 함수를 작성하시오.

CREATE OR REPLACE FUNCTION fn_cart_qtysum01(
    P_PID  IN PROD.PROD_ID%TYPE)
    RETURN NUMBER 
  IS 
    L_QTY NUMBER:=0; -- 매출수량합계
  BEGIN
    SELECT SUM(CART_QTY) INTO L_QTY
      FROM CART
     WHERE CART_NO LIKE '2020%'
       AND PROD_ID=P_PID;
       
    RETURN L_QTY;
  END;
    
(실행)
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           NVL(fn_cart_qtysum01(PROD_ID),0) AS 판매수량,
           NVL(fn_cart_qtysum01(PROD_ID) * PROD_PRICE,0) AS 판매액
      FROM PROD;
    
    
사용예) 날짜와 회워번호를 입력바아 장바구니 번호를 반환하는 함수를 작성하시오.
  CREATE OR REPLACE FUNCTION fn_create_cart_no(
    P_DATE DATE, P_MID MEMBER.MEM_ID%TYPE)
    RETURN VARCHAR2
  IS
    L_CNT NUMBER:=0;
    L_MID MEMBER.MEM_ID%TYPE;
    L_CART_NO VARCHAR2(13);
    L_DATE VARCHAR2(8):=TO_CHAR(P_DATE,'YYYYMMDD');
  BEGIN
    SELECT COUNT(*) INTO L_CNT
      FROM CART
     WHERE CART_NO LIKE L_DATE||'%';
     
    IF L_CNT = 0 THEN
       L_CART_NO:=L_DATE||TRIM('00001');
    ELSE
       SELECT DISTINCT(MAX(CART_NO)) INTO L_CART_NO
         FROM CART
        WHERE CART_NO LIKE L_DATE||'%';
        
       SELECT DISTINCT(MEM_ID) INTO L_MID
         FROM CART
        WHERE CART_NO=L_CART_NO;
       
       IF P_MID != L_MID THEN
          L_CART_NO:=L_CART_NO+1;
       END IF;
    END IF;
    RETURN L_CART_NO;
  END;
  
  
 (실행) 
    SELECT fn_create_cart_no(TO_DATE('20200505'),'c001') FROM DUAL;  
    
    SELECT fn_create_cart_no(SYSDATE,'c001') FROM DUAL;  