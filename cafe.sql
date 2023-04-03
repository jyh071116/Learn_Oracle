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
INTO menu VALUES(1, '����', '�ٴҶ��', 5000)
INTO menu VALUES(2, 'Ǫ��', '������ġ', 7000)
INTO menu VALUES(3, '��ǰ', '��', 17000)
SELECT *
FROM dual;

INSERT INTO menu(m_no, m_group, m_name, m_price)
SELECT 4, '����','�ݵ���',6000
FROM dual UNION ALL
SELECT 5, '��ǰ','�Һ�',30000
FROM dual UNION ALL
SELECT 6, 'Ǫ��','����',8000
FROM dual;

UPDATE menu SET m_price=3000 WHERE m_name='������ġ';
UPDATE menu SET m_price = m_price*0.9 WHERE m_name='�Һ�';
UPDATE menu SET m_name = '����Ƽ' WHERE m_name LIKE '%��';

INSERT INTO "user"(u_no, u_id, u_pw, u_name, u_bd, u_point, u_grade)
SELECT 1, '�Ҹ���1', '1234', '�ڹ���', '0000', 10000, 'gold'
FROM dual UNION ALL
SELECT 2, '�Ҹ���2', '1234', '��泲', '0000', 3000, 'silver'
FROM dual UNION ALL
SELECT 3, '�Ҹ���3', '1234', '����ö', '0000', 1000, 'bronze'
FROM dual;

UPDATE "user" SET u_grade = 'gold' WHERE u_point >= 3000;
UPDATE "user" SET u_point = u_point+1000 WHERE u_name LIKE '��%';
DELETE FROM menu WHERE m_name='����';

SELECT DISTINCT m_group FROM menu;
SELECT m_name FROM menu WHERE m_price >= 8000;
SELECT u_id FROM "user" WHERE u_point BETWEEN 1000 AND 3000;

UPDATE "user" SET u_grade= 'sliver' WHERE u_name='��泲'; 
SELECT u_id FROM "user" WHERE u_grade IN('gold', 'sliver');

INSERT ALL
INTO menu VALUES(6, '����', '�����', 6000)
INTO menu VALUES(7, '����', '���⽺����', 7000)
INTO menu VALUES(8, '����', '��������ƾ', 6500)
SELECT * FROM dual;

SELECT m_price FROM menu WHERE m_name LIKE '%����%';


SELECT * FROM menu;

UPDATE menu SET m_name='�ٴҶ��' WHERE m_name='����Ƽ';
UPDATE menu SET m_price=7000 WHERE m_name='������ġ';
update menu set m_price=30000 where m_name='�Һ�';
DELETE FROM menu WHERE m_no BETWEEN 6 AND 8;

INSERT ALL
INTO menu VALUES(6, 'Ǫ��', '����', 8000)
INTO menu VALUES(7, '����', '�Ƹ޸�ī��', 4000)
INTO menu VALUES(8, '����', '��', 4500)
INTO menu VALUES(9, '����', 'Ƽ', 5000)
INTO menu VALUES(10, 'Ǫ��', '��ī��', 3000)
INTO menu VALUES(11, '����', 'ī���ī', 5500)
INTO menu VALUES(12, '����', '��ü��', 5900)
INTO menu VALUES(13, '����', '���ø���', 4500)
INTO menu VALUES(14, 'Ǫ��', '������', 6000)
INTO menu VALUES(15, 'Ǫ��', '���̱�', 30000)
INTO menu VALUES(16, '����', '�����̵�', 6500)
INTO menu VALUES(17, '����', '�Ƹ޸�ī��', 4000)
INTO menu VALUES(18, '��ǰ', '���º�', 45000)
INTO menu VALUES(19, '��ǰ', '���۹�', 11000)
INTO menu VALUES(20, '��ǰ', '�ݵ���', 13000)
SELECT * FROM dual;

SELECT * FROM menu WHERE m_price <= 10000;
select * from menu where m_group in('����', 'Ǫ��');
select m_name, m_price from menu where m_name like '�ٴҶ��';
select * from menu where m_name like '%��' and m_price>=5000;
select * from menu order by m_price desc;
select * from menu order by m_price asc;

select sum(m_price) from menu;
select count(m_name) from menu;
select max(m_price) from menu;
select min(m_price) from menu;
select avg(m_price) from menu where m_group='����';
select count(*), m_group from menu group by m_group;
select count(*), m_group from menu group by m_group having count(*) >= 10;