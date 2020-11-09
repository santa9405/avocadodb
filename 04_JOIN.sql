/* 
[JOIN ��� ����]
  ����Ŭ       	  	                                SQL : 1999ǥ��(ANSI)
----------------------------------------------------------------------------------------------------------------
� ����		                            ���� ����(INNER JOIN), JOIN USING / ON
                                            + �ڿ� ����(NATURAL JOIN, � ���� ��� �� �ϳ�)
----------------------------------------------------------------------------------------------------------------
���� ���� 		                        ���� �ܺ� ����(LEFT OUTER), ������ �ܺ� ����(RIGHT OUTER)
                                            + ��ü �ܺ� ����(FULL OUTER, ����Ŭ �������δ� ��� ����)
----------------------------------------------------------------------------------------------------------------
��ü ����, �� ����   	                    JOIN ON
----------------------------------------------------------------------------------------------------------------
ī�׽þ�(īƼ��) ��		               ���� ����(CROSS JOIN)
CARTESIAN PRODUCT

- �̱� ���� ǥ�� ��ȸ(American National Standards Institute, ANSI) �̱��� ��� ǥ���� �����ϴ� �ΰ���ü.
- ����ǥ��ȭ�ⱸ ISO�� ���ԵǾ� ����.
*/

/* JOIN
   - �ϳ� �̻��� ���̺��� �����͸� ��ȸ�ϱ� ���� ����ϴ� ����,
   - ���� ����� �ϳ��� RESULT SET���� ����
   
   - ������ �����ͺ��̽� SQL�� �̿��� ���̺� ���踦 ���� �� ����
    -- ������ ������ ���̽��� ������ ���Ἲ�� ����
       �ߺ��Ǵ� ������ ���� �ּ����� �����͸� ���̺� ���
       --> ���ϴ� ������ ��ȸ�ϱ� ���ؼ� �ϳ� �̻��� ���̺��� �ʿ��� ��찡 ����
       
    -- ���� ����� �����͸� ���� ���̺��� ������� �ξ� �ʿ��� �����͸��� ������
        --> JOIN

*/

--1) ���, �����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

--2) �μ� �ڵ�, �μ���
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

--3) JOIN ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);


--------------------------------------------------------------------------------

--1. ���� ����(INNER JOIN)(==� ����(EQAUL JOIN))
    --> ����� �÷��� ���� ��ġ�ϴ� ��鸸 ������ �̷����
    -- (�÷����� ��ġ���� �ʴ� ���� ���ο��� ���ܵ�)
    
--1) ���ῡ ����� �� �÷����� �ٸ� ���
--EMPLOYEE, DEPARTMENT ���̺��� �����Ͽ�
-- ���,�̸�,�μ��ڵ�,�μ��� ��ȸ

 --EMPLOYEE ���̺��� �μ� �ڵ� : DEPT_CODE
 --DEPARTMENT ���̺��� �μ� �ڵ� : DEPT_ID
 --> ������ �÷��� �ǹ�, ������ �������� ���¸� �� == ���� ����
 
 -- ANSI ���
 -- ���ῡ ����� �÷����� �ٸ� ��� 
 -- JOIN ���̺�� ON(�÷���1 = �÷���2)
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- ����Ŭ ���
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

--DEPARTMENT, LOCATION ���̺��� �����Ͽ�
--�μ���, ������ ��ȸ

-- ANSI
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT
/*INNER*/ JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);


-- ����Ŭ
SELECT DEPT_TITLE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;



--1) ���ῡ ����� �� �÷����� ���� ���

--EMPLOYEE, JOB ���̺��� �����Ͽ�
-- ���, �̸�, �����ڵ�, ���޸� ��ȸ

-- ANSI
-- ���ῡ ����� �÷����� ���� ���
-- JOIN ���̺�� USING(�����÷���)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- ����Ŭ
-- ���1) ���� �÷����� �����ϱ� ���� ���̺������ ����
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- ���2) ���̺�� ��Ī�� �����Ͽ� �����ϴµ� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

--------------------------------------------------------------------------------

