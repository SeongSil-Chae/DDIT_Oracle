2024-1016-01)

����1) ��ǰ���̺��� �ǸŰ����� 100���� �̻��� ��ǰ�� ��ȸ�Ͻÿ���
        Alias�� ��ǰ��ȣ,��ǰ��,�ǸŰ��� 
        SELECT PROD_ID AS ��ǰ��ȣ,
               PROD_NAME AS ��ǰ��,
               PROD_PRICE AS �ǸŰ���
        FROM CSS02.PROD
        WHERE PROD_PRICE>=1000000;
����2) ȸ�����̺��� ���ϸ����� 2000 �̸��� ȸ�������� ��ȸ�Ͻÿ�. 
        Alias�� ȸ����ȣ,ȸ����,����,���ϸ���
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_JOB AS ����,
               MEM_MILEAGE AS ���ϸ���
        FROM CSS02.MEMBER
        WHERE MEM_MILEAGE<2000
        
����3) ���￡ �����ϴ� ȸ�������� ��ȸ�Ͻÿ�
        Alias�� ȸ����ȣ,ȸ����,�ּ�
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_ADD1 AS �ּ�
        FROM CSS02.MEMBER
        WHERE MEM_ADD1 LIKE '����%'
        
����4) 2020�� 6���� �������� ���� ȸ������ ��ȸ�Ͻÿ�
        Alias�� ȸ����ȣ,ȸ����,����,���ϸ���
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               SUBSTR(MEM_REGNO2,1,1) IN '2', '4'||'����' AS ����,
               MEM_MILEAGE AS ���ϸ���
        FROM CSS02.MEMBER
        WHERE 
        
����5) ��ǰ���̺��� �ǸŰ����� 10���� ~ 20������ ���ϴ� ��ǰ���� ��ȸ�Ͻÿ�.
        Alias�� ��ǰ��ȣ, ��ǰ��, ���԰���, �ǸŰ���
        SELECT PROD_ID AS ��ǰ��ȣ,
               PROD_NAME AS ��ǰ��,
               PROD_COST AS ���԰���,
               PROD_PRICE AS �ǸŰ���
        FROM CSS02.PROD
        WHERE PROD_PRICE>=100000 AND PROD_PRICE<=200000;
        
����6) hr������ ������̺��� �Ի����� 2016�� �����̸� �޿��� 10000������ ������� ��ȸ�Ͻÿ�.
        ALias�� �����ȣ, �����, �Ի���, �޿�
        SELECT EMPLOYEE_ID AS �����ȣ,
               FIRST_NAME||' '||LAST_NAME AS �����,
               HIRE_DATE AS �Ի���,
               SALARY AS �޿� 
        FROM HR.EMPLOYEES
        WHERE HIRE_DATE<'2016/01/01' AND SALARY <=10000
        
����7) ��ǰ���̺��� ��ǰ�� �з��� 'p201' �Ǵ� 'p203'�� ���ϴ� ��ǰ���� ��ȸ�Ͻÿ�. 
        Alias�� ��ǰ��ȣ, ��ǰ��, �з��ڵ�
        
        SELECT PROD_ID AS ��ǰ��ȣ,
               PROD_NAME AS ��ǰ��,
               LPROD_GU �з��ڵ�
        FROM CSS02.PROD
        WHERE LPROD_GU = 'P201' OR LPROD_GU = 'P203'
