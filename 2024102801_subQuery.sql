2024-1028-01) ��������
 - �˷����� ���� ���ǿ� ����� ����� ��ȯ�� �� ���Ǵ� ����
 - ( )�� ���� ����ϸ� �������� ���Ǵ� ���������� ������ �����ʿ� ����Ѵ�.
 - �з�
  . �Ϲݼ�������/��ø��������/ �ζ��μ�������
  . ���༭������/�����༭������
  . ������ �ִ¼�������/������ ���� ��������
  
��뿹)
1. ������̺��� ��ձ޿����� ���� �޿��� �޴� ����� �����ȣ, �����, �޿��� ��ȸ
  (�������� : ����� �����ȣ, �����, �޿�)
  SELECT EMPLOYEE_ID AS �����ȣ,
         MEM_NAME AS �����,
         SALARY AS �޿�
    FROM HR.EMPLOYEES
    WHERE SALARY > (��������)
    
  (�������� : ��ձ޿�) -- �޿��� ���� �Ⱦ���. ����ؼ� �����ٰ� �ƴ϶�
 SELECT AVG(SALARY)
   FROM HR.EMPLOYEES
   
   (����) -- 107�� �����.
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         SALARY AS �޿�
    FROM HR.EMPLOYEES
    WHERE SALARY> ( SELECT AVG(SALARY)
                       FROM HR.EMPLOYEES) ;
                       
    (�������� : ����� �����ȣ, �����, �޿�)
  SELECT A.EMPLOYEE_ID AS �����ȣ,
         A.EMP_NAME AS �����,
         A.SALARY AS �޿�
    FROM HR.EMPLOYEES A, (���) B
    WHERE A.SALARY>B.��ձ޿�
    
    (��������: ��ձ޿�)
    SELECT AVG(SALARY)
    FROM HR.EMPLOYEES
    
    (����) -- 1�� ���� ��.
  SELECT A.EMPLOYEE_ID AS �����ȣ,
         A.EMP_NAME AS �����,
         A.SALARY AS �޿�, 
         ROUND(B.ASAL) AS ��ձ޿�
    FROM HR.EMPLOYEES A, (SELECT AVG(SALARY) AS ASAL
                            FROM HR.EMPLOYEES) B
    WHERE A.SALARY>B.ASAL
    ORDER BY 3
    
  (�Ϲݼ������� ���)
    SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         SALARY AS �޿�
         (SELECT ROUND(AVG(SALARY))
         FROM HR.EMPLOYEES) AS ��ձ޿�
    FROM HR.EMPLOYEES
    WHERE SALARY> ( SELECT AVG(SALARY)
                       FROM HR.EMPLOYEES) ;
    
2. 2020�� ��ݱ� ���� ���� ������ ������ ��ǰ�� ���� ��ǰ������ ��ȸ�Ͻÿ�.
  Alias�� ��ǰ��ȣ, ��ǰ��, ���Դܰ�
  (�������� : ��ǰ��ȣ, ��ǰ��, ���Դܰ�)
  SELECT A.PROD_ID AS ��ǰ��ȣ,
         A.PROD_NAME AS ��ǰ��,
         A.PROD_COST AS ���Դܰ�
    FROM CSS02.PROD A
    WHERE A.PROD_ID=(���������� ��ǰ�ڵ�)
    
  (�������� : 2020�� ��ݱ� ���Լ����� ���� ���� ��ǰ�� ��ǰ�ڵ�) -- ���������� �������� �� ������ ���� �� 1���� ��������
   SELECT B.PROD_ID
     FROM (SELECT PROD_ID,
                  SUM(BUY_QTY)
             FROM CSS02.BUYPROD
            WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200630')
            GROUP BY PROD_ID
            ORDER BY 2 DESC)B
  WHERE ROWNUM=1;
  
  (����)
   SELECT A.PROD_ID AS ��ǰ��ȣ,
         A.PROD_NAME AS ��ǰ��,
         A.PROD_COST AS ���Դܰ�
    FROM CSS02.PROD A,    (SELECT B.PROD_ID AS BPID
                            FROM (SELECT PROD_ID,
                                         SUM(BUY_QTY)
                                    FROM CSS02.BUYPROD
                                   WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200630')
                                   GROUP BY PROD_ID
                                   ORDER BY 2 DESC)B
                                   WHERE ROWNUM=1) C
    WHERE A.PROD_ID=C.BPID
    
    (��ø��������)
  SELECT PROD_ID AS ��ǰ��ȣ,
         PROD_NAME AS ��ǰ��,
         PROD_COST AS ���Դܰ�
    FROM CSS02.PROD A
    WHERE PROD_ID=(SELECT B.PROD_ID AS BPID
                       FROM (SELECT PROD_ID,
                                    SUM(BUY_QTY)
                                    FROM CSS02.BUYPROD
                                   WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200630')
                                   GROUP BY PROD_ID
                                   ORDER BY 2 DESC)B
                                   WHERE ROWNUM=1) 

    
