CREATE TABLE menu(
    m_no NUMBER PRIMARY KEY,
    m_group VARCHAR2(10),
    m_name VARCHAR2(30),
    m_price NUMBER
);

CREATE TABLE "user"(
    u_no NUMBER PRIMARY KEY,
    u_id VARCHAR2(20),
    u_pw VARCHAR2(4),
    u_name VARCHAR2(30),
    u_bd VARCHAR2(14),
    u_point NUMBER,
    u_grade VARCHAR2(10)
);

CREATE TABLE orderlist(
    o_no NUMBER PRIMARY KEY,
    o_date DATE,
    u_no NUMBER REFERENCES "user"(u_no),
    m_no NUMBER REFERENCES menu(m_no),
    o_group VARCHAR2(30),
    o_size VARCHAR2(30),
    o_price NUMBER,
    o_count NUMBER,
    o_amount NUMBER
);

CREATE TABLE shopping(
    s_no NUMBER PRIMARY KEY,
    m_no NUMBER REFERENCES menu(m_no),
    s_price NUMBER,
    s_count NUMBER,
    s_size VARCHAR2(30),
    s_amoount NUMBER
);

INSERT ALL
INTO menu VALUES(1, '음료', '바닐라라떼', 5000)
INTO menu VALUES(2, '푸드', '샌드위치', 7000)
INTO menu VALUES(3, '상품', '컵', 17000)
SELECT *
FROM dual;

INSERT INTO menu(m_no, m_group, m_name, m_price)
SELECT 4, '음료','콜드브루',6000
FROM dual UNION ALL
SELECT 5, '상품','텀블러',30000
FROM dual UNION ALL
SELECT 6, '푸드','케익',8000
FROM dual;

UPDATE menu SET m_price=3000 WHERE m_name='샌드위치';
UPDATE menu SET m_price = m_price*0.9 WHERE m_name='텀블러';
UPDATE menu SET m_name = '버블티' WHERE m_name LIKE '%라떼';

INSERT INTO "user"(u_no, u_id, u_pw, u_name, u_bd, u_point, u_grade)
SELECT 1, '소마고1', '1234', '박민하', '0000', 10000, 'gold'
FROM dual UNION ALL
SELECT 2, '소마고2', '1234', '김경남', '0000', 3000, 'silver'
FROM dual UNION ALL
SELECT 3, '소마고3', '1234', '정희철', '0000', 1000, 'bronze'
FROM dual;

UPDATE "user" SET u_grade = 'gold' WHERE u_point >= 3000;
UPDATE "user" SET u_point = u_point+1000 WHERE u_name LIKE '박%';
DELETE FROM menu WHERE m_name='케익';

SELECT DISTINCT m_group FROM menu;
SELECT m_name FROM menu WHERE m_price >= 8000;
SELECT u_id FROM "user" WHERE u_point BETWEEN 1000 AND 3000;

UPDATE "user" SET u_grade= 'sliver' WHERE u_name='김경남'; 
SELECT u_id FROM "user" WHERE u_grade IN('gold', 'sliver');

INSERT ALL
INTO menu VALUES(6, '음료', '딸기라떼', 6000)
INTO menu VALUES(7, '음료', '딸기스무디', 7000)
INTO menu VALUES(8, '음료', '딸기프로틴', 6500)
SELECT * FROM dual;

SELECT m_price FROM menu WHERE m_name LIKE '%딸기%';


SELECT * FROM menu;

UPDATE menu SET m_name='바닐라라떼' WHERE m_name='버블티';
UPDATE menu SET m_price=7000 WHERE m_name='샌드위치';
update menu set m_price=30000 where m_name='텀블러';
DELETE FROM menu WHERE m_no BETWEEN 6 AND 8;

INSERT ALL
INTO menu VALUES(6, '푸드', '케익', 8000)
INTO menu VALUES(7, '음료', '아메리카노', 4000)
INTO menu VALUES(8, '음료', '라떼', 4500)
INTO menu VALUES(9, '음료', '티', 5000)
INTO menu VALUES(10, '푸드', '마카롱', 3000)
INTO menu VALUES(11, '음료', '카페모카', 5500)
INTO menu VALUES(12, '음료', '돌체라떼', 5900)
INTO menu VALUES(13, '음료', '애플망고', 4500)
INTO menu VALUES(14, '푸드', '샐러드', 6000)
INTO menu VALUES(15, '푸드', '베이글', 30000)
INTO menu VALUES(16, '음료', '레몬에이드', 6500)
INTO menu VALUES(17, '음료', '아메리카노', 4000)
INTO menu VALUES(18, '상품', '보온병', 45000)
INTO menu VALUES(19, '상품', '쇼퍼백', 11000)
INTO menu VALUES(20, '상품', '콜드컵', 13000)
SELECT * FROM dual;

SELECT * FROM menu WHERE m_price <= 10000;
select * from menu where m_group in('음료', '푸드');
select m_name, m_price from menu where m_name like '바닐라라떼';
select * from menu where m_name like '%라떼' and m_price>=5000;
select * from menu order by m_price desc;
select * from menu order by m_price asc;

select sum(m_price) from menu;
select count(m_name) from menu;
select max(m_price) from menu;
select min(m_price) from menu;
select avg(m_price) from menu where m_group='음료';
select count(*), m_group from menu group by m_group;
select count(*), m_group from menu group by m_group having count(*) >= 10;