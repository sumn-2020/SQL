1) ������ ������
 - ������ ������ ���� ���������� Ʈ�������� ������ �̷���� ����
 - ������ ������ ���̺� ����� �����͸� ������ ������ ��ȯ�ϴ� ����
 - ����Ŭ������ ������ ������ START WITH ... CONNECT BY ���� ������ �� ������ ������ ������ ǥ���ϱ� ���� �������� ����Ŭ 8���� ����

2) �������
 (1) START WITH ���� ���� ������ ã��
 (2) CONNECT BY ���� ���������� ã��

3) ������ ���� START WITH.. CONNECT BY

 SELECT [�÷�]...
 FROM [���̺�]
 WHERE [����]
 START WITH [�ֻ��� ����]
CONNECT BY [NOCYCLE][PRIOR ������ ���� ����];

 . START WITH ���ǿ� ������ ������ �ֻ��� ������ �ο츦 �ĺ��ϴ� ���� ���
 . CONNECT BY���ǿ����� ������ ������ ������� ����Ǵ��� ǥ��
 . ������ �÷��� ������ LEVEL�÷��� ���� �ǻ��÷�(LEVEL Pseudocolumn)�̶�� �ϴµ� ������ ������ ǥ���Ҷ� �� ������ ������ ǥ��
 . �� ���� �ǻ��÷��� �پ��ϰ� ���� - ���� ���� �����ϴ� ����� �������� �鿩���⸦ �Ͽ� ��
   �� ���������� �����͸� ǥ��
 . PRIOR������
 - PRIORŰ����� ���� ������ ���������� ����ϴ� ����Ŭ SQL�������̴�.
   Ű������ ǥ�������� �����δ� CONNECT BY������ ��ȣ(=)�� ������ ������ ���Ǵ� �������̸�
   CONNCET BY������ �ش� �÷��� �θ�ο츦 �ĺ��ϴµ� ���ȴ�.
 . ���� �ǻ��÷�(LEVEL Pseudocolumn)

***********************************************************************
select * from departments;
alter table departments add parent_id NUMBER(4,0);
alter table DEPARTMENTS add
 CONSTRAINT DEPT_DEPT_FK FOREIGN KEY(PARENT_ID)
 REFERENCES DEPARTMENTS(DEPARTMENT_ID);

commit;

update hr.departments set department_name='�ѹ���ȹ��' where
department_id=10;
update hr.departments set department_name='������' where
department_id=20;
update hr.departments set department_name='���ź�' where
department_id=30;
update hr.departments set department_name='�λ��' where
department_id=40;
update hr.departments set department_name='��ۺ�' where
department_id=50;
update hr.departments set department_name='IT' where
department_id=60;
update hr.departments set department_name='ȫ����' where
department_id=70;
update hr.departments set department_name='������' where
department_id=80;
update hr.departments set department_name='��ȹ��' where
department_id=90;
update hr.departments set department_name='������' where
department_id=100;
update hr.departments set department_name='ȸ���' where
department_id=110;
update hr.departments set department_name='�ڱݺ�' where
department_id=120;
update hr.departments set department_name='���μ���' where
department_id=130;
update hr.departments set department_name='�ſ� ������' where
department_id=140;
update hr.departments set department_name='�ֽ� ������' where
department_id=150;
update hr.departments set department_name='�����Ļ���' where
department_id=160;
update hr.departments set department_name='������' where
department_id=170;
update hr.departments set department_name='�Ǽ���' where
department_id=180;
update hr.depar tments set department_name='�����' where
department_id=190;
update hr.departments set department_name='���' where
department_id=200;
update hr.departments set department_name='IT ������' where
department_id=210;
update hr.departments set department_name='NOC' where
department_id=220;
update hr.departments set department_name='IT �����׽�ũ' where
department_id=230;
update hr.departments set department_name='�����Ǹ� �����' where
department_id=240;
update hr.departments set department_name='�Ǹ���' where
department_id=250;
update hr.departments set department_name='ä����' where
department_id=260;
update hr.departments set department_name='�޿�������' where
department_id=270;

commit;

update departments
 set parent_id=null
 where DEPARTMENT_ID =10;

 update departments
 set parent_id=10
 where DEPARTMENT_ID in(20,30,40,50,80,90,110);

update departments
 set parent_id= 30
 where DEPARTMENT_ID in(180,200,170,220);

