2024-1015-01)SELECT ��

��뿹) ȸ�����̺��� ��� ȸ���� ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�Ͻÿ�.
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_ADD1||' '||MEM_ADD2 AS �ּ�, -- || �̰Ŵ� +      ' ' �̰Ŵ� ���ڿ�
           MEM_MILEAGE AS ���ϸ��� -- " �� �� �� ��" ��� ���Ÿ� �ֵ���ǥ �־�ߵ�.
      FROM CSS02.MEMBER
      
      
��뿹) �з����̺��� ������ ��ȸ�Ͻÿ�.
        Alias�� ����, �з��ڵ�, �з���
    SELECT LPROD_ID AS ����,
           LPROD_GU AS �з��ڵ�,
           LPROD_NM AS �з���
      FROM CSS02.LPROD;
        
        
��뿹) ȸ�����̺��� ȸ������ ������ ������ ��ȸ�Ͻÿ�.
    SELECT DISTINCT SUBSTR(MEM_ADD1,1,2)  -- ADD1���� ù���ڿ��� �α��� ����
      FROM CSS02.MEMBER;

��뿹) ������̺��� �޿��� 10000�̻��� ��������� ��ȸ�Ͻÿ�.
        Alias�� �����ȣ, �����,�Ի���,�޿�
    SELECT  EMPLOYEE_ID AS �����ȣ,
            EMP_NAME AS �����,
            HIRE_DATE AS �Ի���,
            SALARY AS �޿�
      FROM HR.EMPLOYEES
     WHERE SALARY>=10000;
        
        
��뿹) ������̺��� �μ��� ������� ��ձ޿��� ��ȸ�Ͻÿ�.
        ��, �μ��ڵ������ ����Ͻÿ�.
    SELECT DEPARTMENT_ID AS �μ��ڵ�,
           COUNT(*) AS �����,
           ROUND (AVG(SALARY)) AS ��ձ޿� -- ROUND�� ������ �Ҽ����� �ݿø� ����.
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID
      ORDER BY 1 ASC -- 1�� �������� ù��° �÷��� �����Ѵٶ�� ��. (DEPARTMENT_ID)
        
    (��ձ޿��� ���� �μ����� ���)
    SELECT DEPARTMENT_ID AS �μ��ڵ�,
           COUNT(*) AS �����,
           ROUND (AVG(SALARY)) AS ��ձ޿� -- ROUND�� ������ �Ҽ����� �ݿø� ����.
      FROM HR.EMPLOYEES
      GROUP BY DEPARTMENT_ID
      ORDER BY ��ձ޿�  DESC -- ORDER BY ROUND (AVG(SALARY)) DESC  
      
    -- ORDER BY ���� ��ձ޿� �� ��Ī �ᵵ �ǰ� 3(����Ʈ ����) �ᵵ ��.
    -- ASC ������ ����,   DESC ������ ����
    
��뿹) ������̺��� �����ȣ, �����, �Ի��� ����Ͻÿ�.
        ��, �޿��� ���� ������� ���
        
    SELECT EMPLOYEE_ID AS�����ȣ,
           EMP_NAME AS �����,
           HIRE_DATE AS �Ի���,
           SALARY �޿�
    FROM HR.EMPLOYEES
    ORDER BY SALARY    -- �� ���̺��� �÷��̶�� �󸶵��� �� �� �ִ�. �� ��¿��� �޿��� ������ ����.
                         -- ���� �� ���� ��
    
    
    
��뿹) ȸ�����̺��� ���ɴ뺰 ��� ���ϸ����� ��ȸ�Ͻÿ�. + ȸ����   
    SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)* 10||'��' AS ���ɴ�,      --EXTRACT : �����ϴ�
            COUNT(*) AS ȸ����,
           AVG(MEM_MILEAGE) AS ��ո��ϸ���
    FROM CSS02.MEMBER
    GROUP BY ���ɴ�
    ORDER BY 1;


