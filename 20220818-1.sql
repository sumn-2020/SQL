2022-0818-02) 
2. �����Լ�


��뿹)  
SELECT ABS(10), ABS(-100), ABS(0),
       SIGN(-20000), SIGN(-0.0099), SIGN(0.000005), SIGN(500000), SIGN(0),
       POWER(2,10),
       SQRT(3.3)
FROM DUAL; 
----------------------------

SELECT GREATEST('KOREA', 1000, 'ȫ�浿'),
       LEAST('ABC', 'ȫ�浿', '200')
FROM DUAL;


SELECT ASCII('ȫ') FROM DUAL; 



��뿹) ȸ�����̺����� ���ϸ����� 1000�̸��� ȸ���� ã�� 1000���� ���� ����Ͻÿ�. 
    Alias�� ȸ����ȣ, ȸ����, �������ϸ���, ����� ���ϸ���
    
SELECT MEM_ID AS ȸ����ȣ, 
       MEM_NAME AS ȸ����, 
       MEM_MILEAGE AS �������ϸ���, 
       GREATEST(MEM_MILEAGE , 1000) AS ����ȸ��ϸ���   -- 1000�� ȸ������ �������ִ� ���ϸ����� ���� �� �� �߿� 1000���� ������ ����ϰ� �ƴϸ� 1000���� 
FROM MEMBER; 
-- ������ ���� 24�� �� ���� �Ǵϱ�






-----------------------------------------------------------------

��뿹) 
SELECT ROUND(12345.678945,3), --9�� �ݿø�  
       ROUND(12345.678945), -- 6�� �ݿø� 
       ROUND(12345.678945,-3) -- 3�� �ݿø� 
FROM DUAL; 

SELECT TRUNC(12345.678945,3), -- 9���� ����
       TRUNC(12345.678945), -- 6���� ���� 
       TRUNC(12999.678945,-3) -- ����° 9���� ����
FROM DUAL;


��뿹) HR������ ������̺����� ������� �ټӿ����� ���Ͽ� �ټӿ����� ���� �ټ� ������ ����Ͻÿ�.
       �ټӼ��� = �⺻��(SALARY) * (�ټӳ��/100)
       �޿��հ� = �⺻�� + �ټӼ��� 
       ���� = �޿��հ��� 13%
       ���޾� = �޿��հ�-�����̸� �Ҽ� 2°�ڸ����� �ݿø��Ͻÿ�. 
       Alias�� �����ȣ, �����, �Ի���, �ټӳ��, �޿�, �ټӼ���, ����, ���޾� 
       
    SELECT EMPLOYEE_ID AS �����ȣ, 
           EMP_NAME AS �����, 
           HIRE_DATE AS �Ի���, 
           TRUNC((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��,
           SALARY AS �⺻�޿�,
           ROUND(SALARY * (TRUNC((SYSDATE - HIRE_DATE) / 365)) / 100),1) AS �ټӼ���,
           ROUND(SALARY + SALARY * (TRUNC((SYSDATE - HIRE_DATE) / 365)) / 100),1) AS �޿��հ�,
           ROUND(SALARY + ROUND(SALARY + SALARY * (TRUNC((SYSDATE - HIRE_DATE) / 365) / 100),1) AS ����,
           (SALARY + SALARY * (TRUNC((SYSDATE - HIRE_DATE) / 365)/100)) - (SALARY + (SALARY * (TRUNC((SYSDATE - HIRE_DATE) / 365)/100))) * 0.13 AS ���޾� 
    FROM HR.EMPLOYEES;
    
    
    
��뿹) 
    SELECT FLOOR(23.456), FLOOR(23), FLOOR(-23.456), 
           CEIL(23.456), CEIL(23), CEIL(-23.456)
    FROM DUAL; 





��뿹
SELECT WIDTH_BUCKET(28, 10, 39, 3), -- 10���� 39���� 3���� �������� �������� 28�� ���° ������ ���ϴ°�
        WIDTH_BUCKET(8, 10, 39, 3), -- 10���� 39���� 3���� �������� �������� 8�� ���° ������ ���ϴ°�
        WIDTH_BUCKET(39, 10, 39, 3), -- 10���� 39���� 3���� �������� �������� 39�� ���° ������ ���ϴ°�
        WIDTH_BUCKET(58, 10, 39, 3), -- 10���� 39���� 3���� �������� �������� 58�� ���° ������ ���ϴ°�
        WIDTH_BUCKET(10, 10, 39, 3) -- 10���� 39���� 3���� �������� �������� 10�� ���° ������ ���ϴ°�
FROM DUAL; 




��뿹) ȸ�����̺����� ȸ������ ���ϸ����� ��ȸ�Ͽ� 
1000 - 9000���̸� 3���� �������� �����ϰ� 
ȸ����ȣ, ȸ����, ���ϸ���, ����� ����ϵ� 
������� ���ϸ����� ���� ȸ������ '1��� ȸ��', '2��� ȸ��', '3��� ȸ��', '4��� ȸ��'�� ����Ͻÿ�. 


SELECT MEM_ID AS ȸ����ȣ, 
       MEM_NAME AS ȸ����, 
       MEM_MILEAGE AS ���ϸ���, 
       4 - WIDTH_BUCKET( MEM_MILEAGE ,1000, 9000, 3)||'���ȸ��' AS ���
       --WIDTH_BUCKET( MEM_MILEAGE ,9000, 999, 3)||'���ȸ��'
FROM MEMBER;
























-





, 
       