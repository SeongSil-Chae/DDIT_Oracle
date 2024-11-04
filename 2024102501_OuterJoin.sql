2024-1025-01) 외부조인
 - 내부조인은 조인조건을 만족하는 자료만 결과로 출력
 - 외부조인은 더 많은 쪽을 기준으로 부족한 테이블에 NULL값으로 구성된 행을 삽입한 후 조인 수행
 - 일반 외부조인 연산자는 '(+)'이며 이연사자는 부족한 테이블쪽에 추가한다.
 (주의사항) 
 . 복수개의 조인조건 중 여러개가 외부 조인이 필요한 경우 모두 외부조인 연산자를 추가해야함.
 . A, B, C 세개의 테이블이 외부조인하는 경우 한 테이블이 동시에 나머지 두 테이블과 외부조인 될 수 없다.
  즉 A=B(+) AND C=B(+)는 허용되지 않음. 단, A=B(+) AND B=C(+)는 허용됨
 . 일반 외부조인문의 WHERE절에 일반조건이 포함된경우 결과가 내부조인으로 변경출력됨
    => 해결책으로 서브쿼리를 사용하여 해결하거나 ANSI조인을 사용하여야 한다.
사용형식-일반외부조인)
    SELECT 컬럼LIST
      FROM 테이블1 [별칭1], 테이블2 {별칭2] [,...]
     WHERE 테이블1.컬럼=테이블2.컬럼(+)
                :
    - '(+)' 연산자가 어느쪽에 사용되든 결과는 같다
    - '테이블1.컬럼(+)=테이블2.컬럼(+)'은 허용되지 않음.
   
사용형식-ANSI외부조인)
    SELECT 컬럼LIST
      FROM 테이블1 [별칭1]
      REIGHT|LEFT|FULL OUTER JOIN 테이블2 [별칭2] ON (조인조건 [AND 일반조건])
                :
    [WHERE 일반조건]
     . RIGHT : OUTER JOIN 다음에 기술된 테이블에 더 많은 자료가 존재하는 경우
     . LEFT : FROM절쪽의 테이블에 더 많은 자료가 존재하는 경우
     . FULL : 양쪽 모두에 자료가 부족한 경우(일반외부조인에서 허용되지 않은 '테이블1.컬럼(+)=테이블2.컬럼(+)'에 해당
     . WHERE 절이 사용되면 내부조인으로 변형됨.
     -- 여기서는 COUNT(*) 사용 안함
     
사용예) 상품테이블에서 모든 분류별 상품의 수를 조회하시오.
    Alias는 분류코드, 분류명, 상품의 수
    SELECT B.LPROD_GU AS 분류코드,
           B.LPROD_NM AS 분류명,
           COUNT(A.PROD_ID) AS "상품의 수"
      FROM CSS02.PROD A, CSS02.LPROD B
      WHERE A.LPROD_GU(+) = B.LPROD_GU 
      GROUP BY B.LPROD_GU,  B. LPROD_NM
      ORDER BY 1
    
ANSI FORMAT    
    SELECT B.LPROD_GU AS 분류코드,
           B.LPROD_NM AS 분류명,
           COUNT(A.PROD_ID) AS "상품의 수"
      FROM CSS02.PROD A
      RIGHT OUTER JOIN CSS02.LPROD B ON(A.LPROD_GU=B.LPROD_GU)
    GROUP BY B.LPROD_GU,  B. LPROD_NM
      ORDER BY 1
    
    
      --  SELECT DISTINCT LPROD_GU FROM CSS02.PROD
      --  SELECT LPROD_GU FROM CSS02.LPROD
        
        
사용예) 2020년 1월 모든 상품별 매입집계를 조회하시오.
        Alias는 상품코드, 상품명, 매입수량, 매입금액
   SELECT B.PROD_ID AS 상품코드,
          B.PROD_NAME AS 상품명,
          NVL(SUM(A.BUY_QTY),0) AS 매입수량,
          SUM(A.BUY_QTY*B.PROD_COST) AS 매입금액
     FROM CSS02. BUYPROD A, CSS02.PROD B
     WHERE B.PROD_ID=A.PROD_ID(+)
    --   AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
       GROUP BY B.PROD_ID, B.PROD_NAME
       ORDER BY 1
        
