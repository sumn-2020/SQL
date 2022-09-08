��뿹) ������̺��� ���������� NULL�� �ƴ� ����� ��ȸ�Ͻÿ�.
      Alias�� �����ȣ, �����, ��������, �μ��ڵ� 
      
      SELECT EMPLOYEE_ID AS �����ȣ, 
             EMP_NAME AS �����, 
             COMMISSION_PCT AS ��������, 
             DEPARTMENT_ID AS �μ��ڵ�
      FROM HR.EMPLOYEES
      WHERE COMMISSION_PCT IS NOT NULL;
      --WHERE COMMISSION_PCT != NULL;
      
      
--------------------------------------------------------------




** ��ǰ���̺��� �з��ڵ尡 'P301'�� ������ ��� ��ǰ�� ���ϸ��� �ش� ��ǰ�� 
  �ǸŰ��� 0.5%�� �����Ͻÿ�. 
  UPDATE ���̺�� SET �÷���  --����� �Ǿ����� ���̺� ��
  
  UPDATE PROD
     SET PROD_MILEAGE = ROUND(PROD_PRICE*0.0005) --�ǸŰ�(PROD_PRICE)�� 0.5%(*100)
  WHERE PROD_LGU <> 'P301'; --�з��ڵ尡 'P301'�� ������('P301'�� ���� ����)
  COMMIT;
  
  ��뿹) ��ǰ���̺��� ��ǰ�� ���ϸ����� NULL�� ��ǰ�� '���ϸ����� �������� �ʴ� ��ǰ' 
         �̶�� �޽����� ���ϸ��� ����÷��� ����Ͻÿ�
         Alias�� ��ǰ��ȣ, ��ǰ��, ���ϸ���


SELECT PROD_ID AS ��ǰ��ȣ, 
       PROD_NAME AS ��ǰ��, 
       NVL(TO_CHAR(PROD_MILEAGE),'���ϸ����� �������� �ʴ� ��ǰ')  AS ���ϸ��� -- PROD_MILEAGE�� NULL�� �ƴϸ� PROD_MILEAGE�� ���̸� '���ϸ����� �������� �ʴ� ��ǰ' 
        --TO_CHAR :  ���ڸ� ���ڷ� ���� / ���ϸ����� �������� �ʴ»�ǰ�̶�� ���ڿ��� ���ϸ����� ���ڸ� ���� ���ϸ� ����. �����ϳ��� �ٲ㼭 ������ Ÿ������ ��������ߵ� 
FROM PROD;

SELECT PROD_ID AS ��ǰ��ȣ, 
       PROD_NAME AS ��ǰ��, 
       NVL(LPAD(TO_CHAR(PROD_MILEAGE), 5),'���ϸ����� �������� �ʴ� ��ǰ')  AS ���ϸ��� 
FROM PROD;


��뿹) 2020�� 6�� ��� ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�. 
      SELECT A.PROD_ID AS ��ǰ�ڵ�, 
             A.PROD_NAME AS ��ǰ��, 
             COUNT(B.CART_PROD) AS �Ǹ�Ƚ��, 
             NVL(SUM(B.CART_QTY),0) AS �Ǹż����հ�, 
             NVL(SUM(B.CART_QTY*A.PROD_PRICE),0) AS �Ǹűݾ��հ�
      FROM PROD A
      LEFT OUTER JOIN CART B ON(A.PROD_ID=B.CART_PROD AND  --CART B �� PROD���� ���빰�� ������ LEFT, CART B�� PROD���� ���빰�� ������ RIGHT, 
            B.CART_NO LIKE '202006%')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;



COMMIT;


----------------------------------------
  UPDATE PROD
     SET PROD_MILEAGE = ROUND(PROD_PRICE*0.0005) 

 COMMIT;





** 2020�� 4�� �Ǹ��ڷḦ �̿��Ͽ� ��� ����ȸ������ ���ϸ����� �����Ͻÿ�.

(1. 2020�� 4�� �Ǹ��ڷḦ �̿��� ȸ���� ���ϸ��� �հ�)
SELECT A.CART_MEMBER, 
       SUM(A.CART_QTY*B.PROD_PRICE),
       SUM(A.CART_QTY*B.PROD_MILEAGE)
FROM CART A, PROD B
WHERE A.CART_PROD = B.PROD_ID
AND A.CART_NO LIKE '202004%' 
GROUP BY A.CART_MEMBER;


