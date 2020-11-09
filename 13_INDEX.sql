/* INDEX(�ε���)

    - SQL���� �˻� ó�� �ӵ��� ����Ű�� ���ؼ�
      �÷��� ���� �����ϴ� ����Ŭ ��ü
      
      - �ε��� ���� ������ B* Ʈ���������� �����Ǿ� ����
      
      * �ε����� ����
        - ����Ʈ�� �������� �����Ǿ� �־� �ڵ� ���� ��, �˻� �ӵ��� ����
        - �ý��ۿ� �ɸ��� ���ϸ� �ٿ� �ý��� ��ü ���� ���
        
      * �ε����� ����
        - �ε����� �߰��ϱ� ���� ������ ���� ������ �ʿ���
        - �ε����� �����ϴµ� �ð��� �ɸ�
        - ������ ���� �۾�(DML(INSERT, UPDATEM DELETE) )�� ����ϰ� �߻��ϴ� ��쿡��
          ������ ���� ���ϸ� �ʷ���
*/

----------------------------------------------------------------------------------------------------------

/* �ε��� ���� ���
 CREATE [UNIQUE] INDEX �ε�����
 ON ���̺��(�÷��� | �Լ��� | ����, ....);
*/

-- �ε��� ����
--> ROWID : DB�� ������ ���� �ּ�
SELECT ROWID, EMP_ID, EMP_NAME
FROM EMPLOYEE;
-- AAAE5e AAB AAALC5 AAB
-- 1~6 : ������ ������Ʈ ��ȣ
-- 7~9 : ���� ��ȣ
-- 10~15 : BLOCK ��ȣ
-- 16~18 : ROW ��ȣ

-- �����ͺ��̽��� ���� ������ �������� ����
--> �׷��� ORDER BY���� �����

-- ���̺� ���� ���� �� PK�� ������ �÷��� 
-- �ڵ����� INDEX�� �����ȴ�.(�ڡڡڡڡ�)

-- �ε��� Ȱ�� ���

-- 1) �ε����� Ȱ������ ���� SELECT��
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE; -- 0.004��

-- 2) �ε����� Ȱ���� SELECT��
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID > 0; -- 0.003��
--> WHERE���� �ε����� ������ �÷��� ���ԵǸ� ��

--> �����Ͱ� 26�� �ۿ� ��� �ӵ� ���̰� �Ⱥ���


-- �ε��� �׽�Ʈ�� ���̺� ����
CREATE TABLE BOARD(
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TITLE VARCHAR2(300) NOT NULL,
    BOARD_CONTENT CLOB NOT NULL,
    BOARD_COUNT NUMBER DEFAULT 0,
    BOARD_CREATE_DT DATE DEFAULT SYSDATE,
    BOARD_MODIFY_DT DATE DEFAULT SYSDATE,
    BOARD_STATUS CHAR(1) DEFAULT 'Y' CHECK(BOARD_STATUS IN ('Y','B','N')),
    BOARD_WRITER NUMBER NOT NULL,
    BOARD_CATEGORY NUMBER NOT NULL,
    BOARD_TYPE NUMBER NOT NULL
);

CREATE SEQUENCE SEQ_BNO
START WITH 1
INCREMENT BY 1
MAXVALUE 10000000
NOCYCLE
NOCACHE;

/* PL/SQL (Precedural Language extention to SQL)
    - ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
    - SQL ���� ������ ������ ����, ����ó��(IF), �ݺ�ó��(FOR, WHILE, LOOP)���� �����Ͽ�
      SQL�� ������ ������ ���
*/

BEGIN
 FOR N IN 1..1000000 LOOP
 
    INSERT INTO BOARD
    VALUES(SEQ_BNO.NEXTVAL, N || '��° �Խñ�',
               N || '��° �Խñ��� �����Դϴ�.',
               DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1,
               CEIL( DBMS_RANDOM.VALUE(0,6) ) *10, 1 );
    END LOOP;

    COMMIT;
END;
/

-- �ε��� Ȱ�� X
SELECT * FROM BOARD
WHERE BOARD_TITLE = '500000��° �Խñ�'; -- 1.491��

-- �ε��� Ȱ�� O
SELECT * FROM BOARD
WHERE BOARD_NO = 500000; -- 0.004��

----------------------------------------------------------------------------------------------------------

/* �ε��� ����
    
    1. ���� �ε���(UNIQUE INDEX)
    2. ����� �ε���(NON UNIQUE INDEX)
    
    3. ���� �ε���(SIGLE INDEX)
        -> �� ���� �÷����� ������ �ε���
        
    4. ���� �ε���(COMPOSITE INDEX)
        -> �� �� �̻��� �÷����� ������ �ε���
        
    5. �Լ� ��� �ε���(FUNCTION BASED INDEX)
        -> SELECT���̳� WHERE���� �ۼ��� ��� �Ǵ� �Լ��Ŀ� �ο��ϴ� �ε��� 
*/

