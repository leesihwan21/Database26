# LMS에 대한 테이블을 생성하고 더미데이터 입력(CRUD)

SHOW DATABASES; # LMS 만 보임.

USE LMS; # LMdoit_cross2doit_cross2S를 사용하겠다....alter

DROP TABLE members; # 내가 잘못 만들었을 경우에 삭제

CREATE TABLE members ( # members table 생성한다.
	# 필드명(변수) 타입 권한 옵션
	id 		  INT AUTO_INCREMENT PRIMARY KEY, -- primary key 는 다른 계정과 연동하려고 사용함.
    # 		  정수  자동번호생성기     기본키 (다른테이블과 연결용)
	uid		  VARCHAR(50) NOT NULL UNIQUE,
    #          가변문자 (50자) 공백비허용 유일한 고유값(변하지 않는 값)
    password  VARCHAR(255) NOT NULL, -- NOT NULL은 공백을 허용하지 않겠다.
    name      VARCHAR(50) NOT NULL,
    role	  ENUM('admin', 'manager','user') DEFAULT 'user', -- EMUN 열거 파일
    #        열거타입(괄호안에 글자만 허용할때,)        기본값, 고정값은 유저
    active    BOOLEAN DEFAULT TRUE, -- True는 1, Fasle는 0. (db상에서볼떄)
    #          블린타입  			기본값
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP
    # 생성일      날짜 시간타입  기본값 시스템 시간
);

# FOREIGN KEY 


# 후보키 : 공백이 없고, 유일해야 되는 필드들. (회원에서 id, email, 주민번호, 학번).
# PRIMARY KEY는 기본키로 공백이 없고, 유일해야하고, 인덱싱이 되어있는 옵션.
# 인덱싱은 : db에서 빠른 찾기를 위한 옵션 
# 컴퓨터는 총3개의 저장소가 있고 하드디스크 ssd LAM CPU 안에 캐시.
# 외래키 : 테이블과 테이블을 연결하는 '연결 고리, 외래키를 사용하면 데이터의 일관성을 유지하고, 중복을 줄이는 등 데이터베이스의 무결성을 지키는 데 핵심적인 역할
# 외래키는 자식이고 기본키는 부모
# members가 부모임으로 kkw 계정이 있어야 scores 테이블에 kkw 점수를 넣을 수 있다.
# members 테이블에 id와 scores 테이블에 member_id 는 타입 일치해야한다. (필수)


SELECT * FROM members;

# 로그인 할 떄
SELECT * FROM members where uid = 'kkw' and password = '1234' and active = True;

# 더미데이터 입력
INSERT INTO members (uid, password, name, role, active)
VALUES ('kkw','1234','김기원','admin', true);

# 더미데이터 출력
SELECT * FROM members;

# 더미데이터 수정
UPDATE members set password = '1111' WHERE uid = 'kkw';

# 회원 삭제 및 수정
DELETE FROM members WHERE uid = 'kkw';
UPDATE members set password = '1111' WHERE uid = 'kkw';

# =========================================================================
# 더미데이터 입력
INSERT INTO members (uid, password, name, role, active)
VALUES ('kkw','1234','김기원','admin', true);

# 더미데이터 입력
INSERT INTO members (uid, password, name, role, active)
VALUES ('lhj','5678','임효정','manager', true);

# 더미데이터 입력
INSERT INTO members (uid, password, name, role, active)
VALUES ('kdg','1111','김도균','user', true); 

# 더미데이터 입력
INSERT INTO members (uid, password, name, role, active)
VALUES ('ksb','2222','김수빈','user', true); 

# 더미데이터 입력
INSERT INTO members (uid, password, name, role, active)
VALUES ('kjy','3333','김지영','user', true);

# ======================================================================

#더미데이터 출력
SELECT * FROM members;
SELECT * FROM members WHERE uid = 'kkw' and password = '1234' and active = True;
# 로그인 할 떄

# 더미데이터 수정
UPDATE members set password = '1111' WHERE uid = 'kkw';

# 회원 삭제
DELETE FROM members WHERE uid = 'kkw';
UPDATE members set active = false WHERE uid = 'kkw'; # 회원 비활성화

