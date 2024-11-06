2024-1104-02)User Defined Function(Function)
  - ������� ���� ������� ��ȯ �ޱ����� ���
  - ��ȯ���� ����
�������)  
  CREATE [OR REPLACE] FUNCTION �Լ���[(
    ������ [IN|OUT|INOUT]  ������Ÿ�� [,]
              :
    ������ [IN|OUT|INOUT]  ������Ÿ��)]
    RETURN ������Ÿ�� --ũ��� �����ϰ� �Է�
  IS|AS
    ���𿵿�;
  BEGIN
    ���࿵��
       : 
    RETURN ��;   -- �� ���� ������ Ÿ�԰� ��ġ�ؾߵ�.
    [EXCEPTION 
      ����ó������;]
  END;
   . 'IN|OUT|INOUT' : ������ ���(IN:�Է¿�, OUT:��¿�, INOUT:����� ���� ���� ����)
   . '������Ÿ��' : ũ�⸦ �����ϸ� �ȵ�
   . SELECT������ ����Ѵ�
   . ���࿵�� ���ο� ��� 1���̻��� RETURN ���� �����ؾ� ��
   . ���� OUT �Ű������� ������� ����
   
��뿹)��ǰ�ڵ带 �Է� �޾� 2020�� �ش� ��ǰ�� ��������հ踦 ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.

  CREATE OR REPLACE FUNCTION fn_cart_qtysum01(
    P_PID  IN PROD.PROD_ID%TYPE)
    RETURN NUMBER
  IS
    L_QTY NUMBER:=0; --��������հ�
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
         NVL(fn_cart_qtysum01(PROD_ID)* PROD_PRICE,0) AS �Ǹž�
    FROM PROD;   
    
    
��뿹)��¥�� ȸ����ȣ�� �Է� �޾� ��ٱ��Ϲ�ȣ�� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.
  CREATE OR REPLACE FUNCTION fn_create_cart_no(
    P_DATE DATE, P_MID MEMBER.MEM_ID%TYPE)
    RETURN VARCHAR2
  IS
    L_CNT NUMBER:=0;  --Ư�� ��¥�� ���� ����
    L_MID MEMBER.MEM_ID%TYPE;   -- �� ��¥�� ���� ū ��ٱ��� ��ȣ�� ���� ȸ����ȣ
    L_CART_NO VARCHAR2(13);    -- ���� ���� īƮ��ȣ
    L_DATE VARCHAR2(8):=TO_CHAR(P_DATE,'YYYYMMDD');   -- Ư�� ��¥�� īƮ��ȣ�� �ֱ� ����
  BEGIN
    SELECT COUNT(*) INTO L_CNT
      FROM CART
     WHERE CART_NO LIKE L_DATE||'%';
     
    IF L_CNT = 0 THEN
       L_CART_NO:=L_DATE||TRIM('00001');
    ELSE
       SELECT DISTINCT(MAX(CART_NO)) INTO L_CART_NO    --2 ��ٱ��ϰ� 3���� �ߺ� ������.
         FROM CART
        WHERE CART_NO LIKE L_DATE||'%';
        
       SELECT DISTINCT(MEM_ID) INTO L_MID
         FROM CART
        WHERE CART_NO=L_CART_NO;
       
       IF P_MID != L_MID THEN    -- �ΰ��� ���ٸ� īƮ��ȣ �ϳ� ���������ش�
          L_CART_NO:=L_CART_NO+1;
       END IF;
    END IF;
    RETURN L_CART_NO;
  END;
  
    
��뿹)������ 2020�� 7�� 28���̶� �����ϰ� ���� �ڷḦ ó���Ͻÿ�
---------------------------------------
  ȸ����ȣ    ��ǰ��ȣ      ���ż���  
---------------------------------------
  b001       P302000013     3
  u001       P202000007     1
  u001       P102000003     2
  
   -- �μ�Ʈ, ������Ʈ, ���ϸ��� �߰�
  
  
1)CART�� ����
  INSERT INTO CART  VALUES('b001',fn_create_cart_no(TO_DATE('20200728'),'b001'),'P302000013',3);
  
  INSERT INTO CART  VALUES('u001',fn_create_cart_no(TO_DATE('20200728'),'u001'),'P202000007',1);
    
  INSERT INTO CART  VALUES('u001',fn_create_cart_no(TO_DATE('20200728'),'u001'),'P102000003',2);
  
��뿹)2020�� 5�� ��ǰ�� ���Ը�����Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ��ȣ,��ǰ��,���Լ����հ�,���Աݾ��հ�,��������հ�,����ݾ��հ�
      ���Աݾ��հ�,����ݾ��հ�� �Լ��� �ۼ�
(�����Լ�:�Ⱓ�� ��ǰ��ȣ�� �Է� �޾� ���Աݾ��հ� ��ȯ)     
  CREATE OR REPLACE FUNCTION fn_sum_buyprod_2005(
    P_PERIOD IN VARCHAR2, P_PID PROD.PROD_ID%TYPE)    -- VARCHAR2 ũ�� ���� ����
    RETURN NUMBER
  IS
    L_SUM_BUY  NUMBER:=0;      --SCLAR ������.
  BEGIN
    SELECT NVL(SUM(A.BUY_QTY*B.PROD_COST),0) INTO L_SUM_BUY
      FROM BUYPROD A, PROD B
     WHERE A.PROD_ID=B.PROD_ID    --�ܰ� ���������� ����
       AND A.BUY_DATE BETWEEN TO_DATE(P_PERIOD||'01') AND LAST_DAY(TO_DATE(P_PERIOD||'01'))
       AND A.PROD_ID=P_PID;
    RETURN L_SUM_BUY;   
  END;
      
      
(�����Լ�:�Ⱓ�� ��ǰ��ȣ�� �Է� �޾� ����ݾ��հ� ��ȯ)     
  CREATE OR REPLACE FUNCTION fn_sum_cart_2005(
    P_PERIOD IN VARCHAR2, P_PID PROD.PROD_ID%TYPE)
    RETURN NUMBER
  IS
    L_SUM_CART  NUMBER:=0;   
  BEGIN
    SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_SUM_CART
      FROM CART A, PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.CART_NO LIKE P_PERIOD||'%'
       AND A.PROD_ID=P_PID;
    RETURN L_SUM_CART;   
  END; 
  
(����)
  SELECT PROD_ID AS ��ǰ��ȣ,
         PROD_NAME AS ��ǰ��,
         fn_sum_buyprod_2005('202004',PROD_ID) AS ���Աݾ��հ�,
         fn_sum_cart_2005('202004',PROD_ID) AS ����ݾ��հ�
    FROM PROD; 