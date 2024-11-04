2024-1017-01) 기타 연산자
 - BETWEEN, LIKE, IN, SOME, ANY, ALL, EXISTS 연산자가 제공됨.
 
 1. BETWEEN 연산자
  - 범위를 지정할때 사용
  - 논리 연산자 'AND'를 대신하여 사용
  
(사용형식)
  expr   BETWEEN 값1 AND 값2
   - 값1과 값2는 같은 타입이어야 함.
   
사용예) 상품테이블에서 분류코드가 P100 대인 모든 상품을 조회하시오.
      Alias는 상품코드, 상품명, 분류코드
(AND 연산자 사용)
      SELECT PROD_ID AS 상품코드,
             PROD_NAME AS 상품명,
             LPROD_GU AS 분류코드
      FROM CSS02.PROD
      WHERE  LPROD_GU>=UPPER('P100') AND LPROD_GU<=UPPER('P199')    -- UPPER =  대문자로 바꿔라.
      
(BETWEEN 사용)
      SELECT PROD_ID AS 상품코드,
             PROD_NAME AS 상품명,
             LPROD_GU AS 분류코드
      FROM CSS02.PROD
      WHERE  LPROD_GU BETWEEN UPPER('P100') AND UPPER('P199')
      
사용예) 사원 테이블에서 급여가 5000~8000 사이의 사원들을 조회하시오.
        Alias는 사원번호, 사원명, 부서코드, 급여
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서코드,
           SALARY AS 급여
    FROM HR.EMPLOYEES
    WHERE SALARY BETWEEN 5000 AND 8000
    ORDER BY 4;
        
        
사용예) 매입테이블에서 2020년 2월 매입정보를 조회하시오.
        Alias는 날짜, 매입상품번호, 매입수량
    SELECT BUY_DATE AS 날짜,
           BUY_PROD AS 매입상품번호,
           BUY_QTY AS 매입수량
        FROM CSS02.BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE(20200201) AND LAST_DAY(TO_DATE(20200201))     -- TO_DATE = 문자든 숫자든 날짜로 바꾸세요.
        

2. LIKE
 - 패턴비교 연산자
 - 패턴구성에 '%'와 '_' 문자열(와일드 카드)이 사용됨
 - 많은 결과를 산출하기 때문에 효율성은 다소 낮음
 - 문자열 비교 연산자임(날짜, 숫자, 데이터에는 사용하지 말것)
 - '%'
   . '%'이 사용된 위치 이후 모든 문자열과 대응
   . 공백문자열도 대응됨
   . ex)
    '대%' : '대'로 시작하는 모든 문자열과 대응(참을 반환)
    '%대' : '대'로 끝나는 모든 문자열과 대응(참을 반환)
    '%대%':  주어진 문자열 내부에 '대'가 존재하면 참을 반환
 - '_'
  . '_'이 사용된 위치 이후 하나의 문자열과 대응
  .ex)
    '대_' : '대'로 시작하고 글자가 2글자이면 참을 반환
    '_대' : '대'로 끝나고 2글자의 문자열이면 참을 반환
    '_대_' : 주어진 문자열 내부에 '대'가 존재하면 참을 반환
 
 사용예) 거주지가 충남인 회원의 회원명, 주소 , 마일리지를 조회
    SELECT MEM_NAME AS 회원명,
           MEM_ADD1||' '||MEM_ADD2 AS 주소,
           MEM_MILEAGE AS 마일리지
    FROM CSS02.MEMBER
    WHERE MEM_ADD1 LIKE '충남%'
    
 사용예) 김씨성을 가진 회원의 이름, 주소, 마일리지 조회
    SELECT MEM_NAME AS 회원명,
           MEM_ADD1||' '||MEM_ADD2 AS 주소,
           MEM_MILEAGE AS 마일리지
    FROM CSS02.MEMBER
    WHERE MEM_NAME LIKE '김%'
    
 사용예) 2020년 6월 판매정보조회
       Alias는 날짜, 판매상품번호, 판매수량
       SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS 날짜,
              PROD_ID AS 판매상품번호,
              CART_QTY AS 판매수량
       FROM CSS02.CART
       WHERE CART_NO LIKE '202006%'
        
 사용예) 2020년 1월 매입정보
       Alias는 날짜, 판매상품번호, 판매수량
       SELECT BUY_DATE AS 날짜,
              BUY_PROD AS 판매상품번호,
              BUY_QTY AS 판매수량
       FROM CSS02.BUYPROD
       WHERE BUY_DATE BETWEEN '20200101' AND '20200131'
       -- WHERE BUY_DATE LIKE('2020/01%') 날짜 사이에 / - 이런게 있을 수 있으니 LIKE 안쓴다.
 
 
 3. IN 연산자
  - 다중행 연산자(복수개의 결과를 비교)
  - IN연산자는 내부에 '='기능이 내포됨
  - 주어진 다수의 데이터 중 어느 하나와 일치하면 TRUE 반환
  - OR 연산자로 바꾸어 사용할 수 있음
  - 불연속적이거나 불규칙적인 값을 비교 
