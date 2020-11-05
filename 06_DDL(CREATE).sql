/*
  DDL (Data Definition Language) : ������ ���� ���(�ڡڡڡڡ�)
  
  - ��ü(OBJECT)�� �����(CREATE), ����(ALTER), ����(DROP) �ϴ� ��
    ������ ��ü ������ �����ϴ� ����
    �ַ� DB������, �����ڰ� �����

  - ����Ŭ���� ���ϴ� ��ü :
    TABLE, VIEW, SEQUENCE, INDEX, PACKAGE, TRIGGER,
    PROCEDURE, FUNCTION, SYNONYM(���Ǿ�), USER

--------------------------------------------------------------------------------

 CREATE
 - ���̺��̳� ��, �ε��� �� �پ��� �����ͺ��̽� ��ü�� �����ϴ� ����
 
 - 1. ���̺� �����ϱ�
 
 - ���̺�(TABLE)�̶�? (�ڡڡ�)
   -- ��(ROW)�� ��(COLUMN)�� �����Ǵ� �����ͺ��̽��� ���� �⺻���� ��ü
   -- �����ͺ��̽� ������ ��� �����ʹ� ���̺��� ���� �����
   
   - ���̺� ���� SQL���� �ۼ���
   
   CREATE TABLE ���̺��(
     �÷��� ������Ÿ��(ũ��|�ڸ���),
     �÷��� ������Ÿ��(ũ��|�ڸ���),
     ...
   );

*/

-- CHAR : �������� ���� �ڷ���(2000 BYTE)
          --> ������ ����Ʈ���� ���� ���� �����Ͱ� ����Ǿ
          -- ���� �뷮�� ��ȯ���� ����

-- VARCHAR : �������� ���� �ڷ���(2000 BYTE)
            --> ������ ����Ʈ ���� ���� ���� �����Ͱ� ����� ���
            -- ���� ũ��(�뷮) ��ȯ
            
-- VARCHAR2 : 4000 BYTE �������� ���� �ڷ���            

-- ������ �����͸� 30����Ʈ ���� ������ �� �ִ� MEMBER_ID �÷�
CREATE TABLE MEMBER(
  MEMBER_ID VARCHAR2(30), 
  MEMBER_PWD VARCHAR2(30),
  MEMBER_NAME VARCHAR2(20),
  MEMBER_SSN CHAR(14),
  ENROLL_DATE DATE DEFAULT SYSDATE
);
-- DEFAULT SYSDATE : �ԷµǴ� ���� ���ų� DEFAULT�� �Էµ� ��� ���� �ð��� ����ض�

-- MEMBER ���̺� ���� Ȯ��
SELECT * FROM MEMBER;

-- 2. �÷��� �ڸ�Ʈ(�ּ�) �ޱ�
-- [�ۼ���]
-- COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.MEMBER_SSN IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS 'ȸ��������';

-- ����ڰ� ������ ���̺� ���� Ȯ��
SELECT * FROM USER_TABLES;

-- ��ųʸ� ��(Dictionary View)
-- USER_TABLES : ����ڰ� �ۼ��� ���̺��� Ȯ���ϴ� ��(������ ���̺�)

/* Data Dictionary(������ ��ųʸ�)(�ڡڡڡڡ�)

  - �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺�

  - ������ ��ųʸ��� ����ڰ� ���̺��� �����ϰų� ����ڸ� �����ϴ� ����
    �۾��� �� �� �����ͺ��̽� ������ ���ؼ� �ڵ����� ���ŵǴ� ���̺�
*/

SELECT USERNAME FROM DBA_USERS;
-- DBA_USERS : �����ͺ��̽��� �����ϴ� ��� �����(USER) ������ ��ȸ�ϴ� ��ųʸ� ��
-- (SYS AS SYSDBA �������θ� ����)

SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-- USER_TAB_COLUMNS : ���̺�, ��, Ŭ�������� �÷��� ���õ� ������ ��ȸ�ϴ� ��ųʸ� ��

