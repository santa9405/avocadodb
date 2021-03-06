/*
    DML(Data Manipulation Language) : 데이터 조작 언어

    - 테이블에 값을 삽입하거나(INSERT), 수정(UPDATE)하거나, 삭제(DELETE)하는 구문

    -- DML 수업 중 주의사항!!
      -> 혼자서 작성 다했다고 실행하지 말 것!
      -> 절대 COMMIT, ROLLBACK 구문 마음대로 실행하지 말 것!
*/



--------------------------------------------------------------------------------

/* 1. INSERT
    - 테이블에 새로운 행을 추가하는 구문
    - 테이블의 행 갯수가 증가함
    
    [작성법 1]
    INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3, ...)
    VALUES(데이터1, 데이터2, 데이터3, ...);
    
    -> 지정한 테이블에서 특정 컬럼을 선택하여 테이터를 삽입(INSERT)하는 방법
      --> 선택이 안된 컬럼은 NULL값이 들어가거나,
          설정되어 있는 DEFAULT값이 들어감
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL, 
                     PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, 
                     SALARY, BONUS, MANAGER_ID, HIRE_DATE, 
                     ENT_DATE, ENT_YN)
VALUES('900', '장채현', '901123-1080503', 'jang_ch@kh.or.kr', 
       '01055569512', 'D1', 'J7', 'S3', 4300000, 0.2, '200', SYSDATE,
       NULL, DEFAULT);
-- 1 행 이(가) 삽입되었습니다. (삽입 성공)

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '장채현';

/* [작성법 2]
    INSERT INTO 테이블명
    VALUES(데이터1, 데이터2, 데이터3, ...);
    
    -> 테이블에 모든 컬럼에 대한 값을 INSERT 할 때 사용하는 방법
      --> INSERT 구문에 컬럼 생략, VALUES에 컬럼 순서대로 데이터를 작성해야 함
*/

ROLLBACK;

INSERT INTO EMPLOYEE
VALUES('900', '장채현', '901123-1080503', 'jang_ch@kh.or.kr', 
       '01055569512', 'D1', 'J7', 'S3', 4300000, 0.2, '200', SYSDATE,
       NULL, DEFAULT);

SELECT * FROM EMPLOYEE WHERE EMP_NAME = '장채현';

COMMIT;



