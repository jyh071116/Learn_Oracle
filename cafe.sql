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