2024-1030-01) VIEW

 - 기본으로 생성된 뷰(WITH CHECK OPTION, WITH READ ONLY 가 사용되지 않은 뷰)의 내용이 변경되면 원본
   테이블의 내용도 변경됨.
 - 원본 테이블의 변경은 VIEW와 상관업이 수행되며 원본의 수정 내용은 즉시 언제나 뷰에 반영
 - WITH READ ONLY : 생성된 뷰가 읽기 전용이기 때문에 뷰를 변경할 수 없음. 단, 원본테이블은
   제한없이 변경될 수 있으며 그 결과는 즉시 뷰에 반영
 - WITH CHECK OPTION : 생성된 뷰의 내용을 생성쿼리의 조건에 위배하도록 변경할 수 없음.
   단, 원본테이블은 제한없이 변경될 수 있으며 그 결과는 즉시 뷰에 반영
 - WITH READ ONLY,   WITH CHECK OPTION  : 같이 사용할 수 없음
   
사용예) 회원테이블에서 마일리지가 4000이상인 회원들의 VIP 뷰를 구성하려한다.
    
 CREATE OR REPLACE VIEW V_MEM01(MID, MNAME, MILEAGE)
 AS
   SELECT MEM_ID AS 회원번호,
          MEM_NAME AS 회원명,
          MEM_MILEAGE AS 마일리지
     FROM CSS02.MEMBER
     WHERE MEM_MILEAGE >=4000;
     
 1) MEMBER테이블에서'a001'회원의 마일리지를 6000으로 변경하시오
     UPDATE CSS02.MEMBER
        SET MEM_MILEAGE=6000
      WHERE UPPER(MEM_ID) = 'A001'
     
     SELECT * FROM V_MEM01
     
  
  2) 뷰에서 'V001'회원의 마일리지(4300)를 2300으로 변경하시오.
     UPDATE V_mem01
        SET 마일리지 = 2300
      WHERE LOWER(회원번호)='v001'
     
    SELECT * FROM V_mem01
    
    
     CREATE OR REPLACE VIEW V_MEM01
 AS
   SELECT MEM_ID AS 회원번호,
          MEM_NAME AS 회원명,
          MEM_MILEAGE AS 마일리지
     FROM CSS02.MEMBER
     WHERE MEM_MILEAGE >=4000
     WITH READ ONLY;
     
     
 3) 뷰에서 'V001'회원의 마일리지(2300)를 4300으로 변경하시오.
     UPDATE V_mem01
        SET 마일리지 = 4300
      WHERE LOWER(회원번호)='v001'
     
    SELECT * FROM V_MEM01
    
    
 4) MEMBER 테이블에서  'V001'회원의 마일리지(2300)를 4300으로 변경
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
   
5) 뷰에서 'V001'회원의 마일리지(4300)를 3300으로 변경하시오.  -- 조건 위배되서 안된다고 나옴
     UPDATE V_mem01
        SET MEM_MILEAGE = 3300
      WHERE LOWER(MEM_ID)='v001'  

6) MEMBER 테이블에서  'V001'회원의 마일리지(4300)를 3300으로 변경  --테이블을 변경하면 변경됨.
  UPDATE MEMBER
     SET MEM_MILEAGE=3300
   WHERE LOWER(MEM_ID)='v001'
   
   SELECT * FROM V_mem01;
   
   