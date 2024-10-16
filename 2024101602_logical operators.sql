2024-1016-02)논리연산자
    - NOT, AND, OR 
    - AND : 범위지정에도 사용

사용예) 마일리지가 2000 이상이면서 직업이 주부인 회원정보를 조회하시오. 
        Alias는 회원번호,회원명,직업,마일리지
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_JOB AS 직업,
               MEM_MILEAGE AS 마일리지
        FROM CSS02.MEMBER
        WHERE MEM_MILEAGE >=2000 AND MEM_JOB='주부'
        ORDER BY MEM_MILEAGE ;
        
사용예) 서울에 거주하거나 여성인 회원정보를 조회하시오
        Alias는 회원번호,회원명,주민등록번호,주소
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_REGNO1 ||' '||MEM_REGNO2 AS 주민등록번호,
               MEM_ADD1||' '|| MEM_ADD2 AS 주소
        FROM CSS02.MEMBER
        WHERE MEM_ADD1 LIKE '서울%' 
        OR (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4');
        -- OR (SUBSTR(MEM_REGN02,1,1) IN '2','4')  위랑 같은 말.   
        
        -- '%서울'   = 앞 글자 뭐든 상관없고 뒤에 서울만 있음 됨.
        -- '서울%'   = 뒷 글자 뭐든 상관없고 앞에 서울만 짤라옴.
        