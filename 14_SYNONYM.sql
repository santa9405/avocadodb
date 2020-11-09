/* SYNONYM(���Ǿ�)
    - �ٸ� DB�� ���� ��ü�� ���� ���� �Ǵ� ���Ӹ�
    - ���� ����ڰ� ���̺��� ������ ���,
      �ٸ� ����ڰ� ���̺� �����ϴ� ����� �����ϰ� ����� ��ü
      
      [�ۼ���]
      CREATE SYNONYM ����(���Ӹ�)
      FOR ����ڸ�.��ü��;
*/

-- 1. ����� ���Ǿ�
-- ��ü�� ���� ���� ������ �ο����� ����ڰ� ������ ���Ǿ��
-- �ش� ����ڸ� ��� ����

-- SQL DEVELOPER(kh)
-- sample �������� kh�� BOARD���̺� ��ȸ ���� �ο�.
GRANT SELECT ON kh.BOARD TO sample;

-- SQLPLUS(sample)
-- kh.BOARD ���̺� ��ȸ
SELECT * FROM kh.BOARD
WHERE ROWNUM <= 100;

-- sample ������ kh.BOARD ���̺��� ���Ǿ�� KB SYNONYM ��ü�� ����
CREATE SYNONYM KB FOR kh.BOARD;
-- ORA-01031: insufficient privileges
--> SYNONYM ���� ������ ����

-- SQL DEVELOPER(sys as sysdba)
-- sample ������ SYNONYM ���� ������ �ο�
GRANT CREATE SYNONYM TO sample;


CREATE SYNONYM KB FOR kh.BOARD;

-- SQLPLUS(sample)���� SYNONYM ���� ���� �ٽ� ����
SELECT * FROM KB
WHERE ROWNUM <= 100; -- (��ȸ ����)

-- KB SYNONYM ����
DROP SYNONYM KB;

-- �ٽ� KB SYNONYM ���� �� SYS�������� KB ��ȸ
SELECT * FROM KB
WHERE ROWNUM <= 100;
--> �����ڿ��� ����� ���Ǿ�� ������ �� ����.
-- ���� GRANT ���̵� ����ڸ�.��ü������ ���� ����

----------------------------------------------------------------------------------------------------------

-- 2. ���� ���Ǿ�
-- ��� ������ �ִ� �����(DBA)�� ������ ���Ǿ��
-- ������ ���Ǿ�� ��� ����ڰ� ����� �� ����
-- ��ǥ���� ���� : DUAL

-- SQL DEVELOPER(sys as sysdba)
-- kh������ DEPARTMENT ���̺��� ���� ���Ǿ DEPT�� ����
CREATE PUBLIC SYNONYM DEPT FOR kh.DEPARTMENT;

-- ���� ���Ǿ� ���� ��ȸ�ϴ� ���
SELECT * FROM kh.DEPARTMENT;

-- ���Ǿ� ���� ��(sys as sysdba, kh)
SELECT * FROM DEPT;

-- SQLPLUS(sample)���� ��ȸ
SELECT * FROM DEPT;
-- ORA-00942: table or view does not exist
--> SELECT ������ ��� ��ȸ �Ұ�

-- SQL DEVELOPER(kh)
-- sample ������ kh.DEPARTMENT ���̺� ��ȸ ���� �ο�
GRANT SELECT ON kh.DEPARTMENT TO sample;
-- Grant��(��) �����߽��ϴ�.
-- SQLPLUS(sample)���� �ٽ� DEPT ��ȸ













