/* SEQUENCE (시퀀스)
    - 순차적으로 정수값을 자동 생성해주는 
      자동 번호 발생기 역할을 하는 객체 
 
    [작성법]
    1) 생성
    CREATE SEQUENCE 시퀀스명
    [START WITH 정수] -- 처음 발생시킬 시작값 지정, 생략 시 기본값 1로 지정
    [INCREMENT BY 정수] -- 다음 값에 대한 증가치, 생략 시 기본 값 1로 지정
    [MAXVALUE 정수| NOMAXVALUE] -- 발생시킬 최대값을 지정(10^27-1), NOMAXVALUE 기본값
    [MINVALUE 정수| NOMINVALUE] -- 발생시킬 최소값을 지정(-10^26), NOMINVALUE 기본값
    [CYCLE | NOCYCLE] -- 값 순환 여부를 지정, NOCYCLE 기본 값
    [CACHE 바이트크기 | NOCACHE] -- 캐쉬메모리크기 지정. 최소값 2바이트
                                                -- NOCACHE 기본 값 20바이트
                                                
    * 시퀀스의 캐쉬메모리는 할당된 크기 만큼 미리 다음 값을 생성해서 저장해둠
        --> 다음 시퀀스 호출 시 저장된 값을 반환하므로 속도가 빠름(DB속도 향상)
*/

-- 1. 시퀀스 생성
CREATE SEQUENCE SEQ_EMP_ID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOMINVALUE
NOCYCLE
NOCACHE;

-- 사용자가 생성한 시퀀스 확인
SELECT * FROM USER_SEQUENCES;

----------------------------------------------------------------------------------------------------------

-- 2. 시퀀스 사용
/* [작성법]

1) 현재 생성된 시퀀스 값 반환
시퀀스명.CURRVAL

2) 시퀀스 값을 INCREMENT 값 만큼 증가시킨 값 반환
시퀀스명.NEXTVAL
*/

SELECT SEQ_EMP_ID.CURRVAL FROM DUAL;
-- CURRVAL는 마지막에 호출된 NEXTVAL의 값을 저장하는 변수같은 개념

--> NEXTVAL를 먼저 호출!
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- 초기 값 300
SELECT SEQ_EMP_ID.CURRVAL FROM DUAL; -- 현재 값 300
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- 310
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- 에러(최대값 초과)

SELECT * FROM USER_SEQUENCES;

/* 시퀀스(CURRVAL, NEXTVAL) 사용 가능/불가능 SQL문

    1) 사용 가능
        - 메인쿼리(서브쿼리가 아닌 SELECT문)의 SELECT절
        - INSERT문의 서브쿼리 SELECT절
        - INSERT문의 VALUES절
        - UPDATE문의 SET절
        
    2) 사용 불가능
       - VIEW의 SELECT절
       - DISTINCT가 있는 SELECT절
       - GROUP BY, HAVING, ORDER BY절이 포함된 SELECT문
       - SELECT, DELETE, UPDATE문의 서브쿼리
       - CREATE TABLE, ARTER TABLE의 DEFAULT값
*/

CREATE SEQUENCE SEQ_EID
START WITH 300 -- 시작값 300
--INCREMENT BY 1 -- 1씩 증가
MAXVALUE 10000 -- 최대값 1만
--NOMINVALUE -- 최소값 없음
--NOCYCLE -- 반복 없음
CACHE 30; -- 캐시 30바이트

SELECT * FROM USER_SEQUENCES;

COMMIT;

INSERT INTO EMPLOYEE
VALUES( SEQ_EID.NEXTVAL, '홍길동','001109-1234567','hogn-gd@kh.or.kr',
            '01012341234','D2','J7','S1',6000000, 0.1, 200, SYSDATE, NULL, DEFAULT);

-- 홍길동 사번 확인
SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '홍길동'; -- 300

INSERT INTO EMPLOYEE
VALUES( SEQ_EID.NEXTVAL, '홍길순','001109-2234567','hogn-gs@kh.or.kr',
            '01012345678','D2','J7','S1',6000000, 0.1, 200, SYSDATE, NULL, DEFAULT);

-- 홍길순 사번 확인
SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '홍길순'; -- 301


----------------------------------------------------------------------------------------------------------

/* 3. 시퀀스 변경
    [작성법]
    ALTER SEQUENCE 시퀀스명
    [INCREMENT BY 정수]
    [MAXVALUE 정수| NOMAXVALUE]
    [MINVALUE 정수| NOMINVALUE]
    [CYCLE | NOCYCLE]
    [CACHE 바이트크기 | NOCACHE]

    -> START WITH는 변경 불가

     * 만약 START WITH를 변경하고 싶다면
       
       DROP SEQUENCE 시퀀스명; 삭제 진행 후
       
       CREATE SEQUENCE 시퀀스명; 다시 생성
*/

ALTER SEQUENCE SEQ_EMP_ID
INCREMENT BY 10
MAXVALUE 400
MINVALUE 200
CYCLE;

SELECT SEQ_EMP_ID.CURRVAL FROM DUAL;
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL;


































