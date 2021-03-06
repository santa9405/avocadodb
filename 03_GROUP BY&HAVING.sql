/* SELECT문 해석 순서

 5:SELECT 컬럼명 AS 별칭, 계산식, 함수식
 1:FROM 참조할 테이블명
     + JOIN
 E:WHERE 컬럼명|함수식|결과가 TRUE/FALSE
 3:GROUP BY 그룹을 묶을 컬럼명
 4:HAVING 그룹함수식 비교연산자 비교값
 6:ORDER BY 컬럼명|컬럼순서|별칭 정렬방식 [NULLS FIRST|LAST];
 
*/

--------------------------------------------------------------------------------
-- 부서별 급여 합 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

/* GROUP BY 절 : 같은 값들이 여러 개 기록된 컬럼을 가지고
                 같은 컬럼 값을 하나의 그룹으로 묶은 구문
                 
 GROUP BY 컬럼명|함수식[,컬럼명|함수식, ...]
 
 - GROUP BY로 나눠진 그룹 수 만큼 그룹 함수 결과가 조회됨
 
 ** GROUP BY 사용 시
    SELECT 절에는 GROUP BY에 작성된 컬럼명 또는 그룹함수만 작성 가능함
*/

-- EMPLOYEE 테이블에서
-- 부서 코드, 부서별 급여 합, 부서별 급여 평균, 부서별 인원 수를
-- 부서코드 순으로 조회
SELECT DEPT_CODE, SUM(SALARY)"급여 합", 
       FLOOR(AVG(SALARY)) "급여 평균", COUNT(*) "인원 수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--EMPLOYEE 테이블에서
-- 부서별로 보너스를 받는 사원의 수
-- 부서 역순으로 조회
SELECT DEPT_CODE, COUNT(BONUS) "보너스 받는 인원 수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC NULLS LAST;


--EMPLOYEE 테이블에서
-- 각 성별의 급여 평균, 급여 합, 인원 수를
-- 인원 수 내림차순으로 조회
SELECT DECODE( SUBSTR(EMP_NO,8,1),'1','남','2','여')성별,
  FLOOR(AVG(SALARY))"급여 평균",
  SUM(SALARY)"급여 합",
  COUNT(*)"인원 수"
FROM EMPLOYEE
GROUP BY DECODE( SUBSTR(EMP_NO,8,1),'1','남','2','여')
ORDER BY "인원 수" DESC;

--------------------------------------------------------------------------------

-- WHERE절과 GROUP BY절 혼합 사용
-- -WHERE절이 해석 우선순위 높음!
    --> 각 컬럼값에 대한 조건을 만들때 사용 하는게 WHERE절
    
-- EMPLOYEE 테이블에서 부서 코드가 'D5','D6'인 부서의 급여 평균 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY))"급여 평균" -- 4순위
FROM EMPLOYEE                 -- 1순위
WHERE DEPT_CODE IN('D5','D6') -- 2순위
GROUP BY DEPT_CODE;           -- 3순위

-- EMPLOYEE 테이블에서 
-- 직급 코드별 2000년도 부터 입사자들의 급여 합을
-- 직급코드 오름차순으로 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE 
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= '2000'
-- WHERE HIRE_DATE >= '00/01/01' 묵시적
-- WHERE HIRE_DATE >= TO_DATE('20000101','YYYYMMDD') 명시적
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--------------------------------------------------------------------------------

-- 여러 컬럼을 묶어서 그룹으로 지정하는 경우

--EMPLOYEE 테이블에서
--부서별로 직급 특정 직급코드의 인원 수와 급여 합을
--부서코드 오름차순, 직급코드 내림차순으로 조회

SELECT DEPT_CODE, JOB_CODE, COUNT(*)"인원 수", SUM(SALARY)"급여 합"
FROM EMPLOYEE 
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE, JOB_CODE DESC; -- 부서별 직급코드 내림차순

-- ** GROUP BY 절에 작성되지 않은 컬럼은 SELECT절에 작성할 수 없다!

--EMPLOYEE 테이블에서 부서 별로 급여 등급이 같은 직원의 수를
-- 부서코드별 급여 등급 오름차순으로 정렬
SELECT DEPT_CODE"부서", SAL_LEVEL"급여 등급", COUNT(*)"직원 수"
FROM EMPLOYEE 
GROUP BY DEPT_CODE, SAL_LEVEL
ORDER BY DEPT_CODE, SAL_LEVEL;