3. �� 2���������� ���� ���� ������ ������ ��ǰ�� ��ǰ�� �ŷ�ó ������ ��ȸ�Ͻÿ�.
  Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, �ּ�
  SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
         D.BUYER_NAME AS �ŷ�ó��,
         D.BUYER_ADD1||' '||D.BUYER_ADD2 AS �ּ�
    FROM CSS02.PROD A, CSS02.BUYER D,
                         (SELECT B.PROD_ID AS BPID
                            FROM (SELECT PROD_ID,
                                         SUM(BUY_QTY)
                                    FROM CSS02.BUYPROD
                                   WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
                                   GROUP BY PROD_ID
                                   ORDER BY 2 DESC)B
                            WHERE ROWNUM=1) C
    WHERE A.PROD_ID=C.BPID
      AND A.BUYER_ID=D.BUYER_ID;
  
  
4. ȸ�����̺��� ���ϸ����� ���� 3���� ȸ���� ȸ����ȣ, ȸ����, ���ϸ����� ��ȸ�Ͻÿ�.
    (��������: ȸ����ȣ, ȸ����, ���ϸ���)
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_MILEAGE AS ���ϸ���
      FROM CSS02.MEMBER
     
     (�������� : ���ϸ��� ��ŷ)
     SELECT RANK() OVER (ORDER BY MEM_MILEAGE DESC)
     FROM CSS02.MEMBER
     WHERE ROWNUM BETWEEN 1 AND 3
     
     (����)
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_MILEAGE AS ���ϸ���
      FROM (SELECT MEM_ID,
                   MEM_NAME,
                   MEM_MILEAGE,
                   RANK() OVER (ORDER BY MEM_MILEAGE DESC) AS BRANK
              FROM CSS02.MEMBER)
    WHERE BRANK BETWEEN 1 AND 3
    GROUP BY MEM_ID, MEM_NAME, MEM_MILEAGE
    
(������ ����)4. ȸ�����̺��� ���ϸ����� ���� 3���� ȸ���� ȸ����ȣ, ȸ����, ���ϸ����� ��ȸ�Ͻÿ�.
    (��������: ȸ����ȣ, ȸ����, ���ϸ���)
 SELECT  A.MEM_ID AS ȸ����ȣ,
         A.MEM_NAME AS ȸ����,
         A.MEM_MILEAGE AS ���ϸ���
 FROM(SELECT MEM_ID,
        MEM_NAME,
        MEM_MILEAGE
   FROM CSS02.MEMBER   
   ORDER BY 3 DESC) A
   WHERE ROWNUM<=3;
  
  
5. �� 4�� ��� 3���� ȸ���� 2020�� 5�� ������Ȳ(ȸ����ȣ,ȸ����,���űݾ��հ�)�� ��ȸ�Ͻÿ�.

    SELECT A.MEM_ID AS ȸ����ȣ,
           A.MEM_NAME AS ȸ����,
           A.MEM_MILEAGE AS ���ϸ���,
           B.CART_NO AS ȸ����ȣ,
           SUM(B.CART_QTY*C.PROD_PRICE) AS ���űݾ��հ�
      FROM (SELECT MEM_ID,
                   MEM_NAME,
                   MEM_MILEAGE,
                   RANK() OVER (ORDER BY MEM_MILEAGE DESC) AS BRANK
              FROM CSS02.MEMBER)
    WHERE BRANK BETWEEN 1 AND 3
    GROUP BY MEM_ID, MEM_NAME, MEM_MILEAGE
    
    (�������� : ȸ����ȣ, ȸ����, ���űݾ��հ�)
    SELECT A.MEM_ID AS ȸ����ȣ,
           A.MEM_NAME AS ȸ����,
           B.CART_NO AS ��¥,
           SUM(B.CART_QTY*C.PROD_PRICE) AS ���űݾ��հ�
      FROM CSS02.MEMBER A, CSS02.CART B, CSS02.PROD C 
     WHERE A.MEM_ID =B.MEM_ID
     AND B.PROD_ID = C.PROD_ID
     AND SUBSTR(B.CART_NO,1,8) BETWEEN  TO_CHAR('20200501') AND TO_CHAR('20200531')
    GROUP BY A.MEM_ID , A.MEM_NAME,B.CART_NO
      
      (����)
