CREATE TABLE patient(
    p_no NUMBER PRIMARY KEY,
    p_name VARCHAR2(10),
    p_id VARCHAR2(15),
    p_pw VARCHAR2(10),
    p_bd DATE
);

CREATE TABLE doctor(
    d_no NUMBER PRIMARY KEY,
    d_section VARCHAR2(10),
    d_name VARCHAR2(15),
    d_day VARCHAR2(1),
    d_time VARCHAR2(2)
);

CREATE TABLE examination(
    e_no NUMBER PRIMARY KEY,
    e_name VARCHAR2(10)
);

CREATE TABLE reservation(
    r_no NUMBER PRIMARY KEY,
    p_no NUMBER REFERENCES patient(p_no),
    d_no NUMBER REFERENCES doctor(d_no),
    r_section VARCHAR2(10),
    r_date VARCHAR2(14),
    r_time VARCHAR2(10),
    e_no NUMBER REFERENCES examination(e_no)
);

CREATE TABLE sickroom(
    s_no NUMBER PRIMARY KEY,
    s_people NUMBER,
    s_room NUMBER,
    s_roomno VARCHAR2(20)
);

CREATE TABLE hospitalization(
    h_no NUMBER PRIMARY KEY,
    p_no NUMBER REFERENCES patient(p_no),
    s_no NUMBER REFERENCES sickroom(s_no),
    h_bedno NUMBER,
    h_sday VARCHAR2(14),
    h_fday VARCHAR2(14),
    h_meal NUMBER,
    h_amount NUMBER
);

alter table patient add p_first date;
alter table patient drop column p_first;
alter table patient modify p_bd varchar2(20);
alter table patient modify p_no not null;
alter table patient drop primary key;
alter table patient add primary key p_no;

insert into patient values(1, '±è»óÀ±', 'bssm', 1234, '2023-3-22');
insert into patient values(2, 'Ãß¼º¿ì', 'bssm', 1234, '2023-3-22');

delete from patient where p_no=2;
select * from patient;