# =================위에서 했던 것을 혼자서 다시 연습=====================================================

SHOW DATABASES;

USE LMS;

DROP TABLE members;

CREATE TABLE members (
		id		INT AUTO_INCREMENT PRIMARY KEY,
		uid		VARCHAR(50) NOT NULL UNIQUE,
		password VARCHAR(255) NOT NULL,
		name	VARCHAR(50) NOT NULL,
		role	ENUM ('admin','manager','user') DEFAULT 'user',
		active	BOOLEAN DEFAULT TRUE,
		created_at  DATETIME DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM members;

# 더미데이터 입력
INSERT INTO members(uid, password, name, role, active)
VALUES ('KKW','1234','김기원','admin',True);

# 더미데이터 수정
UPDATE members set password = '1111' WHERE uid = 'kkw';

# 더미데이터 삭제
DELETE FROM members WHERE uid = 'kkw';

# 더미데이터 삭제한 결과값 확인 SELECT
SELECT * FROM members;


#  여러 더미데이터들의 값들을 각각 INSERT INTO , VALUES 문을 사용하지 앟고 한번에===========================

INSERT INTO members (uid, password, name, role, active)
VALUES 
    ('kkw','1234','김기원','admin', true),
    ('lhj','5678','임효정','manager', true),
    ('kdg','1111','김도균','user', true),
    ('ksb','2222','김수빈','user', true),
    ('kjy','3333','김지영','user', true);
    
# ======================================================

SHOW DATABASES;

USE LMS;
DROP TABLE scores;
CREATE TABLE scores (
		id INT AUTO_INCREMENT PRIMARY KEY,
		member_id INT NOT NULL,
        korean INT NOT NULL,
        english INT NOT NULL,
        math INT NOT NULL,
        total INT NOT NULL,
        average FLOAT  NOT NULL,
        grade CHAR(1) NOT NULL,
        create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        
        FOREIGN KEY (member_id) REFERENCES members(id)
        );
        
        

INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES (1,99,99,99,297,99, 'A');
INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES (2,88,88,88,264,88,'B');
INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES (3,77,77,77,231,77,'C');
INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES (4,66,66,66,198,66,'F');
INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES (5,80,80,80,240,80,'B');

SELECT * FROM scores; -- scores 전체 출력문.

# 기본 정보 조회(INNER JOIN)
# 성적 데이터가 존재하는 회원만 조회합니다. 이름, 과목, 점수, 평균, 등급을 가져오는 쿼리.

SELECT # AS ?? 필드에 이름을 바꿔준 것. 원래 영어로 나옴.
	m.name AS 이름,
    m.uid AS 아이디,
    s.korean AS 국어,
    s.english AS 영어,
    s.math AS 수학,
    s.total AS 총점,
    s.average AS 평균,
    s.grade AS 등급
    
FROM members m # from 뒤에가 부모. member를 m 이라고 씀.
# Aliasing (별칭) : members m 처럼 테이블 이름 뒤에 한 글자 별칭을 주면 쿼리가 훨씬 간결해짐.

JOIN scores s ON m.id = s.member_id;

# ON 조건: m.id = s.member_id와
# 같이 두 테이블을 연결하는 핵심 키 (PK-K) 를 정확히 지정함.

DELETE FROM scores WHERE member_id = 2; # 꼭 2가 아닐수도 잇음.

# 성적이 없는 회원도 포함 조회 (LEFT JOIN)
# 성적표가 아직 작성되지 않은 회원까지 모두 포함하여 명단을 만들 때 사용한다.
# 성적이 없으면  NULL 로 표기된다.alter

SELECT
	m.name AS 이름,
    m.role AS 역할,
    s.average AS 평균,
    s.grade AS 등급,
    IFNULL(s.grade, '미산출') AS 상태 # 성적이 없으면 '미산출'로 표시
    
FROM members m
LEFT JOIN scores s ON m.id = s.member_id; # LEFT JOIN 왼쪽의 부모만 보여달라

# ============================================================================

SHOW DATABASES;

USE LMS;
DROP TABLE BOARDS;
CREATE TABLE BOARDS (
	id			INT auto_increment PRIMARY KEY,
    member_id	INT NOT NULL,
    title		VARCHAR(200) NOT NULL,
    content		TEXT NOT NULL,
    created_at	DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (member_id) references members(id)
    );


INSERT INTO boards (member_id, title, content)
VALUES (3,'제목1','내용1');
INSERT INTO boards (member_id, title, content)
VALUES (4,'제목4','내용4');
INSERT INTO boards (member_id, title, content)
VALUES (4,'제목5','내용5');
INSERT INTO boards (member_id, title, content)
VALUES (5,'제목6','내용6');

SELECT * FROM boards; # 전체 출력

# 게시글 목록 조회(INNER JOIN)================================
SELECT
	b.id AS 글번호,
    b.title AS 제목,
    m.name AS 작성자,
    b.created_at AS 작성일
    
FROM boards b
INNER JOIN members m ON b.member_id = m.id
ORDER BY b.created_at DESC; -- 최신글 순으로 정렬

# ======================================================

SELECT -- 특정 사용자의글만 조회 (WHERE 절 조합)
	b.id AS 글번호,
    b.title AS 제목,
    m.name AS 작성자, -- members 테이블에서 가져옴.
    b.created_at AS 작성일
    
FROM boards b
JOIN members m ON b.member_id = m.id
WHERE m.uid = 'lhj'; --  특정 아이디를 가진 유저의 글만 필터링

# ====================================================

# 관리자용 : 통계 조회 (GROUP BY 조합)======================
SELECT 
    m.name, 
    m.uid, 
    COUNT(b.id) AS 작성글수 # GROUP BY와 셋트
FROM members m
LEFT JOIN boards b ON m.id = b.member_id
GROUP BY m.id;

# 작성자 이름으로 검색하기 (LIKE 활용)========================
SELECT
	b.id AS 글번호,
    b.title AS 제목,
    m.name AS 작성자,
    b.created_at AS 작성일
FROM boards b
INNER JOIN members m ON b.member_id = m.id
WHERE m.name LIKE '%효정%' -- LIKE 문자열 추출 글자열 앞뒤에 % 붙이면 모든것을 추출한다.
ORDER BY b.created_at DESC; -- ORDER BY 내림차순

# ======================================================

# WHERE m.name LIKE '%검색어%' OR b.title LIKE '%검색어%' -- 제목이나 이름에 있던 것들을 찾을 수 있음.members


SELECT * FROM boards;


SELECT * FROM members;

SELECT * FROM members WHERE uid = 'kkw' and password = '1234' and active  = True;

DELETE FROM members WHERE uid = 'kkw';

SELECT * FROM members;

# =========== JOIN 연습하기 =========================

SHOW TABLES;

USE lms;

DROP TABLE 고객;

DROP TABLE 주문;

-- 1. 고객 테이블 생성
CREATE TABLE 고객 (
    고객번호 INT PRIMARY KEY,
    고객이름 VARCHAR(20)
    );
    
 -- 2. 주문 테이블 생성 (고객번호를 외래키로 설정)
CREATE TABLE 주문 (
    주문번호 INT PRIMARY KEY,
    고객번호 INT,
    상품명 VARCHAR(50),
    주문날짜 DATE,
    FOREIGN KEY (고객번호) REFERENCES 고객(고객번호)
    );
    
-- 고객 정보 입력
INSERT INTO 고객 (고객번호, 고객이름) VALUES (1, '김기원');
INSERT INTO 고객 (고객번호, 고객이름) VALUES (2, '홍길동');

-- 고객 정보 출력문 
SELECT * FROM 고객;

-- 주문 정보 입력 (고객번호 1번인 김기원님이 주문한 것으로 설정)
INSERT INTO 주문 (주문번호, 고객번호, 상품명, 주문날짜) 
VALUES (101, 1, '최신형 노트북', '2026-01-29');

-- 주문 정보 입력 출력문alter
SELECT * FROM 주문;

SELECT -- 예시문. 이거는 출력하면 안되는 문 예시문.
    `고객`.`고객번호`, `고객`.`고객이름`, `주문`.`주문번호`, `주문`.`고객번호`, `주문`.`주문날짜`
FROM `고객`
    INNER JOIN `주문` ON `고객`.`고객번호` = `주문`.`고객번호`;


# ----------------------------------------------------------------

SELECT
    a.customer_id, 
    a.store_id, 
    a.first_name, 
    a.last_name, 
    a.email, 
    a.address_id AS a_address_id, -- 여기서 a.address_id에 별칭을 붙임
    b.address_id AS b_address_id, 
    b.address, 
    b.district, 
    b.city_id, 
    b.postal_code, 
    b.phone, 
    b.location
FROM customer AS a
INNER JOIN address AS b ON a.address_id = b.address_id
WHERE a.first_name = 'ROSA';
# ----------------------------------------------------------------------------------------------------

SELECT -- 내부 조인한 테이블에서 조건에 맞는 데이터 조회
	a.customer_id, a.store_id, a.first_name, a.last_name, a.email, a.address_id AS a_address_id,
	b.address_id AS b_address_id, b.address, b.district, b.city_id, b.postal_code, b.phone, b.location
FROM customer AS a
		INNER JOIN address AS b ON a.address_id = b.address_id
WHERE a.first_name = 'ROSA';
# ----------------------------------------------------------------------------------------------------

SELECT -- 열 이름이 유일하지 않은 경우에 대한 해석

-- FROM customer AS a: customer 테이블을 가져와 , 별명을 a 라고 붙임.
-- INNER JOIN address AS b: address 테이블을 가져와 , 별명을 b 라고 붙임.
-- ON a.address_id = b.address_id => 즉, 합치는 기준이 두 테이블 공통 분모값 address_id 값이 같은 데이터끼리 연결하는 것.
-- WHERE a.first_name = 'ROSA' : 합쳐진 전체 데이터 중에서 이름 (first_name)이 'ROSA'인 사람의 데이터만 골라낸다라는 것.
-- SELECT addres_id : 최종적으로 그 사람의 'address_id' 를 화면에 출력해주는 것.

	address_id
FROM customer AS a 
	INNER JOIN address AS b ON a.address_id = b.address_id
WHERE a.first_name = 'ROSA';


SELECT -- 열 이름이 유일하지 않은 경우에 대한 해석

-- FROM customer AS a: customer 테이블을 가져와 , 별명을 a 라고 붙임.
-- INNER JOIN address AS b: address 테이블을 가져와 , 별명을 b 라고 붙임.
-- ON a.address_id = b.address_id => 즉, 합치는 기준이 두 테이블 공통 분모값 address_id 값이 같은 데이터끼리 연결하는 것.
-- WHERE a.first_name = 'ROSA' : 합쳐진 전체 데이터 중에서 이름 (first_name)이 'ROSA'인 사람의 데이터만 골라낸다라는 것.
-- SELECT addres_id : 최종적으로 그 사람의 'address_id' 를 화면에 출력해주는 것.

	a.address_id
FROM customer AS a 
	INNER JOIN address AS b ON a.address_id = b.address_id
WHERE a.first_name = 'ROSA';

# --------------------------------------------------------------------------------------------------

SELECT -- 2개의 조인 조건으로 조인한 테이블에서 조건에 맞는 데이터 조회
	a.customer_id, a.first_name, a.last_name,
    b.address_id, b.address, b.district, b.postal_code
FROM customer AS a
	INNER JOIN address AS b ON a.address_id = b.address_id, b.last_update
WHERE a.first_name = 'ROSA';

# -------------------------------------------------------------------------------------------------

SELECT -- 3개의 테이블을 조인한 테이블에서 조건에 맞는 데이터 조회
	a.customer_id, a.first_name, a.last_name,
    b.address_id, b.address, b.district, b.postal_code, c.city_id, c.city
FROM customer AS a
	INNER JOIN address AS b ON a.address_id
    INNER JOIN city AS c ON b.city_id = c.city_id
WHERE a.first_name = 'ROSA';

# LEFT OUTER JOIN 을 적용한 예
SELECT
    `고객`.`고객번호`, `고객`.`고객이름`, `주문`.`주문번호`, `주문`.`고객번호`, `주문`.`주문날짜`
FROM `고객`
    INNER JOIN `주문` ON `고객`.`고객번호` = `주문`.`고객번호`;
    
SELECT -- LEFT OUTER JOIN 한 결과 조회
	a.address, a.address_id AS a_address_id, b.address_id AS b_address_id, b.store_id
FROM address AS a
	LEFT OUTER JOIN store AS b ON a.address_id = b.address_id;

# ------------------------------------------------------------------------------------------------
SELECT -- LEFT OUTER JOIN 으로 조회한 결과에서 NULL만 조회
	a.address, a.address_id AS a_address_id,
    b.address_id AS b_address_id, b.store_id
FROM address AS a
	LEFT OUTER JOIN store AS b ON a.address_id = b.address_id
WHERE b.address_id IS NULL;

SELECT -- RIGHT OUTER JOIN 한 결과 조회
	a.address, a.address_id AS a_address_id, 
    b.address_id AS b_address_id, b.store_id
FROM address AS a 
	RIGHT OUTER JOIN store AS b ON a.address_id = b.address_id;
# -----------------------------------------------------------------------------------------

SELECT -- RIGHT OUTER JOIN 으로 조회한 결과에서 NULL만 조회  
	a.address_id AS a_address_id, a.store_id,
    b.address, b.address_id AS b_address_id
FROM store AS a
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE a.address_id IS NULL;

# ----------------------------------------------------------------------
SELECT -- FULL OUTER JOIN 한 결과 조회	
	a.address_id AS a_address_id, a.store_id,
    b.address, b.address_id AS b_address_id
FROM store AS a
	LEFT OUTER JOIN address AS b ON a.address_id = b.address_id

UNION -- 위 아래 두 쿼리 결과를 합치고, 중복된 행은 하나만 남기고 제거. ( 이과정에서 진짜 FULL JOIN 결과가 완성됨)

SELECT
	a.address_id AS a_address_id, a.store_id,
    b.address, b.address_id AS b_address_id
FROM store AS a 
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id;
# ---------------------------------------------------------------------

SELECT -- FULL OUTER JOIN 으로 조회한 결과에서 NULL 만 조회
	a.address_id AS a_address_id, a.store_id,
    b.address, b.address_id AS b_address_Id
FROM store AS a
	LEFT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE b.address_id IS NULL

UNION -- 위 아래 두 쿼리 결과를 합치고, 중복된 행은 하나만 남기고 제거. ( 이과정에서 진짜 FULL JOIN 결과가 완성됨)

SELECT
	a.address_id AS a_address_id, a.store_id,
    b.address, b.address_id AS b_address_id
FROM store AS a
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE a.address_id IS NULL;

# --------------------------------------------------------------------

CREATE TABLE doit_cross1(num INT); -- 샘플데이터 생성 (예시)
CREATE TABLE doit_cross2(name VARCHAR(10)); -- 샘플데이터 생성( 예시)

INSERT INTO doit_cross1 VALUES (1), (2), (3); -- 샘플데이터에 정수를 넣은 값.
INSERT INTO doit_cross2 VALUES ('Do'),('It'),('SQL'); -- 샘플데이터에 이름 문자열을 넣은 VARCHAR NULL이 없다.공백없다.

SELECT -- cross1, cross2 출력한다. CROSS JOIN 을 적용한 쿼리문 실행.
	a.num, b.name
FROM doit_cross1 AS a
	CROSS JOIN doit_cross2 AS b
ORDER BY a.num;

# ----------------------------------------------------------------

SELECT -- WHERE 절을 이용한 CROSS JOIN
	a.num, b.name
FROM doit_cross1 AS a
	CROSS JOIN doit_cross2 AS b
WHERE a.num = 1;

# -------------------------------------------------------------

SELECT a.customer_id AS a_customer_id, b.customer_id AS b_customer_id -- SELF JOIN 을 적용한 쿼리 1
FROM customer AS a
	INNER JOIN customer AS b ON a.customer_id = b.customer_id;
    
SELECT -- SELF JOIN 을 적용한 쿼리 2
	a.payment_id, a.amount, b.payment_id, b.amount, b.amount - a.amount AS profit_amount
FROM payment AS a
	LEFT OUTER JOIN payment AS b ON a.payment_id = b.payment_id -1;
    
# -------------------------------------------------------------

SELECT * FROM customer -- 단일행 서브 쿼리 적용 
WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'ROSA');

