2024-1023-02)����(JOIN)
 - �Ϲ����� / ANSI ����
 - �������� / �ܺ����� 
 - EQU-JOIN / NON EQU-JOIN
 - SELF JOIN, NATURAL JOIN ������ �з�
 - ���ο� �����ϴ� ���̺��� ������ n���϶� ���� ������ ������ ��� n-1�� �̻� �̾�� ��.
 
 �������-�Ϲ�����)
    SELECT �÷�list
      FROM ���̺�1 [��Ī1], ���̺�2 [��Ī2] [, ���̺�3 [��Ī3],...]
     WHERE ��������1
      [AND ��������2]
            :
      [AND �Ϲ�����]
      
�������-ANSI INNER ����)
    SELECT �÷�list
      FROM ���̺�1 [��Ī1]
     INNER JOIN ���̺�2 [��Ī2] ON (�������� [AND �Ϲ�����])
                  :
     WHERE �Ϲ�����
     
        
1. Cartesian Product
 - ���̺�� ���� JOIN ������ �����ϰų�, ������ �߸� �������� ���,
 - ù ��° ���̺��� ��� ��鿡 ���ؼ� �ι�° ���̺��� ��� ����� JOIN�Ǿ� ��ȸ�Ǵ� �������� ���¸� Cartesian Product��� ��
 - Cartesian Product�� �߻��ϸ� ��ȸ�Ǵ� �������� ������ ���ϱ޼������� �����ϰ� �Ǿ� ���ϴ� �����͸� ���� �� ���� ���� ����, 
    �����ͺ��̽��� ��Ʈ��ũ�� �δ��� �ְ� �Ǵ� ����� �ʷ��ϰ� �ǹǷ� �����ؾ� �Ѵ�

 �������-�Ϲ�����)
    SELECT �÷�list
      FROM ���̺�1 [��Ī1], ���̺�2 [��Ī2] [, ���̺�3 [��Ī3],...]
    . ����� �� ���̺� �����ϴ� ����� ��� ���ϰ� ������ ���� ����� ��ȯ��.
     (ex A���̺��� 100�� 20��, B���̺��� 50�� 10���� ������ ��� Cartesian Product�� �����ϸ�
     ����� 5000�� 30��)

�������-ANSI CROSS ����)   -- �Ƚ������� ���̺� �ݵ�� 1�� ���.
    SELECT �÷�list
      FROM ���̺�1 [��Ī1]
     CROSS JOIN ���̺�2 [��Ī2] 
                  :


��뿹) ��ٱ������̺�(CART), �������̺�(BUYPROD), ��ǰ���̺�(PROD)�� Cartesian Product�� �����Ͻÿ�.
    SELECT COUNT(*) FROM CSS02.CART; --207�� 4��
    SELECT COUNT(*) FROM CSS02.BUYPROD; --148�� 3�� 
    SELECT COUNT(*) FROM CSS02.PROD;  --74�� 19��
    
(�Ϲ����� -   Cartesian Product)
    SELECT COUNT(*)
    FROM CSS02.CART, CSS02.BUYPROD, CSS02.PROD

(ANSI CROSS JOIN) --�� �Ϲݰ� ��� ����
    SELECT COUNT(*)
      FROM CSS02.CART
      CROSS JOIN CSS02.BUYPROD
      CROSS JOIN CSS02.PROD

2. �������� (INNER JOIN)
 - ��κ��� ����
 - �������ǿ� '='������ ���

�������-�Ϲ�����)
  SELECT �÷�list
      FROM ���̺�1 [��Ī1], ���̺�2 [��Ī2] [, ���̺�3 [��Ī3],...]
     WHERE ��������1
      [AND ��������2]
            :
      [AND �Ϲ�����];
    . ���̺��� ������ n�� �϶� n-1�� �̻��� ���������� �ʿ�
    . '�Ϲ�����'�� '��������'�� ��������� �ǹ̾���

�������-ANSI INNER ����)
    SELECT �÷�list
      FROM ���̺�1 [��Ī1]
     INNER JOIN ���̺�2 [��Ī2] ON (��������1 [AND �Ϲ�����1])
     INNER JOIN ���̺�3 [��Ī3] ON (��������2 [AND �Ϲ�����2])
                  :
     WHERE �Ϲ�����
    . '���̺�1'��'���̺�2'�� �ݵ�� ���� ���εǾ�� ��.
    . '��������1'�� '���̺�1'��'���̺�2'�� ���� ���� ����
    . '�Ϲ�����1'�� '���̺�1'��'���̺�2'�� ���� �Ϲ� ����
    . '���̺�3'��  '���̺�1'��'���̺�2'�� ���ΰ���� ���ε�.
    . 'WHERE �Ϲ�����'�� ��� ���̺�� ���õ� ������ ��� -- **���������� ���
      �Ϲ����� ����� ON���� ����ϵ��� WHERE������ ����ϵ��� ���� ����.
      
��뿹) 2020�� 1�� �����ڷḦ ��ȸ�Ͻÿ�           -- ���̺� ȥ�� ���Ǵ� �÷��� ��Ī �Ƚᵵ ��.
       Alias�� ��¥, ��ǰ��, ����, ���Աݾ��̴�.
       SELECT A.BUY_DATE AS ��¥,
              B.PROD_NAME AS ��ǰ��,
              A.BUY_QTY AS ����,
              A.BUY_QTY*B.PROD_COST AS ���Աݾ�
         FROM CSS02.BUYPROD A, CSS02.PROD B
        WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
          AND A.PROD_ID=B.PROD_ID;
     
(ANSI INNER JOIN)      
   SELECT A.BUY_DATE AS ��¥,
          B.PROD_NAME AS ��ǰ��,
          A.BUY_QTY AS ����,
          A.BUY_QTY*B.PROD_COST AS ���Աݾ�
     FROM SEM1.BUYPROD A
    INNER JOIN  SEM1.PROD B ON(A.PROD_ID=B.PROD_ID AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'));
     
   SELECT A.BUY_DATE AS ��¥,
          B.PROD_NAME AS ��ǰ��,
          A.BUY_QTY AS ����,
          A.BUY_QTY*B.PROD_COST AS ���Աݾ�
     FROM SEM1.BUYPROD A
    INNER JOIN  SEM1.PROD B ON(A.PROD_ID=B.PROD_ID)
    WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131');