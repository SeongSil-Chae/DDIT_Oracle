2024-1031-04) PL/SQL 
��ü����: ��� ����, ĸ��ȭ ����(����������), �ٿ뼺 ����  // ���� ����Ȯ�ϸ� ��ü��ݾ�� ��� ��.

 - �͸���(��ǥ��), ���ν���, �Լ�, Ʈ����, ��Ű�� ���� ����
 
 1. �͸� ���
  - �̸��� ���� ���
  - 2���� �������� ����
(�������)
DECLARE
   ���𿵿� - ����, ���, Ŀ�� ����
BEGIN
   �����Ͻ� ���� ó�� 
   
   [EXCEPTION ó������]
END;


��뿹) Ű����� �μ��ڵ带 �Է� �޾� �ش�μ����� ���� ���� �Ի��� ����� 
        �����ȣ, �����, �Ի���, �޿��� ����ϴ� �͸����� �ۼ��Ͻÿ�.

        


 
   ACCEPT P_DEPT_ID PROMPT '�μ��ڵ� �Է�(10~110) : '
  DECLARE
    L_EMP_ID HR1.EMPLOYEES.EMPLOYEE_ID%TYPE;
    -- ������ Ÿ�� :%TYPE =  ������ Ÿ���� ������� �����Ͽ� ��� ��. ��� ���� Ÿ������ ����
    L_EMP_NAME VARCHAR2(60);
    L_HDATE DATE;
    L_SALARY NUMBER:=0;
     -- := ���� �����ڷ� 0�� NUMBER�� ����
  BEGIN
    SELECT EMPLOYEE_ID,EMP_NAME,HIRE_DATE,SALARY
      INTO L_EMP_ID,L_EMP_NAME,L_HDATE,L_SALARY
      FROM (SELECT EMPLOYEE_ID,EMP_NAME,HIRE_DATE,SALARY
              FROM HR1.EMPLOYEES
             WHERE DEPARTMENT_ID=&P_DEPT_ID    -- & = �����϶�
             ORDER BY HIRE_DATE)
     WHERE ROWNUM=1;
     
    DBMS_OUTPUT.PUT_LINE('�����ȣ : '||L_EMP_ID);
    DBMS_OUTPUT.PUT_LINE('����� : '||L_EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : '||L_HDATE);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||L_SALARY);
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
    
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('�����߻� : '||SQLERRM);    
  END;
      
  CURSOR ���)     
      
  ACCEPT P_DEPT_ID PROMPT '�μ��ڵ� �Է�(10~110) : '
  DECLARE
   CURSOR CUR_EMP01 IS
     SELECT EMPLOYEE_ID,EMP_NAME,HIRE_DATE,SALARY
       FROM HR1.EMPLOYEES
      WHERE DEPARTMENT_ID=&P_DEPT_ID 
      ORDER BY HIRE_DATE;
  BEGIN
    FOR REC IN CUR_EMP01 LOOP
      DBMS_OUTPUT.PUT_LINE('�����ȣ : '||REC.EMPLOYEE_ID);
      DBMS_OUTPUT.PUT_LINE('����� : '||REC.EMP_NAME);
      DBMS_OUTPUT.PUT_LINE('�Ի��� : '||REC.HIRE_DATE);
      DBMS_OUTPUT.PUT_LINE('�޿� : '||REC.SALARY);
      DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('�����߻� : '||SQLERRM);    
  END;       
        
        
        
        
        
        
        
        
        
        
        
        
        