/* 2. �ܺ� ����(OUTER JOIN)( == ���� ����)
-- �� ���̺��� ������ �÷����� ��ġ���� �ʴ� �൵ ���ο� ���� ��Ŵ
 * OUTER JOIN�� �ݵ�� ����ؾ� ��
*/

-- INNER JOIN �� OUTER ������ ���ϱ� ���� SQL����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); -- 21�� ��ȸ��

-- 1) LEFT [OUTER] JOIN
-- ��ġ�⿡ ����� �� ���̺� �� ���� ����� ���̺��� ��� �÷��� �������� ����
-- (NULL �������� ����)

--ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- 23��(�̿���,�ϵ��� �߰�)

--����Ŭ (+)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- ����(DEPT_CODE)�� �������� �Ͽ� ������(DEPT_ID)�� ���缭 �߰�


-- 2) RIGHT [OUTER] JOIN
-- ��ġ�⿡ ����� �� ���̺� �� ������ ����� ���̺��� ��� �÷��� �������� ����
-- (NULL �������� ����)

--ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--24�� : �����ʿ� ������ ���� �ʾҴ�
-- �ؿܿ���3��, �����ú�, ���������ΰ� �߰���

--����Ŭ
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN
-- ��ġ�⿡ ����� �� ���̺��� ���� ��� ���� ����� ����
--> LEFT ������ RIGHT

--ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

--����Ŭ�� FULL OUTER �ȵ�
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+); -- �ȵ�

--------------------------------------------------------------------------------

--3. ���� ����(CROSS JOIN)(==CARTESIAN PRODUCT, ������)
-- ���εǴ� ���̺��� �� ����� ��� ���ε� �����Ͱ� �˻��Ǵ� ���
SELECT EMP_NAME FROM EMPLOYEE; -- 23��
SELECT DEPT_TITLE FROM DEPARTMENT; -- 9��

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT; -- 207�� == 23 * 9

--------------------------------------------------------------------------------

--4. �� ����(NON EQAUL JOIN)
--'='(��ȣ)�� ������� �ʴ� ���ι�
-- ������ �÷� ���� ��ġ�ϴ� ���(�) �� �ƴ�
-- ������ �÷� ���� ���� ���� ���� ���ԵǴ� ���� ��� ������ ����

-- EMPLOYEE, SAL_GRADE�� �����Ͽ�
-- �ڽ��� �޿���޿� �´� �޿��� �ް� �ִ� �������
-- �̸�, �޿�, �޿� ��� ��ȸ
SELECT EMP_NAME, SALARY, EMPLOYEE.SAL_LEVEL
FROM EMPLOYEE 
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
--      S1         600�鸸            600�� ~ 1000��

--------------------------------------------------------------------------------

-- 5. ��ü ����(SELF JOIN)
-- ���� ���̺��� ����
--> ������ ���̺� �� ���� �����ϴ� ���

-- EMPLOYEE ���̺���
-- ���, �̸�, ������ ���, ������ �̸� ��ȸ

-- ANSI
SELECT E.EMP_ID, E.EMP_NAME, 
    E.MANAGER_ID"������ ���", M.EMP_NAME"������ �̸�"
FROM EMPLOYEE E
--JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID); --15�� (INNER JOIN) = NULL ����
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID); --23��*(LEFT OUTER JOIN)

--����Ŭ
SELECT E.EMP_ID, E.EMP_NAME, 
    E.MANAGER_ID"������ ���", M.EMP_NAME"������ �̸�"
FROM EMPLOYEE E, EMPLOYEE M
-- WHERE E.MANAGER_ID = M.EMP_ID; --15��(� ����)
WHERE E.MANAGER_ID = M.EMP_ID(+); --23��(���� ���� ����)

--------------------------------------------------------------------------------

-- 6. �ڿ� ����(NATURAL JOIN)
--�����Ϸ��� �� ���̺���
-- ������ Ÿ�԰� �̸��� ���� �÷��� �ִٸ� �ڵ������� ���� �̷�� ������ �ϴ� ����
-- *�ݵ�� ������ Ÿ�԰� �̸��� �÷��� �־�� ��
 --> �ش� ������ �������� ������ CROSS JOIN�� �Ͼ
 
