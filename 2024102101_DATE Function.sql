2024-1021-01) 날짜 함수
 - SYSDATE, SYSTIMESTAMP, ADD_MONTHS, NEXT_DAY, LAST_DAY, MONTH_BETWEEN, 
   EXTRACT, ROUND, TRUNC
 
사용예)
    SELECT SYSDATE,
            TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
    FROM DUAL;
    
(사용예) HR계정DML 사원테이블에서 모든 사원들의 입사일을 2년 뒤로 변경하시오
 
 UPDATE HR. EMPLOYEES
    SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,24); 
    -- 24 개월 뒤로 변경
 COMMIT;

사용예) 회원 테이블에서 회원들의 나이를 정확히 OO년 OO월 형식으로 출력하시오
        Alias는 회원번호, 회원명, 생년월일, 나이
        
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_BIR AS 생년월일,
           TRUNC (ROUND(MONTHS_BETWEEN(SYSDATE, MEM_BIR))/12)||'년'||
             MOD (ROUND(MONTHS_BETWEEN(SYSDATE, MEM_BIR)),12)||'개월' AS 나이
    FROM CSS02.MEMBER
    
사용예)  키보드로 년도와 월을 입력받아 해당월에 매입된 상품의 매입수량합계와 매입금액합계를 조회하시오.
ACCEPT P_PERIOD  PROMPT '기간을 입력(YYYYMM) : '
  DECLARE
    L_SDATE DATE := TO_DATE('&P_PERIOD'||'01');
    L_EDATE DATE := LAST_DAY(L_SDATE);
    CURSOR CUR_PERIOD_SUM  IS
      SELECT A.PROD_ID AS APID, 
             B.PROD_NAME AS BNAME,
             SUM(A.BUY_QTY) AS SQTY, 
             SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
        FROM SEM1.BUYPROD A, SEM1.PROD B
       WHERE A.PROD_ID=B.PROD_ID
         AND A.BUY_DATE BETWEEN L_SDATE AND L_EDATE
       GROUP BY A.PROD_ID,B.PROD_NAME;  
  BEGIN
    FOR REC  IN CUR_PERIOD_SUM LOOP
      DBMS_OUTPUT.PUT_LINE('상품번호 : '||REC.APID);
      DBMS_OUTPUT.PUT_LINE('상품명 : '||REC.BNAME);
      DBMS_OUTPUT.PUT_LINE('매입수량 : '||REC.SQTY);
      DBMS_OUTPUT.PUT_LINE('매입금액 : '||REC.BSUM);
      DBMS_OUTPUT.PUT_LINE('------------------------------------------------');      
    END LOOP;
  END;
    
    
사용예) SELECT NEXT_DAY(SYSDATE,'월'),
              NEXT_DAY(SYSDATE,'화요일'),
              NEXT_DAY(SYSDATE,'일요일')
        FROM DUAL;    
    --출력 오늘 10/21 월욜 기준
    2024/10/28	2024/10/22	2024/10/27
    담주 월욜      내일       이번주 일욜
    
** EXTRACT(fmt FROM data)
  - 'date'에서 'fmt'에 해당하는 요소를 반환(숫자자료)
  - fmt는 YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
  
사용예) 2020년  3월 매입자료를 조회하시오. Alias는 날짜, 상품번호, 매입수량
    SELECT BUY_DATE AS 날짜,
           PROD_ID AS 상품번호,
           BUY_QTY AS 매입수량
    FROM CSS02.BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE)=2020
      AND EXTRACT(MONTH FROM BUY_DATE)=3;
    
문제) 장바구니테이블에서 2020년 5월과 7월에 판매된 정보를 출력하시오 --TO DATE 배우고 한다고 함.
      (일자, 상품번호, 수량이며 날짜순으로 출력할 것) 
      
      SELECT 일자, 상품번호, 수량
      FROM CSS02.
    
    
    
    