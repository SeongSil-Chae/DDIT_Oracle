2024-1104-02)User Defined Function(Function)
  - 사용자의 고유 결과값을 반환 받기위하 모듈
  - 반환값이 있음
사용형식)  
  CREATE [OR REPLACE] FUNCTION 함수명[(
    변수명 [IN|OUT|INOUT]  데이터타입 [,]
              :
    변수명 [IN|OUT|INOUT]  데이터타입)]
    RETURN 데이터타입 --크기는 제외하고 입력
  IS|AS
    선언영역;
  BEGIN
    실행영역
       : 
    RETURN 값;   -- 위 리턴 데이터 타입과 일치해야됨.
    [EXCEPTION 
      예외처리영역;]
  END;
   . 'IN|OUT|INOUT' : 변수의 기능(IN:입력용, OUT:출력용, INOUT:입출력 공용 변수 선언)
   . '데이터타입' : 크기를 지정하면 안됨
   . SELECT문에서 사용한다
   . 실행영역 내부에 적어도 1개이상의 RETURN 문이 존재해야 함
   . 보통 OUT 매개변수는 사용하자 않음
   
사용예)상품코드를 입력 받아 2020년 해당 상품의 매출수량합계를 반환하는 함수를 작성하시오.

  CREATE OR REPLACE FUNCTION fn_cart_qtysum01(
    P_PID  IN PROD.PROD_ID%TYPE)
    RETURN NUMBER
  IS
    L_QTY NUMBER:=0; --매출수량합계
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
         NVL(fn_cart_qtysum01(PROD_ID)* PROD_PRICE,0) AS 판매액
    FROM PROD;   
    
    
사용예)날짜와 회원번호를 입력 받아 장바구니번호를 반환하는 함수를 작성하시오.
  CREATE OR REPLACE FUNCTION fn_create_cart_no(
    P_DATE DATE, P_MID MEMBER.MEM_ID%TYPE)
    RETURN VARCHAR2
  IS
    L_CNT NUMBER:=0;  --특정 날짜의 행의 갯수
    L_MID MEMBER.MEM_ID%TYPE;   -- 그 날짜의 가장 큰 장바구니 번호를 가진 회원번호
    L_CART_NO VARCHAR2(13);    -- 새로 만든 카트번호
    L_DATE VARCHAR2(8):=TO_CHAR(P_DATE,'YYYYMMDD');   -- 특정 날짜를 카트번호에 넣기 위해
  BEGIN
    SELECT COUNT(*) INTO L_CNT
      FROM CART
     WHERE CART_NO LIKE L_DATE||'%';
     
    IF L_CNT = 0 THEN
       L_CART_NO:=L_DATE||TRIM('00001');
    ELSE
       SELECT DISTINCT(MAX(CART_NO)) INTO L_CART_NO    --2 장바구니가 3개라 중복 제거함.
         FROM CART
        WHERE CART_NO LIKE L_DATE||'%';
        
       SELECT DISTINCT(MEM_ID) INTO L_MID
         FROM CART
        WHERE CART_NO=L_CART_NO;
       
       IF P_MID != L_MID THEN    -- 두개가 같다면 카트번호 하나 증가시켜준다
          L_CART_NO:=L_CART_NO+1;
       END IF;
    END IF;
    RETURN L_CART_NO;
  END;
  
    
사용예)오늘이 2020년 7월 28일이라 가정하고 다음 자료를 처리하시오
---------------------------------------
  회원번호    상품번호      구매수량  
---------------------------------------
  b001       P302000013     3
  u001       P202000007     1
  u001       P102000003     2
  
   -- 인설트, 업데이트, 마일리지 추가
  
  
1)CART에 삽입
  INSERT INTO CART  VALUES('b001',fn_create_cart_no(TO_DATE('20200728'),'b001'),'P302000013',3);
  
  INSERT INTO CART  VALUES('u001',fn_create_cart_no(TO_DATE('20200728'),'u001'),'P202000007',1);
    
  INSERT INTO CART  VALUES('u001',fn_create_cart_no(TO_DATE('20200728'),'u001'),'P102000003',2);
  
사용예)2020년 5월 상품별 매입매출현황을 조회하시오
      Alias는 상품번호,상품명,매입수량합계,매입금액합계,매출수량합계,매출금액합계
      매입금액합계,매출금액합계는 함수로 작성
(매입함수:기간과 상품번호를 입력 받아 매입금액합계 반환)     
  CREATE OR REPLACE FUNCTION fn_sum_buyprod_2005(
    P_PERIOD IN VARCHAR2, P_PID PROD.PROD_ID%TYPE)    -- VARCHAR2 크기 설정 금지
    RETURN NUMBER
  IS
    L_SUM_BUY  NUMBER:=0;      --SCLAR 변수임.
  BEGIN
    SELECT NVL(SUM(A.BUY_QTY*B.PROD_COST),0) INTO L_SUM_BUY
      FROM BUYPROD A, PROD B
     WHERE A.PROD_ID=B.PROD_ID    --단가 꺼내오려고 조인
       AND A.BUY_DATE BETWEEN TO_DATE(P_PERIOD||'01') AND LAST_DAY(TO_DATE(P_PERIOD||'01'))
       AND A.PROD_ID=P_PID;
    RETURN L_SUM_BUY;   
  END;
      
      
(매출함수:기간과 상품번호를 입력 받아 매출금액합계 반환)     
  CREATE OR REPLACE FUNCTION fn_sum_cart_2005(
    P_PERIOD IN VARCHAR2, P_PID PROD.PROD_ID%TYPE)
    RETURN NUMBER
  IS
    L_SUM_CART  NUMBER:=0;   
  BEGIN
    SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_SUM_CART
      FROM CART A, PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.CART_NO LIKE P_PERIOD||'%'
       AND A.PROD_ID=P_PID;
    RETURN L_SUM_CART;   
  END; 
  
(실행)
  SELECT PROD_ID AS 상품번호,
         PROD_NAME AS 상품명,
         fn_sum_buyprod_2005('202004',PROD_ID) AS 매입금액합계,
         fn_sum_cart_2005('202004',PROD_ID) AS 매출금액합계
    FROM PROD; 