2024-1031-04) PL/SQL 
객체지향: 상속 지원, 캡슐화 지원(접근지원자), 다용성 지원  // 조금 부정확하면 객체기반언어 라고 함.

 - 익명블록(대표적), 프로시져, 함수, 트리거, 패키지 등이 제공
 
 1. 익명 블록
  - 이름이 없는 블록
  - 2개의 영역으로 구성
(기술형식)
DECLARE
   선언영역 - 변수, 상수, 커서 선언
BEGIN
   비지니스 로직 처리 
   
   [EXCEPTION 처리영역]
END;


사용예) 키보드로 부서코드를 입력 받아 해당부서에서 가장 먼저 입사한 사원의 
        사원번호, 사원명, 입사일, 급여를 출력하는 익명블록을 작성하시오.

        


 
   ACCEPT P_DEPT_ID PROMPT '부서코드 입력(10~110) : '
  DECLARE
    L_EMP_ID HR1.EMPLOYEES.EMPLOYEE_ID%TYPE;
    -- 참조형 타입 :%TYPE =  데이터 타입이 상관없이 변경하여 사용 함. 행과 같은 타입으로 변경
    L_EMP_NAME VARCHAR2(60);
    L_HDATE DATE;
    L_SALARY NUMBER:=0;
     -- := 배정 연산자로 0을 NUMBER에 넣음
  BEGIN
    SELECT EMPLOYEE_ID,EMP_NAME,HIRE_DATE,SALARY
      INTO L_EMP_ID,L_EMP_NAME,L_HDATE,L_SALARY
      FROM (SELECT EMPLOYEE_ID,EMP_NAME,HIRE_DATE,SALARY
              FROM HR1.EMPLOYEES
             WHERE DEPARTMENT_ID=&P_DEPT_ID    -- & = 참조하라
             ORDER BY HIRE_DATE)
     WHERE ROWNUM=1;
     
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||L_EMP_ID);
    DBMS_OUTPUT.PUT_LINE('사원명 : '||L_EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('입사일 : '||L_HDATE);
    DBMS_OUTPUT.PUT_LINE('급여 : '||L_SALARY);
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('오류발생 : '||SQLERRM);    
  END;
      
  CURSOR 사용)     
      
  ACCEPT P_DEPT_ID PROMPT '부서코드 입력(10~110) : '
  DECLARE
   CURSOR CUR_EMP01 IS
     SELECT EMPLOYEE_ID,EMP_NAME,HIRE_DATE,SALARY
       FROM HR1.EMPLOYEES
      WHERE DEPARTMENT_ID=&P_DEPT_ID 
      ORDER BY HIRE_DATE;
  BEGIN
    FOR REC IN CUR_EMP01 LOOP
      DBMS_OUTPUT.PUT_LINE('사원번호 : '||REC.EMPLOYEE_ID);
      DBMS_OUTPUT.PUT_LINE('사원명 : '||REC.EMP_NAME);
      DBMS_OUTPUT.PUT_LINE('입사일 : '||REC.HIRE_DATE);
      DBMS_OUTPUT.PUT_LINE('급여 : '||REC.SALARY);
      DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('오류발생 : '||SQLERRM);    
  END;       
        
        
        
        
        
        
        
        
        
        
        
        
        
