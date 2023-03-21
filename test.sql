create table book(
  	bookid number primary key,
 	bookname varchar2(20),
  	publisher varchar2(20),
  	price number
  	);

insert into book values(1, '축구의 역사', '굿스포츠', 7000);
insert into book values(2, '축구아는 여자', '나무수', 13000);
insert into book values(3, '축구의 이해', '대한미디어', 22000);

CREATE TABLE customer(
    custid NUMBER PRIMARY KEY,
    custname VARCHAR2(20),
    address VARCHAR2(25),
    phone VARCHAR2(20)
    );
    
INSERT INTO customer VALUES(1, '박지성', '영국 맨체스터', '000-5000-0001');
INSERT INTO customer VALUES(2, '김연아', '대한민국 서울', '000-6000-0001');
INSERT INTO customer VALUES(3, '장미란', '대한민국 강원도', '000-7000-0001');

CREATE TABLE orders(
    orderid NUMBER,
    custid NUMBER,
    bookid NUMBER,
    saleprice NUMBER,
    orderdate DATE,
    PRIMARY KEY (orderid),
    FOREIGN KEY (custid) REFERENCES customer(custid)
    );

    
INSERT INTO orders VALUES(1, 1, 1, 6000, TO_DATE('2014-07-01', 'yyyy-mm-dd'));
INSERT INTO orders VALUES(2, 1, 3, 21000, TO_DATE('2014-07-03', 'yyyy-mm-dd'));
INSERT INTO orders VALUES(3, 2, 5, 8000, TO_DATE('2014-07-03', 'yyyy-mm-dd'));

select * from book;
select * from customer;
select * from orders;