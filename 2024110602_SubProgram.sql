2024-1106-02) �������α׷�
 - ���ν����� �Լ� �ȿ��� �ش� ���α׷��� �ݺ��Ͽ� ���Ǵ� ��ƾ�� �ִ� ��� 
   �������α׷��� ���� �� �� �ִ�.
 - ���� ���α׷��� DECLARE ~ IS ���̿� ���ν����� �Լ��� �ۼ��Ѵ�. 
 
��뿹) Ű����� ���ɴ븦 �Է� �޾� �� ���ɴ뿡 �ش��ϴ� ȸ������ 2020�� ������Ȳ�� ���
       ����� ������ ȸ����ȣ, ȸ����, ���űݾ��հ�
 1)�͸���
  ACCEPT P_AGE  PROMPT '���ɴ� �Է� : '
  DECLARE
    CURSOR cur_mem04 IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10=&P_AGE; 
       
    PROCEDURE proc_inner_sales_info(
      P_MID IN MEMBER.MEM_ID%TYPE, P_NAME IN MEMBER.MEM_NAME%TYPE)
    IS
    BEGIN
      DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||P_MID);
      DBMS_OUTPUT.PUT_LINE('ȸ���� : '||P_NAME);
      DBMS_OUTPUT.PUT_LINE('���űݾ��հ� : '||TO_CHAR(fn_sum_member(P_MID),'99,999,999'));
      DBMS_OUTPUT.PUT_LINE('------------------------------------------');
    END;
  BEGIN
    FOR REC IN cur_mem04 LOOP
        proc_inner_sales_info(REC.MEM_ID, REC.MEM_NAME);
    END LOOP;
  END;

 2)�Լ�
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
  
  
  
  
  SELECT TO_CHAR(0.1230) AS NUM1
    ,  TO_CHAR(0.1230, 'FM999.9999') AS NUM2
    ,  TO_CHAR(0.1230, '999.0000') AS NUM3
    ,  TO_CHAR(0.1230, 'FM000.000') AS NUM4
    ,  TO_CHAR(0.1230, 'FM000.0000') AS NUM5
  FROM DUAL

 