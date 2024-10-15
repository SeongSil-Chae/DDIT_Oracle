2024-1015-01)SELECT 문

사용예) 회원테이블에서 모든 회원의 회원번호, 회원명, 주소, 마일리지를 조회하시오.
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_ADD1||' '||MEM_ADD2 AS 주소, -- || 이거는 +      ' ' 이거는 문자열
           MEM_MILEAGE AS 마일리지 -- " 마 일 리 지" 띄어 쓸거면 쌍따음표 넣어야됨.
      FROM CSS02.MEMBER
      
      
사용예) 분류테이블의 내용을 조회하시오.
        Alias는 순번, 분류코드, 분류명
    SELECT LPROD_ID AS 순번,
           LPROD_GU AS 분류코드,
           LPROD_NM AS 분류명
      FROM CSS02.LPROD;
        
        
사용예) 회원테이블에서 회원들의 거주지 종류를 조회하시오.
    SELECT DISTINCT SUBSTR(MEM_ADD1,1,2)  -- ADD1에서 첫글자에서 두글자 까지
      FROM CSS02.MEMBER;

사용예) 사원테이블에서 급여가 10000이상인 사원정보를 조회하시오.
        Alias는 사원번호, 사원명,입사일,급여
    SELECT  EMPLOYEE_ID AS 사원번호,
            EMP_NAME AS 사원명,
            HIRE_DATE AS 입사일,
            SALARY AS 급여
      FROM HR.EMPLOYEES
     WHERE SALARY>=10000;
        
        
사용예) 사원테이블에서 부서별 사원수와 평균급여를 조회하시오.
        단, 부서코드순으로 출력하시오.
    SELECT DEPARTMENT_ID AS 부서코드,
           COUNT(*) AS 사원수,
           ROUND (AVG(SALARY)) AS 평균급여 -- ROUND를 넣으면 소수점을 반올림 해줌.
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID
      ORDER BY 1 ASC -- 1은 셀렉에서 첫번째 컬럼을 선택한다라는 뜻. (DEPARTMENT_ID)
        
    (평균급여가 많은 부서부터 출력)
    SELECT DEPARTMENT_ID AS 부서코드,
           COUNT(*) AS 사원수,
           ROUND (AVG(SALARY)) AS 평균급여 -- ROUND를 넣으면 소수점을 반올림 해줌.
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID
      ORDER BY 평균급여  DESC -- ORDER BY ROUND (AVG(SALARY)) DESC  
      
    -- ORDER BY 에서 평균급여 라도 별칭 써도 되고 3(셀렉트 목차) 써도 됨.
    -- ASC 작은순 정렬,   DESC 높은순 정렬
    
사용예) 사원테이블에서 사원번호, 사원명, 입사일 출력하시오.
        단, 급여가 적은 사원부터 출력
        
    SELECT EMPLOYEE_ID AS사원번호,
           EMP_NAME AS 사원명,
           HIRE_DATE AS 입사일,
           SALARY 급여
    FROM HR.EMPLOYEES
    ORDER BY SALARY    -- 이 테이블의 컬럼이라면 얼마든지 쓸 수 있다. 단 출력에서 급여가 나오진 않음.
                         -- 많은 순 정렬 됨
    
    
    
사용예) 회원테이블에서 연령대별 평균 마일리지를 조회하시오. + 회원수   
    SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)* 10||'대' AS 연령대,      --EXTRACT : 추출하다
            COUNT(*) AS 회원수,
           AVG(MEM_MILEAGE) AS 평균마일리지
    FROM CSS02.MEMBER
    GROUP BY 연령대
    ORDER BY 1;


