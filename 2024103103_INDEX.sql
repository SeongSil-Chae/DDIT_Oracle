2024-1031-03) INDEX
��뿹) ȸ�����̺� ȸ���̸��� ����Ͽ� �ε����� �����Ͻÿ�.
    SELECT *
      FROM MEMBER 
    WHERE MEM_NAME='������'

  CREATE INDEX  idx_mem_name
     ON MEMBER(MEM_NAME);


��뿹) ȸ�����̺��� 2��° �ֹε�� ��ȣ 2���ں��� 3���� ���ڷ� �ε����� ����
   CREATE INDEX idx_regno2 ON MEMBER(SUBSTR(MEM_REGNO2,2,3));
   
   SELECT * 
     FROM MEMBER
    WHERE SUBSTR(MEM_REGNO2,2,3) = '458'





