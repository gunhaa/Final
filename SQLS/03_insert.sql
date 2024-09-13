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

COMMIT;