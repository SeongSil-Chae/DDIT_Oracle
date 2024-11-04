2024-1021-01) ��¥ �Լ�
 - SYSDATE, SYSTIMESTAMP, ADD_MONTHS, NEXT_DAY, LAST_DAY, MONTH_BETWEEN, 
   EXTRACT, ROUND, TRUNC
 
��뿹)
    SELECT SYSDATE,
            TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
    FROM DUAL;
    
(��뿹) HR����DML ������̺��� ��� ������� �Ի����� 2�� �ڷ� �����Ͻÿ�
 
 UPDATE HR. EMPLOYEES
    SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,24); 
    -- 24 ���� �ڷ� ����
 COMMIT;

��뿹) ȸ�� ���̺��� ȸ������ ���̸� ��Ȯ�� OO�� OO�� �������� ����Ͻÿ�
        Alias�� ȸ����ȣ, ȸ����, �������, ����
        
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_BIR AS �������,
           TRUNC (ROUND(MONTHS_BETWEEN(SYSDATE, MEM_BIR))/12)||'��'||
             MOD (ROUND(MONTHS_BETWEEN(SYSDATE, MEM_BIR)),12)||'����' AS ����
    FROM CSS02.MEMBER
    
��뿹)  Ű����� �⵵�� ���� �Է¹޾� �ش���� ���Ե� ��ǰ�� ���Լ����հ�� ���Աݾ��հ踦 ��ȸ�Ͻÿ�.
ACCEPT P_PERIOD  PROMPT '�Ⱓ�� �Է�(YYYYMM) : '
  DECLARE
    L_SDATE DATE := TO_DATE('&P_PERIOD'||'01');
    L_EDATE DATE := LAST_DAY(L_SDATE);
    CURSOR CUR_PERIOD_SUM  IS
      SELECT A.PROD_ID AS APID, 
             B.PROD_NAME AS BNAME,
             SUM(A.BUY_QTY) AS SQTY, 
             SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
        FROM SEM1.BUYPROD A, SEM1.PROD B
       WHERE A.PROD_ID=B.PROD_ID
         AND A.BUY_DATE BETWEEN L_SDATE AND L_EDATE
       GROUP BY A.PROD_ID,B.PROD_NAME;  
  BEGIN
    FOR REC  IN CUR_PERIOD_SUM LOOP
      DBMS_OUTPUT.PUT_LINE('��ǰ��ȣ : '||REC.APID);
      DBMS_OUTPUT.PUT_LINE('��ǰ�� : '||REC.BNAME);
      DBMS_OUTPUT.PUT_LINE('���Լ��� : '||REC.SQTY);
      DBMS_OUTPUT.PUT_LINE('���Աݾ� : '||REC.BSUM);
      DBMS_OUTPUT.PUT_LINE('------------------------------------------------');      
    END LOOP;
  END;
    
    
��뿹) SELECT NEXT_DAY(SYSDATE,'��'),
              NEXT_DAY(SYSDATE,'ȭ����'),
              NEXT_DAY(SYSDATE,'�Ͽ���')
        FROM DUAL;    
    --��� ���� 10/21 ���� ����
    2024/10/28	2024/10/22	2024/10/27
    ���� ����      ����       �̹��� �Ͽ�
    
** EXTRACT(fmt FROM data)
  - 'date'���� 'fmt'�� �ش��ϴ� ��Ҹ� ��ȯ(�����ڷ�)
  - fmt�� YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
  
��뿹) 2020��  3�� �����ڷḦ ��ȸ�Ͻÿ�. Alias�� ��¥, ��ǰ��ȣ, ���Լ���
    SELECT BUY_DATE AS ��¥,
           PROD_ID AS ��ǰ��ȣ,
           BUY_QTY AS ���Լ���
    FROM CSS02.BUYPROD
    WHERE EXTRACT(YEAR FROM BUY_DATE)=2020
      AND EXTRACT(MONTH FROM BUY_DATE)=3;
    
����) ��ٱ������̺��� 2020�� 5���� 7���� �Ǹŵ� ������ ����Ͻÿ� --TO DATE ���� �Ѵٰ� ��.
      (����, ��ǰ��ȣ, �����̸� ��¥������ ����� ��) 
      
      SELECT ����, ��ǰ��ȣ, ����
      FROM CSS02.
    
    
    
    