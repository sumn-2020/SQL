��뿹)
    SELECT LTRIM('APPLE PERSIMMON BANANA', 'PPLE'), --PPLE�� ��ġ�ϴ��� A��� ���۱��ڰ� ��ġ���� �ʱ� ������ ����� ���� 
           LTRIM('   APPLE PERSIMMON BANANA'), -- ���� ����
           LTRIM('APPLE PERSIMMON BANANA', 'AP'),
           LTRIM('APTPLEAP PERSIMMON BANANA', 'AP'), -- AP�� ��ġ�ϹǷ� AP ���� �� �� �ش� ���ڿ� A�� P�� �����ؼ� ������ ����(�ҿ��������� ������ ���� �Ұ���)
           LTRIM('APPALEAP APPERSIMMON APBANANA', 'AP'),  --AP������ P�� ���������� �����Ƿ� ���� 
           LTRIM('PRAPALEAP APPERSIMMON APBANANA', 'AP')
    FROM DUAL;
    
    
    
------------------------------------------------------------


��뿹) �������̺�(JOBS)���� ������(JOB_TITLE) 'Accounting Manager'�� ������ ��ȸ�Ͻÿ�. 

SELECT JOB_ID AS �����ڵ�, 
       JOB_TITLE AS ������, 
       LENGTHB(JOB_TITLE) AS "�������� ����", 
       MIN_SALARY AS �����޿� , 
       MAX_SALARY AS �ְ�޿� 
FROM HR.JOBS
WHERE TRIM(JOB_TITLE) = 'Accounting Manager';


��뿹) JOBS���̺��� �������� ������ Ÿ���� VARCHAR2(40)���� �����Ͻÿ�.
UPDATE HR.JOBS
    SET JOB_TITLE=TRIM(JOB_TITLE);

COMMIT;


--------------------------------------
��뿹)
SELECT SUBSTR('ABCDEFGHIJK', 3, 5), -- 3��°���� �ټ����� ���ڸ� �ڸ� 
       SUBSTR('ABCDEFGHIJK', 3),
       SUBSTR('ABCDEFGHIJK', -3, 5), -- �ڿ��� ����°���� �ټ�����  
       SUBSTR('ABCDEFGHIJK', 3, 15) -- ���ڼ����� ū ���� �� ū ���� ������ ������ ��� �� ���� �ٸ� ���� 
FROM DUAL;
--------------------------------------------------------------------------------------
��뿹) ȸ�����̺��� �ֹι�ȣ �ʵ�(MEM_REGNO1, MEMGEGNO2)�� �̿��Ͽ� ȸ������ ���̸� ���ϰ�, 
        ȸ����ȣ, ȸ����, �ֹι�ȣ, ���̸� ����Ͻÿ�.
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ, 
           CASE WHEN SUBSTR(MEM_REGNO2, 1,1) IN ('1','2') THEN  -- MEM_REGNO2 ù��° ���ڿ��� ù��° ���ڸ� ���������� �� ���ڰ� 1�Ǵ� 2�϶� 
                2022-(TO_NUMBER(SUBSTR(MEM_REGNO1, 1, 2))+1900) -- 1990���� ù��° ���ڿ��� �α��� �ڸ���(SUBSTR) => 90 �׸��� �̰� ���ڷ� �����ϰ�(TO_NUMBER) 90+1900 = 1990 => 2022 - 1990 = ���� ����
           ELSE 
                2022-(TO_NUMBER(SUBSTR(MEM_REGNO1, 1, 2))+2000)
           END AS ���� 
    FROM MEMBER;


��뿹) ������ 2020�� 4�� 1���̶�� �����Ͽ� 'c001'ȸ���� ��ǰ�� ���� �� �� 
        �ʿ��� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�. (MAX(), TO_CHAR()�Լ����)
        
        SELECT '20200401' || TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO, 9))) + 1, '0000'))
        -- TO_NUMBER(SUBSTR(CART_NO, 9)): CART_NUM�� 9��° ���ڸ� �������� ���� ����ϰ� ���ڿ��� ���ڷ� ��ȯ 
        -- MAX(TO_NUMBER(SUBSTR(CART_NO, 9)) : �� �߿��� ���� ū �� ���  3 
        -- TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO, 9)) : ���ڿ��� ��ġ�� ���ؼ� �ٽ� ���ڿ��� ��ȯ
        -- 2020040100003���� 2020040100004���� ����Ǿ�� �Ǳ� ������ 3+1
        -- ||: 20200401��TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO, 9))) + 1, '0000')��ġ�� 
        -- TRIM : ���ʿ��� ���� ���� 
        FROM CART
        WHERE SUBSTR(CART_NO, 1, 8) = '20200401';
        
        
        SELECT MAX(CART_NO) + 1 
        FROM CART
        WHERE SUBSTR(CART_NO, 1, 8) = '20200401';
    

��뿹) �̹��� ������ ȸ������ ��ȸ�Ͻÿ�. 
    Alias�� ȸ����ȣ, ȸ����, �������, ���� 
    ��, ������ �ֹε�Ϲ�ȣ�� �̿��� �� 
    
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_REGNO1 AS �������, 
           SUBSTR(MEM_REGNO1,3,2) AS ���� 
    FROM MEMBER
    WHERE SUBSTR(MEM_REGNO1,3,2) = '09';


-----------------------------------------------------------------------
��뿹)
    SELECT REPLACE('APPLE   PERSIMMON BANANA', 'A', '����'),  -- ��� A�� ���̷� ����
           REPLACE('APPLE   PERSIMMON BANANA', 'A'), -- ��� A�� ����
           REPLACE('APPLE   PERSIMMON BANANA', ' ', '-'), -- ��� ��ĭ ������ ã�Ƽ� -���� ���� 
           REPLACE('APPLE   PERSIMMON BANANA   ', ' ')    -- ��� ��ĭ���� ����
    FROM DUAL;









