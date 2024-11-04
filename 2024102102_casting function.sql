2024-1021-02) ����ȯ�Լ�
 - CAST, TO_CHAR, TO_NUMBER, TO_DATE
 
1. TO_CHAR(char|number|date [,fmt] )

 1) ��¥�����������ڿ�
-----------------------------------------------------------------------
 ���ڿ�             �ǹ�            ��
-----------------------------------------------------------------------
 AD, BC            ����         SELECT TO_CHAR(SYSDATE,'BC AD') FROM DUAL;
 CC                ����         SELECT EXTRACT(YEAR FROM SYSDATE)||'�� => ' || TO_CHAR(SYSDATE,'CC')||'������' FROM DUAL;
 YYYY,YYY,YY       �⵵         SELECT TO_CHAR(SYSDATE,'YYYY YYY YY Y YEAR') FROM DUAL;  
 Y, YEAR
 
 MONTH,MON          ��          SELECT TO_CHAR(SYSDATE,'YYYY MONTH, YYYY MON') FROM DUAL;
 RM, MM                         SELECT TO_CHAR(SYSDATE,'YYYY MM, YYYY RM') FROM DUAL;
 DD, DDD, J        ��¥          SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DDD') FROM DUAL;
                                SELECT TO_CHAR(SYSDATE, 'YYYY-MM-J') FROM DUAL;
 AM, PM             ����/����    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD PM') FROM DUAL;
 HH, HH12, HH24     �ð�        SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DD HH:MI:SS') FROM DUAL;
 MI                 ��          SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DD HH:MI:SS SSSSS') FROM DUAL;
 SS,SSSSS           ��          
 ����ڰ� ���� ���� ���� ���ڿ�    SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') FROM DUAL;
 
 
 
 ���
 1. ���� ����
 2. 2024�� => 21������
 3. 2024 024 24 4 TWENTY TWENTY-FOUR
 4. 2024 10��, 2024 10��  -- ����� MONTH: OCTOBER , MON: OCT
 5. 2024 10, 2024 X   : �θ����� �� ǥ�� �� ����.
 6. 2024-10-295
 7. 2024-10-2460605
 8. 2024-10-21 ����
 9. 2024-10-21 21 11:07:25 (����ð� ���)
 10. 2024-10-21 21 11:08:57 40137
 11. 2024�� 10�� 21��  -- " "�� ���ڿ� �߰��Ͽ� ���
 
 
 2) ���������������ڿ�
 -----------------------------------------------------------------------
 ���ڿ�   �ǹ�                                   ��
------------------------------------------------------------------------
 9, 0    ����������ڸ�, ��ȿ�Ѽ����ΰ�����        SELECT TO_CHAR(PROD_COST,'9,999,999'),
                                                        TO_CHAR(PROD_COST,'0,000,000')
                                                  FROM CSS02.PROD;
         ����������ڸ�, ��ȿ�Ѽ����ΰ��0���       SELECT ROUND(SALARY/7,2),
                                                        TO_CHAR(ROUND(SALARY/7,2),'99,999.99'),
                                                        TO_CHAR(ROUND(SALARY/7,2),'00,000.00')
                                                    FROM HR.EMPLOYEES;
 $,L     ȭ���ȣ ���                             SELECT TO_CHAR(PROD_COST,'L9,999,999') FROM CSS02.PROD;                                              
 MI      ������ȣ)'-'�� �����ʿ� ���               SELECT TO_CHAR(-12345,'999,999MI'),
                                                        TO_CHAR(12345,'999,999MI') 
                                                    FROM DUAL; 
 PR      ������ "<>"�� ǥ��                        SELECT TO_CHAR(-12345,'999,999PR'),
                                                        TO_CHAR(12345,'999,999PR') 
                                                    FROM DUAL;


���
1.    210,000	 0,210,000 << �̷� ����  9�� ���� 0�� 0�� �־ ���
2. 660	    660.00	 00,660.00  << �Ҽ��������� 9,0 ��� �Ѵ� ����.
3.  ��210,000  < ���� �տ� L ���̸� �츮���� ����̶� ��ȭ�� ����. �տ� $�� ���̸� �޷��� ǥ�õ�.
4.  12,345-	 12,345  -- �� �Ⱦ�
5.  <12,345>	  12,345 



2. TO_NUMBER(CHAR [,FMT])
  - �־��� ���ڿ� �ڷ�(char)�� ���ڷ� ��ȯ
  - 'char'�� ���ڷ� ��ȯ�� �� ���� ���ڰ� ���Ե� ��� => 
  �ش��ڷᰡ ��µǱ� ���� �ʿ��� �����������ڿ���'fmt'�� ����Ͽ� �⺻ ������ �ڷḦ ��ȯ�ؾ���.
    
��뿹)
    SELECT TO_NUMBER('12345'),
           TO_NUMBER('12345.67'),
           TO_NUMBER('12,345.67','99,999.99'),
           TO_NUMBER('��123,456','L000,000')
        FROM DUAL;
        
 ���
12345	12345.67	12345.67	123456
        

3. TO_DATE(char|number [,fmt])
 - �־��� ���ڿ� �ڷ�(char)�� �����ڷḦ ��¥ ������ �ڷ�� ��ȯ
 - 'char'�� ��¥�� ��ȯ�� �� ���� ���ڰ� ���Ե� ���=>�ش� �ڷᰡ ��µǱ� ���� �ʿ��� 
   �����������ڿ��� 'fmt'�� ����Ͽ� �⺻ ��¥�� �ڷḦ ��ȯ�ؾ���
 - 'char|number'�� ��¥�ڷ�� ��ȯ�� �� �ִ� ��Ҹ� ��� �����ؾ� �Ѵ�.(��, �����)
 
��뿹)
    SELECT TO_DATE('20200430'),
           TO_DATE(20200630)
        FROM DUAL;
        
     SELECT TO_CHAR(TO_DATE('20200430123127','YYYYMMDDHH24MISS'),'YYYY-MM-DD HH24:MI:SS'),
        TO_DATE(20200630)
        FROM DUAL;
        
 ���
 1. 2020/04/30	2020/06/30  <���ڿ�, ���ڸ� 6�� 31�Ϸ� ������ ������
 2. 2020/04/30	2020/06/30  
 3. 2020-04-30 12:31:27	    2020/06/30      



4. CAST(expr   as     type)

��뿹) 2020�� 07�� ������Ȳ�� ��ȸ�Ͻÿ�. Alias�� ��¥, ��ǰ�ڵ�, ��������̴�.

SELECT CAST(SUBSTR(CART_NO,1,8) AS DATE) AS ��¥,
       PROD_ID AS ��ǰ�ڵ�,
       CART_QTY AS �������
    FROM CSS02.CART
    WHERE CART_NO LIKE '202007%'

���
2020/07/01 (�⺻ ��¥ Ÿ��)	P201000013	  5