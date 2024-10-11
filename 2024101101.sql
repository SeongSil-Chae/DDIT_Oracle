2024-1011-01)�����ڷ� Ÿ��
  - RAW, BFILE, BLOB
1. RAW
 . 2000BYTE ���� �ڷ�����
 . �ε��� ó�� ����
 . 16������ 2�����·� �ڷ� ����
 �������)
 �÷��� RAW(ũ��)
 
2. BFILE
  . 4GB���� ����
  . �ڷḦ �ܺ� ���丮�� �����ϰ� ���̺��� ��ο� ���ϸ� ����
  . ������ ����� �߻��Ǵ� �ڷ�ó���� ����
 �������)
 �÷��� BFILE
  
3. BLOB
 . 4GB���� ����
 . �ڷḦ ���� ���̺� ����
 . ������ �߻����� �ʴ� �ڷ����忡 ����
 �������)
 �÷��� BLOB
 
 ��뿹)
   CREATE TABLE TEST05(
     COL RAW(2000));
     
  INSERT INTO TEST05 VALUES (HEXTORAW('3DCF'));  
  INSERT INTO TEST05 VALUES('0011110111001111');
 -- HEX: 16����
 -- HEXTORAW: 16������ �������ּ���.
  SELECT * FROM TEST05;     
     
** BFILE Ÿ������ �ڷ� ����
  0) ���̺� ����
  CREATE TABLE TEST06(
   COL BFILE);
   
  1) �������� ����
    D:\A_TeachingMaterial\02_Oracle\work\lupy.jpg
    
  2) ���������� ����� ��θ� ���� ���丮 ��ü ����  -- ���丮 = ����
    CREATE DIRECTORY ���丮�� AS '������';
    
    CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle\work';
    -- ���� TEST_DIR �̰� ���� ���丮 ��θ� ����Ҽ� ����.

    
  3) ������ ����
     INSERT INTO TEST06(COL) VALUES(BFILENAME('TEST_DIR','lupy.jpg'));
     --���Խ� ���丮, ���ϸ� �ֱ� 
     --  ' ' ���ڿ��� ��ҹ��� ����
     
     select * from TEST06;
     
     
     
     
** BLOB Ÿ������ �ڷ� ����
  0) ���̺� ����
  CREATE TABLE TEST07(
   COL BLOB);
   
  1) �������� ����
    D:\A_TeachingMaterial\02_Oracle\work\lupy.jpg
    
  2) ���������� ����� ��θ� ���� ���丮 ��ü ����  -- ���丮 = ����
    CREATE DIRECTORY ���丮�� AS '������';
    
    CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle\work';
    -- ���� TEST_DIR �̰� ���� ���丮 ��θ� ����Ҽ� ����.

    
  3) ������ ���� - ���(�Լ�, ��������, �͸��� ���� ���)
     
     DECLARE  -- ���Ǵ� ���� ���� L_@@@ << ������
       L_DIR    VARCHAR2(20):='TEST_DIR';
       L_FILE   VARCHAR2(30):='lupy.jpg'; -- ���ϸ� 30��
       L_BFILE  BFILE;
       L_BLOB   BLOB;
     BEGIN
       INSERT INTO TEST07(COL) VALUES(EMPTY_BLOB()) RETURN COL INTO L_BLOB;
       
       L_BFILE:=BFILENAME(L_DIR,L_FILE);
       DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
       DBMS_LOB.LOADFROMFILE(L_BLOB, L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
       DBMS_LOB.FILECLOSE(L_BFILE); -- Ŭ���� �Ǿ���.
     END;
     
     select * from TEST07;     
     
     
     