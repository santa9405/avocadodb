/* SEQUENCE (������)
    - ���������� �������� �ڵ� �������ִ� 
      �ڵ� ��ȣ �߻��� ������ �ϴ� ��ü 
 
    [�ۼ���]
    1) ����
    CREATE SEQUENCE ��������
    [START WITH ����] -- ó�� �߻���ų ���۰� ����, ���� �� �⺻�� 1�� ����
    [INCREMENT BY ����] -- ���� ���� ���� ����ġ, ���� �� �⺻ �� 1�� ����
    [MAXVALUE ����| NOMAXVALUE] -- �߻���ų �ִ밪�� ����(10^27-1), NOMAXVALUE �⺻��
    [MINVALUE ����| NOMINVALUE] -- �߻���ų �ּҰ��� ����(-10^26), NOMINVALUE �⺻��
    [CYCLE | NOCYCLE] -- �� ��ȯ ���θ� ����, NOCYCLE �⺻ ��
    [CACHE ����Ʈũ�� | NOCACHE] -- ĳ���޸�ũ�� ����. �ּҰ� 2����Ʈ
                                                -- NOCACHE �⺻ �� 20����Ʈ
                                                
    * �������� ĳ���޸𸮴� �Ҵ�� ũ�� ��ŭ �̸� ���� ���� �����ؼ� �����ص�
        --> ���� ������ ȣ�� �� ����� ���� ��ȯ�ϹǷ� �ӵ��� ����(DB�ӵ� ���)
*/

-- 1. ������ ����
CREATE SEQUENCE SEQ_EMP_ID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOMINVALUE
NOCYCLE
NOCACHE;

-- ����ڰ� ������ ������ Ȯ��
SELECT * FROM USER_SEQUENCES;

----------------------------------------------------------------------------------------------------------

-- 2. ������ ���
/* [�ۼ���]

1) ���� ������ ������ �� ��ȯ
��������.CURRVAL

2) ������ ���� INCREMENT �� ��ŭ ������Ų �� ��ȯ
��������.NEXTVAL
*/

SELECT SEQ_EMP_ID.CURRVAL FROM DUAL;
-- CURRVAL�� �������� ȣ��� NEXTVAL�� ���� �����ϴ� �������� ����

--> NEXTVAL�� ���� ȣ��!
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- �ʱ� �� 300
SELECT SEQ_EMP_ID.CURRVAL FROM DUAL; -- ���� �� 300
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- 310
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL; -- ����(�ִ밪 �ʰ�)

SELECT * FROM USER_SEQUENCES;

/* ������(CURRVAL, NEXTVAL) ��� ����/�Ұ��� SQL��

    1) ��� ����
        - ��������(���������� �ƴ� SELECT��)�� SELECT��
        - INSERT���� �������� SELECT��
        - INSERT���� VALUES��
        - UPDATE���� SET��
        
    2) ��� �Ұ���
       - VIEW�� SELECT��
       - DISTINCT�� �ִ� SELECT��
       - GROUP BY, HAVING, ORDER BY���� ���Ե� SELECT��
       - SELECT, DELETE, UPDATE���� ��������
       - CREATE TABLE, ARTER TABLE�� DEFAULT��
*/

CREATE SEQUENCE SEQ_EID
START WITH 300 -- ���۰� 300
--INCREMENT BY 1 -- 1�� ����
MAXVALUE 10000 -- �ִ밪 1��
--NOMINVALUE -- �ּҰ� ����
--NOCYCLE -- �ݺ� ����
CACHE 30; -- ĳ�� 30����Ʈ

SELECT * FROM USER_SEQUENCES;

COMMIT;

INSERT INTO EMPLOYEE
VALUES( SEQ_EID.NEXTVAL, 'ȫ�浿','001109-1234567','hogn-gd@kh.or.kr',
            '01012341234','D2','J7','S1',6000000, 0.1, 200, SYSDATE, NULL, DEFAULT);

-- ȫ�浿 ��� Ȯ��
SELECT * FROM EMPLOYEE
WHERE EMP_NAME = 'ȫ�浿'; -- 300

INSERT INTO EMPLOYEE
VALUES( SEQ_EID.NEXTVAL, 'ȫ���','001109-2234567','hogn-gs@kh.or.kr',
            '01012345678','D2','J7','S1',6000000, 0.1, 200, SYSDATE, NULL, DEFAULT);

-- ȫ��� ��� Ȯ��
SELECT * FROM EMPLOYEE
WHERE EMP_NAME = 'ȫ���'; -- 301


----------------------------------------------------------------------------------------------------------

/* 3. ������ ����
    [�ۼ���]
    ALTER SEQUENCE ��������
    [INCREMENT BY ����]
    [MAXVALUE ����| NOMAXVALUE]
    [MINVALUE ����| NOMINVALUE]
    [CYCLE | NOCYCLE]
    [CACHE ����Ʈũ�� | NOCACHE]

    -> START WITH�� ���� �Ұ�

     * ���� START WITH�� �����ϰ� �ʹٸ�
       
       DROP SEQUENCE ��������; ���� ���� ��
       
       CREATE SEQUENCE ��������; �ٽ� ����
*/

ALTER SEQUENCE SEQ_EMP_ID
INCREMENT BY 10
MAXVALUE 400
MINVALUE 200
CYCLE;

SELECT SEQ_EMP_ID.CURRVAL FROM DUAL;
SELECT SEQ_EMP_ID.NEXTVAL FROM DUAL;


































