2024-1024-02)����
DELETE FROM CSS02.REMAIN;
 --����: CART �μ�Ʈ -> REMAIN ������Ʈ, -> ���ϸ��� ������Ʈ
 --���� : BUYPROD �μ�Ʈ -> REMAIN ������Ʈ
** ������ ������ ��� ���� ���̺�(REMAIN)�� �����Ͻÿ�.
--------------------------------------------------------------------------------
�÷���          ������Ÿ��              �⺻��              PK,FK           ����
--------------------------------------------------------------------------------
REMAIN_YEAR     CHAR(4)                                   PK             �⵵
PROD_ID         VARCHAR2(10)                              PK & FK        ��ǰ�ڵ�
REMAIN_J_00     NUMBER(5)               0                                �������
REMAIN_I        NUMBER(5)               0                                �԰����
REMAIN_O        NUMBER(5)               0                                ������
REMAIN_J_99     NUMBER(5)               0                                �����=�������+����-����
REMAIN_DATE     DATE                  SYSDATE                            ó������

** REMAIN ���̺� ���� �ڷḦ �Է��Ͻÿ�.
 �⵵ : 2020��
 ��ǰ�ڵ� : ��ǰ���̺��� ��� ��ǰ�ڵ�
 ������� : ��ǰ���̺��� �ش� ��ǰ�� ������� (PROD_PROPERSTOCK)
 �����   : ��ǰ���̺��� �ش� ��ǰ�� �������
 �������� : 2020�� 1�� 1��
 
 INSERT INTO CSS02.REMAIN(REMAIN_YEAR,PROD_ID, REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)
   SELECT '2020', PROD_ID, PROD_PROPERSTOCK, PROD_PROPERSTOCK,TO_DATE('20200101')
   FROM CSS02.PROD;
COMMIT;

SELECT * FROM CSS02.REMAIN;