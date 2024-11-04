2024-1028-01) 서브쿼리
 - 알려지지 않은 조건에 기반한 결과를 반환할 때 사용되는 쿼리
 - ( )로 묶어 사용하며 조건절에 사용되는 서브쿼리는 연산자 오른쪽에 기술한다.
 - 분류
  . 일반서브쿼리/중첩서브쿼리/ 인라인서브쿼리
  . 단행서브쿼리/다중행서브쿼리
  . 연관성 있는서브쿼리/연관성 없는 서브쿼리
  
사용예)
1. 사원테이블에서 평균급여보다 많은 급여를 받는 사원의 사원번호, 사원명, 급여를 조회
  (메인쿼리 : 사원의 사원번호, 사원명, 급여)
  SELECT EMPLOYEE_ID AS 사원번호,
         MEM_NAME AS 사원명,
         SALARY AS 급여
    FROM HR.EMPLOYEES
    WHERE SALARY > (서브쿼리)
    
  (서브쿼리 : 평균급여) -- 급여에 라운드 안씌움. 출력해서 보여줄게 아니라서
 SELECT AVG(SALARY)
   FROM HR.EMPLOYEES
   
   (결합) -- 107번 실행됨.
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         SALARY AS 급여
    FROM HR.EMPLOYEES
    WHERE SALARY> ( SELECT AVG(SALARY)
                       FROM HR.EMPLOYEES) ;
                       
    (메인쿼리 : 사원의 사원번호, 사원명, 급여)
  SELECT A.EMPLOYEE_ID AS 사원번호,
         A.EMP_NAME AS 사원명,
         A.SALARY AS 급여
    FROM HR.EMPLOYEES A, (평균) B
    WHERE A.SALARY>B.평균급여
    
    (서브쿼리: 평균급여)
    SELECT AVG(SALARY)
    FROM HR.EMPLOYEES
    
    (결합) -- 1번 실행 됨.
  SELECT A.EMPLOYEE_ID AS 사원번호,
         A.EMP_NAME AS 사원명,
         A.SALARY AS 급여, 
         ROUND(B.ASAL) AS 평균급여
    FROM HR.EMPLOYEES A, (SELECT AVG(SALARY) AS ASAL
                            FROM HR.EMPLOYEES) B
    WHERE A.SALARY>B.ASAL
    ORDER BY 3
    
  (일반서브쿼리 사용)
    SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         SALARY AS 급여
         (SELECT ROUND(AVG(SALARY))
         FROM HR.EMPLOYEES) AS 평균급여
    FROM HR.EMPLOYEES
    WHERE SALARY> ( SELECT AVG(SALARY)
                       FROM HR.EMPLOYEES) ;
    
2. 2020년 상반기 가장 많은 수량을 매입한 상품이 속한 상품정보를 조회하시오.
  Alias는 상품번호, 상품명, 매입단가
  (메인쿼리 : 상품번호, 상품명, 매입단가)
  SELECT A.PROD_ID AS 상품번호,
         A.PROD_NAME AS 상품명,
         A.PROD_COST AS 매입단가
    FROM CSS02.PROD A
    WHERE A.PROD_ID=(서브쿼리의 상품코드)
    
  (서브쿼리 : 2020년 상반기 매입수량이 가장 많은 상품의 상품코드) -- 서브쿼리의 서브쿼리 한 이유는 정렬 후 1번을 빼내려고
   SELECT B.PROD_ID
     FROM (SELECT PROD_ID,
                  SUM(BUY_QTY)
             FROM CSS02.BUYPROD
            WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200630')
            GROUP BY PROD_ID
            ORDER BY 2 DESC)B
  WHERE ROWNUM=1;
  
  (결합)
   SELECT A.PROD_ID AS 상품번호,
         A.PROD_NAME AS 상품명,
         A.PROD_COST AS 매입단가
    FROM CSS02.PROD A,    (SELECT B.PROD_ID AS BPID
                            FROM (SELECT PROD_ID,
                                         SUM(BUY_QTY)
                                    FROM CSS02.BUYPROD
                                   WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200630')
                                   GROUP BY PROD_ID
                                   ORDER BY 2 DESC)B
                                   WHERE ROWNUM=1) C
    WHERE A.PROD_ID=C.BPID
    
    (중첩서브쿼리)
  SELECT PROD_ID AS 상품번호,
         PROD_NAME AS 상품명,
         PROD_COST AS 매입단가
    FROM CSS02.PROD A
    WHERE PROD_ID=(SELECT B.PROD_ID AS BPID
                       FROM (SELECT PROD_ID,
                                    SUM(BUY_QTY)
                                    FROM CSS02.BUYPROD
                                   WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200630')
                                   GROUP BY PROD_ID
                                   ORDER BY 2 DESC)B
                                   WHERE ROWNUM=1) 

    