-- INSERT시 VALUES 대신 서브쿼리 사용하기
CREATE TABLE EMP_01(
    EMP_ID VARCHAR2(3) PRIMARY KEY,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

INSERT INTO EMP_01
    (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
);
-- 24개 행 이(가) 삽입되었습니다.

SELECT * FROM EMP_01;

COMMIT;


--------------------------------------------------------------------------------

/* 2. INSERT ALL

  - 서로다른 테이블에 INSERT시 서브쿼리가 사용하는 테이블이 같은 경우
    두 개 이상의 테이블에 INSERT ALL을 이용하여 한 번에 삽입 가능한 구문
    (단, 서브쿼리 조건절이 같아야 함)
*/

-- INSERT ALL 예시1

-- 사번, 사원명, 부서코드, 입사일 컬럼을 가지는 테이블 EMP_DEPT를 생성하고
-- EMPLOYEE 테이블에의 컬럼, 데이터 타입만 복사
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0;
      --> 서브쿼리의 WHERE절 조건을 항상 FALSE가 되게 만들면
      -- 데이터는 복사되지 않고, 테이블의 컬럼, 데이터 타입만 복사가 됨

SELECT * FROM EMP_DEPT;

-- 사번, 이름, 관리자 번호 컬럼을 가지는 테이블 EMP_MANAGER를 생성하고
-- EMPLOYEE 테이블에서 컬럼명, 데이터 타입만 복사
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_MANAGER;


-- EMP_DEPT테이블에
-- EMPLOYEE 테이블에서 부서코드가 'D1'인 사원의
-- 사번, 이름, 부서코드, 입사일 삽입
INSERT INTO EMP_DEPT
    (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
     FROM EMPLOYEE
     WHERE DEPT_CODE = 'D1');

-- EMP_MANAGER테이블에
-- EMPLOYEE 테이블에서 부서코드가 'D1'인 사원의
-- 사번, 이름, 관리자 번호 삽입
INSERT INTO EMP_MANAGER
    (SELECT EMP_ID, EMP_NAME, MANAGER_ID
     FROM EMPLOYEE
     WHERE DEPT_CODE = 'D1');
     
SELECT * FROM EMP_DEPT;     
SELECT * FROM EMP_MANAGER;

ROLLBACK;

-- 서브쿼리에서 사용하는 테이블과 조건절 내용이 같으므로
-- INSERT ALL을 이용해서 한번에 삽입을 진행할 수 있음
INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
        SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
        FROM EMPLOYEE
        WHERE DEPT_CODE = 'D1';
-- 8개 행 이(가) 삽입되었습니다.

SELECT * FROM EMP_DEPT;     
SELECT * FROM EMP_MANAGER;



-- INSERT ALL 예시2

-- EMPLOYEE테이블의 구조를 복사하여 사번, 이름, 입사일, 급여를 기록할 수 있는
-- 테이블 EMP_OLD와 EMP_NEW 생성
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;
   
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;

-- EMPLOYEE테이블의 입사일 기준으로 2000년 1월 1일 이전에 입사한 사원의 사번, 이름,
-- 입사일, 급여를 조회해서 EMP_OLD테이블에 삽입하고 그 후에 입사한 사원의 정보는 
-- EMP_NEW테이블에 삽입
INSERT ALL
    WHEN HIRE_DATE < '2000/01/01' THEN
        INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    WHEN HIRE_DATE >= '2000/01/01' THEN
        INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

COMMIT;


--------------------------------------------------------------------------------


/* 3. UPDATE
     - 테이블에 기록된 데이터의 컬럼 값을 수정하는 구문
     - 테이블의 전체 행 갯수에서는 변화가 없음
     
     [작성법]
     UPDATE 테이블명
     SET 컬럼명 = 변경값
     [WHERE 컬럼명 비교연산자 비교값]
*/

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_COPY 테이블에서 부서코드가 'D9'인 행의 부서명을
-- '전략기획팀'으로 수정

UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀';
-- 9개 행 이(가) 업데이트되었습니다.

SELECT * FROM DEPT_COPY; --> 모두 '전략기획팀' 으로 바뀜

ROLLBACK;

UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';
-- 1 행 이(가) 업데이트되었습니다.

SELECT * FROM DEPT_COPY;

COMMIT;

-- 여러 컬럼을 수정하는 경우


-- DEPT_COPY 테이블에서 부서코드가 'D8'인 부서를
-- 부서명 : 기술연구부 / 지역코드 : L2로 수정
UPDATE DEPT_COPY
SET DEPT_TITLE = '기술연구부',
     LOCATION_ID = 'L2'
WHERE DEPT_ID = 'D8';

SELECT * FROM DEPT_COPY;

ROLLBACK;


-- UPDATE + 서브쿼리

/* [작성법]
    UPDATE 테이블명
    SET 컬럼명 = (서브쿼리)
    [WHERE 컬럼명 비교식 (서브쿼리)]
*/

-- 평상 시 유재식 사원을 부러워하던 방명수 사원의
-- 급여와 보너스를 유재식과 동일하게 변경해주기로 했다
-- 이를 반영하기 위한 SQL구문을 작성하시오
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;

-- 유재식, 방명수의 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME IN('유재식','방명수');

-- 방명수의 급여, 보너스를 유재식과 똑같이 수정
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY
                    WHERE EMP_NAME='유재식'),
     BONUS = (SELECT BONUS FROM EMP_SALARY
                    WHERE EMP_NAME='유재식')
WHERE EMP_NAME = '방명수';

-- 다중열 서브쿼리를 이용한 UPDATE문

-- 방명수의 급여 인상 소식을 전해들은
-- 노옹철, 전형돈, 정중하, 하동운이 단체파업을 진행했다.
-- 이를 해결하기 위해 위 4명의 급여, 보너스를 유재식과 똑같이 바꿔주기로 했다.
-- 이를 반영한 SQL 구문을 작성하시오
SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN('노옹철','전형돈','정중하','하동운');

UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                                   FROM EMP_SALARY
                                   WHERE EMP_NAME='유재식')
WHERE EMP_NAME IN('노옹철','전형돈','정중하','하동운');
-- 4개 행 이(가) 업데이트되었습니다.
                 
