2024-1021-02) 형변환함수
 - CAST, TO_CHAR, TO_NUMBER, TO_DATE
 
1. TO_CHAR(char|number|date [,fmt] )

 1) 날짜형식지정문자열
-----------------------------------------------------------------------
 문자열             의미            예
-----------------------------------------------------------------------
 AD, BC            서기         SELECT TO_CHAR(SYSDATE,'BC AD') FROM DUAL;
 CC                세기         SELECT EXTRACT(YEAR FROM SYSDATE)||'년 => ' || TO_CHAR(SYSDATE,'CC')||'세기임' FROM DUAL;
 YYYY,YYY,YY       년도         SELECT TO_CHAR(SYSDATE,'YYYY YYY YY Y YEAR') FROM DUAL;  
 Y, YEAR
 
 MONTH,MON          월          SELECT TO_CHAR(SYSDATE,'YYYY MONTH, YYYY MON') FROM DUAL;
 RM, MM                         SELECT TO_CHAR(SYSDATE,'YYYY MM, YYYY RM') FROM DUAL;
 DD, DDD, J        날짜          SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DDD') FROM DUAL;
                                SELECT TO_CHAR(SYSDATE, 'YYYY-MM-J') FROM DUAL;
 AM, PM             오전/오후    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD PM') FROM DUAL;
 HH, HH12, HH24     시간        SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DD HH:MI:SS') FROM DUAL;
 MI                 분          SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DD HH:MI:SS SSSSS') FROM DUAL;
 SS,SSSSS           초          
 사용자가 만든 형식 지정 문자열    SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') FROM DUAL;
 
 
 
 출력
 1. 서기 서기
 2. 2024년 => 21세기임
 3. 2024 024 24 4 TWENTY TWENTY-FOUR
 4. 2024 10월, 2024 10월  -- 영어면 MONTH: OCTOBER , MON: OCT
 5. 2024 10, 2024 X   : 로마숫자 월 표시 된 것임.
 6. 2024-10-295
 7. 2024-10-2460605
 8. 2024-10-21 오전
 9. 2024-10-21 21 11:07:25 (현재시각 출력)
 10. 2024-10-21 21 11:08:57 40137
 11. 2024년 10월 21일  -- " "로 문자열 추가하여 사용
 
 
 2) 숫자형식지정문자열
 -----------------------------------------------------------------------
 문자열   의미                                   예
------------------------------------------------------------------------
 9, 0    출력형식의자리, 유효한숫자인경우출력        SELECT TO_CHAR(PROD_COST,'9,999,999'),
                                                        TO_CHAR(PROD_COST,'0,000,000')
                                                  FROM CSS02.PROD;
         출력형식의자리, 무효한숫자인경우0출력       SELECT ROUND(SALARY/7,2),
                                                        TO_CHAR(ROUND(SALARY/7,2),'99,999.99'),
                                                        TO_CHAR(ROUND(SALARY/7,2),'00,000.00')
                                                    FROM HR.EMPLOYEES;
 $,L     화폐기호 출력                             SELECT TO_CHAR(PROD_COST,'L9,999,999') FROM CSS02.PROD;                                              
 MI      음수기호)'-'를 오른쪽에 출력               SELECT TO_CHAR(-12345,'999,999MI'),
                                                        TO_CHAR(12345,'999,999MI') 
                                                    FROM DUAL; 
 PR      음수를 "<>"에 표현                        SELECT TO_CHAR(-12345,'999,999PR'),
                                                        TO_CHAR(12345,'999,999PR') 
                                                    FROM DUAL;


출력
1.    210,000	 0,210,000 << 이런 느낌  9는 공백 0은 0을 넣어서 출력
2. 660	    660.00	 00,660.00  << 소수점에서는 9,0 모드 둘다 같음.
3.  ￦210,000  < 숫자 앞에 L 붙이면 우리나라 사람이라 원화가 나옴. 앞에 $를 붙이면 달러로 표시됨.
4.  12,345-	 12,345  -- 잘 안씀
5.  <12,345>	  12,345 



2. TO_NUMBER(CHAR [,FMT])
  - 주어진 문자열 자료(char)를 숫자로 변환
  - 'char'에 숫자로 변환될 수 없는 문자가 포함된 경우 => 
  해당자료가 출력되기 위해 필요한 형식지정문자열을'fmt'에 기술하여 기본 숫자형 자료를 반환해야함.
    
사용예)
    SELECT TO_NUMBER('12345'),
           TO_NUMBER('12345.67'),
           TO_NUMBER('12,345.67','99,999.99'),
           TO_NUMBER('￦123,456','L000,000')
        FROM DUAL;
        
 출력
12345	12345.67	12345.67	123456
        

3. TO_DATE(char|number [,fmt])
 - 주어진 문자열 자료(char)나 숫자자료를 날짜 형식의 자료로 변환
 - 'char'에 날짜로 변환될 수 없는 문자가 포함된 경우=>해당 자료가 출력되기 위해 필요한 
   형식지정문자열을 'fmt'에 기술하여 기본 날짜형 자료를 반환해야함
 - 'char|number'는 날짜자료로 변환될 수 있는 요소를 모두 포함해야 한다.(즉, 년월일)
 
사용예)
    SELECT TO_DATE('20200430'),
           TO_DATE(20200630)
        FROM DUAL;
        
     SELECT TO_CHAR(TO_DATE('20200430123127','YYYYMMDDHH24MISS'),'YYYY-MM-DD HH24:MI:SS'),
        TO_DATE(20200630)
        FROM DUAL;
        
 출력
 1. 2020/04/30	2020/06/30  <문자열, 숫자를 6월 31일로 넣으면 에러남
 2. 2020/04/30	2020/06/30  
 3. 2020-04-30 12:31:27	    2020/06/30      



4. CAST(expr   as     type)

사용예) 2020년 07월 매출현황을 조회하시오. Alias는 날짜, 상품코드, 매출수량이다.

SELECT CAST(SUBSTR(CART_NO,1,8) AS DATE) AS 날짜,
       PROD_ID AS 상품코드,
       CART_QTY AS 매출수량
    FROM CSS02.CART
    WHERE CART_NO LIKE '202007%'

출력
2020/07/01 (기본 날짜 타입)	P201000013	  5