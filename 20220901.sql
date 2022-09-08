2022-0901-01)
  ** ���������̺� ����
  1)���̺�� : REMAIN
  2)�÷���
  --------------------------------------------------------------------
    �÷���         ������Ÿ��              NULLABLE          PK, FK
  --------------------------------------------------------------------
   REMAIN_YEAR    CHAR(4)                                 PK            --����
   PROD_ID        VARCHAR2(10)                            PK & FK       --��ǰ�ڵ�
   REMAIN_J_00    NUMBER(5)             DEFAULT 0                       --�������
   REMAIN_I       NUMBER(5)                                             --�԰����
   REMAIN_O       NUMBER(5)                                             --������
   REMAIN_J_99    NUMBER(5)             DEFAULT 0                       --�⸻(��)��� : �������
   REMAIN_DATE    DATE                  DEFAULT SYSDATE                 --��������           
  --------------------------------------------------------------------
  
CREATE TABLE REMAIN(
   REMAIN_YEAR    CHAR(4),                                 
   PROD_ID        VARCHAR2(10),                            
   REMAIN_J_00    NUMBER(5) DEFAULT 0,                    
   REMAIN_I       NUMBER(5),                                            
   REMAIN_O       NUMBER(5),                                            
   REMAIN_J_99    NUMBER(5) DEFAULT 0,                      
   REMAIN_DATE    DATE DEFAULT SYSDATE,  

   CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR,PROD_ID),
   CONSTRAINT fk_remain_prod FOREIGN KEY(PROD_ID) REFERENCES PROD(PROD_ID));
   
** ���������̺�(REMAIN)�� ���� �ڷḦ �Է��ϼ���
  ���� : 2020��
  ��ǰ�ڵ� : PROD ���̺��� ��� ��ǰ�ڵ�
  ������� : PROD ���̺��� �������(PROD_PROPERSTOCK)
  �԰�/������ : 0
  �⸻��� : PROD ���̺��� �������(PROD_PROPERSTOCK)
  �������� : 2020�� 1�� 1��
  
1) INSERT���� SUBQUERY
  . '( )' ������� ����
  . VALUES ���� �����ϰ� ���������� ���
  
  INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_I,REMAIN_O,REMAIN_J_99,REMAIN_DATE) 
    SELECT '2020',PROD_ID,PROD_PROPERSTOCK,0,0,PROD_PROPERSTOCK,TO_DATE('20200101')
      FROM PROD;
      
COMMIT;   
  SELECT * FROM REMAIN;
  
2) ���������� �̿��� UPDATE��
(�������)
   UPDATE ���̺��
      SET (�÷���1[,�÷���2,...])=(��������)   
   [WHERE ����]  -- ��� ������Ʈ�� ����
    . SET ������ �����ų �÷��� �ϳ� �̻��� ��� ���� ( ) �ȿ� �÷����� ����ϸ�
      ���������� SELECT ���� �÷����� ����� ������� 1��1 �����Ǿ� �Ҵ��
    . SET ������ ()�� ������� ������ �����ų �÷����� ���������� ����ؾ� ��
    
    
    
    
    
    
    
��뿹)2020�� 1�� ��ǰ���� �������踦 �̿��Ͽ� ���������̺��� �����Ͻÿ�.
      �۾����ڴ� 2020�� 1�� 31���̴�.
      
      
 (�������� : ���������̺� ����)     
  UPDATE REMAIN A
     SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE)=
         (�������� : 2020�� 1�� ��ǰ�� ���Լ�������)
   WHERE A.PROD_ID IN(SELECT BUY_PROD
                        FROM BUYPROD
                       WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')) 
                       
                       
(�������� : 2020�� 1�� ��ǰ�� ���Լ�������)
SELECT BUY_PROD
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
                       
                       
                    
(����)
--74���� �ڷᰡ ������Ʈ �� , 39���� �����Ͱ� �����ϱ� ������Ʈ �ߵ� -> ������Ʈ ���� 
UPDATE REMAIN A 
   SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
       (SELECT A.REMAIN_I + B.BSUM, -- 0+22
               A.REMAIN_J_99 + B.BSUM, --33+22
               TO_DATE('20200131')
         FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM --���������� ����� �Ϻκи� �ʿ��� ��� FROM���� ����ϰ�, �ٱ��� ������ �����Ǵ� �������� ���
                FROM BUYPROD
               WHERE BUY_DATE BETWEEN TO_DATE('20200101') 
                 AND TO_DATE('20200131')
               GROUP BY BUY_PROD
               ORDER BY 1) B    
        WHERE A.PROD_ID=B.BUY_PROD
       )
