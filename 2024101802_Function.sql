2024-1018-02) 문자열 함수
 - CONCAT, LOWER, UPPER, INITCAP, LENGTH, LENGTHB,
   LPAD, RPAD, LTRIM, RTRIM, TRIM, SUBSTR, REPLACE, INSTR
   
   1. CONCAT
   
사용예) 회원테이블에서 여성회원들의 회원번호, 회원명, 주민번호를 출력하시오.
        단, 주민번호는 XXXXXX-XXXXXXX형식으로 출력하시오.
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           CONCAT(MEM_REGNO1,'-',MEM_REGNO2) AS 주민번호,
           MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호2
        FROM CSS02.MEMBER
        WHERE SUBSTR(MEM_REGNO2,1,1) IN ('2','4')
        
    2. LOWER, UPPER    
    
사용예) 상품테이블에서 분류코드가 'P201', 'P202'에 속한 상품의
        상품번호, 상품명, 판매가격을 출력
    SELECT PROD_ID AS 상품번호,
           PROD_NAME AS 상품명,
           PROD_PRICE AS 판매가격
      FROM CSS02.PROD
      WHERE LOWER(LPROD_GU) IN ('p201', 'p202')


    3. LPAD, RPAD / NVL2(NULL 아니면 출력, NULL이면 출력)
        LPAD(입력값 , 9) 9칸 공백 주고 글자 넣기
        
사용예) 상품테이블에서 상품의 크기(PROD_SIZE)를 조회하여 데이터가 없으면(NULL이면)
        크기컬럼에 '크기정보 없음'을 출력하시오. 출력할 컬럼은 상품명, 매입단가, 크기이다.
    SELECT  PROD_NAME AS 상품명,
            PROD_COST AS 매입단가,
            NVL2(PROD_SIZE,LPAD(PROD_SIZE,9), '크기정보 없음') AS 크기
    FROM CSS02.PROD
        
    SELECT LPAD(PROD_NAME,25,'*'),   -- 왼쪽 공백 25개를 만들고 거기에 *로 채우기
        TO_CHAR(PROD_COST,'9,999,999') AS 매입가격,
        TO_CHAR(PROD_PRICE,'9,999,999') AS 매입가격
        FROM CSS02.PROD
        
 3. LTRIM, RTRIM       
   문자열 지우기
사용예)
    SELECT LTRIM('AABABBCABAB','AB') FROM DUAL;
      -- A,B 가 있으면 다 지우고 새로운 거 있으면 그때부터 안지워짐.
    SELECT RTRIM('BAABABCBABAB','AB') FROM DUAL;
    SELECT LTRIM('BAABABCBABAB') FROM DUAL;
    SELECT TRIM('  BAABAB  ' ) FROM DUAL;
    
사용예) 오늘 날짜의 장바구니번호를 생성하시오.  -- 이건 미완성이라 ;;
    CREAT OR REPLACE FUNCTION CREAT_CART_NO(P_DATE IN DATE)
    RETURN VARCHAR2
    AS
       L_CART_NO CSS02.CART.CART_NO%TYPE;
       L_CNT NUMBER:=0;
    BEGIN 
    SELECT COUNT(*) INTO L_CNT
        FROM CSS02.CART
        WHERE CART_NO LIKE TO_CHAR(P_DATE,'YYYYMMDD')||'%'
        
        IF L_CNT=0 THEN
        L_CART_NO:=TO_CHAR(P_DATE,'YYYYMMDD')||'0001'
        ELSE
        SELECT MAX(DISTINCT(CART_NO))+1 INTO L_CART_NO
        FROM CSS02.CART
        WHERE CART_NO:=TO_CHAR(P_DATE,'YYYYMMDD')||'%'
    END IF
    RETURN L_CART_NO
    END;
    
  4. REPLACE
사용예) 상품테이블에서 상품명 중 '대우'를 찾아 'DAEWOO'로 변경하고, 
        또 상품의 설명(RPOD_OUTLINE) 값 중 모든 공백을 제거하시오.
        출력은 상품코드, 상품명, 상품 설명
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           REPLACE(PROD_NAME,'대우','DAEWOO') AS 상품명1, --'대우'를 'DAEWOO'로 변경
           PROD_OUTLINE AS "상품 설명",
           REPLACE(PROD_OUTLINE, ' ') AS "상품 설명"  -- 공백을 찾아 지움
      FROM CSS02.PROD; 
  
        
        
        
  5. SUBSTR    SUBSTR('문자열~~~~@@@', 2,5)  2: 2번째 글자부터 5개 출력,
            -2는 뒤에서 2번째부터 뒤로 출력 (최대 2개 가능)
        
사용예)
  SELECT SUBSTR('대전시 중구 계룡로 846', 2,5) AS COL1,
         SUBSTR('대전시 중구 계룡로 846', 2) AS COL2,
         SUBSTR('대전시 중구 계룡로 846', -2,5) AS COL3,
         SUBSTR('대전시 중구 계룡로 846', 2,50) AS COL4
    FROM DUAL;
        
사용예) 주민등록번호를 사용하여 회원들의 나이를 구하시오. 출력은 회원명, 주민번호, 나이
    SELECT MEM_NAME AS 회원명,
           CONCAT(MEM_REGNO1, '-',MEM_REGNO2) AS 주민번호,
           CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','2') THEN
                     EXTRACT(YEAR FROM SYSDATE)-('19'||SUBSTR(MEM_REGNO1,1,2))
                     ELSE EXTRACT(YEAR FROM SYSDATE)-('20'||SUBSTR(MEM_REGNO1,1,2))
                     END AS 나이
    FROM CSS02.MEMBER;
    

    
    
    
    
    

        
        