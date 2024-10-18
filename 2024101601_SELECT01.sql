2024-1016-01)

예제1) 상품테이블에서 판매가격이 100만원 이상인 상품을 조회하시오오
        Alias는 상품번호,상품명,판매가격 
        SELECT PROD_ID AS 상품번호,
               PROD_NAME AS 상품명,
               PROD_PRICE AS 판매가격
        FROM CSS02.PROD
        WHERE PROD_PRICE>=1000000
        ORDER BY PROD_PRICE, PROD_ID; -- 1번 정렬 후 같은 값이면 3번으로 정렬
        
예제2) 회원테이블에서 마일리지가 2000 미만인 회원정보를 조회하시오. 
        Alias는 회원번호,회원명,직업,마일리지
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_JOB AS 직업,
               MEM_MILEAGE AS 마일리지
        FROM CSS02.MEMBER
        WHERE MEM_MILEAGE<2000
        ORDER BY 4;
        
예제3) 서울에 거주하는 회원정보를 조회하시오
        Alias는 회원번호,회원명,주소
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_ADD1 AS 주소
        FROM CSS02.MEMBER
        WHERE SUBSTR(MEM_ADD1,1,2)='서울'  -- WHERE MEM_ADD1 LIKE '서울%'
        
예제4) 2020년 6월에 구매하지 않은 회원들을 조회하시오
        Alias는 회원번호,회원명,성별,마일리지
        
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '남성회원'
               ELSE '여성회원' END AS 성별,
               MEM_MILEAGE AS 마일리지
        FROM CSS02.MEMBER
        WHERE MEM_ID NOT IN(2020년 6월에 구매한 회원번호)
        
        (2020년 6월에 구매한 회원번호)  -- 위 NOT IN에 들어갈 조건을 또 셀렉문 써서 넣어준다.
        SELECT DISTINCT MEM_ID
        FROM CSS02.CART
        WHERE SUBSTR(CART_NO,1,6)='202006'
        
(결합) -- 1, 2 만든 셀렉문을 결합한다.

        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
               CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '남성회원'
               ELSE '여성회원' END AS 성별,
               MEM_MILEAGE AS 마일리지
        FROM CSS02.MEMBER
        WHERE MEM_ID NOT IN(SELECT DISTINCT MEM_ID
                              FROM CSS02.CART
                             WHERE SUBSTR(CART_NO,1,6)='202006')
        ORDER BY 1

        
예제5) 상품테이블에서 판매가격이 10만원 ~ 20만원에 속하는 상품들을 조회하시오.
        Alias는 상품번호, 상품명, 매입가격, 판매가격
        SELECT PROD_ID AS 상품번호,
               PROD_NAME AS 상품명,
               PROD_COST AS 매입가격,
               PROD_PRICE AS 판매가격
        FROM CSS02.PROD
        WHERE PROD_PRICE BETWEEN 100000 AND 200000
--         WHERE PROD_PRICE>=100000 AND PROD_PRICE<=200000        
        ORDER BY 4;
        
예제6) hr계정의 사원테이블에서 입사일이 2016년 이전이며 급여가 10000이하인 사원들을 조회하시오.
        ALias는 사원번호, 사원명, 입사일, 급여
        SELECT EMPLOYEE_ID AS 사원번호,
               FIRST_NAME||' '||LAST_NAME AS 사원명,
               HIRE_DATE AS 입사일,
               SALARY AS 급여 
        FROM HR.EMPLOYEES
        WHERE HIRE_DATE<'2016/01/01' AND SALARY <=10000
        
예제7) 상품테이블에서 상품의 분류가 'p201' 또는 'p203'에 속하는 상품들을 조회하시오. 
        Alias는 상품번호, 상품명, 분류코드
        
        SELECT PROD_ID AS 상품번호,
               PROD_NAME AS 상품명,
               LPROD_GU 분류코드
        FROM CSS02.PROD
        WHERE LPROD_GU = 'P201' OR LPROD_GU = 'P203'
