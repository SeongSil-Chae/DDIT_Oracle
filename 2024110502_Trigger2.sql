2024-1105-02)
1. ������̺��� �����ȣ,�����,�μ��ڵ�,�Ի���,�����ڵ�� ������ ���̺� TBL_EMP�� �����Ͻÿ�

  CREATE TABLE TBL_EMP AS
    SELECT EMPLOYEE_ID,EMP_NAME,DEPARTMENT_ID,HIRE_DATE,JOB_ID
      FROM EMPLOYEES;
      
2. ���̺� TBL_EMP�� ���� ������ RETIRES ���̺��� �����Ͻÿ�
  CREATE TABLE RETIRES AS
    SELECT *  FROM TBL_EMP;  
    
  DELETE FROM  RETIRES; 
  
  
��뿹)TBL_EMP���̺��� �Ի����� 2016�� ����������� ����ó���Ͻÿ�
      ����ó���� ������ ������ RETIRES���̺� �����ϰ� TBL_EMP���̺��� �����ϴ� �۾� 
  SELECT * FROM TBL_EMP
    WHERE HIRE_DATE<=TO_DATE('20160101');
    
  CREATE OR REPLACE TRIGGER tg_retire
    BEFORE  DELETE  ON  TBL_EMP
    FOR EACH ROW
  BEGIN
    INSERT INTO RETIRES(EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, HIRE_DATE, JOB_ID)
      VALUES(:OLD.EMPLOYEE_ID, :OLD.EMP_NAME, :OLD.DEPARTMENT_ID, :OLD.HIRE_DATE, :OLD.JOB_ID);
  END;
  
    DELETE  FROM TBL_EMP
     WHERE HIRE_DATE<=TO_DATE('20160101');
