2024-1017-01) ��Ÿ ������
 - BETWEEN, LIKE, IN, SOME, ANY, ALL, EXISTS �����ڰ� ������.
 
 1. BETWEEN ������
  - ������ �����Ҷ� ���
  - �� ������ 'AND'�� ����Ͽ� ���
  
(�������)
  expr   BETWEEN ��1 AND ��2
   - ��1�� ��2�� ���� Ÿ���̾�� ��.
   
��뿹) ��ǰ���̺��� �з��ڵ尡 P100 ���� ��� ��ǰ�� ��ȸ�Ͻÿ�.
      Alias�� ��ǰ�ڵ�, ��ǰ��, �з��ڵ�
(AND ������ ���)
      SELECT PROD_ID AS ��ǰ�ڵ�,
             PROD_NAME AS ��ǰ��,
             LPROD_GU AS �з��ڵ�
      FROM CSS02.PROD
      WHERE  LPROD_GU>=UPPER('P100') AND LPROD_GU<=UPPER('P199')    -- UPPER =  �빮�ڷ� �ٲ��.
      
(BETWEEN ���)
      SELECT PROD_ID AS ��ǰ�ڵ�,
             PROD_NAME AS ��ǰ��,
             LPROD_GU AS �з��ڵ�
      FROM CSS02.PROD
      WHERE  LPROD_GU BETWEEN UPPER('P100') AND UPPER('P199')
      
��뿹) ��� ���̺��� �޿��� 5000~8000 ������ ������� ��ȸ�Ͻÿ�.
        Alias�� �����ȣ, �����, �μ��ڵ�, �޿�
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ��ڵ�,
           SALARY AS �޿�
    FROM HR.EMPLOYEES
    WHERE SALARY BETWEEN 5000 AND 8000
    ORDER BY 4;
        
        
��뿹) �������̺��� 2020�� 2�� ���������� ��ȸ�Ͻÿ�.
        Alias�� ��¥, ���Ի�ǰ��ȣ, ���Լ���
    SELECT BUY_DATE AS ��¥,
           BUY_PROD AS ���Ի�ǰ��ȣ,
           BUY_QTY AS ���Լ���
        FROM CSS02.BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE(20200201) AND LAST_DAY(TO_DATE(20200201))     -- TO_DATE = ���ڵ� ���ڵ� ��¥�� �ٲټ���.
        

2. LIKE
 - ���Ϻ� ������
 - ���ϱ����� '%'�� '_' ���ڿ�(���ϵ� ī��)�� ����
 - ���� ����� �����ϱ� ������ ȿ������ �ټ� ����
 - ���ڿ� �� ��������(��¥, ����, �����Ϳ��� ������� ����)
 - '%'
   . '%'�� ���� ��ġ ���� ��� ���ڿ��� ����
   . ���鹮�ڿ��� ������
   . ex)
    '��%' : '��'�� �����ϴ� ��� ���ڿ��� ����(���� ��ȯ)
    '%��' : '��'�� ������ ��� ���ڿ��� ����(���� ��ȯ)
    '%��%':  �־��� ���ڿ� ���ο� '��'�� �����ϸ� ���� ��ȯ
 - '_'
  . '_'�� ���� ��ġ ���� �ϳ��� ���ڿ��� ����
  .ex)
    '��_' : '��'�� �����ϰ� ���ڰ� 2�����̸� ���� ��ȯ
    '_��' : '��'�� ������ 2������ ���ڿ��̸� ���� ��ȯ
    '_��_' : �־��� ���ڿ� ���ο� '��'�� �����ϸ� ���� ��ȯ
 
 ��뿹) �������� �泲�� ȸ���� ȸ����, �ּ� , ���ϸ����� ��ȸ
    SELECT MEM_NAME AS ȸ����,
           MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
           MEM_MILEAGE AS ���ϸ���
    FROM CSS02.MEMBER
    WHERE MEM_ADD1 LIKE '�泲%'
    
 ��뿹) �达���� ���� ȸ���� �̸�, �ּ�, ���ϸ��� ��ȸ
    SELECT MEM_NAME AS ȸ����,
           MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
           MEM_MILEAGE AS ���ϸ���
    FROM CSS02.MEMBER
    WHERE MEM_NAME LIKE '��%'
    
 ��뿹) 2020�� 6�� �Ǹ�������ȸ
       Alias�� ��¥, �ǸŻ�ǰ��ȣ, �Ǹż���
       SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS ��¥,
              PROD_ID AS �ǸŻ�ǰ��ȣ,
              CART_QTY AS �Ǹż���
       FROM CSS02.CART
       WHERE CART_NO LIKE '202006%'
        
 ��뿹) 2020�� 1�� ��������
       Alias�� ��¥, �ǸŻ�ǰ��ȣ, �Ǹż���
       SELECT BUY_DATE AS ��¥,
              BUY_PROD AS �ǸŻ�ǰ��ȣ,
              BUY_QTY AS �Ǹż���
       FROM CSS02.BUYPROD
       WHERE BUY_DATE BETWEEN '20200101' AND '20200131'
       -- WHERE BUY_DATE LIKE('2020/01%') ��¥ ���̿� / - �̷��� ���� �� ������ LIKE �Ⱦ���.
 
 
 3. IN ������
  - ������ ������(�������� ����� ��)
  - IN�����ڴ� ���ο� '='����� ������
  - �־��� �ټ��� ������ �� ��� �ϳ��� ��ġ�ϸ� TRUE ��ȯ
  - OR �����ڷ� �ٲپ� ����� �� ����
  - �ҿ������̰ų� �ұ�Ģ���� ���� �� 
