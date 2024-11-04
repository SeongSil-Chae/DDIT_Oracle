2024-1029-01)집합연산자
 - UNION, UNION ALL, INTERSECT, MINUS 제공
 - 연산에 참여하는 SELECT문의 SELECT절에 사용되는 컬럼의 갯수, 자료타입, 순서가 일치해야함
 - 컬럼의 별칭은 첫 번째 SELECT문이 기준이 됨
 - ORDER BY 절은 맨 마지막 SELECT 문에서만 사용가능
 - CLOB, BLOB, BFILE 등의 컬럼이 포함된 SELECT 문은 사용할 수 없음.
 
 1. UNION과 UNION ALL
  - 여러 쿼리의 결과 집합의 합집합 결과를 반환
  - 구조가 다른 여러테이블에서 동일 형태의 자료를 추출하는 경우
  - 열을 행으로 변환하여 조회하는 경우 사용
  
사용예) 2020년 1월과 6월에 매입된 상품들을 조회하시오. (이걸로 UNION, UNION ALL, INTERCEPT 연습 가능)
     SELECT DISTINCT A.PROD_ID AS 상품번호, --39개
            B.PROD_NAME AS 상품명
       FROM CSS02.BUYPROD A, CSS02.PROD B
      WHERE A.PROD_ID=B.PROD_ID
        AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
    UNION 
     SELECT DISTINCT A.PROD_ID,--여기 별칭 쓰는거 의미 없음 --36개
            B.PROD_NAME
       FROM CSS02.BUYPROD A, CSS02.PROD B
      WHERE A.PROD_ID=B.PROD_ID
        AND A.BUY_DATE BETWEEN TO_DATE('20200501') AND TO_DATE('20200531')
        ORDER BY 1 -- 오더바이는 여기 끝에만 사용 해야됨.
        
        
 CREATE TABLE BUDGET(
 PERIOD     CHAR(6),
 BUDGET_AMT NUMBER(5))
    
INSERT INTO BUDGET VALUES('202301', 1000);
INSERT INTO BUDGET VALUES('202302', 2000);
INSERT INTO BUDGET VALUES('202303', 1500);

 CREATE TABLE SALES(
 PERIOD     CHAR(6),
 SLAE_AMT NUMBER(5))
 
 INSERT INTO SALES VALUES('202301', 900);
INSERT INTO SALES VALUES('202302', 2000);
INSERT INTO SALES VALUES('202303', 1000);       

사용예) 2023년  1-3월 계획 대비 실적을 조회하시오.
    SELECT PERIOD, BUDGET_AMT,0 AS SALE_AMT
    FROM BUDGET
    UNION
    SELECT PERIOD, 0 AS BUDGET_AMT, SALE_AMT
    FROM SALES
    ORDER BY 1;

(구조가 다른 여러 테이블에서 동일 형태의 자료를 추출)
    SELECT PERIOD AS 기간,
           SUM(BUDGET_AMT) AS 계획,
           SUM(SALE_AMT) AS 실적,
           LPAD(ROUND(SUM(SALE_AMT)/SUM(BUDGET_AMT),2)*100||'%',5) AS 달성률
      FROM (SELECT PERIOD, BUDGET_AMT,0 AS SALE_AMT
              FROM BUDGET
           UNION
            SELECT PERIOD, 0 AS BUDGET_AMT,SALE_AMT
              FROM SALES
             ORDER BY 1)
    GROUP BY PERIOD
    ORDER BY 1;
             

(사용예)            
 CREATE TABLE SCORE(
    GUBUN VARCHAR2(30),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MAT NUMBER(3));
    
  INSERT INTO SCORE VALUES('중간고사',92,87,67);
  INSERT INTO SCORE VALUES('기말고사',88,80,95);
  
  SELECT * FROM SCORE;
  
  SELECT GUBUN AS 구분,
         '국어' AS 과목,
         KOR AS 점수
    FROM SCORE
  UNION
    SELECT GUBUN AS 구분,
           '영어' AS 과목,
           KOR AS 점수
      FROM SCORE
  UNION
    SELECT GUBUN AS 구분,
           '수학' AS 과목,
           MAT AS 점수
      FROM SCORE           
             