--------------------------------------------------------------------------------

/* HAVING절 : 그룹에 대한 조건을 설정할 때 사용하는 구문

   HAVING 컬럼명|함수식
*/

-- EMPLOYEE 테이블에서 부서별 급여 평균이 3백만 이상인 부서를
-- 부서코드 오름차순으로 조회
SELECT DEPT_CODE"부서", FLOOR(AVG(SALARY))"급여 평균"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 부서별 급여 합이 9백만 초과인 부서를
-- 부서코드 오름차순으로 조회
SELECT DEPT_CODE"부서", SUM(SALARY)"급여 합"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY 1;

-- 1. EMPLOYEE 테이블에서 각 부서별 가장 높은 급여, 가장 낮은 급여를 조회하여
-- 부서 코드 오름차순으로 정렬하세요.
SELECT DEPT_CODE"부서", MAX(SALARY)"가장 높은 급여", MIN(SALARY)"가장 낮은 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 2. EMPLOYEE 테이블에서 각 직급별 보너스를 받는 사원의 수를 조회하여
-- 직급코드 오름차순으로 정렬하세요
SELECT JOB_CODE"직급", COUNT(BONUS)"보너스"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 3. EMPLOYEE 테이블에서 
-- 부서별 70년대생의 급여 평균이 300만 이상인 부서를 조회하여
-- 부서 코드 오름차순으로 정렬하세요
SELECT DEPT_CODE"부서", AVG(SALARY)"급여 평균"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN '70' AND '79'
-- SUBSTR(EMP_NO,1,1) = '7'
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000
ORDER BY 1;

--------------------------------------------------------------------------------

--집계함수
--그룹 별 산출 결과를 계산하는 함수
--GROUP BY 절에만 작성 가능한 함수

-- EMPLOYTT 테이블에서 직급별 급여 합을
-- 직급 오름차순으로 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- 모든 직원의 급여 합
SELECT SUM(SALARY) FROM EMPLOYEE;

-- ROLLUP 집계 함수 : 
-- 그룹별 '중간 집계'와 '전체 집계'를 계산하여 결과를 행에 자동 추가해주는 함수
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

--EMPLOYTT 테이블에서
--각 부서에 소속된 직급별 급여 합을 조회
--단, 부서 별 급여 합,
--직급별 급여 합,
--전체 급여 합 결과를 추가
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

--------------------------------------------------------------------------------
-- CUBE 집계 함수 : ROLLUP + 그룹으로 지정된 모든 그룹에 대한 집계 결과 추가
-- 정처기

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

--------------------------------------------------------------------------------
--GROUPING 함수
--ROLLUP,CUBE에 의한 산출물이
-- 인자로 전달받은 컬럼 집합의 산출물이면 0
-- 아니면 1을 반환하는 함수
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
 GROUPING(DEPT_CODE)"부서별 그룹",
 GROUPING(JOB_CODE)"직급별 그룹"
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;


SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
  CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1 THEN '부서'
       WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0 THEN '직급'
       WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 1 THEN '총합'
       ELSE '부서별 직급'
    END 구분
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

--------------------------------------------------------------------------------

/* 집합 연산자(SET OPERATION)
 - 여러 SELECT문의 결과물(RESULT SET)을 하나로 만드는 연산자
 - 서로 다른 조건에 의해 결과가 다른 SELECT문을 하나로 결합하고 싶을 때 사용
 - 사용법이 간단하여 초보자들이 사용하기 좋음
 
 ** 주의 사항
  SELECT문의 SELECT절이 모두 동일해야함
*/

-- UNION(합집합):RESULT SET을 하나로 합치는 연산자
-- 중복되는 행은 한 번만 조회됨

--EMPLOYEE 테이블에서
-- 부서 코드가 'D5'인 직원 이거나
-- 급여가 300만 초과인 직원의
-- 사번, 이름, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

--> UNION은 OR연산과 같은 결과를 반환함
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
OR SALARY > 3000000;

-- INTERSECT(교집합)
-- RESULT SET중 공통되는 행만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

--> INTERSECT는 AND연산과 같은 결과를 반환함
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
AND SALARY > 3000000;

-- UNION ALL(합집합 + 교집합)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- MINUS(차집합):선행 RESULT SET에서 후행 RESULT SET과 일치하는 부분을 제외
-- 부서코드가 'D5'인 직원 중 급여가 300만 초과한 사람을 제외한 결과를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;















