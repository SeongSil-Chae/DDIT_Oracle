2024-1029-01)���տ�����
 - UNION, UNION ALL, INTERSECT, MINUS ����
 - ���꿡 �����ϴ� SELECT���� SELECT���� ���Ǵ� �÷��� ����, �ڷ�Ÿ��, ������ ��ġ�ؾ���
 - �÷��� ��Ī�� ù ��° SELECT���� ������ ��
 - ORDER BY ���� �� ������ SELECT �������� ��밡��
 - CLOB, BLOB, BFILE ���� �÷��� ���Ե� SELECT ���� ����� �� ����.
 
 1. UNION�� UNION ALL
  - ���� ������ ��� ������ ������ ����� ��ȯ
  - ������ �ٸ� �������̺��� ���� ������ �ڷḦ �����ϴ� ���
  - ���� ������ ��ȯ�Ͽ� ��ȸ�ϴ� ��� ���
  
��뿹) 2020�� 1���� 6���� ���Ե� ��ǰ���� ��ȸ�Ͻÿ�. (�̰ɷ� UNION, UNION ALL, INTERCEPT ���� ����)
     SELECT DISTINCT A.PROD_ID AS ��ǰ��ȣ, --39��
            B.PROD_NAME AS ��ǰ��
       FROM CSS02.BUYPROD A, CSS02.PROD B
      WHERE A.PROD_ID=B.PROD_ID
        AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
    UNION 
     SELECT DISTINCT A.PROD_ID,--���� ��Ī ���°� �ǹ� ���� --36��
            B.PROD_NAME
       FROM CSS02.BUYPROD A, CSS02.PROD B
      WHERE A.PROD_ID=B.PROD_ID
        AND A.BUY_DATE BETWEEN TO_DATE('20200501') AND TO_DATE('20200531')
        ORDER BY 1 -- �������̴� ���� ������ ��� �ؾߵ�.
        
        
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

��뿹) 2023��  1-3�� ��ȹ ��� ������ ��ȸ�Ͻÿ�.
    SELECT PERIOD, BUDGET_AMT,0 AS SALE_AMT
    FROM BUDGET
    UNION
    SELECT PERIOD, 0 AS BUDGET_AMT, SALE_AMT
    FROM SALES
    ORDER BY 1;

(������ �ٸ� ���� ���̺��� ���� ������ �ڷḦ ����)
    SELECT PERIOD AS �Ⱓ,
           SUM(BUDGET_AMT) AS ��ȹ,
           SUM(SALE_AMT) AS ����,
           LPAD(ROUND(SUM(SALE_AMT)/SUM(BUDGET_AMT),2)*100||'%',5) AS �޼���
      FROM (SELECT PERIOD, BUDGET_AMT,0 AS SALE_AMT
              FROM BUDGET
           UNION
            SELECT PERIOD, 0 AS BUDGET_AMT,SALE_AMT
              FROM SALES
             ORDER BY 1)
    GROUP BY PERIOD
    ORDER BY 1;
             

(��뿹)            
 CREATE TABLE SCORE(
    GUBUN VARCHAR2(30),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MAT NUMBER(3));
    
  INSERT INTO SCORE VALUES('�߰����',92,87,67);
  INSERT INTO SCORE VALUES('�⸻���',88,80,95);
  
  SELECT * FROM SCORE;
  
  SELECT GUBUN AS ����,
         '����' AS ����,
         KOR AS ����
    FROM SCORE
  UNION
    SELECT GUBUN AS ����,
           '����' AS ����,
           KOR AS ����
      FROM SCORE
  UNION
    SELECT GUBUN AS ����,
           '����' AS ����,
           MAT AS ����
      FROM SCORE           
             
��뿹) 2020�� 06�� ��� ȸ���� ������� ��ȸ�Ͻÿ�.
  SELECT B.MEM_NAME AS ȸ����,
         NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS ���űݾ�
    FROM CSS02.CART A
   RIGHT OUTER JOIN CSS02.MEMBER B ON(A.MEM_ID  = B.MEM_ID)
    LEFT OUTER JOIN CSS02.PROD C ON (A.PROD_ID = C.PROD_ID AND A.CART_NO LIKE '202006%')
    GROUP BY B.MEM_NAME;

1. ȸ���̸��� 0�� ���
    SELECT MEM_NAME, 0 AS AMT
      FROM CSS02.MEMBER
    
2. 2020�� 6�� ȸ���� ������� ��ȸ�Ͻÿ�
    SELECT D.MEM_NAME AS MEM_NAME, C.SAMT AS AMT
      FROM (SELECT  A.MEM_ID AS MID,
                    SUM(A.CART_QTY*B.PROD_PRICE) AS SAMT
              FROM CSS02.CART A, CSS02.PROD B
             WHERE A.PROD_ID  = B.PROD_ID
               AND A.CART_NO LIKE '202006%'
             GROUP BY A.MEM_ID)C, CSS02.MEMBER D
      WHERE C.MID=D.MEM_ID
    
 3.���� 
    SELECT MEM_NAME AS ȸ����,
           SUM(AMT) AS �����հ�
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
 
 2. ������(INTERSECT)
 - ���꿡 �����ϴ� ������ ��� ����� �κ��� ��ȯ
 
��뿹) 2020�� 6���� 2020�� 7���� ��� �Ǹŵ� ��ǰ������ ���
    (2020�� 6��)
    SELECT DISTINCT A.PROD_ID AS ��ǰ�ڵ�,
           B.PROD_NAME AS ��ǰ��
      FROM CSS02.CART A, CSS02.PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.CART_NO LIKE '202006%'
 INTERSECT  
 --(2020�� 7��)
     SELECT DISTINCT A.PROD_ID,
           B.PROD_NAME 
      FROM CSS02.CART A, CSS02.PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.CART_NO LIKE '202007%'
     ORDER BY 1
     
3. ������ (MINUS)
  - ������ �����ϴ� ���� ������ ����� ������ ������ ����� ������ ���� ��ȯ
  - MINUS������ �տ� ���Ǵ� ������ ���� ����� �޶���
 
 ��뿹) 2020�� 6���� 7���� �Ǹŵ� ��ǰ �� 6������ �Ǹŵ� ��ǰ������ ���
 --(2020�� 6��)
     SELECT DISTINCT A.PROD_ID AS ��ǰ�ڵ�,
           B.PROD_NAME AS ��ǰ��
      FROM CSS02.CART A, CSS02.PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.CART_NO LIKE '202006%'
   MINUS  
 --(2020�� 7��)
     SELECT DISTINCT A.PROD_ID,
           B.PROD_NAME 
      FROM CSS02.CART A, CSS02.PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.CART_NO LIKE '202007%'
     ORDER BY 1
 
 
 
 
 