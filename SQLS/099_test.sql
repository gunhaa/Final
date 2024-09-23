
--테이블 삭제
DROP TABLE "VIDEO_MEMBER" CASCADE CONSTRAINTS;
DROP TABLE "VIDEO_CHAT" CASCADE CONSTRAINTS;
DROP TABLE "VIDEO_CHATTIMER" CASCADE CONSTRAINTS;
DROP TABLE "VIDEO_ROOM" CASCADE CONSTRAINTS;

-- 시퀀스 삭제
DROP SEQUENCE SEQ_CHAT_NO;
DROP SEQUENCE  SEQ_TIMER_NO;


CREATE TABLE "VIDEO_MEMBER" (
	"PROJECT_NO"	NUMBER		NOT NULL,
	"USER_NO"	    NUMBER		NOT NULL,
	"VIDEO_STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NOT NULL,
    PRIMARY KEY (USER_NO, PROJECT_NO),
    CONSTRAINT FK_USER_VIDEO_MEMBER FOREIGN KEY (USER_NO) REFERENCES "USER" (USER_NO) ON DELETE CASCADE,
    CONSTRAINT FK_PROJECT_VIDEO_MEMBER FOREIGN KEY (PROJECT_NO) REFERENCES "PROJECT" (PROJECT_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN "VIDEO_MEMBER"."PROJECT_NO" IS '프로젝트 번호';
COMMENT ON COLUMN "VIDEO_MEMBER"."USER_NO" IS '사용자 번호';
COMMENT ON COLUMN "VIDEO_MEMBER"."VIDEO_STATUS" IS '접속중 Y 나감 N';


CREATE TABLE "VIDEO_ROOM" (
	"PROJECT_NO"	NUMBER		NOT NULL,
	"VIDEO_TITLE"	VARCHAR2(100)	DEFAULT '화상 채팅'	NOT NULL , 
    PRIMARY KEY (PROJECT_NO),
    CONSTRAINT FK_MEMBER_VIDEO_ROOM FOREIGN KEY (PROJECT_NO) REFERENCES "PROJECT" (PROJECT_NO) ON DELETE CASCADE
);

COMMENT ON COLUMN "VIDEO_ROOM"."PROJECT_NO" IS '프로젝트 번호';
COMMENT ON COLUMN "VIDEO_ROOM"."VIDEO_TITLE" IS '제목';


CREATE TABLE "VIDEO_CHATTIMER" (
	"TIMER_NO"	NUMBER		NOT NULL,
	"TIMER_SEND"	DATE		NOT NULL,
	"TIMER_CONTENT"	VARCHAR2(600)	NOT NULL,
	"TIMER_STATUS"	VARCHAR2(3)	DEFAULT 'N'	NOT NULL,
	"PROJECT_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
    PRIMARY KEY (TIMER_NO),
    CONSTRAINT FK_VIDEO_MEMBER_CHATTIMER FOREIGN KEY (USER_NO, PROJECT_NO) 
    REFERENCES "VIDEO_MEMBER" (USER_NO, PROJECT_NO) ON DELETE CASCADE 
);

COMMENT ON COLUMN "VIDEO_CHATTIMER"."TIMER_NO" IS '예약 번호(SEQ)';
COMMENT ON COLUMN "VIDEO_CHATTIMER"."TIMER_SEND" IS '예약 시간';
COMMENT ON COLUMN "VIDEO_CHATTIMER"."TIMER_CONTENT" IS '메시지 내용';
COMMENT ON COLUMN "VIDEO_CHATTIMER"."TIMER_STATUS" IS '전송시 Y';
COMMENT ON COLUMN "VIDEO_CHATTIMER"."PROJECT_NO" IS '프로젝트 번호';
COMMENT ON COLUMN "VIDEO_CHATTIMER"."USER_NO" IS '사용자 번호';



CREATE TABLE "VIDEO_CHAT" (
	"CHAT_NO"	NUMBER		NOT NULL,
	"CHAT_TIMESTAMP"	DATE	DEFAULT SYSDATE	NOT NULL,
	"CHAT_CONTENT"	VARCHAR2(600)		NOT NULL,
	"PROJECT_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
    PRIMARY KEY (CHAT_NO),
    CONSTRAINT FK_MEMBER_VIDEO_CHAT FOREIGN KEY (USER_NO,PROJECT_NO) REFERENCES "VIDEO_MEMBER" (USER_NO,PROJECT_NO) ON DELETE CASCADE
    
);

COMMENT ON COLUMN "VIDEO_CHAT"."CHAT_NO" IS '채팅 번호';
COMMENT ON COLUMN "VIDEO_CHAT"."CHAT_TIMESTAMP" IS '채팅 시간';
COMMENT ON COLUMN "VIDEO_CHAT"."CHAT_CONTENT" IS '채팅내용';
COMMENT ON COLUMN "VIDEO_CHAT"."PROJECT_NO" IS '프로젝트 번호';
COMMENT ON COLUMN "VIDEO_CHAT"."USER_NO" IS '사용자 번호';




-- 시퀀스 생성
CREATE SEQUENCE SEQ_CHAT_NO NOCACHE;
CREATE SEQUENCE SEQ_TIMER_NO NOCACHE;

SELECT * FROM "VIDEO_MEMBER";
SELECT * FROM "VIDEO_ROOM";
SELECT * FROM VIDEO_CHAT;
SELECT * FROM VIDEO_CHATTIMER;
select * from "USER";
SELECT CHAT_CONTENT ,CHAT_TIMESTAMP FROM VIDEO_CHAT WHERE PROJECT_NO=1 ORDER BY CHAT_NO;
SELECT USER_NAME, CHAT_CONTENT, CHAT_TIMESTAMP,PROFILE_IMG FROM VIDEO_CHAT JOIN "USER" USING(USER_NO) WHERE PROJECT_NO=1 ORDER BY CHAT_NO;
--ROLLBACK;
-- 샘플 데이터 삽입
--INSERT INTO "VIDEO_MEMBER" VALUES (1, 1, 'Y');
--INSERT INTO "VIDEO_MEMBER" VALUES (1, 2, 'Y');
INSERT INTO "VIDEO_ROOM" VALUES (1, DEFAULT);
INSERT INTO VIDEO_CHAT VALUES (SEQ_CHAT_NO.NEXTVAL, SYSDATE, '안녕', 1 , 1);
INSERT INTO VIDEO_CHATTIMER VALUES (SEQ_TIMER_NO.NEXTVAL , SYSDATE, '내용', 'N' , 1, 1);
--ROLLBACK;
--UPDATE "VIDEO_MEMBER" SET VIDEO_STATUS='N' WHERE USER_NO=4;
UPDATE VIDEO_ROOM SET VIDEO_TITLE='점심 뭐' WHERE PROJECT_NO=1;
UPDATE VIDEO_ROOM SET VIDEO_TITLE='test' WHERE PROJECT_NO=1;
UPDATE VIDEO_MEMBER SET VIDEO_STATUS='N' WHERE PROJECT_NO=1 AND USER_NO=1;
UPDATE VIDEO_CHATTIMER SET TIMER_STATUS='Y' WHERE PROJECT_NO =1 AND USER_NO=1;
commit;
SELECT VIDEO_TITLE FROM VIDEO_ROOM WHERE PROJECT_NO=1;
SELECT SYSDATE FROM DUAL;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';





CREATE TABLE "THREAD" (
	"THREAD_NO"	NUMBER		NOT NULL,
	"THREAD_TITLE"	VARCHAR2		NOT NULL,
    PRIMARY KEY (THREAD_NO)
);

COMMENT ON COLUMN "THREAD"."THREAD_NO" IS '스레드 번호(SEQ)';

COMMENT ON COLUMN "THREAD"."THREAD_TITLE" IS '스레드 이름';

CREATE TABLE "THREAD_MESSAGE" (
	"THREAD_CHATNO"	NUMBER		NOT NULL,
	"THREAD_MESSAGE"	VARCHAR2		NOT NULL,
	"THREAD_TIMESTAMP"	DATE	DEFAULT SYSDATE	NOT NULL,
	"THREAD_TYPE"	VARCHAR2		NOT NULL,
	"THREAD_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
    PRIMARY KEY (THREAD_CHATNO),
    FOREIGN KEY (THREAD_NO) REFERENCES THREAD(THREAD_NO) ON DELETE CASCADE, -- 외래 키 설정
    FOREIGN KEY (USER_NO) REFERENCES "USER"(USER_NO) ON DELETE CASCADE -- 외래 키 설정
);

COMMENT ON COLUMN "THREAD_MESSAGE"."THREAD_CHATNO" IS '채팅 번호(SEQ)';

COMMENT ON COLUMN "THREAD_MESSAGE"."THREAD_MESSAGE" IS '채팅 내용';

COMMENT ON COLUMN "THREAD_MESSAGE"."THREAD_TIMESTAMP" IS '채팅 시간';

COMMENT ON COLUMN "THREAD_MESSAGE"."THREAD_TYPE" IS '"ENTER" / "CHAT"/"SYSTEM"';

COMMENT ON COLUMN "THREAD_MESSAGE"."THREAD_NO" IS '스레드 번호(SEQ)';

COMMENT ON COLUMN "THREAD_MESSAGE"."USER_NO" IS '사용자 번호';

CREATE TABLE "THREAD_MEMBER" (
	"THREAD_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
    FOREIGN KEY (THREAD_NO) REFERENCES THREAD(THREAD_NO) ON DELETE CASCADE, -- 외래 키 설정
    FOREIGN KEY (USER_NO) REFERENCES "USER"(USER_NO) ON DELETE CASCADE -- 외래 키 설정
);

COMMENT ON COLUMN "THREAD_MEMBER"."THREAD_NO" IS '스레드 번호(SEQ)';

COMMENT ON COLUMN "THREAD_MEMBER"."USER_NO" IS '사용자 번호';

CREATE TABLE "PROJECT THREAD" (
	"PROJECT_NO"	NUMBER		NOT NULL,
	"THREAD_NO"	NUMBER		NOT NULL,
    FOREIGN KEY (THREAD_NO) REFERENCES THREAD(THREAD_NO) ON DELETE CASCADE, -- 외래 키 설정
    FOREIGN KEY (PROJECT_NO) REFERENCES "PROJECT"(PROJECT_NO) ON DELETE CASCADE -- 외래 키 설정
);

COMMENT ON COLUMN "PROJECT THREAD"."PROJECT_NO" IS '프로젝트 번호';

COMMENT ON COLUMN "PROJECT THREAD"."THREAD_NO" IS '스레드 번호(SEQ)';

ALTER TABLE "THREAD" ADD CONSTRAINT "PK_THREAD" PRIMARY KEY (
	"THREAD_NO"
);

ALTER TABLE "THREAD_MESSAGE" ADD CONSTRAINT "PK_THREAD_MESSAGE" PRIMARY KEY (
	"THREAD_CHATNO"
);

ALTER TABLE "THREAD_MESSAGE" ADD CONSTRAINT "FK_THREAD_TO_THREAD_MESSAGE_1" FOREIGN KEY (
	"THREAD_NO"
)
REFERENCES "THREAD" (
	"THREAD_NO"
);

ALTER TABLE "THREAD_MESSAGE" ADD CONSTRAINT "FK_USER_TO_THREAD_MESSAGE_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "USER" (
	"USER_NO"
);

ALTER TABLE "THREAD_MEMBER" ADD CONSTRAINT "FK_THREAD_TO_THREAD_MEMBER_1" FOREIGN KEY (
	"THREAD_NO"
)
REFERENCES "THREAD" (
	"THREAD_NO"
);

ALTER TABLE "THREAD_MEMBER" ADD CONSTRAINT "FK_USER_TO_THREAD_MEMBER_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "USER" (
	"USER_NO"
);

ALTER TABLE "PROJECT THREAD" ADD CONSTRAINT "FK_PROJECT_TO_PROJECT THREAD_1" FOREIGN KEY (
	"PROJECT_NO"
)
REFERENCES "PROJECT" (
	"PROJECT_NO"
);

ALTER TABLE "PROJECT THREAD" ADD CONSTRAINT "FK_THREAD_TO_PROJECT THREAD_1" FOREIGN KEY (
	"THREAD_NO"
)
REFERENCES "THREAD" (
	"THREAD_NO"
);



