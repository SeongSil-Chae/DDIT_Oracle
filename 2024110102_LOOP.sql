2024-1101-02) �ݺ���
 - ����Ŭ�� �ݺ����� LOOP ~ END LOOP, WHILE ~ END LOOP;, FOR ~ END LOOP���� ����
 - �ַ� Ŀ�� ����� ������
1.LOOP ~ END LOOP
 - ���� �⺻�̵Ǵ� �ݺ���������
 - ���ѷ��� ����
  (�������)
   LOOP
     �ݺ���ɹ�(��);
    [EXIT WHEN ����;]
    [�ݺ���ɹ�(��);]
            :
    END LOOP;
    . 'EXIT WHEN ����' : ������ ���̸� �ݺ��� ���

��뿹) �������� 7���� ����Ͻÿ�
  DECLARE
    L_CNT NUMBER:=1;
  BEGIN
    LOOP
    EXIT WHEN L_CNT>9;
    DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT||' = ' || 7*L_CNT);
    L_CNT:= L_CNT+1;
    END LOOP;
  END;
  
  ��뿹) ȸ�����̺��� ������ �����ϴ� ȸ���� ȸ����ȣ, ȸ����, ���ϸ���, �ּҸ�
        ����ϴ� PL/SQL���α׷��� �ۼ��Ͻÿ�
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_MILEAGE AS ���ϸ���,
         MEM_ADD1||' '||MEM_ADD2 AS �ּ�
    FROM MEMBER
   WHERE MEM_ADD1 LIKE '����%'; 
   
  DECLARE
    L_MID MEMBER.MEM_ID%TYPE;
    L_MNAME VARCHAR2(200);
    L_MILE NUMBER:=0;
    L_ADDRESS VARCHAR2(2000);
    
    CURSOR CUR_MEM02 IS
      SELECT MEM_ID,MEM_NAME,MEM_MILEAGE,MEM_ADD1||' '||MEM_ADD2
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '����%';
  BEGIN
    OPEN CUR_MEM02;
    LOOP
      FETCH CUR_MEM02 INTO L_MID,L_MNAME,L_MILE,L_ADDRESS;
      EXIT WHEN CUR_MEM02%NOTFOUND;
      DBMS_OUTPUT.PUT(RPAD(L_MID,6));
      DBMS_OUTPUT.PUT(RPAD(L_MNAME,10));
      DBMS_OUTPUT.PUT(TO_CHAR(L_MILE,'99,999'));
      DBMS_OUTPUT.PUT_LINE('  '||L_ADDRESS);
      DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('ȸ�� �� : '||CUR_MEM02%ROWCOUNT||' ��');
    CLOSE CUR_MEM02;
  END; 

(�������� Ű����� �޾� ó��)  
  ACCEPT P_ADD  PROMPT '�������� 2���ڷ� �Է� : '
  DECLARE
    L_MID MEMBER.MEM_ID%TYPE;
    L_MNAME VARCHAR2(200);
    L_MILE NUMBER:=0;
    L_ADDRESS VARCHAR2(2000);
    
    CURSOR CUR_MEM02(A_ADD VARCHAR2) IS
      SELECT MEM_ID,MEM_NAME,MEM_MILEAGE,MEM_ADD1||' '||MEM_ADD2
        FROM MEMBER
       WHERE MEM_ADD1 LIKE A_ADD||'%';
  BEGIN
    OPEN CUR_MEM02('&P_ADD');
    LOOP
      FETCH CUR_MEM02 INTO L_MID,L_MNAME,L_MILE,L_ADDRESS;
      EXIT WHEN CUR_MEM02%NOTFOUND;
      DBMS_OUTPUT.PUT(RPAD(L_MID,6));
      DBMS_OUTPUT.PUT(RPAD(L_MNAME,10));
      DBMS_OUTPUT.PUT(TO_CHAR(L_MILE,'99,999'));
      DBMS_OUTPUT.PUT_LINE('  '||L_ADDRESS);
      DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('ȸ�� �� : '||CUR_MEM02%ROWCOUNT||' ��');
    CLOSE CUR_MEM02;
  END;   
  
2. WHILE LOOP ~ END LOOP
 - �� ���߾���� WHILE���� ���� ��� ����
 - ������ ���� ���� �� �򰡵� ���� ���̸� �ݺ����(LOOP ~ END LOOP)�� �����ϰ�
   �����̸� WHILE ���� ����� ����
   
(�������)
    WHILE ���� LOOP
      �ݺ�ó�� ��ɹ�(��);
        : 
    END LOOP;
  
  
  3. �Ϲ� FOR��
  - �� ���߾���� FOR���� ���� ��� ����
  - FOR�� ����� ������� �ʱⰪ�� ������ �� ���� ���� ���Ͽ� ���������� �۰ų� ������ 
    �ݺ����(LOOP ~ END LOOP)�� �����ϰ� ũ�� FOR ���� ����� ����
�������) 
  FOR ����� IN [REVERSE]�ʱⰪ..������ LOOP
      �ݺ�ó����ɹ�(��);
            :
  END LOOP;
  
��뿹) �������� 7��
  DECLARE 
  BEGIN
    FOR I IN 1..9 LOOP
      DBMS_OUTPUT.PUT_LINE('7 * '||I||' = '||7*I);
    END LOOP;
  END;
  
  
  
  
  4. Ŀ���� FOR�� 
   - Ŀ���� ���Ǵ� FOR ��
   - FOR���� �̿��Ͽ� Ŀ���� ����ϴ� ��� OPEN, FETCH, CLOSE����� ������.
�������)
  FOR ���ڵ�� IN Ŀ����|in-line ���������� ������ Ŀ������(SELECT��) LOOP
     �ݺ���(��);
        :
  END LOOP;
  . FOR�� �ȿ��� Ŀ���� �÷��� �����ϴ� ���
    => ���ڵ��.Ŀ���÷������� ������
  . ������� ���ڵ���� �ý��ۿ��� ������
  
  
  
  
  
  
  
  
  
  
  