DESC MEMBER;
-- DESC�� : ���̺��� ������ ǥ���ϴ� ����

-- MEMBER ���̺� ���� ������ ����
INSERT INTO MEMBER VALUES('MEM01','123ABC','ȫ�浿','000101-3345678',DEFAULT);

-- ������ ���� Ȯ��
SELECT * FROM MEMBER;

COMMIT;
-- ���̺� ���� ����(DML)�� ���� DB�� �ݿ��ϴ� TCL ����

-- ������ -> SYSDATE�� Ȱ��
INSERT INTO MEMBER VALUES ('MEM02', 'QWER1234', '�迵��', '971208-2123456', SYSDATE); 

-- ������ -> DEFAULT Ȱ��(���̺� ���� �� ���ǵ� ���� �ݿ���)
INSERT INTO MEMBER VALUES ('MEM03', 'ZZ9786', '��ö��', '900314-1122334',  DEFAULT); -- DEFAULT

-- ������ -> INSERT �� ���ۼ� �ϴ� ��� -> DEAFULT ���� �ݿ���
INSERT INTO MEMBER(MEMBER_ID, MEMBER_PWD, MEMBER_NAME, MEMBER_SSN)
VALUES ('MEM04', 'ASDQWE','������', '851011-2345678');

COMMIT;

SELECT * FROM MEMBER;


