2024-1101-01)

1. �б⹮(if)

��뿹) ���� ��¥�� ��ٱ��� ��ȣ�� �����Ͻÿ�.
  DECLARE
    L_CART_NO CART.CART_NO%TYPE; -- �ӽ� ��ٱ��� ��ȣ
    L_MEM_ID MEMBER.MEM_ID%TYPE := 'c001'; -- ���� ȸ����ȣ
    L_TEMP_MID MEMBER.MEM_ID%TYPE; -- ���� ū ��ٱ��ϸ� ������ ȸ����ȣ
    L_CNT NUMBER := 0; -- CART���̺� �����ϴ� ���� ��¥�� �ڷ� ��(���� ��)
    L_CART_NO1 VARCHAR2(8) := '20200418';
  BEGIN
    SELECT COUNT(*) INTO L_CNT
        FROM CART
       WHERE CART_NO LIKE L_CART_NO1 || '%';
       
    IF L_CNT = 0 THEN
        L_CART_NO := L_CART_NO1 || TRIM('00001');
    ELSE
        SELECT DISTINCT(MAX(CART_NO)) INTO L_CART_NO
            FROM CART
           WHERE CART_NO LIKE L_CART_NO1 || '%';
          
         SELECT DISTINCT(MEM_ID) INTO L_TEMP_MID
            FROM CART
           WHERE CART_NO = L_CART_NO;
            
        IF L_MEM_ID != L_TEMP_MID THEN
            L_CART_NO := L_CART_NO + 1;
        END IF;        
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��ٱ��� ��ȣ : ' || L_CART_NO);
  END;


2. ���ߺб⹮(CASE WHEN ~ THEN     END CASE)
(�������-1) 
 CASE ���ǽ�
        WHEN ��1 THEN ��ɹ�1;
        WHEN ��2 THEN ��ɹ�2;
                :
 ELSE
    ��ɹ�n;
 END CASE;

(�������-2) 
 CASE WHEN ���ǽ�1 THEN ��ɹ�1;
      WHEN ���ǽ�2 THEN ��ɹ�2;
                :
 ELSE
    ��ɹ�n;
 END CASE;

��뿹) Ű����� ��¥(��,��,��)�� �Է� �޾� �ش����� ������ ����Ͻÿ�.
ACCEPT P_DATE PROMPT '��¥�Է�(YYYYMMDD) : '
DECLARE
    L_DAYS NUMBER:=0; --���� 1�� 1�� 1�� ���� �Էµ� ��¥���� ����� �ϼ�
    L_RESULT VARCHAR2(100); -- ��� ���ڿ� ����
BEGIN
    L_DAYS:=TRUNC(TO_DATE('&P_DATE'))-TO)DATE('00010101')-1;
    CASE WHEN MOD(L_DAYS, 7) WHEN 0 THEN L_RESULT := TO_DATE('&P_DATE')||'���� �Ͽ����Դϴ�.';
                             WHEN 1 THEN L_RESULT := TO_DATE'&P_DATE')||'���� �������Դϴ�.';
                             WHEN 2 THEN L_RESULT := TO_DATE('&P_DATE')||'���� ȭ�����Դϴ�.';
                             WHEN 3 THEN L_RESULT := TO_DATE('&P_DATE')||'���� �������Դϴ�.';
                             WHEN 4 THEN L_RESULT := TO_DATE('&P_DATE')||'���� ������Դϴ�.';
                             WHEN 5 THEN L_RESULT := TO_DATE('&P_DATE')||'���� �ݿ����Դϴ�.';
                            
    ELSE 
    L_RESULT := TO_DATE('&P_DATE')||'���� ������Դϴ�.';
 ELSE CASE;
 DBMS_OUTPUT.PUT_LINE(L_RESULT);
END;

                            






