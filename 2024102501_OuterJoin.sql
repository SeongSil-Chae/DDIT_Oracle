2024-1025-01) �ܺ�����
 - ���������� ���������� �����ϴ� �ڷḸ ����� ���
 - �ܺ������� �� ���� ���� �������� ������ ���̺� NULL������ ������ ���� ������ �� ���� ����
 - �Ϲ� �ܺ����� �����ڴ� '(+)'�̸� �̿����ڴ� ������ ���̺��ʿ� �߰��Ѵ�.
 (���ǻ���) 
 . �������� �������� �� �������� �ܺ� ������ �ʿ��� ��� ��� �ܺ����� �����ڸ� �߰��ؾ���.
 . A, B, C ������ ���̺��� �ܺ������ϴ� ��� �� ���̺��� ���ÿ� ������ �� ���̺�� �ܺ����� �� �� ����.
  �� A=B(+) AND C=B(+)�� ������ ����. ��, A=B(+) AND B=C(+)�� ����
 . �Ϲ� �ܺ����ι��� WHERE���� �Ϲ������� ���ԵȰ�� ����� ������������ ������µ�
    => �ذ�å���� ���������� ����Ͽ� �ذ��ϰų� ANSI������ ����Ͽ��� �Ѵ�.
�������-�Ϲݿܺ�����)
    SELECT �÷�LIST
      FROM ���̺�1 [��Ī1], ���̺�2 {��Ī2] [,...]
     WHERE ���̺�1.�÷�=���̺�2.�÷�(+)
                :
    - '(+)' �����ڰ� ����ʿ� ���ǵ� ����� ����
    - '���̺�1.�÷�(+)=���̺�2.�÷�(+)'�� ������ ����.
   
�������-ANSI�ܺ�����)
    SELECT �÷�LIST
      FROM ���̺�1 [��Ī1]
      REIGHT|LEFT|FULL OUTER JOIN ���̺�2 [��Ī2] ON (�������� [AND �Ϲ�����])
                :
    [WHERE �Ϲ�����]
     . RIGHT : OUTER JOIN ������ ����� ���̺� �� ���� �ڷᰡ �����ϴ� ���
     . LEFT : FROM������ ���̺� �� ���� �ڷᰡ �����ϴ� ���
     . FULL : ���� ��ο� �ڷᰡ ������ ���(�Ϲݿܺ����ο��� ������ ���� '���̺�1.�÷�(+)=���̺�2.�÷�(+)'�� �ش�
     . WHERE ���� ���Ǹ� ������������ ������.
     -- ���⼭�� COUNT(*) ��� ����
     
��뿹) ��ǰ���̺��� ��� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�.
    Alias�� �з��ڵ�, �з���, ��ǰ�� ��
    SELECT B.LPROD_GU AS �з��ڵ�,
           B.LPROD_NM AS �з���,
           COUNT(A.PROD_ID) AS "��ǰ�� ��"
      FROM CSS02.PROD A, CSS02.LPROD B
      WHERE A.LPROD_GU(+) = B.LPROD_GU 
      GROUP BY B.LPROD_GU,  B. LPROD_NM
      ORDER BY 1
    
ANSI FORMAT    
    SELECT B.LPROD_GU AS �з��ڵ�,
           B.LPROD_NM AS �з���,
           COUNT(A.PROD_ID) AS "��ǰ�� ��"
      FROM CSS02.PROD A
      RIGHT OUTER JOIN CSS02.LPROD B ON(A.LPROD_GU=B.LPROD_GU)
    GROUP BY B.LPROD_GU,  B. LPROD_NM
      ORDER BY 1
    
    
      --  SELECT DISTINCT LPROD_GU FROM CSS02.PROD
      --  SELECT LPROD_GU FROM CSS02.LPROD
        
        
��뿹) 2020�� 1�� ��� ��ǰ�� �������踦 ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ�
   SELECT B.PROD_ID AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          NVL(SUM(A.BUY_QTY),0) AS ���Լ���,
          SUM(A.BUY_QTY*B.PROD_COST) AS ���Աݾ�
     FROM CSS02. BUYPROD A, CSS02.PROD B
     WHERE B.PROD_ID=A.PROD_ID(+)
    --   AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
       GROUP BY B.PROD_ID, B.PROD_NAME
       ORDER BY 1
        
