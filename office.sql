CREATE TABLE emp(
    emp_no NUMBER PRIMARY KEY,
    emp_name VARCHAR2(30),
    dept_no NUMBER
);

CREATE TABLE dept(
    dept_no NUMBER PRIMARY KEY,
    dept_name VARCHAR2(30)
);

insert all
into emp values(101, '�̳���', 10)
into emp values(102, '������', 10)
into emp values(103, '��泲', 10)
into emp values(104, '����ö', 10)
into emp values(500, '�ֺ���', null)
into emp values(301, '������', 30)
into emp values(302, '�ڹ���', 30)
into emp values(501, '�����', null)
select * from dual;

insert all
into dept values(10, '1�г��')
into dept values(20, '2�г��')
into dept values(30, '3�г��')
select * from dual;

select * from emp inner join dept on emp.dept_no = dept.dept_no; --inner join(�Ӽ����� �ٸ� ��)
select * from emp natural join dept; --natural join
select * from emp inner join dept using(dept_no); --inner join 2(�Ӽ����� ���� ��

select * from emp left outer join dept using(dept_no);
select * from emp right outer join dept using(dept_no);
select * from emp full outer join dept using(dept_no);