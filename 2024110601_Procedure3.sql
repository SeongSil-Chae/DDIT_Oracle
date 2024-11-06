2024-1106-01)extra lec01

���ν��� ����
1. ������̺��� ����� ���� 5���̻��� �μ��� �μ��ڵ�,�μ���,����������� ����ϴ� ���ν��� �ۼ�

  1) ������̺��� ����� ���� 5���̻��� �μ��� �μ��ڵ�
     SELECT DEPARTMENT_ID,
            COUNT(*)
       FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID
     HAVING COUNT(*)>=5; 
     
  2) ���ν��� ����
     CREATE OR REPLACE PROCEDURE proc_dept_info(
       P_DID  IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
     IS
       L_DEPT_NAME VARCHAR2(100); --�μ���
       L_MANAGER_NAME  VARCHAR2(100); --���������
     BEGIN                  
       SELECT A.DEPARTMENT_NAME,B.EMP_NAME INTO L_DEPT_NAME,L_MANAGER_NAME
         FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
        WHERE A.MANAGER_ID=B.EMPLOYEE_ID
          AND A.DEPARTMENT_ID=P_DID;
       DBMS_OUTPUT.PUT('  '||P_DID||'   ');
       DBMS_OUTPUT.PUT(RPAD(L_DEPT_NAME,20));
       DBMS_OUTPUT.PUT_LINE(RPAD(L_MANAGER_NAME,9));
       DBMS_OUTPUT.PUT_LINE('--------------------------------------');
     END;
  

  3) ����  
     DECLARE
       CURSOR cur_dept02  IS
         SELECT DEPARTMENT_ID, COUNT(*)
           FROM HR.EMPLOYEES
          GROUP BY DEPARTMENT_ID
         HAVING COUNT(*)>=5;        
     BEGIN
       FOR REC IN cur_dept02 LOOP
           proc_dept_info(REC.DEPARTMENT_ID);
       END LOOP;
     END;


2. Ű����� ���ɴ븦 �Է� �޾� �� ���ɴ뿡 �ش��ϴ� ȸ������ 2020�� ������Ȳ�� ���
   ����� ������ ȸ����ȣ, ȸ����, ���űݾ��հ��̸� ���űݾ� �հ�� �Լ����ۼ��ϰ�
   ����ϴºκ��� ���ν����� �ۼ��Ͻÿ�.
 1)�͸���
  ACCEPT P_AGE  PROMPT '���ɴ� �Է� : '
  DECLARE
    CURSOR cur_mem04 IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10=&P_AGE; 
  BEGIN
    FOR REC IN cur_mem04 LOOP
        proc_sales_info(REC.MEM_ID, REC.MEM_NAME);
    END LOOP;
  END;

 2)���ν���  
  CREATE OR REPLACE PROCEDURE proc_sales_info(
    P_MID IN MEMBER.MEM_ID%TYPE, P_NAME IN MEMBER.MEM_NAME%TYPE)
  IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||P_MID);
    DBMS_OUTPUT.PUT_LINE('ȸ���� : '||P_NAME);
    DBMS_OUTPUT.PUT_LINE('���űݾ��հ� : '||TO_CHAR(fn_sum_member(P_MID),'99,999,999'));
    DBMS_OUTPUT.PUT_LINE('------------------------------------------');
  END;

 3)�Լ�
  CREATE OR REPLACE FUNCTION fn_sum_member(
    P_MID  IN  MEMBER.MEM_ID%TYPE)
    RETURN NUMBER
  IS
    L_SUM NUMBER:=0; --���űݾ��հ�
  BEGIN
    SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_SUM
      FROM CART A, PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.MEM_ID=P_MID
       AND A.CART_NO LIKE '2020%';
    
    RETURN L_SUM;   
  END;


