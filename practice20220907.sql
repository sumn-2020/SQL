��뿹) ��ǰ�� �з��ڵ尡 'P202'�� ���� �з���� ��ǰ�� ���� ����Ͻÿ�. 
SELECT B.LPROD_NM AS �з���,
       COUNT(*) AS "��ǰ�� ��"
FROM PROD A, LPROD B
WHERE B.LPROD_GU = A.PROD_LGU
  AND B.LPROD_GU = 'P202'
GROUP BY B.LPROD_NM;

SELECT LTRIM('APPLE PERSON', 'PPLE')
FROM DUAL;

SELECT LTRIM('APPLE PERSON', 'AP')
FROM DUAL; 
    
    
��뿹) �������̺�(JOBS)���� ������(JOB_TITLE) 'Accounting Manager'�� ������ ��ȸ�Ͻÿ�.
SELECT JOB_TITLE AS ������,
       LENGTHB(JOB_TITLE) AS "�������� ����",
       MIN_SALARY AS �����޿�,
       MAX_SALARY AS �ְ�޿�
FROM HR.JOBS
WHERE TRIM(JOB_TITLE) = 'Accounting Manager';


��뿹) JOBS���̺��� �������� ������ Ÿ���� VARCHAR2(40)���� �����Ͻÿ�.
UPDATE HR.JOBS
    SET JOB_TITLE=TRIM(JOB_TITLE);


��뿹) ȸ�����̺��� �ֹι�ȣ �ʵ�(MEM_REGNO1, MEMGEGNO2)�� �̿��Ͽ� ȸ������ ���̸� ���ϰ�, 
ȸ����ȣ, ȸ����, �ֹι�ȣ, ���̸� ����Ͻÿ�.

SELECT MEM_ID AS ȸ����ȣ, 
       MEM_NAME AS ȸ����, 
       MEM_REGNO1 ||'-'|| MEM_REGNO2 AS �ֹι�ȣ, 
       CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '2') THEN
            2022 - (TO_NUMBER(SUBSTR(MEM_REGNO1, 1,2)) + 1900) 
        ELSE 
            2022 - (TO_NUMBER(SUBSTR(MEM_REGNO1, 1, 2))+ 2000)
        END AS ����
FROM MEMBER;


SELECT GREATEST ('KOREA', 1000, 'ȫ�浿'),
       LEAST('ABC', 'ȫ�浿', '200')
FROM DUAL;




��뿹) ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ���� ã�� 1000���� ���� ����Ͻÿ�.
Alias�� ȸ����ȣ, ȸ����, �������ϸ���, ����� ���ϸ���



SELECT MEM_ID AS ȸ����ȣ, 
       MEM_NAME  AS ȸ����, 
       MEM_MILEAGE AS �������ϸ���, 
       MEM_MILEAGE < 1000 AS ����� ���ϸ���
FROM MEMBER;



��뿹) ȸ�����̺��� ȸ����ȣ, ȸ����, ���ϸ���, ������ ��ȸ�Ͻÿ�.
      ������ ���ϸ����� ���� ȸ������ �ο��ϰ� ���� ���ϸ����� ���� ������ �ο��Ͻÿ�.
SELECT MEM_ID AS ȸ����ȣ, 
       MEM_NAME AS ȸ����, 
       MEM_MILEAGE AS ���ϸ���,
       RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS ����
FROM MEMBER;
       
SELECT PROD_ID AS ��ǰ��ȣ,
       PROD_NAME AS ��ǰ��,
       NVL(TO_CHAR(PROD_MILEAGE),'���ϸ����� �������� �ʴ� ��ǰ') AS ���ϸ���
FROM PROD;

SELECT PROD_ID AS ��ǰ��ȣ,
       PROD_NAME AS ��ǰ��,
       NVL(LPAD(TO_CHAR(PROD_MILEAGE),5), '���ϸ����� �������� �ʴ� ��ǰ') AS ���ϸ���
FROM PROD;








