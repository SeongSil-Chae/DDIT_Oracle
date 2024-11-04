    
문제1) 2020년 2월 ~ 6월까지 상품별 매출 수량을 집계하시오. 
      단, 안팔린 제품도 표시
    SELECT A.PROD_ID AS 상품번호,
           A.PROD_NAME AS 상품명,
           NVL(SUM(B.CART_QTY),0) AS 매출수량
    FROM CSS02.PROD A
    LEFT OUTER JOIN CSS02.CART B ON (A.PROD_ID=B.PROD_ID AND TO_DATE(SUBSTR(CART_NO,1,8)) BETWEEN ('20200201') AND ('20200630'))
    GROUP BY A.PROD_ID, A.PROD_NAME
    ORDER BY 3 DESC   
      
문제2) 모든 사원 중 인도에 사는 사람의 부서번호와 직무를 출력하시오.
    SELECT A.DEPARTMENT_ID AS 부서번호,
           B.EMP_NAME AS 사원명,
           C.JOB_ID AS 직무번호,
           C.JOB_TITLE AS 직무명,
           NVL(D.LOCATION_ID,0) AS 사는지역,
           NVL(D.COUNTRY_ID,0) AS 나라코드
      FROM HR.DEPARTMENTS A
      LEFT OUTER JOIN HR.EMPLOYEES B ON (A.DEPARTMENT_ID=B.DEPARTMENT_ID)
      LEFT OUTER JOIN HR.JOBS C ON (B.JOB_ID=C.JOB_ID)
      LEFT OUTER JOIN HR.LOCATIONS D ON(A.LOCATION_ID=D.LOCATION_ID AND D.COUNTRY_ID = 'US')
      GROUP BY A.DEPARTMENT_ID, B.EMP_NAME, C.JOB_ID, C.JOB_TITLE, D.LOCATION_ID, D.COUNTRY_ID
      ORDER BY 1
    

문제3) 모든 상품에서 2020년 매입한 상품 금액이 가장 큰 값을 표시하고 
        판매실적을 나타내세요.
        
문제4) 모든 직원 중 커미션이 있는 사원의 급여를 표시하세요.
        해당 부서의 급여 합계를 나타시오.
    
    
    
    