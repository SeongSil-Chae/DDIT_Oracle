2024-1024-02)조인
DELETE FROM CSS02.REMAIN;
 --매출: CART 인설트 -> REMAIN 업데이트, -> 마일리지 업데이트
 --매입 : BUYPROD 인설트 -> REMAIN 업데이트
** 각자의 계정에 재고 수불 테이블(REMAIN)을 생성하시오.
--------------------------------------------------------------------------------
컬럼명          데이터타입              기본값              PK,FK           설명
--------------------------------------------------------------------------------
REMAIN_YEAR     CHAR(4)                                   PK             년도
PROD_ID         VARCHAR2(10)                              PK & FK        상품코드
REMAIN_J_00     NUMBER(5)               0                                기초재고
REMAIN_I        NUMBER(5)               0                                입고수량
REMAIN_O        NUMBER(5)               0                                출고수량
REMAIN_J_99     NUMBER(5)               0                                현재고=기초재고+매입-매출
REMAIN_DATE     DATE                  SYSDATE                            처리일자

** REMAIN 테이블에 다음 자료를 입력하시오.
 년도 : 2020년
 상품코드 : 상품테이블의 모든 상품코드
 기초재고 : 상품테이블의 해당 상품의 적정재고 (PROD_PROPERSTOCK)
 현재고   : 상품테이블의 해당 상품의 적정재고
 갱신일자 : 2020년 1월 1일
 
 INSERT INTO CSS02.REMAIN(REMAIN_YEAR,PROD_ID, REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)
   SELECT '2020', PROD_ID, PROD_PROPERSTOCK, PROD_PROPERSTOCK,TO_DATE('20200101')
   FROM CSS02.PROD;
COMMIT;

SELECT * FROM CSS02.REMAIN;