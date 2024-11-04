2024-1021-03) 집계함수
 - SUM AVG, COUNT, MIN, MAX가 제공됨.
 
 사용예) 회원테이블에서 모든 회원들의 마일리지 합계와, 평균마일리지, 인원수, 최대마일리지,
 최소 마일리지를 구하시오
    SELECT SUM(MEM_MILEAGE) AS 마일리지합계,
           ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지,
           COUNT(*) AS 인원수,  -- *을 쓰면 NULL값도 1로 표시함. 갯수로 표시 / 컬럼명을 쓰면 NULL 제외
           MAX(MEM_MILEAGE) AS 최대마일리지,
           MIN(MEM_MILEAGE) AS 최소마일리지
    FROM CSS02.MEMBER;
    
 출력
 74300	3096	24	8700	1200
 

 사용예) 상품테이블에서 상품의 수, 최대판매가, 최소판매가를 구하시오.
    SELECT COUNT(*) 상품의수,
           MAX(PROD_PRICE) AS 최대판매가,
           MIN(PROD_PRICE) AS 최소판매가
    FROM CSS02.PROD  --기본키 컬럼명을 넣으면 공백은 빼고  나옴. 테이블 전체로 넣으면 공백 나올수도


사용예) 2020년 4월 판매수량 합계를 구하시오.
    SELECT SUM(CART_QTY) AS 판매수량합계
    FROM CSS02.CART
    WHERE CART_NO LIKE'202004%'     
    

사용예) 사원테이블에서 부서별 평균급여와 인원수를 조회하시오
    SELECT DEPARTMENT_ID AS 부서,
           ROUND(AVG(SALARY)) AS 평균급여,
           COUNT(*) AS 인원수
    FROM HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID
    ORDER BY 1


사용예) 상품테이블에서 분류별 상품의 수, 평균판매가를 조회하시오.
    SELECT LPROD_GU AS 분류코드,
           COUNT(PROD_ID) AS 상품의수,
           ROUND(AVG(PROD_PRICE)) AS 평균판매가
      FROM CSS02.PROD
      GROUP BY LPROD_GU  --ROLLUP(LPROD_GU) 를 사용하면 총합계 나옴
      ORDER BY 1


사용예) 매입테이블에서 2020년 월별 매입수량합계를 조회하시오.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월,
           SUM(BUY_QTY) AS 매입수량합계
      FROM CSS02.BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE)=2020
    GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    ORDER BY 1
 

사용예) 매입테이블에서 2020년 상품별 매입수량합계를 조회하시오.
    SELECT TO_DATE(BUY_DATE, 'YYYY/MM/DD') AS 년도,
           PROD_ID AS 상품,
           SUM(BUY_QTY) AS 매입수량합계
    FROM CSS02.BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE)=2020
    GROUP BY PROD_ID, BUY_DATE
    ORDER BY 1;


사용예) 매출테이블에서 월별, 상품별 판매수량합계를 조회하시오.
    SELECT SUBSTR(CART_NO,5,2) AS 월,
           PROD_ID AS 상품,
           SUM(CART_QTY) AS 판매수량합계
    FROM CSS02.CART
    GROUP BY SUBSTR(CART_NO,5,2), PROD_ID
    ORDER BY 1


사용예) 사원테이블에서 부서별, 년도별 입사한 사원수를 조회하시오. 
    SELECT DEPARTMENT_ID AS 부서, 
           EXTRACT(YEAR FROM HIRE_DATE) AS 년도,
           COUNT(*) AS 사원수
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID, EXTRACT(YEAR FROM HIRE_DATE)
      ORDER BY 1, 2
      
      
사용예) 사원테이블에서 부서별, 년도별 입사한 사원수를 조회하되 
        입사한 사원수가 5명 이상인 자료만 출력하시오. ★★ HAVING 사용
    SELECT DEPARTMENT_ID AS 부서, 
           EXTRACT(YEAR FROM HIRE_DATE) AS 년도,
           COUNT(*) AS 사원수
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID, EXTRACT(YEAR FROM HIRE_DATE)
      HAVING COUNT(*) >=5
      ORDER BY 1, 2
      
사용예) 매입테이블에서 2020년 월별 매입수량합계 중
        가장 많이 매입한 정보만 출력하시오
    SELECT EXTRACT(MONTH FROM BUY_DATE)||'월' AS 월,
           SUM(BUY_QTY) AS 매입수량합계
      FROM CSS02.BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE)=2020
    GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    ORDER BY 2 DESC
    
    -- 실행하면 뷰에 가상의 행 번호가 생성 됨. ROWNUM 이라고 함.
    -- 집계함수에는 집계함수를 사용할수 없다.
사용예) 회원테이블에서 성별 평균마일리지를 조회하시오.
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '남성'
           ELSE '여성' END AS 구분,
           ROUND(AVG(MEM_MILEAGE)) AS 평균파일리지 
      FROM CSS02.MEMBER
      GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '남성'
           ELSE '여성' END

사용예) 회원테이블에서 년령대별 회원수와 평균마일리지를 조회하시오.
    SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE))-(EXTRACT(YEAR FROM MEM_BIR))/10) AS 년령대,
           COUNT(*) AS 회원수,
           ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
    FROM CSS02.MEMBER
    GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE))-(EXTRACT(YEAR FROM MEM_BIR))/10)
    ORDER BY 1

사용예) 회원테이블에서 거주지별 평균마일리지와 회원수를 조회하시오.
    SELECT SUBSTR(MEM_ADD1,1,2) AS 주소,
           ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지,
           COUNT(*) AS 회원수
    FROM CSS02.MEMBER
    GROUP BY SUBSTR(MEM_ADD1,1,2)