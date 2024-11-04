2024-1022-02)NULL처리함수
 - NVL, NVL2, NULLIF 등의 함수와 IS [NOT] NULL연산자가 제공 됨
 
사용예)
 1. 상품테이블에서 분류코드가 'P301' 상품의 매출가격을 매입가격으로 갱신하시오.
    UPDATE CSS02.PROD 
        SET PROD_PRICE =PROD_COST
        WHERE UPPER(LPROD_GU)='P301'
        
        COMMIT;
 2. 사원테이블에서 영업실적(COMMISSION_PCT)이 없는 사원수를 조회하시오.
    SELECT COUNT(*) AS 사원수
      FROM HR.EMPLOYEES
      WHERE COMMISSION_PCT IS NULL
    
 3. 상품테이블에서 크기정보(prod_size)를 조회하되 그 값이 null이면 “크기정보 없음＂을 출력하시오
    SELECT PROD_ID,
           PROD_NAME,
           NVL(PROD_SIZE, '크기정보없음')
    FROM CSS02.PROD;
 
4. 2020년 6월 모든 회원별 구매정보를 조회하시오
    Alias는 회원번호,회원명,구매수량합계이며 구매정보가 없는 회원은 '구매없음'을 출력하시오
    SELECT A.MEM_ID AS 회원번호,
           NVL(TO_CHAR(SUM(B.CART_QTY),'99,999'),'구매없음') AS 구매수량합계
    FROM CSS02.MEMBER A
    LEFT OUTER JOIN CSS02.CART B ON(A.MEM_ID=B.MEM_ID AND B.CART_NO LIKE '202006%')
    GROUP BY A.MEM_ID

5. 사원테이블에서 각 사원의 부서코드를 조회하여 부서코드가 없는 사원은 '프리랜서'를 출력하고
    NULL이 아니면 해당부서의 관리자 사원번호를 출력하시오.
    또 부서 코드가 NULL이면 부서코드 난에는 공백을 출력하시오.
    Alias는 사원번호, 사원명, 부서코드, 비고
    SELECT B.EMPLOYEE_ID AS 사원번호,
           B.EMP_NAME AS  사원명,
           NVL(TO_CHAR(B.DEPARTMENT_ID), ' ') AS 부서코드,
           NVL2(B.DEPARTMENT_ID,(SELECT TO_CHAR(A.MANAGER_ID)
                                 FROM HR.DEPARTMENTS A
                                WHERE B.DEPARTMENT_ID = A.DEPARTMENT_ID),'프리랜서') AS 비고
    FROM HR.EMPLOYEES B
    ORDER BY B.DEPARTMENT_ID;
    
    -- 위는 아직 안배운 내용인데 아래 내용과 같음.
    
   SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS  사원명,
           NVL(TO_CHAR(DEPARTMENT_ID), ' ') AS 부서코드,
           NVL2(DEPARTMENT_ID,NVL(TO_CHAR(MANAGER_ID),'대표'),'프리랜서') AS 비고
     FROM HR.EMPLOYEES 
    ORDER BY DEPARTMENT_ID;
    
 5. 상품테이블에서 매입가격과 매출가격이 같은 상품을 찾아 비고난에 '단종예정상품'을 출력하고 
 그 이외의 상품은 조수익(매출-매입)을 출력하시오. Alias는 상품코드, 상품명, 매입단가, 매출단가, 비고
 SELECT PROD_ID AS 상품코드,
        PROD_NAME AS 상품명,
        PROD_COST AS 매입단가,
        PROD_PRICE AS 매출단가,
        NVL2(NULLIF(PROD_COST, PROD_PRICE),TO_CHAR(PROD_PRICE-(NULLIF(PROD_COST, PROD_PRICE)),'9,999,999') ,'단정예정상품' ) AS 비고
   FROM CSS02.PROD;
 
