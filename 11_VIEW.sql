/* VIEW(��)
   - SELECT���� ���� ���(RESULT SET)�� ������ ������ ���� ���̺� ��ü
   
   - ���������� �����͸� �����ϰ� ���� ����
   
   - ���̺��� ����ϴ� �Ͱ� �����ϰ� ����� �� ����
   
   
   * VIEW ��� ����
     1) ������ SELECT �������� �ܼ�ȭ�Ͽ� ���� ���
     2) ���̺��� ��¥ ����� ���� �� �־� ���Ȼ� ������
     
   * VIEW�� ����
     1) ALTER ������ ����� �� ����.(VIEW�� ���� ���̺� �̹Ƿ� ���� �Ұ���)
     2) VIEW�� �̿��� DML�� ����� ���� ������ ������ ����
       -> SINGLE TABLE VIEW������ �κ������� DML ��� ����
       
   ** ���������� VIEW�� �̿��� DML�� ����ǰ� ������
       SELECT �뵵�θ� �����

    [�ۼ���]
    CREATE [OR REPLACE] VIEW ���̸�
    AS ��������;
*/

-- 1. VIEW ��� ����

-- ��� ���, �̸�, �μ���, �ٹ������� ��ȸ�ϴ� SELECT�� �ۼ� ��
-- �ش� ����� VIEW�� �����ؼ� ����
CREATE VIEW V_EMPLOYEE
AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
LEFT JOIN NATIONAL USING(NATIONAL_CODE);
-- ORA-01031: insufficient privileges : �� ���� ������ ����
--> sys as sysdba�� ������ ��ȯ�� �� kh ������ VIEW ���� ������ �ο�
GRANT CREATE VIEW TO kh;
--> �ٽ� kh �������� ���� ���� �� ���� �ִ� VIEW ���� ������ �ٽ� ����
--View V_EMPLOYEE��(��) �����Ǿ����ϴ�.

SELECT * FROM V_EMPLOYEE;

-- * VIEW�� ������ ���̺��̴�.
--> ���� �����ϴ� ���̺��� �ƴ϶�
-- ����� �Ǵ� ���̺���� �����͸� �̿��ؼ� ����� �����ִ� ��

COMMIT;

-- ����� 205�� ������ �̸��� '���߾�'���� ����
SELECT * FROM EMPLOYEE
WHERE EMP_ID = 205;

UPDATE EMPLOYEE
SET EMP_NAME = '���߾�'
WHERE EMP_ID = 205;

-- ���̽����̺� Ȯ��
SELECT EMP_NAME FROM EMPLOYEE
WHERE EMP_ID = 205; -- ���߾�

-- V_EMPLOYEE������ Ȯ��
SELECT EMP_NAME FROM V_EMPLOYEE
WHERE EMP_ID = 205; -- ���߾�

ROLLBACK;

--------------------------------------------------------------------------------
COMMIT;

UPDATE V_EMPLOYEE
SET EMP_NAME = '���߾�'
WHERE EMP_ID = 205;

SELECT * FROM EMPLOYEE
WHERE EMP_ID = 205;

ROLLBACK;


/* 2. DML�� ������ �Ұ����� ���

    1) VIEW�� ���Ե��� ���� �÷��� �����ϴ� ���
    2) VIEW�� ���Ե��� ���� �÷� �߿�
        ���̽� ���̺� �÷��� NOT NULL ���������� �ִ� ���
        
    3) VIEW�� �÷��� ��� ǥ�������� ���ǵ� ���    
    4) VIEW ���� �� ���������� GROUP BY���� ���ԵǾ� �ִ� ���
    5) VIEW�� �÷��� DISTINCT�� ���Ե� ���
    6) VIEW ������ ���� ���������� JOIN�� �ۼ��Ǿ� �ִ� ���
*/

