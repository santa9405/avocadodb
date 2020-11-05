/*
    DML(Data Manipulation Language) : ������ ���� ���

    - ���̺� ���� �����ϰų�(INSERT), ����(UPDATE)�ϰų�, ����(DELETE)�ϴ� ����

    -- DML ���� �� ���ǻ���!!
      -> ȥ�ڼ� �ۼ� ���ߴٰ� �������� �� ��!
      -> ���� COMMIT, ROLLBACK ���� ������� �������� �� ��!
*/



--------------------------------------------------------------------------------

/* 1. INSERT
    - ���̺� ���ο� ���� �߰��ϴ� ����
    - ���̺��� �� ������ ������
    
    [�ۼ��� 1]
    INSERT INTO ���̺��(�÷���1, �÷���2, �÷���3, ...)
    VALUES(������1, ������2, ������3, ...);
    
    -> ������ ���̺��� Ư�� �÷��� �����Ͽ� �����͸� ����(INSERT)�ϴ� ���
      --> ������ �ȵ� �÷��� NULL���� ���ų�,
          �����Ǿ� �ִ� DEFAULT���� ��
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL, 
                     PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, 
                     SALARY, BONUS, MANAGER_ID, HIRE_DATE, 
                     ENT_DATE, ENT_YN)
VALUES('900', '��ä��', '901123-1080503', 'jang_ch@kh.or.kr', 
       '01055569512', 'D1', 'J7', 'S3', 4300000, 0.2, '200', SYSDATE,
       NULL, DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�. (���� ����)

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '��ä��';

/* [�ۼ��� 2]
    INSERT INTO ���̺��
    VALUES(������1, ������2, ������3, ...);
    
    -> ���̺� ��� �÷��� ���� ���� INSERT �� �� ����ϴ� ���
      --> INSERT ������ �÷� ����, VALUES�� �÷� ������� �����͸� �ۼ��ؾ� ��
*/

ROLLBACK;

INSERT INTO EMPLOYEE
VALUES('900', '��ä��', '901123-1080503', 'jang_ch@kh.or.kr', 
       '01055569512', 'D1', 'J7', 'S3', 4300000, 0.2, '200', SYSDATE,
       NULL, DEFAULT);

SELECT * FROM EMPLOYEE WHERE EMP_NAME = '��ä��';

COMMIT;



-- INSERT�� VALUES ��� �������� ����ϱ�
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
-- 24�� �� ��(��) ���ԵǾ����ϴ�.

SELECT * FROM EMP_01;

COMMIT;


--------------------------------------------------------------------------------

/* 2. INSERT ALL

  - ���δٸ� ���̺� INSERT�� ���������� ����ϴ� ���̺��� ���� ���
    �� �� �̻��� ���̺� INSERT ALL�� �̿��Ͽ� �� ���� ���� ������ ����
    (��, �������� �������� ���ƾ� ��)
*/

-- INSERT ALL ����1

-- ���, �����, �μ��ڵ�, �Ի��� �÷��� ������ ���̺� EMP_DEPT�� �����ϰ�
-- EMPLOYEE ���̺��� �÷�, ������ Ÿ�Ը� ����
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0;
      --> ���������� WHERE�� ������ �׻� FALSE�� �ǰ� �����
      -- �����ʹ� ������� �ʰ�, ���̺��� �÷�, ������ Ÿ�Ը� ���簡 ��

SELECT * FROM EMP_DEPT;

-- ���, �̸�, ������ ��ȣ �÷��� ������ ���̺� EMP_MANAGER�� �����ϰ�
-- EMPLOYEE ���̺��� �÷���, ������ Ÿ�Ը� ����
CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;

SELECT * FROM EMP_MANAGER;


-- EMP_DEPT���̺�
-- EMPLOYEE ���̺��� �μ��ڵ尡 'D1'�� �����
-- ���, �̸�, �μ��ڵ�, �Ի��� ����
INSERT INTO EMP_DEPT
    (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
     FROM EMPLOYEE
     WHERE DEPT_CODE = 'D1');

