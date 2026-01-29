# 파이썬과 mysql 병합 작업을 위한 sql 페이지.

# 절차 : 일반적으로 system(root)계정은 개발용으로 사용하지 앟는다.
# mysql 에 사용할 id와 pw와 권한을 부여하고 db를 생성한다. 

CREATE USER 'mbc'@'localhost' IDENTIFIED BY '1234';
# 사용자 계정을 생성한다. MBC 는 ID, localhost 는 접속 PC,  1234 는 암호.
# 						  'lhj'@' 192.168.0.154				5678 -> 임효정씨가 154 주소로 들어옴.
# 						  'lhj'@' 192.168.0.%	-> 192.168.0.1~192.168.0.255 , 따라서 1부터 255사이의 범위가 다 들어온다. 
# ip 주소가 바뀌어도 다 들어올 수 있음.alte
# 						  'lhj'@'%' alter		-> 전체 IP(외부에서도 접속됨 -> 보안에 좋지 않음)
# 사용자 계정 생성은 ID가 중복되어도 됨 . -> 대신 접속 PC를 다중처리 할 수 있음alter


# CREATE USER 'mbc'@'192.168.0.%' IDENTIFIED BY '1234';
# CREATE USER 'mbc'@'%' IDENTIFIED BY 'MBC320!!';

# 사용자를 삭제alter
DROP USER 'mbc'@'localhost';

CREATE USER 'mbc'@'localhost' IDENTIFIED BY '1234';

# mbc 사용자에게 lms 권한을 부여한다.==================================================

# 1. 데이터베이스 생성 -> 2. 게정에 권한을 부여.alter
CREATE DATABASE lms default CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
# lms 데이터베이스를 생성			   한국어 지원 ->  utf-8,      대소문자 지운, 안함. 
# COLLATE : 문자 집합에 포함된 문자들을 어떻게 비교하고 정려랄지 정의하는 키워드alter
# 데이터비교시 대소문자 구분, 문자 간의 정렬 순서, 언어별 특수문자 처리 방식 지원
# utf8mb4 : 문자집합
# general : 비교규칙(간단한 일반비교)
# ci : Case Insensitive (대소문자 구분하지 않음)
# COLLATE utf8mb4_bin (대소문자 구분 함)

# mbc라는 계정이 lms를 사용할 수 있게 권한부여========================================

--  GRANT  권한 부여
--  REVOKE 권한 삭제

GRANT ALL PRIVILEGES ON LMS.* TO 'mbc'@'localhost';
#						LMS 는 db.테이블 mbc 는 ID, localhost 는 접속 pc
# ALL PRIVILEGES -> 모든 권한 부여alter
# GRANT SELECT, INSERT ON LMS.* TO '아르바이트생'@'%';
#		 READ	CREATE

# 권한 즉시 반영 FLUSH 권한 즉시 부여 반영====================================================
FLUSH PRIVILEGES;

USE mySQL; # mySQL 최고 db에 접속
SELECT * FROM USER; # mySQL에 사용자의 목록을 볼 수 있음.

# =============================================WHERE절로 조건에 맞는 데이터 조회 연습=========================================================

-- 1. sakila 에 있는 데이터베이스 customer 테이블은 모든 고객으 ㅣ정보 데이터가 저장되있다.
SELECT first_name FROM customer; -- 고객의 first_name  열 

SELECT first_name, last_name FROM customer; -- 고객의 2개 열을 조회

SELECT * FROM customer; -- 고객 모든 정보 열 조회

SHOW COLUMNS FROM sakila.customer; -- customer 테이블 옆 정보 조회

SELECT * FROM customer WHERE first_name = 'MARIA'; -- WHERE 절을 이용한 연산자로 특정한 고유값 조회alter

SELECT * FROM customer WHERE address_id = 200; -- address_id 가 200인 행 조회

SELECT * FROM customer WHERE address_id < 200; -- address_id 가 200미만인 행 조회

SELECT * FROM customer WHERE first_name = 'MARIA'; -- first_name 이 MARIA 인 행 조회

SELECT * FROM customer WHERE first_name < 'MARIA'; -- first_name 이 MARIA 미만인 행 조회

SELECT * FROM payment -- payment_date가 2005-07-09 13:24:07 인 행 조회
WHERE payment_date = '2005-07-09 13:24:07';

