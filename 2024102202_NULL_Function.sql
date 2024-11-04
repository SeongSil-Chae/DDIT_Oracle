2024-1022-02)NULLó���Լ�
 - NVL, NVL2, NULLIF ���� �Լ��� IS [NOT] NULL�����ڰ� ���� ��
 
��뿹)
 1. ��ǰ���̺��� �з��ڵ尡 'P301' ��ǰ�� ���Ⱑ���� ���԰������� �����Ͻÿ�.
    UPDATE CSS02.PROD 
        SET PROD_PRICE =PROD_COST
        WHERE UPPER(LPROD_GU)='P301'
        
        COMMIT;
 2. ������̺��� ��������(COMMISSION_PCT)�� ���� ������� ��ȸ�Ͻÿ�.
    SELECT COUNT(*) AS �����
      FROM HR.EMPLOYEES
      WHERE COMMISSION_PCT IS NULL
    
 3. ��ǰ���̺��� ũ������(prod_size)�� ��ȸ�ϵ� �� ���� null�̸� ��ũ������ �������� ����Ͻÿ�
    SELECT PROD_ID,
           PROD_NAME,
           NVL(PROD_SIZE, 'ũ����������')
    FROM CSS02.PROD;
 
4. 2020�� 6�� ��� ȸ���� ���������� ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ,ȸ����,���ż����հ��̸� ���������� ���� ȸ���� '���ž���'�� ����Ͻÿ�
    SELECT A.MEM_ID AS ȸ����ȣ,
           NVL(TO_CHAR(SUM(B.CART_QTY),'99,999'),'���ž���') AS ���ż����հ�
    FROM CSS02.MEMBER A
    LEFT OUTER JOIN CSS02.CART B ON(A.MEM_ID=B.MEM_ID AND B.CART_NO LIKE '202006%')
    GROUP BY A.MEM_ID

5. ������̺��� �� ����� �μ��ڵ带 ��ȸ�Ͽ� �μ��ڵ尡 ���� ����� '��������'�� ����ϰ�
    NULL�� �ƴϸ� �ش�μ��� ������ �����ȣ�� ����Ͻÿ�.
    �� �μ� �ڵ尡 NULL�̸� �μ��ڵ� ������ ������ ����Ͻÿ�.
    Alias�� �����ȣ, �����, �μ��ڵ�, ���
    SELECT B.EMPLOYEE_ID AS �����ȣ,
           B.EMP_NAME AS  �����,
           NVL(TO_CHAR(B.DEPARTMENT_ID), ' ') AS �μ��ڵ�,
           NVL2(B.DEPARTMENT_ID,(SELECT TO_CHAR(A.MANAGER_ID)
                                 FROM HR.DEPARTMENTS A
                                WHERE B.DEPARTMENT_ID = A.DEPARTMENT_ID),'��������') AS ���
    FROM HR.EMPLOYEES B
    ORDER BY B.DEPARTMENT_ID;
    
    -- ���� ���� �ȹ�� �����ε� �Ʒ� ����� ����.
    
   SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS  �����,
           NVL(TO_CHAR(DEPARTMENT_ID), ' ') AS �μ��ڵ�,
           NVL2(DEPARTMENT_ID,NVL(TO_CHAR(MANAGER_ID),'��ǥ'),'��������') AS ���
     FROM HR.EMPLOYEES 
    ORDER BY DEPARTMENT_ID;
    
 5. ��ǰ���̺��� ���԰��ݰ� ���Ⱑ���� ���� ��ǰ�� ã�� ����� '����������ǰ'�� ����ϰ� 
 �� �̿��� ��ǰ�� ������(����-����)�� ����Ͻÿ�. Alias�� ��ǰ�ڵ�, ��ǰ��, ���Դܰ�, ����ܰ�, ���
 SELECT PROD_ID AS ��ǰ�ڵ�,
        PROD_NAME AS ��ǰ��,
        PROD_COST AS ���Դܰ�,
        PROD_PRICE AS ����ܰ�,
        NVL2(NULLIF(PROD_COST, PROD_PRICE),TO_CHAR(PROD_PRICE-(NULLIF(PROD_COST, PROD_PRICE)),'9,999,999') ,'����������ǰ' ) AS ���
   FROM CSS02.PROD;
 
