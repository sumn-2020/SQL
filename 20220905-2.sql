
------------------------------------------------------------------------
�ǻ��÷�                        �ǹ�
------------------------------------------------------------------------
��������.NEXTVAL               '������' ��ü�� ���� �� ��ȯ 
��������.CURVAL                '������' ��ü�� ���� �� ��ȯ 

** ������ ���� �� �ݵ�� '��������.NEXTVAL' ����� 1���̻�, �� ó������ ����Ǿ�� ��


��뿹) �з����̺��� LPROD_ID���� �������� ���Ͽ� ���� �ڷḦ �Է��Ͻÿ�
----------------------------
�з��ڵ�     �з���
----------------------------
p501       ��깰
p502       ���깰
p503       �ӻ깰

CREATE SEQUENCE SEQ_LPROD_ID
  START WITH 10;
  
INSERT INTO LPROD(LPROD_ID, LPROD_GU,LPROD_NM) 
VALUES(SEQ_LPROD_ID.NEXTVAL, 'P501', '��깰');

  
INSERT INTO LPROD(LPROD_ID, LPROD_GU,LPROD_NM) 
VALUES(SEQ_LPROD_ID.NEXTVAL, 'P502', '���깰');

INSERT INTO LPROD(LPROD_ID, LPROD_GU,LPROD_NM) 
VALUES(SEQ_LPROD_ID.NEXTVAL, 'P503', '�ӻ깰');

SELECT * FROM LPROD;
  
SELECT SEQ_LPROD_ID.CURRVAL FROM DUAL; -- ������
SELECT SEQ_LPROD_ID.NEXTVAL FROM DUAL;













