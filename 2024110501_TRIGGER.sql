2024-1105-01)TRIGGER
 - Ư�� ���̺� �߻��� DML������� �ٸ� ���̺� �ڵ����� ������ ó�����ִ� 
   Ư�� ���ν���
 - Ʈ���� ���ο��� DCL���(COMMIT, ROLLBACK ���� ���)�� ����� �� ����
(�������)
  CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
     BEFORE|AFTER   INSERT | UPDATE | DELETE  ON ���̺��
    [FOR EACH ROW]
    [WHEN ����]
  [DECLARE]
    ���𿵿�;
  BEGIN
  --Ʈ���� ����
    ���࿵��;
  END;
   . ' BEFORE|AFTER' : Ʈ���� �����κ��� ����Ǵ� �������� 
     - BEFORE : '���̺��'�� 'INSERT | UPDATE | DELETE' �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ���� ����
     - AFTER : '���̺��'�� 'INSERT | UPDATE | DELETE' �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ���� ����
   . 'INSERT | UPDATE | DELETE' : ����Ǵ� �̺�Ʈ�� 'OR'�����ڸ� �̿��Ͽ� ���� ��� ����  
     ex) INSERT OR DELETE OR UPDATE  ON CART => CART���̺� ����,���� �Ǵ� ���� ����� ������ Ʈ���� ����
   . 'FOR EACH ROW'�� ����ϸ� ����� Ʈ���� �����ϸ� �������Ʈ���� ��
   . WHEN ���� : Ʈ���Ű� �߻��� ������ ���� ��ü������ ���
   . Ʈ���Ŵ� ������� Ʈ���ſ� ����� Ʈ���ŷ� ����
     - ������� Ʈ���� : �̺�Ʈ ��������� ���Ǽ��� ������� Ʈ���� ������ �ѹ��� ����
                       'FOR EACH ROW'�� ����
     - ����� Ʈ���� : ��κ��� Ʈ���ŷ� �̺�Ʈ ��������� �ึ�� Ʈ���� ���� ����
                     'FOR EACH ROW' ���
   . �ǻ緹�ڵ�(PSEUDO RECORD)
   ------------------------------------------------------------------------------------------
     �ǻ緹�ڵ�    �ǹ�
   ------------------------------------------------------------------------------------------  
      :NEW        INSERT, UPDATE �������Ǹ�, �����Ͱ�����(����)�ɶ����»��ο�̴�. 
                  DELETE �ÿ��¸���ʵ��NULL�̴�.
      :OLD        DELETE, UPDATE �������Ǹ�, �����Ͱ�����(����)�ɶ������ǰ��̴�.
                  INSERT �ÿ��¸���ʵ��NULL�̴�.
      :NEW, :OLD�� ����� TRIGGER���� ��밡��
   --------------------------------------------------------------------------------------=--
   . Ʈ���� �Լ�
   ------------------------------------------------------------------------------------------
     �Լ�           �ǹ�
   ------------------------------------------------------------------------------------------  
     INSERTING     �̺�Ʈ�� INSERT�̸� ��
     UPDATING      �̺�Ʈ�� UPDATE�̸� �� 
     DELETING      �̺�Ʈ�� DELETE�̸� ��
   ------------------------------------------------------------------------------------------   
     
��뿹)LPROD ���̺��� �з��ڵ� 'P501'�ڷḦ �����Ͻÿ�. �ڷᰡ �����Ǹ� 
      '�ڷ������ ���������� ����Ǿ����ϴ�!'��� �޽����� ����ϴ� Ʈ���Ÿ� �����Ͻÿ�
  CREATE OR REPLACE TRIGGER delete_lprod_tg
    AFTER  DELETE  ON  LPROD
  BEGIN
   DBMS_OUTPUT.PUT_LINE('�ڷ������ ���������� ����Ǿ����ϴ�!'); 
  END;
      
  DELETE  FROM LPROD WHERE LPROD_GU='P501'; 
  ROLLBACK;
  
  SELECT * FROM LPROD;
  
