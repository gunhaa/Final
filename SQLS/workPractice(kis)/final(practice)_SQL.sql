--sys계정
-- **계정생성 <- 관리자계정(sys 관리자 계정)
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
--DROP USER finalPractice;

-- 계정 생성
CREATE USER tlink
IDENTIFIED BY "tlink1234";

-- 권한 부여 (CREATE위함)
GRANT CONNECT, RESOURCE, CREATE VIEW TO tlink;

-- 객체 생성 공간 할당 (INSERT위함)
ALTER USER tlink 
DEFAULT TABLESPACE SYSTEM
QUOTA UNLIMITED ON SYSTEM;

--------------------------------------------------------------------------------
--tlink계정

--DROP SEQUENCE SEQ_USER_NO;
--DELETE "USER";
CREATE SEQUENCE SEQ_USER_NO NOCACHE;



INSERT INTO "USER" VALUES( SEQ_USER_NO.NEXTVAL, 1, '$2a$10$aYmvPo8eMnfkoFqRKWey2ugZ/HCS6z7ho/CpYmmha4K0ZbSMfAmIK', '유저일', 1, 1, NULL, SYSDATE, DEFAULT, DEFAULT );
INSERT INTO "USER" VALUES( SEQ_USER_NO.NEXTVAL, 2, '$2a$10$aYmvPo8eMnfkoFqRKWey2ugZ/HCS6z7ho/CpYmmha4K0ZbSMfAmIK', '유저일2', 1, 1, NULL, SYSDATE, DEFAULT, DEFAULT );
INSERT INTO "USER_PROJECT" VALUES(1, 1);
INSERT INTO "USER_PROJECT" VALUES(2, 1);
INSERT INTO "USER_PROJECT" VALUES(1, 2);
COMMIT;




DROP TABLE WORK;
DROP SEQUENCE SEQ_WORK_NO;

--12컬럼
--CREATE_DT / UPDATE_DT / WORK_ST  :3컬럼(사용자x*개발자o)
-- ...                             :9컬럼(사용자o)


CREATE TABLE "WORK" (
	"WORK_NO"	    NUMBER		                        NOT NULL,
	"WORK_TITLE"	VARCHAR2(150)	DEFAULT '제목'	    NULL,
	"WORK_CONTENT"	VARCHAR2(4000)	DEFAULT '내용'	    NULL,
	"CREATE_DT"	    DATE	        DEFAULT SYSDATE 	NOT NULL,
	"UPDATE_DT"	    DATE	        DEFAULT NULL	    NULL,
	"DUE_DT"	    DATE	        DEFAULT SYSDATE	    NULL,
	"WORK_ST"	    NUMBER(1)	    DEFAULT 1	        NOT NULL,
	"WORK_PR_ST"	NUMBER(1)	    DEFAULT 0	        NOT NULL,
	"WORK_PR"	    NUMBER(1)	    DEFAULT 0	        NULL,
	"WORK_MN_NO"	NUMBER	        DEFAULT NULL	    NULL,
	"PARENT_NO"	    NUMBER	        DEFAULT NULL	    NULL,
	"PROJECT_NO"	NUMBER		                        NOT NULL
); 




COMMENT ON COLUMN "WORK"."WORK_NO" IS '작업번호(시퀀스)';
COMMENT ON COLUMN "WORK"."WORK_TITLE" IS '작업제목';
COMMENT ON COLUMN "WORK"."WORK_CONTENT" IS '작업내용';
COMMENT ON COLUMN "WORK"."CREATE_DT" IS '작업작성일';
COMMENT ON COLUMN "WORK"."UPDATE_DT" IS '작업수정일(최종)';
COMMENT ON COLUMN "WORK"."DUE_DT" IS '작업마감일';
COMMENT ON COLUMN "WORK"."WORK_ST" IS '삭제0 / 기본 N1';
COMMENT ON COLUMN "WORK"."WORK_PR_ST" IS '0=시작전 / 1=진행중 / 2=완료후';
COMMENT ON COLUMN "WORK"."WORK_PR" IS '0=낮음 / 1=중간 /  2=높음';
COMMENT ON COLUMN "WORK"."WORK_MN_NO" IS '작업자번호(사용자지정)';
COMMENT ON COLUMN "WORK"."PARENT_NO" IS '상위';
COMMENT ON COLUMN "WORK"."PROJECT_NO" IS '프로젝트 번호';