3. 위 2번문제에서 가장 많은 수량을 매입한 상품을 납품한 거래처 정보를 조회하시오.
  Alias는 거래처코드, 거래처명, 주소
  SELECT A.BUYER_ID AS 거래처코드,
         D.BUYER_NAME AS 거래처명,
         D.BUYER_ADD1||' '||D.BUYER_ADD2 AS 주소
    FROM CSS02.PROD A, CSS02.BUYER D,
                         (SELECT B.PROD_ID AS BPID
                            FROM (SELECT PROD_ID,
                                         SUM(BUY_QTY)
                                    FROM CSS02.BUYPROD
                                   WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
                                   GROUP BY PROD_ID
                                   ORDER BY 2 DESC)B
                            WHERE ROWNUM=1) C
    WHERE A.PROD_ID=C.BPID
      AND A.BUYER_ID=D.BUYER_ID;
  
  
4. 회원테이블에서 마일리지가 많은 3명의 회원의 회원번호, 회원명, 마일리지를 조회하시오.
    (메인쿼리: 회원번호, 회원명, 마일리지)
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 마일리지
      FROM CSS02.MEMBER
     
     (서브쿼리 : 마일리지 랭킹)
     SELECT RANK() OVER (ORDER BY MEM_MILEAGE DESC)
     FROM CSS02.MEMBER
     WHERE ROWNUM BETWEEN 1 AND 3
     
     (결합)
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 마일리지
      FROM (SELECT MEM_ID,
                   MEM_NAME,
                   MEM_MILEAGE,
                   RANK() OVER (ORDER BY MEM_MILEAGE DESC) AS BRANK
              FROM CSS02.MEMBER)
    WHERE BRANK BETWEEN 1 AND 3
    GROUP BY MEM_ID, MEM_NAME, MEM_MILEAGE
    
(교수님 버전)4. 회원테이블에서 마일리지가 많은 3명의 회원의 회원번호, 회원명, 마일리지를 조회하시오.
    (메인쿼리: 회원번호, 회원명, 마일리지)
 SELECT  A.MEM_ID AS 회원번호,
         A.MEM_NAME AS 회원명,
         A.MEM_MILEAGE AS 마일리지
 FROM(SELECT MEM_ID,
        MEM_NAME,
        MEM_MILEAGE
   FROM CSS02.MEMBER   
   ORDER BY 3 DESC) A
   WHERE ROWNUM<=3;
  
  
5. 위 4번 결과 3명의 회원의 2020년 5월 구매현황(회원번호,회원명,구매금액합계)를 조회하시오.

    SELECT A.MEM_ID AS 회원번호,
           A.MEM_NAME AS 회원명,
           A.MEM_MILEAGE AS 마일리지,
           B.CART_NO AS 회원번호,
           SUM(B.CART_QTY*C.PROD_PRICE) AS 구매금액합계
      FROM (SELECT MEM_ID,
                   MEM_NAME,
                   MEM_MILEAGE,
                   RANK() OVER (ORDER BY MEM_MILEAGE DESC) AS BRANK
              FROM CSS02.MEMBER)
    WHERE BRANK BETWEEN 1 AND 3
    GROUP BY MEM_ID, MEM_NAME, MEM_MILEAGE
    
    (서브쿼리 : 회원번호, 회원명, 구매금액합계)
    SELECT A.MEM_ID AS 회원번호,
           A.MEM_NAME AS 회원명,
           B.CART_NO AS 날짜,
           SUM(B.CART_QTY*C.PROD_PRICE) AS 구매금액합계
      FROM CSS02.MEMBER A, CSS02.CART B, CSS02.PROD C 
     WHERE A.MEM_ID =B.MEM_ID
     AND B.PROD_ID = C.PROD_ID
     AND SUBSTR(B.CART_NO,1,8) BETWEEN  TO_CHAR('20200501') AND TO_CHAR('20200531')
    GROUP BY A.MEM_ID , A.MEM_NAME,B.CART_NO
      
      (결합)