ANSI FORMAT)
 SELECT B.PROD_ID AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          NVL(SUM(A.BUY_QTY),0) AS ���Լ���,
          NVL(SUM(A.BUY_QTY*B.PROD_COST), 0) AS ���Աݾ�
     FROM CSS02.PROD B 
     LEFT OUTER JOIN CSS02. BUYPROD A ON(B.PROD_ID=A.PROD_ID AND
        A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131'))
    GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 4 DESC   

**** WHERE (���� ���� ����� 39���� ����.  �Ϲ� ������ �Ǽ� 0�� �ȳ���)    ****
 SELECT B.PROD_ID AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          NVL(SUM(A.BUY_QTY),0) AS ���Լ���,
          NVL(SUM(A.BUY_QTY*B.PROD_COST), 0) AS ���Աݾ�
     FROM CSS02.PROD B 
     LEFT OUTER JOIN CSS02. BUYPROD A ON(B.PROD_ID=A.PROD_ID )
      WHERE  A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
    GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 4 DESC           

(2020�� 1�� ��ǰ�� ���Լ���, ���Աݾ� ����)
  SELECT A.PROD_ID AS APID,
         SUM(BUY_QTY) AS SQTY,
         SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
    FROM CSS02.BUYPROD A, CSS02.PROD B
    WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
    GROUP BY A.PROD_ID
         
          
(��� ��ǰ�� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ�) -- �������� �Ἥ ����.
     SELECT C.PROD_ID AS ��ǰ�ڵ�,
            C.PROD_NAME AS ��ǰ��,
            NVL(D.SQTY,0) AS ���Լ���,
            NVL(D.BSUM,0) AS ���Աݾ�
       FROM CSS02.PROD C, 
            (SELECT A.PROD_ID AS APID,
                 SUM(BUY_QTY) AS SQTY,
                 SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
                FROM CSS02.BUYPROD A, CSS02.PROD B
               WHERE A.PROD_ID=B.PROD_ID
                 AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
                 GROUP BY A.PROD_ID)D
      WHERE C.PROD_ID=D.APID(+)
    ORDER BY 4 DESC
 
 (ANSI PUTER JOIN) -- �� �������� �� ������ �Ʒ� �Ƚ÷� ������.
 SELECT C.PROD_ID AS ��ǰ�ڵ�,
            C.PROD_NAME AS ��ǰ��,
            NVL(D.SQTY,0) AS ���Լ���,
            NVL(D.BSUM,0) AS ���Աݾ�
       FROM CSS02.PROD C 
       LEFT OUTER JOIN (SELECT A.PROD_ID AS APID,
                           SUM(BUY_QTY) AS SQTY,
                           SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
                          FROM CSS02.BUYPROD A, CSS02.PROD B
                         WHERE A.PROD_ID=B.PROD_ID
                           AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND ('20200131')
                         GROUP BY A.PROD_ID)D ON (C.PROD_ID=D.APID)
        ORDER BY 4 DESC
    
��뿹) ������̺��� ��� �μ��� ������� ��ȸ�Ͻÿ�.
       Alias �μ��ڵ�, �μ���, �����
      SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
             B.DEPARTMENT_NAME AS �μ���,
             COUNT(A.EMPLOYEE_ID) AS �����
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE  A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID(+)
     GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 1;
    
(ANSI OUTER)
      SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
             B.DEPARTMENT_NAME AS �μ���,
             COUNT(A.EMPLOYEE_ID) AS �����
      FROM HR.EMPLOYEES A
      FULL OUTER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID= B.DEPARTMENT_ID)
         GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 1;
     
����1] 2020�� 6�� ��ǰ�� ����/���� �������踦 ��ȸ�Ͻÿ�.
    Alias�� ��ǰ�ڵ�, ��ǰ��, ���Լ���, �������
  SELECT A.PROD_ID AS ��ǰ�ڵ�,
         A.PROD_NAME AS ��ǰ��,
         SUM(C.BUY_QTY) AS ���Լ���,
         SUM(B.CART_QTY) AS �������
    FROM css02.PROD A, css02.CART B, css02.BUYPROD C
   WHERE A.PROD_ID=B.PROD_ID(+)
     AND A.PROD_ID=C.PROD_ID(+)
     AND B.CART_NO LIKE '202006%'
     AND C.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
   GROUP BY  A.PROD_ID, A.PROD_NAME
   ORDER BY 1;  
   
(ANSI)
  SELECT A.PROD_ID AS ��ǰ�ڵ�,
         A.PROD_NAME AS ��ǰ��,
         NVL(SUM(C.BUY_QTY),0) AS ���Լ���,
         NVL(SUM(B.CART_QTY),0) AS �������
    FROM css02.PROD A
    LEFT OUTER JOIN css02.CART B ON(A.PROD_ID=B.PROD_ID AND 
         SUBSTR(B.CART_NO,1,6) BETWEEN '202001' AND '202004')
    LEFT OUTER JOIN css02.BUYPROD C ON(C.PROD_ID=A.PROD_ID AND
         C.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200430'))
   GROUP BY  A.PROD_ID, A.PROD_NAME
   ORDER BY 1; 
   
--������������Լ�     
CREATE OR REPLACE FUNCTION fn_sum_cart(
  P_SDATE IN VARCHAR2, P_EDATE IN VARCHAR2, P_PID IN css02.PROD.PROD_ID%TYPE)
  RETURN NUMBER
IS
  L_SUM NUMBER:=0;
BEGIN
  SELECT SUM(CART_QTY) INTO L_SUM
    FROM css02.CART
   WHERE SUBSTR(CART_NO,1,6) BETWEEN P_SDATE AND P_EDATE
     AND PROD_ID=P_PID;
  RETURN L_SUM; 
END;

--���Լ��������Լ�    
CREATE OR REPLACE FUNCTION fn_sum_buyprod(
  P_SDATE IN VARCHAR2, P_EDATE IN VARCHAR2, P_PID IN css02.PROD.PROD_ID%TYPE)
  RETURN NUMBER
IS
  L_SUM NUMBER:=0;
BEGIN
  SELECT SUM(BUY_QTY) INTO L_SUM
    FROM css02.BUYPROD
   WHERE BUY_DATE BETWEEN TO_DATE(P_SDATE||'01') AND LAST_DAY(TO_DATE(P_EDATE||'01'))
     AND PROD_ID=P_PID;
  RETURN L_SUM; 
END;    
    
--����    
SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��,
       fn_sum_buyprod('202001','202004',PROD_ID) AS ���Լ���,
       fn_sum_cart('202001','202004',PROD_ID) AS �������
  FROM PROD;     
       
    