2024-1031-01) ������

��뿹)
   CREATE SEQUENCE seq_lprod_id
     START WITH 10;
     
��뿹) LPROD���̺� ������ �ڷḦ �����Ͻÿ�.
--------------------------------------------
   LPROD_ID        LPROD_GU       LPROD_NM
--------------------------------------------
     ���������      P501            ��깰
        ""          P502            ���깰
        ""          P503            �ӻ깰
 
 INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) 
        VALUES(seq_lprod_id.NEXTVAL,'P501','��깰');
 
  INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) 
        VALUES(seq_lprod_id.NEXTVAL,'P502','���깰');       
  
  INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) 
        VALUES(seq_lprod_id.NEXTVAL,'P503','�ӻ깰');   
        
    SELECT * FROM LPROD;    
    SELECT seq_lprod_id.CURRVAL FROM DUAL;   
        
        
        