SELECT A.MEM_ID AS ȸ����ȣ,
       A.MEM_NAME AS ȸ����,
       A.MEM_MILEAGE AS ���ϸ���,
       B.CART_NO AS ��¥,
       SUM(B.CART_QTY * C.PROD_PRICE) AS ���űݾ��հ�
  FROM (SELECT MEM_ID,
               MEM_NAME,
               MEM_MILEAGE,
               RANK() OVER (ORDER BY MEM_MILEAGE DESC) AS BRANK
          FROM CSS02.MEMBER
       ) A
      LEFT OUTER JOIN CSS02.CART B ON A.MEM_ID = B.MEM_ID
      LEFT OUTER JOIN CSS02.PROD C ON B.PROD_ID = C.PROD_ID
 WHERE A.BRANK BETWEEN 1 AND 3
   AND SUBSTR(B.CART_NO, 1, 8) BETWEEN '20200501' AND '20200531'
 GROUP BY A.MEM_ID, A.MEM_NAME, A.MEM_MILEAGE, B.CART_NO;

(������ ����)5. �� 4�� ��� 3���� ȸ���� 2020�� 5�� ������Ȳ(ȸ����ȣ,ȸ����,���űݾ��հ�)�� ��ȸ�Ͻÿ�.
SELECT D.AMID AS ȸ����ȣ,
       D.ANAME AS ȸ����,
       SUM(C.CART_QTY*B.PROD_PRICE) AS ���űݾ��հ�
  FROM CSS02.PROD B, CSS02.CART C, (SELECT  A.MEM_ID AS AMID,
                                           A.MEM_NAME AS ANAME
                                    FROM(SELECT MEM_ID,
                                                MEM_NAME,
                                                MEM_MILEAGE
                                           FROM CSS02.MEMBER   
                                          ORDER BY 3 DESC) A
                                         WHERE ROWNUM<=3)D
 WHERE B.PROD_ID=C.PROD_ID
   AND D.AMID=C.MEM_ID
   AND C.CART_NO LIKE '202005%'
   GROUP BY D.AMID , D.ANAME

7. ������̺��� �ڽ��� �Ҽӵ� �μ��� ��ձ޿����� �� ���� �޿��� �޴� 
    ����� �����ȣ, �����, �μ���ȣ, �޿�, �μ���ձ޿��� ����Ͻÿ�.
   SELECT A.EMPLOYEE_ID AS �����ȣ,
          A.EMP_NAME AS �����,
          A.DEPARTMENT_ID AS �μ���ȣ,
          A.SALARY AS �޿�,
          �μ���ձ޿�
     FROM HR.EMPLOYEES A,
    WHERE A.SALARY < (�μ�����ձ޿�)
    
(��������: �μ��� ��ձ޿�)
  SELECT B.DEPARTMENT_ID,
         AVG(B.SALARY) AS BAVG
    FROM HR.EMPLOYEES B
    GROUP BY B.DEPARTMENT_ID
    
(����)
   SELECT A.EMPLOYEE_ID AS �����ȣ,
          A.EMP_NAME AS �����,
          A.DEPARTMENT_ID AS �μ���ȣ,
          A.SALARY AS �޿�,
          (SELECT ROUND(AVG(SALARY))
             FROM HR.EMPLOYEES C
             WHERE C.DEPARTMENT_ID=A.DEPARTMENT_ID) AS �μ���ձ޿�
     FROM HR.EMPLOYEES A,
    WHERE A.SALARY < (SELECT B.BAVG
                       FROM (SELECT DEPARTMENT_ID,
                                    AVG(SALARY) AS BAVG
                               FROM HR.EMPLOYEES 
                               GROUP BY DEPARTMENT_ID)B
                       WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID)
    ORDER BY 3, 4 DESC
    
(INLINE SUBQUERY)
   SELECT A.EMPLOYEE_ID AS �����ȣ,
          A.EMP_NAME AS �����,
          A.DEPARTMENT_ID AS �μ���ȣ,
          A.SALARY AS �޿�,
          ROUND(B.BAVG) AS �μ���ձ޿�
     FROM HR.EMPLOYEES A,(SELECT DEPARTMENT_ID,
                                    AVG(SALARY) AS BAVG
                               FROM HR.EMPLOYEES 
                               GROUP BY DEPARTMENT_ID)B
    WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
    AND A.SALARY<B.BAVG
    ORDER BY 3, 4 DESC
    