SELECT * FROM payment -- payment_date가 2005년 7월 9일 미만인 행 조회
WHERE payment_date < '2005-07-09';

SELECT * FROM customer WHERE address_id between 5 and 10; -- 정해진 범위에 해당하는 데이터 조회

SELECT * FROM payment WHERE payment_date between '2005-06-17' AND '2005-07-19'; -- 2005년 6월 17일 ~ 2005년 7월 19일까지 포함한 날짜 조회

SELECT * FROM payment WHERE payment_date = '2005-07-08 07:33:56'; -- 2005년 7월 8일 07:33:56 이라는 정확한 데이터를 조회

SELECT * FROM customer WHERE first_name between 'm' AND 'o'; -- first_name열에서 M~O범위의 데이터 조회

SELECT * FROM customer 
WHERE first_name NOT between 'm' and 'o'; -- first_name 열에서 M~O 범위의 값을 제외한 데이터 조회

SELECT * FROM city WHERE city = 'Sunnyvale' and country_id = 103; -- 두 조건을 만족하는 데이터 조회

SELECT * FROM payment
WHERE payment_date >= '2005-06-01' and payment_date <= '2005-07-05'; -- 두 개의 비교 연산식을 만족하는 데이터 조회

SELECT * FROM customer
WHERE first_name = 'MARIA' OR first_name = 'LINDA'; -- 한조 건을 만족한 경우 데이터 조회

SELECT * FROM customer
WHERE first_name = 'MARIA' OR first_name = 'LINDA' or first_name = 'NANCY'; -- OR을 두 개 이상 사용한 경우

SELECT * FROM customer
WHERE first_name IN ('MARIA', 'LINDA', 'NANCY'); -- IN을 활용한 데이터 조회

SELECT * FROM city
WHERE country_id = 103 or country_id = 86
	AND city IN ('Cheju','Sunnyvale', 'Dallas'); -- 요구 사항을 반영해 작성한 쿼리문.
    
SELECT * FROM city WHERE country_id = 103; -- 쿼리 풀이 순서 1

SELECT * FROM city
WHERE country_id = 86
	AND city IN ('Cheju','Sunnyvale', 'Dallas'); -- 쿼리 풀이 순서 2
    
SELECT * FROM city 
WHERE country_id = 86 OR country_id = 103
	AND city IN ('Cheju','Sunnyvale', 'Dallas'); -- 쿼리 순서 변경alter
    
SELECT * FROM city
WHERE (country_id=103 OR country_id=86)
	and city IN ('Cheju','Sunnyvale', 'Dallas'); -- 소괄호로 우선순위를 다시 정해 데이터를 조회alter
    
SELECT * FROM city 
WHERE country_id IN (103,86)
	AND city IN ('Cheju','Sunnyvale', 'Dallas'); -- IN AND 결합한 데이터 조회
    
SELECT * FROM address; -- address 에서 null 이 있는 데이터만 조회

SELECT * FROM address WHERE address2 = NULL; -- = 연산자를 사용해 NULL 데이터 조회

SELECT * FROM address WHERE address2 IS NULL; -- address2 열에서 NULL인 데이터 조회

SELECT * FROM address WHERE address2 IS NOT NULL; -- address2 열에서 null이 아닌 데이터 조회

SELECT * FROM address WHERE address2 = ' '; -- address2열에서 NULL 이 아닌 데이터 조회

# ==============ORDER BY절로 데이터 정리하기===========================================================

SELECT * FROM customer ORDER BY first_name; -- first_name 열을 기준으로 정렬
SELECT * FROM customer ORDER BY last_name; -- last_name 열을 기준으로 정렬alter
SELECT * FROM customer ORDER BY store_id, first_name; -- store_id, first_name 순으로 데이터 정렬
SELECT * FROM customer ORDER BY first_name, store_id; -- first_name, store_id 순으로 데이터 정렬
SELECT * FROM customer ORDER BY first_name ASC; -- first_name 열을 오름차순으로 정렬
SELECT * FROM customer ORDER BY first_name DESC; -- first_name 열을 내림차순으로 정렬
SELECT * FROM customer ORDER BY store_id DESC, first_name ASC; -- ASC와 DESC를 조합하여 데이터 정렬
SELECT * FROM customer ORDER BY store_id DESC, first_name ASC LIMIT 10; -- LIMIT으로 상위 10개 의 데이터 조회
SELECT * FROM customer ORDER BY customer_id ASC LIMIT 100, 10; -- LIMIT으로 101번째부터 10개의 데이터 조회
SELECT * FROM customer ORDER BY customer_id ASC LIMIT 10 OFFSET 100; -- 데이터 100개 건너뛰고 101번째부터 데이터 10개 조회

