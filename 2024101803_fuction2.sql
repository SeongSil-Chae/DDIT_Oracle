2024-1018-03) 숫자 함수
 - 수학적함수(ABS,SQRT,POWER, SIGN, ... ETC), ROUND, TRUNC, MOD, CEIL, FLOOR등
 
 사용예)
    SELECT ABS(-2000), ABS(2000),
           ROUND(SQRT(3.3),3), SIGN(-10000), SIGN(0.0001),SIGN(0), POWER(2,10)
     FROM DUAL;
     
     결과 : 2000  	2000	1.817	-1	1	0	1024
     
사용예) 상품테이블에서 각 상품의 마일리지를 다름 조건으로 계산하여 변경하시오
        마일리지=(상품의 매출가격-매입가격)의 1% 값을 초과하는 가장 가까운 정수
                단, 그 값이 정수이면 그 값을 반환
         UPDATE PROD
         SET PROD_MILEAGE = CEIL ((PROD_PRICE-PROD_COST)*0.01)
      COMMIT;
        
        