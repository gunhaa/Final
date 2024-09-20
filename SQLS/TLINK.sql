--ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
--
---- 계정 생성
--CREATE USER tlink IDENTIFIED BY "tlink1234";
--
---- 권한 부여
--GRANT CONNECT, RESOURCE, CREATE VIEW TO tlink;
--
---- 객체 생성 공간 할당
--ALTER USER tlink DEFAULT TABLESPACE SYSTEM
--QUOTA UNLIMITED ON SYSTEM;

BEGIN
   -- 테이블 삭제
   FOR r IN (SELECT UPPER(table_name) AS table_name FROM user_tables) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE "' || r.table_name || '" CASCADE CONSTRAINTS';
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping table: ' || r.table_name || ' - ' || SQLERRM);
      END;
   END LOOP;

   -- 시퀀스 삭제
   FOR s IN (SELECT UPPER(sequence_name) AS sequence_name FROM user_sequences) LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE "' || s.sequence_name || '"';
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error dropping sequence: ' || s.sequence_name || ' - ' || SQLERRM);
      END;
   END LOOP;
END;
/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- USER 테이블 생성
CREATE TABLE "USER" (
    "USER_NO"      NUMBER            NOT NULL,
    "USER_EMAIL"   VARCHAR2(100)     NOT NULL,
    "USER_PW"      VARCHAR2(100)     NOT NULL,
    "USER_NAME"    VARCHAR2(60)      NOT NULL,
    "USER_PHONE"   VARCHAR2(11)      NULL,  -- 전화번호 NULL 허용
    "USER_ADDR"    VARCHAR2(1000)    NULL,  -- 주소 NULL 허용
    "PROFILE_IMG"  VARCHAR2(1000)    NULL,  -- 프로필 이미지 NULL 허용
    "ENROLL_DATE"  DATE              DEFAULT SYSDATE NULL,
    "ROLE"         CHAR              DEFAULT 'U' NOT NULL,
    "USER_DEL_FL"  CHAR              DEFAULT 'N' NOT NULL,  -- 탈퇴 여부 컬럼 추가
    CONSTRAINT "PK_USER" PRIMARY KEY ("USER_NO"),
    CONSTRAINT "CHK_USER_ROLE" CHECK ("ROLE" IN ('S', 'A', 'U')),  -- ROLE 제약 조건
    CONSTRAINT "CHK_USER_DEL_FL" CHECK ("USER_DEL_FL" IN ('Y', 'N'))  
);

-- 컬럼에 대한 주석 추가
COMMENT ON COLUMN "USER"."USER_NO" IS '사용자 번호';
COMMENT ON COLUMN "USER"."USER_EMAIL" IS '이메일';
COMMENT ON COLUMN "USER"."USER_PW" IS '비밀번호';
COMMENT ON COLUMN "USER"."USER_NAME" IS '이름';
COMMENT ON COLUMN "USER"."USER_PHONE" IS '전화번호';
COMMENT ON COLUMN "USER"."USER_ADDR" IS '주소';
COMMENT ON COLUMN "USER"."PROFILE_IMG" IS '프로필 이미지';
COMMENT ON COLUMN "USER"."ENROLL_DATE" IS '가입일';
COMMENT ON COLUMN "USER"."ROLE" IS '역할';
COMMENT ON COLUMN "USER"."USER_DEL_FL" IS '탈퇴 여부';

-- PROJECT 테이블 생성
CREATE TABLE "PROJECT" (
    "PROJECT_NO"   NUMBER            NOT NULL,
    "PROJECT_TITLE" VARCHAR2(100)     NOT NULL,
    "PROJECT_INFO" VARCHAR2(100)     NOT NULL,
    "CREATE_DATE" DATE  DEFAULT SYSDATE   NOT NULL,
    "MANAGER"      NUMBER            NOT NULL
);

-- 컬럼에 대한 주석 추가
COMMENT ON COLUMN "PROJECT"."PROJECT_NO" IS '프로젝트 번호';
COMMENT ON COLUMN "PROJECT"."PROJECT_TITLE" IS '프로젝트명';
COMMENT ON COLUMN "PROJECT"."PROJECT_INFO" IS '프로젝트 설명';
COMMENT ON COLUMN "PROJECT"."CREATE_DATE" IS '프로젝트 생성일';
COMMENT ON COLUMN "PROJECT"."MANAGER" IS '프로젝트 매니저';

