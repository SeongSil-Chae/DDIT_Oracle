2024-1018-03) ���� �Լ�
 - �������Լ�(ABS,SQRT,POWER, SIGN, ... ETC), ROUND, TRUNC, MOD, CEIL, FLOOR��
 
 ��뿹)
    SELECT ABS(-2000), ABS(2000),
           ROUND(SQRT(3.3),3), SIGN(-10000), SIGN(0.0001),SIGN(0), POWER(2,10)
     FROM DUAL;
     
     ��� : 2000  	2000	1.817	-1	1	0	1024
     
��뿹) ��ǰ���̺��� �� ��ǰ�� ���ϸ����� �ٸ� �������� ����Ͽ� �����Ͻÿ�
        ���ϸ���=(��ǰ�� ���Ⱑ��-���԰���)�� 1% ���� �ʰ��ϴ� ���� ����� ����
                ��, �� ���� �����̸� �� ���� ��ȯ
         UPDATE PROD
         SET PROD_MILEAGE = CEIL ((PROD_PRICE-PROD_COST)*0.01)
      COMMIT;
        
        