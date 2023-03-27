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