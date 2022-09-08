2022-0805-01)������Ÿ��
- ����Ŭ���� ���ڿ�, ����, ��¥, ������ �ڷ�Ÿ���� ���� 
1. ���� ������Ÿ�� 
    . ����Ŭ�� �����ڷ�� ''�ȿ� ����� �ڷ�
    . ��ҹ��� ���� (����ǥ�ȿ�����)
    . CHAR(��������), VARCHAR(��������), VARCHAR2(����Ŭ������ ���� ��������), NVARCHAR2(�ٱ�������), LONG(2BG ���ڿ�), CLOB(4GB ���ڿ�), NCLOB���� ������(CHAR ������ �������� ���� ��������)
    1) CHAR(n[BYTE|CHAR])
        - �������� ���ڿ� ����
        - �ִ� 2000BYTE���� ���尡�� (2000���ڱ��� ��������(���ڱ���) , �ѱ��� ��� 2000/3���� ���� ���ڱ����ۿ� ����ȵ�)
        - 'n[BYTE|CHAR]' : '[BYTE|CHAR]'�� �����Ǹ� BYTE�� ��� 
            'CHAR'�� n���ڼ����� ����
        - �ѱ� �� ���ڴ� 3BYTE�� ���� 
        - �⺻Ű�� ���̰� ������ �ڷ�(�ֹι�ȣ, ������ȣ)�� ���缺�� Ȯ���ϱ����� ���
��뿹)
CREATE TABLE TEMP01(
    COL1 CHAR(10), -- BYTE�� DEFAULT�� ��޵�
    COL2 CHAR(10 BYTE),
    COL3 CHAR(10CHAR)
);

INSERT INTO TEMP01 VALUES('����(6BYITE)', '���ѹ�', '���ѹα�');
-- ����: 2���� 6����Ʈ
-- ���ѹ� : 3���� 9����Ʈ
-- ���ѹα� : 4���� 12����Ʈ

SELECT * FROM TEMP01;
SELECT  LENGTHB(COL1) AS COL1,
        LENGTHB(COL2) AS COL2,
        LENGTHB(COL3) AS COL3
FROM TEMP01;





2) VARCHAR2(n[BYTE|CHAR])
    - �������� ���ڿ� �ڷ� ���� 
    - �ִ� 4000BYTE���� ���� ���� 
    - VARCHAR, NVARCHAR2�� ���������� ���� 
 
 ��뿹)
 CREATE TABLE TEMP02(
    COL1 CHAR(20),
    COL2 VARCHAR2(2000 BYTE),
    COL3 VARCHAR2(4000 CHAR)
 );
 
INSERT INTO TEMP02 VALUES('ILPOSTINO', 'BOYHOOD','����ȭ ���� �Ǿ����ϴ�-������');
 
 SELECT * FROM TEMP02;
 
 SELECT LENGTHB(COL1) AS COL1,
        LENGTHB(COL2) AS COL2,
        LENGTHB(COL3) AS COL3,
        LENGTH(COL1) AS COL1,
        LENGTH(COL2) AS COL2,
        LENGTH(COL3) AS COL3
FROM TEMP02;
        
 
 
 
 
 
 
 
 
 
 
 
 3) LONG
    - �������� ���ڿ� �ڷ� ����
    - �ִ� 2GB���� ���� ����
    - �� ���̺� �� �÷��� LONGŸ�� ��� ����
    - ���� ��� �������� ����(8i) => CLOB�� UPGRADE
(�������)
    �÷��� LONG 
        . LONG Ÿ������ ����� �ڷḦ �����ϱ� ���� �ּ� 31bit�� �ʿ�
        => �Ϻ� ���(LENGTHB ���� �Լ�)�� ����
        . SELECT���� SELECT��, UPGRADE�� SET��, INSERT���� VALUES������ ��� ���� 
        
(��뿹)
CREATE TABLE TEMP03(
    COL1 VARCHAR2(2000),
    COL2 LONG
);

INSERT INTO TEMP03 VALUES('������ �߱� ���� 846', '������ �߱� ���� 846'); 


SELECT SUBSTR(COL1, 8, 3)
       --SUBSTR(COL2, 8, 3)
FROM TEMP03;

SELECT LENGTHB(COL2)
       --SUBSTR(COL2, 8, 3)
FROM TEMP03;



        
        
SELECT * FROM TEMP03;
 
 
 
 
 
 4) CLOB (Character Large Objects)
    - ��뷮�� �������� ���ڿ� ����
    - �ִ� 4GB���� ó�� ���� 
    - �� ���̺� �������� CLOB Ÿ�� ���� ���� 
    - �Ϻ� ����� DBMS_LOB API(Application Programming Interface)���� �����ϴ� �Լ� ���
    (�������)
    �÷��� CLOB 
    
    (��뿹)
    CREATE TABLE TEMP04(
        COL1 VARCHAR2(255),
        COL2 CLOB,
        COL3 CLOB
    );
 
    INSERT INTO TEMP04 VALUES('APPLE BANANA PERSIMMON', 'APPLE BANANA PERSIMMON', 'APPLE BANANA PERSIMMON');

    SELECT * FROM TEMP04; 
    --����ڰ� ������ ���̸�ŭ�� �����ϰ� �������� ���� �ݳ� 
    
    SELECT SUBSTR(COL1, 7, 6) FROM TEMP04;
    -- TEMP04���̺��� COL1 7��° �ڸ��������� 6���ڹ�ȯ 
    
    SELECT SUBSTR(COL1, 7, 6) AS COL1,
            SUBSTR(COL3, 7, 6) AS COL3,
            -- LENGTHB(COL2) AS COL4,
            DBMS_LOB.GETLENGTH(COL2) AS COL4, -- ���ڼ� ��ȯ
            DBMS_LOB.SUBSTR(COL2, 7, 6) AS COL2
    FROM TEMP04;
    
    




