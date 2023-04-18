CREATE TABLE book(
    bookid NUMBER(2) PRIMARY KEY,
    bookname VARCHAR2(40),
    publisher VARCHAR2(40),
    price NUMBER(8)
);

CREATE TABLE customer(
    custid NUMBER(2) PRIMARY KEY,
    NAME VARCHAR2(40),
    address VARCHAR2(50),
    phone VARCHAR2(20)
);

CREATE TABLE orders(
    orderid NUMBER(2) PRIMARY KEY,
    custid NUMBER(2) REFERENCES customer(custid),
    bookid NUMBER(2) REFERENCES book(bookid),
    saleprice NUMBER(8),
    orderdate DATE
);

-- Book, Customer, Orders ������ ����
INSERT INTO book VALUES(1, '�౸�� ����', '�½�����', 7000);
INSERT INTO book VALUES(2, '�౸�ƴ� ����', '������', 13000);
INSERT INTO book VALUES(3, '�౸�� ����', '���ѹ̵��', 22000);
INSERT INTO book VALUES(4, '���� ���̺�', '���ѹ̵��', 35000);
INSERT INTO book VALUES(5, '�ǰ� ����', '�½�����', 8000);
INSERT INTO book VALUES(6, '���� �ܰ躰���', '�½�����', 6000);
INSERT INTO book VALUES(7, '�߱��� �߾�', '�̻�̵��', 20000);
INSERT INTO book VALUES(8, '�߱��� ��Ź��', '�̻�̵��', 13000);
INSERT INTO book VALUES(9, '�ø��� �̾߱�', '�Ｚ��', 7500);
INSERT INTO book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO customer VALUES (1, '������', '���� ��ü��Ÿ', '000-5000-0001');
INSERT INTO customer VALUES (2, '�迬��', '���ѹα� ����', '000-6000-0001');  
INSERT INTO customer VALUES (3, '��̶�', '���ѹα� ������', '000-7000-0001');
INSERT INTO customer VALUES (4, '�߽ż�', '�̱� Ŭ������', '000-8000-0001');
INSERT INTO customer VALUES (5, '�ڼ���', '���ѹα� ����',  NULL);

INSERT INTO orders VALUES (1, 1, 1, 6000, TO_DATE('2014-07-01','yyyy-mm-dd')); 
INSERT INTO orders VALUES (2, 1, 3, 21000, TO_DATE('2014-07-03','yyyy-mm-dd'));
INSERT INTO orders VALUES (3, 2, 5, 8000, TO_DATE('2014-07-03','yyyy-mm-dd')); 
INSERT INTO orders VALUES (4, 3, 6, 6000, TO_DATE('2014-07-04','yyyy-mm-dd')); 
INSERT INTO orders VALUES (5, 4, 7, 20000, TO_DATE('2014-07-05','yyyy-mm-dd'));
INSERT INTO orders VALUES (6, 1, 2, 12000, TO_DATE('2014-07-07','yyyy-mm-dd'));
INSERT INTO orders VALUES (7, 4, 8, 13000, TO_DATE( '2014-07-07','yyyy-mm-dd'));
INSERT INTO orders VALUES (8, 3, 10, 12000, TO_DATE('2014-07-08','yyyy-mm-dd')); 
INSERT INTO orders VALUES (9, 2, 10, 7000, TO_DATE('2014-07-09','yyyy-mm-dd')); 
INSERT INTO orders VALUES (10, 3, 8, 13000, TO_DATE('2014-07-10','yyyy-mm-dd'));

COMMIT;

SELECT bookname FROM book WHERE price = (SELECT MAX(price) FROM book);

SELECT NAME FROM customer WHERE custid IN (SELECT custid FROM orders);

SELECT NAME FROM customer WHERE custid IN (SELECT custid FROM orders WHERE bookid IN (SELECT bookid FROM book WHERE publisher = '���ѹ̵��'));

SELECT NAME, address FROM customer WHERE EXISTS(SELECT custid FROM orders);

SELECT bookname FROM book B WHERE EXISTS(SELECT * FROM orders O, customer C WHERE O.custid = C.custid AND B.bookid = O.bookid AND address LIKE '���ѹα�%');

SELECT NAME, address FROM customer CS WHERE EXISTS (SELECT * FROM orders WHERE CS.custid = orders.custid);







--����
SELECT NAME FROM customer WHERE custid IN(SELECT custid FROM orders WHERE bookid IN(SELECT bookid FROM book WHERE publisher = '���ѹ̵��'));
SELECT NAME FROM customer CS WHERE EXISTS(SELECT * FROM orders od, book B WHERE CS.custid = od.custid AND od.bookid = B.bookid AND publisher='���ѹ̵��');

SELECT NAME, address
FROM customer CS
WHERE EXISTS(SELECT *
             FROM orders od
             WHERE CS.custid = od.custid);

SELECT SUM(saleprice)
FROM orders
WHERE EXISTS(SELECT *
             FROM customer
             WHERE address LIKE '���ѹα�%' AND customer.custid = orders.custid);
--�������� �������� ���� ������ �̸��� ���Ͻÿ�.
SELECT bookname AS "���� �̸�"
FROM book bk
WHERE NOT EXISTS(SELECT *
             FROM customer cs, orders od
             WHERE NAME = '������' AND bk.bookid = od.bookid AND od.custid = cs.custid);
            
--��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice)
                    from orders);
                   
--�� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.
select orderid, custid, saleprice
from orders od1
where saleprice > (select avg(saleprice)
                    from orders od2
                    where od1.custid = od2.custid);


select * from orders od1, orders od2 where od1.custid = od2.custid;
--3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
select orderid, saleprice
from orders
where saleprice > all (select saleprice
                       from orders
                       where custid=3);
                       
select orderid, saleprice
from orders
where saleprice > (select max(saleprice)
                       from orders
                       where custid=3);

--����
select name, sum(saleprice)
from orders natural join customer
group by name;