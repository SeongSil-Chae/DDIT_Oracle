2024-1016-01)

예제1) 상품테이블에서 판매가격이 100만원 이상인 상품을 조회하시오오
        Alias는 상품번호,상품명,판매가격 
        SELECT PROD_ID AS 상품번호,
               PROD_NAME AS 상품명,
               PROD_PRICE AS 판매가격
        FROM CSS02.PROD
        WHERE PROD_PRICE>=1000000;
예제2) 회원테이블에서 마일리지가 2000 미만인 회원정보를 조회하시오. 
        Alias는 회원번호,회원명,직업,마일리지
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_JOB AS 직업,
               MEM_MILEAGE AS 마일리지
        FROM CSS02.MEMBER
        WHERE MEM_MILEAGE<2000
        
예제3) 서울에 거주하는 회원정보를 조회하시오
        Alias는 회원번호,회원명,주소
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_ADD1 AS 주소
        FROM CSS02.MEMBER
        WHERE MEM_ADD1 LIKE '서울%'
        
예제4) 2020년 6월에 구매하지 않은 회원들을 조회하시오
        Alias는 회원번호,회원명,성별,마일리지
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               SUBSTR(MEM_REGNO2,1,1) IN '2', '4'||'여자' AS 성별,
               MEM_MILEAGE AS 마일리지
        FROM CSS02.MEMBER
        WHERE 
        
예제5) 상품테이블에서 판매가격이 10만원 ~ 20만원에 속하는 상품들을 조회하시오.
        Alias는 상품번호, 상품명, 매입가격, 판매가격
        SELECT PROD_ID AS 상품번호,
               PROD_NAME AS 상품명,
               PROD_COST AS 매입가격,
               PROD_PRICE AS 판매가격
        FROM CSS02.PROD
        WHERE PROD_PRICE>=100000 AND PROD_PRICE<=200000;
        
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
