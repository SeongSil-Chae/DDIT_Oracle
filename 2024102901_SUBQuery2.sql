2020-1029-01)서브쿼리

사용예)사원테이블에서 직책별 가장 많은 급여를 바는 사원의 사원번호, 사원명, 직책, 급여를
      급여가 많은순으로 출력하시오.
    (메인쿼리: 사원번호, 사원명, 직책, 급여
    SELECT A.EMPLOYEE_ID AS 사원번호,
           A.EMP_NAME AS 사원명,
           B.JOB_TITLE AS 직책,
           A.SALARY AS 급여
      FROM HR.EMPLOYEEES A, HR.JOBS B
     WHERE A.JOB_ID= B.JOB_ID
     AND (A.JOB_ID, A.SALARY) = ( 서브쿼리)
    
      
    (서브쿼리: 직책별 가장 많은 급여를 바는 사원)
    SELECT  JOB_ID AS 직책,
           MAX(SALARY) AS 급여
      FROM HR.EMPLOYEES
      GROUP BY JOB_ID

(결합)
    SELECT A.EMPLOYEE_ID AS 사원번호,
           A.EMP_NAME AS 사원명,
           B.JOB_TITLE AS 직책,
           A.SALARY AS 급여
      FROM HR.EMPLOYEES A, HR.JOBS B
     WHERE A.JOB_ID= B.JOB_ID
     AND (A.JOB_ID, A.SALARY) IN (SELECT  JOB_ID AS 직책,
                                         MAX(SALARY) AS 급여
                                   FROM HR.EMPLOYEES
                                  GROUP BY JOB_ID)
                                  
    -- 마지막 AND 에서 양쪽 2개씩 같이 맞춰야 함. ( 다중행 연산자)                              
                                  
                                  
                            

사용예) 회원테이블에서 남성회원의 가장 많은 마일리지보다 많은 마일리지를 가지고 있는 여성회원의 
        회원번호, 회원명, 마일리지를 구하시오
        
        (서브쿼리: 남성회원의 가장 많은 마일리지)
        SELECT MEM_MILEAGE AS 마일리지
          FROM CSS02.MEMBER
         WHERE SUBSTR(MEM_REGNO2,1,1) IN('1','3') 
         
         (메인쿼리: 회원번호, 회원명, 마일리지)
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
               MEM_MILEAGE AS 마일리지
          FROM CSS02.MEMBER
         WHERE SUBSTR(MEM_REGNO2,1,1) IN('2','4')  
           AND MEM_MILEAGE > ALL(SELECT MEM_MILEAGE AS 마일리지
                                   FROM CSS02.MEMBER
                                  WHERE SUBSTR(MEM_REGNO2,1,1) IN('1','3'))
         

사용예) 2020년 전자제품(분류코드: P201) 중 매입금액을 기준으로 가장 적게 매입된 상품보다
        많이 매입된 상품의 상품코드, 상품명,분류명,매입금액을 조회하시오.
        
   (서브쿼리: 매입금액을 기준으로 가장 적게 매입된 상품)
   SELECT C.CMIN
     FROM(SELECT B.PROD_ID AS 상품번호,
                  SUM(A.BUY_QTY*B.PROD_COST) AS CMIN
             FROM CSS02.BUYPROD A,CSS02.PROD B
            WHERE B.PROD_ID  LIKE 'P201%'
            GROUP BY B.PROD_ID
            ORDER BY 2 )C
    WHERE ROWNUM =1
     
   (메인쿼리 : 많이 매입된 상품의 상품코드, 상품명,분류명,매입금액)
   SELECT C.PROD_ID AS 상품코드,
          C.PROD_NAME AS 상품명,
          D.LPROD_GU AS 분류명,
          MIN(A.BUY_QTY*C.PROD_COST) AS 매입금액
    FROM CSS02.PROD C, CSS02.LPROD D
    
(결합)  -- 실패
   SELECT B.PROD_ID AS 상품코드,
          B.PROD_NAME AS 상품명,
          D.LPROD_GU AS 분류코드,
          SELECT SUM(A.BUY_QTY*C.PROD_COST) AS MI
            FROM CSS02.BUYPROD A, CSS02.COST C
    FROM CSS02.LPROD D
    WHERE  H.MI <ALL (SELECT C.CMIN
                                       FROM(SELECT B.PROD_ID AS 상품번호,
                                                   SUM(A.BUY_QTY*B.PROD_COST) AS CMIN
                                              FROM CSS02.BUYPROD A,CSS02.PROD B
                                             WHERE B.PROD_ID  LIKE 'P201%'
                                             GROUP BY B.PROD_ID
                                             ORDER BY 2 )C
                                     WHERE ROWNUM =1)
                        
   (교수님 코드) -- 문제 자체가 어렵게 되었음
   SELECT A.PID AS 상품코드,
         A.FNAME AS 상품명,
         A.FSUM AS 매입금액
    FROM (SELECT B.PROD_ID AS PID,
                 P.PROD_NAME AS FNAME,
                 SUM(B.BUY_QTY*P.PROD_COST) AS FSUM
            FROM CSS02.BUYPROD B, CSS02.PROD P
           WHERE B.PROD_ID=P.PROD_ID
             AND B.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')
           GROUP BY B.PROD_ID,P.PROD_NAME)A
   WHERE A.FSUM >(SELECT C.GSUM
                    FROM (SELECT SUM(A.BUY_QTY*B.PROD_COST) AS GSUM
                            FROM CSS02.BUYPROD A, CSS02.PROD B
                           WHERE A.PROD_ID=B.PROD_ID
                             AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')
                             AND B.LPROD_GU='P102'
                           GROUP BY A.PROD_ID
                           ORDER BY 1) C
                   WHERE ROWNUM=1)        
   ORDER BY 3;
    

 사용예) 2020년 모든 상품별 매입수량합계를 조회하시오.
 
(서브쿼리 : 2020년 상품별 매입수량합계)
    SELECT PROD_ID,
           SUM(BUY_QTY)
      FROM CSS02.BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')
     GROUP BY PROD_ID
 
 (메인쿼리 : 모든 상품별 매입수량합계)
   SELECT B.PROD_ID,
          B.BSUM
     FROM CSS02.PROD A, (SELECT PROD_ID,
                                SUM(BUY_QTY) AS BSUM
                           FROM CSS02.BUYPROD
                          WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')
                          GROUP BY PROD_ID)B
    WHERE A.PROD_ID=B.PROD_ID(+)
 
 
 
 
 
        
        
        
        
        
        