사용형식)
  expr   IN(값, 값2,...)
 
 사용예) 사원테이블에서 10,20,90번 부서에 속한 사원정보를 조회하시오
       Alias는  사원번호, 사원명, 부서번호
(OR 연산자 사용)
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서번호
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID=10
        OR DEPARTMENT_ID=20
        OR DEPARTMENT_ID=90
        
(IN 연산자 사용)
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서번호
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID IN(10,20,90)
    
사용예)소속사원의 수가 10명 이상인 부서의 부서번호, 부서명, 위치코드를 출력하시오.
--서브쿼리 = 알지 못하는 조건을 구해내는 것
    
서브쿼리 : 소속사원의 수가 10명 이상인 부서의 부서번호
    SELECT A.DEPARTMENT_ID
      FROM (SELECT DEPARTMENT_ID,
             COUNT(*)
              FROM HR.EMPLOYEES
           GROUP BY DEPARTMENT_ID
           HAVING COUNT(*)>=10) A  -- A는 뷰의 별칭으로 사용
    
    (서브쿼리 만들어서 위에 넣어줌 프롬에)
    SELECT DEPARTMENT_ID,
           COUNT(*)
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID
      HAVING COUNT(*)>=10 A
      
 메인쿼리 : 부서 테이블에서 부서번호, 부서명, 위치코드
   SELECT DEPARTMENT_ID AS 부서번호,
          DEPARTMENT_NAME AS 부서명,
          LOCATION_ID AS 위치코드
     FROM HR.DEPARTMENTS
     WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
                             FROM (SELECT DEPARTMENT_ID,
                                   COUNT(*)
                                   FROM HR.EMPLOYEES
                                   GROUP BY DEPARTMENT_ID
                                   HAVING COUNT(*)>=10) A)
                                   

                                   
                                   
 4. ANY(SOME)
사용형식)
  expr  관계연산자 ANY(SOME)(값1,값2,...값N)
  . 주어진 값1 ~ 값N 중 어느 하나와 사용된 관계연산자를 만족하면 true를 반환
  . 사용된 관계연산자가 '='인 경우 IN과 같다
  . 사용된 관계연산자 중 '>'이 사용되면 '값1'~'값N'중 제일 작은값보다 크면 true
  
사용예) 사원테이블에서 급여가 3000,4000,5000 이상인 사원의 사원명, 부서번호, 급여를 출력
    SELECT EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서번호,
           SALARY AS 급여
      FROM HR.EMPLOYEES
      WHERE SALARY > ANY(3000,4000,5000)
    --WHERE SALARY > SOME(3000,4000,5000)
      ORDER BY 3
                                   
      SELECT EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서번호,
           SALARY AS 급여
      FROM HR.EMPLOYEES
      WHERE SALARY = ANY(3080,4620,5000)
      ORDER BY 3                                 
 
 
 
 
 
 
 