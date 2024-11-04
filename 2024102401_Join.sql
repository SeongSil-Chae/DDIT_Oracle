2024-1024-01)조인

사용예1) 사원테이블에서 2018년 이후 입사한 사원들의 정보를 부서별로 출력하시오
        Alias는 사원번호, 사원명, 부서번호, 부서명, 직책명
        SELECT A.EMPLOYEE_ID AS 사원번호,
               A.EMP_NAME AS 사원명,
               A.DEPARTMENT_ID AS 부서번호,
               B.DEPARTMENT_NAME AS 부서명,
               C.JOB_TITLE AS 직책명
          FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS C
          WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
            AND A.JOB_ID=C.JOB_ID
            AND HIRE_DATE >=TO_DATE('20180101')
            ORDER BY 3
    
안시)
        SELECT A.EMPLOYEE_ID AS 사원번호,
               A.EMP_NAME AS 사원명,
               A.DEPARTMENT_ID AS 부서번호,
               B.DEPARTMENT_NAME AS 부서명,
               C.JOB_TITLE AS 직책명
          FROM HR.EMPLOYEES A
          INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
          INNER JOIN HR.JOBS C ON(A.JOB_ID = C.JOB_ID AND HIRE_DATE >=('20180101'))
        ORDER BY 3

            
            
사용예2) 2020년 4-7월 상품별 판매집계를 조회하시오
        Alias는 상품코드, 상품명, 판매수량, 매출금액이며 매출금액이 큰 상품부터 출력
        SELECT A.PROD_ID AS 상품코드,
               B.PROD_NAME AS 상품명,
              SUM(A.CART_QTY) AS 판매수량,
              SUM(B.PROD_PRICE*A.CART_QTY) AS 매출금액
        FROM CSS02.CART A, CSS02.PROD B
        WHERE A.PROD_ID = B.PROD_ID
          AND SUBSTR(A.CART_NO,1,6) BETWEEN '202004' AND '202007'
          GROUP BY A.PROD_ID, B.PROD_NAME
          ORDER BY 4 DESC
        
ANSI)       
        SELECT A.PROD_ID AS 상품코드,
               B.PROD_NAME AS 상품명,
              SUM(A.CART_QTY) AS 판매수량,
              SUM(B.PROD_PRICE*A.CART_QTY) AS 매출금액
        FROM CSS02.CART A
        INNER JOIN CSS02.PROD B on(A.PROD_ID = B.PROD_ID)
        where SUBSTR(A.CART_NO,1,6) BETWEEN '202004' AND '202007'
         GROUP BY A.PROD_ID, B.PROD_NAME
          ORDER BY 4 DESC
        
사용예3) 2020년 상반기 상품 분류별 매입금액을 조회하시오.
    Alias는 분류코드, 분류명, 매입금액합계
    SELECT C.LPROD_GU AS 분류코드,
           B.LPROD_NM AS 분류명,
           SUM(A.BUY_QTY*C.PROD_COST) AS 매입금액합계
    FROM  CSS02.BUYPROD A, CSS02.LPROD B, CSS02.PROD C
    WHERE A.PROD_ID = C.PROD_ID -- 매입금액을 계산하기 위하여 PROD_COST를 참조가능
      AND C.LPROD_GU =B.LPROD_GU -- 해당 상품의 분류정보 참조
      AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
     GROUP BY C.LPROD_GU, B.LPROD_NM
     ORDER BY 1