1. 연산자
 - 사칙연산자(산술연산자) : +, -, /, *
 - 관계연산자(비교연산자) : >, <, >=, <=, =, != (<>) --<> 이건 크거나 작다. != 이거도 크거나 작거나
 - 논리연산자 : NOT, AND, OR 
 - NULL처리용 : IS NULL, IS NOT NULL
 - 기타연산자 : LIKE, BETWEEN, IN(SOME), ANY, ALL, EXISTS
 
 
 1) 사칙연산자(산술연산자)
  - 값이 반환
  - 조건문 구성 시 필수 아님.
 
 사용예) 사원테이블에서 영업실적코드(COMMISSION_PCT)를 사용하여 보너스와 지급액을 계산하여
        출력하시오. --보너스 전체 지급이라 조건 없음
        보너스(BONUS)=급여(SALARY) * 영업실적코드(COMMISSION_PCT)의 50%
        지급액=급여(SALARY)+보너스(BONUS)
        Alias는 사원번호, 사원명, 급여, 보너스, 지급액이다.
        
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명,
               SALARY AS 급여,
               NVL(SALARY * COMMISSION_PCT * 0.5,0) AS 보너스,
               SALARY+NVL(SALARY * COMMISSION_PCT * 0.5,0) AS 지급액
          FROM HR.EMPLOYEES
 -- NVL 사용하면 NULL 값을 없애준다. 보너스 없는사람도 급여 기본급 지급 됨.
 
 
 2) 관계연산자와 논리연산자
   - 조건식 구성에 사용(WHERE 절이나 또는 표현식(DECODE, CASE ~ WHEN THEN)에 사용)
   - 관계연산자는 대소관계를 판단하여 참(true) 또는 거짓(false)를 반환
   - 논리연산자는 다수개의 관계식을 결합
   ---------------------------------------
    입력                  출력
   A   B            AND   OR   EX-OR
   ---------------------------------------
   0   0             0     0     0
   0   1             0     1     1
   1   0             0     1     1
   1   1             1     1     0
   
   사용예) 키보드로 날짜를 입력 받아 요일을 출력하시오 (아래는 참조만)
   
ACCEPT P_DATE  PROMPT '날짜입력(년월일) : '  --ACCEPT 입력값 출력하는거다
  DECLARE
    L_REMINDER  NUMBER:=0;
    L_DAYS  NUMBER:=0;
    L_RESULT  VARCHAR2(100);
  BEGIN
    L_DAYS:=TRUNC(TO_DATE('&P_DATE'))-TRUNC(TO_DATE('00010101'))-1;
    L_REMINDER:=MOD(L_DAYS,7);
    CASE L_REMINDER WHEN 0 THEN L_RESULT:=TO_DATE('&P_DATE')||'은 일요일 입니다';  -- 스위치 절과 비슷
                    WHEN 1 THEN L_RESULT:=TO_DATE('&P_DATE')||'은 월요일 입니다';
                    WHEN 2 THEN L_RESULT:=TO_DATE('&P_DATE')||'은 화요일 입니다';
                    WHEN 3 THEN L_RESULT:=TO_DATE('&P_DATE')||'은 수요일 입니다';
                    WHEN 4 THEN L_RESULT:=TO_DATE('&P_DATE')||'은 목요일 입니다';
                    WHEN 5 THEN L_RESULT:=TO_DATE('&P_DATE')||'은 금요일 입니다';
                    ELSE
                                L_RESULT:=TO_DATE('&P_DATE')||'은 토요일 입니다';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(L_RESULT);  -- 출력
  END;
   
 사용예) 키보드로 년도를 입력 받아 윤년 또는 평년을 판단하여 출력
   ACCEPT P_YEAR PROMPT '년도입력(YYYY) : '
   DECLARE
      L_RESULT VARCHAR2(100);
   BEGIN
     IF MOD(&P_YEAR,4)=0 AND MOD(&P_YEAR,100)!=0) OR (MOD(&P_YEAR,400)=0) THEN
         L_RESULT := &P_YEAR||'년은 윤년입니다.');
      ELSE   
         L_RESULT := &P_YEAR||'년은 평년입니다.');
      END IF;
      DBMS_OUTPUT.PUT_LINE(L_RESULT);
   END;
