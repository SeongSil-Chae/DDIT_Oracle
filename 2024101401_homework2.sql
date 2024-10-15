drop table "GOODS";
drop table "CUSTOMERS";
drop table "ORDER_GOODS";
drop table "ORDER_GOODS";
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
    order_num	char(12)		NOT NULL,
    cust_id	number(4)		NOT NULL,
    gid	char(4)		NOT NULL,
	order_qty	number(3)		NULL
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

ALTER TABLE order_goods ADD CONSTRAINT FK_orders_TO_order_goods_2 FOREIGN KEY (
	cust_id
)
REFERENCES customers (
	cust_id
);




사용예) 위에 생성된 테이블에 다음의 자료를 입력하시오
  [상품정보: GOOODS테이블]
--------------------------------------------------
  상품번호         상품명                 가격
  p101           신라면(컵소)             1100
  p102           고소미                  2300
  p201           마우스                  35000
  p202           키보드                  120000
--------------------------------------------------

INSERT INTO GOODS(GID,G_NAME,G_PRICE) VALUES('P101', '신라면(컴소)', 1100);
INSERT INTO GOODS VALUES('P102', '고소미', 2300);
INSERT INTO GOODS(G_NAME,G_PRICE, GID) VALUES('마우스', 35000,'T201' );
INSERT INTO GOODS VALUES('P202', '키보드', 120000);

SELECT * FROM GOODS;

 [고객정보:customers테이블]
 -------------------------------------------------
   고객번호        고객명              주소
   1100           강감찬             대전시 중구 계룡로 846
   1101           이순신             서울시 성북구 장위1동 1110
   1102           박정민             청주시 서원서 장암동 23
   1303           김영호             대전시 대덕구 석봉동
 -------------------------------------------------
 
 INSERT INTO CUSTOMERS VALUES(1100, '강감찬', '대전시 중구 계룡로 846');
 INSERT INTO CUSTOMERS VALUES(1101, '이순신', '서울시 성북구 장위1동');
 INSERT INTO CUSTOMERS VALUES(1102, '박정민', '청주시 서원구 장암동 23');
 INSERT INTO CUSTOMERS VALUES(1303, '김영호', '대전시 대덕구 대덕대로 1555');
 
 SELECT * FROM CUSTOMERS;
 
 COMMIT;
 
 숙제] 다음 자료를 입력하시오.
  ------------------------------------------------------------
    주문번호           회원번호          상품번호         주문수량     
  ------------------------------------------------------------
  202410140001         1102             P102              3
  202410140001         1102             P202              1
  202410140001         1102             P101              5
  202410140002         1104             P202              2
  202410140002         1104             P201              1
  202410140003         1101             P101             10
  ------------------------------------------------------------ 
 
 INSERT INTO ORDER_GOODS VALUES(202410140001, 1102, 'P102', 3);
 INSERT INTO ORDER_GOODS VALUES(202410140001, 1102, 'P202', 1);
 INSERT INTO ORDER_GOODS VALUES(202410140001, 1102, 'P101', 5);
 INSERT INTO ORDER_GOODS VALUES(202410140002, 1104, 'P202', 2);
 INSERT INTO ORDER_GOODS VALUES(202410140002, 1104, 'P201', 1);
 INSERT INTO ORDER_GOODS VALUES(202410140003, 1101, 'P101', 10);
 
 