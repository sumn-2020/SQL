���̺� ��



SELECT COUNT(*) AS "PROD ���̺� ���� ��" FROM PROD;
SELECT COUNT(*) AS "CART ���̺� ���� ��" FROM CART;
SELECT COUNT(*) AS "BUYPROD ���̺� ���� ��" FROM BUYPROD;

SELECT COUNT(*) FROM PROD, CART, BUYPROD;


-- CART�� BUYPROD�� ���谡 �ξ��� ���� X
SELECT COUNT(*)
FROM PROD
CROSS JOIN CART
CROSS JOIN BUYPROD;

-- ANSI 
SELECT * 
FROM PROD
CROSS JOIN CART
CROSS JOIN BUYPROD;



��뿹) �������̺��� 2020�� 6�� ���Ի�ǰ������ ��ȸ�Ͻÿ�.
       Alias�� ����, ��ǰ��ȣ, ��ǰ��, ����, �ݾ�

--(�Ϲ�����)
SELECT A.BUY_DATE AS ����, 
       B.PROD_ID AS ��ǰ��ȣ, 
       B.PROD_NAME AS ��ǰ��, 
       A.BUY_QTY AS ����, 
       A.BUY_QTY * B.PROD_COST AS �ݾ� --����*�ܰ�
FROM BUYPROD A, PROD B
WHERE A.BUY_PROD=B.PROD_ID --��������
AND A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') --�Ϲ�����
ORDER BY 1;


--(ANSI ����)
SELECT A.BUY_DATE AS ����, 
       B.PROD_ID AS ��ǰ��ȣ, 
       B.PROD_NAME AS ��ǰ��, 
       A.BUY_QTY AS ����, 
       A.BUY_QTY * B.PROD_COST AS �ݾ� --����*�ܰ�
FROM BUYPROD A
--INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID AND
--      (A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')))
INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID)
WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
ORDER BY 1;







(��뿹) ��ǰ���̺��� 'P10202'�ŷ�ó���� ��ǰ�ϴ� ��ǰ������ ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó��, ���Դܰ�
        
    --�Ϲ�����
    SELECT A.PROD_ID AS ��ǰ�ڵ�, 
           A.PROD_NAME AS ��ǰ��, 
           A.PROD_BUYER AS �ŷ�ó�ڵ�,
           B.BUYER_NAME AS �ŷ�ó��, 
           A.PROD_COST AS ���Դܰ�
    FROM PROD A, BUYER B
    WHERE A.PROD_BUYER = B.BUYER_ID -- �� ���̺� �� �̸��� ���� �ų��� ���ؼ� ���� ������ (�̳�����)
        AND A.PROD_BUYER = 'P10202';
        
        
    --ANSI����
    SELECT A.PROD_ID AS ��ǰ�ڵ�, 
           A.PROD_NAME AS ��ǰ��, 
           A.PROD_BUYER AS �ŷ�ó�ڵ�,
           B.BUYER_NAME AS �ŷ�ó��, 
           A.PROD_COST AS ���Դܰ�
    FROM PROD A 
    INNER JOIN BUYER B ON(A.PROD_BUYER = B.BUYER_ID)
    WHERE A.PROD_BUYER = 'P10202';



   
��뿹) ��ǰ���̺��� ���������� ��ȸ�Ͻÿ�.
      Alias�� ��ǰ�ڵ� ��ǰ��, �з���, �ǸŴܰ�
      
      --�Ϲ�����
      SELECT A.PROD_ID AS ��ǰ�ڵ�, 
             A.PROD_NAME AS ��ǰ��, 
             B.LPROD_NM AS �з���, 
             A.PROD_PRICE AS �ǸŴܰ�
      FROM PROD A, LPROD B
      WHERE A.PROD_LGU = B.LPROD_GU; -- �� ���̺� �� �̸��� ���� �ų��� ���ؼ� ���� ������ (�̳�����)
      
      --ANSI����
      SELECT A.PROD_ID AS ��ǰ�ڵ�, 
             A.PROD_NAME AS ��ǰ��, 
             B.LPROD_NM AS �з���, 
             A.PROD_PRICE AS �ǸŴܰ�
      FROM LPROD B
      INNER JOIN PROD A ON (A.PROD_LGU = B.LPROD_GU);
      
      
      
      
��뿹) ������̺��� �����ȣ, �����, �μ���, �Ի����� ����Ͻÿ�.

SELECT A.EMPLOYEE_ID AS �����ȣ, 
       A.EMP_NAME  AS �����, 
       B.DEPARTMENT_NAME AS �μ���, 
       A.HIRE_DATE AS �Ի���
FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE A.DEPARTMENT_ID  = B.DEPARTMENT_ID; 
-- �� ���̺� �� �̸��� ���� �ų��� ���ؼ� ���� ������ (�̳�����)
-- �̳������� ���������� �����ϴ� �͸� ���
-- NULL�� DEPARTMENT_ID�μ��ڵ忡 ����  : KIMBERY GRANT�� NULL�̱� ������ ���X
-- KIMBERY GRANT�� ������ �Ϸ��� OUTER JOIN ��ߵ� 


