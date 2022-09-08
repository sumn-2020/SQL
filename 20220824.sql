
-- ~�� : ������ �����Լ� ����ؾߵ� 

��뿹) ��ٱ������̺��� 2020�� 5�� ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�. 
       Alias�� ��ǰ�ڵ�, �ǸŰǼ�, �Ǹż���, �ݾ�
SELECT A.CART_PROD AS ��ǰ�ڵ�, 
       COUNT(*) AS �ǸŰǼ�, 
       SUM(A.CART_QTY) AS �Ǹż���, 
       SUM(A.CART_QTY*B.PROD_PRICE) AS �ݾ�
FROM CART A, PROD B
WHERE A.CART_NO LIKE '202005%'
  AND A.CART_PROD = B.PROD_ID -- ����
GROUP BY A.CART_PROD
ORDER BY  1;


��뿹) ��ٱ������̺��� 2020�� 5�� ȸ���� �Ǹ����踦 ��ȸ�Ͻÿ�. 
       Alias�� ȸ����ȣ(����), ���ż���, ���űݾ�
       
SELECT A.CART_MEMBER AS ȸ����ȣ, 
       SUM(A.CART_QTY) AS ���ż���,
       SUM(A.CART_QTY * B.PROD_PRICE) AS ���űݾ�
FROM CART A, PROD B
WHERE A.CART_NO LIKE '202005%'
  AND A.CART_PROD = B.PROD_ID -- ����
GROUP BY A.CART_MEMBER
ORDER BY 1;
       
       
��뿹) ��ٱ������̺��� 2020�� ����, ȸ���� �Ǹ����踦 ��ȸ�Ͻÿ�. 
       Alias�� ��, ȸ����ȣ, ���ż���, ���űݾ�
       

SELECT SUBSTR(A.CART_NO, 5, 2) AS ��, 
       A.CART_MEMBER AS ȸ����ȣ, 
       SUM(A.CART_QTY) AS ���ż���, 
       SUM(A.CART_QTY * B.PROD_PRICE) AS ���űݾ�
FROM CART A, PROD B
WHERE SUBSTR(A.CART_NO, 1,4) = '2020'
  AND A.CART_PROD = B.PROD_ID -- ����
GROUP BY SUBSTR(A.CART_NO, 5, 2), A.CART_MEMBER
ORDER BY 1;



��뿹) ��ٱ������̺��� 2020�� 5�� ��ǰ�� �Ǹ����踦 ��ȸ�ϵ� �Ǹűݾ��� 100���� �̻��� �ڷḸ ��ȸ�Ͻÿ�. 
       Alias�� ��ǰ�ڵ�, �Ǹż���, �ݾ�
       
       SELECT A.CART_PROD AS ��ǰ�ڵ�, 
              SUM(A.CART_QTY) AS �Ǹż���, 
              SUM(A.CART_QTY * B.PROD_PRICE) AS �ݾ�
       FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202005%'
         AND A.CART_PROD = B.PROD_ID
         --AND SUM(A.CART_QTY * B.PROD_PRICE) >= 1000000 -- WHERE �������� �����Լ� ��� �Ұ��� HAVING �� ��ߵ� 
       GROUP BY A.CART_PROD
       HAVING SUM(A.CART_QTY * B.PROD_PRICE) >= 1000000 
       ORDER BY 1;
       
       
       
    