--WORK 시퀀스
CREATE SEQUENCE SEQ_WORK_NO NOCACHE;





CREATE TABLE "TODO" (
	"TODO_NO"	    NUMBER		                        NOT NULL,
	"TODO_TITLE"	VARCHAR2(150)	DEFAULT '제목'	    NULL,
	"TODO_CONTENT"	VARCHAR2(4000)	DEFAULT '내용'	    NULL,
	"CREATE_DT"	    DATE	        DEFAULT SYSDATE	    NOT NULL,
	"UPDATE_DT"	    DATE	        DEFAULT NULL	    NULL,
	"TODO_ST"	    NUMBER(1)	    DEFAULT 1	        NOT NULL,
	"TODO_PR_ST"	NUMBER(1)	    DEFAULT 0   	    NOT NULL,
	"TODO_MN_NO"	NUMBER	                    	    NOT NULL,
	"PARENT_NO"	    NUMBER      	DEFAULT NULL	    NULL,
	"PROJECT_NO"	NUMBER		                        NOT NULL
);
COMMENT ON COLUMN "TODO"."TODO_NO" IS '투두번호(시퀀스)';
COMMENT ON COLUMN "TODO"."TODO_TITLE" IS '투두제목';
COMMENT ON COLUMN "TODO"."TODO_CONTENT" IS '투두내용';
COMMENT ON COLUMN "TODO"."CREATE_DT" IS '투두작성일';
COMMENT ON COLUMN "TODO"."UPDATE_DT" IS '투두수정일';
COMMENT ON COLUMN "TODO"."TODO_ST" IS '삭제0 / 기본 1';
COMMENT ON COLUMN "TODO"."TODO_PR_ST" IS '0=시작전,/1=진행중/2=완료후';
COMMENT ON COLUMN "TODO"."TODO_MN_NO" IS '회원번호';
COMMENT ON COLUMN "TODO"."PARENT_NO" IS '부모번호';
COMMENT ON COLUMN "TODO"."PROJECT_NO" IS '프로젝트 번호';

CREATE SEQUENCE SEQ_TODO_NO NOCACHE;



INSERT INTO WORK VALUES(
SEQ_WORK_NO.NEXTVAL, '제목1', '내용1', 
DEFAULT, DEFAULT, DEFAULT, 
DEFAULT, DEFAULT, DEFAULT, 
DEFAULT, DEFAULT, 1
);

INSERT INTO WORK VALUES(
SEQ_WORK_NO.NEXTVAL, '제목2', '내용2', 
DEFAULT, DEFAULT, DEFAULT, 
DEFAULT, DEFAULT, DEFAULT, 
DEFAULT, NULL, 1
);
COMMIT;
--ROLLBACK;

UPDATE WORK SET WORK_ST=1;
COMMIT;

ROLLBACK;




SELECT A.WORK_NO, A.WORK_TITLE, A.WORK_CONTENT, 
TO_CHAR(A.CREATE_DT, 'YYYY-MM-DD') CREATE_DT, TO_CHAR(A.UPDATE_DT, 'YYYY-MM-DD') UPDATE_DT, TO_CHAR(A.DUE_DT, 'YYYY-MM-DD') DUE_DT, 
A.WORK_PR_ST, A.WORK_PR, A.WORK_MN_NO, A.PARENT_NO, A.PROJECT_NO
,USER_NAME, PROFILE_IMG
,PROJECT_TITLE
,B.WORK_TITLE PARENT_TITLE
FROM WORK A
LEFT OUTER JOIN "USER" ON A.WORK_MN_NO="USER".USER_NO
LEFT OUTER JOIN "PROJECT" ON A.PROJECT_NO="PROJECT".PROJECT_NO
LEFT OUTER JOIN WORK B ON A.PARENT_NO=B.WORK_NO
WHERE A.PROJECT_NO=1
AND A.WORK_ST=1
SELECT * FROM WORK;
;

SELECT * FROM WORK
ORDER BY WORK_MN_NO
;


