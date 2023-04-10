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
into emp values(101, '이나영', 10)
into emp values(102, '조윤겸', 10)
into emp values(103, '김경남', 10)
into emp values(104, '정희철', 10)
into emp values(500, '최병준', null)
into emp values(301, '박제현', 30)
into emp values(302, '박민하', 30)
into emp values(501, '김기태', null)
select * from dual;

insert all
into dept values(10, '1학년부')
into dept values(20, '2학년부')
into dept values(30, '3학년부')
select * from dual;

select * from emp inner join dept on emp.dept_no = dept.dept_no; --inner join(속성명이 다를 때)
select * from emp natural join dept; --natural join
select * from emp inner join dept using(dept_no); --inner join 2(속성명이 같을 때

select * from emp left outer join dept using(dept_no);
select * from emp right outer join dept using(dept_no);
select * from emp full outer join dept using(dept_no);