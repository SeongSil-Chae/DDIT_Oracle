2024-1011-01)이진자료 타입
  - RAW, BFILE, BLOB
1. RAW
 . 2000BYTE 까지 자료저장
 . 인덱스 처리 가능
 . 16진수와 2진형태로 자료 저장
 사용형식)
 컬럼명 RAW(크기)
 
2. BFILE
  . 4GB까지 저장
  . 자료를 외부 디렉토리에 저장하고 테이블에는 경로와 파일명만 저장
  . 변경이 빈번히 발생되는 자료처리에 적합
 사용형식)
 컬럼명 BFILE
  
3. BLOB
 . 4GB까지 저장
 . 자료를 직접 테이블에 저장
 . 변경이 발생되지 않는 자료저장에 적합
 사용형식)
 컬럼명 BLOB
 
 사용예)
   CREATE TABLE TEST05(
     COL RAW(2000));
     
  INSERT INTO TEST05 VALUES (HEXTORAW('3DCF'));  
  INSERT INTO TEST05 VALUES('0011110111001111');
 -- HEX: 16진수
 -- HEXTORAW: 16진수로 변경해주세요.
  SELECT * FROM TEST05;     
     
** BFILE 타입으로 자료 저장
  0) 테이블 생성
  CREATE TABLE TEST06(
   COL BFILE);
   
  1) 원본파일 저장
    D:\A_TeachingMaterial\02_Oracle\work\lupy.jpg
    
  2) 원본파일이 저장된 경로를 가진 디렉토리 객체 생성  -- 디렉토리 = 폴더
    CREATE DIRECTORY 디렉토리명 AS '절대경로';
    
    CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle\work';
    -- 이제 TEST_DIR 이걸 쓰면 디렉토리 경로를 사용할수 있음.

    
  3) 데이터 삽입
     INSERT INTO TEST06(COL) VALUES(BFILENAME('TEST_DIR','lupy.jpg'));
     --삽입시 디렉토리, 파일명 넣기 
     --  ' ' 문자열엔 대소문자 구분
     
     select * from TEST06;
     
     
     
     
** BLOB 타입으로 자료 저장
  0) 테이블 생성
  CREATE TABLE TEST07(
   COL BLOB);
   
  1) 원본파일 저장
    D:\A_TeachingMaterial\02_Oracle\work\lupy.jpg
    
  2) 원본파일이 저장된 경로를 가진 디렉토리 객체 생성  -- 디렉토리 = 폴더
    CREATE DIRECTORY 디렉토리명 AS '절대경로';
    
    CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle\work';
    -- 이제 TEST_DIR 이걸 쓰면 디렉토리 경로를 사용할수 있음.

    
  3) 데이터 삽입 - 블록(함수, 프로지셔, 익명블록 등을 사용)
     
     DECLARE  -- 사용되는 변수 선언 L_@@@ << 변수명
       L_DIR    VARCHAR2(20):='TEST_DIR';
       L_FILE   VARCHAR2(30):='lupy.jpg'; -- 파일명 30자
       L_BFILE  BFILE;
       L_BLOB   BLOB;
     BEGIN
       INSERT INTO TEST07(COL) VALUES(EMPTY_BLOB()) RETURN COL INTO L_BLOB;
       
       L_BFILE:=BFILENAME(L_DIR,L_FILE);
       DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
       DBMS_LOB.LOADFROMFILE(L_BLOB, L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
       DBMS_LOB.FILECLOSE(L_BFILE); -- 클로즈 되야함.
     END;
     
     select * from TEST07;     
     
     
     