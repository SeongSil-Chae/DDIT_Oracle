2024-1104-02) User Defined Function(Function)
  - ������� ���� ������� ��ȯ �ޱ� ���� ���
  - ��ȯ���� ����
�������) 
  CREATE [OR REPLACE] FUNCTION �Լ��� [(
    ������ [IN|OUT|INOUT] ������Ÿ�� [,]
                :
    ������ [IN|OUT|INOUT] ������Ÿ��)]
    RETURN ������ Ÿ��
  IS|AS
     ���𿵿�;
  BEGIN
     ���࿵��
        :
     RETURN ��;  -- �� ���� ������ Ÿ�԰� ��ġ�ؾߵ�.
      [EXCEPTION
        ����ó������;]
    END;
    . 'IN|OUT|INOUT' : ������ ���(IN:�Է¿�, OUT:��¿�, INOUT: ����� ���� ���� ����)
    . '������Ÿ��' : ũ�⸦ �����ϸ� �ȵ�
    . SELECT������ ����Ѵ�
    . ���࿵�� ���ο� ��� 1�� �̻��� RETURN ���� �����ؾ� ��
    . ���� OUT �Ű������� ������� ����
    
    
��뿹) ��ǰ�ڵ带 �Է¹޾� 2020�� �ش� ��ǰ�� ������� �հ踦 ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.

CREATE OR REPLACE FUNCTION fn_cart_qtysum01(
    P_PID  IN PROD.PROD_ID%TYPE)
    RETURN NUMBER 
  IS 
    L_QTY NUMBER:=0; -- ��������հ�
  BEGIN
    SELECT SUM(CART_QTY) INTO L_QTY
      FROM CART
     WHERE CART_NO LIKE '2020%'
       AND PROD_ID=P_PID;
       
    RETURN L_QTY;
  END;
    
(����)
    SELECT PROD_ID AS ��ǰ�ڵ�,
           PROD_NAME AS ��ǰ��,
           NVL(fn_cart_qtysum01(PROD_ID),0) AS �Ǹż���,
           NVL(fn_cart_qtysum01(PROD_ID) * PROD_PRICE,0) AS �Ǹž�
      FROM PROD;
    
    
��뿹) ��¥�� ȸ����ȣ�� �Է¹پ� ��ٱ��� ��ȣ�� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.
  CREATE OR REPLACE FUNCTION fn_create_cart_no(
    P_DATE DATE, P_MID MEMBER.MEM_ID%TYPE)
    RETURN VARCHAR2
  IS
    L_CNT NUMBER:=0;
    L_MID MEMBER.MEM_ID%TYPE;
    L_CART_NO VARCHAR2(13);
    L_DATE VARCHAR2(8):=TO_CHAR(P_DATE,'YYYYMMDD');
  BEGIN
    SELECT COUNT(*) INTO L_CNT
      FROM CART
     WHERE CART_NO LIKE L_DATE||'%';
     
    IF L_CNT = 0 THEN
       L_CART_NO:=L_DATE||TRIM('00001');
    ELSE
       SELECT DISTINCT(MAX(CART_NO)) INTO L_CART_NO
         FROM CART
        WHERE CART_NO LIKE L_DATE||'%';
        
       SELECT DISTINCT(MEM_ID) INTO L_MID
         FROM CART
        WHERE CART_NO=L_CART_NO;
       
       IF P_MID != L_MID THEN
          L_CART_NO:=L_CART_NO+1;
       END IF;
    END IF;
    RETURN L_CART_NO;
  END;
  
  
 (����) 
    SELECT fn_create_cart_no(TO_DATE('20200505'),'c001') FROM DUAL;  
    
    SELECT fn_create_cart_no(SYSDATE,'c001') FROM DUAL;  