--ANSI����
SELECT A.EMPLOYEE_ID AS �����ȣ, 
       A.EMP_NAME  AS �����, 
       B.DEPARTMENT_NAME AS �μ���, 
       A.HIRE_DATE AS �Ի���
FROM HR.EMPLOYEES A
INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID  = B.DEPARTMENT_ID);




��뿹) 2020�� 4�� ȸ����, ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�.
       Alias�� ȸ����ȣ, ȸ����, ��ǰ��, ���ż����հ�, ���űݾ��հ� 

SELECT A.CART_MEMBER AS ȸ����ȣ,
       B.MEM_NAME AS ȸ����, 
       C.PROD_NAME AS ��ǰ��, 
       SUM(A.CART_QTY) AS ���ż����հ�, 
       SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ��հ� -- ���� * ����
FROM CART A, MEMBER B, PROD C
WHERE A.CART_MEMBER = B.MEM_ID -- ��������: ȸ���������� ���� 
  AND A.CART_PROD = C.PROD_ID --��ǰ��, �ǸŴܰ��������� ���� ��������
  AND A.CART_NO LIKE '202004%'
GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
ORDER BY 1;


--ANSI����
SELECT A.CART_MEMBER AS ȸ����ȣ,
       B.MEM_NAME AS ȸ����, 
       C.PROD_NAME AS ��ǰ��, 
       SUM(A.CART_QTY) AS ���ż����հ�, 
       SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ��հ� -- ���� * ����
FROM CART A 
INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID) -- ���⼭�� ��¥�� ���õ� ���� �ʿ� ����
INNER JOIN PROD C ON(A.CART_PROD = C.PROD_ID)
WHERE A.CART_NO LIKE '202004%'
-- INNER JOIN PROD C ON(A.CART_PROD = C.PROD_ID  AND A.CART_NO LIKE '202004%')
GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
ORDER BY 1;

----------------------------------------------------------

��뿹) 2020�� 5�� �ŷ�ó��(buyer) ��������(cart)�� ��ȸ�Ͻÿ�. 
    Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ����ݾ��հ�
 
--�Ϲ�����
SELECT  A.BUYER_ID AS �ŷ�ó�ڵ�, 
        A.BUYER_NAME AS �ŷ�ó��, 
        SUM(C.CART_QTY * B.PROD_PRICE) AS ����ݾ��հ�   
FROM  BUYER A, PROD B, CART C 
WHERE C.CART_NO LIKE '202005%'  -- �Ϲ�����
  AND A.BUYER_ID = B.PROD_BUYER --��������
  AND B.PROD_ID = C.CART_PROD   --��������
GROUP BY A.BUYER_ID, A.BUYER_NAME
ORDER BY 1; --�ŷ�ó�ڵ������ ���


 
 
--ANSI����
SELECT  A.BUYER_ID AS �ŷ�ó�ڵ�, 
        A.BUYER_NAME AS �ŷ�ó��, 
        SUM(C.CART_QTY * B.PROD_PRICE) AS ����ݾ��հ�   
FROM  BUYER A
INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
INNER JOIN CART C ON(B.PROD_ID = C.CART_PROD AND C.CART_NO LIKE '202005%')
GROUP BY A.BUYER_ID, A.BUYER_NAME
ORDER BY 1;
    
    
    
��뿹) HR�������� �̱��̿��� ������ ��ġ�� �μ������� ��ȸ�Ͻÿ�.
Alias�� �μ���ȣ, �μ���, �ּ�, ������
--�Ϲ�����
SELECT A.DEPARTMENT_ID AS �μ���ȣ, 
       A.DEPARTMENT_NAME AS �μ���, 
       B.STREET_ADDRESS||', '||B.CITY||', '||B.STATE_PROVINCE AS �ּ�, 
       C.COUNTRY_NAME AS ������
FROM HR.DEPARTMENTS A,  HR.LOCATIONS B, HR.COUNTRIES C
WHERE A.LOCATION_ID = B.LOCATION_ID
  AND B.COUNTRY_ID  = C.COUNTRY_ID  
  AND B.COUNTRY_ID != 'US'
ORDER BY 1;
  
-- ANSI����
SELECT A.DEPARTMENT_ID AS �μ���ȣ, 
       A.DEPARTMENT_NAME AS �μ���, 
       B.STREET_ADDRESS||', '||B.CITY||', '||B.STATE_PROVINCE AS �ּ�, 
       C.COUNTRY_NAME AS ������
FROM HR.DEPARTMENTS A
INNER JOIN HR.LOCATIONS B ON(A.LOCATION_ID = B.LOCATION_ID)
INNER JOIN  HR.COUNTRIES C ON(B.COUNTRY_ID=C.COUNTRY_ID AND B.COUNTRY_ID NOT IN('US'));




















































