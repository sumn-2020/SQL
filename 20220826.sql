* ��ǰ���̺��� �з��ڵ尡 'P301'�� ��ǰ�� �ǸŰ��� ���԰��� ������ �����Ͻÿ�. 
UPDATE PROD
   SET PROD_PRICE = PROD_COST
WHERE PROD_LGU = 'P301';

��뿹) ��ǰ���̺��� ���԰��ݰ� ���Ⱑ���� ��ȸ�ϰ�, �� ������ ���� ��ǰ�� ã�� ����� '�Ǹ��ߴܿ�����ǰ'�� ����ϰ�, 
       �� ������ ���� ���� ��ǰ�� ���������� ����� ����Ͻÿ�.
       Alias�� ��ǰ��ȣ, ��ǰ��, ���԰�, ���Ⱑ, ���
       
SELECT PROD_ID AS ��ǰ��ȣ, 
       PROD_NAME AS ��ǰ��, 
       PROD_COST AS ���԰�, 
       PROD_PRICE AS ���Ⱑ, 
       NVL2(NULLIF(PROD_PRICE,PROD_COST), TO_CHAR((PROD_PRICE-PROD_COST), '9,999,999'), '�Ǹ��ߴܿ�����ǰ') AS ��� --PROD_PRICE��PROD_COST�� ���ϰ�, ���̸� ��������(�ǸŰܰ� - ���԰���) �����̸�  '�Ǹ��ߴܿ�����ǰ', )��� 
FROM PROD;


-----------------------------------------------------------------------------


��뿹) 2020�� 1�� ��� ��ǰ�� ���Լ������踦 ��ȸ�Ͻÿ�.
    
    SELECT B.PROD_ID AS ��ǰ�ڵ�, 
           B.PROD_NAME AS ��ǰ��, 
           SUM(A.BUY_QTY) AS ���Լ����հ� 
    FROM BUYPROD A, PROD B
    WHERE A.BUY_PROD(+)=B.PROD_ID --��ǰ�� ������ PROD�� ����
      AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
    GROUP BY B.PROD_ID, B.PROD_NAME
    ORDER BY 1;
    
    
    (ANSI����)
    SELECT B.PROD_ID AS ��ǰ�ڵ�, 
           B.PROD_NAME AS ��ǰ��, 
           NVL(SUM(A.BUY_QTY), 0) AS ���Լ����հ� 
    FROM BUYPROD A
   -- RIGHT OUTER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID AND 
          --A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
    RIGHT OUTER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID) -- 74�� ��� 
    WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131') -- 1�� 35���� ���ܽ�Ű�� 39�Ǹ� ��� 
    GROUP BY B.PROD_ID, B.PROD_NAME
    ORDER BY 1;
    
    
    (SUBQUERY)
    SELECT B.PROD_ID AS ��ǰ�ڵ�, 
           B.PROD_NAME AS ��ǰ��, 
           A.BSUM AS ���Լ����հ� 
    FROM PROD B,
         (2020�� 1�� ��ǰ�� ���Լ��� ����) -- �������� A
    WHERE B.PROD_ID = A.��ǰ�ڵ�(+)
    ORDER BY 1;
    
    (��������: 2020�� 1�� ��ǰ�� ���Լ��� ����)
    SELECT BUY_PROD, 
           SUM(BUY_QTY) AS BSUM -- ���Լ����հ�(A.BSUM)�� �ҷ��ٰ� �����ؼ� ����� 
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE ('20200131')
    GROUP BY BUY_PROD
    
    (����)
    SELECT B.PROD_ID AS ��ǰ�ڵ�, 
           B.PROD_NAME AS ��ǰ��, 
           A.BSUM AS ���Լ����հ� 
    FROM PROD B,
         (SELECT BUY_PROD, 
           SUM(BUY_QTY) AS BSUM -- ���Լ����հ�(A.BSUM)�� �ҷ��ٰ� �����ؼ� ����� 
          FROM BUYPROD
          WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE ('20200131')
          GROUP BY BUY_PROD ) A
    WHERE B.PROD_ID = A.BUY_PROD(+)
    ORDER BY 1;
    





