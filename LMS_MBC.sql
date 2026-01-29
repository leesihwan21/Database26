# LMS에 대한 테이블을 생성하고 더미데이터 입력(CRUD)

SHOW DATABASES; # LMS 만 보임.

USE LMS; # LMS를 사용하겠다....alter

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

# 더미데이터 출력
SELECT * FROM members;

# 로그인 할 떄
SELECT * FROM members where uid = 'kkw' and password = '1234' and active = True


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


#  여러 더미데이터들의 값들을 각각 INSERT INTO , VALUES 문을 사용하지 앟고 한번에 
INSERT INTO members (uid, password, name, role, active)
VALUES 
    ('kkw','1234','김기원','admin', true),
    ('lhj','5678','임효정','manager', true),
    ('kdg','1111','김도균','user', true),
    ('ksb','2222','김수빈','user', true),
    ('kjy','3333','김지영','user', true);
    
# ======================================================
    
SELECT * FROM members;

SELECT * FROM members WHERE uid = 'kkw' and password = '1234' and active  = True;
DELETE FROM members WHERE uid = 'kkw';
SELECT * FROM members;
    