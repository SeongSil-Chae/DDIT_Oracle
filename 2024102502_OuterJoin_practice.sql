    
����1) 2020�� 2�� ~ 6������ ��ǰ�� ���� ������ �����Ͻÿ�. 
      ��, ���ȸ� ��ǰ�� ǥ��
    SELECT A.PROD_ID AS ��ǰ��ȣ,
           A.PROD_NAME AS ��ǰ��,
           NVL(SUM(B.CART_QTY),0) AS �������
    FROM CSS02.PROD A
    LEFT OUTER JOIN CSS02.CART B ON (A.PROD_ID=B.PROD_ID AND TO_DATE(SUBSTR(CART_NO,1,8)) BETWEEN ('20200201') AND ('20200630'))
    GROUP BY A.PROD_ID, A.PROD_NAME
    ORDER BY 3 DESC   
      
����2) ��� ��� �� �ε��� ��� ����� �μ���ȣ�� ������ ����Ͻÿ�.
    SELECT A.DEPARTMENT_ID AS �μ���ȣ,
           B.EMP_NAME AS �����,
           C.JOB_ID AS ������ȣ,
           C.JOB_TITLE AS ������,
           NVL(D.LOCATION_ID,0) AS �������,
           NVL(D.COUNTRY_ID,0) AS �����ڵ�
      FROM HR.DEPARTMENTS A
      LEFT OUTER JOIN HR.EMPLOYEES B ON (A.DEPARTMENT_ID=B.DEPARTMENT_ID)
      LEFT OUTER JOIN HR.JOBS C ON (B.JOB_ID=C.JOB_ID)
      LEFT OUTER JOIN HR.LOCATIONS D ON(A.LOCATION_ID=D.LOCATION_ID AND D.COUNTRY_ID = 'US')
      GROUP BY A.DEPARTMENT_ID, B.EMP_NAME, C.JOB_ID, C.JOB_TITLE, D.LOCATION_ID, D.COUNTRY_ID
      ORDER BY 1
    

����3) ��� ��ǰ���� 2020�� ������ ��ǰ �ݾ��� ���� ū ���� ǥ���ϰ� 
        �ǸŽ����� ��Ÿ������.
        
����4) ��� ���� �� Ŀ�̼��� �ִ� ����� �޿��� ǥ���ϼ���.
        �ش� �μ��� �޿� �հ踦 ��Ÿ�ÿ�.
    
    
    
    