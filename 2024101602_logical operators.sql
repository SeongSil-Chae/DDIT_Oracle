2024-1016-02)��������
    - NOT, AND, OR 
    - AND : ������������ ���

��뿹) ���ϸ����� 2000 �̻��̸鼭 ������ �ֺ��� ȸ�������� ��ȸ�Ͻÿ�. 
        Alias�� ȸ����ȣ,ȸ����,����,���ϸ���
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_JOB AS ����,
               MEM_MILEAGE AS ���ϸ���
        FROM CSS02.MEMBER
        WHERE MEM_MILEAGE >=2000 AND MEM_JOB='�ֺ�'
        ORDER BY MEM_MILEAGE ;
        
��뿹) ���￡ �����ϰų� ������ ȸ�������� ��ȸ�Ͻÿ�
        Alias�� ȸ����ȣ,ȸ����,�ֹε�Ϲ�ȣ,�ּ�
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_REGNO1 ||' '||MEM_REGNO2 AS �ֹε�Ϲ�ȣ,
               MEM_ADD1||' '|| MEM_ADD2 AS �ּ�
        FROM CSS02.MEMBER
        WHERE MEM_ADD1 LIKE '����%' 
        OR (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4');
        -- OR (SUBSTR(MEM_REGN02,1,1) IN '2','4')  ���� ���� ��.   
        
        -- '%����'   = �� ���� ���� ������� �ڿ� ���︸ ���� ��.
        -- '����%'   = �� ���� ���� ������� �տ� ���︸ ©���.
        