�������)
  expr   IN(��, ��2,...)
 
 ��뿹) ������̺��� 10,20,90�� �μ��� ���� ��������� ��ȸ�Ͻÿ�
       Alias��  �����ȣ, �����, �μ���ȣ
(OR ������ ���)
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ���ȣ
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID=10
        OR DEPARTMENT_ID=20
        OR DEPARTMENT_ID=90
        
(IN ������ ���)
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ���ȣ
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID IN(10,20,90)
    
��뿹)�Ҽӻ���� ���� 10�� �̻��� �μ��� �μ���ȣ, �μ���, ��ġ�ڵ带 ����Ͻÿ�.
--�������� = ���� ���ϴ� ������ ���س��� ��
    
�������� : �Ҽӻ���� ���� 10�� �̻��� �μ��� �μ���ȣ
    SELECT A.DEPARTMENT_ID
      FROM (SELECT DEPARTMENT_ID,
             COUNT(*)
              FROM HR.EMPLOYEES
           GROUP BY DEPARTMENT_ID
           HAVING COUNT(*)>=10) A  -- A�� ���� ��Ī���� ���
    
    (�������� ���� ���� �־��� ���ҿ�)
    SELECT DEPARTMENT_ID,
           COUNT(*)
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID
      HAVING COUNT(*)>=10 A
      
 �������� : �μ� ���̺��� �μ���ȣ, �μ���, ��ġ�ڵ�
   SELECT DEPARTMENT_ID AS �μ���ȣ,
          DEPARTMENT_NAME AS �μ���,
          LOCATION_ID AS ��ġ�ڵ�
     FROM HR.DEPARTMENTS
     WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
                             FROM (SELECT DEPARTMENT_ID,
                                   COUNT(*)
                                   FROM HR.EMPLOYEES
                                   GROUP BY DEPARTMENT_ID
                                   HAVING COUNT(*)>=10) A)
                                   

                                   
                                   
 4. ANY(SOME)
�������)
  expr  ���迬���� ANY(SOME)(��1,��2,...��N)
  . �־��� ��1 ~ ��N �� ��� �ϳ��� ���� ���迬���ڸ� �����ϸ� true�� ��ȯ
  . ���� ���迬���ڰ� '='�� ��� IN�� ����
  . ���� ���迬���� �� '>'�� ���Ǹ� '��1'~'��N'�� ���� ���������� ũ�� true
  
��뿹) ������̺��� �޿��� 3000,4000,5000 �̻��� ����� �����, �μ���ȣ, �޿��� ���
    SELECT EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ���ȣ,
           SALARY AS �޿�
      FROM HR.EMPLOYEES
      WHERE SALARY > ANY(3000,4000,5000)
    --WHERE SALARY > SOME(3000,4000,5000)
      ORDER BY 3
                                   
      SELECT EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ���ȣ,
           SALARY AS �޿�
      FROM HR.EMPLOYEES
      WHERE SALARY = ANY(3080,4620,5000)
      ORDER BY 3                                 
 
 
 
 
 
 
 