SELECT * FROM EMP_SALARY;

-- EMP_SALARY 테이블에서
-- BONUS를 받지 못하는 사원의 BONUS를 0.1로 수정
UPDATE EMP_SALARY
SET BONUS = 0.1
WHERE BONUS IS NULL;

SELECT * FROM EMP_SALARY;

ROLLBACK;

-- EMP_SALARY 테이블에서
-- BONUS를 받지 못하는 사원의 BONUS를 0.1,
-- BONUS를 받던 사원들은 0.1씩 증가한 값으로 수정
UPDATE EMP_SALARY E
SET BONUS = (SELECT NVL2(BONUS, BONUS + 0.1, 0.1)
                     FROM EMP_SALARY M
                     WHERE E.EMP_ID = M.EMP_ID);
                     
UPDATE EMP_SALARY
SET BONUS = NVL(BONUS, 0) +0.1;

ROLLBACK;

SELECT * FROM EMP_SALARY;

-- EMP_SALARY 테이블에서
-- ASIA 지역에 근무하는 직원의 보너스를 0.5로 변경
UPDATE EMP_SALARY
SET BONUS = 0.5
WHERE DEPT_CODE IN (SELECT DEPT_ID FROM DEPARTMENT 
                                  LEFT JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
                                  WHERE LOCAL_NAME LIKE 'ASIA_');
                        
SELECT * FROM EMP_SALARY;

ROLLBACK;

--------------------------------------------------------------------------------

-- UPDATE시 주의사항
    --> UPDATE시 변경할 값은 해당 컬럼의 제약 조건을 위배하면 안됨

SELECT * FROM USER_FK;
SELECT * FROM USER_GRADE;

UPDATE USER_FK
SET GRADE_CODE = 40 -- USER_GRADE테이블에 GRADE_CODE 컬럼 값 중 없는 값을 작성함
WHERE USER_NO = 1;
-- ORA-02291: integrity constraint (KH.GRADE_CODE_FK) violated - parent key not found






--------------------------------------------------------------------------------

/* 4. DELETE
    - 테이블의 행을 삭제하는 구문
    - 테이블 전체 행 갯수가 줄어듦
    
    
    [작성법]
    DELETE FROM 테이블명
    [WHERE 컬럼명 비교연산자 비교값]
    
    -> WHERE절을 작성하지 않는 경우
        해당 테이블의 모든 데이터가 DELETE됨
*/

COMMIT;

DELETE FROM EMPLOYEE
WHERE EMP_NAME ='장채현';
-- 1 행 이(가) 삭제되었습니다.

SELECT * FROM EMPLOYEE
WHERE EMP_NAME='장채현'; -- 조회 안됨

ROLLBACK;

-- WHERE절 미작성 시 모든 행이 삭제됨
SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY; -- 24개 행 이(가) 삭제되었습니다.

ROLLBACK;

-- FK 제약 조건 중 별도의 삭제옵션이 설정되지 않은 행은 삭제 불가능
DELETE FROM USER_GRADE
WHERE GRADE_CODE = '10';
-- ORA-02292: integrity constraint (KH.GRADE_CODE_FK) violated - child record found

-- 삭제 시 FK 제약 조건을 비활성화 하면 삭제가 가능하다
ALTER TABLE USER_FK
DISABLE CONSTRAINT GRADE_CODE_FK CASCADE;

SELECT * FROM USER_FK;
SELECT * FROM USER_GRADE;

-- 제약조건 활성화
ALTER TABLE USER_FK
ENABLE CONSTRAINT GRADE_CODE_FK;

INSERT INTO USER_GRADE
VALUES(10, '일반회원');


-- TRUNCATE : 테이블의 전체행을 삭제하는 DDL
-- DELETE보다 수행속도가 빠르고, ROLLBACK으로 복구가 불가능함

CREATE TABLE EMP_SALARY2
AS SELECT * FROM EMP_SALARY;

SELECT * FROM EMP_SALARY2;

COMMIT;

DELETE FROM EMP_SALARY2;
ROLLBACK;

TRUNCATE TABLE EMP_SALARY2;
SELECT * FROM EMP_SALARY2;
ROLLBACK;













