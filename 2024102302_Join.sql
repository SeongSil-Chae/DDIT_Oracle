2024-1023-02)조인(JOIN)
 - 일반조인 / ANSI 조인
 - 내부조인 / 외부조인 
 - EQU-JOIN / NON EQU-JOIN
 - SELF JOIN, NATURAL JOIN 등으로 분류
 - 조인에 참여하는 테이블의 갯수가 n개일때 조인 조건의 개수는 적어도 n-1개 이상 이어야 함.
 
 사용형식-일반조인)
    SELECT 컬럼list
      FROM 테이블1 [별칭1], 테이블2 [별칭2] [, 테이블3 [별칭3],...]
     WHERE 조인조건1
      [AND 조인조건2]
            :
      [AND 일반조건]
      
사용형식-ANSI INNER 조인)
    SELECT 컬럼list
      FROM 테이블1 [별칭1]
     INNER JOIN 테이블2 [별칭2] ON (조인조건 [AND 일반조건])
                  :
     WHERE 일반조건
     
        
1. Cartesian Product
 - 테이블들 간의 JOIN 조건을 생략하거나, 조건을 잘못 설정했을 경우,
 - 첫 번째 테이블의 모든 행들에 대해서 두번째 테이블의 모든 행들이 JOIN되어 조회되는 데이터의 형태를 Cartesian Product라고 함
 - Cartesian Product가 발생하면 조회되는 데이터의 개수가 기하급수적으로 증가하게 되어 원하는 데이터를 얻을 수 없는 것은 물론, 
    데이터베이스나 네트워크에 부담을 주게 되는 결과를 초래하게 되므로 주의해야 한다

 사용형식-일반조인)
    SELECT 컬럼list
      FROM 테이블1 [별칭1], 테이블2 [별칭2] [, 테이블3 [별칭3],...]
    . 결과는 각 테이블에 존재하는 행들을 모두 곱하고 열들은 더한 결과가 반환됨.
     (ex A테이블이 100행 20열, B테이블이 50행 10열로 구성된 경우 Cartesian Product를 수행하면
     결과는 5000행 30열)

사용형식-ANSI CROSS 조인)   -- 안시조인은 테이블 반드시 1개 사용.
    SELECT 컬럼list
      FROM 테이블1 [별칭1]
     CROSS JOIN 테이블2 [별칭2] 
                  :


사용예) 장바구니테이블(CART), 매입테이블(BUYPROD), 상품테이블(PROD)에 Cartesian Product를 수행하시오.
    SELECT COUNT(*) FROM CSS02.CART; --207행 4열
    SELECT COUNT(*) FROM CSS02.BUYPROD; --148행 3열 
    SELECT COUNT(*) FROM CSS02.PROD;  --74행 19열
    
(일반조인 -   Cartesian Product)
    SELECT COUNT(*)
    FROM CSS02.CART, CSS02.BUYPROD, CSS02.PROD

(ANSI CROSS JOIN) --위 일반과 결과 같음
    SELECT COUNT(*)
      FROM CSS02.CART
      CROSS JOIN CSS02.BUYPROD
      CROSS JOIN CSS02.PROD

2. 동등조인 (INNER JOIN)
 - 대부분의 조인
 - 조인조건에 '='연산자 사용

사용형식-일반조인)
  SELECT 컬럼list
      FROM 테이블1 [별칭1], 테이블2 [별칭2] [, 테이블3 [별칭3],...]
     WHERE 조인조건1
      [AND 조인조건2]
            :
      [AND 일반조건];
    . 테이블의 개수가 n개 일때 n-1개 이상의 조인조건이 필요
    . '일반조건'과 '조건조건'의 기술순서는 의미없음

사용형식-ANSI INNER 조인)
    SELECT 컬럼list
      FROM 테이블1 [별칭1]
     INNER JOIN 테이블2 [별칭2] ON (조인조건1 [AND 일반조건1])
     INNER JOIN 테이블3 [별칭3] ON (조인조건2 [AND 일반조건2])
                  :
     WHERE 일반조건
    . '테이블1'과'테이블2'는 반드시 직접 조인되어야 함.
    . '조인조건1'은 '테이블1'과'테이블2'에 관한 조인 조건
    . '일반조건1'은 '테이블1'과'테이블2'에 관한 일반 조건
    . '테이블3'은  '테이블1'과'테이블2'의 조인결과와 조인됨.
    . 'WHERE 일반조건'은 모든 테이블과 관련된 조건을 기술 -- **내부조인인 경우
      일반조건 기술이 ON절에 기술하든지 WHERE절에서 기술하든지 차이 없음.
      
사용예) 2020년 1월 매입자료를 조회하시오           -- 테이블에 혼자 사용되는 컬럼은 별칭 안써도 됨.
       Alias는 날짜, 상품명, 수량, 매입금액이다.
       SELECT A.BUY_DATE AS 날짜,
              B.PROD_NAME AS 상품명,
              A.BUY_QTY AS 수량,
              A.BUY_QTY*B.PROD_COST AS 매입금액
         FROM CSS02.BUYPROD A, CSS02.PROD B
        WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
          AND A.PROD_ID=B.PROD_ID;
     
(ANSI INNER JOIN)      
   SELECT A.BUY_DATE AS 날짜,
          B.PROD_NAME AS 상품명,
          A.BUY_QTY AS 수량,
          A.BUY_QTY*B.PROD_COST AS 매입금액
     FROM SEM1.BUYPROD A
    INNER JOIN  SEM1.PROD B ON(A.PROD_ID=B.PROD_ID AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'));
     
   SELECT A.BUY_DATE AS 날짜,
          B.PROD_NAME AS 상품명,
          A.BUY_QTY AS 수량,
          A.BUY_QTY*B.PROD_COST AS 매입금액
     FROM SEM1.BUYPROD A
    INNER JOIN  SEM1.PROD B ON(A.PROD_ID=B.PROD_ID)
    WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131');