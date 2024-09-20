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

INSERT INTO "USER" VALUES(
    SEQ_USER_NO.NEXTVAL,                  -- 사용자 번호 (USER_NO)
    'user04@kh.or.kr',              -- 이메일 (USER_EMAIL)
    '$2a$10$eeylz0XV81KRZBA.UN09Hu52FXyehKvb.z1COFF7Yi1eRmK7feSzq',                      -- 비밀번호 (USER_PW) pass01
    '유저사',                         -- 이름 (USER_NAME)
    '01012345678',                      -- 전화번호 (USER_PHONE)
    '1234^^^테헤란로12^^^101동 201호',-- 주소 (USER_ADDR)
    NULL,  -- 프로필 이미지 (PROFILE_IMG)
    SYSDATE,                            -- 가입일 (ENROLL_DATE)
    DEFAULT,                                -- 역할 (ROLE)
    DEFAULT                                 -- 탈퇴 여부 (USER_DEL_FL)
);

-- 프로젝트 삽입1
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '세미 프로젝트',
    '유저일이 만들었음',
    DEFAULT,
    3
);

INSERT INTO "USER_PROJECT" VALUES(
    3, -- 생성자
    1 -- 만든 프로젝트 번호
);

-- 프로젝트 삽입2
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '파이널 프로젝트',
    '유저이가 만들었음',
    DEFAULT,
    4
);

INSERT INTO "USER_PROJECT" VALUES(
    4, -- 생성자
    2 -- 만든 프로젝트 번호
);

-- 프로젝트 삽입3
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '안 중요한 프로젝트',
    '유저삼이 만든 프로젝트입니다.',
    DEFAULT,
    5
);

INSERT INTO "USER_PROJECT" VALUES(
    5, -- 생성자
    3 -- 만든 프로젝트 번호
);

-- 프로젝트 삽입4
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '중요한 프로젝트',
    '유저사가 만든 프로젝트임',
    DEFAULT,
    6
);

INSERT INTO "USER_PROJECT" VALUES(
    6, -- 생성자
    4 -- 만든 프로젝트 번호
);

-- 프로젝트 삽입5
INSERT INTO "PROJECT" VALUES(
    SEQ_PROJECT_NO.NEXTVAL,
    '저일의 프로젝트',
    '연습용 프로젝트',
    DEFAULT,
    3
);

INSERT INTO "USER_PROJECT" VALUES(
    3, -- 생성자
    5 -- 만든 프로젝트 번호
);

-- 프로젝트 초대1
INSERT INTO "USER_PROJECT" VALUES(
    4, -- 유저번호
    1 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    5, -- 유저번호
    1 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    6, -- 유저번호
    1 -- 프로젝트 번호
);

-- 프로젝트 초대2
INSERT INTO "USER_PROJECT" VALUES(
    3, -- 유저번호
    2 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    5, -- 유저번호
    2 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    6, -- 유저번호
    2 -- 프로젝트 번호
);

-- 프로젝트 초대3
INSERT INTO "USER_PROJECT" VALUES(
    3, -- 유저번호
    3 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    4, -- 유저번호
    3 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    6, -- 유저번호
    3 -- 프로젝트 번호
);

-- 프로젝트 초대4
INSERT INTO "USER_PROJECT" VALUES(
    3, -- 유저번호
    4 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    4, -- 유저번호
    4 -- 프로젝트 번호
);

INSERT INTO "USER_PROJECT" VALUES(
    5, -- 유저번호
    4 -- 프로젝트 번호
);

-- 공지사항
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

INSERT INTO SCHEDULE VALUES(SEQ_SCHEDULE_NO.NEXTVAL, 1, '일정1', SYSDATE, SYSDATE + 2,
	 '일정1의 내용입니다.', 3, 2);

INSERT INTO SCHEDULE VALUES(SEQ_SCHEDULE_NO.NEXTVAL, 2, '휴가1', SYSDATE+3, SYSDATE + 6,
	 '휴가1의 내용입니다.', 4, 2);

-- 특정 일정 등록
INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 1, '회의1',
        TO_DATE('2024-09-19 12:50', 'YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-09-19 12:56', 'YYYY-MM-DD HH24:MI'),
        '회의 1내용입니다.', 3, 2
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 1, '회의2',
        TO_DATE('2024-09-24 12:50', 'YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-09-24 12:56', 'YYYY-MM-DD HH24:MI'),
        '회의 2내용입니다.', 4, 2
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 2, '연가1',
        TO_DATE('2024-09-15', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-17', 'YYYY-MM-DD"T"HH24:MI'),
        '연가 1내용입니다.', 4, 2
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 2, '연가2',
        TO_DATE('2024-09-01', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-04 12:56', 'YYYY-MM-DD HH24:MI'),
        '연가 2내용입니다.', 3, 2
);

INSERT INTO SCHEDULE VALUES(
        SEQ_SCHEDULE_NO.NEXTVAL, 3, '병가2',
        TO_DATE('2024-09-06', 'YYYY-MM-DD"T"HH24:MI'),
        TO_DATE('2024-09-07 12:56', 'YYYY-MM-DD HH24:MI'),
        '병가 1내용입니다.', 3, 2
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