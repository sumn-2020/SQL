2022-0808-02)
4. ��Ÿ�ڷ��� 
- �����ڷḦ �����ϱ� ���� ������ Ÿ��
- RAW, LONG, RAW, BLOG, BFILE ���� ������ 
- �����ڷ�� ����Ŭ�� �ؼ��ϰų� ��ȯ���� �ʴ´�. 

1) RAW 
. ���� �����ڷ� ����
. �ִ� 2000BYTE���� ���尡��
. �ε��� ó���� ���� 
. 16������ 2���� ���·� ���� 

(�������)
�÷��� RAW(ũ��)


��뿹)
CREATE TABLE TEMP118 (
    COL1 RAW(2000)
);

INSERT INTO TEMP118 VALUES('2A7F'); -- 2����Ʈ ���� 
INSERT INTO TEMP118 VALUES(HEXTOROW('2A7F')); -- ROW�����͸� �����ϱ� ���� 16���������ϴ� �Լ� 
INSERT INTO TEMP118 VALUES('0010101001111111');

SELECT * FROM TEMP118;


2) BFILE
. �����ڷḦ ����
. ����� �Ǵ� �����ڷḦ �����ͺ��̽� �ܺο� �����ϰ� �����ͺ��̽��� ��� ������ ����
. �ִ� 4GB���� ���尡��
(�������)
�÷��� BFILE;

** �ڷ� �������
(1) �ڷ��غ� 
(2) ���̺� ���� (���̺� �� �÷��� BFILE�� ����) 
    CREATE TABLE TEMP09(
        COL1 BFILE
    );
(3) ���丮(���� , �����͸� ������ �� �ִ� ��) ��ü ���� - ������� �� ���ϸ�
    CREATE OR REPLACE DIRECTORY ��Ī AS ��θ�;
    CREATE OR REPLACE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle\SAMPLE.jpg';
(4) ���� 
    INSERT INTO TEMP09 VALUES(BFILENAME('TEST_DIR','SAMPLE.jpg'));

SELECT * FROM TEMP09;


3) BLOB
CREATE TABLE TEMP110 (
    COL1 BLOB
);


������ ����
 DECLARE
   L_DIR VARCHAR2(20):='TEST_DIR';
   L_FILE VARCHAR2(30):='SAMPLE.jpg';
   L_BFILE  BFILE;
   L_BLOB  BLOB;
 BEGIN
   INSERT INTO TEMP110 VALUES(EMPTY_BLOB())
     RETURN COL1 INTO L_BLOB;
   
   L_BFILE:=BFILENAME(L_DIR,L_FILE);
   
   DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
   DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE, DBMS_LOB.GETLENGTH(L_BFILE));
   DBMS_LOB.FILECLOSE(L_BFILE);
   
   COMMIT;
 END;
 
 
 
   










