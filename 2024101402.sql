20241014-02)UPDATE
  - �ڷḦ �����Ҷ� ���
�������)
    UPDATE ���̺��
          SET �÷���=��,
              �÷���=��,
                 :
              �÷���=��
    WHERE ����;
    
    UPDATE ���̺��
          SET (�÷���1,�÷���2,�÷���3,...)=(��1,��2,...|��������)  -- �̷� ���� ���� ���������� �Ἥ ����ϴ� ���.
    WHERE ����;    
    
��뿹) HR������ ������̺�(EMPLOYEES)���� ��� ������ �޿��� 10% �λ��Ͻÿ�.
UPDATE HR.EMPLOYEES
    SET SALARY=SALARY*1.1;
    COMMIT;
    
��뿹) ȸ�����̺�(MEMBER)���� ���ϸ����� 3000������ ȸ���� ��ȸ�Ͽ� ���� 500���� �߰������Ͻÿ�.

  UPDATE CSS02.MEMBER
    SET MEM_MILEAGE=MEM_MILEAGE+500
  WHERE MEM_MILEAGE<=3000;

  SELECT MEM_ID,MEM_NAME,MEM_MILEAGE
    FROM CSS02.MEMBER;
    
    ROLLBACK; -- ������� �ǵ���
    COMMIT;





