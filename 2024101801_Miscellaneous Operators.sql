2024-1018-01) ��Ÿ������ 

5. ALL
�������)
  expr  ���迬����ALL(��1, ��2,...��N)
  . �־��� ��1 ~ ��N ��ο� ���� ���迬���ڸ� �����ϸ� true�� ��ȯ
  . ���迬���� �� '='�� ����� �� ����.
  . ���� ���迬���� �� '>'�� ���Ǹ� '��1' ~ '��n' �� ���� ū������ ũ�� true
  
��뿹) ������̺��� 10~50�� �μ��� ��ձ޿����� ���� �޿��� �޴� �����
        �����ȣ, �����, �μ���ȣ, �޿��� ��ȸ�Ͻÿ�.
    (���� ����)    
    SELECT �����ȣ, �����, �μ���ȣ, �޿�
    FROM HR.EMPLOYEES
    WHERE SALARY>ALL (10~50�� �μ��� ��ձ޿�);
    
    (�������� : 10~50�� �μ��� ��ձ޿�)
    SELECT A.ASAL   -- �Ʒ� �߿��� ��ձ޿��� ����ϱ� ���� �̷��� ��.
    FROM (SELECT DEPARTMENT_ID,
            AVG(SALARY) AS ASAL
             FROM HR.EMPLOYEES
             WHERE DEPARTMENT_ID BETWEEN 10 AND 50
             GROUP BY DEPARTMENT_ID)A
             
(����)
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ���ȣ,
           SALARY AS �޿�
    FROM HR.EMPLOYEES
    WHERE SALARY>ALL (SELECT A.ASAL   
                        FROM (SELECT DEPARTMENT_ID,
                        AVG(SALARY) AS ASAL
                        FROM HR.EMPLOYEES
                        WHERE DEPARTMENT_ID BETWEEN 10 AND 50
                        GROUP BY DEPARTMENT_ID)A)
    ORDER BY 4;
    
    
    
    
    