위 ANSI FORMAT)
 SELECT C.LPROD_GU AS 분류코드,
           B.LPROD_NM AS 분류명,
           SUM(A.BUY_QTY*C.PROD_COST) AS 매입금액합계
    FROM  CSS02.BUYPROD A
    INNER JOIN CSS02.PROD C  ON(A.PROD_ID = C.PROD_ID AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630'))
    INNER JOIN CSS02.LPROD B ON(C.LPROD_GU = B.LPROD_GU )
    GROUP BY C.LPROD_GU, B.LPROD_NM
     ORDER BY 1
    
사용예4) 2020년 거래처별, 상품별 매출액 집계를 조회하시오.
        Alias는 거래처코드, 거래처명, 상품명, 판매수량, 판매금액
 
 일반)
    SELECT A.BUYER_ID AS 거래처코드,
           A.BUYER_NAME AS 거래처명,
           B.PROD_NAME AS 상품명,
           SUM(C.CART_QTY) AS 판매수량,
           SUM(B.PROD_PRICE*C.CART_QTY) 판매금액
    FROM CSS02.BUYER A, CSS02.PROD B, CSS02.CART C
    WHERE B.PROD_ID = C.PROD_ID -- 판매단가 추출
    AND B.BUYER_ID = A.BUYER_ID
      AND SUBSTR(CART_NO,1,6)BETWEEN '202001' AND '202012' 
    GROUP BY A.BUYER_NAME, B.PROD_NAME,  A.BUYER_ID
    ORDER BY 1
 
 안시)
     SELECT A.BUYER_ID AS 거래처코드,
           A.BUYER_NAME AS 거래처명,
           B.PROD_NAME AS 상품명,
           C.CART_QTY AS 판매수량,
           SUM(B.PROD_PRICE*C.CART_QTY) 판매금액
    FROM CSS02.BUYER A
    INNER JOIN CSS02.PROD B ON(A.BUYER_ID=B.BUYER_ID)
    INNER JOIN CSS02.CART C ON(B.PROD_ID=C.PROD_ID)
     WHERE SUBSTR(CART_NO,1,6)BETWEEN '202001' AND '202012' 
    GROUP BY A.BUYER_NAME, B.PROD_NAME,  A.BUYER_ID, C.CART_QTY
 
        
사용예5) HR 계정에서 미국 이외에 근무하는 직원정보를 조회하시오. 미국의 국가코드는 'US'임
        Alias는 사원번호, 사원명, 부서코드, 부서명, 부서주소이며 부서별로 출력하시오.
        
        SELECT A.EMPLOYEE_ID AS 사원번호,
               A.EMP_NAME AS 사원명,
               B.DEPARTMENT_ID AS 부서코드,
               B.DEPARTMENT_NAME AS 부서명,
               C.STREET_ADDRESS||' '||C.CITY||' '||C.STATE_PROVINCE||' '||D.COUNTRY_NAME AS 부서주소
          FROM HR.EMPLOYEES A
          INNER JOIN HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
          INNER JOIN HR.LOCATIONS C ON(B.LOCATION_ID=C.LOCATION_ID AND C.COUNTRY_ID !='US')
          INNER JOIN HR.COUNTRIES D ON(C.COUNTRY_ID=D.COUNTRY_ID);
    
    
위 문제 일반조인)
        SELECT A.EMPLOYEE_ID AS 사원번호,
               A.EMP_NAME AS 사원명,
               B.DEPARTMENT_ID AS 부서코드,
               B.DEPARTMENT_NAME AS 부서명,
               C.STREET_ADDRESS||' '||C.CITY||' '||C.STATE_PROVINCE||' '||D.COUNTRY_NAME AS 부서주소
          FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.COUNTRIES D
          where A.DEPARTMENT_ID = B.DEPARTMENT_ID
          and B.LOCATION_ID=C.LOCATION_ID AND C.COUNTRY_ID !='US'
          and C.COUNTRY_ID=D.COUNTRY_ID
          group by A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_ID,B.DEPARTMENT_NAME,  C.STREET_ADDRESS||' '||C.CITY||' '||C.STATE_PROVINCE||' '||D.COUNTRY_NAME



사용예6) 2020년 상품별 판매집계를 조회하시오
        
일반)
SELECT A.PROD_ID AS 상품코드,
       A.PROD_NAME AS 상품명,
       SUM(B.CART_QTY) AS 판매집계