(2. ȸ�����̺��� ���ϸ��� ����) 
UPDATE MEMBER TA
   SET TA.MEM_MILEAGE = TA.MEM_MILEAGE + 
                        NVL((SELECT TB.MSUM -- NULL ���� �־����� 0���� ��µǵ��� 
                           FROM (SELECT A.CART_MEMBER AS MID, 
                                        SUM(A.CART_QTY*B.PROD_MILEAGE) AS MSUM
                                 FROM CART A, PROD B
                                 WHERE A.CART_PROD = B.PROD_ID
                                   AND A.CART_NO LIKE '202004%' 
                                 GROUP BY A.CART_MEMBER) TB
                           WHERE TB.MID = TA.MEM_ID),0);

ROLLBACK;


��뿹) 2020�� 4�� ����ȸ���鿡�� Ư�� ���ϸ��� 300����Ʈ�� �����Ͻÿ�.

ROLLBACK;
UPDATE MEMBER 
SET MEM_MILEAGE = MEM_MILEAGE + 300
WHERE MEM_ID IN (SELECT DISTINCT CART_MEMBER
                   FROM CART
                  WHERE CART_NO LIKE '202004%');
















--[ ����� ]

CREATE OR REPLACE VIEW V_MEM_MILEAGE
AS
  SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
    FROM MEMBER
  WITH READ ONLY;
  
  
DELETE FROM MEMBER;
    
SELECT  * FROM V_MEM_MILEAGE;











UPDATE MEMBER SET MEM_MILEAGE=1000 WHERE MEM_ID='a001';
UPDATE MEMBER SET MEM_MILEAGE=2300 WHERE MEM_ID='b001';
UPDATE MEMBER SET MEM_MILEAGE=3500 WHERE MEM_ID='c001';
UPDATE MEMBER SET MEM_MILEAGE=1700 WHERE MEM_ID='d001';
UPDATE MEMBER SET MEM_MILEAGE=6500 WHERE MEM_ID='e001';
UPDATE MEMBER SET MEM_MILEAGE=2700 WHERE MEM_ID='f001';
UPDATE MEMBER SET MEM_MILEAGE=800 WHERE MEM_ID='g001';
UPDATE MEMBER SET MEM_MILEAGE=1500 WHERE MEM_ID='h001';
UPDATE MEMBER SET MEM_MILEAGE=900 WHERE MEM_ID='i001';
UPDATE MEMBER SET MEM_MILEAGE=1100 WHERE MEM_ID='j001';
UPDATE MEMBER SET MEM_MILEAGE=3700 WHERE MEM_ID='k001';
UPDATE MEMBER SET MEM_MILEAGE=5300 WHERE MEM_ID='l001';
UPDATE MEMBER SET MEM_MILEAGE=1300 WHERE MEM_ID='m001';
UPDATE MEMBER SET MEM_MILEAGE=2700 WHERE MEM_ID='n001';
UPDATE MEMBER SET MEM_MILEAGE=2600 WHERE MEM_ID='o001';
UPDATE MEMBER SET MEM_MILEAGE=2200 WHERE MEM_ID='p001';
UPDATE MEMBER SET MEM_MILEAGE=1500 WHERE MEM_ID='q001';
UPDATE MEMBER SET MEM_MILEAGE=700 WHERE MEM_ID='r001';
UPDATE MEMBER SET MEM_MILEAGE=3200 WHERE MEM_ID='s001';
UPDATE MEMBER SET MEM_MILEAGE=2200 WHERE MEM_ID='t001';
UPDATE MEMBER SET MEM_MILEAGE=2700 WHERE MEM_ID='u001';
UPDATE MEMBER SET MEM_MILEAGE=4300 WHERE MEM_ID='v001';
UPDATE MEMBER SET MEM_MILEAGE=2700 WHERE MEM_ID='w001';
UPDATE MEMBER SET MEM_MILEAGE=8700 WHERE MEM_ID='x001';

COMMIT;







��뿹) ��ǰ���̺��� ��ǰ�� ������ ����Ͻÿ�.  
       ��, ������ ������ '�������'�� ����Ͻÿ�.(NVL�� NVL2�� ���� ����)
       Alias�� ��ǰ��ȣ, ��ǰ��, ����

        (NVL ���)
        SELECT PROD_ID AS ��ǰ��ȣ, 
               PROD_NAME AS ��ǰ��, 
               NVL(PROD_COLOR,'�������') AS ���� --PROD_COLOR ���� NULL�� �ƴϸ� ���� ��, NULL�̸� ������� ���
        FROM PROD;
        
        (NVL2 ���)
        SELECT PROD_ID AS ��ǰ��ȣ, 
               PROD_NAME AS ��ǰ��, 
               NVL2(PROD_COLOR, PROD_COLOR,'�������') AS ���� -- PROD_COLOR ���� NULL�� �ƴϸ� PROD_COLOR, NULL�̸� ������� ��� 
        FROM PROD;




















