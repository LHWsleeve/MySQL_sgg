USE myemployees;
SELECT
	MAX( salary ),
	MIN( salary ),
	AVG( salary ),
	SUM( salary ),
	job_id 
FROM
	employees 
GROUP BY
	job_id 
ORDER BY
	job_id;
SELECT
	MIN( salary ),
	manager_id 
FROM
	employees 
GROUP BY
	manager_id 
HAVING
	MIN( salary ) > 6000 SELECT
	department_id,
	COUNT( * ),
	AVG( salary ) 
FROM
	employees 
WHERE
	department_id IS NOT NULL 
GROUP BY
	department_id 
ORDER BY
	AVG( salary ) DESC;
SELECT
	COUNT( * ),
	job_id 
FROM
	employees 
GROUP BY
	job_id;
SELECT
	department_name,
	last_name 
FROM
	departments,
	employees 
WHERE
	departments.department_id = employees.department_id;
CREATE TABLE job_grades ( grade_level VARCHAR ( 3 ), lowest_sal INT, highest_sal INT );
INSERT INTO job_grades
VALUES
	( 'A', 1000, 2999 );
INSERT INTO job_grades
VALUES
	( 'B', 3000, 5999 );
INSERT INTO job_grades
VALUES
	( 'C', 6000, 9999 );
INSERT INTO job_grades
VALUES
	( 'D', 10000, 14999 );
INSERT INTO job_grades
VALUES
	( 'E', 15000, 24999 );
INSERT INTO job_grades
VALUES
	( 'F', 25000, 40000 );
SELECT
	city 
FROM
	locations l
	LEFT OUTER JOIN departments d ON d.location_id = l.location_id 
WHERE
	d.department_id IS NULL;
SELECT
	e.*,
	d.department_name 
FROM
	departments d
	LEFT OUTER JOIN employees e ON e.department_id = d.department_id 
WHERE
	d.department_name = "SAl" 
	OR d.department_name = "IT";
SELECT
	MIN( salary ) AS salary,
	job_id,
	last_name 
FROM
	employees;
SELECT
	e.last_name,
	e.department_id,
	d.location_id 
FROM
	departments d
	JOIN employees e ON d.department_id = e.department_id 
WHERE
	location_id IN ( 1400, 1700 );
SELECT
	e.*,
	COUNT( * ) 
FROM
	employees e 
GROUP BY
	department_id # 部门,员工,工资
SELECT
	department_name,
	employee_id,
	salary,
	last_name 
FROM
	employees e,
	departments d 
WHERE
	e.department_id = d.department_id #Z的部门
SELECT
	e.department_id 
FROM
	employees e 
WHERE
	e.last_name = "Zlotkey";
SELECT
	* 
FROM
	( SELECT salary, last_name, e.department_id FROM employees e, departments d WHERE e.department_id = d.department_id ) AS bumen 
WHERE
	department_id = ( SELECT department_id FROM employees WHERE last_name = "Zlotkey" );#查询公司名平均工资
SELECT
	AVG( salary ) 
FROM
	employees #比平均平均工资高的工号姓名工资
SELECT
	salary,
	last_name,
	employee_id 
FROM
	employees e 
WHERE
	e.salary > ( SELECT AVG( salary ) FROM employees );#①查询本部门平均工资
SELECT
	AVG( salary ),
	department_id 
FROM
	employees 
GROUP BY
	department_id;#查询>①的员工工号姓名工资
SELECT
	employee_id,
	last_name,
	salary,
	e.department_id 
FROM
	employees e
	INNER JOIN ( SELECT AVG( salary ) ag, department_id FROM employees GROUP BY department_id ) ag_dep ON e.department_id = ag_dep.department_id 
WHERE
	salary > ag_dep.ag;#1.查询姓名中包含字母U的员工
SELECT
	last_name,
	department_id,
	employee_id 
FROM
	employees 
WHERE
	last_name LIKE ( "%u%" );#2， 1并且在相同部门
SELECT
	last_name,
	department_id,
	employee_id 
FROM
	employees 
WHERE
	department_id IN ( SELECT DISTINCT department_id FROM employees WHERE last_name LIKE "%u%" );# location_id1700
SELECT
	l.location_id,
	department_id 
FROM
	locations l
	INNER JOIN departments d ON l.location_id = d.location_id 
WHERE
	l.location_id = 1700;#2 查1700位置员工号
SELECT
	e.employee_id,
	pipei.location_id 
FROM
	(
SELECT
	l.location_id,
	department_id 
FROM
	locations l
	INNER JOIN departments d ON l.location_id = d.location_id 
WHERE
	l.location_id = 1700 
	) AS pipei
	INNER JOIN employees e ON e.department_id = pipei.department_id;#查询KING的工号
SELECT
	employee_id 
FROM
	employees 
WHERE
	last_name = "K_ing";#查查询呗1管的员共姓名和工资
SELECT
	last_name,
	salary 
FROM
	employees 
WHERE
	manager_id IN ( SELECT employee_id FROM employees WHERE last_name = "K_ing" );#查询最高工资
SELECT
	MAX( salary ) salary,
	CONCAT( last_name, " ", first_name ) AS 姓名 
FROM
	employees;
SELECT
	last_name,
	department_id,
	employee_id 
FROM
	employees 
WHERE
	last_name LIKE ( "%u%" ) 
	LIMIT 0,
	5;#库创建