6. 2020�� 1�� ��ǰ�� ���Լ����� ���Ͽ� ���������̺��� �����Ͻÿ�.
(��������: ���������̺� UPDATE)
UPDATE CSS02.REMAIN A
   SET A.REMAIN_I = A.REMAIN_I+(2020�� 1�� �ش� ��ǰ�� ���Լ���),
       A.REMAIN_J_99 = A.REMAIN_J_99+(2020�� 1�� �ش� ��ǰ�� ���Լ���),
       A.REMAIN_DATE = 2020�� 1�� 31��
       
UPDATE CSS02.REMAIN A
   SET (A.REMAIN_I, A.REMAIN_J_99,A.REMAIN_DATE  = (2020�� 1�� �ش� ��ǰ�� ���Լ����� ���ϴ� ����������
                                                    SELECT ���� ���
                                                    SELECT A.REMAIN_I+���Լ���, A.REMAIN_J_99+���Լ���,
                                                             2020�� 1��31��
                                                      FROM (��ǰ�� ���Լ���) B
                                                     WHERE B.��ǰ�ڵ�=A.��ǰ�ڵ�)
(�������� : 2020�� 1�� �ش� ��ǰ�� ���Լ���)
  SELECT PROD_ID,
         SUM(BUY_QTY) AS BSUM
    FROM CSS02.BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
    GROUP BY PROD_ID

COMMIT;
(����)
UPDATE CSS02.REMAIN A
SET (A.REMAIN_I, A.REMAIN_J_99,A.REMAIN_DATE)  = 
    (SELECT A.REMAIN_I+B.BSUM, A.REMAIN_J_99+B.BSUM, TO_DATE('20200131')
       FROM (SELECT PROD_ID,
        SUM(BUY_QTY) AS BSUM
       FROM CSS02.BUYPROD
      WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
      GROUP BY PROD_ID) B
      WHERE B.PROD_ID = A.PROD_ID)
WHERE A.PROD_ID IN (SELECT DISTINCT PROD_ID
                      FROM CSS02.BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131'))



��뿹) ��ǰ�� �з��� ��� ���԰����� �� ū ���԰����� ������ ��ǰ�� ��ǰ��ȣ, ��ǰ��, ���԰����� ��ȸ�Ͻÿ�.
  (��������: ��ǰ�� ��ǰ��ȣ, ��ǰ��, ���԰���)
  SELECT PRID_ID AS ��ǰ��ȣ,
         PROD_NAME AS ��ǰ��,
         PROD_COST AS ���԰���
    FROM CSS02.PROD
   WHERE PROD_COST > (�з��� ��� ���԰�)
   
  (��������: �з��� ��� ���԰�)
  SELECT A.ACOS
    FROM (SELECT LPROD_GU,
                 AVG(PROD_COST) AS ACOS
            FROM CSS02.PROD
           GROUP BY LPROD_GU)A
(���� ���� ������)
SELECT AVG(PROD_COST)
  FROM CSS02.PROD
 GROUP BY LPROD_GU) 

(����)

  SELECT PROD_ID AS ��ǰ��ȣ,
         PROD_NAME AS ��ǰ��,
         PROD_COST AS ���԰���
    FROM CSS02.PROD
   WHERE PROD_COST > ANY (SELECT AVG(PROD_COST)
                            FROM CSS02.PROD
                            GROUP BY LPROD_GU)
  ORDER BY 3 DESC

(EXISTS ������ ���)
 - EXISTS������ ������ EXPR�� ������� ����
  ��, WHERE EXISTS (SUBQUERY) �������� ���
 - EXISTS ������ �������� ��� 1���̶� ������ ��(true)�� ��ȯ�ϰ� ����� ������ ����(false)��
  ��ȯ��(����� ������ ������� ����. ���� ���������� SELECT ���� SELECT 1�� ����ϴ� ��찡 ��κ���)
  
 (EXISTS Ȱ��) 
   SELECT B.PROD_ID AS ��ǰ��ȣ,
          B.PROD_NAME AS ��ǰ��,
          B.PROD_COST AS ���԰���
     FROM CSS02.PROD B
    WHERE EXISTS (SELECT 1
                    FROM (SELECT AVG(PROD_COST)ACOS
                            FROM CSS02.PROD
                           GROUP BY LPROD_GU)A
                           WHERE B.PROD_COST<A.ACOS)
