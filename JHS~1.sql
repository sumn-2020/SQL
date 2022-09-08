����1) ������̺�(HR.EMPLOYEES)���� ���ʽ��� ����ϰ� ���޾��� �����Ͽ� ����Ͻÿ�.

���ʽ� = ���� * ���������� 30%
���޾� = ���� + ���ʽ�
Alias�� �����ȣ, �����, ����, ��������, ���ʽ�, ���޾�
��簪�� �����κи� ���


SELECT EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����, 
       SALARY AS ����,
       COMMISSION_PCT AS ��������, 
       NVL(SALARY * COMMISSION_PCT * 0.3, 0) AS ���ʽ�, 
       SALARY + SALARY * (COMMISSION_PCT * 0.03) AS ���޾�
  FROM HR.EMPLOYEES;
  
  
  
����2) ��ǰ���̺�(PROD)���� �ǸŰ����� 30���� �̻��̰� ������� 5�� �̻���
��ǰ�� ��ǰ��ȣ, ��ǰ��, ���԰�, �ǸŰ��� ��ȸ�Ͻÿ�.

SELECT PROD_ID AS ��ǰ��ȣ, 
       PROD_NAME AS ��ǰ��, 
       PROD_COST AS ���԰�, 
       PROD_PRICE AS �ǸŰ�
       PROD_PROPERSTOCK AS �������
FROM PROD
WHERE PROD_PRICE >= 300000 AND  PROD_PROPERSTOCK >= 5; 



����3) �������̺�(BUYPROD)���� �̰� ���Լ����� 10�� �̻��� ���������� ��ȸ�Ͻÿ�.  
2020�� 1�� (= 1��1��~31�ϱ���)
Alias�� ������, ���Ի�ǰ, ���Լ���, ���Աݾ�

SELECT BUY_DATE AS ������, 
       BUY_PROD AS ���Ի�ǰ, 
       BUY_QTY AS ���Լ���, 
       BUY_QTY * BUY_COST AS ���Աݾ�
FROM BUYPROD
WHERE BUY_QTY >= 10
  AND BUY_DATE>=TO_DATE('20200101') AND BUY_DATE>=TO_DATE('20200131');
  
  
  
����4) ȸ�����̺��� ���ɴ밡 20���̰ų� ������ ȸ���� ��ȸ�Ͻÿ�.
Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ���

SELECT MEM_ID AS ȸ����ȣ, 
       MEM_NAME AS ȸ����, 
       MEM_REGNO1 ||'-'|| MEM_REGNO2 AS �ֹι�ȣ, 
       MEM_MILEAGE AS ���ϸ���
FROM MEMBER 
WHERE STR(MEM_REGNO2, 1, 1) IN ('2', '4');






  
  