-- NULL���� �ִ� �ڷ���� ������Ʈ ���� X
 WHERE A.PROD_ID IN(SELECT BUY_PROD
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'));
                     -- �� �ȿ��� ���� ������� A.PROD_ID�� ��Ƽ� �ݿ�


ROLLBACK;
COMMIT;




------------------------------------------------------------------------------------
��뿹) 2020�� 2-3�� ��ǰ���� �������踦 �̿��Ͽ� ���������̺��� �����Ͻÿ�
�۾����ڴ� 2020�� 3�� 31���̴�.

UPDATE REMAIN A
   SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
       (SELECT A.REMAIN_I + B.BSUM, 
               A.REMAIN_J_99 + B.BSUM, 
               TO_DATE('20200331')
         FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                FROM BUYPROD
               WHERE BUY_DATE BETWEEN TO_DATE('20200201') 
                 AND TO_DATE('20200331')
               GROUP BY BUY_PROD
               ORDER BY 1) B   
               
        WHERE A.PROD_ID=B.BUY_PROD
       )    
 WHERE A.PROD_ID IN(SELECT BUY_PROD
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200331'));
                     





��뿹) 2020�� 4-7�� ���Ը������踦 �̿��Ͽ� ���������̺��� �����Ͻÿ�
�۾����ڴ� 2020�� 8�� 1���̴�. 


UPDATE ������̺� 
SET (�԰����, �⸻���, ��������) =
    (�԰����+1�������հ�, �⸻���+1�������հ�, �۾�����) 
WHERE ��ǰ�ڵ� IN(1���� ���Ե� ��ǰ�ڵ�) 


(����)
UPDATE REMAIN A
   SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
   
       (SELECT A.REMAIN_I + B.BSUM,
               A.REMAIN_J_99 + B.BSUM,
               TO_DATE('20200801')
               
         FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                 FROM BUYPROD
                WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
                GROUP BY BUY_PROD) B
               
        WHERE A.PROD_ID=B.BUY_PROD)
          
  WHERE A.PROD_ID IN(SELECT BUY_PROD
                       FROM BUYPROD
                      WHERE BUY_DATE BETWEEN TO_DATE('20200401') 
                            AND TO_DATE('20200731'));
                   
   
  
  (����)
  UPDATE REMAIN A
   SET (A.REMAIN_O, A.REMAIN_J_99,A.REMAIN_DATE)=
   
       (SELECT A.REMAIN_O + C.CSUM,
               A.REMAIN_J_99 - C.CSUM,
               TO_DATE('20200801')
               
         FROM (SELECT CART_PROD, SUM(CART_QTY) AS CSUM
                  FROM CART 
                WHERE SUBSTR(CART_NO, 1, 6) BETWEEN '202004' AND '2020070'
                GROUP BY CART_PROD ) C 
               
        WHERE A.PROD_ID=C.CART_PROD)
          
  WHERE A.PROD_ID IN(SELECT CART_PROD
                        FROM CART 
                       WHERE SUBSTR(CART_NO, 1, 6) BETWEEN '202004' AND '2020070');
   
  
  
  ---------------------------------------------------------------
��뿹) ȸ�����̺��� ������ �ֺ��� ȸ���� ���ϸ����� 3000�̻��� ��� ȸ������ ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.
  SELECT MEM_ID AS ȸ����ȣ, 
         MEM_NAME AS ȸ����, 
         MEM_JOB AS ����, 
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_JOB ='�ֺ�'
UNION ALL 
  SELECT MEM_ID, 
         MEM_NAME, 
         MEM_JOB, 
         TO_NUMBER(MEM_REGNO1)
    FROM MEMBER
   WHERE MEM_MILEAGE>=3000;
   
   
   
   
��뿹) 2020�� 4, 5, 6, 7�� ���ž��� ���� ���� ȸ������ ȸ����ȣ, ȸ����, ���űݾ��հ踦 ��ȸ�Ͻÿ�. 

