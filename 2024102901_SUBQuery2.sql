2020-1029-01)��������

��뿹)������̺��� ��å�� ���� ���� �޿��� �ٴ� ����� �����ȣ, �����, ��å, �޿���
      �޿��� ���������� ����Ͻÿ�.
    (��������: �����ȣ, �����, ��å, �޿�
    SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.JOB_TITLE AS ��å,
           A.SALARY AS �޿�
      FROM HR.EMPLOYEEES A, HR.JOBS B
     WHERE A.JOB_ID= B.JOB_ID
     AND (A.JOB_ID, A.SALARY) = ( ��������)
    
      
    (��������: ��å�� ���� ���� �޿��� �ٴ� ���)
    SELECT  JOB_ID AS ��å,
           MAX(SALARY) AS �޿�
      FROM HR.EMPLOYEES
      GROUP BY JOB_ID

(����)
    SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.JOB_TITLE AS ��å,
           A.SALARY AS �޿�
      FROM HR.EMPLOYEES A, HR.JOBS B
     WHERE A.JOB_ID= B.JOB_ID
     AND (A.JOB_ID, A.SALARY) IN (SELECT  JOB_ID AS ��å,
                                         MAX(SALARY) AS �޿�
                                   FROM HR.EMPLOYEES
                                  GROUP BY JOB_ID)
                                  
    -- ������ AND ���� ���� 2���� ���� ����� ��. ( ������ ������)                              
                                  
                                  
                            

��뿹) ȸ�����̺��� ����ȸ���� ���� ���� ���ϸ������� ���� ���ϸ����� ������ �ִ� ����ȸ���� 
        ȸ����ȣ, ȸ����, ���ϸ����� ���Ͻÿ�
        
        (��������: ����ȸ���� ���� ���� ���ϸ���)
        SELECT MEM_MILEAGE AS ���ϸ���
          FROM CSS02.MEMBER
         WHERE SUBSTR(MEM_REGNO2,1,1) IN('1','3') 
         
         (��������: ȸ����ȣ, ȸ����, ���ϸ���)
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
               MEM_MILEAGE AS ���ϸ���
          FROM CSS02.MEMBER
         WHERE SUBSTR(MEM_REGNO2,1,1) IN('2','4')  
           AND MEM_MILEAGE > ALL(SELECT MEM_MILEAGE AS ���ϸ���
                                   FROM CSS02.MEMBER
                                  WHERE SUBSTR(MEM_REGNO2,1,1) IN('1','3'))
         

��뿹) 2020�� ������ǰ(�з��ڵ�: P201) �� ���Աݾ��� �������� ���� ���� ���Ե� ��ǰ����
        ���� ���Ե� ��ǰ�� ��ǰ�ڵ�, ��ǰ��,�з���,���Աݾ��� ��ȸ�Ͻÿ�.
        
   (��������: ���Աݾ��� �������� ���� ���� ���Ե� ��ǰ)
   SELECT C.CMIN
     FROM(SELECT B.PROD_ID AS ��ǰ��ȣ,
                  SUM(A.BUY_QTY*B.PROD_COST) AS CMIN
             FROM CSS02.BUYPROD A,CSS02.PROD B
            WHERE B.PROD_ID  LIKE 'P201%'
            GROUP BY B.PROD_ID
            ORDER BY 2 )C
    WHERE ROWNUM =1
     
   (�������� : ���� ���Ե� ��ǰ�� ��ǰ�ڵ�, ��ǰ��,�з���,���Աݾ�)
   SELECT C.PROD_ID AS ��ǰ�ڵ�,
          C.PROD_NAME AS ��ǰ��,
          D.LPROD_GU AS �з���,
          MIN(A.BUY_QTY*C.PROD_COST) AS ���Աݾ�
    FROM CSS02.PROD C, CSS02.LPROD D
    
(����)  -- ����
   SELECT B.PROD_ID AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          D.LPROD_GU AS �з��ڵ�,
          SELECT SUM(A.BUY_QTY*C.PROD_COST) AS MI
            FROM CSS02.BUYPROD A, CSS02.COST C
    FROM CSS02.LPROD D
    WHERE  H.MI <ALL (SELECT C.CMIN
                                       FROM(SELECT B.PROD_ID AS ��ǰ��ȣ,
                                                   SUM(A.BUY_QTY*B.PROD_COST) AS CMIN
                                              FROM CSS02.BUYPROD A,CSS02.PROD B
                                             WHERE B.PROD_ID  LIKE 'P201%'
                                             GROUP BY B.PROD_ID
                                             ORDER BY 2 )C
                                     WHERE ROWNUM =1)
                        
   (������ �ڵ�) -- ���� ��ü�� ��ư� �Ǿ���
   SELECT A.PID AS ��ǰ�ڵ�,
         A.FNAME AS ��ǰ��,
         A.FSUM AS ���Աݾ�
    FROM (SELECT B.PROD_ID AS PID,
                 P.PROD_NAME AS FNAME,
                 SUM(B.BUY_QTY*P.PROD_COST) AS FSUM
            FROM CSS02.BUYPROD B, CSS02.PROD P
           WHERE B.PROD_ID=P.PROD_ID
             AND B.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')
           GROUP BY B.PROD_ID,P.PROD_NAME)A
   WHERE A.FSUM >(SELECT C.GSUM
                    FROM (SELECT SUM(A.BUY_QTY*B.PROD_COST) AS GSUM
                            FROM CSS02.BUYPROD A, CSS02.PROD B
                           WHERE A.PROD_ID=B.PROD_ID
                             AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')
                             AND B.LPROD_GU='P102'
                           GROUP BY A.PROD_ID
                           ORDER BY 1) C
                   WHERE ROWNUM=1)        
   ORDER BY 3;
    

 ��뿹) 2020�� ��� ��ǰ�� ���Լ����հ踦 ��ȸ�Ͻÿ�.
 
(�������� : 2020�� ��ǰ�� ���Լ����հ�)
    SELECT PROD_ID,
           SUM(BUY_QTY)
      FROM CSS02.BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')
     GROUP BY PROD_ID
 
 (�������� : ��� ��ǰ�� ���Լ����հ�)
   SELECT B.PROD_ID,
          B.BSUM
     FROM CSS02.PROD A, (SELECT PROD_ID,
                                SUM(BUY_QTY) AS BSUM
                           FROM CSS02.BUYPROD
                          WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20201231')
                          GROUP BY PROD_ID)B
    WHERE A.PROD_ID=B.PROD_ID(+)
 
 
 
 
 
        
        
        
        
        
        