SELECT *
FROM (
    SELECT WORK.*, ROW_NUMBER() OVER (PARTITION BY WORK_MN_NO ORDER BY WORK_MN_NO) AS RN,
    COUNT(*) OVER (PARTITION BY WORK_MN_NO) AS CNT
    FROM WORK
)
WHERE RN = CNT; 



SELECT *
FROM WORK
WHERE WORK_MN_NO IN (
    SELECT MAX(WORK_MN_NO)
    FROM WORK
    GROUP BY WORK_MN_NO
);

SELECT MAX(WORK_MN_NO) AS MAX_NUM
FROM WORK
GROUP BY WORK_MN_NO
;



--댓글
--DROP TABLE WORK_COMMENT;
--DROP SEQUENCE SEQ_WORK_COMMENT_NO;


CREATE TABLE "WORK_COMMENT" (
	"COMMENT_NO"	NUMBER		                        NOT NULL,
	"COMMENT_CON"	VARCHAR2(4000)		                NOT NULL,
	"COMMENT_ST"	NUMBER(1)	    DEFAULT 1	        NOT NULL,
	"COMMENT_DT"	DATE	        DEFAULT SYSDATE	    NOT NULL,
	"PARENT_NO"	    NUMBER	        DEFAULT NULL	    NULL,
	"WORK_NO"	    NUMBER		                        NOT NULL,
	"USER_NO"	    NUMBER		                        NOT NULL,
	"PROJECT_NO"	NUMBER		                        NOT NULL
);

COMMENT ON COLUMN "WORK_COMMENT"."COMMENT_NO" IS '답변번호(시퀀스)';
COMMENT ON COLUMN "WORK_COMMENT"."COMMENT_CON" IS '답변내용';
COMMENT ON COLUMN "WORK_COMMENT"."COMMENT_ST" IS '삭제0 기본1';
COMMENT ON COLUMN "WORK_COMMENT"."COMMENT_DT" IS '댓글작성일';
COMMENT ON COLUMN "WORK_COMMENT"."PARENT_NO" IS '부모 댓글 번호';
COMMENT ON COLUMN "WORK_COMMENT"."WORK_NO" IS '작업번호(시퀀스)';
COMMENT ON COLUMN "WORK_COMMENT"."USER_NO" IS '회원번호';
COMMENT ON COLUMN "WORK_COMMENT"."PROJECT_NO" IS '프로젝트 번호';


CREATE SEQUENCE SEQ_WORK_COMMENT_NO NOCACHE;



INSERT INTO WORK_COMMENT VALUES(
    SEQ_WORK_COMMENT_NO.NEXTVAL, '댓글1', DEFAULT, DEFAULT, DEFAULT,
    1, 1, 1
);
INSERT INTO WORK_COMMENT VALUES(
    SEQ_WORK_COMMENT_NO.NEXTVAL, '댓글2', DEFAULT, DEFAULT, DEFAULT,
    1, 2, 1null
);
INSERT INTO WORK_COMMENT VALUES(
    SEQ_WORK_COMMENT_NO.NEXTVAL, '댓글3', DEFAULT, DEFAULT, DEFAULT,
    1, 1, 1
);
COMMIT;



;





        
--------------------------------------------------------------------------------
INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    '1',              -- 이메일 (USER_EMAIL)
    '$2a$10$eoLo2fIAuCTHMOaMH8Dxt.GDE8HCdN2Gy6xzy3hTMYsCTKNVW1i96',                      -- 비밀번호 (USER_PW)
    '1',                         -- 이름 (USER_NAME)
    '1',                      -- 전화번호 (USER_PHONE)
    '1',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    '2',              -- 이메일 (USER_EMAIL)
    '$2a$10$eoLo2fIAuCTHMOaMH8Dxt.GDE8HCdN2Gy6xzy3hTMYsCTKNVW1i96',                      -- 비밀번호 (USER_PW)
    '2',                         -- 이름 (USER_NAME)
    '2',                      -- 전화번호 (USER_PHONE)
    '2',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);


INSERT INTO PROJECT VALUES (
    1, 1, 1, DEFAULT, 1
);

INSERT INTO USER_PROJECT VALUES (
    1, 1
);

INSERT INTO USER_PROJECT VALUES (
    2, 1
);

COMMIT;
--------------------------------------------------------------------------------

