/*
  DCL(Data Control Language) : ������ ���� ���
     - �����ͺ��̽�, �����ͺ��̽� ��ü�� ���� ���� ������ ����(�ο�, ȸ��)�ϴ� ���
     
     - GRANT(���� �ο�), REVOKE(���� ȸ��)
     
     - ������ ���� : �ý��� ����, ��ü ����
*/

/* 1. �ý��� ����
 - ������� ��ü ����/����, �����ͺ��̽� ���ӵ ���õ� ������ �ǹ���

    [�ۼ���]
        GRANT ����1, ����2, .....
        TO ����ڸ�;
        
        REVOKE ����1, ����2 .....
        FROM ����ڸ�;
*/

-- �ý��� ���� ���� 
/*
CRETAE SESSION   : �����ͺ��̽� ���� ����
CREATE TABLE    : ���̺� ���� ����
CREATE VIEW      : �� ���� ����
CREATE SEQUENCE  : ������ ���� ����
CREATE PROCEDURE : �Լ�(���ν���) ���� ����
CREATE USER      : �����(����) ���� ����
DROP USER        : �����(����) ���� ����
DROP ANY TABLE   : ���� ���̺� ���� ����
*/

/* ������ ����
    1) ������ ���� : �����ͺ��̽��� ������ ������ ����ϴ� �����̸�
                          ��� ���Ѱ� å���� ������ ����(SYS, SYSTEM)
    
    2) ����� ���� : �����ͺ��̽��� ���Ͽ�
                          ����, ����, ���� �ۼ� ���� �۾��� ������ �� �ִ� ��������
                          ������ �ʿ��� �ּ����� ���Ѹ� ������ ���� ��Ģ���� �Ѵ�.
*/

-- SQL DEVELOPER(sys)
-- �׽�Ʈ�� ���� ����(sample)
CREATE USER sample IDENTIFIED BY sample;
-- User SAMPLE��(��) �����Ǿ����ϴ�.

-- SQLPLUS���� sample �������� �α��� �õ�
-- PRA-01045: user SAMPLE lacks CREATE  SESSION privilege; logon denied
--> CREATE SESSION ������ ��� �α��� ����

-- SQL DEVELOPER(sys)
-- sample ������ DB���� ������ �ο�
GRANT CREATE SESSION TO sample;
-- Grant��(��) �����߽��ϴ�.
--> SQLPLUS���� �ٽ� sample ���� �α��� �غ���

-- SQLPLUS(sample)
CREATE TABLE TEST(
  TID NUMBER PRIMARY KEY
   );
-- ORA-01031: insufficient privileges
--> ���̺� ���� ������ ��� ���� �߻�

-- SQL DEVELOPER(sys)
-- sample ������ ���̺� ���� ���� �ο�
GRANT CREATE TABLE TO sample;
-- Grant��(��) �����߽��ϴ�.

-- SQLPLUS(sample)
-- ���̺� ���� ����(CREATE TABLE)�� �ο��� ���¿��� �ٽ� ���̺� ����
-- ORA-01950: no privileges on tablespace 'SYSTEM' ���� �߻�

-- SQL DEVELOPER(sys)
-- sample ������ ���̺� �����̽� �Ҵ緮 �ο�
ALTER USER sample QUOTA 2M ON SYSTEM;
-- User SAMPLE��(��) ����Ǿ����ϴ�.

-- SQLPLUS(sample)
-- �ٽ� TEST ���̺� �����غ��� -> Table created.(���̺� ���� ����)

--------------------------------------------------------------------------------


/*
    ROLE : ����ڿ��� �㰡�� �� �ִ� ���ѵ��� ����
             ROLE�� �̿��ϸ� ���� �ο�/ȸ���� ������
             
             CONNECT : ����ڰ� DB�� ���� �����ϵ��� �ϴ�
                             CREATE SESSION�� ������ �ۼ��Ǿ��ִ� ROLE
             
             RESOURCE : CREATE ������ �̿��� ��ü ���� ���Ѱ�
                              INSERT, UPDATE, DELETE ������ ����� �� �ֵ��� �ϴ� 
                              ������ ��Ƶ� ROLE
*/

-- ROLE �׽�Ʈ�� ���ؼ� sample ���� ���� �� �ٽ� ����

-- SQLPLUS(sample)
-- ���� �� ���� ���� ����
EXIT;
-- Disconnected from Oracle Database

-- SQL DEVELOPER(sys)
-- sample ���� ����
DROP USER sample CASCADE;

-- �ٽ� sample ���� ����
CREATE USER sample IDENTIFIED BY sample;
-- User SAMPLE��(��) �����Ǿ����ϴ�.

-- ROLE�� �̿��Ͽ� sample ������ DB ���� ���� + �⺻ �ڿ� ��� ���� �ο�
GRANT CONNECT, RESOURCE TO sample;
-- Grant��(��) �����߽��ϴ�.

-- SQLPLUS�� �ٽ� Ű�� sample�� �α��� �� TEST ���̺� �ٽ� ����
--> �������� ����, ���̺� ������ �����

--------------------------------------------------------------------------------
/* 2. ��ü ����
    - Ư�� ��ü�� ������ �� �ִ� ����
    
    [�ۼ���]
    GRANT ��������[(�÷���)] | ALL
    ON ��ü�� | ROLE �̸� | PUBLIC
    TO ����ڸ�;
*/

-- SQLPLUS(sample)
-- sample �������� kh������ �ִ� EMPLOYEE ���̺� ��ȸ�ϱ�
SELECT * FROM kh.EMPLOYEE;
-- ORA-00942: table or view does not exist
--> kh������ EMPLOYEE ���̺� ���� ���� ������ ��� ���� �߻�

-- SQL DVELOPER(kh)
-- sample �������� kh������ EMPLOYEE ���̺��� ��ȸ�� �� �ֵ���
-- ��ü ���� �ο� ����
-- ��ü ���� ����
/*
   ���� ����         ���� ��ü
   SELECT              TABLE, VIEW, SEQUENCE
    INSERT              TABLE, VIEW
    UPDATE              TABLE, VIEW
    DELETE              TABLE, VIEW
    ALTER               TABLE, SEQUENCE
    REFERENCES          TABLE
    INDEX               TABLE
    EXECUTE             PROCEDURE
*/

GRANT SELECT ON kh.EMPLOYEE TO sample;
-- Grant��(��) �����߽��ϴ�.

-- SQLPLUS(sample)
-- �ٽ� kh.EMPLOYEE ��ȸ
SELECT * FROM kh.EMPLOYEE;

-- SQL DEVELOPER(kh)
-- sample ������ �ο��ߴ� EMPLOYEE ���̺� SELECT ������ ȸ��
REVOKE SELECT ON kh.EMPLOYEE FROM sample;

-- ���� ȸ�� �� SQLPLUS(sample)���� �ٽ� kh.EMPLOYEE ��ȸ�غ���
-- ORA-00942: table or view does not exist

-- ROLE ���� Ȯ��(SYS)
SELECT grantee, privilege
    FROM DBA_SYS_PRIVS
    WHERE grantee IN('CONNECT' ,'RESOURCE');
    
-- ����ڿ��� �ο��� ���� Ȯ��(����� ����)
SELECT *
 FROM USER_ROLE_PRIVS;