# 와일드카드로 문자열 조회==============================================================================================

SELECT * FROM customer WHERE first_name LIKE 'A%'; -- 첫 번째 글자가 A로 시작하는 데이터 조회
SELECT * FROM customer WHERE first_name LIKE 'AA%'; -- 첫번째 글자가 AA로 시작하는 데이터 조회
SELECT * FROM customer WHERE first_name LIKE '%A'; -- A로 끝나는 모든 데이터 조회
SELECT * FROM customer WHERE first_name LIKE '%RA'; -- RA로 끝나는 모든 데이터 조회
SELECT * FROM customer WHERE first_name LIKE '%A%'; -- A를 포함한 모든 데이터 조회
SELECT * FROM customer WHERE first_name NOT LIKE 'A%'; -- 첫 번째 글자가 A로 시작하지 않는 데이터 조회

WITH CTE (col_1) AS ( -- 특수 문자를 포함한 임의 테이블 생성
SELECT 'A%BC' UNION ALL
SELECT 'A_BC'  UNION ALL
SELECT 'ABC'
)
SELECT * FROM CTE;

WITH CTE (col_1) AS ( -- 특수 문자 % 를 포함한 데이터 조회
SELECT 'A%BC' UNION ALL
SELECT 'A_BC' UNION ALL
SELECT 'ABC'
)
SELECT * FROM CTE WHERE col_1 LIKE '%';

WITH CTE (col_1) AS (
SELECT 'A%BC' UNION ALL
SELECT 'A_BC' UNION ALL
SELECT 'ABC'
)
SELECT * FROM CTE WHERE col_1 LIKE '%#%%' ESCAPE '#'; -- ESCAPE 로 특수 문자 % 를 포함한 데이터 조회

WITH CTE (col_1) AS (
SELECT 'A%BC' UNION ALL
SELECT 'A_BC' UNION ALL
SELECT 'ABC'
)
SELECT * FROM CTE WHERE col_1 LIKE '%!%%' ESCAPE '!'; -- ESCAPE 와 !로 특수문자 %를 포함한 데이터 조회
SELECT * FROM CTE WHERE col_1 LIKE '%!%%' ESCAPE '!'; -- 명령어가 전달될 떄
SELECT * FROM CTE WHERE col_1 LIKE '%%%'; -- 데이터베이스 엔진이 SQL 명령을 수행할 떄

SELECT * FROM customer WHERE first_name LIKE 'A'; -- A로 시작하면서 문자열 길이가 2인 데이터 조회
SELECT * FROM customer WHERE first_name LIKE 'A__'; -- A로 시작하면서 문자열 길이가 3인 데이터 조회
SELECT * FROM customer WHERE first_name LIKE '__A'; -- A로 끝나면서 문자열 길이가 3인 데이터 조회
SELECT * FROM customer WHERE first_name LIKE 'A__A'; -- A로 시작하고 A로 끝나면서 4인 데이터 조회
SELECT * FROM customer WHERE first_name LIKE '_____'; -- 문자열 길이가 5인 데이터 조회
SELECT * FROM customer WHERE first_name LIKE 'A_R%'; -- A_R 로 시작하는 문자열 조회
SELECT * FROM customer WHERE first_name LIKE '__R%'; -- __R로 시작하는 문자열 조회
SELECT * FROM customer WHERE first_name LIKE 'A%R_'; -- A로 시작하면서 R_로 끝나는 문자열 조회
SELECT * FROM customer WHERE first_name REGEXP '^K|N$'; -- ^ | $ 를 사용해 데이터 조회
SELECT * FROM customer WHERE first_name REGEXP 'K[L-N]'; -- [...] 를 사용해 데이터 조회
SELECT * FROM customer WHERE first_name REGEXP 'K[^L-N]'; -- [^...]를 사용해 데이터 조회