-- 1. ���� �ε���(UNIQUE INDEX)
/*
    - ���� �ε����� ������ �÷��� �ߺ��� ���� �Ұ�(UNIQUE �������� ����)
        --> �ߺ����� �̹� ���Ե� �÷����� ���� �ε��� ���� �Ұ�
        
    - ���̺� ���� �� �Ǵ� �������� �߰� SQL����
      PRIMARY KEY, UNIQUE ���������� �����Ǵ� ���
      ���� INDEX�� �÷���  ���ٸ� �ڵ����� INDEX�� ������

  * PK�� �̿��Ͽ� �˻��ϴ� ��� ���� ��� ū ȿ���� ����
*/

-- BOARD ���̺��� BOARD_TITLE �÷��� ���� �ε��� ����
CREATE UNIQUE INDEX IDX_BOARD_TITLE
ON BOARD(BOARD_TITLE);

-- ����ڰ� ������ �ε��� ��ȸ
SELECT INDEX_NAME, TABLE_NAME, UNIQUENESS
FROM USER_INDEXES
WHERE TABLE_NAME = 'BOARD';

SELECT * FROM BOARD
WHERE BOARD_TITLE = '500000��° �Խñ�';

-- ���� �ε��� �������� ���� BOARD_TITLE �÷��� UNIQUE ���������� ����.
 INSERT INTO BOARD
        VALUES(SEQ_BNO.NEXTVAL,  '500000��° �Խñ�',
                    '500000��° �Խñ��� �����Դϴ�.',
                    DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1,
                    50, 1 );
-- ORA-00001: unique constraint (KH.IDX_BOARD_TITLE) violated

-- �ε��� ����
DROP INDEX IDX_BOARD_TITLE;

-- 2. ����� �ε���(NONUNIQUE INDEX)
-- �÷��� �ߺ����� ������ ����ϰ� ��ȸ�Ǵ� �÷��� ������� ����
-- �ַ� ��ȸ ���� ����� ���� ���

CREATE INDEX IDX_BOARD_TITLE_NU
ON BOARD(BOARD_TITLE);

SELECT * FROM BOARD
WHERE BOARD_TITLE = '500000��° �Խñ�';

CREATE INDEX IDX_BARD_CT_NU
ON BOARD(BOARD_CATEGORY);

SELECT * FROM BOARD
WHERE BOARD_CATEGORY = 30;



------------------------------------------------------

-- �ε��� �籸��(INDEX REBUILD)

-- DML�۾�(Ư�� DELETE)����� ������ ���,
-- �ش� �ε��� ������ ��Ʈ���� �������θ� ���ŵǰ�
-- ���� ��Ʈ���� �׳� �����ְ� �ȴ�.
-- �ε����� �ʿ� ���� ������ �����ϰ� �ֱ� ������
-- �ε����� �� ������ �ʿ䰡 �ִ�.
ALTER INDEX IDX_BOARD_TITLE_NU REBUILD;

-- �ε��� ����
DROP INDEX IDX_BOARD_TITLE_NU;


-- ���� �ε����� 4���� �̻������� �����Ϳ��� ȿ�����̰� 
-- �ݴ�� ���� �������� �翡���� ������ ��ȿ�����̴�. 
-- DML�� ���� �������� ���� ���� ��ȸ������ ���̺����� ȿ���������� 
-- DML�� �����ϸ� �ٽ� �ε������� �����ؾߵǴ� �ð��� �� �ɸ���. --> ��ȿ����


/* �ε��� �籸��(INDEX REBUILD) �߰� ����

    ���̺� �����Ͱ� �߰�, ����, ����(DML)�� �Ͼ�� 
    �ش� ���̺� �����ϴ� �ε������� �߰�, ����, ������ �Ͼ
    
    �׷��� DML ����� �����ϸ� Ʈ���� �ұ����� ��Ÿ���� ��
        - INSERT : ����Ʈ���� ������ ������ �ʿ��� ��ġ�� ���ο� ������ �߰��ǰ�
                   ����� ������ �ٽ� ���ĵ� 
                   -> ���ο� ���� �߰� �� ����Ʈ�� �������θ� �߰��Ǿ� �ұ��� �߻� ����
                   
        - DELETE : �����Ͱ� �����Ǹ�, ������ �����Ϳ� ����� �ε��������� ����� �����Ͱ� �������θ� �����ǰ�
                   �����Ͱ� ����Ǿ� �ִ� ������ ������ ��� �����ְԵ� 
                   -> ���� ���� ����
                   
        - UPDATE : INSERT�� DELETE�� ���ÿ� �����
            
*/    
























