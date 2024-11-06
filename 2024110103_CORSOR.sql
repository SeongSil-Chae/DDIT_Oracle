2024-1101-03)Ŀ��(CORSOR)
 - ������ Ŀ���� SQL����� ������ ���� ����� ����
 - ������ Ŀ���� SELECT���� ��� ����
 - Ŀ���� �������� SQL ��� ������ �ڷῡ �����Ͽ� �ش� �ڷḦ ������ �� �ִ� ����� ����
 - FOR���� ������ Ŀ���� ������� : ��û(���𿵿�) -> OPEN -> FETCH -> CLOSE�� ����  -- FETCH �갡 �� ������ �� �ִ��� �˷���.
 - FOR������ Ŀ���� ����ϴ� ��� OPEN, FETCH, CLOSE ����
 - CORSOR�� �ٽ� ������ �ݾƾߵ�.
 - Ŀ���� ���� : ������Ŀ��(IMPLICITE CURSOR), �����Ŀ��(EXPLICITE CURSOR)
 
 - ������ Ŀ��
   . Ŀ�������� ������ ���� Ŀ���� SELECT���� ����� �ǹ��ϸ� SELECT���� ����� ��µǱ� �����ϸ�
   OPEN�Ǿ��ٰ� ��� ����� ������ �ڵ����� CLOSE��. ���� �׻� CLOSE ������
 - Ŀ���Ӽ�
 -----------------------------------------------------------------
   �Ӽ�                  �ǹ�
 -----------------------------------------------------------------
  SQL%ISOPEN           Ŀ���� ���� �����̸� ��(true), ������ �����̸� ����(false) ��ȯ
                       ������Ŀ���� �׻� false��
  SQL%FOUND            FETCH�� �ڷ�(��)�� ������ true, ������ false ��ȯ                  
  SQL%NOTFOUND         FETCH�� �ڷ�(��)�� ������ false, ������ true ��ȯ
  SQL%ROWCOUNT         Ŀ���� ���Ե� ���� �� ��ȯ         
  
  - ����� Ŀ��
   . Ŀ�����𹮿� ���� ������ Ŀ��
 - Ŀ���Ӽ�
 -----------------------------------------------------------------
   �Ӽ�                  �ǹ�
 -----------------------------------------------------------------
  Ŀ����%ISOPEN           Ŀ���� ���� �����̸� ��(true), ������ �����̸� ����(false) ��ȯ                    
  Ŀ����%FOUND            FETCH�� �ڷ�(��)�� ������ true, ������ false ��ȯ                  
  Ŀ����%NOTFOUND         FETCH�� �ڷ�(��)�� ������ false, ������ true ��ȯ
  Ŀ����%ROWCOUNT         Ŀ���� ���Ե� ���� �� ��ȯ         
  

�������)
  CURSOR Ŀ����[(������ Ÿ�Ը�,...)] IS   -- Ÿ�Ը����� ũ�⾲���ʰ� Ÿ�Ը� ����
    SELECT ��;
    
    
1) OPEN ��
  . Ŀ���� ��밡���� ���·� ��ȯ
  �������)
  OPEN Ŀ����[(�Ű�����list);
  
2) FETCH ��
  . Ŀ�� ������ �ڷḦ ������� �о�� �� ���
�������)
  FETCH Ŀ���� INTO ����list;
   . Ŀ���� ���Ե� �÷��� ���� INTO���� ������ ���� �ݵ�� ��ġ
   . Ŀ���� ���Ե� �÷��� INTO���� ������ MAPPING�Ǿ� ���� ������
   . ��κ��� FETCH���� �ݺ��� ���ο� ���
  
3) CLOSE ��
  . ����� �Ϸ�� Ŀ���� CLOSE�Ǿ� �� OPEN�� �� ����.
�������)
    CLOSE Ŀ����;
  
    
��뿹) �泲�� �����ϴ� ȸ������ 2020�� 5�� ������Ȳ�� ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, ���ž�
      Alias�� ȸ����ȣ, ȸ����, ���ž�
  DECLARE
    L_MID MEMBER.MEM_ID%TYPE;
    L_MNAME VARCHAR2(100);
    L_AMT NUMBER:=0;
    
    CURSOR CUR_MEM03  IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '�泲%'; 
  BEGIN
    OPEN CUR_MEM03;
    LOOP
      FETCH CUR_MEM03 INTO L_MID,L_MNAME;
      EXIT WHEN CUR_MEM03%NOTFOUND;
      SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_AMT
        FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202005%'
         AND A.PROD_ID=B.PROD_ID
         AND A.MEM_ID=L_MID;
      DBMS_OUTPUT.PUT(L_MID||' ');
      DBMS_OUTPUT.PUT(L_MNAME||' ');
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(L_AMT,'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------');      
    END LOOP;
  END;
      
(WHILE�� ���)
  DECLARE
    L_MID MEMBER.MEM_ID%TYPE;
    L_MNAME VARCHAR2(100);
    L_AMT NUMBER:=0;
    
    CURSOR CUR_MEM03  IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '�泲%'; 
  BEGIN
    OPEN CUR_MEM03;
    FETCH CUR_MEM03 INTO L_MID,L_MNAME;
    WHILE CUR_MEM03%FOUND LOOP
      SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_AMT
        FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202005%'
         AND A.PROD_ID=B.PROD_ID
         AND A.MEM_ID=L_MID;
      DBMS_OUTPUT.PUT(L_MID||' ');
      DBMS_OUTPUT.PUT(L_MNAME||' ');
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(L_AMT,'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------'); 
      FETCH CUR_MEM03 INTO L_MID,L_MNAME;
    END LOOP;
  END;
  
(FOR��)
  DECLARE
    L_AMT NUMBER:=0;
    CURSOR CUR_MEM03  IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '�泲%'; 
  BEGIN
    FOR REC IN CUR_MEM03 LOOP
      SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_AMT
        FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202005%'
         AND A.PROD_ID=B.PROD_ID
         AND A.MEM_ID=REC.MEM_ID;
      DBMS_OUTPUT.PUT(REC.MEM_ID||' ');
      DBMS_OUTPUT.PUT(REC.MEM_NAME||' ');
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(L_AMT,'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------'); 
    END LOOP;
  END;
  
  (�ζ��� FOR LOOP ��)
  DECLARE
    L_AMT NUMBER:=0;
  BEGIN
    FOR REC IN (SELECT MEM_ID,MEM_NAME FROM MEMBER WHERE MEM_ADD1 LIKE '�泲%') LOOP
      SELECT NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) INTO L_AMT
        FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202005%'
         AND A.PROD_ID=B.PROD_ID
         AND A.MEM_ID=REC.MEM_ID;
      DBMS_OUTPUT.PUT(REC.MEM_ID||' ');
      DBMS_OUTPUT.PUT(REC.MEM_NAME||' ');
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(L_AMT,'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------'); 
    END LOOP;
  END;  


