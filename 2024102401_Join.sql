2024-1024-01)����

��뿹1) ������̺��� 2018�� ���� �Ի��� ������� ������ �μ����� ����Ͻÿ�
        Alias�� �����ȣ, �����, �μ���ȣ, �μ���, ��å��
        SELECT A.EMPLOYEE_ID AS �����ȣ,
               A.EMP_NAME AS �����,
               A.DEPARTMENT_ID AS �μ���ȣ,
               B.DEPARTMENT_NAME AS �μ���,
               C.JOB_TITLE AS ��å��
          FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS C
          WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
            AND A.JOB_ID=C.JOB_ID
            AND HIRE_DATE >=TO_DATE('20180101')
            ORDER BY 3
    
�Ƚ�)
        SELECT A.EMPLOYEE_ID AS �����ȣ,
               A.EMP_NAME AS �����,
               A.DEPARTMENT_ID AS �μ���ȣ,
               B.DEPARTMENT_NAME AS �μ���,
               C.JOB_TITLE AS ��å��
          FROM HR.EMPLOYEES A
          INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
          INNER JOIN HR.JOBS C ON(A.JOB_ID = C.JOB_ID AND HIRE_DATE >=('20180101'))
        ORDER BY 3

            
            
��뿹2) 2020�� 4-7�� ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�
        Alias�� ��ǰ�ڵ�, ��ǰ��, �Ǹż���, ����ݾ��̸� ����ݾ��� ū ��ǰ���� ���
        SELECT A.PROD_ID AS ��ǰ�ڵ�,
               B.PROD_NAME AS ��ǰ��,
              SUM(A.CART_QTY) AS �Ǹż���,
              SUM(B.PROD_PRICE*A.CART_QTY) AS ����ݾ�
        FROM CSS02.CART A, CSS02.PROD B
        WHERE A.PROD_ID = B.PROD_ID
          AND SUBSTR(A.CART_NO,1,6) BETWEEN '202004' AND '202007'
          GROUP BY A.PROD_ID, B.PROD_NAME
          ORDER BY 4 DESC
        
ANSI)       
        SELECT A.PROD_ID AS ��ǰ�ڵ�,
               B.PROD_NAME AS ��ǰ��,
              SUM(A.CART_QTY) AS �Ǹż���,
              SUM(B.PROD_PRICE*A.CART_QTY) AS ����ݾ�
        FROM CSS02.CART A
        INNER JOIN CSS02.PROD B on(A.PROD_ID = B.PROD_ID)
        where SUBSTR(A.CART_NO,1,6) BETWEEN '202004' AND '202007'
         GROUP BY A.PROD_ID, B.PROD_NAME
          ORDER BY 4 DESC
        
��뿹3) 2020�� ��ݱ� ��ǰ �з��� ���Աݾ��� ��ȸ�Ͻÿ�.
    Alias�� �з��ڵ�, �з���, ���Աݾ��հ�
    SELECT C.LPROD_GU AS �з��ڵ�,
           B.LPROD_NM AS �з���,
           SUM(A.BUY_QTY*C.PROD_COST) AS ���Աݾ��հ�
    FROM  CSS02.BUYPROD A, CSS02.LPROD B, CSS02.PROD C
    WHERE A.PROD_ID = C.PROD_ID -- ���Աݾ��� ����ϱ� ���Ͽ� PROD_COST�� ��������
      AND C.LPROD_GU =B.LPROD_GU -- �ش� ��ǰ�� �з����� ����
      AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
     GROUP BY C.LPROD_GU, B.LPROD_NM
     ORDER BY 1