-- EMP_MANAGER���̺�
-- EMPLOYEE ���̺��� �μ��ڵ尡 'D1'�� �����
-- ���, �̸�, ������ ��ȣ ����
INSERT INTO EMP_MANAGER
    (SELECT EMP_ID, EMP_NAME, MANAGER_ID
     FROM EMPLOYEE
     WHERE DEPT_CODE = 'D1');
     
SELECT * FROM EMP_DEPT;     
SELECT * FROM EMP_MANAGER;

ROLLBACK;

-- ������������ ����ϴ� ���̺�� ������ ������ �����Ƿ�
-- INSERT ALL�� �̿��ؼ� �ѹ��� ������ ������ �� ����
INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
        SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
        FROM EMPLOYEE
        WHERE DEPT_CODE = 'D1';
-- 8�� �� ��(��) ���ԵǾ����ϴ�.

SELECT * FROM EMP_DEPT;     
SELECT * FROM EMP_MANAGER;



-- INSERT ALL ����2

-- EMPLOYEE���̺��� ������ �����Ͽ� ���, �̸�, �Ի���, �޿��� ����� �� �ִ�
-- ���̺� EMP_OLD�� EMP_NEW ����
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;
   
CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;

-- EMPLOYEE���̺��� �Ի��� �������� 2000�� 1�� 1�� ������ �Ի��� ����� ���, �̸�,
-- �Ի���, �޿��� ��ȸ�ؼ� EMP_OLD���̺� �����ϰ� �� �Ŀ� �Ի��� ����� ������ 
-- EMP_NEW���̺� ����
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
     - ���̺� ��ϵ� �������� �÷� ���� �����ϴ� ����
     - ���̺��� ��ü �� ���������� ��ȭ�� ����
     
     [�ۼ���]
     UPDATE ���̺��
     SET �÷��� = ���氪
     [WHERE �÷��� �񱳿����� �񱳰�]
*/

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_COPY ���̺��� �μ��ڵ尡 'D9'�� ���� �μ�����
-- '������ȹ��'���� ����

UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��';
-- 9�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT * FROM DEPT_COPY; --> ��� '������ȹ��' ���� �ٲ�

ROLLBACK;

UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';
-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT * FROM DEPT_COPY;

COMMIT;

-- ���� �÷��� �����ϴ� ���


-- DEPT_COPY ���̺��� �μ��ڵ尡 'D8'�� �μ���
-- �μ��� : ��������� / �����ڵ� : L2�� ����
UPDATE DEPT_COPY
SET DEPT_TITLE = '���������',
     LOCATION_ID = 'L2'
WHERE DEPT_ID = 'D8';

SELECT * FROM DEPT_COPY;

ROLLBACK;


-- UPDATE + ��������

/* [�ۼ���]
    UPDATE ���̺��
    SET �÷��� = (��������)
    [WHERE �÷��� �񱳽� (��������)]
*/

-- ��� �� ����� ����� �η����ϴ� ���� �����
-- �޿��� ���ʽ��� ����İ� �����ϰ� �������ֱ�� �ߴ�
-- �̸� �ݿ��ϱ� ���� SQL������ �ۼ��Ͻÿ�
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
    FROM EMPLOYEE;

-- �����, ������ �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME IN('�����','����');

-- ������ �޿�, ���ʽ��� ����İ� �Ȱ��� ����
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY
                    WHERE EMP_NAME='�����'),
     BONUS = (SELECT BONUS FROM EMP_SALARY
                    WHERE EMP_NAME='�����')
WHERE EMP_NAME = '����';

-- ���߿� ���������� �̿��� UPDATE��

-- ������ �޿� �λ� �ҽ��� ���ص���
-- ���ö, ������, ������, �ϵ����� ��ü�ľ��� �����ߴ�.
-- �̸� �ذ��ϱ� ���� �� 4���� �޿�, ���ʽ��� ����İ� �Ȱ��� �ٲ��ֱ�� �ߴ�.
-- �̸� �ݿ��� SQL ������ �ۼ��Ͻÿ�
SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN('���ö','������','������','�ϵ���');

UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                                   FROM EMP_SALARY
                                   WHERE EMP_NAME='�����')
WHERE EMP_NAME IN('���ö','������','������','�ϵ���');
-- 4�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
                 
SELECT * FROM EMP_SALARY;

