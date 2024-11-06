2024-1101-03)커서(CORSOR)
 - 광의의 커서는 SQL명령의 영향을 받은 행들의 집합
 - 협의의 커서는 SELECT문의 결과 집합
 - 커서의 사용목적은 SQL 결과 집합의 자료에 접근하여 해당 자료를 편집할 수 있는 기능을 제공
 - FOR문을 제외한 커서의 사용절차 : 생청(선언영역) -> OPEN -> FETCH -> CLOSE로 구성  -- FETCH 얘가 더 수행할 게 있는지 알려줌.
 - FOR문에서 커서를 사용하는 경우 OPEN, FETCH, CLOSE 생략
 - CORSOR를 다시 열려고 닫아야됨.
 - 커서의 종류 : 묵시적커서(IMPLICITE CURSOR), 명시적커서(EXPLICITE CURSOR)
 
 - 묵시적 커서
   . 커서선언문이 사용되지 않은 커서로 SELECT문의 결과를 의미하며 SELECT문의 결과가 출력되기 시작하면
   OPEN되었다가 결과 출력이 끝나면 자동으로 CLOSE됨. 따라서 항상 CLOSE 상태임
 - 커서속성
 -----------------------------------------------------------------
   속성                  의미
 -----------------------------------------------------------------
  SQL%ISOPEN           커서가 오픈 상태이면 참(true), 닫혀진 상태이면 거짓(false) 반환
                       묵시적커서는 항상 false임
  SQL%FOUND            FETCH할 자료(행)이 있으면 true, 없으면 false 반환                  
  SQL%NOTFOUND         FETCH할 자료(행)이 있으면 false, 없으면 true 반환
  SQL%ROWCOUNT         커서에 포함된 행의 수 반환         
  
  - 명시적 커서
   . 커서선언문에 의해 생성된 커서
 - 커서속성
 -----------------------------------------------------------------
   속성                  의미
 -----------------------------------------------------------------
  커서명%ISOPEN           커서가 오픈 상태이면 참(true), 닫혀진 상태이면 거짓(false) 반환                    
  커서명%FOUND            FETCH할 자료(행)이 있으면 true, 없으면 false 반환                  
  커서명%NOTFOUND         FETCH할 자료(행)이 있으면 false, 없으면 true 반환
  커서명%ROWCOUNT         커서에 포함된 행의 수 반환         
  

사용형식)
  CURSOR 커서명[(변수명 타입명,...)] IS   -- 타입명에서는 크기쓰지않고 타입명만 쓴다
    SELECT 문;
    
    
1) OPEN 문
  . 커서를 사용가능한 상태로 전환
  사용형식)
  OPEN 커서명[(매개변수list);
  
2) FETCH 문
  . 커서 내부의 자료를 행단위로 읽어올 때 사용
사용형식)
  FETCH 커서명 INTO 변수list;
   . 커서에 포함된 컬럼의 수와 INTO절의 변수의 수는 반드시 일치
   . 커서에 포함된 컬럼이 INTO절의 변수에 MAPPING되어 값을 전달함
   . 대부분의 FETCH문은 반복문 내부에 기술
  
3) CLOSE 문
  . 사용이 완료된 커서는 CLOSE되야 재 OPEN될 수 있음.
사용형식)
    CLOSE 커서명;
  
    
사용예) 충남에 거주하는 회원들의 2020년 5월 구매현황을 조회하시오.
        Alias는 회원번호, 회원명, 구매액
      Alias는 회원번호, 회원명, 구매액
  DECLARE
    L_MID MEMBER.MEM_ID%TYPE;
    L_MNAME VARCHAR2(100);
    L_AMT NUMBER:=0;
    
    CURSOR CUR_MEM03  IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '충남%'; 
  BEGIN
    OPEN CUR_MEM03;
    LOOP
      FETCH CUR_MEM03 INTO L_MID,L_MNAME;
      EXIT WHEN CUR_MEM03%NOTFOUND;
      SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_AMT
        FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202005%'
         AND A.PROD_ID=B.PROD_ID
         AND A.MEM_ID=L_MID;
      DBMS_OUTPUT.PUT(L_MID||' ');
      DBMS_OUTPUT.PUT(L_MNAME||' ');
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(L_AMT,'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------');      
    END LOOP;
  END;
      
(WHILE문 사용)
  DECLARE
    L_MID MEMBER.MEM_ID%TYPE;
    L_MNAME VARCHAR2(100);
    L_AMT NUMBER:=0;
    
    CURSOR CUR_MEM03  IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '충남%'; 
  BEGIN
    OPEN CUR_MEM03;
    FETCH CUR_MEM03 INTO L_MID,L_MNAME;
    WHILE CUR_MEM03%FOUND LOOP
      SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_AMT
        FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202005%'
         AND A.PROD_ID=B.PROD_ID
         AND A.MEM_ID=L_MID;
      DBMS_OUTPUT.PUT(L_MID||' ');
      DBMS_OUTPUT.PUT(L_MNAME||' ');
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(L_AMT,'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------'); 
      FETCH CUR_MEM03 INTO L_MID,L_MNAME;
    END LOOP;
  END;
  
(FOR문)
  DECLARE
    L_AMT NUMBER:=0;
    CURSOR CUR_MEM03  IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '충남%'; 
  BEGIN
    FOR REC IN CUR_MEM03 LOOP
      SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_AMT
        FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202005%'
         AND A.PROD_ID=B.PROD_ID
         AND A.MEM_ID=REC.MEM_ID;
      DBMS_OUTPUT.PUT(REC.MEM_ID||' ');
      DBMS_OUTPUT.PUT(REC.MEM_NAME||' ');
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(L_AMT,'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------'); 
    END LOOP;
  END;
  
  (인라인 FOR LOOP 문)
  DECLARE
    L_AMT NUMBER:=0;
  BEGIN
    FOR REC IN (SELECT MEM_ID,MEM_NAME FROM MEMBER WHERE MEM_ADD1 LIKE '충남%') LOOP
      SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_AMT
        FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202005%'
         AND A.PROD_ID=B.PROD_ID
         AND A.MEM_ID=REC.MEM_ID;
      DBMS_OUTPUT.PUT(REC.MEM_ID||' ');
      DBMS_OUTPUT.PUT(REC.MEM_NAME||' ');
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(L_AMT,'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------'); 
    END LOOP;
  END;  