-- �ֹε�Ϲ�ȣ, ��ȭ ��ȣ �� ���ڰ� ���Ե� �������� �÷��� ���������� �ϴ� ����
CREATE TABLE MEMBER2(
  MEMBER_ID VARCHAR2(30), 
  MEMBER_PWD VARCHAR2(30),
  MEMBER_NAME VARCHAR2(20),
  MEMBER_SSN NUMBER,
  ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER2 VALUES ('MEM02', 'QWER1234', '�迵��', 0712082123456, SYSDATE); 

SELECT * FROM MEMBER2;
-- �ֹε�Ϲ�ȣ�� NUMBER�� ������ ��� ���� �� 0�� ������� ������ �߻�
  --> �̸� �ذ��ϱ� ���� ���� ������ Ÿ���� ���
  
  
--------------------------------------------------------------------------------
/*
  ���� ����(CONSTRAINTS)
  
  - ����ڰ� ���ϴ� ������ �����͸� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
  - ���̺� �ۼ� �� �� �÷��� ���� �� ��Ͽ� ���� ���� ���� ���� ����
  
  ���� ������ ����
  - ������ ���Ἲ ����. (�ߺ� ������X, NULL X)
  - �Է� �����Ϳ� ������ ���� �ڵ� �˻�
  - �������� ����/���� ���� ���� �˻�
  
  ���� ������ ����
  - PRIMARY KEY
  - NOT NULL
  - UNIQUE
  - CECK
  - FOERIGN KEY
*/

-- ���� ���� Ȯ�� ���
SELECT * FROM USER_CONSTRAINTS;
-- USER_CONSTRAINTS : ����ڰ� �ۼ��� ���� ������ Ȯ���ϴ� ��ųʸ� ��

SELECT * FROM USER_CONS_COLUMNS;
-- USER_CONS_COLUMNS : ���� ������ ������ �÷��� Ȯ���ϴ� ��ųʸ� ��


--------------------------------------------------------------------------------

-- 1. NOT NULL ���� ����
-- �ش� �÷��� �ݵ�� ���� ��ϵǾ�� �ϴ� ��� ����ϴ� ���� ����
-- ������ ����/���� �� NULL ���� ������� �ʵ���
-- �÷� �������� ������

-- NOT NULL ���������� ���� ���
CREATE TABLE USER_NOT_NN(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(20),
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOT_NN
VALUES(1,'USER01','PASS01','�迵��','��','010-1111-2222','USER01@naver.com');

INSERT INTO USER_NOT_NN
VALUES(2,NULL,NULL,NULL,'��','010-1111-2222','USER01@naver.com');

SELECT * FROM USER_CONSTRAINTS;

-- NOT NULL ���������� ������ ���
-- (��*10)NOT NULL ���� ������ ���̺� ���� �� �÷� �����θ� ���� ������!
CREATE TABLE USER_NN(
  USER_NO NUMBER NOT NULL, -- �÷� ���� �� ���� ���ǵ� ���� ���� --> �÷� ���� ����
  USER_ID VARCHAR2(20) NOT NULL,
  USER_PWD VARCHAR2(20) NOT NULL,
  USER_NAME VARCHAR2(30) NOT NULL,
  GENDER CHAR(3),
  PHONE VARCHAR2(30) NOT NULL,
  EMAIL VARCHAR2(50) NOT NULL
);

-- �ۼ��� ���� ���� Ȯ��(���� ������ ��� COLUMN�� �ִ���)
SELECT C1.TABLE_NAME, COLUMN_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'USER_NN';


INSERT INTO USER_NN
VALUES(1,'USER01','PASS01','�迵��','��','010-1111-2222','USER01@naver.com');

INSERT INTO USER_NN
VALUES(2,'USER02','PASS02','������','��','010-1111-2222','USER01@naver.com');
-- ORA-01400: cannot insert NULL into ("KH"."USER_NN"."USER_ID")
--> NOT NULL ���� ������ �����Ͽ� ���� �߻�

--------------------------------------------------------------------------------

/* 2. UNIQUE ���� ����
 - �÷� �Է°��� ���ؼ� �ߺ��� �����ϴ� ���� ����
 - �÷�/���̺� �������� ���� ���� ���� ����
 - ��, UNIQUE ���� ������ ������ �÷����� NULL �� �ߺ��� �����ϴ�
*/


-- USER_NN ���̺� �ߺ� ������ ����(���� -> ���Ἲ�� ħ��)
SELECT * FROM USER_NN;

INSERT INTO USER_NN
VALUES(1,'USER01','PASS01','�迵��','��','010-1111-2222','USER01@naver.com');


-- 1) �÷� ������  UNIQUE ���� ���� ����


-- UNIQUE ���� ���� ���̺� ����
CREATE TABLE USER_UK(
    USER_NO NUMBER,
    --USER_ID VARCHAR2(20) UNIQUE, -- �⺻ �÷� ���� ���� ���� ����
    USER_ID VARCHAR2(20) CONSTRAINT USER_ID_UK UNIQUE,
                      -- CONSTRAINT ���� ���Ǹ� ���� ����
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);



-- ������ ������� �ϳ��� ����
INSERT INTO USER_UK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');


INSERT INTO USER_UK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');
-- ORA-00001: unique constraint (KH.USER_ID_UK) violated
--> USER_ID �÷��� �ߺ������Ͱ� ���ԵǾ� UNIQUE ���� ������ ����

INSERT INTO USER_UK
VALUES(1, NULL, 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');
-- UNIQUE�� NULL �� ���� ����

INSERT INTO USER_UK
VALUES(1, NULL, 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');
-- UNIQUE�� NULL �� �ߺ� ���Ե� ����

-- ���� ��� Ȯ��
SELECT  * FROM USER_UK; 


-- ���� ���� ��Ÿ���� SYS_C008635 ���� ���� ���Ǹ�����
-- �ش� ���� ������ ������ ���̺��, �÷�, ���� ���� Ÿ�� ��ȸ 
SELECT UCC.TABLE_NAME, UCC.COLUMN_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC, USER_CONS_COLUMNS UCC
WHERE UCC.CONSTRAINT_NAME = UC.CONSTRAINT_NAME
AND UCC.CONSTRAINT_NAME = 'USER_ID_UK';


--------------------------------------------

-- 2) ���̺� �������� ���� ���� ����

/* [�ۼ���]
	CREATE TABLE ���̺��(
      �÷��� ������Ÿ��, ..,
      [CONSTRAINT �������Ǹ�] �������� (�÷���)
    );
	
*/


CREATE TABLE USER_UK2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    --UNIQUE(USER_ID) -- �⺻ ���̺� ���� �������� ����
    CONSTRAINT USER_ID_UK2 UNIQUE (USER_ID)
);


-- USER_UK2 ���̺� ������ �������� ��ȸ
SELECT C1.TABLE_NAME,  COLUMN_NAME  ,SEARCH_CONDITION
FROM USER_CONSTRAINTS  C1 
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'USER_UK2';


-- �����͸� �����Ͽ� UNIQUE ���� ���� Ȯ��
INSERT INTO USER_UK2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UK2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

SELECT * FROM USER_UK2;



--------------------------------------------

-- 3) UNIQUE ����Ű
-- �� �� �̻��� �÷��� ���� �ϳ��� UNIQUE ���� ������ ����
-- ������ �÷��� �����Ͱ� ��� ��ġ�ؾ� �ߺ����� ������
-- ����Ű�� ���̺� �����θ� �ۼ��� �� ����

CREATE TABLE USER_UK3(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    CONSTRAINT USER_NO_ID_UK UNIQUE(USER_NO, USER_ID)
);




INSERT INTO USER_UK3
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UK3
VALUES(2, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UK3
VALUES(2, 'user02', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_UK3
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');
--> ���� �÷��� ��� UNIQUE ���� ������ �����Ǿ� ������ 
-- �� �÷��� ��� �ߺ��Ǵ� ���� ��쿡�� ���� �߻�

SELECT * FROM USER_UK3;


SELECT UC.TABLE_NAME, UCC.COLUMN_NAME, UCC.CONSTRAINT_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UCC.CONSTRAINT_NAME = 'USER_NO_ID_UK';
--> �ΰ��� UNIQUE ���� �������� �ϳ��� ���� ���Ǹ����� �Ǿ��ִ� �� Ȯ��



------------------------------------------------------------------------------------------


-- �������ǿ� �̸� ����
CREATE TABLE CONST_NAME(
  TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL, 
  TEST_DATA2 VARCHAR2(20) CONSTRAINT UK_TEST_DATA2 UNIQUE,
  TEST_DATA3 VARCHAR2(30),
  CONSTRAINT UK_TEST_DATA3 UNIQUE(TEST_DATA3)
);
-- TEST_DATA1 �÷��� �÷� ������ NOT_NULL ���������� �߰��ϰ� ���� ���� ���� NN_TEST_DATA1���� ����
-- TEST_DATA2 �÷��� �÷� ������ UNIQUE ���������� �߰��ϰ� ���� ���� ���� UK_TEST_DATA2 ����
-- TEST_DATA3 �÷��� ���̺� ������ UNIQUE ���������� �߰��ϰ� ���� ���� ���� UK_TEST_DATA3 ����

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CONST_NAME';

SELECT * 
FROM USER_CONSTRAINTS C1
JOIN USER_CONS_COLUMNS C2 USING(CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'CONS_NAME';


------------------------------------------------------------------------------------------


/* 3. PRIMARY KEY(�⺻Ű) ���� ���� 
    - ���̺��� �� ���� ������ ã�� ���� ����� �÷��� �ǹ���
     -> ���̺��� ��� �࿡ ���� �ĺ���(IDENTIFIER) ������ ��
     
    - NOT NULL + UNIQUE ���� ������ �ǹ̸� ������ ���� 
    
    - �� ���̺�� �ϳ��� PK ���� ������ ������ �� ����
    
    - �÷� / ���̺� ������ �������� ���� ����
    
    - PK�� ����Ű ���� ����

*/

-- 1) PRIMARY KEY�� ������ ���̺� ����

CREATE TABLE USER_PK(
  --USER_NO NUMBER PRIMARY KEY, -- �÷� ������ PK ����
  --USER_NO NUMBER CONSTRAINT USER_PK_PK PRIMARY KEY, -- �÷� ������ PK ���� + �̸� ����
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  --PRIMARY KEY(USER_NO) -- ���̺� ���� PK ����
  CONSTRAINT USER_PK_PK PRIMARY KEY(USER_NO) -- ���̺� ���� PK ���� + �̸� ����
);


-- ���� ��� ���� �ϸ鼭 Ȯ��
INSERT INTO USER_PK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_PK
VALUES(1, 'user02', 'pass02', '�̼���', '��', '010-5678-9012', 'lee123@kh.or.kr');
-- ORA-00001: unique constraint (KH.USER_PK_PK) violated

INSERT INTO USER_PK
VALUES(NULL, 'user03', 'pass03', '������', '��', '010-9999-3131', 'yoo123@kh.or.kr');
-- ORA-01400: cannot insert NULL into ("KH"."USER_PK"."USER_NO")


-- USER_PK_PK �������� Ȯ��
SELECT UC.TABLE_NAME, UCC.COLUMN_NAME, UC.CONSTRAINT_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.CONSTRAINT_NAME = 'USER_PK_PK';


--------------------------------------------

-- 2) PRIMARY KEY ����Ű
--> ���̺� �����θ� �ۼ��� �� ����
CREATE TABLE USER_PK2(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20),
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  CONSTRAINT USER_NO_ID_PK PRIMARY KEY(USER_NO, USER_ID) -- ����Ű ����
);