SELECT * FROM customer WHERE first_name LIKE '_______' -- 와일드카드 조합으로 데이터 조회
	AND first_name REGEXP 'A[L-N]'
    AND first_name regexp 'O$';
 
# ============GROUP BY 절로 데이터 묶기===============================================================================================

SELECT special_features FROM film GROUP BY special_features; -- special_features 열의 데이터 그룹화
SELECT rating FROM film GROUP BY rating; -- rating 열의 데이터 그룹화
SELECT special_features, rating FROM film group by special_features, rating; --  special_features, rating 열 순서로 데이터를 그룹화(묶기)
SELECT rating, special_features FROM film GROUP BY special_features, rating; -- rating, special_features 열 순서로 데이터를 그룹화
SELECT special_features, COUNT(*) AS cnt FROM film GROUP BY special_features; -- count 함수로 그룹에 속한 데이터 개수 세기

SELECT special_features, rating, COUNT(*) AS cnt FROM film 
GROUP BY special_features, rating ORDER BY special_features, rating, cnt DESC; -- 두 열의 데이터 그룹에 속한 데이터 개수 세기

SELECT special_features, rating, COUNT(*) AS cnt FROM film GROUP BY rating; -- 일부러 오류 메세지 나오게 사용함.

SELECT special_features, COUNT(*) AS cnt FROM film 
GROUP BY special_features
HAVING cnt > 70; -- special_features 열에서 데이터 개수가 70보다 큰 것만 필터링

SELECT special_features, COUNT(*) AS cnt FROM film 
GROUP BY special_features
HAVING rating = 'G'; -- 오류 메세지 나올 것이다. 일부러 오류 뜨게 함. 수정하려고alter

SELECT special_features, rating, COUNT(*) AS cnt FROM film
GROUP BY special_features, rating
HAVING rating = 'R' AND cnt > 8; -- 오류 없이 필터링 한 경우

SELECT DISTINCT special_features, rating FROM film; -- 두 열의 데이터 중복 제거

SELECT special_features, rating FROM film -- group by 절로 두 열을 그룹화한 경우
GROUP BY special_features, rating;

SELECT DISTINCT special_features, rating, COUNT(*) AS cnt FROM film; -- 오류 메세지 나오게 설정함.

# 테이블 생성 조회====================================================================================================================

USE doitsql;

CREATE TABLE doit_increment ( -- 첫 번째 열에 auto_increment 적용 , 자동으로 1씩 증가함.
col_1 INT auto_increment primary key,
col_2 VARCHAR(50),
col_3 int
);

INSERT INTO doit_increment (col_2, col_3) VALUES ('1 자동 입력', 1);
INSERT INTO doit_increment (col_2, col_3) VALUES ('2 자동 입력', 2);

SELECT * FROM doit_increment;

INSERT INTO doit_increment (col_1, col_2, col_3) VALUES (3, '3 자동 입력', 3); -- 자동 입력되는 값과 동일한 값을 입력한 경우
SELECT * FROM doit_increment; -- 자동 입력되는 값과 동일한 값을 입력한 경우

INSERT INTO doit_increment (col_1, col_2, col_3) VALUES (5, '4 건너뛰고 5 자동 입력', 5); -- 자동 입력되는 값보다 큰 값을 입력한 경우
SELECT * FROM doit_increment;

INSERT INTO doit_increment (col_2, col_3) VALUES ('어디까지 입력되었을까요? , 0'); -- 1열을 제외하고 데이터 입력한 경우
SELECT * FROM doit_increment;

SELECT LAST_INSERT_ID(); -- AUTO_INCREMENT 가 적용된 열의 마지막 데이터 조회

ALTER TABLE doit_increment AUTO_INCREMENT = 100;
INSERT INTO doit_increment (col_2, col_3) VALUES ('시작값이 변경되었을까?', 0); -- 자동으로 입력되는 값을 100부터 시작

SET @@auto_increment_increment  = 5;
INSERT INTO doit_increment (col_2, col_3) VALUES ('5씩 증가할까? (1)', 0);
INSERT INTO doit_increment (col_2, col_3) VALUES ('5씩 증가할까? (2)', 0);
SELECT * FROM doit_increment;  -- 자동으로 입력되는 값이 5씩 증가함.