--EMPLOYEE, JOB ���̺��� �����Ͽ�
--���, �̸�, �����ڵ�, ���޸� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- �÷��� �Ǵ� ������ Ÿ���� �ٸ� ��� ũ�ν� ������ �Ͼ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT;


--------------------------------------------------------------------------------

--7. ���� ����
--N���� ���̺��� ������ �� ���
--���� ���� �߿�!(�ڡڡڡڡ�)


-- EMPLOYEE, DEPARTMENT, LOCATION ���̺��� �����Ͽ�
-- ���, �����, �μ���, ������ ��ȸ

--ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);


-- ���� ������ ��Ű�� ���� ���
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- EMPLOYEE ���̺��� LOCATION_ID ��� �÷��� ���� ������
-- EMPLOYEE, LOCATION ���̺��� � ������ �������� ����

--����Ŭ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

-- 23�� ��� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_CODE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

--������ �븮�̸鼭 �ƽþ� ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸�, ���޸�, �μ���, �ٹ�������, �޿� ��ȸ

--ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
WHERE JOB_NAME = '�븮'
AND LOCAL_NAME LIKE 'ASIA%';

--����Ŭ
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT, LOCATION
WHERE J.JOB_CODE = E.JOB_CODE
AND DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE
AND JOB_NAME = '�븮'
AND LOCAL_NAME LIKE 'ASIA%';

--------------------------------------------------------------------------------
-- �ǽ�����

-- �ǽ�����

-- 1. �ֹι�ȣ�� 70��� ���̸鼭 ������ �����̰�, ����'��'���� ��������
-- �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SUBSTR(EMP_NO,1,1) = '7'
AND SUBSTR(EMP_NO,8,1) = '2'
AND EMP_NAME LIKE '��%';

-- 2. �̸��� '��'�ڰ� ���� �������� ���, �����, ���޸��� ��ȸ�Ͻÿ�
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%��%';

-- 3. �ؿܿ��� 1��, 2�ο� �ٹ��ϴ� �����
-- �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
SELECT EMP_NAME"�����", JOB_NAME"���޸�", DEPT_CODE"�μ��ڵ�", DEPT_TITLE"�μ���"
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE DEPT_TITLE = '�ؿܿ���1��'
OR DEPT_TITLE = '�ؿܿ���2��'
ORDER BY DEPT_CODE DESC, EMP_NAME, DEPT_TITLE;

-- 4. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 5. �μ��� �ִ� ����� �����, ���޸�, �μ���, ������ ��ȸ
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID) -- INNER JOIN �̹Ƿ� �ڵ����� NULL�� ����
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);
--WHERE DEPT_CODE IS NOT NULL;

-- 6. �޿���޺� �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
-- �����, ���޸�, �޿�, ����(���ʽ�����)�� ��ȸ�Ͻÿ�
-- ������ ���ʽ�����Ʈ�� �����Ͻÿ�
SELECT EMP_NAME, JOB_NAME, SALARY,(SALARY+SALARY*NVL(BONUS, 0))*12"����"
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL)
WHERE SALARY > MIN_SAL; 

-- 7. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� ��������
-- �����, �μ���, ������, �������� ��ȸ�Ͻÿ�
SELECT EMP_NAME"�����", DEPT_TITLE"�μ���", 
LOCAL_NAME"������", NATIONAL_NAME"������"
FROM EMPLOYEE
--JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN('�ѱ�','�Ϻ�');

-- 8. ���� �μ��� �ٹ��ϴ� �������� �����, �μ��ڵ�, �����̸��� ��ȸ�Ͻÿ�
SELECT C.EMP_NAME"�����", E.DEPT_CODE"�μ��ڵ�", E.EMP_NAME"�����̸�"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE C ON(E.DEPT_CODE = C.DEPT_CODE)
WHERE E.EMP_NAME != C.EMP_NAME
ORDER BY 1;


-- 9. ���ʽ�����Ʈ�� ���� ������ �߿��� �����ڵ尡 J4�� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
-- ��, JOIN, IN ����� ��
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE BONUS IS NULL 
AND JOB_CODE IN('J4','J7');