1. ������
 - ��Ģ������(���������) : +, -, /, *
 - ���迬����(�񱳿�����) : >, <, >=, <=, =, != (<>) --<> �̰� ũ�ų� �۴�. != �̰ŵ� ũ�ų� �۰ų�
 - �������� : NOT, AND, OR 
 - NULLó���� : IS NULL, IS NOT NULL
 - ��Ÿ������ : LIKE, BETWEEN, IN(SOME), ANY, ALL, EXISTS
 
 
 1) ��Ģ������(���������)
  - ���� ��ȯ
  - ���ǹ� ���� �� �ʼ� �ƴ�.
 
 ��뿹) ������̺��� ���������ڵ�(COMMISSION_PCT)�� ����Ͽ� ���ʽ��� ���޾��� ����Ͽ�
        ����Ͻÿ�. --���ʽ� ��ü �����̶� ���� ����
        ���ʽ�(BONUS)=�޿�(SALARY) * ���������ڵ�(COMMISSION_PCT)�� 50%
        ���޾�=�޿�(SALARY)+���ʽ�(BONUS)
        Alias�� �����ȣ, �����, �޿�, ���ʽ�, ���޾��̴�.
        
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����,
               SALARY AS �޿�,
               NVL(SALARY * COMMISSION_PCT * 0.5,0) AS ���ʽ�,
               SALARY+NVL(SALARY * COMMISSION_PCT * 0.5,0) AS ���޾�
          FROM HR.EMPLOYEES
 -- NVL ����ϸ� NULL ���� �����ش�. ���ʽ� ���»���� �޿� �⺻�� ���� ��.
 
 
 2) ���迬���ڿ� ��������
   - ���ǽ� ������ ���(WHERE ���̳� �Ǵ� ǥ����(DECODE, CASE ~ WHEN THEN)�� ���)
   - ���迬���ڴ� ��Ұ��踦 �Ǵ��Ͽ� ��(true) �Ǵ� ����(false)�� ��ȯ
   - �������ڴ� �ټ����� ������� ����
   ---------------------------------------
    �Է�                  ���
   A   B            AND   OR   EX-OR
   ---------------------------------------
   0   0             0     0     0
   0   1             0     1     1
   1   0             0     1     1
   1   1             1     1     0
   
   ��뿹) Ű����� ��¥�� �Է� �޾� ������ ����Ͻÿ� (�Ʒ��� ������)
   
ACCEPT P_DATE  PROMPT '��¥�Է�(�����) : '  --ACCEPT �Է°� ����ϴ°Ŵ�
  DECLARE
    L_REMINDER  NUMBER:=0;
    L_DAYS  NUMBER:=0;
    L_RESULT  VARCHAR2(100);
  BEGIN
    L_DAYS:=TRUNC(TO_DATE('&P_DATE'))-TRUNC(TO_DATE('00010101'))-1;
    L_REMINDER:=MOD(L_DAYS,7);
    CASE L_REMINDER WHEN 0 THEN L_RESULT:=TO_DATE('&P_DATE')||'�� �Ͽ��� �Դϴ�';  -- ����ġ ���� ���
                    WHEN 1 THEN L_RESULT:=TO_DATE('&P_DATE')||'�� ������ �Դϴ�';
                    WHEN 2 THEN L_RESULT:=TO_DATE('&P_DATE')||'�� ȭ���� �Դϴ�';
                    WHEN 3 THEN L_RESULT:=TO_DATE('&P_DATE')||'�� ������ �Դϴ�';
                    WHEN 4 THEN L_RESULT:=TO_DATE('&P_DATE')||'�� ����� �Դϴ�';
                    WHEN 5 THEN L_RESULT:=TO_DATE('&P_DATE')||'�� �ݿ��� �Դϴ�';
                    ELSE
                                L_RESULT:=TO_DATE('&P_DATE')||'�� ����� �Դϴ�';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(L_RESULT);  -- ���
  END;
   
 ��뿹) Ű����� �⵵�� �Է� �޾� ���� �Ǵ� ����� �Ǵ��Ͽ� ���
   ACCEPT P_YEAR PROMPT '�⵵�Է�(YYYY) : '
   DECLARE
      L_RESULT VARCHAR2(100);
   BEGIN
     IF MOD(&P_YEAR,4)=0 AND MOD(&P_YEAR,100)!=0) OR (MOD(&P_YEAR,400)=0) THEN
         L_RESULT := &P_YEAR||'���� �����Դϴ�.');
      ELSE   
         L_RESULT := &P_YEAR||'���� ����Դϴ�.');
      END IF;
      DBMS_OUTPUT.PUT_LINE(L_RESULT);
   END;
