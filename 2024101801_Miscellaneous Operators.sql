2024-1018-01) 기타연산자 

5. ALL
사용형식)
  expr  관계연산자ALL(값1, 값2,...값N)
  . 주어진 값1 ~ 값N 모두와 사용된 관계연산자를 만족하면 true를 반환
  . 관계연산자 중 '='은 사용할 수 없다.
  . 사용된 관계연산자 중 '>'이 사용되면 '값1' ~ '값n' 중 제일 큰값보다 크면 true
  
사용예) 사원테이블에서 10~50번 부서의 평균급여보다 많은 급여를 받는 사원의
        사원번호, 사원명, 부서번호, 급여를 조회하시오.
    (메인 쿼리)    
    SELECT 사원번호, 사원명, 부서번호, 급여
    FROM HR.EMPLOYEES
    WHERE SALARY>ALL (10~50번 부서의 평균급여);
    
    (서브쿼리 : 10~50번 부서의 평균급여)
    SELECT A.ASAL   -- 아래 중에서 평균급여만 출력하기 위해 이렇게 함.
    FROM (SELECT DEPARTMENT_ID,
            AVG(SALARY) AS ASAL
             FROM HR.EMPLOYEES
             WHERE DEPARTMENT_ID BETWEEN 10 AND 50
             GROUP BY DEPARTMENT_ID)A
             
(결합)
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서번호,
           SALARY AS 급여
    FROM HR.EMPLOYEES
    WHERE SALARY>ALL (SELECT A.ASAL   
                        FROM (SELECT DEPARTMENT_ID,
                        AVG(SALARY) AS ASAL
                        FROM HR.EMPLOYEES
                        WHERE DEPARTMENT_ID BETWEEN 10 AND 50
                        GROUP BY DEPARTMENT_ID)A)
    ORDER BY 4;
    
    
    
    
    