FROM CSS02.PROD A, CSS02.CART B
WHERE A.PROD_ID=B.PROD_ID
AND SUBSTR(CART_NO,1,6)BETWEEN '202001' AND '202012'
GROUP BY A.PROD_ID, A.PROD_NAME


조인
SELECT A.PROD_ID AS 상품코드,
       A.PROD_NAME AS 상품명,
       SUM(B.CART_QTY) AS 판매집계
FROM CSS02.PROD A
INNER JOIN CSS02.CART B ON (A.PROD_ID=B.PROD_ID)
WHERE SUBSTR(CART_NO,1,6)BETWEEN '202001' AND '202012'
GROUP BY A.PROD_ID, A.PROD_NAME


사용예6) 2020년 월별회원별 판매집계를 조회하시오.
일반) 
    SELECT EXTRACT(MONTH FROM TO_DATE(SUBSTR(CART_NO,1,8)))  AS 월별,
           A.MEM_NAME AS 회원명,
           SUM(B.CART_QTY) AS 판매집계
    FROM CSS02.MEMBER A, CSS02.CART B
    WHERE A.MEM_ID = B.MEM_ID
    GROUP BY EXTRACT(MONTH FROM TO_DATE(SUBSTR(CART_NO,1,8))), A.MEM_NAME
    ORDER BY 1
    
ANSI) 
    SELECT EXTRACT(MONTH FROM TO_DATE(SUBSTR(CART_NO,1,8)))  AS 월별,
           A.MEM_NAME AS 회원명,
           SUM(B.CART_QTY) AS 판매집계
    FROM CSS02.MEMBER A
    INNER JOIN  CSS02.CART B ON (A.MEM_ID = B.MEM_ID)
     GROUP BY EXTRACT(MONTH FROM TO_DATE(SUBSTR(CART_NO,1,8))), A.MEM_NAME
    ORDER BY 1

사용예7) 사원테이블에서 다음과 같이 출력되도록 조인하시오.
        Alias 사원번호, 사원명, 부서명, 급여
    SELECT B.EMPLOYEE_ID AS 사원번호,
           B.EMP_NAME AS 사원명,
           A.DEPARTMENT_NAME AS 부서명,
           B.SALARY AS 급여
    FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
    WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID

ANSI)
 SELECT B.EMPLOYEE_ID AS 사원번호,
           B.EMP_NAME AS 사원명,
           A.DEPARTMENT_NAME AS 부서명,
           B.SALARY AS 급여
    FROM HR.DEPARTMENTS A
    INNER JOIN HR.EMPLOYEES B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)



사용예) 월별 제일 많이 주문한 사람 출력
    SELECT SUBSTR(A.CART_NO,5,2) AS 월별,
           B.MEM_NAME AS 고객명,
           SUM(A.CART_QTY) AS 주문량
    FROM CSS02.CART A, CSS02.MEMBER B
    WHERE A.MEM_ID = B.MEM_ID
    GROUP BY SUBSTR(A.CART_NO,5,2), B.MEM_NAME
    ORDER BY 1, 3 DESC
        
        
사용예) 50~90번 부서에서 가장 높은 급여를 받는 직종을 표시하고 해당 직종의 평균 근속연수를 계산하시오.
    SELECT A.DEPARTMENT_ID AS 부서번호,
           B.JOB_TITLE AS 잡네임,
           MAX(C.SALARY) AS 급여,
           AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM C.HIRE_DATE)) AS 평균근속연수
    FROM HR.DEPARTMENTS A, HR.JOBS B, HR.EMPLOYEES C
    WHERE A.DEPARTMENT_ID = C.DEPARTMENT_ID
    AND B.JOB_ID = C.JOB_ID
    AND A.DEPARTMENT_ID BETWEEN 50 AND 90
    GROUP BY A.DEPARTMENT_ID, B.JOB_TITLE
    ORDER BY 3