SELECT A.MEM_ID AS 회원번호,
       A.MEM_NAME AS 회원명,
       A.MEM_MILEAGE AS 마일리지,
       B.CART_NO AS 날짜,
       SUM(B.CART_QTY * C.PROD_PRICE) AS 구매금액합계
  FROM (SELECT MEM_ID,
               MEM_NAME,
               MEM_MILEAGE,
               RANK() OVER (ORDER BY MEM_MILEAGE DESC) AS BRANK
          FROM CSS02.MEMBER
       ) A
      LEFT OUTER JOIN CSS02.CART B ON A.MEM_ID = B.MEM_ID
      LEFT OUTER JOIN CSS02.PROD C ON B.PROD_ID = C.PROD_ID
 WHERE A.BRANK BETWEEN 1 AND 3
   AND SUBSTR(B.CART_NO, 1, 8) BETWEEN '20200501' AND '20200531'
 GROUP BY A.MEM_ID, A.MEM_NAME, A.MEM_MILEAGE, B.CART_NO;

(교수님 버전)5. 위 4번 결과 3명의 회원의 2020년 5월 구매현황(회원번호,회원명,구매금액합계)를 조회하시오.
SELECT D.AMID AS 회원번호,
       D.ANAME AS 회원명,
       SUM(C.CART_QTY*B.PROD_PRICE) AS 구매금액합계
  FROM CSS02.PROD B, CSS02.CART C, (SELECT  A.MEM_ID AS AMID,
                                           A.MEM_NAME AS ANAME
                                    FROM(SELECT MEM_ID,
                                                MEM_NAME,
                                                MEM_MILEAGE
                                           FROM CSS02.MEMBER   
                                          ORDER BY 3 DESC) A
                                         WHERE ROWNUM<=3)D
 WHERE B.PROD_ID=C.PROD_ID
   AND D.AMID=C.MEM_ID
   AND C.CART_NO LIKE '202005%'
   GROUP BY D.AMID , D.ANAME

7. 사원테이블에서 자신이 소속된 부서의 평균급여보다 더 작은 급여를 받는 
    사원의 사원번호, 사원명, 부서번호, 급여, 부서평균급여를 출력하시오.
   SELECT A.EMPLOYEE_ID AS 사원번호,
          A.EMP_NAME AS 사원명,
          A.DEPARTMENT_ID AS 부서번호,
          A.SALARY AS 급여,
          부서평균급여
     FROM HR.EMPLOYEES A,
    WHERE A.SALARY < (부서별평균급여)
    
(서브쿼리: 부서별 평균급여)
  SELECT B.DEPARTMENT_ID,
         AVG(B.SALARY) AS BAVG
    FROM HR.EMPLOYEES B
    GROUP BY B.DEPARTMENT_ID
    
(결합)
   SELECT A.EMPLOYEE_ID AS 사원번호,
          A.EMP_NAME AS 사원명,
          A.DEPARTMENT_ID AS 부서번호,
          A.SALARY AS 급여,
          (SELECT ROUND(AVG(SALARY))
             FROM HR.EMPLOYEES C
             WHERE C.DEPARTMENT_ID=A.DEPARTMENT_ID) AS 부서평균급여
     FROM HR.EMPLOYEES A,
    WHERE A.SALARY < (SELECT B.BAVG
                       FROM (SELECT DEPARTMENT_ID,
                                    AVG(SALARY) AS BAVG
                               FROM HR.EMPLOYEES 
                               GROUP BY DEPARTMENT_ID)B
                       WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID)
    ORDER BY 3, 4 DESC
    
(INLINE SUBQUERY)
   SELECT A.EMPLOYEE_ID AS 사원번호,
          A.EMP_NAME AS 사원명,
          A.DEPARTMENT_ID AS 부서번호,
          A.SALARY AS 급여,
          ROUND(B.BAVG) AS 부서평균급여
     FROM HR.EMPLOYEES A,(SELECT DEPARTMENT_ID,
                                    AVG(SALARY) AS BAVG
                               FROM HR.EMPLOYEES 
                               GROUP BY DEPARTMENT_ID)B
    WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
    AND A.SALARY<B.BAVG
    ORDER BY 3, 4 DESC
    
