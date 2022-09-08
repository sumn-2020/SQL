-- ��ǰ���̺��� ��ǰ�� ���԰��� ��� ��
SELECT PROD_COST
FROM PROD
ORDER BY 1;

--DISTINCT : �ߺ�����
SELECT AVG(DISTINCT PROD_COST),  -- AS "�ߺ��Ȱ��� ����",
       AVG(ALL PROD_COST) , -- AS "DEFAULT�ν� ��� ���� ����",
       AVG(PROD_COST)  -- AS "���԰� ���"
FROM PROD;

--��ǰ���̺��� ��ǰ�з��� ���԰��� ��� ��
-- BY : ~�� / GROUP:����
-- ASC : ��������(��������) / DESC: �������� 
SELECT PROD_LGU,
       ROUND(AVG(PROD_COST),2) PROD_COST -- �Ҽ��� ��°�ڸ����� ���
FROM PROD
GROUP BY PROD_LGU
ORDER BY PROD_LGU;


--��ǰ�з��� ���Ű���(=�ǸŰ���) ���
SELECT PROD_LGU AS ��ǰ�з�,
       ROUND(AVG(PROD_SALE),2) AS ���Ű������
FROM PROD
GROUP BY PROD_LGU
ORDER BY PROD_LGU;

SELECT PROD_LGU,
       PROD_BUYER,
       ROUND(AVG(PROD_COST),2) PROD_COST,
       SUM(PROD_COST),
       MAX(PROD_COST),
       MIN(PROD_COST),
       COUNT(PROD_COST)
FROM PROD
GROUP BY PROD_LGU, PROD_BUYER -- ��׷� : PROD_LGU  / �ұ׷� : PROD_BUYER
ORDER BY 1,2;


--P.282
--��ǰ���̺�(PROD)��
--�� �ǸŰ���(PROD_SALE) 
--��� ���� ���Ͻÿ� ?
--(Alias�� ��ǰ���ǸŰ����)
-- Alias ��� bytes�� 30bytes
SELECT ROUND(AVG(PROD_SALE), 2)  AS ��ǰ���ǸŰ����
FROM PROD;

SELECT * FROM PROD;

--P.282
--��ǰ���̺��� ��ǰ�з�(PROD_LGU)�� 
--�ǸŰ���(PROD_SALE) ��� ���� ���Ͻÿ� ?
--(Alias�� ��ǰ�з�(PROD_LGU), ��ǰ�з����ǸŰ������)

SELECT  PROD_LGU AS ��ǰ�з�, 
        ROUND(AVG(PROD_SALE), 2) AS  ��ǰ�з����ǸŰ����
FROM PROD
GROUP BY PROD_LGU;


SELECT  PROD_LGU AS ��ǰ�з�, 
        TO_CHAR(ROUND(AVG(PROD_SALE), 2), 'L9,999,999.00') AS  ��ǰ�з����ǸŰ����  --#### ���ڸ� �� ��� 
FROM PROD
GROUP BY PROD_LGU;


--P.283
--�ŷ�ó���̺�(BUYER)�� 
--�����(BUYER_CHARGER)�� �÷����� �Ͽ� 
--COUNT���� �Ͻÿ� ? 
--( Alias�� �ڷ��(DISTINCT), 
--  �ڷ��, �ڷ��(*) )
SELECT COUNT(DISTINCT BUYER_CHARGER) "�ڷ��(DISTINCT)",
       COUNT(BUYER_CHARGER) �ڷ��,
       COUNT(*) "�ڷ��(*)"
FROM BUYER;


-- ���� �� : ī��θ�Ƽ
-- ���� ��: ���� 
SELECT COUNT(*), -- * : ������ �� 
       COUNT(PROD_ID), 
       COUNT(PROD_NAME),
       COUNT(PROD_COLOR) -- NULL ���� 
FROM PROD;

-- p283
--ȸ�����̺�(MEMBER)�� ���(MEM_LIKE)��
--COUNT �����Ͻÿ�.
--ȸ���� ��̺� �ο����� ���غ���
--Alias�� ���, �ڷ��, �ڷ��(*)
SELECT MEM_LIKE ���,
       COUNT(MEM_ID) �ο���, -- �ο����� �⺻Ű�� ���°� ���� ��Ȯ�ϴ�  �ٸ� �÷����� NULL���� �������������ϱ� 
       COUNT(*) "�ڷ��(*)"
FROM MEMBER
GROUP BY MEM_LIKE
ORDER BY MEM_LIKE;



--P.284
--��ٱ������̺��� ȸ���� �ִ뱸�ż���
--�� �˻��Ͻÿ�?
--ALIAS : ȸ��ID, �ִ����, �ּҼ���
SELECT  CART_MEMBER AS ȸ��ID, 
        MAX(CART_QTY) AS �ִ����, -- CART_QTY���ż��� 
        MIN(CART_QTY) AS  �ּҼ���
FROM CART
GROUP BY CART_MEMBER
ORDER BY CART_MEMBER;




-- ������ 2020�⵵7��11���̶� �����ϰ� 
-- ��ٱ������̺�(CART)�� �߻��� 
-- �߰��ֹ���ȣ(CART_NO)�� �˻� �Ͻÿ� ? 
--( Alias�� �ְ�ġ�ֹ���ȣMAX(CART_NO), 
-- �߰��ֹ���ȣ MAX(CART_NO)+1 )

SELECT MAX(CART_NO) AS �ְ�ġ�ֹ���ȣ,
       MAX(CART_NO)+1 AS �߰��ֹ���ȣ
FROM CART
WHERE SUBSTR(CART_NO, 1, 8) = '20200711'
GROUP BY CART_NO
ORDER BY CART_NO; 

SELECT *
FROM CART
WHERE SUBSTR(CART_NO, 1, 8) = '20200711'; 


SELECT *
FROM CART
WHERE SUBSTR(CART_NO, 1, 8) = '20200711'
  AND CART_NO LIKE '20200711%';
-- LIKE�� �Բ� ���� %, _�� ���ϵ�ī���� ��
-- % : �������� / _ : �� ����



--P.285
--��ǰ���̺��� ��ǰ�з�, �ŷ�ó���� 
--�ְ��ǸŰ�, �ּ��ǸŰ�, �ڷ���� �˻��Ͻÿ�?



SELECT MAX(PROD_SALE) �ְ��ǸŰ�, 
       MIN(PROD_SALE) �ּ��ǸŰ�, 
       COUNT(*) �ڷ��
FROM PROD
GROUP BY PROD_LGU, PROD_BUYER;