-- 기본 키 제약 조건 추가
ALTER TABLE "PROJECT" ADD CONSTRAINT "PK_PROJECT" PRIMARY KEY ("PROJECT_NO");

-- USER_PROJECT 테이블 생성
CREATE TABLE "USER_PROJECT" (
    "USER_NO"      NUMBER            NOT NULL,
    "PROJECT_NO"   NUMBER            NOT NULL,
    
    CONSTRAINT FK_USER FOREIGN KEY (USER_NO) REFERENCES "USER" (USER_NO) ON DELETE CASCADE,
    CONSTRAINT FK_PROJECT FOREIGN KEY (PROJECT_NO) REFERENCES "PROJECT" (PROJECT_NO) ON DELETE CASCADE

);

-- 컬럼에 대한 주석 추가
COMMENT ON COLUMN "USER_PROJECT"."USER_NO" IS '사용자 번호';
COMMENT ON COLUMN "USER_PROJECT"."PROJECT_NO" IS '프로젝트 번호';

--이메일 인증키 테이블
CREATE TABLE "AUTH_KEY" (
   "AUTH_KEY_NO"   NUMBER      NOT NULL,
   "CODE"   CHAR(6)      NOT NULL,
   "EMAIL"   VARCHAR2(50)      NOT NULL,
   "CREATE_TIME"   DATE   DEFAULT SYSDATE   NOT NULL
);

COMMENT ON COLUMN "AUTH_KEY"."AUTH_KEY_NO" IS '인증키 구분 번호(SEQ_AUTH_KEY_NO)';
COMMENT ON COLUMN "AUTH_KEY"."CODE" IS '코드';
COMMENT ON COLUMN "AUTH_KEY"."EMAIL" IS '이메일';
COMMENT ON COLUMN "AUTH_KEY"."CREATE_TIME" IS '인증 코드 생성 시간';

ALTER TABLE "AUTH_KEY" ADD CONSTRAINT "PK_AUTH_KEY" PRIMARY KEY (
   "AUTH_KEY_NO"
);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_USER_NO NOCACHE;
CREATE SEQUENCE SEQ_PROJECT_NO NOCACHE;
CREATE SEQUENCE SEQ_AUTH_KEY_NO NOCACHE;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE "FILES" (
   "FILE_NO"   NUMBER      NOT NULL,
   "FILE_PATH"   VARCHAR2(300)      NOT NULL,
   "FILE_RENAME"   VARCHAR2(1500)      NOT NULL,
   "FILE_ORIGINAL"   VARCHAR2(1500)      NOT NULL,
   "FILE_ORDER"   NUMBER,
   "FILE_CODE"   NUMBER      NOT NULL,
   "TARGET_NO"   NUMBER      NOT NULL
);

COMMENT ON COLUMN "FILES"."FILE_NO" IS '파일 번호(SEQ_IMG_NO)';
COMMENT ON COLUMN "FILES"."FILE_PATH" IS '파일 저장 폴더 경로';
COMMENT ON COLUMN "FILES"."FILE_RENAME" IS '변경된 파일 이름';
COMMENT ON COLUMN "FILES"."FILE_ORIGINAL" IS '원본 파일 이름';
COMMENT ON COLUMN "FILES"."FILE_ORDER" IS '파일 순서 번호';
COMMENT ON COLUMN "FILES"."FILE_CODE" IS '파일 위치 코드(게시글(1), 채팅(2), 작업(3), 캘린더(4))';
COMMENT ON COLUMN "FILES"."TARGET_NO" IS '각 타입별 시퀀스 번호';

CREATE SEQUENCE SEQ_FILE_NO NOCACHE; -- 파일 번호

CREATE TABLE "NOTICE_COMMENT" (
   "COMMENT_NO"   NUMBER      PRIMARY KEY,
   "COMMENT_CONTENT"   VARCHAR2(4000)      NOT NULL,
   "C_CREATE_DATE"   DATE   DEFAULT SYSDATE   NOT NULL,
   "COMMENT_DEL_FL"  NUMBER   DEFAULT 1   NOT NULL,
   "NOTICE_NO"   NUMBER      NOT NULL,
   "USER_NO"   NUMBER      NOT NULL,
   "PARENT_NO"   NUMBER   
);

