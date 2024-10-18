2024-1018-02) ���ڿ� �Լ�
 - CONCAT, LOWER, UPPER, INITCAP, LENGTH, LENGTHB,
   LPAD, RPAD, LTRIM, RTRIM, TRIM, SUBSTR, REPLACE, INSTR
   
   1. CONCAT
   
��뿹) ȸ�����̺��� ����ȸ������ ȸ����ȣ, ȸ����, �ֹι�ȣ�� ����Ͻÿ�.
        ��, �ֹι�ȣ�� XXXXXX-XXXXXXX�������� ����Ͻÿ�.
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           CONCAT(MEM_REGNO1,'-',MEM_REGNO2) AS �ֹι�ȣ,
           MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ2
        FROM CSS02.MEMBER
        WHERE SUBSTR(MEM_REGNO2,1,1) IN ('2','4')
        
    2. LOWER, UPPER    
    
��뿹) ��ǰ���̺��� �з��ڵ尡 'P201', 'P202'�� ���� ��ǰ��
        ��ǰ��ȣ, ��ǰ��, �ǸŰ����� ���
    SELECT PROD_ID AS ��ǰ��ȣ,
           PROD_NAME AS ��ǰ��,
           PROD_PRICE AS �ǸŰ���
      FROM CSS02.PROD
      WHERE LOWER(LPROD_GU) IN ('p201', 'p202')


    3. LPAD, RPAD / NVL2(NULL �ƴϸ� ���, NULL�̸� ���)
        LPAD(�Է°� , 9) 9ĭ ���� �ְ� ���� �ֱ�
        
��뿹) ��ǰ���̺��� ��ǰ�� ũ��(PROD_SIZE)�� ��ȸ�Ͽ� �����Ͱ� ������(NULL�̸�)
        ũ���÷��� 'ũ������ ����'�� ����Ͻÿ�. ����� �÷��� ��ǰ��, ���Դܰ�, ũ���̴�.
    SELECT  PROD_NAME AS ��ǰ��,
            PROD_COST AS ���Դܰ�,
            NVL2(PROD_SIZE,LPAD(PROD_SIZE,9), 'ũ������ ����') AS ũ��
    FROM CSS02.PROD
        
    SELECT LPAD(PROD_NAME,25,'*'),   -- ���� ���� 25���� ����� �ű⿡ *�� ä���
        TO_CHAR(PROD_COST,'9,999,999') AS ���԰���,
        TO_CHAR(PROD_PRICE,'9,999,999') AS ���԰���
        FROM CSS02.PROD
        
 3. LTRIM, RTRIM       
   ���ڿ� �����
��뿹)
    SELECT LTRIM('AABABBCABAB','AB') FROM DUAL;
      -- A,B �� ������ �� ����� ���ο� �� ������ �׶����� ��������.
    SELECT RTRIM('BAABABCBABAB','AB') FROM DUAL;
    SELECT LTRIM('BAABABCBABAB') FROM DUAL;
    SELECT TRIM('  BAABAB  ' ) FROM DUAL;
    
��뿹) ���� ��¥�� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�.  -- �̰� �̿ϼ��̶� ;;
    CREAT OR REPLACE FUNCTION CREAT_CART_NO(P_DATE IN DATE)
    RETURN VARCHAR2
    AS
       L_CART_NO CSS02.CART.CART_NO%TYPE;
       L_CNT NUMBER:=0;
    BEGIN 
    SELECT COUNT(*) INTO L_CNT
        FROM CSS02.CART
        WHERE CART_NO LIKE TO_CHAR(P_DATE,'YYYYMMDD')||'%'
        
        IF L_CNT=0 THEN
        L_CART_NO:=TO_CHAR(P_DATE,'YYYYMMDD')||'0001'
        ELSE
        SELECT MAX(DISTINCT(CART_NO))+1 INTO L_CART_NO
        FROM CSS02.CART
        WHERE CART_NO:=TO_CHAR(P_DATE,'YYYYMMDD')||'%'
    END IF
    RETURN L_CART_NO
    END;
    
  4. REPLACE
��뿹) ��ǰ���̺��� ��ǰ�� �� '���'�� ã�� 'DAEWOO'�� �����ϰ�, 
        �� ��ǰ�� ����(RPOD_OUTLINE) �� �� ��� ������ �����Ͻÿ�.
        ����� ��ǰ�ڵ�, ��ǰ��, ��ǰ ����
    SELECT PROD_ID AS ��ǰ�ڵ�,
           PROD_NAME AS ��ǰ��,
           REPLACE(PROD_NAME,'���','DAEWOO') AS ��ǰ��1, --'���'�� 'DAEWOO'�� ����
           PROD_OUTLINE AS "��ǰ ����",
           REPLACE(PROD_OUTLINE, ' ') AS "��ǰ ����"  -- ������ ã�� ����
      FROM CSS02.PROD; 
  
        
        
        
  5. SUBSTR    SUBSTR('���ڿ�~~~~@@@', 2,5)  2: 2��° ���ں��� 5�� ���,
            -2�� �ڿ��� 2��°���� �ڷ� ��� (�ִ� 2�� ����)
        
��뿹)
  SELECT SUBSTR('������ �߱� ���� 846', 2,5) AS COL1,
         SUBSTR('������ �߱� ���� 846', 2) AS COL2,
         SUBSTR('������ �߱� ���� 846', -2,5) AS COL3,
         SUBSTR('������ �߱� ���� 846', 2,50) AS COL4
    FROM DUAL;
        
��뿹) �ֹε�Ϲ�ȣ�� ����Ͽ� ȸ������ ���̸� ���Ͻÿ�. ����� ȸ����, �ֹι�ȣ, ����
    SELECT MEM_NAME AS ȸ����,
           CONCAT(MEM_REGNO1, '-',MEM_REGNO2) AS �ֹι�ȣ,
           CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','2') THEN
                     EXTRACT(YEAR FROM SYSDATE)-('19'||SUBSTR(MEM_REGNO1,1,2))
                     ELSE EXTRACT(YEAR FROM SYSDATE)-('20'||SUBSTR(MEM_REGNO1,1,2))
                     END AS ����
    FROM CSS02.MEMBER;
    

    
    
    
    
    

        
        