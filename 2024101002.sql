2024-1010-02)�����ڷ���
   - NUMBER, INTEGER, DECIMAL, BINARY_FLOAT, BINARY_DOUBLE  ����� �����ǳ� ���������δ�
     NUMBER�� �����Ǿ� ����
     
�������)
  NUMBER[(*\P [,S])]
  �� P�� ��ü �ڸ��� (1~38)
  �� S�� �Ҽ��� ������ �ڸ���(-84 ~ 127, dafault�� 0)
  
��뿹)
  CREATE TABLE TEST02(
    COL1 NUMBER,
    COL2 NUMBER(3),
    COL3 NUMBER(3,2),
    COL4 NUMBER(5,2),
    COL5 NUMBER(7,1),
    COL6 NUMBER(7,-1),
    COL7 NUMBER(7,-2),
    COL8 NUMBER(*,2),
    COL9 NUMBER(4,5),
    COL10 NUMBER(4,7),
    COL11 NUMBER(3,4),
    COL12 NUMBER(4,6));
     
  INSERT INTO TEST02 VALUES(456.73, 456.73, 0.73, 456.73, 456.77, 50456.73, 
  12456.73, 12456.7393, 0.01234, 0.0001234, 0.0012, 0.00123789);
  
  INSERT INTO TEST02 VALUES(456.73, 456.73, 0.73, 456.73, 456.77, 50456.73, 
  12456.73, 12456.7393, 0.01234, 0.0001234, 0.0812, 0.00123789);
     
     
   SELECT * FROM TEST02;  
   
   
   CREATE TABLE TEST03(
    COL1 INTEGER,
    COL2 DECIMAL,
    COL3 BINARY_FLOAT,
    COL4 BINARY_DOUBLE);
    --���� ũ�⸦ �˾ƺ��� ���� �غ�. NUMBER�� ����ϸ�� �����ϸ�.
