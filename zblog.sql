#创建blogs数据库
CREATE DATABASE blogs;

#使用数据库blogs
USE blogs;

#创建数据表：用户表 tbl_user
#编号id，用户角色rid，用户名username，密码password，邮箱email，
#create_time创建时间，modify_time修改时间，
#is_deleted已删除，is_active已激活令牌token
CREATE TABLE IF NOT EXISTS tbl_user(
	id INT NOT NULL AUTO_INCREMENT,
	rid INT NOT NULL,
	username VARCHAR(50) NOT NULL UNIQUE,
	PASSWORD VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	create_time VARCHAR(100),
	modify_time VARCHAR(100),
	is_deleted INT,
	is_active INT,
	token VARCHAR(100),
	PRIMARY KEY (id)
);

#创建数据表：用户表 tbl_blog
#编号id，作者author，标题title，主题theme
#create_time创建时间，modify_time修改时间，
#is_active可见，location文件地址
CREATE TABLE IF NOT EXISTS tbl_blog(
	id INT NOT NULL AUTO_INCREMENT,
	author VARCHAR(50) NOT NULL,
	title VARCHAR(50) NOT NULL UNIQUE,
	theme VARCHAR(50) NOT NULL,
	create_time VARCHAR(50),
	modify_time VARCHAR(50),
	is_active INT,
	location VARCHAR(100),
	PRIMARY KEY (id)
);

#删除表tbl_user
DROP TABLE tbl_user;
#删除表tbl_blog
DROP TABLE tbl_blog;

#插入用户数据进表tbl_user
INSERT INTO tbl_user(id, rid, username, PASSWORD, email, create_time, modify_time, is_deleted, is_active, token) VALUES
(1, 0, "zekio", "1234", "zz@aa.com", "2020-11-19 13:07", "", 0, 0, "3r23fwfg4g4g4");

#插入用户数据进表tbl_blog
INSERT INTO tbl_blog(id, author, title, theme, create_time, modify_time, is_active, location) VALUES
(1, "zekio", "Java基础知识", "java", "2020-11-19 13:07", "", 0, "static/blog/md/Java_basic.md");
INSERT INTO tbl_blog(id, author, title, theme, create_time, modify_time, is_active, location) VALUES
(2, "zekio", "Springboot基础知识", "java", "2020-11-20 13:07", "", 0, "static/blog/md/Java_springboot.md");
INSERT INTO tbl_blog(id, author, title, theme, create_time, modify_time, is_active, location) VALUES
(3, "zekio", "Vue基础知识", "js", "2020-11-20 13:07", "", 0, "static/blog/md/Vue_basic.md");
INSERT INTO tbl_blog(id, author, title, theme, create_time, modify_time, is_active, location) VALUES
(4, "zekio", "C基础知识", "C", "2020-11-28 13:07", "", 0, "static/blog/md/Vue_basic.md");
INSERT INTO tbl_blog(id, author, title, theme, create_time, modify_time, is_active, location) VALUES
(5, "zekio", "C++基础知识", "C", "2020-12-28 13:07", "", 0, "static/blog/md/Vue_basic.md");
INSERT INTO tbl_blog(id, author, title, theme, create_time, modify_time, is_active, location) VALUES
(6, "zekio", "Python基础知识", "Python", "2020-11-28 13:07", "", 0, "static/blog/md/Vue_basic.md");