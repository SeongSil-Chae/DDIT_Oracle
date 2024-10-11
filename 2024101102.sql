2024-1011-02)ALTER ��
  - �̸� ����(���̺�, �÷�, ��������), �߰�(�÷�, ��������), Ÿ�Ժ���(�÷��� �ڷ�Ÿ��), ����(�÷�, ��������)
  - ALTER RENAME, ALTER ADD, ALTER MODIFY, ALTER DROP
  
1)ALTER RENAME
 - ���̺��, �÷���, �������� �̸��� ����
 (�������)
 ALTER TABLE OLD_���̺�� RENAME TO NEW_���̺��;  --���̺�� ����
 
 (��뿹) BUYPROD���̺� �̸��� PURCHASE�� �����ض�.
   ALTER TABLE PURCHASE RENAME TO BUYPROD;
  
 
 ALTER TABLE ���̺�� RENAME COLUMN OLD_�÷��� TO NEW_�÷���;  --�÷��� ����
 ��뿹) PROD���̺��� PROD_LGU�÷��� LPROD_GU��, PROD_BUYER_ID�� ���� 
  ALTER TABLE PROD RENAME COLUMN PROD_LGU TO LPROD_GU;
   -- ���� ���ӿ��� ���� ������ Ŭ���ؼ� ���ϸ�, Ŭ�и� ���� ����.

 ALTER TABLE ���̺�� RENAME CONSTRAINTS OLD_����� TO NEW_�����; -- ����� ����
��뿹) BUYER���̺��� �ܷ�Ű ������(FR_BUYER_LGU)��  (KF_BUYER_LG)�� ����
 ALTER TABLE BUYER RENAME CONSTRAINTS KF_BUYER_LG TO FK_LPROD_LG;
 
 2) ALTER ADD
  - �÷�, ���������� �߰�
 (�������) 
  ALTER TABLE ���̺�� ADD (�÷� ���ǹ�); 
 (��뿹) HR������ EMPLOYEE���̺� EMP_NAME VARCHAR2(45)�� �߰��Ͻÿ�.
 ALTER TABLE HR.EMPLOYEES ADD(EMP_NAME VARCHAR2(45));
 
 UPDATE HR.EMPLOYEES
    SET EMP_NAME=FIRST_NAME||' '||LAST_NAME;        --|| = �� ��ȣ�� +��
   COMMIT;
 

��뿹) �а����̺�(DEPARTMENT), �������̺�(PROFESSOR)�� ����
 CREATE TABLE PROFESSOR(
   P_ID NUMBER(3),
   P_NAME VARCHAR(30),
   P_MAJOR VARCHAR2(50),
   P_TEL VARCHAR2(30),
   DEPT_ID NUMBER(5));
   
 CREATE TABLE DEPARTMENT(
    DEPT_ID NUMBER(5),
    DEPT_NAME VARCHAR2(30),
    DEPT_TEL VARCHAR2(30));
 
�⺻Ű ���� -- ���̺� �����ؼ� 2�� �⺻Ű �����ϰ� ���� ���̺� �а�Ű�� �ܷ�Ű�� ��.
  ALTER TABLE PROFESSOR ADD CONSTRAINTS pk_professor primary key(P_ID);
  
  ALTER TABLE DEPARTMENT ADD CONSTRAINTS pk_dept primary key(DEPT_ID);
  
  ALTER TABLE PROFESSOR ADD CONSTRAINTS Fk_profe_dept FOREIGN key(DEPT_ID)
                                        REFERENCES DEPARTMENT(DEPT_ID);
                                        
                                        
                                        
3) ALTER MODIFY
  - �÷��� �ڷ�Ÿ���̳� ũ�⺯��
�������)
  ALTER TABLE ���̺�� MODIFY �÷����ǹ�;
  
��뿹) HR������ EMPLOYEES���̺��� EMP_NAME�÷��� CHAR(50)���� �����Ͻÿ�.

ALTER TABLE HR.EMPLOYEES MODIFY EMP_NAME CHAR(50);
ALTER TABLE HR.EMPLOYEES MODIFY EMP_NAME VARCHAR2(50);
-- �� ó�� CHAR (��������)�� ���ִ°� VARCHAR�� �����ص� ũ�Ⱑ �� ������.
-- �׷��� ������Ʈ �ʿ�.
UPDATE HR.EMPLOYEES
    SET EMP_NAME=TRIM(EMP_NAME);
    COMMIT;
  
  