��뿹) 2020�� 4�� ��� ��ǰ�� ����������踦 ��ȸ�Ͻÿ�.
    Alias�� ��ǰ�ڵ�, ��ǰ��, ��������հ�
    
    (ANSI FORMAT)
    SELECT A.PROD_ID AS ��ǰ�ڵ�, 
           A.PROD_NAME AS ��ǰ��, 
           SUM(CART_QTY) AS ��������հ�
    FROM PROD A  -- FROM���� ������ ���� �� ���� ��� LEFT 
    LEFT OUTER JOIN CART B ON(B.CART_PROD=A.PROD_ID AND B.CART_NO LIKE '202004%')
    GROUP BY A.PROD_ID, A.PROD_NAME
    ORDER BY 1;
    
          
    
    

��뿹) 2020�� 6�� ��� ��ǰ�� ����/����������踦 ��ȸ�Ͻÿ�.
    Alias ��ǰ�ڵ�, ��ǰ��, ���Լ���, ������� 

SELECT A.PROD_ID AS ��ǰ�ڵ�, 
       A.PROD_NAME AS ��ǰ��, 
       SUM(B.BUY_QTY) AS ���Լ���, 
       SUM(C.CART_QTY) AS ������� 
FROM PROD A 
LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.BUY_PROD AND 
     B.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))
LEFT OUTER JOIN CART C ON(C.CART_PROD = A.PROD_ID AND C.CART_NO LIKE '202006%')
GROUP BY A.PROD_ID,A.PROD_NAME 
ORDER BY 1;





------------------------
��뿹) ������̺��� ������� ��ձ޿����� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�. 
Alias�� �����ȣ, �����, ��å�ڵ�, �޿� 

(��������: ������̺��� ������� �����ȣ, �����, ��å�ڵ�, �޿���ȸ)
SELECT �����ȣ, �����, ��å�ڵ�, �޿���ȸ
FROM HR.EMPLOYEES
WHERE SALARY > (��ձ޿�)

(��������: ��ձ޿�)
SELECT AVG(SALARY)
FROM HR.EMPLOYEES

(���� - ��ø��������: WHERE���� ���Ʊ� ���� )

SELECT EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����, 
       JOB_ID AS ��å�ڵ�, 
       SALARY AS �޿�
FROM HR.EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                FROM HR.EMPLOYEES)
ORDER BY 4 DESC; -- �޿��� ���� ������� ���� ��� ������ ��� 



(IN-LINE)
SELECT A.EMPLOYEE_ID AS �����ȣ, 
       A.EMP_NAME AS �����, 
       A.JOB_ID AS ��å�ڵ�, 
       A.SALARY AS �޿�
FROM HR.EMPLOYEES A, (SELECT AVG(SALARY) AS SAL
                      FROM HR.EMPLOYEES) B
WHERE A.SALARY > B.SAL
ORDER BY 4 DESC; 






��뿹) 2017�� ���Ŀ� �Ի��� ����� �����ϴ� �μ��� ��ȸ�Ͻÿ�. 
      Alias�� �μ���ȣ, �μ���, ���������ȣ 
      
(��������: �μ��� �μ���ȣ, �μ���, ���������ȣ ���)
    SELECT DISTINCT A.DEPARTMENT_ID AS �μ���ȣ,  --�μ���ȣ : EMPLOYEES, DEPARTMENTS ���� �����ʰ� ����� 
           B.DEPARTMENT_NAME AS �μ���, 
           A.MANAGER_ID AS ���������ȣ 
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID  -- �μ��� �����÷��� ���ν�Ŵ
      AND B.DEPARTMENT_ID IN(��������)
      
      
      
(��������: 2017�� ���Ŀ� �Ի��� ����� �����ϴ� �μ���ȣ)
SELECT DEPARTMENT_ID
FROM HR.EMPLOYEES
WHERE HIRE_DATE>TO_DATE('20161231')



(����- ���1 : �����༭������)
    SELECT DISTINCT A.DEPARTMENT_ID AS �μ���ȣ, 
           B.DEPARTMENT_NAME AS �μ��� 
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID  
      AND B.DEPARTMENT_ID IN(SELECT  DEPARTMENT_ID
                            FROM HR.EMPLOYEES
                            WHERE HIRE_DATE>TO_DATE('20161231'))
     ORDER BY 1;


(����- ���2 : ���ü� �ִ� �������� )
SELECT DISTINCT A.DEPARTMENT_ID AS �μ���ȣ, 
           B.DEPARTMENT_NAME AS �μ���, 
           A.MANAGER_ID AS ���������ȣ 
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID  
      AND EXISTS(SELECT 1
                   FROM HR.EMPLOYEES C
                   WHERE HIRE_DATE>TO_DATE('20161231')
                   AND C.EMPLOYEE_ID = A.EMPLOYEE_ID); -- �������� �Ұ� : A.EMPLOYEE_ID�� �������� ���ϱ� ������ �� ���������� ���� ���� �����ص� ��¾ȵ�



---------------------------------------
      
��뿹) ��ǰ���̺��� ��ǰ�� ����ǸŰ����� �ǸŰ��� �� ���� ��ǰ�� ��ǰ��ȣ, ��ǰ��, �з���, �ǸŰ��� ��ȸ�Ͻÿ�.



(����)
SELECT A.PROD_ID AS ��ǰ��ȣ, 
       A.PROD_NAME AS ��ǰ��, 
       B.LPROD_NM AS �з���,
       A.PROD_PRICE AS �ǸŰ�
FROM PROD A, LPROD B
WHERE A.PROD_LGU = B.LPROD_GU  
  AND A.PROD_PRICE > (SELECT AVG(PROD_PRICE)
                      FROM PROD);




---------------------------------------------------

��뿹) ȸ�����̺��� 2000�� ���� ����� � ȸ���� ���ϸ������� �� ���� ���ϸ����� ������ ȸ���� 
       ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ����� ��ȸ
       
       
  SELECT MEM_ID AS ȸ����ȣ,  
         MEM_NAME AS ȸ����, 
         MEM_REGNO1 ||'-'|| MEM_REGNO2 AS �ֹι�ȣ, 
         MEM_MILEAGE AS ���ϸ���
  FROM MEMBER 
  --WHERE MEM_MILEAGE >ALL(2000�� ���� ����� � ȸ���� ���ϸ���) : 2000�� ���� ����� � ȸ���� ���ϸ������� �� ���� ȸ���� ���ϸ���
  WHERE MEM_MILEAGE >ALL(SELECT MEM_MILEAGE 
                         FROM MEMBER
                         WHERE SUBSTR(MEM_REGNO2, 1,1) IN('1', '2'));
  

--------------------------------------------------------------

��뿹) ��ٱ������̺��� 2020�� 5�� ȸ���� �ְ� ���űݾ��� ����� ȸ���� ��ȸ�Ͻÿ�.
       Alias�� ȸ����ȣ, ȸ����, ���űݾ��հ�
       
(��������: 2020�� 5�� ȸ���� ���űݾ� �հ踦 ������������ ����)
SELECT A.CART_MEMBER AS CID, -- ȸ����ȣ 
       SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM --���űݾ��հ�
FROM CART A, PROD B
WHERE A.CART_PROD=B.PROD_ID
  AND A.CART_NO LIKE '202005%' --2020�� 5���޿� �߻��� 
GROUP BY A.CART_MEMBER
ORDER BY  2 DESC; -- ���űݾ� �������� �������� 


(��������: ���������� ��� �� �� ù�ٿ� �ش��ϴ� �ڷ� ���)
SELECT TA.CID AS ȸ����ȣ, --MEM_ID�ȿ� �ִ� ȸ����ȣ�� TA�ӿ� ����ִ� ȸ����ȣ ���� �ϳ� �ƹ��ų� �����
       M.MEM_NAME AS ȸ����, 
       TA.CSUM AS ���űݾ��հ�
FROM MEMBER M, (SELECT A.CART_MEMBER AS CID,
                       SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                FROM CART A, PROD B
                WHERE A.CART_PROD=B.PROD_ID
                  AND A.CART_NO LIKE '202005%' 
                GROUP BY A.CART_MEMBER
                ORDER BY  2 DESC) TA 
WHERE M.MEM_ID=TA.CID 
  AND ROWNUM <=5; --5��� ��� (*ROWNUM = 1: �ѻ�����)



(WITH �� ��� : �������� ���� WITH����� ���� ����)
-- ��ȣ�ӿ� ����ִ� �͵��� ������� A1�� ���� 
WITH A1 AS (SELECT A.CART_MEMBER AS CID, 
                   SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
            FROM CART A, PROD B
            WHERE A.CART_PROD=B.PROD_ID
              AND A.CART_NO LIKE '202005%' 
            GROUP BY A.CART_MEMBER
            ORDER BY  2 DESC)
SELECT B. MEM_ID, B.MEM_NAME, A1.CSUM
  FROM MEMBER B, A1
 WHERE B.MEM_ID=A1.CID -- ���ο���
   AND ROWNUM=1;







  
  
  
  
  
  
  
       
       
      
      
      
      
      
      
      
      







