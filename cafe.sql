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
INTO menu VALUES(1, 'À½·á', '¹Ù´Ò¶ó¶ó¶¼', 5000)
INTO menu VALUES(2, 'Çªµå', '»÷µåÀ§Ä¡', 7000)
INTO menu VALUES(3, '»óÇ°', 'ÄÅ', 17000)
SELECT *
FROM dual;

INSERT INTO menu(m_no, m_group, m_name, m_price)
SELECT 4, 'À½·á','ÄÝµåºê·ç',6000
FROM dual UNION ALL
SELECT 5, '»óÇ°','ÅÒºí·¯',30000
FROM dual UNION ALL
SELECT 6, 'Çªµå','ÄÉÀÍ',8000
FROM dual;

UPDATE menu SET m_price=3000 WHERE m_name='»÷µåÀ§Ä¡';
UPDATE menu SET m_price = m_price*0.9 WHERE m_name='ÅÒºí·¯';
UPDATE menu SET m_name = '¹öºíÆ¼' WHERE m_name LIKE '%¶ó¶¼';

INSERT INTO "user"(u_no, u_id, u_pw, u_name, u_bd, u_point, u_grade)
SELECT 1, '¼Ò¸¶°í1', '1234', '¹Ú¹ÎÇÏ', '0000', 10000, 'gold'
FROM dual UNION ALL
SELECT 2, '¼Ò¸¶°í2', '1234', '±è°æ³²', '0000', 3000, 'silver'
FROM dual UNION ALL
SELECT 3, '¼Ò¸¶°í3', '1234', 'Á¤ÈñÃ¶', '0000', 1000, 'bronze'
FROM dual;

UPDATE "user" SET u_grade = 'gold' WHERE u_point >= 3000;
UPDATE "user" SET u_point = u_point+1000 WHERE u_name LIKE '¹Ú%';
DELETE FROM menu WHERE m_name='ÄÉÀÍ';

SELECT DISTINCT m_group FROM menu;
SELECT m_name FROM menu WHERE m_price >= 8000;
SELECT u_id FROM "user" WHERE u_point BETWEEN 1000 AND 3000;

update "user" set u_grade= 'sliver' where u_name='±è°æ³²'; 
SELECT u_id from "user" where u_grade in('gold', 'sliver');

insert all
into menu values(6, 'À½·á', 'µþ±â¶ó¶¼', 6000)
into menu values(7, 'À½·á', 'µþ±â½º¹«µð', 7000)
into menu values(8, 'À½·á', 'µþ±âÇÁ·ÎÆ¾', 6500)
select * from dual;

select m_price from menu where m_name like '%µþ±â%';