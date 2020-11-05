/* DDL(Data Definition Language) : ������ ���� ���
    - ��ü(OBJECT)�� �����(CREATE), ����(ALTER)�ϰ�, ����(DROP)�ϴ� ����

  * ALTER
    - ��ü�� �����ϴ� ����
    
     [���̺� ���� �ۼ���]
     ALTER TABLE ���̺�� ������ ����;
     
     -> ������ ����
        -- �÷� �߰�/����
        -- �������� �߰�/����
        -- �÷��� �ڷ��� ����
        -- �÷��� DEFAULT�� ����
        -- �÷���, �������Ǹ�, ���̺�� ����
*/

-- 1. �÷� �߰�, ����, ����
SELECT * FROM DEPT_COPY;

-- 1) �÷� �߰�(ADD)
ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20));

SELECT * FROM DEPT_COPY;

-- �÷� �߰� �� DEFAULT �� ����
ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT '�ѱ�');

SELECT * FROM DEPT_COPY;

-- 2) �÷� ����(MODIFY)
ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR2(30)
MODIFY LOCATION_ID VARCHAR2(10)
MODIFY LNAME DEFAULT '�̱�';

-- �÷� ���� �� ���ǻ���
--> ũ�⸦ �����Ϸ��� �÷��� ���� ���� ũ�⺸�� ū �����Ͱ� ������ �������� ����

SELECT LENGTHB(DEPT_TITLE)
FROM DEPT_COPY
WHERE DEPT_TITLE = '�����ú�';

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(10);
-- ORA-01441: cannot decrease column length because some value is too big


-- 3) �÷� ����(DROP COLUMN �÷���)
-- �÷� ���� �����ص� �÷��� ������
-- ������ �÷��� �������� ����(DDL�� �ٷ� DB�� �ݿ���)
-- ��� �÷��� ������ ���� ����(���̺��� �ּ� �� �� �̻��� �÷��� �����ؾ� ��)

CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_ID;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2
DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2
DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2
DROP COLUMN LNAME;

SELECT * FROM DEPT_COPY2;

-- ������ ���� �÷� ����
ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE;
-- ORA-12983: cannot drop all columns in a table

-- �÷� ���� �� ���ǻ���
    --> �÷� ���� �� FK ���������� ������ �÷��� �������� ����
    
    

--------------------------------------------------------------------------------

/* 2. ���� ���� �߰�, ����

    1) ���� ���� �߰�(ADD, MODIFY(NOT NULL �߰� ��))
    
    [�ۼ���]
    ALTER TABLE ���̺��
    ADD CONSTRAINT �������Ǹ� ��������(�÷���);
    
    (NOT NULL�� ���)
    ALTER TABLE ���̺��
    MODIFY �÷��� CONSTRAINT �������Ǹ� NOT NULL;
*/

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DC_ID_PK PRIMARY KEY(DEPT_ID);

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DC_TITLE_UK UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DC_LNAME_NN NOT NULL;
--> SQLDEVELOPER ����


-- ���� ���̺� FK ���� ���� �߰��ϱ�

-- EMPLOYEE - DEPARTMENT FK �߰�
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_DCODE_FK FOREIGN KEY(DEPT_CODE)
REFERENCES DEPARTMENT/*(DEPT_ID)*/;

-- EMPLOYEE - JOB
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_JCODE_FK FOREIGN KEY(JOB_CODE)
REFERENCES JOB/*(JOB_CODE)*/;

-- EMPLOYEE - SAL_GRADE
ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMP_SLEV_FK FOREIGN KEY(SAL_LEVEL)
REFERENCES SAL_GRADE /*(SAL_LEVEL)*/; -- �ܷ�Ű�� ������ �÷��� ������ ���̺��� �⺻Ű�̸� ��������

-- DEPARTMENT - LOCATION
ALTER TABLE DEPARTMENT
ADD CONSTRAINT DEPT_LID_FK FOREIGN KEY(LOCATION_ID)
REFERENCES LOCATION/*LOCATION_ID*/;

-- LOCATION - NATIONAL
ALTER TABLE LOCATION
ADD CONSTRAINT LOCA_NCODE_FK FOREIGN KEY(NATIONAL_CODE)
REFERENCES NATIONAL/*NATIONAL_CODE*/;


-- 2) ���� ���� ����(DROP)
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DC_TITLE_UK;


-- NOT NULL �������� ���� �� MODIFY ���
ALTER TABLE DEPT_COPY
MODIFY LNAME NULL;



--------------------------------------------------------------------------------

-- 3. �÷�, ��������, ���̺� �̸� ����(RENAME)

-- 1) �÷��� ����
-- DEPT_COPY ���̺��� DEPT_TITLE -> DEPT_NAME ����
ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

SELECT * FROM DEPT_COPY;

-- 2) ���� ���Ǹ� ����
ALTER TABLE DEPT_COPY
RENAME CONSTRAINT DC_ID_PK TO DCOPY_DID_PK;

ALTER TABLE DEPT_COPY
RENAME CONSTRAINT SYS_C007080 TO DCOPY_DID_NN;

-- 3) ���̺�� ����
ALTER TABLE DEPT_COPY
RENAME TO DCOPY;

SELECT * FROM DEPT_COPY; -- �������� ����
SELECT * FROM DCOPY;


--------------------------------------------------------------------------------

-- 4. ���̺� ����(DROP TABLE)
-- DCOPY ����
CREATE TABLE DCOPY2
AS SELECT * FROM DCOPY;

SELECT * FROM DCOPY2;

-- DCOPY2�� PK �߰�
ALTER TABLE DCOPY2
ADD CONSTRAINT DCOPY2_DID_PK PRIMARY KEY(DEPT_ID);


-- EMPLOYEE ����
CREATE TABLE EMP_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_COPY;


-- EMP_COPY�� DCOPY2 FK ����
ALTER TABLE EMP_COPY
ADD CONSTRAINT ECOPY_DCODE_FK FOREIGN KEY(DEPT_CODE)
REFERENCES DCOPY2;

-- FK ����������(���谡 �������� ����) ���� ���̺� ����
DROP TABLE DCOPY;

SELECT * FROM DCOPY;


-- ���谡 �����Ǿ� �ִ� ���̺� ����
DROP TABLE DCOPY2 CASCADE CONSTRAINT;
-- ORA-02449: unique/primary keys in table referenced by foreign keys

-- CASCADE CONSTRAINT : EMP_COPY�� �ִ� FK �������� ����












