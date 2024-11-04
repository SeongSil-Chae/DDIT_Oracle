2024-1023-01)�����Լ�(WINDOW �Լ�)
 - RANK() OVER, DENSE_RANK() OVER, ROW_NUMBER() OVER �� ����
�������)
  RANK()|DENSE_RANK()|ROW_NUMBER() OVER(ORDER BY �÷���[DESC|ASC] [,�÷���[DESC|ASC],...])
  . SELECT �������� ����.
  
��뿹) ��ǰ���̺��� �Ǹ��������� ū ��ǰ���� ����� �ο��Ͻÿ�. 
        �� ���� ���̸� ���Դܰ��� ū ��ǰ���� ����ο�
        Alias�� ��ǰ�ڵ�, ��ǰ��, ���Դܰ�, ������, ���
        SELECT PROD_ID AS ��ǰ�ڵ�,
               PROD_NAME AS ��ǰ��,
               PROD_COST AS ���Դܰ�,
               PROD_PRICE-PROD_COST AS ������,
               RANK() OVER(ORDER BY (PROD_PRICE-PROD_COST) DESC) AS "���1(RNAK)",
               DENSE_RANK() OVER(ORDER BY (PROD_PRICE-PROD_COST) DESC, PROD_COST DESC) AS"���2(DENSE_RANK)",
               ROW_NUMBER() OVER(ORDER BY (PROD_PRICE-PROD_COST) DESC, PROD_COST DESC) AS"���3(ROW_NUMBER)"
        FROM CSS02.PROD;
        
��뿹) ������̺��� �� ������� �����ȣ, �����, �Ի���, ������ ��ȸ�Ͻÿ�.
        ������ �Ի��� ������ ����� �ο��Ͻÿ�.
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����,
               HIRE_DATE AS �Ի���,
               RANK() OVER(ORDER BY HIRE_DATE) AS ����
        FROM HR.EMPLOYEES
    
**�׷캰 ����
�������) 
    RANK()|DENSE_RANK()|ROW_NUMBER() OVER((PARTITION BY �÷���[,�÷���,...]
                                        ORDER BY �÷���[DESC|ASC] [,�÷���[DESC|ASC],...])
    . 'PARTITION BY �÷���' : �÷������� �׷�ȭ �� �� �����ο�
    
��뿹) ������̺��� �μ��� �޿������� ������ �ο��Ͻÿ�. �����ȣ, �����, �μ���ȣ, �޿�, ����
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ���ȣ,
           SALARY AS �޿�,
           RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS ����
      FROM HR.EMPLOYEES
��뿹) ȸ�����̺��� ���ɴ뺰 ���ϸ��� ������ ������ �ο��Ͻÿ�. ȸ����ȣ, ȸ����, ����, ���ϸ���, ����
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS ����, 
           MEM_MILEAGE AS ���ϸ���,
           RANK() OVER(PARTITION BY TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR))/10) ORDER BY MEM_MILEAGE DESC) AS ����
      FROM CSS02.MEMBER
        
        -- ���ɴ� ���ϴ¹�
        -- TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR))/10)
        
        