SELECT * FROM customer -- 잘못된 단일행 서브 쿼리 적용시 오류 발생 예
WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

SELECT * FROM customer -- IN 을 활용한 다중 행 서브 쿼리 적용 1 
WHERE first_name IN ('ROSA','ANA');

SELECT * FROM customer -- IN 을 활용한 다중 행 서브 쿼리 적용 2
WHERE customer_id IN (SELECT customer_id FROM customer WHERE first_name IN ('ROSA','ANA'));

SELECT -- 테이블 3개를 조인하는 쿼리문
	a.film_id, a.title
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id = b.film_id
    INNER JOIN category AS c ON b.category_id = c.category_id
WHERE c.name = 'Action';

SELECT -- IN 을 활용한 쿼리 적용
	film_id, title
FROM film
WHERE film_id IN (
	SELECT a.film_id
	FROM film_category AS a
		INNER JOIN category AS b ON a.category_id = b.category_id
	WHERE b.name = 'Action'
    );
    
SELECT -- NOT IN 을 활용한 서브 쿼리 적용 	
	film_id, title
FROM film
WHERE film_id NOT IN (
	SELECT a.film_id
    FROM film_category AS a
		inner join category AS b on a.category_id = b.category_id
	WHERE b.name = 'Action'
    );
    
SELECT * FROM customer -- ANY를 활용한 서브 쿼리 적용
WHERE customer_id = ANY (SELECT customer_id FROM customer WHERE first_name IN 
('ROSA','ANA'));


