2024-1101-02) 반복문
 - 오라클의 반복문은 LOOP ~ END LOOP, WHILE ~ END LOOP;, FOR ~ END LOOP문을 제공
 - 주로 커서 사용이 목적임
1.LOOP ~ END LOOP
 - 가장 기본이되는 반복구조제공
 - 무한루프 제공
  (사용형식)
   LOOP
     반복명령문(들);
    [EXIT WHEN 조건;]
    [반복명령문(들);]
            :
    END LOOP;
    . 'EXIT WHEN 조건' : 조건이 참이면 반복을 벗어남

사용예) 구구단의 7단을 출력하시오
  DECLARE
    L_CNT NUMBER:=1;
  BEGIN
    LOOP
    EXIT WHEN L_CNT>9;
    DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT||' = ' || 7*L_CNT);
    L_CNT:= L_CNT+1;
    END LOOP;
  END;
  
  사용예) 회원테이블에서 대전에 거주하는 회원의 회원번호, 회원명, 마일리지, 주소를
        출력하는 PL/SQL프로그램을 작성하시오
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_MILEAGE AS 마일리지,
         MEM_ADD1||' '||MEM_ADD2 AS 주소
    FROM MEMBER
   WHERE MEM_ADD1 LIKE '대전%'; 
   
  DECLARE
    L_MID MEMBER.MEM_ID%TYPE;
    L_MNAME VARCHAR2(200);
    L_MILE NUMBER:=0;
    L_ADDRESS VARCHAR2(2000);
    
    CURSOR CUR_MEM02 IS
      SELECT MEM_ID,MEM_NAME,MEM_MILEAGE,MEM_ADD1||' '||MEM_ADD2
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '대전%';
  BEGIN
    OPEN CUR_MEM02;
    LOOP
      FETCH CUR_MEM02 INTO L_MID,L_MNAME,L_MILE,L_ADDRESS;
      EXIT WHEN CUR_MEM02%NOTFOUND;
      DBMS_OUTPUT.PUT(RPAD(L_MID,6));
      DBMS_OUTPUT.PUT(RPAD(L_MNAME,10));
      DBMS_OUTPUT.PUT(TO_CHAR(L_MILE,'99,999'));
      DBMS_OUTPUT.PUT_LINE('  '||L_ADDRESS);
      DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('회원 수 : '||CUR_MEM02%ROWCOUNT||' 명');
    CLOSE CUR_MEM02;
  END; 

(거주지를 키보드로 받아 처리)  
  ACCEPT P_ADD  PROMPT '거주지를 2글자로 입력 : '
  DECLARE
    L_MID MEMBER.MEM_ID%TYPE;
    L_MNAME VARCHAR2(200);
    L_MILE NUMBER:=0;
    L_ADDRESS VARCHAR2(2000);
    
    CURSOR CUR_MEM02(A_ADD VARCHAR2) IS
      SELECT MEM_ID,MEM_NAME,MEM_MILEAGE,MEM_ADD1||' '||MEM_ADD2
        FROM MEMBER
       WHERE MEM_ADD1 LIKE A_ADD||'%';
  BEGIN
    OPEN CUR_MEM02('&P_ADD');
    LOOP
      FETCH CUR_MEM02 INTO L_MID,L_MNAME,L_MILE,L_ADDRESS;
      EXIT WHEN CUR_MEM02%NOTFOUND;
      DBMS_OUTPUT.PUT(RPAD(L_MID,6));
      DBMS_OUTPUT.PUT(RPAD(L_MNAME,10));
      DBMS_OUTPUT.PUT(TO_CHAR(L_MILE,'99,999'));
      DBMS_OUTPUT.PUT_LINE('  '||L_ADDRESS);
      DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('회원 수 : '||CUR_MEM02%ROWCOUNT||' 명');
    CLOSE CUR_MEM02;
  END;   
  
2. WHILE LOOP ~ END LOOP
 - 웹 개발언어의 WHILE문과 같은 기능 제공
 - 조건을 먼저 평가한 후 평가된 값이 참이면 반복명령(LOOP ~ END LOOP)을 수행하고
   거짓이면 WHILE 다음 명령을 수행
   
(사용형식)
    WHILE 조건 LOOP
      반복처리 명령문(들);
        : 
    END LOOP;
  
  
  3. 일반 FOR문
  - 웹 개발언어의 FOR문과 같은 기능 제공
  - FOR에 기술된 제어변수에 초기값을 배정한 후 최종 값과 비교하여 최종값보다 작거나 같으면 
    반복명령(LOOP ~ END LOOP)를 수행하고 크면 FOR 다음 명령을 수행
사용형식) 
  FOR 제어변수 IN [REVERSE]초기값..최종값 LOOP
      반복처리명령문(들);
            :
  END LOOP;
  
사용예) 구구단의 7단
  DECLARE 
  BEGIN
    FOR I IN 1..9 LOOP
      DBMS_OUTPUT.PUT_LINE('7 * '||I||' = '||7*I);
    END LOOP;
  END;
  
  
  
  
  4. 커서용 FOR문 
   - 커서에 사용되는 FOR 문
   - FOR문을 이용하여 커서를 사용하는 경우 OPEN, FETCH, CLOSE명령이 생략됨.
사용형식)
  FOR 레코드명 IN 커서명|in-line 서브쿼리로 구현한 커서본문(SELECT문) LOOP
     반복문(들);
        :
  END LOOP;
  . FOR문 안에서 커서의 컬럼을 참조하는 방법
    => 레코드명.커서컬럼명으로 참조함
  . 제어변수나 레코드명은 시스템에서 제공함
  
  
  
  
  
  
  
  
  
  
  