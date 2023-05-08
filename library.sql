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

SELECT NAME FROM customer WHERE custid IN (SELECT custid FROM orders);

SELECT NAME FROM customer WHERE custid IN (SELECT custid FROM orders WHERE bookid IN (SELECT bookid FROM book WHERE publisher = '대한미디어'));

SELECT NAME, address FROM customer WHERE EXISTS(SELECT custid FROM orders);

SELECT bookname FROM book B WHERE EXISTS(SELECT * FROM orders O, customer C WHERE O.custid = C.custid AND B.bookid = O.bookid AND address LIKE '대한민국%');

SELECT NAME, address FROM customer CS WHERE EXISTS (SELECT * FROM orders WHERE CS.custid = orders.custid);







--복습
SELECT NAME FROM customer WHERE custid IN(SELECT custid FROM orders WHERE bookid IN(SELECT bookid FROM book WHERE publisher = '대한미디어'));
SELECT NAME FROM customer CS WHERE EXISTS(SELECT * FROM orders od, book B WHERE CS.custid = od.custid AND od.bookid = B.bookid AND publisher='대한미디어');

SELECT NAME, address
FROM customer CS
WHERE EXISTS(SELECT *
             FROM orders od
             WHERE CS.custid = od.custid);

SELECT SUM(saleprice)
FROM orders
WHERE EXISTS(SELECT *
             FROM customer
             WHERE address LIKE '대한민국%' AND customer.custid = orders.custid);
--박지성이 구매하지 않은 도서의 이름을 구하시오.
SELECT bookname AS "도서 이름"
FROM book bk
WHERE NOT EXISTS(SELECT *
             FROM customer cs, orders od
             WHERE NAME = '박지성' AND bk.bookid = od.bookid AND od.custid = cs.custid);
            
--평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice)
                    from orders);
                   
--각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
select orderid, custid, saleprice
from orders od1
where saleprice > (select avg(saleprice)
                    from orders od2
                    where od1.custid = od2.custid);


select * from orders od1, orders od2 where od1.custid = od2.custid;
--3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
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

--고객별
select name, sum(saleprice)
from orders natural join customer
group by name;

--내장함수
-- -78과 +78의 절대값을 구하시오.
select abs(-78) from dual;
select abs(78) from dual;

--4.875를 소수 첫째 자리까지 반올림한 값을 구하시오.
select round(4.875, 1)
from dual;

--고객별 평균 주문금액을 백 원 단위로 반올림한 값을 구하시오.
select custid "고객번호", round(avg(saleprice), -2) "평균 주문금액"
from orders
group by custid;

--마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
select orderid "주문번호", orderdate "주문일", orderdate+10 "확정일자"
from orders;

--마당서점에 도서를 출고하는 출판사의 총 개수를 구하시오.
select count(distinct publisher) "출판사의 개수"
from book;

--주문하지 않은 고객의 이름을 구하시오.
select name
from customer
where name not in(
    select name
    from customer, orders
    where customer.custid = orders.custid);

--고객별 평균판매액을 구하시오.
--단, 도서의 판매액 평균보다 자신의 구매액의 평균이 더 높은 고객만 구하시오.
select name, avg(saleprice)
from customer natural join orders
group by name
having avg(saleprice) > (
    select avg(saleprice)
    from orders);

--'삼성당' 에서 출판한 도서를 삭제하시오.
delete from book
where publisher like '삼성당';

select * from book;

--출판사 '대한미디어'를 대한출판사'로 이름을 바꾸시오.
update book
set publisher = '대한출판사'
where publisher like '대한미디어';

select * from book;

--출판사에 대한 정보를 저장하는 테이블 Bookcompany(name, address, begin)를 생성하고자 한다.
--name은 기본키며 VARCHAR2(20), address는 VARCHAR2(20), begin은 DATE타입으로 선언하여 생성하시오.
create table Bookcompany(
    name varchar2(20) primary key,
    address varchar2(20),
    begin date
);

insert into bookcompany values('박소마', '부산', to_date('2023-05-01', 'yyyy-mm-dd'));
select * from bookcompany;

--Bookcompany 테이블에 인터넷 주소를 저장하는 webaddress 속성을 varchar(30)으로 추가하시오.
alter table Bookcompany add webaddress varchar(30);

--NULL값 처리
CREATE TABLE mybook(
    bookid NUMBER,
    price NUMBER
);

INSERT INTO mybook VALUES(1, 10000);
INSERT INTO mybook VALUES(2, 20000);
INSERT INTO mybook VALUES(3, NULL);
COMMIT;

--NVL함수
SELECT name, NVL(phone, '연락처 없음')
FROM customer;

--book 테이블에서 '축구'라는 문구가 포함된 자료만 보여주는 뷰
create view vw_book
    as select *
    from book
    where bookname like '%축구%';
    
select * from vw_book;

--주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오.
create view vw_customer
    as select *
    from customer
    where address like '%대한민국%';
    
select * from vw_customer;

--orders테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후,
--'김연아'고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
create view vw_orders
    as select orderid, bookname, name, saleprice
    from customer c, book b, orders o
    where c.custid = o.custid and o.bookid = b.bookid;

select orderid, bookname, saleprice
from vw_orders
where name='김연아';

--vw_customer은 주소가 대한민국인 고객을 보여준다. 이 뷰를 영국을 주소로
--가진 고객으로 변경하시오. phone 속성은 필요 없으므로 포함시키지 마시오.
create or replace view vw_customer
    as select custid, name, address
    from customer
    where address like '%영국%';
    
select * from vw_customer;

--앞서 생성한 뷰 vw_customer를 삭제하시오.
drop view vw_customer;

--(1)판매가격이 20, 000원 이상인 도서의 도서번호, 도서이름, 출판사, 판매가격을 보여주는
--highorders 뷰를 생성하시오.
create view highorders
    as select book.bookid, bookname, name, publisher, saleprice
    from orders, book, customer
    where orders.bookid = book.bookid and orders.custid = customer.custid and saleprice >= 20000;

--(2)생성한 뷰를 이용하여 판매된 도서의 이름과 고객의 이름을 출력하는 SQL문을 작성하시오.
select bookname, name
from highorders;

--(3)highboards 뷰를 변경하고자 한다. 판매가격 속성을 삭제하는 명령을 수행하시오.
--삭제 후 (2)번 SQL문을 다시 수행하시오.
create or replace view highorders
    as select book.bookid, bookname, name, publisher
    from orders, book, customer
    where orders.bookid = book.bookid and orders.custid = customer.custid and saleprice >= 20000;
    
--도서의 가격과 판매가격의 차이가 가장 많은 주문
select *
from orders o, book b, customer c
where o.bookid = b.bookid and o.custid = c.custid and (abs(saleprice-price)) = (select max(abs(saleprice-price))
from orders natural join book);

--전체 고객의 30% 이상이 구매한 도서
select bookname
from book b, customer c, orders o
where b.bookid = o.bookid and o.custid = c.custid
group by bookname
having count(bookname) > (
    select count(custid) from customer) * 0.3;