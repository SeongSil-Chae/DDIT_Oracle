2024-1023-01)등위함수(WINDOW 함수)
 - RANK() OVER, DENSE_RANK() OVER, ROW_NUMBER() OVER 가 제공
사용형식)
  RANK()|DENSE_RANK()|ROW_NUMBER() OVER(ORDER BY 컬럼명[DESC|ASC] [,컬럼명[DESC|ASC],...])
  . SELECT 절에서만 사용됨.
  
사용예) 상품테이블에서 판매조수익이 큰 상품부터 등수를 부여하시오. 
        단 같은 값이면 매입단가가 큰 상품부터 등수부여
        Alias는 상품코드, 상품명, 매입단가, 조수익, 등수
        SELECT PROD_ID AS 상품코드,
               PROD_NAME AS 상품명,
               PROD_COST AS 매입단가,
               PROD_PRICE-PROD_COST AS 조수익,
               RANK() OVER(ORDER BY (PROD_PRICE-PROD_COST) DESC) AS "등수1(RNAK)",
               DENSE_RANK() OVER(ORDER BY (PROD_PRICE-PROD_COST) DESC, PROD_COST DESC) AS"등수2(DENSE_RANK)",
               ROW_NUMBER() OVER(ORDER BY (PROD_PRICE-PROD_COST) DESC, PROD_COST DESC) AS"등수3(ROW_NUMBER)"
        FROM CSS02.PROD;
        
사용예) 사원테이블에서 각 사원들의 사원번호, 사원명, 입사일, 순번을 조회하시오.
        순번은 입사일 순으로 등수를 부여하시오.
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명,
               HIRE_DATE AS 입사일,
               RANK() OVER(ORDER BY HIRE_DATE) AS 순번
        FROM HR.EMPLOYEES
    
**그룹별 등위
사용형식) 
    RANK()|DENSE_RANK()|ROW_NUMBER() OVER((PARTITION BY 컬럼명[,컬럼명,...]
                                        ORDER BY 컬럼명[DESC|ASC] [,컬럼명[DESC|ASC],...])
    . 'PARTITION BY 컬럼명' : 컬럼명으로 그룹화 한 후 등위부여
    
사용예) 사원테이블에서 부서별 급여순으로 등위를 부여하시오. 사원번호, 사원명, 부서번호, 급여, 순위
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서번호,
           SALARY AS 급여,
           RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS 순위
      FROM HR.EMPLOYEES
사용예) 회원테이블에서 연령대별 마일리지 순으로 등위를 부여하시오. 회원번호, 회원명, 나이, 마일리지, 순위
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS 나이, 
           MEM_MILEAGE AS 마일리지,
           RANK() OVER(PARTITION BY TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR))/10) ORDER BY MEM_MILEAGE DESC) AS 순위
      FROM CSS02.MEMBER
        
        -- 연령대 구하는법
        -- TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR))/10)
        
        