6. 2020년 1월 상품별 매입수량을 구하여 재고수불테이블을 갱신하시오.
(메인쿼리: 재고수불테이블 UPDATE)
UPDATE CSS02.REMAIN A
   SET A.REMAIN_I = A.REMAIN_I+(2020년 1월 해당 상품의 매입수량),
       A.REMAIN_J_99 = A.REMAIN_J_99+(2020년 1월 해당 상품의 매입수량),
       A.REMAIN_DATE = 2020년 1월 31일
       
UPDATE CSS02.REMAIN A
   SET (A.REMAIN_I, A.REMAIN_J_99,A.REMAIN_DATE  = (2020년 1월 해당 상품의 매입수량을 구하는 서브쿼리의
                                                    SELECT 절에 기술
                                                    SELECT A.REMAIN_I+매입수량, A.REMAIN_J_99+매입수량,
                                                             2020년 1월31일
                                                      FROM (상품별 매입수량) B
                                                     WHERE B.상품코드=A.상품코드)
(서브쿼리 : 2020년 1월 해당 상품의 매입수량)
  SELECT PROD_ID,
         SUM(BUY_QTY) AS BSUM
    FROM CSS02.BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
    GROUP BY PROD_ID

COMMIT;
(결합)
UPDATE CSS02.REMAIN A
SET (A.REMAIN_I, A.REMAIN_J_99,A.REMAIN_DATE)  = 
    (SELECT A.REMAIN_I+B.BSUM, A.REMAIN_J_99+B.BSUM, TO_DATE('20200131')
       FROM (SELECT PROD_ID,
        SUM(BUY_QTY) AS BSUM
       FROM CSS02.BUYPROD
      WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
      GROUP BY PROD_ID) B
      WHERE B.PROD_ID = A.PROD_ID)
WHERE A.PROD_ID IN (SELECT DISTINCT PROD_ID
                      FROM CSS02.BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131'))



사용예) 상품의 분류별 평균 매입가보다 더 큰 매입가격을 보유한 상품의 상품번호, 상품명, 매입가격을 조회하시오.
  (메인쿼리: 상품의 상품번호, 상품명, 매입가격)
  SELECT PRID_ID AS 상품번호,
         PROD_NAME AS 상품명,
         PROD_COST AS 매입가격
    FROM CSS02.PROD
   WHERE PROD_COST > (분류별 평균 매입가)
   
  (서브쿼리: 분류별 평균 매입가)
  SELECT A.ACOS
    FROM (SELECT LPROD_GU,
                 AVG(PROD_COST) AS ACOS
            FROM CSS02.PROD
           GROUP BY LPROD_GU)A
(위랑 같음 개선됨)
SELECT AVG(PROD_COST)
  FROM CSS02.PROD
 GROUP BY LPROD_GU) 

(결합)

  SELECT PROD_ID AS 상품번호,
         PROD_NAME AS 상품명,
         PROD_COST AS 매입가격
    FROM CSS02.PROD
   WHERE PROD_COST > ANY (SELECT AVG(PROD_COST)
                            FROM CSS02.PROD
                            GROUP BY LPROD_GU)
  ORDER BY 3 DESC

(EXISTS 연산자 사용)
 - EXISTS연산자 왼쪽은 EXPR을 기술하지 않음
  즉, WHERE EXISTS (SUBQUERY) 형식으로 사용
 - EXISTS 다음의 서브쿼리 결과 1행이라도 있으면 참(true)를 반환하고 결과가 없으면 거짓(false)를
  반환함(결과의 내용은 상관하지 않음. 따라서 서브쿼리의 SELECT 절을 SELECT 1로 사용하는 경우가 대부분임)
  
 (EXISTS 활용) 
   SELECT B.PROD_ID AS 상품번호,
          B.PROD_NAME AS 상품명,
          B.PROD_COST AS 매입가격
     FROM CSS02.PROD B
    WHERE EXISTS (SELECT 1
                    FROM (SELECT AVG(PROD_COST)ACOS
                            FROM CSS02.PROD
                           GROUP BY LPROD_GU)A
                           WHERE B.PROD_COST<A.ACOS)
