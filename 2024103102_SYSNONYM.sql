2024-1031-02) ���Ǿ�(SYSNONYM)
 - ��ü�� �̸��� �� �ϳ��� �̸��� �ο�
 - ��ü�� ����� �� �ִ� �������� ������ ��밡��(�÷���Ī, ���̺� ��Ī���� ������)
 - �÷��� �ȵǰ� ��ü�� ����. (���̺� ����)
 
��뿹) 
    CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;
    
    SELECT * FROM HR.DEPARTMENTS;
    SELECT * FROM DEPT;
    
    SELECT  A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME
      FROM HR.EMPLOYEES A, DEPT B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     ORDER BY 1
     
     CREATE OR REPLACE SYNONYM MYDUAL FOR SYS.DUAL;
     
     SELECT SYSDATE FROM MYDUAL;