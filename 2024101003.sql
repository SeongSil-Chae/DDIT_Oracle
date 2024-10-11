2024-1010-03) ��¥�ڷ� Ÿ��
 - DATE, TIMESTAMP, TIMESTAMP WITH LOCAL TIME ZONE, TIMESTAMP WITH TIME ZONE
1. DATE
 - �⺻ ��¥ Ÿ��(��, ��, ��, ��, ��, ��)
 - '+', '-' �� ���� ��� (������, �� �ȵ�)
 - SYSDATE �Լ��� �ý��� ��¥ ����
 
2. TIMESTAMP
  - ������ �ð�(�Ҽ��� 9�ڸ� ������ �ʹ�ȯ)
  - SYSTIMESTAMP �Լ��� �ý��� ��¥ ����
  
�������)
  SELECT SYSDATE FROM DUAL;
   ** ������ ���̺��� ������ DUAL�� ���.
  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
   ** �׳� ����ϸ� ���� ���� GMT ������ ����.
   ** �ٿ� ���� ���� 6. Docker���� ����Ŭ�� �ð� ���� �����ϱ� << ���� ���� 
      �״�� ��Ŀ �����ϸ� ���� �ð����� ���� ����.
      
      
      
��뿹)
  CREATE TABLE TEST04(
    COL1 DATE,
    COL2 DATE,
    COL3 DATE,
    COL4 TIMESTAMP,
    COL5 TIMESTAMP WITH LOCAL TIME ZONE,
    COL6 TIMESTAMP WITH TIME ZONE);
    
  INSERT INTO TEST04 VALUES(SYSDATE, SYSDATE-10, SYSDATE+10, SYSTIMESTAMP, SYSTIMESTAMP, SYSTIMESTAMP);  

  SELECT * FROM TEST04;  
  -- �����
  -- 2024/10/11	2024/10/01	2024/10/21	2024/10/11 09:16:52.596606000	2024/10/11 09:16:52.596606000	2024/10/11 09:16:52.596606000 +09:00
  
  -- ��¥�� -10 �ϸ� 10���� ����.
  
  SELECT TRUNC(SYSDATE) - TRUNC(TO_DATE('19921229')) FROM DUAL;
  -- �� ���� �� ��¥���� ��ƿ� �ϼ� ����
  -- TRUNC : �Ҽ��� ©�����.
  -- DUAL : ���̺��� ������.
  -- ��¥ - ��¥ = ����
  
  
  
  
  
  
  
  
  
  
  
  
   
   
   