ANSI FORMAT)
 SELECT B.PROD_ID AS 상품코드,
          B.PROD_NAME AS 상품명,
          NVL(SUM(A.BUY_QTY),0) AS 매입수량,
          NVL(SUM(A.BUY_QTY*B.PROD_COST), 0) AS 매입금액
     FROM CSS02.PROD B 
     LEFT OUTER JOIN CSS02. BUYPROD A ON(B.PROD_ID=A.PROD_ID AND
        A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131'))
    GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 4 DESC   

**** WHERE (절을 쓰면 결과가 39개만 나옴.  일반 조인이 되서 0이 안나옴)    ****
 SELECT B.PROD_ID AS 상품코드,
          B.PROD_NAME AS 상품명,
          NVL(SUM(A.BUY_QTY),0) AS 매입수량,
          NVL(SUM(A.BUY_QTY*B.PROD_COST), 0) AS 매입금액
     FROM CSS02.PROD B 
     LEFT OUTER JOIN CSS02. BUYPROD A ON(B.PROD_ID=A.PROD_ID )
      WHERE  A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
    GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 4 DESC           

(2020년 1월 상품별 매입수량, 매입금액 집계)
  SELECT A.PROD_ID AS APID,
         SUM(BUY_QTY) AS SQTY,
         SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
    FROM CSS02.BUYPROD A, CSS02.PROD B
    WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
    GROUP BY A.PROD_ID
         
          
(모든 상품별 상품코드, 상품명, 매입수량, 매입금액) -- 서브쿼리 써서 만듬.
     SELECT C.PROD_ID AS 상품코드,
            C.PROD_NAME AS 상품명,
            NVL(D.SQTY,0) AS 매입수량,
            NVL(D.BSUM,0) AS 매입금액
       FROM CSS02.PROD C, 
            (SELECT A.PROD_ID AS APID,
                 SUM(BUY_QTY) AS SQTY,
                 SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
                FROM CSS02.BUYPROD A, CSS02.PROD B
               WHERE A.PROD_ID=B.PROD_ID
                 AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
                 GROUP BY A.PROD_ID)D
      WHERE C.PROD_ID=D.APID(+)
    ORDER BY 4 DESC
 
 (ANSI PUTER JOIN) -- 위 서브쿼리 쓴 내용을 아래 안시로 변경함.
 SELECT C.PROD_ID AS 상품코드,
            C.PROD_NAME AS 상품명,
            NVL(D.SQTY,0) AS 매입수량,
            NVL(D.BSUM,0) AS 매입금액
       FROM CSS02.PROD C 
       LEFT OUTER JOIN (SELECT A.PROD_ID AS APID,
                           SUM(BUY_QTY) AS SQTY,
                           SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
                          FROM CSS02.BUYPROD A, CSS02.PROD B
                         WHERE A.PROD_ID=B.PROD_ID
                           AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
                         GROUP BY A.PROD_ID)D ON (C.PROD_ID=D.APID)
        ORDER BY 4 DESC
    
사용예) 사원테이블에서 모든 부서별 사원수를 조회하시오.
       Alias 부서코드, 부서명, 사원수
      SELECT A.DEPARTMENT_ID AS 부서코드,
             B.DEPARTMENT_NAME AS 부서명,
             COUNT(A.EMPLOYEE_ID) AS 사원수
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE  A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID(+)
     GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 1;
    
(ANSI OUTER)
      SELECT A.DEPARTMENT_ID AS 부서코드,
             B.DEPARTMENT_NAME AS 부서명,
             COUNT(A.EMPLOYEE_ID) AS 사원수
      FROM HR.EMPLOYEES A
      FULL OUTER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID= B.DEPARTMENT_ID)
         GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 1;
     
문제1] 2020년 6월 상품별 매입/매출 수량집계를 조회하시오.
    Alias는 상품코드, 상품명, 매입수량, 매출수량
  SELECT A.PROD_ID AS 상품코드,
         A.PROD_NAME AS 상품명,
         SUM(C.BUY_QTY) AS 매입수량,
         SUM(B.CART_QTY) AS 매출수량
    FROM css02.PROD A, css02.CART B, css02.BUYPROD C
   WHERE A.PROD_ID=B.PROD_ID(+)
     AND A.PROD_ID=C.PROD_ID(+)
     AND B.CART_NO LIKE '202006%'
     AND C.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
   GROUP BY  A.PROD_ID, A.PROD_NAME
   ORDER BY 1;  
   
(ANSI)
  SELECT A.PROD_ID AS 상품코드,
         A.PROD_NAME AS 상품명,
         NVL(SUM(C.BUY_QTY),0) AS 매입수량,
         NVL(SUM(B.CART_QTY),0) AS 매출수량
    FROM css02.PROD A
    LEFT OUTER JOIN css02.CART B ON(A.PROD_ID=B.PROD_ID AND 
         SUBSTR(B.CART_NO,1,6) BETWEEN '202001' AND '202004')
    LEFT OUTER JOIN css02.BUYPROD C ON(C.PROD_ID=A.PROD_ID AND
         C.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200430'))
   GROUP BY  A.PROD_ID, A.PROD_NAME
   ORDER BY 1; 
   
--매출수량집계함수     
CREATE OR REPLACE FUNCTION fn_sum_cart(
  P_SDATE IN VARCHAR2, P_EDATE IN VARCHAR2, P_PID IN css02.PROD.PROD_ID%TYPE)
  RETURN NUMBER
IS
  L_SUM NUMBER:=0;
BEGIN
  SELECT SUM(CART_QTY) INTO L_SUM
    FROM css02.CART
   WHERE SUBSTR(CART_NO,1,6) BETWEEN P_SDATE AND P_EDATE
     AND PROD_ID=P_PID;
  RETURN L_SUM; 
END;

--매입수량집계함수    
CREATE OR REPLACE FUNCTION fn_sum_buyprod(
  P_SDATE IN VARCHAR2, P_EDATE IN VARCHAR2, P_PID IN css02.PROD.PROD_ID%TYPE)
  RETURN NUMBER
IS
  L_SUM NUMBER:=0;
BEGIN
  SELECT SUM(BUY_QTY) INTO L_SUM
    FROM css02.BUYPROD
   WHERE BUY_DATE BETWEEN TO_DATE(P_SDATE||'01') AND LAST_DAY(TO_DATE(P_EDATE||'01'))
     AND PROD_ID=P_PID;
  RETURN L_SUM; 
END;    
    
--실행    
SELECT PROD_ID AS 상품코드,
       PROD_NAME AS 상품명,
       fn_sum_buyprod('202001','202004',PROD_ID) AS 매입수량,
       fn_sum_cart('202001','202004',PROD_ID) AS 매출수량
  FROM PROD;     
       
    