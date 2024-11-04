2024-1021-03) �����Լ�
 - SUM AVG, COUNT, MIN, MAX�� ������.
 
 ��뿹) ȸ�����̺��� ��� ȸ������ ���ϸ��� �հ��, ��ո��ϸ���, �ο���, �ִ븶�ϸ���,
 �ּ� ���ϸ����� ���Ͻÿ�
    SELECT SUM(MEM_MILEAGE) AS ���ϸ����հ�,
           ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���,
           COUNT(*) AS �ο���,  -- *�� ���� NULL���� 1�� ǥ����. ������ ǥ�� / �÷����� ���� NULL ����
           MAX(MEM_MILEAGE) AS �ִ븶�ϸ���,
           MIN(MEM_MILEAGE) AS �ּҸ��ϸ���
    FROM CSS02.MEMBER;
    
 ���
 74300	3096	24	8700	1200
 

 ��뿹) ��ǰ���̺��� ��ǰ�� ��, �ִ��ǸŰ�, �ּ��ǸŰ��� ���Ͻÿ�.
    SELECT COUNT(*) ��ǰ�Ǽ�,
           MAX(PROD_PRICE) AS �ִ��ǸŰ�,
           MIN(PROD_PRICE) AS �ּ��ǸŰ�
    FROM CSS02.PROD  --�⺻Ű �÷����� ������ ������ ����  ����. ���̺� ��ü�� ������ ���� ���ü���


��뿹) 2020�� 4�� �Ǹż��� �հ踦 ���Ͻÿ�.
    SELECT SUM(CART_QTY) AS �Ǹż����հ�
    FROM CSS02.CART
    WHERE CART_NO LIKE'202004%'     
    

��뿹) ������̺��� �μ��� ��ձ޿��� �ο����� ��ȸ�Ͻÿ�
    SELECT DEPARTMENT_ID AS �μ�,
           ROUND(AVG(SALARY)) AS ��ձ޿�,
           COUNT(*) AS �ο���
    FROM HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID
    ORDER BY 1


��뿹) ��ǰ���̺��� �з��� ��ǰ�� ��, ����ǸŰ��� ��ȸ�Ͻÿ�.
    SELECT LPROD_GU AS �з��ڵ�,
           COUNT(PROD_ID) AS ��ǰ�Ǽ�,
           ROUND(AVG(PROD_PRICE)) AS ����ǸŰ�
      FROM CSS02.PROD
      GROUP BY LPROD_GU  --ROLLUP(LPROD_GU) �� ����ϸ� ���հ� ����
      ORDER BY 1


��뿹) �������̺��� 2020�� ���� ���Լ����հ踦 ��ȸ�Ͻÿ�.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS ��,
           SUM(BUY_QTY) AS ���Լ����հ�
      FROM CSS02.BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE)=2020
    GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    ORDER BY 1
 

��뿹) �������̺��� 2020�� ��ǰ�� ���Լ����հ踦 ��ȸ�Ͻÿ�.
    SELECT TO_DATE(BUY_DATE, 'YYYY/MM/DD') AS �⵵,
           PROD_ID AS ��ǰ,
           SUM(BUY_QTY) AS ���Լ����հ�
    FROM CSS02.BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE)=2020
    GROUP BY PROD_ID, BUY_DATE
    ORDER BY 1;


��뿹) �������̺��� ����, ��ǰ�� �Ǹż����հ踦 ��ȸ�Ͻÿ�.
    SELECT SUBSTR(CART_NO,5,2) AS ��,
           PROD_ID AS ��ǰ,
           SUM(CART_QTY) AS �Ǹż����հ�
    FROM CSS02.CART
    GROUP BY SUBSTR(CART_NO,5,2), PROD_ID
    ORDER BY 1


��뿹) ������̺��� �μ���, �⵵�� �Ի��� ������� ��ȸ�Ͻÿ�. 
    SELECT DEPARTMENT_ID AS �μ�, 
           EXTRACT(YEAR FROM HIRE_DATE) AS �⵵,
           COUNT(*) AS �����
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID, EXTRACT(YEAR FROM HIRE_DATE)
      ORDER BY 1, 2
      
      
��뿹) ������̺��� �μ���, �⵵�� �Ի��� ������� ��ȸ�ϵ� 
        �Ի��� ������� 5�� �̻��� �ڷḸ ����Ͻÿ�. �ڡ� HAVING ���
    SELECT DEPARTMENT_ID AS �μ�, 
           EXTRACT(YEAR FROM HIRE_DATE) AS �⵵,
           COUNT(*) AS �����
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID, EXTRACT(YEAR FROM HIRE_DATE)
      HAVING COUNT(*) >=5
      ORDER BY 1, 2
      
��뿹) �������̺��� 2020�� ���� ���Լ����հ� ��
        ���� ���� ������ ������ ����Ͻÿ�
    SELECT EXTRACT(MONTH FROM BUY_DATE)||'��' AS ��,
           SUM(BUY_QTY) AS ���Լ����հ�
      FROM CSS02.BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE)=2020
    GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    ORDER BY 2 DESC
    
    -- �����ϸ� �信 ������ �� ��ȣ�� ���� ��. ROWNUM �̶�� ��.
    -- �����Լ����� �����Լ��� ����Ҽ� ����.
��뿹) ȸ�����̺��� ���� ��ո��ϸ����� ��ȸ�Ͻÿ�.
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '����'
           ELSE '����' END AS ����,
           ROUND(AVG(MEM_MILEAGE)) AS ������ϸ��� 
      FROM CSS02.MEMBER
      GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '����'
           ELSE '����' END

��뿹) ȸ�����̺��� ��ɴ뺰 ȸ������ ��ո��ϸ����� ��ȸ�Ͻÿ�.
    SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE))-(EXTRACT(YEAR FROM MEM_BIR))/10) AS ��ɴ�,
           COUNT(*) AS ȸ����,
           ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
    FROM CSS02.MEMBER
    GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE))-(EXTRACT(YEAR FROM MEM_BIR))/10)
    ORDER BY 1

��뿹) ȸ�����̺��� �������� ��ո��ϸ����� ȸ������ ��ȸ�Ͻÿ�.
    SELECT SUBSTR(MEM_ADD1,1,2) AS �ּ�,
           ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���,
           COUNT(*) AS ȸ����
    FROM CSS02.MEMBER
    GROUP BY SUBSTR(MEM_ADD1,1,2)