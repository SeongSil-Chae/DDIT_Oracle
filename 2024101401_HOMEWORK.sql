drop table "GOODS";
drop table "CUSTOMERS";
drop table "ORDER_GOODS";
drop table orders;

ALTER TABLE order_goods MODIFY GID CHAR(12);
commit;

CREATE TABLE goods (
	gid	char(4)		NOT NULL,
	g_name	Varchar2(50)		NULL,
	g_price	number(6)		NULL
);

CREATE TABLE customers (
	cust_id	number(4)		NOT NULL,
	cust_name	Varchar2(30)		NULL,
	cust_addr	Varchar2(250)		NULL
);

CREATE TABLE orders (
	order_num	char(12)		NOT NULL,
	order_date	date		NULL,
	cust_id	number(4)		NOT NULL
);

CREATE TABLE order_goods (
	gid	char(4)		NOT NULL,
	order_num	char(12)		NOT NULL,
	order_qty	number(3)		NULL,
    cust_id number(4) NOT NULL,  -- �߰�
    CONSTRAINT PK_ORDER_GOODS PRIMARY KEY (gid, order_num)
);

ALTER TABLE goods ADD CONSTRAINT PK_GOODS PRIMARY KEY (
	gid
);

ALTER TABLE customers ADD CONSTRAINT PK_CUSTOMERS PRIMARY KEY (
	cust_id
);

ALTER TABLE orders ADD CONSTRAINT PK_ORDERS PRIMARY KEY (
	order_num
);

ALTER TABLE order_goods ADD CONSTRAINT PK_ORDER_GOODS PRIMARY KEY (
	gid,
	order_num
);

ALTER TABLE order_goods ADD CONSTRAINT FK_goods_TO_order_goods_1 FOREIGN KEY (
	gid
)
REFERENCES goods (
	gid
);

ALTER TABLE order_goods ADD CONSTRAINT FK_orders_TO_order_goods_1 FOREIGN KEY (
	order_num
)
REFERENCES orders (
	order_num
);

ALTER TABLE order_goods ADD CONSTRAINT FK_customers_TO_order_goods FOREIGN KEY (
	cust_id
) REFERENCES customers (cust_id);





��뿹) ���� ������ ���̺� ������ �ڷḦ �Է��Ͻÿ�
  [��ǰ����: GOOODS���̺�]
--------------------------------------------------
  ��ǰ��ȣ         ��ǰ��                 ����
  p101           �Ŷ��(�ż�)             1100
  p102           ��ҹ�                  2300
  p201           ���콺                  35000
  p202           Ű����                  120000
--------------------------------------------------

INSERT INTO GOODS(GID,G_NAME,G_PRICE) VALUES('P101', '�Ŷ��(�ļ�)', 1100);
INSERT INTO GOODS VALUES('P102', '��ҹ�', 2300);
INSERT INTO GOODS(G_NAME,G_PRICE, GID) VALUES('���콺', 35000,'T201' );
INSERT INTO GOODS VALUES('P202', 'Ű����', 120000);

SELECT * FROM GOODS;

 [������:customers���̺�]
 -------------------------------------------------
   ����ȣ        ����              �ּ�
   1100           ������             ������ �߱� ���� 846
   1101           �̼���             ����� ���ϱ� ����1�� 1110
   1102           ������             û�ֽ� ������ ��ϵ� 23
   1303           �迵ȣ             ������ ����� ������
 -------------------------------------------------
 
 INSERT INTO CUSTOMERS VALUES(1100, '������', '������ �߱� ���� 846');
 INSERT INTO CUSTOMERS VALUES(1101, '�̼���', '����� ���ϱ� ����1��');
 INSERT INTO CUSTOMERS VALUES(1102, '������', 'û�ֽ� ������ ��ϵ� 23');
 INSERT INTO CUSTOMERS VALUES(1303, '�迵ȣ', '������ ����� ������ 1555');
 
 SELECT * FROM CUSTOMERS;
 
 COMMIT;
 
 ����] ���� �ڷḦ �Է��Ͻÿ�.
  ------------------------------------------------------------
    �ֹ���ȣ           ȸ����ȣ          ��ǰ��ȣ         �ֹ�����     
  ------------------------------------------------------------
  202410140001         1102             P102              3
  202410140001         1102             P202              1
  202410140001         1102             P101              5
  202410140002         1104             P202              2
  202410140002         1104             P201              1
  202410140003         1101             P101             10
  ------------------------------------------------------------ 
  
 INSERT INTO  VALUES(1102);
  INSERT INTO CUSTOMERS(CUST_ID) VALUES(1104);
   INSERT INTO CUSTOMERS(CUST_ID) VALUES(1112);
 
 INSERT INTO ORDER_GOODS VALUES('P102', '202410140001', 3);
 INSERT INTO ORDER_GOODS VALUES('P202', '202410140001', 1);
 INSERT INTO ORDER_GOODS VALUES('P101', '202410140001', 5);
 INSERT INTO ORDER_GOODS VALUES('P202', '202410140002', 2);
 INSERT INTO ORDER_GOODS VALUES('P201', '202410140002', 1);
 INSERT INTO ORDER_GOODS VALUES('P101', '202410140003', 10); 
 
 