-- ���� ��� ���� �ϸ鼭 Ȯ��
INSERT INTO USER_PK2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_PK2
VALUES(1, 'user02', 'pass02', '�̼���', '��', '010-5678-9012', 'lee123@kh.or.kr');

INSERT INTO USER_PK2
VALUES(2, 'user01', 'pass01', '������', '��', '010-9999-3131', 'yoo123@kh.or.kr');

INSERT INTO USER_PK2
VALUES(1, 'user01', 'pass01', '�Ż��Ӵ�', '��', '010-9999-9999', 'sin123@kh.or.kr');
-- ORA-00001: unique constraint (KH.USER_NO_ID_PK) violated

SELECT * FROM USER_PK2;



------------------------------------------------------------------------------------------


/* 4. FOREIGN KEY(�ܺ�Ű / �ܷ�Ű) �������� 

 - ����(REFERENCES)�� �ٸ� ���̺��� �÷�(PK)�� �����ϴ� ���� ����� �� �ְ� �ϴ� ���� ����
 
 - FOREIGN KEY ���� ���ǿ� ���ؼ� ���̺��� ����(RELATIONSHIP)�� ����
 
 - �����Ǵ� �� �ܿ��� NULL�� ����� �� ����
 
 -- �÷� ������ ���� ���� ����
 �÷��� ������Ÿ�� [CONSTRAINT �������Ǹ�] REFERENCES �������̺��[(�����÷���)] [�����ɼ�]
 
 -- ���̺� ������ ���� ���� ����
 [CONSTRAINT �������Ǹ�] FOREIGN KEY(�����÷���)REFERENCES �������̺��[(�����÷���)] [�����ɼ�]
 
 (�ڡڡڡڡ�)
 - ������ �� �ִ� �÷��� PK �Ǵ� UNIQUE ���� ������ ������ �÷��� ������ �� ����
 - ���� �÷����� �ۼ����� ������ �������̺��� PK �÷��� �����ϰ� ��

*/
-- 1) FOREIGN KEY ���� ���� ����

-- FOREIGN KEY �������� Ȯ���� ���� ���̺�, ���õ�����
CREATE TABLE USER_GRADE(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE VALUES (10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES (20, '���ȸ��');
INSERT INTO USER_GRADE VALUES (30, 'Ư��ȸ��');

SELECT * FROM USER_GRADE;


-- USER_GRADE���̺�� FOREIGN KEY ���������� �ξ��� ���̺� ����
CREATE TABLE USER_FK(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT GRADE_CODE_FK FOREIGN KEY (GRADE_CODE)
        REFERENCES USER_GRADE(GRADE_CODE)
);



-- ���� ��� ���� �ϸ鼭 Ȯ��
INSERT INTO USER_FK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FK
VALUES(2, 'user02', 'pass02', '�̼���', '��', '010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_FK
VALUES(3, 'user03', 'pass03', '������', '��', '010-9999-3131', 'yoo123@kh.or.kr', 30);

INSERT INTO USER_FK
VALUES(4, 'user04', 'pass04', '���߱�', '��', '010-2222-1111', 'ahn123@kh.or.kr', null);

SELECT * FROM USER_FK;

INSERT INTO USER_FK
VALUES(5, 'user05', 'pass05', '������', '��', '010-6666-1234', 'yoon123@kh.or.kr', 50);
-- ORA-02291: integrity constraint (KH.GRADE_CODE_FK) violated - parent key not found


-- ������ �������� Ȯ��
SELECT UC.TABLE_NAME, UCC.COLUMN_NAME, UC.CONSTRAINT_NAME, UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.CONSTRAINT_NAME = 'GRADE_CODE_FK';


SELECT * FROM USER_FK
LEFT JOIN USER_GRADE USING(GRADE_CODE);
-- FK�� ����� == �� ���̺��� ����Ǿ� ���谡 ������
-- == JOIN ����(JOIN �� FK�� ���� �÷��� �ۼ��ϸ� ��)


--------------------------------------------


-- 2) FOREIGN KEY ���� �ɼ� 
-- �θ����̺��� ������ ������ �ڽ� ���̺��� �����͸� 
-- ������� ó���� ���� ���� ������ ������ �� �ִ�.

-- 2-1) ON DELETE RESTRICTED(���� ����)�� �⺻ �����Ǿ� ����
-- FOREIGN KEY�� ������ �÷����� ���ǰ� �ִ� ���� ���
-- �����ϴ� �÷��� ���� �������� ����

SELECT * FROM USER_GRADE;
SELECT * FROM USER_FK;

DELETE FROM USER_GRADE WHERE GRADE_CODE = 10; -- ���� ����
-- ORA-02292: integrity constraint (KH.GRADE_CODE_FK) violated - child record found

COMMIT;


DELETE FROM USER_GRADE WHERE GRADE_CODE = 20;
-- GRADE_CODE �� 20�� �ܷ�Ű�� �����ǰ� ���� �����Ƿ� ������ ������.

SELECT * FROM USER_GRADE;

ROLLBACK;



---------------------


-- 2-2)ON DELETE SET NULL 
-- �θ� �÷��� �����Ͱ� ������ ���
-- �����ϴ� �ڽ��� �÷� ���� NULL�� �����ϴ� �ɼ�

-- ���� ���� Ȯ���� ���� ���̺�, ���� ������
CREATE TABLE USER_GRADE2(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2
VALUES (10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE2
VALUES (20, '���ȸ��');
INSERT INTO USER_GRADE2
VALUES (30, 'Ư��ȸ��');

SELECT * FROM USER_GRADE2;


-- ON DELETE SET NULL ���� �ɼ��� �߰��� ���̺� ����
CREATE TABLE USER_FK2(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT GRADE_CODE_FK2 FOREIGN KEY(GRADE_CODE)
        REFERENCES USER_GRADE2(GRADE_CODE)ON DELETE SET NULL
 );

-- ���õ����� ����
INSERT INTO USER_FK2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FK2
VALUES(2, 'user02', 'pass02', '�̼���', '��', '010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_FK2
VALUES(3, 'user03', 'pass03', '������', '��', '010-9999-3131', 'yoo123@kh.or.kr', 30);

INSERT INTO USER_FK2
VALUES(4, 'user04', 'pass04', '���߱�', '��', '010-2222-1111', 'ahn123@kh.or.kr', null);

COMMIT;




SELECT * FROM USER_GRADE2;
SELECT * FROM USER_FK2;

-- USER_GRADE2 ���̺��� GRADE_COE =10 ����
DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10;
--> ON DELETE SET NULL �ɼ��� �����Ǿ� �־� ������ �̷����.


SELECT * FROM USER_GRADE2;
SELECT * FROM USER_FK2;


ROLLBACK;



---------------------


-- 2-3) ON DELETE CASCADE(����)
-- �θ� �÷� ���� �����ϴ� ���
-- �ش� �÷� ���� �����ϴ� �ڽ� ���̺��� ���� ���� �����ϴ� �ɼ�



-- ���� ���� Ȯ���� ���� ���̺�, ���� ������
CREATE TABLE USER_GRADE3(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE3
VALUES (10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE3
VALUES (20, '���ȸ��');
INSERT INTO USER_GRADE3
VALUES (30, 'Ư��ȸ��');



-- ON DELETE CASCADE ���� �ɼ��� �߰��� ���̺� ����
CREATE TABLE USER_FK3(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT GRADE_CODE_FK3 FOREIGN KEY(GRADE_CODE)
    REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
);


-- ���õ����� ����
INSERT INTO USER_FK3
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr', 10);

INSERT INTO USER_FK3
VALUES(2, 'user02', 'pass02', '�̼���', '��', '010-5678-9012', 'lee123@kh.or.kr', 10);

INSERT INTO USER_FK3
VALUES(3, 'user03', 'pass03', '������', '��', '010-9999-3131', 'yoo123@kh.or.kr', 30);

INSERT INTO USER_FK3
VALUES(4, 'user04', 'pass04', '���߱�', '��', '010-2222-1111', 'ahn123@kh.or.kr', null);

COMMIT;


SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FK3;

DELETE FROM USER_GRADE3
WHERE GRADE_CODE = 10;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_FK3;
-- ON DELETE CASECADE �ɼ����� ���� ����Ű�� ����� ���� �������� Ȯ��

ROLLBACK;



------------------------------------------------------------------------------------------


/* 5. CHECK ���� ���� 
-- �÷��� ��ϵǴ� ���� ������ �����ϴ� ���� ����

    [�ۼ���]
    CHECK (�÷��� �񱳿����� �񱳰�)
    
    -> ���ǻ��� : �񱳰��� ������ ���ͷ��� ����� �� ����

*/

-- CHECK ���������� ������ ���̺� ���� 
CREATE TABLE USER_CHECK(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);


-- ���� ��� ���� �ϸ鼭 Ȯ��
INSERT INTO USER_CHECK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');

INSERT INTO USER_CHECK
VALUES(2, 'user02', 'pass02', 'ȫ�浿', '��', '010-1234-5678', 'hong123@kh.or.kr');
-- ORA-12899: value too large for column "KH"."USER_CHECK"."GENDER" (actual: 6, maximum: 3)
--> ������ ũ�� �ʰ�

-- ORA-02290: check constraint (KH.SYS_C007051) violated
--> üũ ���� ���� ����

INSERT INTO USER_CHECK
VALUES(3, 'user03', 'pass03', 'ȫ�浿', NULL, '010-1234-5678', 'hong123@kh.or.kr');
-- NULL�� ������


---------------------


-- (����) CHECK ���� ������ �����ε� ���� ����.
CREATE TABLE USER_CHECK2(
  TEST_NUMBER NUMBER,
  CONSTRAINT CK_TEST_NUMBER CHECK (TEST_NUMBER > 0)
);

INSERT INTO USER_CHECK2
VALUES (10);
INSERT INTO USER_CHECK2
VALUES (-10);
 

-- (����) ������ ���� ���� + ���̺� ������ CHECK �������� �߰�
CREATE TABLE USER_CHECK3 (
    C_NAME VARCHAR2(15 CHAR),
    C_PRICE NUMBER,
    C_LEVEL CHAR(1),
    C_DATE DATE,
    CONSTRAINT TBCH3_NAME_PK PRIMARY KEY (C_NAME),
    CONSTRAINT TBCH3_PRICE_PK CHECK (C_PRICE >= 1 AND C_PRICE <= 99999),
    CONSTRAINT TBCH3_LEVEL_PK CHECK (C_LEVEL = 'A' OR C_LEVEL = 'B' OR C_LEVEL = 'C'),
    CONSTRAINT TBCH3_DATE_PK CHECK (C_DATE >= TO_DATE('2016/01/01', 'YYYY/MM/DD'))
);


------------------------------------------------------------------------------------------

-- [�ǽ� ����]
-- ȸ�����Կ� ���̺� ����(USER_TEST)
-- �÷��� : USER_NO(ȸ����ȣ) - �⺻Ű(PK_USER_TEST), 
--         USER_ID(ȸ�����̵�) - �ߺ�����(UK_USER_ID),
--         USER_PWD(ȸ����й�ȣ) - NULL�� ������(NN_USER_PWD),
--         PNO(�ֹε�Ϲ�ȣ) - �ߺ�����(UK_PNO), NULL ������(NN_PNO),
--         GENDER(����) - '��' Ȥ�� '��'�� �Է�(CK_GENDER),
--         PHONE(����ó),
--         ADDRESS(�ּ�),
--         STATUS(Ż�𿩺�) - NOT NULL(NN_STATUS), 'Y' Ȥ�� 'N'���� �Է�(CK_STATUS)
-- �� �÷��� �������ǿ� �̸� �ο��� ��
-- 5�� �̻� INSERT�� ��

CREATE TABLE USER_TEST(
    USER_NO NUMBER CONSTRAINT PK_USER_TEST PRIMARY KEY,
    USER_ID VARCHAR2(30) CONSTRAINT UK_USER_ID UNIQUE,
    USER_PWD VARCHAR2(30) CONSTRAINT NN_USER_PWD NOT NULL,
    PNO CHAR(14) CONSTRAINT NN_PNO NOT NULL,
    GENDER CHAR(3) CONSTRAINT CK_GENDER CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(30),
    STATUS VARCHAR2(30)CONSTRAINT NN_STATUS NOT NULL,
    CONSTRAINT UK_PNO UNIQUE(PNO),
    CONSTRAINT CK_STATUS CHECK(STATUS IN('Y','N'))
);

SELECT * FROM USER_TEST;

COMMENT ON COLUMN USER_TEST.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN USER_TEST.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN USER_TEST.USER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN USER_TEST.PNO IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN USER_TEST.GENDER IS '����';
COMMENT ON COLUMN USER_TEST.PHONE IS '����ó';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '�ּ�';
COMMENT ON COLUMN USER_TEST.STATUS IS 'Ż�𿩺�';

SELECT * FROM USER_TEST;

-- ���̺� ���� ����
DROP TABLE USER_TEST;

-- ���õ�����
INSERT INTO USER_TEST
VALUES (1, 'user01', 'pass01', '880122-1234567', '��', '010-1111-9999', '����� ������ ���ﵿ', 'N');
INSERT INTO USER_TEST
VALUES (2, 'user02', 'pass02', '890222-2234567', '��', '010-2222-9999', '����� ������ �Ｚ��', 'N');
INSERT INTO USER_TEST
VALUES (3, 'user03', 'pass03', '900322-2234567', '��', '010-3333-9999', '����� ������ û�㵿', 'Y');
INSERT INTO USER_TEST
VALUES (4, 'user04', 'pass04', '910422-1234567', '��', '010-4444-9999', '����� ������ ���', 'N');
INSERT INTO USER_TEST
VALUES (5, 'user05', 'pass05', '920522-2234567', '��', '010-5555-9999', '����� ������ ��ġ��', 'N');

SELECT * FROM USER_TEST;

COMMIT;










--------------------------------------------------------------------------------

-- ���������� �̿��� ���̺� ����
  --> �÷���, ������ Ÿ��, �÷� ���� ����ǰ�,
  --  ���������� NOT NULL�� �����
  
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;

-- ���, �̸�, �޿�, �μ���, ���޸����� �̷����
-- EMPLOYEE_COPY2 ���̺��� �����ϰ� ������ ����
CREATE TABLE EMPLOYEE_COPY2
AS
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE);

SELECT * FROM EMPLOYEE_COPY2;
































