2024-1022-01)ROLLUP과 CUBE
 - GROUP BY 절 내부에 사용되며(독립하여 사용할 수 없음) 여러가지 집계를 반환
1. ROLLUP
 - 레벨별 집계를 반환
사용형식)
    GROUP BY [컬럼명,...]ROLLUP(컬럼명1, 컬럼명2,...컬럼명n)[,컬럼명,...]
      . ROLLUP에 기술된 모든 컬럼이 사용된 집계(가장 하위레벨 집계)를 반환한 후 
        오른쪽부터 컬럼들을 하나씩 제거한 집계를 반환함. 마지막은 모든 컬럼을 제거한
        집계(전체집계)를 반환함
      . ROLLUP절에 사용된 컬럼의 수가 n개일때 n+1 종류의 집계를 반환함
      . ROLLUP절 앞 또는 뒤에 컬럼이 올 수 있으며 이를 부분 ROLLUP이라함.
      
사용예) 매출테이블에서 2020년 상반기(1~6월) 월별, 회원별, 상품별 판매수량합계를 조회하시오.
    SELECT SUBSTR(CART_NO,5,2) AS 월,
           MEM_ID AS 회원,
           PROD_ID AS 상품번호,
           SUM(CART_QTY) AS 판매수량합계
      FROM CSS02.CART
     WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
     GROUP BY SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID
    ORDER BY 1;
    
  위 내용을 (ROLLUP) 사용)   
  -- (NULL)뜨는건 합계 / 중간집계할때 좋음.
  
      SELECT SUBSTR(CART_NO,5,2) AS 월,
           MEM_ID AS 회원,
           PROD_ID AS 상품번호,
           SUM(CART_QTY) AS 판매수량합계
      FROM CSS02.CART
     WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
     GROUP BY ROLLUP (SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID)
    ORDER BY 1;
    
(부분 ROLLUP)
      SELECT SUBSTR(CART_NO,5,2) AS 월,
           MEM_ID AS 회원,
           PROD_ID AS 상품번호,
           SUM(CART_QTY) AS 판매수량합계
      FROM CSS02.CART
     WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
     GROUP BY SUBSTR(CART_NO,5,2), ROLLUP (MEM_ID, PROD_ID)
    ORDER BY 1;
    -- 롤업은 작성한 마지막 컬럼 값을 널로 만들면서 총합 처리함,
    
    
2. CUBE
 - 사용된 컬럼들로 조합 가능한 모든 집계를 반환
사용형식)
    GROUP BY [컬럼명,...,]CUBE(컬럼명1,컬럼명2,...컬럼명n)[,컬럼명,...]
      .  CUBE절에 사용된 컬럼들로 조합가능한 모든 집계(2^N)를 반환
      .  나머지 기능들은 ROLLUP과 동일
    
    
사용예) 매출테이블에서 2020년 상반기(1~6월) 월별, 회원별, 상품별 판매수량합계를 조회하시오.
(ROLLUP 대신 CUBE 사용)
1. 월별, 회원별, 상품별의 경우의 수를 전부 출력함.
(월별,회원별,상품별)(월별,회원별)(월별,상품별)(회원별,상품별)(월별)(회원별)(상품별)(총합)

    SELECT SUBSTR(CART_NO,5,2) AS 월,
           MEM_ID AS 회원,
           PROD_ID AS 상품번호,
           SUM(CART_QTY) AS 판매수량합계
      FROM CSS02.CART
     WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
     GROUP BY CUBE(SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID)
    ORDER BY 1;



