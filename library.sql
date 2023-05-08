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

--�����Լ�
-- -78�� +78�� ���밪�� ���Ͻÿ�.
select abs(-78) from dual;
select abs(78) from dual;

--4.875�� �Ҽ� ù° �ڸ����� �ݿø��� ���� ���Ͻÿ�.
select round(4.875, 1)
from dual;

--���� ��� �ֹ��ݾ��� �� �� ������ �ݿø��� ���� ���Ͻÿ�.
select custid "����ȣ", round(avg(saleprice), -2) "��� �ֹ��ݾ�"
from orders
group by custid;

--���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
select orderid "�ֹ���ȣ", orderdate "�ֹ���", orderdate+10 "Ȯ������"
from orders;

--���缭���� ������ ����ϴ� ���ǻ��� �� ������ ���Ͻÿ�.
select count(distinct publisher) "���ǻ��� ����"
from book;

--�ֹ����� ���� ���� �̸��� ���Ͻÿ�.
select name
from customer
where name not in(
    select name
    from customer, orders
    where customer.custid = orders.custid);

--���� ����Ǹž��� ���Ͻÿ�.
--��, ������ �Ǹž� ��պ��� �ڽ��� ���ž��� ����� �� ���� ���� ���Ͻÿ�.
select name, avg(saleprice)
from customer natural join orders
group by name
having avg(saleprice) > (
    select avg(saleprice)
    from orders);

--'�Ｚ��' ���� ������ ������ �����Ͻÿ�.
delete from book
where publisher like '�Ｚ��';

select * from book;

--���ǻ� '���ѹ̵��'�� �������ǻ�'�� �̸��� �ٲٽÿ�.
update book
set publisher = '�������ǻ�'
where publisher like '���ѹ̵��';

select * from book;

--���ǻ翡 ���� ������ �����ϴ� ���̺� Bookcompany(name, address, begin)�� �����ϰ��� �Ѵ�.
--name�� �⺻Ű�� VARCHAR2(20), address�� VARCHAR2(20), begin�� DATEŸ������ �����Ͽ� �����Ͻÿ�.
create table Bookcompany(
    name varchar2(20) primary key,
    address varchar2(20),
    begin date
);

insert into bookcompany values('�ڼҸ�', '�λ�', to_date('2023-05-01', 'yyyy-mm-dd'));
select * from bookcompany;

--Bookcompany ���̺� ���ͳ� �ּҸ� �����ϴ� webaddress �Ӽ��� varchar(30)���� �߰��Ͻÿ�.
alter table Bookcompany add webaddress varchar(30);

--NULL�� ó��
CREATE TABLE mybook(
    bookid NUMBER,
    price NUMBER
);

INSERT INTO mybook VALUES(1, 10000);
INSERT INTO mybook VALUES(2, 20000);
INSERT INTO mybook VALUES(3, NULL);
COMMIT;

--NVL�Լ�
SELECT name, NVL(phone, '����ó ����')
FROM customer;

--book ���̺��� '�౸'��� ������ ���Ե� �ڷḸ �����ִ� ��
create view vw_book
    as select *
    from book
    where bookname like '%�౸%';
    
select * from vw_book;

--�ּҿ� '���ѹα�'�� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�.
create view vw_customer
    as select *
    from customer
    where address like '%���ѹα�%';
    
select * from vw_customer;

--orders���̺� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��,
--'�迬��'���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.
create view vw_orders
    as select orderid, bookname, name, saleprice
    from customer c, book b, orders o
    where c.custid = o.custid and o.bookid = b.bookid;

select orderid, bookname, saleprice
from vw_orders
where name='�迬��';

--vw_customer�� �ּҰ� ���ѹα��� ���� �����ش�. �� �並 ������ �ּҷ�
--���� ������ �����Ͻÿ�. phone �Ӽ��� �ʿ� �����Ƿ� ���Խ�Ű�� ���ÿ�.
create or replace view vw_customer
    as select custid, name, address
    from customer
    where address like '%����%';
    
select * from vw_customer;

--�ռ� ������ �� vw_customer�� �����Ͻÿ�.
drop view vw_customer;

--(1)�ǸŰ����� 20, 000�� �̻��� ������ ������ȣ, �����̸�, ���ǻ�, �ǸŰ����� �����ִ�
--highorders �並 �����Ͻÿ�.
create view highorders
    as select book.bookid, bookname, name, publisher, saleprice
    from orders, book, customer
    where orders.bookid = book.bookid and orders.custid = customer.custid and saleprice >= 20000;

--(2)������ �並 �̿��Ͽ� �Ǹŵ� ������ �̸��� ���� �̸��� ����ϴ� SQL���� �ۼ��Ͻÿ�.
select bookname, name
from highorders;

--(3)highboards �並 �����ϰ��� �Ѵ�. �ǸŰ��� �Ӽ��� �����ϴ� ����� �����Ͻÿ�.
--���� �� (2)�� SQL���� �ٽ� �����Ͻÿ�.
create or replace view highorders
    as select book.bookid, bookname, name, publisher
    from orders, book, customer
    where orders.bookid = book.bookid and orders.custid = customer.custid and saleprice >= 20000;
    
--������ ���ݰ� �ǸŰ����� ���̰� ���� ���� �ֹ�
select *
from orders o, book b, customer c
where o.bookid = b.bookid and o.custid = c.custid and (abs(saleprice-price)) = (select max(abs(saleprice-price))
from orders natural join book);

--��ü ���� 30% �̻��� ������ ����
select bookname
from book b, customer c, orders o
where b.bookid = o.bookid and o.custid = c.custid
group by bookname
having count(bookname) > (
    select count(custid) from customer) * 0.3;