-- 2) VIEW�� ���Ե��� ���� �÷� �߿�
--     ���̽� ���̺� �÷��� NOT NULL ���������� �ִ� ���
CREATE VIEW V_JOB3
AS SELECT JOB_NAME FROM JOB;

INSERT INTO V_JOB3 VALUES('����');
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")

-- VIEW�� �̿��� DML�� �����ϸ�
-- VIEW ��ü�� �����Ͱ� ���ϴ� ���� �ƴ϶�
-- ���̽� ���̺��� ���� ���ϰ� �ǰ�
-- �� ����� �ٽ� VIEW�� �����ϴ� ��


--------------------------------------------------------------------------------------------------------------------


--  1) VIEW�� ���Ե��� ���� �÷��� �����ϴ� ���
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_CODE
    FROM JOB;

SELECT * FROM V_JOB3;

-- 1) VIEW�� ���Ե��� ���� �÷��� �����ϴ� ���
INSERT INTO V_JOB3 VALUES('J8', '����');

UPDATE V_JOB3
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';

DELETE FROM V_JOB2
WHERE JOB_NAME = '���';


--INSERT INTO V_JOB2 VALUES('J8');

SELECT * FROM JOB;


--------------------------------------------------------------------------------------------------------------------

--   2) VIEW�� ���Ե��� ���� �÷� �߿�
--       ���̽� ���̺� �÷��� NOT NULL ���������� �ִ� ���
-- INSERT�ÿ� ����
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME
    FROM JOB;
    
SELECT * FROM V_JOB3;

INSERT INTO V_JOB3 VALUES('����');
-- ���̽� ���̺��� JOB�� JOB_CODE�� NOT NULL ���������� �����Ǿ�����. --> ����

INSERT INTO V_JOB3 VALUES ('J8', '����');
--  �信 ���ǵ��� ���� �÷� ���� --> ����

-- UPDATE/DELETE�� �������� ����
INSERT INTO JOB VALUES('J8','����');

SELECT * FROM V_JOB3;

UPDATE V_JOB3 SET JOB_NAME = '�˹�'
WHERE JOB_NAME = '����';

SELECT * FROM V_JOB3;
SELECT * FROM JOB;

DELETE FROM V_JOB3
WHERE JOB_NAME = '�˹�';

SELECT * FROM V_JOB3;
SELECT * FROM JOB;


--------------------------------------------------------------------------------------------------------------------

--  3) VIEW�� �÷��� ��� ǥ�������� ���ǵ� ���
CREATE OR REPLACE VIEW EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY,
	    (SALARY + (SALARY*NVL(BONUS, 0)))*12 ����
     FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

-- �信 ��� ������ ���Ե� ��� INSERT/UPDATE �� ���� �߻�
INSERT INTO EMP_SAL VALUES(800, '������', 3000000, 36000000);

UPDATE EMP_SAL
SET ���� = 8000000
WHERE EMP_ID = 200;


-- DELETE�� ���� ��� ����
COMMIT;

DELETE FROM EMP_SAL
WHERE ���� = 124800000;

SELECT * FROM EMP_SAL;
SELECT * FROM EMPLOYEE;

ROLLBACK;


--------------------------------------------------------------------------------------------------------------------

-- 4) VIEW ���� �� ���������� GROUP BY���� ���ԵǾ� �ִ� ���
CREATE OR REPLACE VIEW V_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) �հ�, AVG(SALARY) ���
     FROM EMPLOYEE
     GROUP BY DEPT_CODE;
     
SELECT * FROM V_GROUPDEPT;

-- �׷��Լ� �Ǵ� GROUP BY�� ����� ��� INSERT/UPDATE/DELETE �� ���� �߻�
INSERT INTO V_GROUPDEPT
VALUES ('D10', 6000000, 4000000);  -- ������

UPDATE V_GROUPDEPT
SET DEPT_CODE = 'D10'
WHERE DEPT_CODE = 'D1';

