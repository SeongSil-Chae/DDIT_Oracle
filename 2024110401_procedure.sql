2024-1104-01)Stored procedure(procedure)
  - ��ȯ���� ����.(function���� ������)
  - �ڹٿ��� ����Ҷ����� CallableStatement ��ü�� ����ؾ���.
    (�Ϲ� select, insert, update, delete���� Statement �� PreparedStatement��ü ���)
�������)
  CREATE [OR REPLACE] PROCEDURE ���ν����� [(
    ������ [IN|OUT|INOUT] ������Ÿ�� [,]
                :
    ������ [IN|OUT|INOUT] ������Ÿ��)]
  IS|AS
     ���𿵿�;
  BEGIN
     ���࿵��
      [EXCEPTION
        ����ó������;]
    END;
    . 'IN|OUT|INOUT' : ������ ���(IN:�Է¿�, OUT:��¿�, INOUT: ����� ���� ���� ����)
    . '������Ÿ��' : ũ�⸦ �����ϸ� �ȵ�
    
 ������)
   1) OUT �Ű������� ���� ���
     . ������ ����: EXEC | EXECUTE ���ν�����(�Ű�����list)
     . ��� ���ο��� ���� : ���ν�����(�Ű�����list)
 
   2) OUT �Ű������� �ִ� ���
     . ��� ���ο��� ���� : ���ν�����(�Ű�����list) -> �Ű�����list�� �����͸� ���� ���� �������� �;���
     
    
    
��뿹) ���� �����ڷḦ ó���ϴ� ���ν����� �ۼ��Ͻÿ�.
----------------------------------------------------
     ����           ��ǰ�ڵ�        ����
----------------------------------------------------
  2024-11-05      P201000007       20
  EXECUTE proc_insert_buyprod(SYSDATE, 'P201000007', 20);
  (REMAIN����                 ���� ���� ���� �����
              2020 P201000007 9    19   0   28  2020/01/31
              2020 P201000007 9    39   0   48  2024/11/04
              
      ""          P201000011        5
  EXEC  proc_insert_buyprod(SYSDATE,'P202000011',5);
  
                2020    P2020000011    35     91     0     126    2020/01/31
                2020    P2020000011    35     96     0     131    2024/11/03                

      ""          P201000011        12   
    EXEC  proc_insert_buyprod(SYSDATE,'P202000011',12);
                2020    P2020000011    35     96     0     131    2024/11/03 
                2020    P2020000011    35     118     0     143    2024/11/03    
      
   CREATE OR REPLACE PROCEDURE proc_insert_buyprod(
    P_DATE IN DATE, P_PID PROD.PROD_ID%TYPE, P_QTY NUMBER)
   IS
   
   BEGIN
      INSERT INTO BUYPROD VALUES(P_DATE,P_PID,P_QTY);
      UPDATE REMAIN A
         SET A.REMAIN_I=A.REMAIN_I+P_QTY,
             A.REMAIN_J_99=A.REMAIN_J_99+P_QTY,
             A.REMAIN_DATE=P_DATE
       WHERE A.PROD_ID=P_PID;
       
       COMMIT;
   END;
      
��뿹) �⵵�� ���� ȸ����ȣ�� �Է¹޾� �ش� ȸ���� ���űݾ��հ踦 ��ȯ �޴� ���ν����� �ۼ��Ͻÿ�.

    CREATE OR REPLACE PROCEDURE proc_cart_sum01(
        P_PERIOD IN VARCHAR2, P_MID MEMBER.MEM_ID%TYPE,P_AMT OUT NUMBER)
    IS 
      --L_AMT NUMBER:=0;
    BEGIN
      --���űݾ� �հ� ����ؼ� P_AMT�� �Ҵ�
      SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO P_AMT
        FROM CART A, PROD B
       WHERE A.PROD_ID=B.PROD_ID
         AND A.MEM_ID = P_MID
         AND SUBSTR(A.CART_NO,1,6)=P_PERIOD;
    END;
      
 [����]
   DECLARE
   L_AMT NUMBER :=0;
   BEGIN
     proc_cart_sum01('202005','c001',L_AMT);
     
     DBMS_OUTPUT.PUT_LINE('���űݾ� : '||L_AMT);
   END;
 
 
 
��뿹) ��ǰ�� �з��ڵ带 Ű����� �Է� �޾� 2020�� 1~3�� �ش� �з��ڵ忡 ���Ե� ��ǰ���� ���� �����հ踦
        ����ϴ� ���ν����� �ۼ��Ͻÿ�.
(���ν��� : ��ǰ�ڵ� �Է� �޾� 2020�� 1~3�� ���� ���Լ��� �հ踦 ��ȯ)
  CREATE OR REPLACE PROCEDURE proc_buyprod_qtysum(
     P_PID IN PROD.PROD_ID%TYPE, P_QTY OUT NUMBER)
  IS
  BEGIN
     SELECT SUM(BUY_QTY) INTO P_QTY
       FROM BUYPROD
      WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200331')
        AND PROD_ID=P_PID;
  END;
(������: �з��ڵ� �Է¹޾� �ش� �з��� ���� ��ǰ�ڵ带 ���ν����� ����)
  ACCEPT P_LPROD PROMPT '�з��ڵ� �Է� : '
  DECLARE
  L_AMT NUMBER :=0; --  ���Լ��� ���޹��� ����
    CURSOR cur_lprod_prod IS 
        SELECT PROD_ID, PROD_NAME
          FROM PROD
         WHERE LPROD_GU='P201';
  BEGIN
    FOR REC IN cur_lprod_prod LOOP
    DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : '||REC.PROD_ID);
    DBMS_OUTPUT.PUT_LINE('��ǰ�� : '||REC.PROD_NAME);
    proc_buyprod_qtysum(REC.PROD_ID,L_AMT);
    DBMS_OUTPUT.PUT_LINE('���Լ��� : '||L_AMT);
     DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
    END LOOP;
  END;
        
        
    
      
      
      