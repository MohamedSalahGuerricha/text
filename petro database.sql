-- سيتم حذفها petrotesting في حال كان يوجد بالأساس قاعدة بيانات إسمها
DROP DATABASE IF EXISTS petrotesting;
-- petrotesting هنا قمنا بإنشاء قاعدة بيانات جديدة إسمها
CREATE DATABASE petrotesting;
-- و بالتالي أي شيء ننشئه سيتم إنشاؤه فيها petrotesting هنا قمنا بتحديد أن أي إستعلام جديد سيتم تنفيذه على قاعدة البيانات
USE petrotesting;
-- يتألف من 33 أعمده customer هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE customer (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    short_name VARCHAR(20),
    adreess VARCHAR(50),
    NIF VARCHAR(15),
    TIN VARCHAR(15),
    BP VARCHAR(15)
    
);
-- يتألف من عامودين contact Person هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE contactPerson (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(20),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone VARCHAR(20),
    Email VARCHAR(255),
	CONSTRAINT fk_contactPerson_customer FOREIGN KEY (customer_name) REFERENCES job(customer)
);

-- يتألف من 9 أعمدة users هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE driver (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birthdate DATE,
    phone VARCHAR(20),
    vichel VARCHAR(20),--=====================================================
    coment VARCHAR(50),
	CONSTRAINT fk_driver_customer FOREIGN KEY (customer_name) REFERENCES job(customer)
	
);

-- يتألف من 8 أعمده JOB هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE job (
    id INT NOT NULL  AUTO_INCREMENT,
    job_number VARCHAR(6) NOT NULL PRIMARY KEY ,
    customer_name VARCHAR(255),
    PO VARCHAR(20),
    WO VARCHAR(20),
    date_open DATE,
    following VARCHAR(10),
    date_close DATE,
    CONSTRAINT fk_job_customer FOREIGN KEY (customer_name) REFERENCES job(customer)
);
-- يتألف ن 8 أعمدة connection هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE connectionThread (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(15),
    Norm VARCHAR(20),
    content VARCHAR(21844), -- MySQL الرقم 21844 هو أقصى حد ممكن في قواعد بيانات
    publishing_date DATE,
    are_comments_enabled BOOLEAN,
    user_id INT,
    category_id INT
);
-- يتألف من 6 أعمدة Equipment هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE Equipment (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,-- job كمفتاح رئيسي في الجدول id هنا قمنا بتعيين العامود
    job_number VARCHAR(6),
    seriel_number VARCHAR(20) ,
    type_element VARCHAR(50),
    date_dlivred DATE,
    driver_id INT ,
    
    -- countries الموجود في الجدول id هو مفتاح ثانوي بالنسبة للعامود country_id يحدد أن العامود fk_country_user هنا قمنا بوضع قيد بإسم
    CONSTRAINT fk_Equipment_job FOREIGN KEY (job_number) REFERENCES job(job_number)
    CONSTRAINT fk_Equipment_driver FOREIGN KEY (driver_id) REFERENCES job(job_number)

);

-- يتألف من 8 أعمدة posts هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE posts (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    url VARCHAR(2000),
    title VARCHAR(255),
    content VARCHAR(21844), -- MySQL الرقم 21844 هو أقصى حد ممكن في قواعد بيانات
    publishing_date DATE,
    are_comments_enabled BOOLEAN,
    user_id INT,
    category_id INT
);
-- يتألف من 6 أعمدة comments هنا قمنا بإنشاء جدول جديد إسمه
CREATE TABLE comments (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(2000),
    publishing_date DATE,
    parent_comment_id INT,
    user_id INT,
    post_id INT
);
-- genders و users هو بمثابة مفتاح أجنبي بين الجدولين gender_id للإشارة إلى أن العامود fk_users_genders هنا قمنا بوضع قيد إسمه
ALTER TABLE users
ADD CONSTRAINT fk_users_genders
FOREIGN KEY (gender_id) REFERENCES genders(id);
-- roles و users هو بمثابة مفتاح أجنبي بين الجدولين role_id للإشارة إلى أن العامود fk_users_roles هنا قمنا بوضع قيد إسمه
ALTER TABLE users
ADD CONSTRAINT fk_users_roles
FOREIGN KEY (role_id) REFERENCES roles(id);
-- users و photos هو بمثابة مفتاح أجنبي بين الجدولين user_id للإشارة إلى أن العامود fk_photos_users هنا قمنا بوضع قيد إسمه
ALTER TABLE photos
ADD CONSTRAINT fk_photos_users
FOREIGN KEY (user_id) REFERENCES users(id);
-- users و posts هو بمثابة مفتاح أجنبي بين الجدولين user_id للإشارة إلى أن العامود fk_posts_users هنا قمنا بوضع قيد إسمه
ALTER TABLE posts
ADD CONSTRAINT fk_posts_users
FOREIGN KEY (user_id) REFERENCES users(id);
-- categories و posts هو بمثابة مفتاح أجنبي بين الجدولين category_id للإشارة إلى أن العامود fk_posts_categories هنا قمنا بوضع قيد إسمه
ALTER TABLE posts
ADD CONSTRAINT fk_posts_categories
FOREIGN KEY (category_id) REFERENCES categories(id);
-- users و comments هو بمثابة مفتاح أجنبي بين الجدولين user_id للإشارة إلى أن العامود fk_comments_users هنا قمنا بوضع قيد إسمه
ALTER TABLE comments
ADD CONSTRAINT fk_comments_users
FOREIGN KEY (user_id) REFERENCES users(id);
-- posts و comments هو بمثابة مفتاح أجنبي بين الجدولين post_id للإشارة إلى أن العامود fk_comments_posts هنا قمنا بوضع قيد إسمه
ALTER TABLE comments
ADD CONSTRAINT fk_comments_posts
FOREIGN KEY (post_id) REFERENCES posts(id);
-- comments الموجود معه في الجدول id هو بمثابة مفتاح أجنبي بالنسبة للعامود parent_comment_id للإشارة إلى أن العامود fk_comments_comments هنا قمنا بوضع قيد إسمه
ALTER TABLE comments
ADD CONSTRAINT fk_comments_comments
FOREIGN KEY (parent_comment_id) REFERENCES comments(id);
-- يجب أن تكون موحدة users الموجود في الجدول username للإشارة إلى أن قيم العامود uidx_users_username هنا قمنا بوضع قيد إسمه
CREATE UNIQUE INDEX uidx_users_username
ON users (username);
-- يجب أن تكون موحدة users الموجود في الجدول email للإشارة إلى أن قيم العامود uidx_users_email هنا قمنا بوضع قيد إسمه
CREATE UNIQUE INDEX uidx_users_email
ON users (email); 
-- يجب أن تكون موحدة photos الموجود في الجدول url للإشارة إلى أن قيم العامود uidx_photos_url هنا قمنا بوضع قيد إسمه
CREATE UNIQUE INDEX uidx_photos_url
ON photos (url); 
-- يجب أن تكون موحدة photos الموجود في الجدول physical_path للإشارة إلى أن قيم العامود uidx_photos_physical_path هنا قمنا بوضع قيد إسمه
CREATE UNIQUE INDEX uidx_photos_physical_path
ON photos (physical_path); 
-- يجب أن تكون موحدة posts الموجود في الجدول url للإشارة إلى أن قيم العامود uidx_posts_url هنا قمنا بوضع قيد إسمه
CREATE UNIQUE INDEX uidx_posts_url
ON posts (url); 