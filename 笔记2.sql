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
SHOW GLOBAL VARIABLES;
SHOW SESSION VARIABLES;
/*
全局变量作用域：服务每次启动为所有的全局变量赋初始值，针对于所有会话（连接）有效，但是不能跨重启。
*/
/*
会话变量作用域：仅仅对当前会话有效
*/
/*
二、自定义变量

说明：变量是用户自定义的，不是由系统的使用步骤：声明赋值
使用（查看、比较、运算等）

1.用户变量

作用域：针对于当前会话（连接），同于会话变量作用域
①声明并初始化：
SET @用户变量名=值；
SET @用户变量名：=值；
SELECET @用户变量名：=值；

②赋值
方式一：通过SET/SELECT 
同初始化，改变值
方式二：
通过 SELECT 字段 INTO @用户变量名 
FROM 表；
③ 查看用户变量值
SELECET @用户变量名;

*/
/*
局部变量
作用域：仅在BEGIN END 内有效，放置在第一句话。
① 声明
DECLARE 变量名 类型；
DECLARE 变量名 类型 DEFAULT 值;

②赋值（无@符号）
方式一：通过SET/SELECT 
SET 局部变量名=值；
SET 局部变量名：=值；
SELECET @用户变量名：=值；

方式二：
通过 SELECT 字段 INTO 局部变量名 
FROM 表；

③ 查看用户变量值
SELECET 局部变量名;


存储过程
1/*
含义：一组预先编译好的sQ语句的集合，理解成批处理语句1、提高代码的重用性
2、简化操作
3、减少了编译次数并且减少了和数据库服务器的连接次数，提高了效率
*/
/*
一、创建语法
CREATE PROCEDURE存储过程名（参数列表）
	存储过程体（一组）
	END
		注意：
		1、参数列表包舍三部分 参数模式 参数名 参数类型
		举例：
		IN stuname VARCHAR（20）
		参数模式：
		IN：该参数可以作为输入，也就是该参数需要调用方传入值
		OUT：该参数可以作为输出，也就是该参数可以作为返回值
		INOUT：该参数既可以作为输入又可以作为输出，也就是该参数既需要传入值，又可以返回值
		
		2、如果存储过程体仅仅只有一句话，BEGIN END可以省略
		存储过程体中的每条sQ1语句的结尾要求必须加分号。
		存储过程的结尾可以使用DELIMITER重新设置语法：
		DELIMITER 结束标记
		DELIMITER $
		
		二、调用语法
CALL存储过程名（实参列表）
*/
/*
函数
含义：一组预先编评好的sg语句的集合，理解成批处理语句1、提高代码的重用性
2、简化操作
3、减少了编译次数并且减少了和数据库服务器的连接次数，提高了效率
区别：
存储过程：可以有0个返回，也可以有多个返回。适合做批量插入，批量更新
函数：有且仅有有1个返回。适合做增删改
*/#一、创建语法
 
CREATE FUNCTION函数名（参数列表）RETURNS 返回类型 
BEGIN
函数体
END 

/*
注意：
1，参数列表包含两部分：参数名参数类型
2·函数体：肯定会有return语句，如果没有会报错如果return语句没有放在函数体的最后也不报错，但不建议return值；
3，函数体中仅有一句话，则可以省略begin end
4，使用delimiter语句设置结束标记
*/#二、调用语法
SELECT函数名（参数列表）


/*
2.case结构
情况1：类似于java中的switch语句，一般用于实现等值判断
语法：
CASE 变量 表达式 字段
WHEN 要判断的值 THEN返回的值或语句；
WHEN 要判断的值 THEN返回的值2或语句；
...
ELSE要返回的值n 或语句；
END CASE;

情况2：类似于java中的多重IF语句，一般用于实现区间判断
CASE
WHEN要判断的条件1 THEN返回的值1或语句；
WHEN要判断的条件2 THEN返回的值2或语句；
...
ELSE要返回的值n或语句；
END CASE;

可以作为表达式，嵌套在其他语句中使用，可以放在任何地方，BEGIN END中或BEGIN END的外面
可以作为独立的语句去使用，只能放在BGIN END中

特点
①可以作为表达式，嵌套在其他语句中使用，可以放在任何地方，BEGIN END中或BEGIN END的外面可以作为独立的语句去使用，只能放在BEGIN END中
②如果WHEN中的值满足或条件成立，则执行对应的THEN后面的语句，并且结束CASE如果都不满足，则执行EISE中的语句或值
③ELSE可以省略，如果ELSE省略了，并且所有WHEN条件都不满足，则返回NULL
*/

#3.if结构
/*
功能：实现多重升支
语法：
if条件1then语句1；
elseif条件2 then语句2；
【else语句n；】
end if；

应用在begin end中
*/


/*循环控制：iterate类似于continue，继续，结束本次循环，继续下一次leave类似于 break，跳出，结束当前所在的循环
*
#1.while
/*
语法：
【标签：】while 循环条件 do 
循环体；
end while【标签】；
*/


#2.1oop
/*
语法：
【标签：】loop循环体；end loop【标签】；
可以用来模拟简单的死循环
*/


#3.repeat
/* 
语法：
【标签：】repeat循环体；
until 结束循环的条件
end repeat【标签】；
*/
