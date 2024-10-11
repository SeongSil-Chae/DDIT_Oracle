2024-1010-01)문자열 자료타입
1. CHAR(크기[BYTE/CHAR])
 - 고정길이 문자열
 - 2000 BYTE까지(한글 한 글자는 3BYTE)
 - 남는공간(오른쪽)은 공백이 저장
 
2. VARCHAR2(크기[BYTE/CHAR])
 - 가변길이 문자열
 - 4000 BYTE까지(한글 한 글자는 3BYTE)
 - 남는공간은 운영체제에게 반납

3. LONG
 - 가변길이 문자열(남는공간은 운영체제에게 반납)
 - 2GB까지
 - 하나의 테이블에 한 컬럼만 선언 가능
 - 기능개선 서비스가 종료 => CLOB가 제공
 
3. CLOB
 - 가변길이 문자열(남는공간은 운영체제에게 반납)
 - 4GB까지 저장 가능
 - 하나의 테이블에 복수개 컬럼선언 가능
 - 일부 기능은 DMBS_LOB에서 제공
 
 
 사용예)
  CREATE TABLE TEST01(
  COL1 CHAR(20),
  COL2 CHAR(20 CHAR),
  COL3 VARCHAR2(2000),
  COL4 VARCHAR(4000 CHAR),
  COL5 LONG,
  COL6 CLOB,
  COL7 CLOB);
 
** 자료삽입
  INSERT INTO 테이블명[(컬럼명,...)] VALUES(값1,...);
   -'컬럼명,...' :· 컬럼명이 기술되면 해당 컬럼들에만 데이터를 저장
                  따라서 컬럼명의 갯수, 순서, 데이터 타입과 VALUES절의 '값'의 갯수, 순서, 데이터 타입은
                  반드시 일치해야함.
                 · 테이블 생성시 컬럼이 'NOT NULL'로 선언되었으면 '컬럼명,...'에서 절대로 생략될 수 없음
   -INTO절에 '컬럼명,...' 이 생략되고 테이블명만 기술되면 VALUES절은 테이블 내에 존재하는 모든 컬럼에
    기술된 순서대로 데이터를 기술해야 함
  
 사용예) 위에서 생성한 테이블 TEST01에 자료를 삽입하시오
   INSERT INTO TEST01 VALUES('대전시 중구', '대전시 중구','대전시 중구','대전시 중구',
                             '대전시 중구','대전시 중구','대전시 중구');
 * : ALL 이라는 뜻
 LENGTH : 글자 길이
 LENGTHB : 바이트 수를 반환하는 크기
 SELECT  *  FROM TEST01;
 
 SELECT LENGTHB(COL1) AS 컬럼1,
        LENGTHB(COL2) AS 컬럼2,
        LENGTHB(COL3) AS 컬럼3,
        LENGTHB(COL4) AS 컬럼4,
     --   LENGTH(COL5) AS 컬럼5,
        LENGTH(COL6) AS 컬럼6,
        LENGTH(COL7) AS 컬럼7
    FROM TEST01;
    
        * 위 셀렉에서 한글 컬럼< 은 별칭임.
        * LONG이 너무 길어서 데이터로 표시 못해서 주석처리
        * CLOB는 너무 길어서 B를 빼고 렝스만 넣음.
 
 
 