��뿹) 2020�� ��ݱ�(1-6��) ���Ծ� ���� ���� ���� ���Ե� ��ǰ 5���� ��ȸ�Ͻÿ�.
       Alias�� ��ǰ�ڵ�, ���Լ���, ���Աݾ�
       
      -- ��ǰ�� ���Ծ��� ��� 
      -- BUY_DATE 
      -- BUY PROD ���Ի�ǰ�ڵ� 
      -- BUY_QTY ���Ի�ǰ����
      -- BUY_COST ���Ի�ǰ�ܰ�
       
       
    (1) 2020�� ��ݱ�(1-6��) ��ǰ�� ���Ծ��� ����ϰ� ���Ծ��� ���� ������ ���
    
    SELECT BUY_PROD AS ��ǰ�ڵ�, 
           SUM(BUY_QTY * BUY_COST) AS ���Ծ�
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
    GROUP BY BUY_PROD
    ORDER BY 2 DESC;
       
    (2) ���� ���� ���Ե� ��ǰ 1���� ��ȸ
    SELECT BUY_PROD AS ��ǰ�ڵ�, 
           SUM(BUY_QTY) AS ���Լ����հ�,
           MAX(SUM(BUY_QTY * BUY_COST)) AS ���Ծ� -- �����Լ������� �ߺ� �� �� ���� 
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
    GROUP BY BUY_PROD
    ORDER BY 3 DESC;
    
    
    
    
    
    ����] ������̺��� �μ��� ��ձ޿��� ��ȸ�Ͻÿ�.
        SELECT DEPARTMENT_ID AS �μ��ڵ�,
               ROUND(AVG(SALARY)) AS ��ձ޿�
        FROM HR.EMPLOYEES 
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
    
    
    ����] ������̺��� �μ��� ���� ���� �Ի��� ����� �����ȣ, �����, �μ���ȣ, �Ի����� ����Ͻÿ�. 
    SELECT EMPLOYEE_ID AS �����ȣ, 
           EMP_NAME AS �����, 
           DEPARTMENT_ID  AS �μ���ȣ, 
           MIN(HIRE_DATE) AS �Ի���
    FROM HR.EMPLOYEES
    GROUP BY EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID;B -- ���� ���µ� SELECT ������ ������ ������ ������ ���ΰ���...�̰� �׷����� ���� ���� �Ͱ� ����.. (�ֹι�ȣ�� �� �ٸ����� �����ȣ�� ���� ��� ����)

    
    ����] ������� ��ձ޿����� �� ���� �޴� ����� �����ȣ, �����, �μ���ȣ, �޿��� ���
    (������� ��ձ޿�)
    SELECT AVG(SALARY) 
    FROM HR.EMPLOYEES;

    SELECT A.EMPLOYEE_ID AS �����ȣ, 
           A.EMP_NAME AS �����, 
           A.DEPARTMENT_ID AS �μ���ȣ, 
           A.SALARY AS �޿�
    FROM HR.EMPLOYEES A
    WHERE A.SALARY > (SELECT AVG(SALARY) --�̷������� ���� WHERE ������ �����Լ� �ü� ���� 
                       FROM HR.EMPLOYEES)
    ORDER BY 4 DESC;
  
  
    ����] ȸ�����̺��� ����ȸ���� ���ϸ��� �հ�� ��� ���ϸ����� ��ȸ�Ͻÿ�
         Alias�� ����, ���ϸ����հ�, ��ո��ϸ��� 
         
         SELECT CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN('1','3') THEN 
                        '����ȸ��'
                    ELSE 
                        '����ȸ��' 
                END AS ����,
                COUNT(*) AS ȸ����,
                SUM(MEM_MILEAGE) AS ���ϸ����հ�,
                ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
        FROM MEMBER
        GROUP BY CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN('1','3') THEN 
                        '����ȸ��'
                    ELSE 
                        '����ȸ��' 
                END;
        
        
        
         
         
         
       
       
  ----------------------------------------------------------
  ROLLUP�� CUBE
  - �پ��� ���԰���� ������� ��� 
  - �ݵ�� GROUP BY���� ���Ǿ�� ��
  
  
  ��뿹) 2020�� 4-7�� ����,ȸ����, ��ǰ�� ���ż����հ踦 ��ȸ�Ͻÿ�. 
  
       (ROLLUP �����)
       SELECT SUBSTR(CART_NO, 5, 2) AS ��,
              CART_MEMBER AS ȸ����ȣ, 
              CART_PROD AS ��ǰ�ڵ�,
              SUM(CART_QTY) AS  ���ż����հ�
        FROM CART
        WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
        GROUP BY SUBSTR(CART_NO, 5, 2), CART_MEMBER, CART_PROD
        ORDER BY 1;
              
       (ROLLUP �����)
       SELECT SUBSTR(CART_NO, 5, 2) AS ��,
              CART_MEMBER AS ȸ����ȣ, 
              CART_PROD AS ��ǰ�ڵ�,
              SUM(CART_QTY) AS  ���ż����հ�
        FROM CART
        WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
        GROUP BY ROLLUP(SUBSTR(CART_NO, 5, 2), CART_MEMBER, CART_PROD)
        ORDER BY 1;
              
       
       
      
------------------------------------------------------------------------
      
 ��뿹) ��ǰ���̺��� ��ǰ�� �з���, �ŷ�ó�� ��ǰ�� ���� ��ȸ�Ͻÿ�. 
-- (GROUP BY���� ���)
 SELECT PROD_LGU AS "��ǰ�� �з�", 
        PROD_BUYER AS "�ŷ�ó �ڵ�",
        COUNT(*) AS "��ǰ�� ��"
 FROM PROD
 GROUP BY PROD_LGU, PROD_BUYER
 ORDER BY 1;
      
      
--(ROLLUP ���)
 SELECT PROD_LGU AS "��ǰ�� �з�", 
        PROD_BUYER AS "�ŷ�ó �ڵ�",
        COUNT(*) AS "��ǰ�� ��"
 FROM PROD
 GROUP BY ROLLUP(PROD_LGU, PROD_BUYER)
 ORDER BY 1;
      
      
--(�κ� ROLLUP)
 SELECT PROD_LGU AS "��ǰ�� �з�", 
        PROD_BUYER AS "�ŷ�ó �ڵ�",
        COUNT(*) AS "��ǰ�� ��"
 FROM PROD
 GROUP BY PROD_LGU, ROLLUP(PROD_BUYER) -- PROD_LGU: ��� // ROLLUP ���ʿ� ������ ��з�, ROLLUP �����ʿ� ������ �Һз�
 ORDER BY 1;
      
      
      
-------------------------------------------      



       --(CUBE���) 
       SELECT SUBSTR(CART_NO, 5, 2) AS ��,
              CART_MEMBER AS ȸ����ȣ, 
              CART_PROD AS ��ǰ�ڵ�,
              SUM(CART_QTY) AS  ���ż����հ�
        FROM CART
        WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
        GROUP BY CUBE(SUBSTR(CART_NO, 5, 2), CART_MEMBER, CART_PROD)
        ORDER BY 1;  
      
        --(�κ� CUBE���)
        SELECT SUBSTR(CART_NO, 5, 2) AS ��,
              CART_MEMBER AS ȸ����ȣ, 
              CART_PROD AS ��ǰ�ڵ�,
              SUM(CART_QTY) AS  ���ż����հ�
        FROM CART
        WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
        GROUP BY SUBSTR(CART_NO, 5, 2), CUBE(CART_MEMBER, CART_PROD)
        ORDER BY 1;  
        
        
        
        
        
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
       
       