--(WITH���� ����� ���)
WITH T1 AS 
     (SELECT '4��' AS MON, C.MEM_ID AS CID, C.MEM_NAME AS CNAME, D.TOT1 AS CTOT1 
        FROM (SELECT A.CART_MEMBER AS AMID, 
                     SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                FROM CART A, PROD B
               WHERE A.CART_NO LIKE '202004%'
                 AND A.CART_PROD = B.PROD_ID
                GROUP BY A.CART_MEMBER
              ORDER BY 2 DESC) D, MEMBER C
      WHERE C.MEM_ID = D.AMID
        AND ROWNUM = 1
    UNION ALL 
    SELECT '5��' AS MON , C.MEM_ID, C.MEM_NAME, D.TOT1 
        FROM (SELECT A.CART_MEMBER AS AMID, 
                     SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                FROM CART A, PROD B
               WHERE A.CART_NO LIKE '202005%'
                 AND A.CART_PROD = B.PROD_ID
                GROUP BY A.CART_MEMBER
              ORDER BY 2 DESC) D, MEMBER C
      WHERE C.MEM_ID = D.AMID
        AND ROWNUM = 1
       UNION ALL    
    SELECT '6��' AS MON, C.MEM_ID, C.MEM_NAME, D.TOT1 
        FROM (SELECT A.CART_MEMBER AS AMID, 
                     SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                FROM CART A, PROD B, MEMBER C
               WHERE A.CART_NO LIKE '202006%'
                 AND A.CART_PROD = B.PROD_ID
                GROUP BY A.CART_MEMBER
              ORDER BY 2 DESC) D, MEMBER C
      WHERE C.MEM_ID = D.AMID
        AND ROWNUM = 1 
    UNION ALL  
    SELECT '7��' AS MON, C.MEM_ID, C.MEM_NAME, D.TOT1 
        FROM (SELECT A.CART_MEMBER AS AMID, 
                     SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                FROM CART A, PROD B, MEMBER C
               WHERE A.CART_NO LIKE '202007%'
                 AND A.CART_PROD = B.PROD_ID
                GROUP BY A.CART_MEMBER
              ORDER BY 2 DESC) D, MEMBER C
      WHERE C.MEM_ID = D.AMID
        AND ROWNUM = 1       
)
SELECT MON AS ��,
       CID AS ȸ����ȣ,
       CNAME AS ȸ����,
       CTOT1 AS ���űݾ�
FROM T1;
  
  
  
��뿹) 6���� 7���� �Ǹŵ� ��� ��ǰ�� �ߺ����� �ʰ� ����Ͻÿ�.
       Alias�� ��ǰ�ڵ�, ��ǰ��
       
SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��
  FROM CART A, PROD B
 WHERE A.CART_PROD=B.PROD_ID
   AND A.CART_NO LIKE '202006%'
   
UNION --�ߺ����� �ʰ�

SELECT DISTINCT A.CART_PROD,
       B.PROD_NAME
  FROM CART A, PROD B
 WHERE A.CART_PROD=B.PROD_ID
   AND A.CART_NO LIKE '202007%'
ORDER BY 1; --���� �������� ���� (��ü����� ����Ǿ� ��)
  
  
  
---------------------------------------------------------------

��뿹) 2020�� ���Ի�ǰ �� 1���� 5���� ��� ���Ե� ��ǰ�� ��ǰ�ڵ�, ��ǰ��, ����ó���� ��ȸ�Ͻÿ�

SELECT DISTINCT A.BUY_PROD AS ��ǰ�ڵ�, 
       C.PROD_NAME AS ��ǰ��, 
       B.BUYER_NAME AS ����ó��
  FROM BUYPROD A, BUYER B, PROD C
 WHERE A.BUY_PROD = C.PROD_ID
   AND C.PROD_BUYER = B.BUYER_ID
   AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')

INTERSECT

SELECT DISTINCT A.BUY_PROD AS ��ǰ�ڵ�, 
       C.PROD_NAME AS ��ǰ��, 
       B.BUYER_NAME AS ����ó��
  FROM BUYPROD A, BUYER B, PROD C
 WHERE A.BUY_PROD = C.PROD_ID
   AND C.PROD_BUYER = B.BUYER_ID
   AND A.BUY_DATE BETWEEN TO_DATE('20200501') AND TO_DATE('20200531')

ORDER BY 1;


----------------------------------------------------------------------------------

��뿹) 1�� ���Ի�ǰ �� 5�� �Ǹ� �������� 5�� �ȿ� �����ϴ� ��ǰ������ ��ȸ�Ͻÿ�.


WITH T1 AS 

