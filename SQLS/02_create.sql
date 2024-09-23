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
    FOREIGN KEY (PROJECT_NO) REFERENCES PROJECT(PROJECT_NO) ON DELETE CASCADE, -- 외래 키 설정
    FOREIGN KEY (USER_NO) REFERENCES "USER"(USER_NO) ON DELETE CASCADE -- 외래 키 설정
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


--------------------------------------------------------------------------------
--작업
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


CREATE SEQUENCE SEQ_WORK_NO NOCACHE;




--작업댓글
CREATE TABLE "WORK_COMMENT" (
	"COMMENT_NO"	NUMBER		                        NOT NULL,
	"COMMENT_CON"	VARCHAR2(4000)		                NOT NULL,
	"COMMENT_ST"	NUMBER(1)	    DEFAULT 1	        NOT NULL,
	"COMMENT_DT"	DATE	        DEFAULT SYSDATE	    NOT NULL,
	"PARENT_NO"	    NUMBER	        DEFAULT NULL	    NULL,
	"WORK_NO"	    NUMBER		                        NOT NULL,
	"USER_NO"	    NUMBER		                        NOT NULL
);

COMMENT ON COLUMN "WORK_COMMENT"."COMMENT_NO" IS '답변번호(시퀀스)';
COMMENT ON COLUMN "WORK_COMMENT"."COMMENT_CON" IS '답변내용';
COMMENT ON COLUMN "WORK_COMMENT"."COMMENT_ST" IS '삭제0 기본1';
COMMENT ON COLUMN "WORK_COMMENT"."COMMENT_DT" IS '댓글작성일';
COMMENT ON COLUMN "WORK_COMMENT"."PARENT_NO" IS '부모 댓글 번호';
COMMENT ON COLUMN "WORK_COMMENT"."WORK_NO" IS '작업번호(시퀀스)';
COMMENT ON COLUMN "WORK_COMMENT"."USER_NO" IS '회원번호';


CREATE SEQUENCE SEQ_WORK_COMMENT_NO NOCACHE;



--투두
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



--------------------------------------------------------------------------------


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



SELECT SEQ_CHAT_NO.NEXTVAL FROM DUAL;
SELECT SEQ_CHAT_NO.CURRVAL FROM DUAL;

--------------------------------------------------------------------------------


CREATE TABLE "THREAD" (
	"THREAD_NO"	NUMBER		NOT NULL,
	"THREAD_TITLE"	VARCHAR2(100)		NOT NULL,
    PRIMARY KEY (THREAD_NO)
);

COMMENT ON COLUMN "THREAD"."THREAD_NO" IS '스레드 번호(SEQ)';
COMMENT ON COLUMN "THREAD"."THREAD_TITLE" IS '스레드 이름';

CREATE SEQUENCE SEQ_THREAD_NO NOCACHE;

CREATE TABLE "THREAD_MESSAGE" (
	"THREAD_CHATNO"	NUMBER		NOT NULL,
	"THREAD_MESSAGE"	VARCHAR2(4000)		NOT NULL,
	"THREAD_TIMESTAMP"	DATE	DEFAULT SYSDATE	NOT NULL,
	"THREAD_TYPE"	VARCHAR2(100)		NOT NULL,
	"THREAD_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
    PRIMARY KEY (THREAD_CHATNO),
    FOREIGN KEY (THREAD_NO) REFERENCES THREAD(THREAD_NO) ON DELETE CASCADE, -- 외래 키 설정
    FOREIGN KEY (USER_NO) REFERENCES "USER"(USER_NO) ON DELETE CASCADE -- 외래 키 설정
);

CREATE SEQUENCE SEQ_THREAD_CHAT_NO NOCACHE;

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

CREATE TABLE "PROJECT_THREAD" (
	"PROJECT_NO"	NUMBER		NOT NULL,
	"THREAD_NO"	NUMBER		NOT NULL,
    FOREIGN KEY (THREAD_NO) REFERENCES THREAD(THREAD_NO) ON DELETE CASCADE, -- 외래 키 설정
    FOREIGN KEY (PROJECT_NO) REFERENCES "PROJECT"(PROJECT_NO) ON DELETE CASCADE -- 외래 키 설정
);

COMMENT ON COLUMN "PROJECT THREAD"."PROJECT_NO" IS '프로젝트 번호';
COMMENT ON COLUMN "PROJECT THREAD"."THREAD_NO" IS '스레드 번호(SEQ)';
