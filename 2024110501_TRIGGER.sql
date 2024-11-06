2024-1105-01)TRIGGER
 - 특정 테이블에 발생된 DML명령으로 다른 테이블에 자동으로 변경을 처리해주는 
   특수 프로시져
 - 트리거 내부에서 DCL명령(COMMIT, ROLLBACK 등의 명령)은 사용할 수 없다
(사용형식)
  CREATE [OR REPLACE] TRIGGER 트리거명
     BEFORE|AFTER   INSERT | UPDATE | DELETE  ON 테이블명
    [FOR EACH ROW]
    [WHEN 조건]
  [DECLARE]
    선언영역;
  BEGIN
  --트리거 본문
    실행영역;
  END;
   . ' BEFORE|AFTER' : 트리거 본문부분이 실행되는 시점으로 
     - BEFORE : '테이블명'에 'INSERT | UPDATE | DELETE' 이벤트가 발생되기 전에 트리거 본문 실행
     - AFTER : '테이블명'에 'INSERT | UPDATE | DELETE' 이벤트가 발생된 후에 트리거 본문 실행
   . 'INSERT | UPDATE | DELETE' : 밸생되는 이벤트로 'OR'연산자를 이용하여 결합 사용 가능  
     ex) INSERT OR DELETE OR UPDATE  ON CART => CART테이블에 삽입,갱신 또는 삭제 명령을 만나면 트리거 생성
   . 'FOR EACH ROW'를 사용하면 행단위 트리거 생략하면 문장단위트리거 됨
   . WHEN 조건 : 트리거가 발생된 조건을 좀더 구체적으로 기술
   . 트리거는 문장단위 트리거와 행단위 트리거로 구분
     - 문장단위 트리거 : 이벤트 결과집합의 행의수와 관계업이 트리거 본문이 한번만 수행
                       'FOR EACH ROW'가 생략
     - 행단위 트리거 : 대부분의 트리거로 이벤트 결과집합의 행마다 트리거 본문 수행
                     'FOR EACH ROW' 기술
   . 의사레코드(PSEUDO RECORD)
   ------------------------------------------------------------------------------------------
     의사레코드    의미
   ------------------------------------------------------------------------------------------  
      :NEW        INSERT, UPDATE 에서사용되며, 데이터가삽입(갱신)될때들어온새로운값이다. 
                  DELETE 시에는모든필드는NULL이다.
      :OLD        DELETE, UPDATE 에서사용되며, 데이터가삭제(갱신)될때이전의값이다.
                  INSERT 시에는모든필드는NULL이다.
      :NEW, :OLD는 행단위 TRIGGER에서 사용가능
   --------------------------------------------------------------------------------------=--
   . 트리거 함수
   ------------------------------------------------------------------------------------------
     함수           의미
   ------------------------------------------------------------------------------------------  
     INSERTING     이벤트가 INSERT이면 참
     UPDATING      이벤트가 UPDATE이면 참 
     DELETING      이벤트가 DELETE이면 참
   ------------------------------------------------------------------------------------------   
     
사용예)LPROD 테이블에서 분류코드 'P501'자료를 삭제하시오. 자료가 삭제되면 
      '자료삭제가 정상적으로 수행되었습니다!'라는 메시지를 출력하는 트리거를 생성하시오
  CREATE OR REPLACE TRIGGER delete_lprod_tg
    AFTER  DELETE  ON  LPROD
  BEGIN
   DBMS_OUTPUT.PUT_LINE('자료삭제가 정상적으로 수행되었습니다!'); 
  END;
      
  DELETE  FROM LPROD WHERE LPROD_GU='P501'; 
  ROLLBACK;
  
  SELECT * FROM LPROD;
  
사용예)LPROD 테이블에서 분류코드 'P501'~'P503'자료를 삭제하시오. 자료가 삭제되면 
      '자료삭제가 정상적으로 수행되었습니다!'라는 메시지를 출력하는 트리거를 생성하시오  
  DELETE  FROM LPROD WHERE LPROD_GU>='P500';  
  COMMIT;
  
  
사용예제)장바구니테이블에 입력이 발생된 후(INSERT,UPDATE,DELETE) 재고수불테이블과 회원테이블의 자료를
        변경시키는 트리거를 작성하시오.
  CREATE OR REPLACE TRIGGER tg_change_cart
    AFTER  INSERT OR UPDATE OR DELETE  ON CART
    FOR EACH ROW
  DECLARE
    L_QTY NUMBER:=0;
    L_PID PROD.PROD_ID%TYPE;
    L_DATE DATE;
    L_MILEAGE NUMBER:=0;
    L_MID MEMBER.MEM_ID%TYPE;
  BEGIN
    IF INSERTING THEN
       L_QTY:=(:NEW.CART_QTY);
       L_PID:=(:NEW.PROD_ID);
       L_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
       L_MID:=:NEW.MEM_ID;
    ELSIF UPDATING THEN
       L_QTY:=(:NEW.CART_QTY)-(:OLD.CART_QTY);
       L_PID:=(:NEW.PROD_ID);
       L_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
       L_MID:=:NEW.MEM_ID;
    ELSIF DELETING THEN
       L_QTY:= -(:OLD.CART_QTY);
       L_PID:=(:OLD.PROD_ID);
       L_DATE:=TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
       L_MID:=:OLD.MEM_ID;
    END IF;
  
  --재고수불 UPDATE  
    UPDATE REMAIN A
       SET A.REMAIN_O=A.REMAIN_O + L_QTY,
           A.REMAIN_J_99=A.REMAIN_J_99 - L_QTY,
           A.REMAIN_DATE=L_DATE
     WHERE A.REMAIN_YEAR='2020'
       AND A.PROD_ID=L_PID;
    
  --회원테이블 MILEAGE UPDATE 
    SELECT L_QTY*PROD_MILEAGE INTO L_MILEAGE
      FROM PROD
     WHERE PROD_ID=L_PID;
     
    UPDATE MEMBER A
       SET A.MEM_MILEAGE=A.MEM_MILEAGE+L_MILEAGE
     WHERE A.MEM_ID=L_MID; 
  END;
  

        
                    기초    매입  매출  현재고 
2020	P201000009	  9	    26	  0	   35	2020/01/31   
[a001회원의 마일리지 : 6000]
[P201000009의 마일리지 : 140]

2020	P201000009	  9	    26   10	   25	2020/07/28

2020	P201000009	  9	    26	  7	   28	2020/07/28

2020	P201000009	  9     26    0	   35	2020/07/28
   
사용예) 2020년 7월 28일 'a001'회원이 'P201000009'상품을 10개 구매   
  INSERT INTO CART  VALUES('a001',fn_create_cart_no(TO_DATE('20200728'),'a001'),'P201000009',10);
  
   
사용예) 2020년 7월 28일 'a001'회원이 'P201000009'상품을 3개를 반품 
  UPDATE CART
     SET CART_QTY=7
   WHERE CART_NO = '2020072800006'
     AND PROD_ID = 'P201000009';
   
사용예) 2020년 7월 28일 'a001'회원이 'P201000009'상품을 모두 반품    
  DELETE FROM  CART
   WHERE CART_NO = '2020072800006'
     AND PROD_ID = 'P201000009'; 
   
   
     