--(1�� ���Ի�ǰ)
(SELECT BUY_PROD
  FROM BUYPROD 
 WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')

INTERSECT

--(5�� �Ǹ� �������� 1-5�� ��ǰ)
SELECT A.CART_PROD
  FROM (SELECT CART_PROD,
               SUM(CART_QTY)
          FROM CART
         WHERE CART_NO LIKE '202005%'
        GROUP BY CART_PROD
        ORDER BY 2 DESC) A
  WHERE  ROWNUM <=5) --ROWNUM : 5�������� ������
  
  

SELECT BUY_PROD AS ��ǰ�ڵ�, PROD_NAME AS ��ǰ��
FROM T1,PROD
WHERE T1.BUY_PROD=PROD_ID;

-- 1�� ���Ի�ǰ, 5�� �Ǹ� �������� 1-5�� ��ǰ �̰� T1 ���̺��� ���� �ְ�  
-- �� �ϴ� SELECT ������ ��ȸ 



--------------------------------------------------------------------

4) MINUS

��뿹) 2020�� �������̺�(CART)���� 5���� 6�� ���� �� 5������ �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�.

(�Ϲ����� ���)
SELECT DISTINCT A.CART_PROD AS CID, B.PROD_NAME AS CNAME
  FROM CART A, PROD B
 WHERE  A.CART_PROD = B.PROD_ID
   AND SUBSTR(A.CART_NO, 1, 6)='202005'

MINUS

SELECT DISTINCT A.CART_PROD, B.PROD_NAME
  FROM CART A, PROD B
 WHERE  A.CART_PROD = B.PROD_ID
   AND SUBSTR(A.CART_NO, 1, 6)='202006'


(WITH�� ���)
WITH T1 AS (

    SELECT DISTINCT CART_PROD AS CID
      FROM CART 
     WHERE SUBSTR(CART_NO, 1, 6)='202005'
    
    MINUS
    
    SELECT DISTINCT CART_PROD
      FROM CART
     WHERE SUBSTR(CART_NO, 1, 6)='202006'

)
SELECT A.CID AS ��ǰ�ڵ�, 
       B.PROD_NAME AS ��ǰ�� 
  FROM  T1 A, PROD B
  WHERE A.CID=B.PROD_ID;

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
   UPDATE REMAIN A
   SET (A.REMAIN_I,A.REMAIN_O, A.REMAIN_J_99,A.REMAIN_DATE)=
   
       (SELECT A.REMAIN_I + B.BSUM,
               A.REMAIN_O + C.CSUM,
               A.REMAIN_J_99 + B.BSUM - C.CSUM,
               TO_DATE('20200801')
               
         FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                 FROM BUYPROD
                WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
                GROUP BY BUY_PROD) B,  -- 4-7�������� ��������
               
              (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                FROM BUYPROD
               WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
               GROUP BY BUY_PROD ) C  -- 4-7�������� ��������
               
        WHERE A.PROD_ID=B.BUY_PROD
          AND A.PROD_ID=C.CART_PROD)
          
  WHERE A.PROD_ID IN(SELECT BUY_PROD
                       FROM BUYPROD
                      WHERE BUY_DATE BETWEEN TO_DATE('20200401') 
                            AND TO_DATE('20200731')
                      UNION --������ : ����Ǿ����� ���� 
                      SELECT CART_PROD
                        FROM CART 
                       WHERE SUBSTR(CART_NO, 1, 6) BETWEEN '202004' AND '2020070');





   
  
   
(4-7�������� ��������) B
SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
  FROM BUYPROD
WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
GROUP BY BUY_PROD
        
(4-7�������� ��������) C
SELECT CART_PROD, SUM(CART_QTY) AS CSUM
  FROM CART 
WHERE SUBSTR(CART_NO, 1, 6) BETWEEN '202004' AND '2020070'
GROUP BY CART_PROD





----------------------------------------------
(�������)
DELETE FROM ���̺��
 WHERE ����



��뿹) ��ٱ������̺��� 2020�� 4�� 'm001'ȸ���� �����ڷ� �� 'p202000005' ��ǰ�� ���ų����� �����Ͻÿ�. 

DELETE FROM CART A 
 WHERE EXISTS(SELECT 1
                FROM MEMBER B
               WHERE  B.MEM_ID='m001'
                 AND B.MEM_ID = A.CART_MEMBER)
   AND A.CART_NO LIKE '202004%'
   AND A.CART_PROD = 'P202000005';
   
   
ROLLBACK;
COMMIT;












