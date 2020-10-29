-- SQL01_SELECT(Basic) Ǯ��
-- 3��, 10�� ����

-- 1��
SELECT DEPARTMENT_NAME "�а� ��", CATEGORY �迭
FROM TB_DEPARTMENT;

-- 2��
SELECT DEPARTMENT_NAME || '�� ������' || CAPACITY || '�� �Դϴ�.' AS "�а��� ����"
FROM TB_DEPARTMENT;

-- 3��
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE (DEPARTMENT_NO = '001') 
AND (ABSENCE_YN = 'Y')
AND (STUDENT_SSN LIKE '_______2%');

-- 4��
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO BETWEEN 'A513079' AND 'A513119';

-- 5��
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN '20' AND '30';

-- 6��
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7��
SELECT DEPARTMENT_NAME
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NO IS NULL;

-- 8��
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9��
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY 1;

-- 10��
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ENTRANCE_DATE LIKE '02%'
AND STUDENT_ADDRESS LIKE '����%'
AND (ABSENCE_YN = 'N');