�� ANSI FORMAT)
 SELECT C.LPROD_GU AS �з��ڵ�,
           B.LPROD_NM AS �з���,
           SUM(A.BUY_QTY*C.PROD_COST) AS ���Աݾ��հ�
    FROM  CSS02.BUYPROD A
    INNER JOIN CSS02.PROD C  ON(A.PROD_ID = C.PROD_ID AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630'))
    INNER JOIN CSS02.LPROD B ON(C.LPROD_GU = B.LPROD_GU )
    GROUP BY C.LPROD_GU, B.LPROD_NM
     ORDER BY 1
    
��뿹4) 2020�� �ŷ�ó��, ��ǰ�� ����� ���踦 ��ȸ�Ͻÿ�.
        Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ��, �Ǹż���, �Ǹűݾ�
 
 �Ϲ�)
    SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
           A.BUYER_NAME AS �ŷ�ó��,
           B.PROD_NAME AS ��ǰ��,
           SUM(C.CART_QTY) AS �Ǹż���,
           SUM(B.PROD_PRICE*C.CART_QTY) �Ǹűݾ�
    FROM CSS02.BUYER A, CSS02.PROD B, CSS02.CART C
    WHERE B.PROD_ID = C.PROD_ID -- �ǸŴܰ� ����
    AND B.BUYER_ID = A.BUYER_ID
      AND SUBSTR(CART_NO,1,6)BETWEEN '202001' AND '202012' 
    GROUP BY A.BUYER_NAME, B.PROD_NAME,  A.BUYER_ID
    ORDER BY 1
 
 �Ƚ�)
     SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
           A.BUYER_NAME AS �ŷ�ó��,
           B.PROD_NAME AS ��ǰ��,
           C.CART_QTY AS �Ǹż���,
           SUM(B.PROD_PRICE*C.CART_QTY) �Ǹűݾ�
    FROM CSS02.BUYER A
    INNER JOIN CSS02.PROD B ON(A.BUYER_ID=B.BUYER_ID)
    INNER JOIN CSS02.CART C ON(B.PROD_ID=C.PROD_ID)
     WHERE SUBSTR(CART_NO,1,6)BETWEEN '202001' AND '202012' 
    GROUP BY A.BUYER_NAME, B.PROD_NAME,  A.BUYER_ID, C.CART_QTY
 
        
��뿹5) HR �������� �̱� �̿ܿ� �ٹ��ϴ� ���������� ��ȸ�Ͻÿ�. �̱��� �����ڵ�� 'US'��
        Alias�� �����ȣ, �����, �μ��ڵ�, �μ���, �μ��ּ��̸� �μ����� ����Ͻÿ�.
        
        SELECT A.EMPLOYEE_ID AS �����ȣ,
               A.EMP_NAME AS �����,
               B.DEPARTMENT_ID AS �μ��ڵ�,
               B.DEPARTMENT_NAME AS �μ���,
               C.STREET_ADDRESS||' '||C.CITY||' '||C.STATE_PROVINCE||' '||D.COUNTRY_NAME AS �μ��ּ�
          FROM HR.EMPLOYEES A
          INNER JOIN HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
          INNER JOIN HR.LOCATIONS C ON(B.LOCATION_ID=C.LOCATION_ID AND C.COUNTRY_ID !='US')
          INNER JOIN HR.COUNTRIES D ON(C.COUNTRY_ID=D.COUNTRY_ID);
    
    
�� ���� �Ϲ�����)
        SELECT A.EMPLOYEE_ID AS �����ȣ,
               A.EMP_NAME AS �����,
               B.DEPARTMENT_ID AS �μ��ڵ�,
               B.DEPARTMENT_NAME AS �μ���,
               C.STREET_ADDRESS||' '||C.CITY||' '||C.STATE_PROVINCE||' '||D.COUNTRY_NAME AS �μ��ּ�
          FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.COUNTRIES D
          where A.DEPARTMENT_ID = B.DEPARTMENT_ID
          and B.LOCATION_ID=C.LOCATION_ID AND C.COUNTRY_ID !='US'
          and C.COUNTRY_ID=D.COUNTRY_ID
          group by A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_ID,B.DEPARTMENT_NAME,  C.STREET_ADDRESS||' '||C.CITY||' '||C.STATE_PROVINCE||' '||D.COUNTRY_NAME



��뿹6) 2020�� ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�
        
�Ϲ�)
SELECT A.PROD_ID AS ��ǰ�ڵ�,
       A.PROD_NAME AS ��ǰ��,
       SUM(B.CART_QTY) AS �Ǹ�����
