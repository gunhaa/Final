CREATE TABLE "WORK2" (
	"WORK_NO"	    NUMBER		                            PRIMARY KEY,  --이부분 PRIMARY KEY로
	"WORK_TITLE"	VARCHAR2(150)		                    NULL,
	"WORK_CONTENT"	VARCHAR2(4000)		                    NULL,
	"CREATE_DT" 	DATE	            DEFAULT SYSDATE	    NOT NULL,
	"UPDATE_DT" 	DATE		                            NULL,
	"DUE_DT"	    DATE		                            NULL,
	"WORK_ST"   	NUMBER(1)	        DEFAULT 0	        CHECK( "WORK_ST" IN(0,1,2)),   --이부분 CHECK로
	"WORK_PR"	    NUMBER(1)		                        CHECK( "WORK_PR" IN(0,1,2)), --이부분 CHECK로
	"WORK_MN_NO"	NUMBER		                            NULL,
	"PROJECT_NO"	NUMBER		                            NOT NULL,
	"WORK_NO_PR"	NUMBER		                            NULL
);
CREATE SEQUENCE SEQ_WORK_NO2 NOCACHE;
INSERT INTO WORK2 VALUES(SEQ_WORK_NO2.NEXTVAL, '', '', 
DEFAULT, NULL, '24/12/10', 
0, 0, 1, 2, NULL);

INSERT INTO WORK2 VALUES(SEQ_WORK_NO2.NEXTVAL, '', '', 
DEFAULT, NULL, '24/12/10', 
1, 2, 1, 2, NULL);

COMMIT;

--날짜형식  2012-12-12
--TO_CHAR(B_CREATE_DATE, 'YYYY-MM-DD')
SELECT CREATE_DT FROM WORK2;
SELECT TO_CHAR(CREATE_DT, 'YYYY-MM-DD') FROM WORK2;
SELECT TO_CHAR(CREATE_DT, 'YYYY-MM-DD') AS CREATE_DT FROM WORK2;
SELECT TO_CHAR(CREATE_DT, 'YYYY,MM,DD') AS CREATE_DT FROM WORK2; -- gant형식
/*
Html 형식 -> YYYY-MM-DD
Html -> Java -> DB 라인까지 싹다통일o
but 구글Form -> Js -> new Date( ) ->  매개변수function -> , ,형식
차라리 이럴바에 그러면 Js라인에서 처리.
죄다 통일화하되, 당해필요한부분만 변형형태로 대입진행 ㄱㄱ.!!!
오히려 이게 맞는듯함.!!!
굳이 DB에서부터 전부변환해서 가져오기△
물론 당해한정해서 가져오면 상관없으나.
가져오는메소드 사용하다가
다른데서도 사용하는경우 형식변환 다시해줘야함.
그럴경우 작업해놓은게 
작업때문에 다시금작업 또해줘야함.
그렇기에 당해위해서는 통일형식으로 가주되.
끝선에서 처리하는식으로 진행 ㄱㄱ.!!!
이게 가장깔끔한듯함.

Date형식:
 - - >> , ,
일반적>>특이적
원칙적>>예외적

*/














