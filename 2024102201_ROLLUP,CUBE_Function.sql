2024-1022-01)ROLLUP�� CUBE
 - GROUP BY �� ���ο� ���Ǹ�(�����Ͽ� ����� �� ����) �������� ���踦 ��ȯ
1. ROLLUP
 - ������ ���踦 ��ȯ
�������)
    GROUP BY [�÷���,...]ROLLUP(�÷���1, �÷���2,...�÷���n)[,�÷���,...]
      . ROLLUP�� ����� ��� �÷��� ���� ����(���� �������� ����)�� ��ȯ�� �� 
        �����ʺ��� �÷����� �ϳ��� ������ ���踦 ��ȯ��. �������� ��� �÷��� ������
        ����(��ü����)�� ��ȯ��
      . ROLLUP���� ���� �÷��� ���� n���϶� n+1 ������ ���踦 ��ȯ��
      . ROLLUP�� �� �Ǵ� �ڿ� �÷��� �� �� ������ �̸� �κ� ROLLUP�̶���.
      
��뿹) �������̺��� 2020�� ��ݱ�(1~6��) ����, ȸ����, ��ǰ�� �Ǹż����հ踦 ��ȸ�Ͻÿ�.
    SELECT SUBSTR(CART_NO,5,2) AS ��,
           MEM_ID AS ȸ��,
           PROD_ID AS ��ǰ��ȣ,
           SUM(CART_QTY) AS �Ǹż����հ�
      FROM CSS02.CART
     WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
     GROUP BY SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID
    ORDER BY 1;
    
  �� ������ (ROLLUP) ���)   
  -- (NULL)�ߴ°� �հ� / �߰������Ҷ� ����.
  
      SELECT SUBSTR(CART_NO,5,2) AS ��,
           MEM_ID AS ȸ��,
           PROD_ID AS ��ǰ��ȣ,
           SUM(CART_QTY) AS �Ǹż����հ�
      FROM CSS02.CART
     WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
     GROUP BY ROLLUP (SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID)
    ORDER BY 1;
    
(�κ� ROLLUP)
      SELECT SUBSTR(CART_NO,5,2) AS ��,
           MEM_ID AS ȸ��,
           PROD_ID AS ��ǰ��ȣ,
           SUM(CART_QTY) AS �Ǹż����հ�
      FROM CSS02.CART
     WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
     GROUP BY SUBSTR(CART_NO,5,2), ROLLUP (MEM_ID, PROD_ID)
    ORDER BY 1;
    -- �Ѿ��� �ۼ��� ������ �÷� ���� �η� ����鼭 ���� ó����,
    
    
2. CUBE
 - ���� �÷���� ���� ������ ��� ���踦 ��ȯ
�������)
    GROUP BY [�÷���,...,]CUBE(�÷���1,�÷���2,...�÷���n)[,�÷���,...]
      .  CUBE���� ���� �÷���� ���հ����� ��� ����(2^N)�� ��ȯ
      .  ������ ��ɵ��� ROLLUP�� ����
    
    
��뿹) �������̺��� 2020�� ��ݱ�(1~6��) ����, ȸ����, ��ǰ�� �Ǹż����հ踦 ��ȸ�Ͻÿ�.
(ROLLUP ��� CUBE ���)
1. ����, ȸ����, ��ǰ���� ����� ���� ���� �����.
(����,ȸ����,��ǰ��)(����,ȸ����)(����,��ǰ��)(ȸ����,��ǰ��)(����)(ȸ����)(��ǰ��)(����)

    SELECT SUBSTR(CART_NO,5,2) AS ��,
           MEM_ID AS ȸ��,
           PROD_ID AS ��ǰ��ȣ,
           SUM(CART_QTY) AS �Ǹż����հ�
      FROM CSS02.CART
     WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202006'
     GROUP BY CUBE(SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID)
    ORDER BY 1;



