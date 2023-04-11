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

-- Book, Customer, Orders 데이터 생성
INSERT INTO book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO customer VALUES (5, '박세리', '대한민국 대전',  NULL);

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
select name from customer where custid in (select custid from orders);

select name from customer where custid in (select custid from orders where bookid in (select bookid from book where publisher = '대한미디어'));

select name, address from customer where exists(select custid from orders);

select bookname from book where exists(select * from orders, customer where orders.custid = customer.custid and book.bookid = orders.bookid and address like '미국%');

select name, address from customer cs where exists (select * from orders where cs.custid = orders.custid); 