-- EMP_SALARY ���̺���
-- BONUS�� ���� ���ϴ� ����� BONUS�� 0.1�� ����
UPDATE EMP_SALARY
SET BONUS = 0.1
WHERE BONUS IS NULL;

SELECT * FROM EMP_SALARY;

ROLLBACK;

-- EMP_SALARY ���̺���
-- BONUS�� ���� ���ϴ� ����� BONUS�� 0.1,
-- BONUS�� �޴� ������� 0.1�� ������ ������ ����
UPDATE EMP_SALARY E
SET BONUS = (SELECT NVL2(BONUS, BONUS + 0.1, 0.1)
                     FROM EMP_SALARY M
                     WHERE E.EMP_ID = M.EMP_ID);
                     
UPDATE EMP_SALARY
SET BONUS = NVL(BONUS, 0) +0.1;

ROLLBACK;

SELECT * FROM EMP_SALARY;

-- EMP_SALARY ���̺���
-- ASIA ������ �ٹ��ϴ� ������ ���ʽ��� 0.5�� ����
UPDATE EMP_SALARY
SET BONUS = 0.5
WHERE DEPT_CODE IN (SELECT DEPT_ID FROM DEPARTMENT 
                                  LEFT JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
                                  WHERE LOCAL_NAME LIKE 'ASIA_');
                        
SELECT * FROM EMP_SALARY;

ROLLBACK;

--------------------------------------------------------------------------------

-- UPDATE�� ���ǻ���
    --> UPDATE�� ������ ���� �ش� �÷��� ���� ������ �����ϸ� �ȵ�

SELECT * FROM USER_FK;
SELECT * FROM USER_GRADE;

UPDATE USER_FK
SET GRADE_CODE = 40 -- USER_GRADE���̺� GRADE_CODE �÷� �� �� ���� ���� �ۼ���
WHERE USER_NO = 1;
-- ORA-02291: integrity constraint (KH.GRADE_CODE_FK) violated - parent key not found






--------------------------------------------------------------------------------

/* 4. DELETE
    - ���̺��� ���� �����ϴ� ����
    - ���̺� ��ü �� ������ �پ��
    
    
    [�ۼ���]
    DELETE FROM ���̺��
    [WHERE �÷��� �񱳿����� �񱳰�]
    
    -> WHERE���� �ۼ����� �ʴ� ���
        �ش� ���̺��� ��� �����Ͱ� DELETE��
*/

COMMIT;

DELETE FROM EMPLOYEE
WHERE EMP_NAME ='��ä��';
-- 1 �� ��(��) �����Ǿ����ϴ�.

SELECT * FROM EMPLOYEE
WHERE EMP_NAME='��ä��'; -- ��ȸ �ȵ�

ROLLBACK;

-- WHERE�� ���ۼ� �� ��� ���� ������
SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY; -- 24�� �� ��(��) �����Ǿ����ϴ�.

ROLLBACK;

-- FK ���� ���� �� ������ �����ɼ��� �������� ���� ���� ���� �Ұ���
DELETE FROM USER_GRADE
WHERE GRADE_CODE = '10';
-- ORA-02292: integrity constraint (KH.GRADE_CODE_FK) violated - child record found

-- ���� �� FK ���� ������ ��Ȱ��ȭ �ϸ� ������ �����ϴ�
ALTER TABLE USER_FK
DISABLE CONSTRAINT GRADE_CODE_FK CASCADE;

SELECT * FROM USER_FK;
SELECT * FROM USER_GRADE;

-- �������� Ȱ��ȭ
ALTER TABLE USER_FK
ENABLE CONSTRAINT GRADE_CODE_FK;

INSERT INTO USER_GRADE
VALUES(10, '�Ϲ�ȸ��');


-- TRUNCATE : ���̺��� ��ü���� �����ϴ� DDL
-- DELETE���� ����ӵ��� ������, ROLLBACK���� ������ �Ұ�����

CREATE TABLE EMP_SALARY2
AS SELECT * FROM EMP_SALARY;

SELECT * FROM EMP_SALARY2;

COMMIT;

DELETE FROM EMP_SALARY2;
ROLLBACK;

TRUNCATE TABLE EMP_SALARY2;
SELECT * FROM EMP_SALARY2;
ROLLBACK;