DELETE FROM V_GROUPDEPT
WHERE DEPT_CODE = 'D1';


--------------------------------------------------------------------------------------------------------------------

--   5) VIEW�� �÷��� DISTINCT�� ���Ե� ���

CREATE OR REPLACE VIEW V_DT_EMP
AS SELECT DISTINCT JOB_CODE
     FROM EMPLOYEE;
     
SELECT * FROM V_DT_EMP;     
    
-- DISTINCT�� ����� ��� INSERT/UPDATE/DELETE �� ���� �߻�    
INSERT INTO V_DT_EMP VALUES(��J9��);

UPDATE V_DT_EMP
SET JOB_CODE = 'J9'
WHERE JOB_CODE = 'J7';

DELETE FROM V_DT_EMP WHERE JOB_CODE = ��J1��;


--------------------------------------------------------------------------------------------------------------------

-- 6) VIEW ������ ���� ���������� JOIN�� �ۼ��Ǿ� �ִ� ���
CREATE OR REPLACE VIEW V_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
     
SELECT * FROM V_JOINEMP;

-- �� ���� �� JOIN�� ����� ��� INSERT/UPDATE �� ���� �߻�
INSERT INTO V_JOINEMP VALUES(888, ����������, ���λ�����Ρ�);

UPDATE V_JOINEMP
SET DEPT_TITLE = '�λ������'
WHERE EMP_ID = 219; 

-- �� DELETE�� ����
COMMIT;

DELETE FROM V_JOINEMP
WHERE EMP_ID = 219;

SELECT * FROM V_JOINEMP;
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

ROLLBACK;

--------------------------------------------------------------------------------------------------------------------

/* 3. VIEW�� ����
 
 - �� ���� �� ����� SELECT���� TEXT��� �÷��� ����Ǿ� ������
   �䰡 ȣ��Ǵ� ��� TEXT�÷��� ��ϵ� SELECT���� �ٽ� �����Ͽ�
   �� ����� �����ִ� ������
*/

-- USER_VIEWS : ����� ���� �並 Ȯ���ϴ� ��ųʸ� ��
SELECT * FROM USER_VIEWS;

"SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
LEFT JOIN NATIONAL USING(NATIONAL_CODE)"

--------------------------------------------------------------------------------------------------------------------

/* 4. VIEW �ɼ�

  [�ۼ���]
  CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���̸�[(��Ī[, ��Ī...])]
  AS ��������
  [WITH CHECK OPTION]
  [WHIT READ ONLY]
  
  WHIT CHECK OPTION : �ɼ��� ������ �÷� ���� ���� �Ұ����ϰ� ����� �ɼ�
  WHIT READ ONLY : �並 �б� �������� ����ϴ� �ɼ�(SELECT�� ����)

*/
CREATE VIEW V_EMP_JOB
AS
SELECT EMP_ID ���, EMP_NAME �̸�, JOB_NAME ���޸�,
  DECODE( SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') ����
FROM EMPLOYEE
NATURAL JOIN JOB;
-- ORA-00998: must name this expression with a column alias

SELECT * FROM V_EMP_JOB;


CREATE OR REPLACE VIEW V_EMP_JOB(���, �̸�, ���޸�, ����)
AS
SELECT EMP_ID, EMP_NAME, JOB_NAME,
  DECODE( SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��')
FROM EMPLOYEE
NATURAL JOIN JOB;

--------------------------------------------------------------------------------------------------------------------

-- FORCE / NOFORCE
-- VIEW ���� �� ���Ǵ� ���������� ���̽� ���̺��� �������� �ʾƵ�
-- VIEW�� ������ �� �ִ�/���� �� ������ �ɼ�
-- NOFORCE�� �⺻��
CREATE OR REPLACE FORCE VIEW V_EMP
AS SELECT TCODE, TNAME, TCONTENT
FROM TT;
-- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.

SELECT * FROM V_EMP;











