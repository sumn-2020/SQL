2022-0826-03] �����Լ�

��뿹) ȸ�����̺��� ȸ����ȣ, ȸ����, ���ϸ���, ������ ��ȸ�Ͻÿ�.
       ������ ���ϸ����� ���� ȸ������ �ο��ϰ� ���� ���ϸ����� ���� ������ �ο��Ͻÿ�.
       
SELECT MEM_ID AS ȸ����ȣ, 
       MEM_NAME AS ȸ����, 
       MEM_MILEAGE AS ���ϸ���, 
       EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����,
       RANK() OVER(ORDER BY MEM_MILEAGE DESC, 
                  (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)) DESC) AS  ���� --���ϸ����� ������ ���� ������ �����ϰڴ�.
FROM MEMBER;
--���ϸ����� ���� ȸ������ �ο� (=������ ó���ض�)










SELECT MEM_ID AS ȸ����ȣ, 
       MEM_NAME AS ȸ����, 
       MEM_MILEAGE AS ���ϸ���, 
       EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����,
       ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC)  AS  ���� 
FROM MEMBER;

��뿹) ������̺��� �μ����� �޿��� ���� ������ �ο��Ͻÿ�.
       Alias�� �����ȣ, �����, �μ���ȣ, �޿�, �����̿� ������ �޿��� ���� ��������� �ο��Ͻÿ�. 
       ���� �޿��� ���� ���� �ο��� ��
       
SELECT EMPLOYEE_ID  AS �����ȣ, 
       EMP_NAME AS �����, 
       DEPARTMENT_ID AS �μ���ȣ, 
       SALARY AS �޿�, 
       RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS ����
FROM HR.EMPLOYEES;
-- PARTITION BY : =GROUP BY