FROM CSS02.PROD A, CSS02.CART B
WHERE A.PROD_ID=B.PROD_ID
AND SUBSTR(CART_NO,1,6)BETWEEN '202001' AND '202012'
GROUP BY A.PROD_ID, A.PROD_NAME


����
SELECT A.PROD_ID AS ��ǰ�ڵ�,
       A.PROD_NAME AS ��ǰ��,
       SUM(B.CART_QTY) AS �Ǹ�����
FROM CSS02.PROD A
INNER JOIN CSS02.CART B ON (A.PROD_ID=B.PROD_ID)
WHERE SUBSTR(CART_NO,1,6)BETWEEN '202001' AND '202012'
GROUP BY A.PROD_ID, A.PROD_NAME


��뿹6) 2020�� ����ȸ���� �Ǹ����踦 ��ȸ�Ͻÿ�.
�Ϲ�) 
    SELECT EXTRACT(MONTH FROM TO_DATE(SUBSTR(CART_NO,1,8)))  AS ����,
           A.MEM_NAME AS ȸ����,
           SUM(B.CART_QTY) AS �Ǹ�����
    FROM CSS02.MEMBER A, CSS02.CART B
    WHERE A.MEM_ID = B.MEM_ID
    GROUP BY EXTRACT(MONTH FROM TO_DATE(SUBSTR(CART_NO,1,8))), A.MEM_NAME
    ORDER BY 1
    
ANSI) 
    SELECT EXTRACT(MONTH FROM TO_DATE(SUBSTR(CART_NO,1,8)))  AS ����,
           A.MEM_NAME AS ȸ����,
           SUM(B.CART_QTY) AS �Ǹ�����
    FROM CSS02.MEMBER A
    INNER JOIN  CSS02.CART B ON (A.MEM_ID = B.MEM_ID)
     GROUP BY EXTRACT(MONTH FROM TO_DATE(SUBSTR(CART_NO,1,8))), A.MEM_NAME
    ORDER BY 1

��뿹7) ������̺��� ������ ���� ��µǵ��� �����Ͻÿ�.
        Alias �����ȣ, �����, �μ���, �޿�
    SELECT B.EMPLOYEE_ID AS �����ȣ,
           B.EMP_NAME AS �����,
           A.DEPARTMENT_NAME AS �μ���,
           B.SALARY AS �޿�
    FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
    WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID

ANSI)
 SELECT B.EMPLOYEE_ID AS �����ȣ,
           B.EMP_NAME AS �����,
           A.DEPARTMENT_NAME AS �μ���,
           B.SALARY AS �޿�
    FROM HR.DEPARTMENTS A
    INNER JOIN HR.EMPLOYEES B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)



��뿹) ���� ���� ���� �ֹ��� ��� ���
    SELECT SUBSTR(A.CART_NO,5,2) AS ����,
           B.MEM_NAME AS ����,
           SUM(A.CART_QTY) AS �ֹ���
    FROM CSS02.CART A, CSS02.MEMBER B
    WHERE A.MEM_ID = B.MEM_ID
    GROUP BY SUBSTR(A.CART_NO,5,2), B.MEM_NAME
    ORDER BY 1, 3 DESC
        
        
��뿹) 50~90�� �μ����� ���� ���� �޿��� �޴� ������ ǥ���ϰ� �ش� ������ ��� �ټӿ����� ����Ͻÿ�.
    SELECT A.DEPARTMENT_ID AS �μ���ȣ,
           B.JOB_TITLE AS �����,
           MAX(C.SALARY) AS �޿�,
           AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM C.HIRE_DATE)) AS ��ձټӿ���
    FROM HR.DEPARTMENTS A, HR.JOBS B, HR.EMPLOYEES C
    WHERE A.DEPARTMENT_ID = C.DEPARTMENT_ID
    AND B.JOB_ID = C.JOB_ID
    AND A.DEPARTMENT_ID BETWEEN 50 AND 90
    GROUP BY A.DEPARTMENT_ID, B.JOB_TITLE
    ORDER BY 3