COMMENT ON COLUMN "NOTICE_COMMENT"."COMMENT_NO" IS '댓글 번호(SEQ_COMMENT_NO)';
COMMENT ON COLUMN "NOTICE_COMMENT"."COMMENT_CONTENT" IS '댓글 내용';
COMMENT ON COLUMN "NOTICE_COMMENT"."C_CREATE_DATE" IS '댓글 작성일';
COMMENT ON COLUMN "NOTICE_COMMENT"."COMMENT_DEL_FL" IS '댓글 삭제 여부(1 : 삭제X, 2 : 삭제O 3: 상단 고정)';
COMMENT ON COLUMN "NOTICE_COMMENT"."NOTICE_NO" IS '댓글이 작성된 게시글 번호';
COMMENT ON COLUMN "NOTICE_COMMENT"."USER_NO" IS '댓글 작성자 회원 번호';
COMMENT ON COLUMN "NOTICE_COMMENT"."PARENT_NO" IS '부모 댓글 번호';

CREATE SEQUENCE SEQ_COMMENT_NO NOCACHE; -- 댓글 번호

CREATE TABLE "SCHEDULE" (
    SCHEDULE_NO NUMBER PRIMARY KEY, -- 기본 키 설정
    SCHEDULE_TYPE CHAR(2) NOT NULL,
    SCHEDULE_TITLE VARCHAR2(150) NOT NULL,
    START_DATE DATE NOT NULL,
    END_DATE DATE NOT NULL,
    SCHEDULE_CONTENT VARCHAR2(900) NOT NULL,
    USER_NO NUMBER NOT NULL,
    PROJECT_NO NUMBER NOT NULL,
    FOREIGN KEY (PROJECT_NO) REFERENCES PROJECT(PROJECT_NO), -- 외래 키 설정
    FOREIGN KEY (USER_NO) REFERENCES "USER"(USER_NO) -- 외래 키 설정
);

COMMENT ON COLUMN "SCHEDULE"."SCHEDULE_NO" IS '일정 번호(SEQ_SCHEDULE_NO)';
COMMENT ON COLUMN "SCHEDULE"."SCHEDULE_TYPE" IS '일정 타입(일정 1 연가 2 병가 3)';
COMMENT ON COLUMN "SCHEDULE"."SCHEDULE_TITLE" IS '일정 제목';
COMMENT ON COLUMN "SCHEDULE"."START_DATE" IS '시작일';
COMMENT ON COLUMN "SCHEDULE"."END_DATE" IS '종료일';
COMMENT ON COLUMN "SCHEDULE"."SCHEDULE_CONTENT" IS '일정 내용';
COMMENT ON COLUMN "SCHEDULE"."USER_NO" IS '회원 번호';
COMMENT ON COLUMN "SCHEDULE"."PROJECT_NO" IS '프로젝트 번호';


CREATE SEQUENCE SEQ_SCHEDULE_NO NOCACHE; -- 일정 번호 시퀀스


CREATE TABLE "NOTICE" (
    NOTICE_NO NUMBER PRIMARY KEY, -- 기본 키 설정
    NOTICE_TYPE NUMBER NOT NULL,
    NOTICE_STATUS NUMBER DEFAULT 1 NOT NULL,
    NOTICE_COMMENT_VIEW NUMBER DEFAULT 1 NOT NULL,
    NOTICE_COPY NUMBER DEFAULT 1 NOT NULL,
    NOTICE_TITLE VARCHAR2(150) NOT NULL,
    CREATE_DT DATE DEFAULT SYSDATE NOT NULL ,
    UPDATE_DT DATE DEFAULT NULL,
    NOTICE_CONTENT VARCHAR2(900) NOT NULL,
    READ_COUNT NUMBER DEFAULT 0,
    USER_NO NUMBER NOT NULL,
    FOREIGN KEY (USER_NO) REFERENCES "USER"(USER_NO) -- 외래 키 설정
);