사용예) 2020년 06월 모든 회원별 매출액을 조회하시오.
  SELECT B.MEM_NAME AS 회원명,
         NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS 구매금액
    FROM CSS02.CART A
   RIGHT OUTER JOIN CSS02.MEMBER B ON(A.MEM_ID  = B.MEM_ID)
    LEFT OUTER JOIN CSS02.PROD C ON (A.PROD_ID = C.PROD_ID AND A.CART_NO LIKE '202006%')
    GROUP BY B.MEM_NAME;

1. 회원이름과 0을 출력
    SELECT MEM_NAME, 0 AS AMT
      FROM CSS02.MEMBER
    
2. 2020년 6월 회원별 매출액을 조회하시오
    SELECT D.MEM_NAME AS MEM_NAME, C.SAMT AS AMT
      FROM (SELECT  A.MEM_ID AS MID,
                    SUM(A.CART_QTY*B.PROD_PRICE) AS SAMT
              FROM CSS02.CART A, CSS02.PROD B
             WHERE A.PROD_ID  = B.PROD_ID
               AND A.CART_NO LIKE '202006%'
             GROUP BY A.MEM_ID)C, CSS02.MEMBER D
      WHERE C.MID=D.MEM_ID
    
 3.결합 
    SELECT MEM_NAME AS 회원명,
           SUM(AMT) AS 구매합계
      FROM (SELECT MEM_NAME, 0 AS AMT
             FROM CSS02.MEMBER
    UNION
       SELECT D.MEM_NAME AS MEM_NAME, C.SAMT AS AMT
      FROM (SELECT  A.MEM_ID AS MID,
                    SUM(A.CART_QTY*B.PROD_PRICE) AS SAMT
              FROM CSS02.CART A, CSS02.PROD B
             WHERE A.PROD_ID  = B.PROD_ID
               AND A.CART_NO LIKE '202006%'
             GROUP BY A.MEM_ID)C, CSS02.MEMBER D
      WHERE C.MID=D.MEM_ID)
      GROUP BY MEM_NAME
      
      
 ------------------------------------------------------------
 
 2. 교집합(INTERSECT)
 - 연산에 참여하는 쿼리의 결과 공통된 부분을 반환
 
사용예) 2020년 6월과 2020년 7월에 모두 판매된 상품정보를 출력
    (2020년 6월)
    SELECT DISTINCT A.PROD_ID AS 상품코드,
           B.PROD_NAME AS 상품명
      FROM CSS02.CART A, CSS02.PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.CART_NO LIKE '202006%'
 INTERSECT  
 --(2020년 7월)
     SELECT DISTINCT A.PROD_ID,
           B.PROD_NAME 
      FROM CSS02.CART A, CSS02.PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.CART_NO LIKE '202007%'
     ORDER BY 1
     
3. 차집합 (MINUS)
  - 연산의 참여하는 왼쪽 쿼리의 결과에 오른쪽 쿼리의 결과를 제거한 값을 반환
  - MINUS연산자 앞에 사용되는 쿼리에 따라 결과가 달라짐
 
 사용예) 2020년 6월과 7월에 판매된 상품 중 6월에만 판매된 상품정보를 출력
 --(2020년 6월)
     SELECT DISTINCT A.PROD_ID AS 상품코드,
           B.PROD_NAME AS 상품명
      FROM CSS02.CART A, CSS02.PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.CART_NO LIKE '202006%'
   MINUS  
 --(2020년 7월)
     SELECT DISTINCT A.PROD_ID,
           B.PROD_NAME 
      FROM CSS02.CART A, CSS02.PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.CART_NO LIKE '202007%'
     ORDER BY 1
 
 
 
 
 