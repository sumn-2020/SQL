��뿹) ȸ�����̺��� ���ϸ����� 3000�̻��� ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� �並 �����Ͻÿ�

CREATE OR REPLACE VIEW V_MEM01(MID,MNAME, MJOB, MILE)
AS 
  SELECT MEM_ID, 
         MEM_NAME, 
         MEM_JOB, 
         MEM_MILEAGE
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000;
   



CREATE OR REPLACE VIEW V_MEM01
AS 
  SELECT MEM_ID AS ȸ����ȣ, 
         MEM_NAME AS ȸ����, 
         MEM_JOB AS ����, 
         MEM_MILEAGE AS  ���ϸ���
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000;
   




CREATE OR REPLACE VIEW V_MEM01 (MID,MNAME, MJOB, MILE)
AS 
  SELECT MEM_ID AS ȸ����ȣ, 
         MEM_NAME AS ȸ����, 
         MEM_JOB AS ����, 
         MEM_MILEAGE AS  ���ϸ���
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000;
   


CREATE OR REPLACE VIEW V_MEM01
AS 
  SELECT MEM_ID, 
         MEM_NAME, 
         MEM_JOB, 
         MEM_MILEAGE
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000;
   
   
   

SELECT * FROM V_MEM01;




*** V_MEM01���� ��ö��ȸ��(k001)�� ���ϸ����� 2000���� ����

UPDATE V_MEM01
   SET MEM_MILEAGE=2000
 WHERE MEM_ID ='k001';


*** MEMBER���̺��� ��ö��ȸ��(k001)�� ���ϸ����� 5000���� ����

UPDATE MEMBER 
   SET MEM_MILEAGE=5000
 WHERE MEM_ID='k001';


*** MEMBER���̺��� ��� ȸ������ ���ϸ����� 1000�� �����Ͻÿ�

UPDATE MEMBER 
   SET MEM_MILEAGE = MEM_MILEAGE + 1000; -- ���ϸ��� = ���縶�ϸ����� + 1000
   
--�������̺��� �ٲ�� ��� �ڵ����� �ٲ� 
   
   
 ---------------------------------------------------------------------
 
 
 
 
CREATE OR REPLACE VIEW V_MEM01 (MID,MNAME, MJOB, MILE)
AS 
  SELECT MEM_ID, 
         MEM_NAME, 
         MEM_JOB, 
         MEM_MILEAGE
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000
   WITH READ ONLY; --�б����� �� ����(�������̺� ��� �ƴ�, �ƹ��� �信�� READ ONLY�Ѵ� �ϴ��� �������̺��� �ٲ�. �������̺�ٲ�� �䵵 �ٲ� -> �� ����ü�� update ����)
   
   
 SELECT * FROM V_MEM01;  


** MEMBER ���̺��� ��� ȸ���� ���ϸ����� 1000�� ���ҽ�Ű�ÿ�
UPDATE MEMBER 
   SET MEM_MILEAGE = MEM_MILEAGE - 1000;

SELECT * FROM V_MEM01;  
COMMIT;


** �� V_MEM01�� �ڷῡ�� ��ö�� �ܿ��� ���ϸ��� ('k001')�� 3700���� ����
UPDATE V_MEM01
   SET MILE = 3700
 WHERE MID ='k001'; (X) -- �б��������� �س��� ������ ���� ��
 
 
----------------------------------------------------------------------------------
 
(���Ǻ俩 ��)
CREATE OR REPLACE VIEW V_MEM01 (MID,MNAME, MJOB, MILE)
AS 
  SELECT MEM_ID, 
         MEM_NAME, 
         MEM_JOB, 
         MEM_MILEAGE
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000
   WITH CHECK OPTION;

SELECT * FROM V_MEM01; 

** �� V_MEM01���� �ſ�ȯȸ��('c001')�� ���ϸ����� 5500���� �����Ͻÿ�. 
-- MEM_MILEAGE>=3000 ������ �������� �ʾұ� ������ ���������� ��� 
UPDATE V_MEM01
   SET MILE = 5500
 WHERE MID='c001';


** �� V_MEM01���� �ſ�ȯȸ��('c001')�� ���ϸ����� 1500���� �����Ͻÿ�. 
-- MEM_MILEAGE>=3000 ������ �����߱� ������ ����
UPDATE V_MEM01
   SET MILE = 1500
 WHERE MID='c001'; (X)
 
 
 UPDATE MEMBER
   SET MEM_MILEAGE = 1500
 WHERE MEM_ID='c001'; (o) --�������̺��� �������� ���� �����ϰ� �̰��� ��� �信 �ݿ���
 

ROLLBACK;