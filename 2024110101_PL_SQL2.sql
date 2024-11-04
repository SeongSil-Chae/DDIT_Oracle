2024-1101-01)

1. 분기문(if)

사용예) 오늘 날짜의 장바구니 번호를 생성하시오.
  DECLARE
    L_CART_NO CART.CART_NO%TYPE; -- 임시 장바구니 번호
    L_MEM_ID MEMBER.MEM_ID%TYPE := 'c001'; -- 구매 회원번호
    L_TEMP_MID MEMBER.MEM_ID%TYPE; -- 가장 큰 장바구니를 보유한 회원번호
    L_CNT NUMBER := 0; -- CART테이블에 존재하는 오늘 날짜의 자료 수(행의 수)
    L_CART_NO1 VARCHAR2(8) := '20200418';
  BEGIN
    SELECT COUNT(*) INTO L_CNT
        FROM CART
       WHERE CART_NO LIKE L_CART_NO1 || '%';
       
    IF L_CNT = 0 THEN
        L_CART_NO := L_CART_NO1 || TRIM('00001');
    ELSE
        SELECT DISTINCT(MAX(CART_NO)) INTO L_CART_NO
            FROM CART
           WHERE CART_NO LIKE L_CART_NO1 || '%';
          
         SELECT DISTINCT(MEM_ID) INTO L_TEMP_MID
            FROM CART
           WHERE CART_NO = L_CART_NO;
            
        IF L_MEM_ID != L_TEMP_MID THEN
            L_CART_NO := L_CART_NO + 1;
        END IF;        
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('장바구니 번호 : ' || L_CART_NO);
  END;


2. 다중분기문(CASE WHEN ~ THEN     END CASE)
(사용형식-1) 
 CASE 조건식
        WHEN 값1 THEN 명령문1;
        WHEN 값2 THEN 명령문2;
                :
 ELSE
    명령문n;
 END CASE;

(사용형식-2) 
 CASE WHEN 조건식1 THEN 명령문1;
      WHEN 조건식2 THEN 명령문2;
                :
 ELSE
    명령문n;
 END CASE;

사용예) 키보드로 날짜(년,월,일)을 입력 받아 해당일의 요일을 출력하시오.
ACCEPT P_DATE PROMPT '날짜입력(YYYYMMDD) : '
DECLARE
    L_DAYS NUMBER:=0; --서기 1년 1월 1일 부터 입력된 날짜까지 경과된 일수
    L_RESULT VARCHAR2(100); -- 결과 문자열 저장
BEGIN
    L_DAYS:=TRUNC(TO_DATE('&P_DATE'))-TO)DATE('00010101')-1;
    CASE WHEN MOD(L_DAYS, 7) WHEN 0 THEN L_RESULT := TO_DATE('&P_DATE')||'일은 일요일입니다.';
                             WHEN 1 THEN L_RESULT := TO_DATE'&P_DATE')||'일은 월요일입니다.';
                             WHEN 2 THEN L_RESULT := TO_DATE('&P_DATE')||'일은 화요일입니다.';
                             WHEN 3 THEN L_RESULT := TO_DATE('&P_DATE')||'일은 수요일입니다.';
                             WHEN 4 THEN L_RESULT := TO_DATE('&P_DATE')||'일은 목요일입니다.';
                             WHEN 5 THEN L_RESULT := TO_DATE('&P_DATE')||'일은 금요일입니다.';
                            
    ELSE 
    L_RESULT := TO_DATE('&P_DATE')||'일은 토요일입니다.';
 ELSE CASE;
 DBMS_OUTPUT.PUT_LINE(L_RESULT);
END;

                            






