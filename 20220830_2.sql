�ܺ�����



(�Ϲ� �ܺ����� ����)
SELECT �÷�list
  FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2],...
 WHERE ��Ī1.�÷���(+)=��Ī2.�÷���2 => ���̺��1�� �ڷᰡ ������ ���̺��� ��� 
 
 
(ANSI �ܺ����� �������)
 SELECT �÷�list
   FROM ���̺��1 [��Ī1]
 RIGHT|LEFT|FULL OUTER JOIN ���̺��2 [��Ī2] ON(��������1 [AND �Ϲ�����1])
                            :
 [WHERE �Ϲ�����]
 
 

 -------------------------------------------------------
 
 ��뿹) ��� �з��� ���� ��ǰ�� ���� ����Ͻÿ�.
 SELECT A.PROD_LGU AS �з��ڵ�, 
        B.LPROD_NM AS ��ǰ��, 
        COUNT(*) AS "��ǰ�� ��"
   FROM PROD A, LPROD B
  WHERE A.PROD_LGU(+)=B.LPROD_GU -- LPROD�� �����ϱ� ������ PROD���� (+)�ܺ����� 
  GROUP BY A.PROD_LGU, B.LPROD_NM
  ORDER BY 1;
   
 
 
 
 
 
 SELECT B.LPROD_GU AS �з��ڵ�, 
        B.LPROD_NM AS ��ǰ��, 
        COUNT(A.PROD_ID) AS "��ǰ�� ��"
   FROM PROD A, LPROD B
  WHERE A.PROD_LGU(+)=B.LPROD_GU 
  GROUP BY B.LPROD_GU, B.LPROD_NM
  ORDER BY 1;
 
 
 SELECT  B.LPROD_GU AS �з��ڵ�, 
        B.LPROD_NM AS ��ǰ��, 
        COUNT(A.PROD_ID) AS "��ǰ�� ��"
   FROM PROD A
   RIGHT OUTER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU)
  GROUP BY B.LPROD_GU, B.LPROD_NM
  ORDER BY 1;
 
 
 
 
 
 
 SELECT DISTINCT PROD_LGU
   FROM PROD 
 
 
 
 -------------------------------------
 
 
 ��뿹) 2020�� 6�� ��� �ŷ�ó�� �������踦 ��ȸ�Ͻÿ�.
        Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ�
 
--�Ϲݿܺ�����       
SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
       A.BUYER_NAME AS �ŷ�ó��, 
       SUM(B.BUY_QTY * C.PROD_COST) AS ���Աݾ��հ� --�ŷ�ó��(BUYER) ����(BUYPROD)
FROM BUYER A, BUYPROD B, PROD C
WHERE B.BUY_PROD(+)= C.PROD_ID
  AND A.BUYER_ID=C.PROD_BUYER(+)
  AND BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
GROUP BY A.BUYER_ID, A.BUYER_NAME;


-- ANSI �ܺ�����
SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
       A.BUYER_NAME AS �ŷ�ó��, 
       NVL(SUM(B.BUY_QTY * C.PROD_COST),0) AS ���Աݾ��հ� 
FROM BUYER A
LEFT OUTER JOIN PROD C ON(A.BUYER_ID=C.PROD_BUYER) --FROM�����̺��� ���빰�� �� ���Ƽ� LEFT 
LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD= C.PROD_ID AND BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')) --PROD ��ǰ���̺��ڵ庸�� BUYPROD��ǰ���̺� �ڵ尡 ���빰�� �� ���Ƽ� LEFT 
GROUP BY A.BUYER_ID, A.BUYER_NAME
ORDER BY 1;


--���������� �̿��ϴ� ���
SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
       A.BUYER_NAME AS �ŷ�ó��, 
       NVL(TBL.BSUM, 0) AS ���Աݾ��հ�
FROM BUYER A,

     --(2020�� 6�� �ŷ�ó�� ���Աݾ��հ�)
     (SELECT C.PROD_BUYER AS CID,
             SUM(B.BUY_QTY*C.PROD_COST) AS BSUM
        FROM BUYPROD B, PROD C
       WHERE B.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
         AND B.BUY_PROD=C.PROD_ID
       GROUP BY C.PROD_BUYER) TBL
       
WHERE A.BUYER_ID= TBL.CID(+)
ORDER BY 1;




��뿹) 2020�� ��ݱ� (1~6��) ��� ��ǰ�� ���Լ������踦 ��ȸ�Ͻÿ�.

��뿹) 2020�� ��ݱ� (1~6��) ��� ��ǰ�� ����������踦 ��ȸ�Ͻÿ�.

��뿹) 2020�� ��ݱ� (1~6��) ��� ��ǰ�� ����/����������踦 ��ȸ�Ͻÿ�.






SELECT DISTINCT BUY_PROD
FROM BUYPROD
WHERE BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630');
 
 

 
 ��뿹) 2020�� ��ݱ�(1-6��) ��� ��ǰ�� ���Լ������踦 ��ȸ�Ͻÿ�.
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 