��뿹)LPROD ���̺��� �з��ڵ� 'P501'~'P503'�ڷḦ �����Ͻÿ�. �ڷᰡ �����Ǹ� 
      '�ڷ������ ���������� ����Ǿ����ϴ�!'��� �޽����� ����ϴ� Ʈ���Ÿ� �����Ͻÿ�  
  DELETE  FROM LPROD WHERE LPROD_GU>='P500';  
  COMMIT;
  
  
��뿹��)��ٱ������̺� �Է��� �߻��� ��(INSERT,UPDATE,DELETE) ���������̺�� ȸ�����̺��� �ڷḦ
        �����Ű�� Ʈ���Ÿ� �ۼ��Ͻÿ�.
  CREATE OR REPLACE TRIGGER tg_change_cart
    AFTER  INSERT OR UPDATE OR DELETE  ON CART
    FOR EACH ROW
  DECLARE
    L_QTY NUMBER:=0;
    L_PID PROD.PROD_ID%TYPE;
    L_DATE DATE;
    L_MILEAGE NUMBER:=0;
    L_MID MEMBER.MEM_ID%TYPE;
  BEGIN
    IF INSERTING THEN
       L_QTY:=(:NEW.CART_QTY);
       L_PID:=(:NEW.PROD_ID);
       L_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
       L_MID:=:NEW.MEM_ID;
    ELSIF UPDATING THEN
       L_QTY:=(:NEW.CART_QTY)-(:OLD.CART_QTY);
       L_PID:=(:NEW.PROD_ID);
       L_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
       L_MID:=:NEW.MEM_ID;
    ELSIF DELETING THEN
       L_QTY:= -(:OLD.CART_QTY);
       L_PID:=(:OLD.PROD_ID);
       L_DATE:=TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
       L_MID:=:OLD.MEM_ID;
    END IF;
  
  --������ UPDATE  
    UPDATE REMAIN A
       SET A.REMAIN_O=A.REMAIN_O + L_QTY,
           A.REMAIN_J_99=A.REMAIN_J_99 - L_QTY,
           A.REMAIN_DATE=L_DATE
     WHERE A.REMAIN_YEAR='2020'
       AND A.PROD_ID=L_PID;
    
  --ȸ�����̺� MILEAGE UPDATE 
    SELECT L_QTY*PROD_MILEAGE INTO L_MILEAGE
      FROM PROD
     WHERE PROD_ID=L_PID;
     
    UPDATE MEMBER A
       SET A.MEM_MILEAGE=A.MEM_MILEAGE+L_MILEAGE
     WHERE A.MEM_ID=L_MID; 
  END;
  

        
                    ����    ����  ����  ����� 
2020	P201000009	  9	    26	  0	   35	2020/01/31   
[a001ȸ���� ���ϸ��� : 6000]
[P201000009�� ���ϸ��� : 140]

2020	P201000009	  9	    26   10	   25	2020/07/28

2020	P201000009	  9	    26	  7	   28	2020/07/28

2020	P201000009	  9     26    0	   35	2020/07/28
   
��뿹) 2020�� 7�� 28�� 'a001'ȸ���� 'P201000009'��ǰ�� 10�� ����   
  INSERT INTO CART  VALUES('a001',fn_create_cart_no(TO_DATE('20200728'),'a001'),'P201000009',10);
  
   
��뿹) 2020�� 7�� 28�� 'a001'ȸ���� 'P201000009'��ǰ�� 3���� ��ǰ 
  UPDATE CART
     SET CART_QTY=7
   WHERE CART_NO = '2020072800006'
     AND PROD_ID = 'P201000009';
   
��뿹) 2020�� 7�� 28�� 'a001'ȸ���� 'P201000009'��ǰ�� ��� ��ǰ    
  DELETE FROM  CART
   WHERE CART_NO = '2020072800006'
     AND PROD_ID = 'P201000009'; 
   
   
     