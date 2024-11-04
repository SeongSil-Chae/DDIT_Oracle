2024-1031-01) 시퀀스

사용예)
   CREATE SEQUENCE seq_lprod_id
     START WITH 10;
     
사용예) LPROD테이블에 다음의 자료를 삽입하시오.
--------------------------------------------
   LPROD_ID        LPROD_GU       LPROD_NM
--------------------------------------------
     시퀀스사용      P501            농산물
        ""          P502            수산물
        ""          P503            임산물
 
 INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) 
        VALUES(seq_lprod_id.NEXTVAL,'P501','농산물');
 
  INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) 
        VALUES(seq_lprod_id.NEXTVAL,'P502','수산물');       
  
  INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) 
        VALUES(seq_lprod_id.NEXTVAL,'P503','임산물');   
        
    SELECT * FROM LPROD;    
    SELECT seq_lprod_id.CURRVAL FROM DUAL;   
        
        
        