COMMENT ON COLUMN "NOTICE"."NOTICE_NO" IS '게시글 번호(SEQ_NOTICE_NO)';
COMMENT ON COLUMN "NOTICE"."NOTICE_TYPE" IS '게시글 타입(안내 1 새기능 소개 2  정책변경3)';
COMMENT ON COLUMN "NOTICE"."NOTICE_STATUS" IS '게시글 상태(정상 1, 삭제2, 상단 고정 3)';
COMMENT ON COLUMN "NOTICE"."NOTICE_COMMENT_VIEW" IS '게시글 댓글 출력 여부(가능 1, 불가 2)';
COMMENT ON COLUMN "NOTICE"."NOTICE_COPY" IS '게시글 복사 / 출처 허용 여부(사용 1, 불가 2)';
COMMENT ON COLUMN "NOTICE"."NOTICE_TITLE" IS '게시글 제목';
COMMENT ON COLUMN "NOTICE"."CREATE_DT" IS '작성일';
COMMENT ON COLUMN "NOTICE"."UPDATE_DT" IS '마지막 수정일';
COMMENT ON COLUMN "NOTICE"."NOTICE_CONTENT" IS '게시글 내용';
COMMENT ON COLUMN "NOTICE"."READ_COUNT" IS '조회수';
COMMENT ON COLUMN "NOTICE"."USER_NO" IS '회원 번호';


CREATE SEQUENCE SEQ_NOTICE_NO NOCACHE; -- 게시글 번호 시퀀스

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 값 대입
-- 게시판 종류 추가
-- SYSTEM 관리자 데이터 삽입
INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'sys01@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW)
    '관리자',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    NULL,-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    'S',                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

-- ADMIN 관리자 데이터 삽입
INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'ad01@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW)
    '관리자',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    NULL,-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    'A',                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

-- 유저 데이터 삽입
INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'user01@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW)
    '유저일',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    '1234^^^테헤란로12^^^101동 201호',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'user02@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW)
    '유저이',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    '1234^^^테헤란로12^^^101동 201호',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'user03@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW) pass01
    '유저삼',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    '1234^^^테헤란로12^^^101동 201호',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

-- 프로젝트 삽입
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '세미 프로젝트',
    '세미 프로젝트입니다.',
    DEFAULT,
    2
);

INSERT INTO "USER_PROJECT" VALUES(
    2, -- 생성자
    1 -- 만든 프로젝트 번호
);

INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '파이널 프로젝트',
    '파이널 프로젝트입니다.',
    DEFAULT,
    3
);

INSERT INTO "USER_PROJECT" VALUES(
    3, -- 생성자
    2 -- 만든 프로젝트 번호
);

-- 프로젝트 초대
INSERT INTO "USER_PROJECT" VALUES(
    4, -- 유저번호
    2 -- 프로젝트 번호
);

BEGIN
   FOR i IN 1..310 LOOP
      INSERT INTO NOTICE (
         NOTICE_NO, NOTICE_TYPE, NOTICE_STATUS, NOTICE_TITLE, CREATE_DT, UPDATE_DT, NOTICE_CONTENT, READ_COUNT, USER_NO
      ) VALUES (
         SEQ_NOTICE_NO.NEXTVAL, 
         MOD(i, 3) + 1, -- NOTICE_TYPE은 1, 2, 3이 고르게 분배됨
         1, -- NOTICE_STATUS는 항상 1
         '게시글 제목' || i, -- 게시글 제목은 '게시글 제목1', '게시글 제목2' ...
         SYSDATE, -- 작성일
         NULL, -- 마지막 수정일
         '게시글 내용' || i, -- 게시글 내용은 '게시글 내용1', '게시글 내용2' ...
         CEIL(DBMS_RANDOM.VALUE(20,200)), -- 조회수는 항상 0
         1 -- USER_NO는 1로 설정 (실제 존재하는 USER_NO를 사용해야 함)
      );
   END LOOP;
   COMMIT;
END;
/


INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 3, 1, 1, '상단 고정 내용임',  SYSDATE, NULL, '상단 고정 내용임', 328, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 3, 2, 2, '상단 고정 내용임2', SYSDATE, NULL, '상단 고정 내용임',234, 1 );

INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 1, 1, '서버점검중', SYSDATE, NULL, '오늘 서버 점검합니다', 22, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 2, 2, '이제 캘린더 사용 가능', SYSDATE, NULL, '캘린더 사용 가능합니다.', 52, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 1, 1, '이제 캘린더 사용 가능2', SYSDATE, NULL, '캘린더 사용 가능합니다.', 122, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 1, 1, '서버점검중2', SYSDATE, NULL, '오늘 서버 점검합니다', 45, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 2, 2, '서버점검중3', SYSDATE, NULL, '오늘 서버 점검합니다', 59, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 2, 2, '이제 캘린더 사용 가능3', SYSDATE, NULL, '캘린더 사용 가능합니다.', 66, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 1, 1, '서버점검중4', SYSDATE, NULL, '오늘 서버 점검합니다', 0, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 1, 1, '이제 캘린더 사용 가능4', SYSDATE, NULL, '캘린더 사용 가능합니다.', 110, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 3, 1, 2, 2, '정부 정책 변경에 따른 개인정보보안 약정 변경', SYSDATE, NULL, '캘린더 사용 가능합니다.', 123, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 2, 2, '서버점검중5 만약 게시글 제목이 너무 길다면 어떻게 될까 두 줄이 되는데 그걸 더 넘어가면 어떻게 될까', SYSDATE, NULL, '오늘 서버 점검합니다', 43, 1);
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 3, 1, 1, 1, '정부 정책 변경에 따른 개인정보보안 약정 변경', SYSDATE, NULL, '오늘 서버 점검합니다', 112, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 1, 1, '이제 캘린더 사용 가능6', SYSDATE, NULL, '캘린더 사용 가능합니다.', 145, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 1, 1, '이제 캘린더 사용 가능7', SYSDATE, NULL, '캘린더 사용 가능합니다.', 122, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 3, 1, 1, 1, '정부 정책 변경에 따른 개인정보보안 약정 변경', SYSDATE, NULL, '오늘 서버 점검합니다', 40, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 2, 1, 1, 1, '이제 캘린더 사용 가능8', SYSDATE, NULL, '캘린더 사용 가능합니다.', 82, 1 );
INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, 1, 1, 1, '서버점검중8', SYSDATE, NULL, '오늘 서버 점검합니다', 101, 1 );

INSERT INTO SCHEDULE VALUES(SEQ_SCHEDULE_NO.NEXTVAL, 1, '일정1', SYSDATE, SYSDATE + 2,
	 '일정1의 내용입니다.', 3, 1);

INSERT INTO SCHEDULE VALUES(SEQ_SCHEDULE_NO.NEXTVAL, 2, '휴가1', SYSDATE+3, SYSDATE + 6,
	 '휴가1의 내용입니다.', 4, 1);

-- 특정 일정 등록
INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 1, '회의1',
        TO_DATE('2024-09-19 12:50', 'YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-09-19 12:56', 'YYYY-MM-DD HH24:MI'),
        '회의 1내용입니다.', 3, 1
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 1, '회의2',
        TO_DATE('2024-09-24 12:50', 'YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-09-24 12:56', 'YYYY-MM-DD HH24:MI'),
        '회의 2내용입니다.', 4, 1
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 2, '연가1',
        TO_DATE('2024-09-15', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-17', 'YYYY-MM-DD"T"HH24:MI'),
        '연가 1내용입니다.', 4, 1
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 2, '연가2',
        TO_DATE('2024-09-01', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-04 12:56', 'YYYY-MM-DD HH24:MI'),
        '연가 2내용입니다.', 3, 1
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 3, '병가2',
        TO_DATE('2024-09-06', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-07 12:56', 'YYYY-MM-DD HH24:MI'),
        '병가 1내용입니다.', 3, 1
);

-- COMMENT 테이블 샘플 데이터 삽입(PL/SQL)
BEGIN
   FOR I IN 1..1000 LOOP
      INSERT INTO NOTICE_COMMENT 
      VALUES(SEQ_COMMENT_NO.NEXTVAL, 
            SEQ_COMMENT_NO.CURRVAL || '번째 댓글',
            DEFAULT, DEFAULT,
             CEIL(DBMS_RANDOM.VALUE(0,328)),
             3, NULL);
   END LOOP;
END;
/
-- 파일 데이터 추가 
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00001.jpg', 'cat1.jpg', 0, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00002.jpg', 'cat2.jpg', 1, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00003.jpg', 'cat3.jpg', 2, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00004.jpg', 'cat4.jpg', 3, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00005.jpg', 'cat5.jpg', 4, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/notice/', 
    '20240809111920_00006.jpg', 'dog1.jpg', 5, 1, 328);
    
INSERT INTO FILES
VALUES(SEQ_FILE_NO.NEXTVAL, '/resources/images/calendar/', 
    '20240809111920_00001.jpg', 'cat1.jpg', 0, 4, 7);


    


COMMIT;