CREATE DATABASE books;#库修改，更改库的字符集
ALTER DATABASE books CHARACTER 
SET gbk;#哭的删除
DROP DATABASE books;#表的创建
CREATE TABLE books ( id INT, #编号
bName VARCHAR ( 20 ), price DOUBLE, authorID INT, publishDate TIMESTAMP );#创建author表
CREATE TABLE author ( id INT, Nmae VARCHAR ( 20 ), nation VARCHAR ( 10 ) );
DESC author USE books;#修改列名
ALTER TABLE books CHANGE COLUMN publishDate pubDate TIMESTAMP;#添加新列
ALTER TABLE author ADD COLUMN annual DOUBLE;
DESC author;
ALTER TABLE author DROP COLUMN annual;
SELECT
	VERSION( );#表的复制
INSERT INTO author
VALUES
	( 1, "xxx", "中国" ),
	( 2, "aaa", "日本" ),
	( 3, "bbb", "美国" ),
	( 4, "ccc", "中国" );#1.仅仅复制表结构
DROP TABLE
IF
	EXISTS copy2;
CREATE TABLE COPY LIKE author;#2.复制表结构和数据
CREATE TABLE copy2 SELECT
* 
FROM
	author;
SELECT
	* 
FROM
	copy3;#只复制部分数据
CREATE TABLE copy3 SELECT
* 
FROM
	author 
WHERE
	nation = "中国";#只复制部分结构
CREATE TABLE copy4 SELECT
id,
nation 
FROM
	author #只select部分字段
	
WHERE
	0;#0或  者设置一个所有人都不满足的条件，无法复制数据
#表级约束：除了非空，默认，其他都支持
#列级约束：除了外键，都支持
#通用表和列级约束
CREATE TABLE stuifo (
id INT PRIMARY KEY,
stuname VARCHAR ( 10 ) NOT NULL,
sex CHAR ( 1 ),
age INT DEFAULT 18,
seat INT UNIQUE,
majorid INT,
CONSTRAINT fk_stuinfo_majorid FOREIGN KEY ( majorid ) REFERENCES major ( majorid ) 
);
CREATE TABLE major ( majorid INT PRIMARY KEY, nmajor VARCHAR ( 20 ) );
DESC major;
DESC stuifo;#主键和唯一的对比：
# 主键
#保证唯一性，不允许为空。允许多个列合并成一个主键，此时多个列每次插入的对应多列数据不能完全相同。
#唯一键
#保证唯一性，允许为空但。一个表中允许设置多个唯一键，但是一个唯一键只允许存在一个NULL
#外键
#1.要求在从表设置外键关系
#2. 要求从表的外键列类型和主表的关联列类型要求一致或兼容，名称无所谓
#3.主表的关联列必须是一个key（唯一键或主键 ）
#4.插入数据时，先插入主表，再插入从表。删除数据时先删除从表，在删除主表。
#修改表时添加约束，直接在末尾加上，非空，默认等约束
SHOW ENGINES;
/*
事务的创建
#隐式事务：事务没有明显的开启和结束的标记比如insert，update，delete语句
#显示事务
#显式事务：事务具有明显的开启和结束的标记前提：必须先设置自动提交功能为禁用
1.
#set autocommit=0；
START TRANSACTION;可选

2.编写事务中的sql语句(SELECT,INSERT,UODATE,SELECT)

3.结束事务
commit；提交事务
rollback；回滚事务
*/#事务步骤
DROP TABLE
IF
	EXISTS account;
CREATE TABLE account ( id INT PRIMARY KEY AUTO_INCREMENT, username VARCHAR ( 20 ), balance DOUBLE );
INSERT INTO account ( username, balance )
VALUES
	( "张无忌", 1000 ),
	( "赵敏", 1000 );

SET autocommit = 0;
START TRANSACTION;
UPDATE account 
SET balance = 1000 
WHERE
	username = "张无忌";
UPDATE account 
SET balance = 1000 
WHERE
	username = "赵敏";#COMMIT;
ROLLBACK;#回滚。（仅仅是类似，实际没提交之前就在表中更改（是否更改要取决于数据库隔离等级））可以理解为再commit和rollback之前，数据库所有的操作都是在内存中，只有确定是提交还是回滚才会放入磁盘文件
SHOW VARIABLES LIKE "autocommit";
/*
#视图
视图：MySQL从5.0.1版本开始提供视图功能。一种虚拟存在的表，行和列的数据来自定义视图的查询中使用的表，并且是在使用视图时动态生成的，只保存了sql逻辑，不保存查询结果
应用场景：
-☆ 多个地方用到同样的查询结果
-★该查询结果使用的sql语句较复杂

优点
1.实现sql语句的重用
2.·简化复杂sql操作
3.保护数据，提高安全性
*/
USE myemployees;
DESC departments;
DESC employees;#创建视图
CREATE VIEW v1 AS SELECT
last_name,
department_name,
job_title 
FROM
	employees e
	JOIN departments d ON e.department_id = d.department_id
	JOIN jobs j ON j.job_id = e.job_id;
SELECT
	* 
FROM
	v1;
/*
视图的修改ew
1，create or replace view 视图名
AS

2. alter view 视图名
AS

*/

/*
删除视图
语法 drop view 视图名，视图名...
*/

/*
查看视图（结构）
DESC 视图名
show create view  视图名
*/

/*
视图更新（数据）
1.插入
INSERT INTO 视图名 VALUES （）；视图和原始表都会插入该数据
2.修改
UPDATE 视图名 SET last_name="",WHERE last_name="";视图原始表均修改
3.删除
DELETE FROM 视图名 WHERE last_name="";均删除

#具备以下特点的视图不允许增删改
包含分组函数，DISTINCT,GROUP BY,HAVING,UNION,UNION ALL
常量视图
SELECT中包含子查询
JOIN(链接)
FROM一个不能更新的视图
WHERE子句的子查询引用了from子句中的表
*/
