2024-1031-03) INDEX
사용예) 회원테이블에 회원이름을 사용하여 인덱스를 구성하시오.
    SELECT *
      FROM MEMBER 
    WHERE MEM_NAME='오성순'

  CREATE INDEX  idx_mem_name
     ON MEMBER(MEM_NAME);


사용예) 회원테이블의 2번째 주민등록 번호 2글자부터 3개의 글자로 인덱스를 구성
   CREATE INDEX idx_regno2 ON MEMBER(SUBSTR(MEM_REGNO2,2,3));
   
   SELECT * 
     FROM MEMBER
    WHERE SUBSTR(MEM_REGNO2,2,3) = '458'