update departments
 set parent_id=40
 where DEPARTMENT_ID =260;

update departments
 set parent_id=60
 where DEPARTMENT_ID in(210,230);

update departments
 set parent_id= 80
 where DEPARTMENT_ID in(190,240,250);

update departments
 set parent_id= 90
 where DEPARTMENT_ID in(60,70,100);

update departments
 set parent_id= 100
 where DEPARTMENT_ID in(110,120,130,140,150,160);

update departments
 set parent_id=120
 where DEPARTMENT_ID =270;

commit;

select * from departments;
--------------------------------------------------------------

CREATE TABLE BOM (
 ITEM_ID INTEGER NOT NULL, -- ǰ��ĺ���
 PARENT_ID INTEGER, -- ����ǰ�� �ĺ���
 ITEM_NAME VARCHAR2(20) NOT NULL, -- ǰ���̸�
 ITEM_QTY INTEGER, -- ǰ�� ����
 PRIMARY KEY (ITEM_ID)
);

INSERT INTO BOM VALUES ( 1001, NULL, '��ǻ��', 1);
INSERT INTO BOM VALUES ( 1002, 1001, '��ü', 1);
INSERT INTO BOM VALUES ( 1003, 1001, '�����', 1);
INSERT INTO BOM VALUES ( 1004, 1001, '������', 1);
INSERT INTO BOM VALUES ( 1005, 1002, '���κ���', 1);
INSERT INTO BOM VALUES ( 1006, 1002, '��ī��', 1);
INSERT INTO BOM VALUES ( 1007, 1002, '�Ŀ����ö���', 1);
INSERT INTO BOM VALUES ( 1008, 1005, 'CPU', 1);
INSERT INTO BOM VALUES ( 1009, 1005, 'RAM', 1);
INSERT INTO BOM VALUES ( 1010, 1005, '�׷���ī��', 1);
INSERT INTO BOM VALUES ( 1011, 1005, '��Ÿ��ġ', 1);


CREATE TABLE RECURSIVE_BOOK(
 BOOK_ID NUMBER(4) NOT NULL,
 PARENT_ID NUMBER(4),
 BOOK_NAME VARCHAR2(20) NOT NULL,
 BOOK_QTY NUMBER(3),
CONSTRAINT BOOK_KEY PRIMARY KEY (BOOK_ID));

DELETE FROM RECURSIVE_BOOK;

INSERT INTO RECURSIVE_BOOK VALUES (101, null, '����', 1);
INSERT INTO RECURSIVE_BOOK VALUES (102, 101, '����å', 1);
INSERT INTO RECURSIVE_BOOK VALUES (103, 101, '����å', 1);
INSERT INTO RECURSIVE_BOOK VALUES (104, 101, '����', 1);
INSERT INTO RECURSIVE_BOOK VALUES (105, 102, '�޳���_����', 1);
INSERT INTO RECURSIVE_BOOK VALUES (106, 102, '���ų������׷���_��������',1);
INSERT INTO RECURSIVE_BOOK VALUES (107, 102, '��Ȧ��_�����ϴ°�', 1);
INSERT INTO RECURSIVE_BOOK VALUES (108, 106, '��ȭ�찳������_����', 1);
INSERT INTO RECURSIVE_BOOK VALUES (109, 106, '�����ʱ�����_���', 1);
INSERT INTO RECURSIVE_BOOK VALUES (110, 104, '90���_��������_�м�', 1);
INSERT INTO RECURSIVE_BOOK VALUES (111, 103, '6.25������_����', 1);

commit;


***********************************************************************
��뿹)
 SELECT LEVEL, item_name, item_id, parent_id
 FROM bom
 START WITH parent_id IS NULL --��Ʈ��带 ����,
 CONNECT BY PRIOR item_id = parent_id;--�θ�� �ڽĳ��鰣�� ���踦 ����


 SELECT LPAD(' ', 2*(LEVEL-1)) || item_name as item_names, 
 item_id,
 parent_id
 FROM bom
 START WITH parent_id IS NULL
 CONNECT BY PRIOR item_id = parent_id;


 select level,
 department_id as �μ��ڵ�,
 lpad(' ',2*(level-1))||department_name as �μ���,
 manager_id as �μ���,
 location_id as ��ġ,
 parent_id as �����μ��ڵ�
 from departments
 start with parent_id is null
 connect by prior department_id=parent_id;

