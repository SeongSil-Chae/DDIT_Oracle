? ��ǰ���̺��� ��ǰ�� ��, �ִ��ǸŰ�, �ּ��ǸŰ��� ���Ͻÿ�.
    SELECT PROD_TOTALSTOCK AS ��ǰ�Ǽ�,
           COUNT(*),
           MAX(PROD_PRICE) AS �ִ��ǸŰ�,
           MIN(PROD_PRICE) AS �ּ��ǸŰ�
    FROM CSS02.PROD
    GROUP BY PROD_ID, PROD_TOTALSTOCK
    HAVING MAX(PROD_PRICE)>0 AND MIN(PROD_PRICE)>=0


? 2020�� 4�� �Ǹż��� �հ踦 ���Ͻÿ�.
    SELECT CART_NO,
       SUM(CART_QTY)
    FROM CSS02.CART
    WHERE TO_DATE(SUBSTR(CART_NO, 1, 8), 'YYYYMMDD') 
      BETWEEN TO_DATE('2020-04-01', 'YYYY-MM-DD') 
      AND TO_DATE('2020-04-30', 'YYYY-MM-DD')        
    GROUP BY CART_NO
    
    



? ������̺��� �μ��� ��ձ޿��� �ο����� ��ȸ�Ͻÿ�
? ��ǰ���̺��� �з��� ��ǰ�� ��, ����ǸŰ��� ��ȸ�Ͻÿ�.
? �������̺��� 2020�� ���� ���Լ����հ踦 ��ȸ�Ͻÿ�.
? �������̺��� 2020�� ��ǰ�� ���Լ����հ踦 ��ȸ�Ͻÿ�.
? �������̺��� ����, ��ǰ�� �Ǹż����հ踦 ��ȸ�Ͻÿ�.
? ������̺��� �μ���, �⵵�� �Ի��� ������� ��ȸ�Ͻÿ�. 
? ȸ�����̺��� ���� ��ո��ϸ����� ��ȸ�Ͻÿ�.
? ȸ�����̺��� ��ɴ뺰 ȸ������ ��ո��ϸ����� ��ȸ�Ͻÿ�.
? ȸ�����̺��� �������� ��ո��ϸ����� ȸ������ ��ȸ�Ͻÿ�.