# INSET INTO 와 SELECT로 다른 테이블에 결 과 입력
CREATE TABLE doit_insert_select_from (
col_1 INT,
col_2 VARCHAR(10)
); -- 첫 번째 테이블 생성

CREATE TABLE doit_insert_select_to (
col_1 INT,
col_2 VARCHAR(10)
); --  두 번째 테이블 생성

INSERT INTO doit_insert_select_from VALUES(1, 'Do'); -- 첫 번째 테이블에 데이터를 입력
INSERT INTO doit_insert_select_from VALUES(2, 'It');
INSERT INTO doit_insert_select_from VALUES(3, 'MySQL');

INSERT INTO doit_insert_select_to 
SELECT * FROM doit_insert_select_from; -- 첫 번째 테이블의 데이터를 조회해 두번째 테이블에 입력

SELECT * FROM doit_insert_select_to; -- 두번째 테이블 조회

# ==================================================================================================================================

CREATE TABLE doit_select_new AS (SELECT * FROM doit_insert_select_from);
SELECT * FROM doit_select_new; -- CREATE TABLE로 새 테이블에 결과 입력

CREATE TABLE doit_parent(col_1 INT primary KEY);
CREATE TABLE doit_child(col_1 INT);

ALTER TABLE doit_child
ADD FOREIGN KEY (col_1) REFERENCES doit_parent(col_1); -- 부모 테이블과 자식 테이블 생성

INSERT INTO doit_child VALUES (1); -- 오류 메세지 출력생성함.

INSERT INTO doit_parent VALUES (1);
INSERT INTO doit_child VALUES (1);

SELECT * FROM doit_parent;
SELECT * FROM doit_child; -- 부모 테이블에 데이터 입력 후 자식 테이블에도 데이터 입력

DELETE FROM doit_parent WHERE col_1 = 1; -- 오류 발생시킴. 

DELETE FROM doit_child WHERE col_1 = 1;
DELETE FROM doit_parent WHERE col_1 = 1;

SELECT * FROM doit_child;
SELECT * FROM doit_parent;

DROP TABLE doit_child;
DROP TABLE doit_parent;

CREATE TABLE doit_parent (col_1 INT PRIMARY KEY);
CREATE TABLE doit_child (col_1 INT);

ALTER TABLE doit_child ADD FOREIGN KEY (col_1) 
references doit_parent(col_1);

SHOW CREATE TABLE doit_child;
SHOW CREATE TABLE doit_parent;

SHOW TABLE STATUS WHERE Name IN ('doit_child', 'doit_parent'); -- 데이터 한개 이상을 보고 싶을 경우에 사용함.

ALTER TABLE doit_child
DROP constraint doit_child_ibfk_1;

DROP TABLE doit_parent;

# === MySQL의 데이터 유형 정리하기 ========================================================================================================
# 숫자형 : 정수는 기본적으로 부호를 갖는 signed 형식으로 저장되어 음수와 양수들 동시에 저장할 수 있다.
# 부호를 갖지 않는 unsigned라는 형식도 있는데 이 형식으로 설정되면 0보다 큰 양의 정수를 더 많이 저장할 수 있어alter
# 최대값은 signed 형식보다 2배 커진다.

USE doitsql;
CREATE TABLE doit_float (col_1 FLOAT);
INSERT INTO doit_float VALUES (0.7);

SELECT * FROM doit_float WHERE col_1 = 0.7;

SELECT 10/3;

USE doitsql;
CREATE TABLE doit_char_varchar (
col_1 CHAR(5),
col_2 VARCHAR(5)
);

INSERT INTO doit_char_varchar VALUES ('12345','12345');
INSERT INTO doit_char_varchar VALUES ('abcde','abcde');
INSERT INTO doit_char_varchar VALUES ('가나다라마','가나다라마');
INSERT INTO doit_char_varchar VALUES ('hello','안녕하세요');
INSERT INTO doit_char_varchar VALUES ('李金朴崔任','李金朴崔任');

SELECT
col_1, CHAR_LENGTH(col_1) as char_length, LENGTH(col_1) AS CHAR_BYTE,
col_2, CHAR_LENGTH(col_2) as char_length, LENGTH(col_2) AS CHAR_BYTE
FROM doit_char_varchar;