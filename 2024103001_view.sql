2024-1030-01) VIEW

 - �⺻���� ������ ��(WITH CHECK OPTION, WITH READ ONLY �� ������ ���� ��)�� ������ ����Ǹ� ����
   ���̺��� ���뵵 �����.
 - ���� ���̺��� ������ VIEW�� ������� ����Ǹ� ������ ���� ������ ��� ������ �信 �ݿ�
 - WITH READ ONLY : ������ �䰡 �б� �����̱� ������ �並 ������ �� ����. ��, �������̺���
   ���Ѿ��� ����� �� ������ �� ����� ��� �信 �ݿ�
 - WITH CHECK OPTION : ������ ���� ������ ���������� ���ǿ� �����ϵ��� ������ �� ����.
   ��, �������̺��� ���Ѿ��� ����� �� ������ �� ����� ��� �信 �ݿ�
 - WITH READ ONLY,   WITH CHECK OPTION  : ���� ����� �� ����
   
��뿹) ȸ�����̺��� ���ϸ����� 4000�̻��� ȸ������ VIP �並 �����Ϸ��Ѵ�.
    
 CREATE OR REPLACE VIEW V_MEM01(MID, MNAME, MILEAGE)
 AS
   SELECT MEM_ID AS ȸ����ȣ,
          MEM_NAME AS ȸ����,
          MEM_MILEAGE AS ���ϸ���
     FROM CSS02.MEMBER
     WHERE MEM_MILEAGE >=4000;
     
 1) MEMBER���̺���'a001'ȸ���� ���ϸ����� 6000���� �����Ͻÿ�
     UPDATE CSS02.MEMBER
        SET MEM_MILEAGE=6000
      WHERE UPPER(MEM_ID) = 'A001'
     
     SELECT * FROM V_MEM01
     
  
  2) �信�� 'V001'ȸ���� ���ϸ���(4300)�� 2300���� �����Ͻÿ�.
     UPDATE V_mem01
        SET ���ϸ��� = 2300
      WHERE LOWER(ȸ����ȣ)='v001'
     
    SELECT * FROM V_mem01
    
    
     CREATE OR REPLACE VIEW V_MEM01
 AS
   SELECT MEM_ID AS ȸ����ȣ,
          MEM_NAME AS ȸ����,
          MEM_MILEAGE AS ���ϸ���
     FROM CSS02.MEMBER
     WHERE MEM_MILEAGE >=4000
     WITH READ ONLY;
     
     
 3) �信�� 'V001'ȸ���� ���ϸ���(2300)�� 4300���� �����Ͻÿ�.
     UPDATE V_mem01
        SET ���ϸ��� = 4300
      WHERE LOWER(ȸ����ȣ)='v001'
     
    SELECT * FROM V_MEM01
    
    
 4) MEMBER ���̺���  'V001'ȸ���� ���ϸ���(2300)�� 4300���� ����
  UPDATE MEMBER
     SET MEM_MILEAGE=4300
   WHERE LOWER(MEM_ID)='v001'
   
   SELECT * FROM V_mem01;
   
   
   
   CREATE OR REPLACE VIEW V_mem01
   AS 
     SELECT MEM_ID,
          MEM_NAME,
          MEM_MILEAGE
     FROM CSS02.MEMBER
     WHERE MEM_MILEAGE >=4000   
     WITH CHECK OPTION
   
5) �信�� 'V001'ȸ���� ���ϸ���(4300)�� 3300���� �����Ͻÿ�.  -- ���� ����Ǽ� �ȵȴٰ� ����
     UPDATE V_mem01
        SET MEM_MILEAGE = 3300
      WHERE LOWER(MEM_ID)='v001'  

6) MEMBER ���̺���  'V001'ȸ���� ���ϸ���(4300)�� 3300���� ����  --���̺��� �����ϸ� �����.
  UPDATE MEMBER
     SET MEM_MILEAGE=3300
   WHERE LOWER(MEM_ID)='v001'
   
   SELECT * FROM V_mem01;
   
   