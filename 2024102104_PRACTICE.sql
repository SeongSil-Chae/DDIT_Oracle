? 상품테이블에서 상품의 수, 최대판매가, 최소판매가를 구하시오.
    SELECT PROD_TOTALSTOCK AS 상품의수,
           COUNT(*),
           MAX(PROD_PRICE) AS 최대판매가,
           MIN(PROD_PRICE) AS 최소판매가
    FROM CSS02.PROD
    GROUP BY PROD_ID, PROD_TOTALSTOCK
    HAVING MAX(PROD_PRICE)>0 AND MIN(PROD_PRICE)>=0


? 2020년 4월 판매수량 합계를 구하시오.
    SELECT CART_NO,
       SUM(CART_QTY)
    FROM CSS02.CART
    WHERE TO_DATE(SUBSTR(CART_NO, 1, 8), 'YYYYMMDD') 
      BETWEEN TO_DATE('2020-04-01', 'YYYY-MM-DD') 
      AND TO_DATE('2020-04-30', 'YYYY-MM-DD')        
    GROUP BY CART_NO
    
    



? 사원테이블에서 부서별 평균급여와 인원수를 조회하시오
? 상품테이블에서 분류별 상품의 수, 평균판매가를 조회하시오.
? 매입테이블에서 2020년 월별 매입수량합계를 조회하시오.
? 매입테이블에서 2020년 상품별 매입수량합계를 조회하시오.
? 매출테이블에서 월별, 상품별 판매수량합계를 조회하시오.
? 사원테이블에서 부서별, 년도별 입사한 사원수를 조회하시오. 
? 회원테이블에서 성별 평균마일리지를 조회하시오.
? 회원테이블에서 년령대별 회원수와 평균마일리지를 조회하시오.
? 회원테이블에서 거주지별 평균마일리지와 회원수를 조회하시오.