SELECT * FROM customer -- < ANY를 활용한 서브 쿼리 적용
WHERE customer_id < ANY (SELECT customer_id FROM customer WHERE first_name IN
('ROSA','ANA'));

SELECT * FROM customer -- > ANY를 활용한 서브 쿼리 적용
WHERE customer_id > ANY (SELECT customer_id FROM customer WHERE first_name IN
('ROSA','ANA'));
    
SELECT * FROM customer -- EXISTS를 활용한 서브 쿼리 적용, TRUE 를 반환하는 경우
WHERE EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('ROSA','ANA'));

SELECT * FROM customer -- EXISTS를 활용한 서브 쿼리 적용, FALSE 를 반환하는 경우
WHERE EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('KANG'));

SELECT * FROM customer -- NOT EXISTS 를 활용한 서브 쿼리 적용, FALSE 를 반환하는 경우
WHERE NOT EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('KANG'));

SELECT * FROM customer -- ALL 을 활용한 서브 쿼리 적용
WHERE customer_id = ALL (SELECT customer_id FROM customer WHERE first_name IN ('ROSA','ANA'));

SELECT -- 테이블 조인
	a.film_id, a.title, a.special_features, c.name
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id = b.film_id
    INNER JOIN category AS c ON b.category_id = c.category_id
WHERE a.film_id > 10 AND a.film_id < 20;

SELECT -- FROM 절에 서브 쿼리 적용
	a.film_id, a.title, a.special_features, x.name
FROM film AS a 
	INNER JOIN (
    SELECT
		b.film_id, c.name
	FROM film_category AS b
		INNER join category AS c ON b.category_id = c.category_id
	WHERE b.film_id > 10 AND b.film_id < 20) AS x ON a.film_id = x.film_id;

SELECT -- 테이블 조인
	a.film_id, a.title, a.special_features, c.name
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id = b.film_id
    INNER JOIN category AS c ON b.category_id = c.category_id
WHERE a.film_id > 10 AND a.film_id < 20;

SELECT  -- select 절에 서브 쿼리 적용
	a.film_id, a.title, a.special_features, (SELECT c.name FROM film_category as
    b INNER JOIN category AS c ON b.category_id = c.category_id WHERE a.film_id = 
    b.film_id) AS name
FROM film AS a
WHERE a.film_id > 10 AND a.film_id < 20;