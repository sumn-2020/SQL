[�Լ�]
1. ���ڿ��Լ� 
    1) CONCAT : ���ڿ� ����
    SELECT  MEM_ID AS ȸ����ȣ,
            MEM_NAME AS ȸ����,
            CONCAT(CONCAT(MEM_REGNO1, '-'), MEM_REGNO2) AS �ֹι�ȣ, --MEM_REGNO1�� -�� ��ġ��, MEM_REGNO1-�� MEM_REGNO2�� ��ģ��. => MEM_REGNO1-MEM_REGNO2
            -- MEM_REGNO1 ||'-'|| MEM_REGNO2 AS �ֹι�ȣ
            MEM_JOB AS ����
    FROM MEMBER;

    2) LOWER, UPPER, INITCAP : �빮�ڸ� �ҹ��ڷ�(LOWER), �ҹ��ڸ� �빮�ڷ�(UPPER), �ܾ��� ù���ڸ� �빮�ڷ�(INITCAP)
    SELECT LOWER(EMAIL) || '@gamil.com' AS �̸����ּ� -- �̸��� �ּҸ� �ҹ��ڷ� ������ @gamil.com�ٿ��� ���
    FROM HR.EMPLOYEES;

    3) LPAD, RPAD : ���� ���� - LPAD�� ���ʺ���, RPAD�� �����ʺ���
    SELECT LPAD('������ �߱�', 20, '*'), -- 20ĭ�� �־����� ���ڿ��� �����ʿ������� ����, �������� *�� ä���
           LPAD('������ �߱�', 20), -- 20ĭ�� �־����� ���ڿ��� �����ʿ������� ����, �������� �������� ä���
           RPAD('������ �߱�', 20, '*'),
           RPAD('������ �߱�' , 20)
    FROM DUAL; 
    
    4) LTRIM, RTRIM: ���ڿ� ���� 
    SELECT LTRIM('APPLE PERSIMMON BANANA', 'PPLE'), 
           LTRIM('   APPLE PERSIMMON BANANA') -- �������
    FROM DUAL;
    
    5) TRIM: ��������
    SELECT TRIM('     SAMPLE TEXT')
    FROM DUAL;
    
    6) SUBSTR: ���� ����
    SELECT SUBSTR('ABCDEFGHIJK', 3, 5), -- 3��°���� �ټ����� �������� 
           SUBSTR('ABCDEFGHIJK', -3, 5) -- �ڿ��� ����°���� �ټ����� ���� ����
    FROM DUAL; 
    
    7) REPLACE: ���ڱ�ü
    SELECT REPLACE('APPLE    PERSIMMON BANANA', 'A', '����'), -- ��� A�� ���̷� ����
           REPLACE('APPLE    PERSIMMON BANANA', 'A') -- ��� A����
    FROM DUAL;
    
    
2. �����Լ� 
    1) ABS, SIGN, POWER, SQRT 
    - ABS: ���밪 ��ȯ
    - SIGN : ����� 1, ������ -1, 0�̸� 0
    - POWER : e�� n�� ��
    - SQRT: n�� ������
    
    2) GREATEST, LEAST
    - GREATEST: �� ��(������)���� �����Ǿ��ִ� ���� �� ���� ū ��, 
    - LEAST : �� ��(������)���� �����Ǿ��ִ� ���� �� ���� ���� �� ���� 
    
    SELECT GREATEST(100, 200, 300),
           LEAST(100, 200, 300)
    FROM DUAL;
    
    3) ROUND, TRUNC
    - ROUND: �ݿø� 
    - TRUNC: ����
    SELECT ROUND(12345.678945, 3), -- �Ҽ��� ����° �ڸ�+1���� �ݿø�
           ROUND(12345.678945, -3) ???????????
    FROM DUAL;
    
    SELECT TRUNC(12345.678945, 3), -- �Ҽ��� ����° �ڸ� + 1���� �׳� ����
           TRUNC(12345.678945), --6���� �׳� ����
           TRUNC(12345.678945, -3) -- ����° �ڸ����� �׳� 0���� ��ü 
    FROM DUAL;
    
    4) FLOOR, CEIL
    - FLOOR: n���� ���� ���� (n=2745.675 ��ȯ: 2745)
    - CEIL: n���� ū ���� (n=2745.675 ��ȯ: 2746)

    SELECT FLOOR(23.456), FLOOR(23), FLOOR(-23.456),
           CEIL(23.456), CEIL(23), CEIL(-23.456)
    FROM DUAL;
    
    5) MOD, REMAINDER
    - MOD : ������ ��ȯ, n - b * FLOOR(n/b)
    - REMAINDER: �������� ũ�Ⱑ  b���� ������ �׳� ��ȯ�ϰ�, ũ�� ���� ���� �� �� ��ȯ, n - b * ROUND(n/b)
    MOD(23,7) = 23 - (7 * FLOOR(23/7))
          = 23 - 7 * FLOOR(3.286)
					= 23 - 7 * 3
					= 2

    REMAINDER(23,7) = 23 - (7 * ROUND(23/7))
					= 23 - 7 * ROUND(3.286)
					= 23 - 7 * 3
					= 2

    6) WIDTH_BUCKET : b���� �������� ���� �� ��� ������ ���ϴ��� �Ǵ��ϴ� ��
    SELECT WIDTH_BUCKET(28, 10, 39, 3) -- 10���� 39���� 3���� �������� ������ �� 28�� �� ��° ������ ���ϴ°�
    FROM DUAL;
    

3. ��¥�Լ�
    1) SYSDATE : ���� ��¥ �� �ð����� ����
    2) ADD_MONTHS : �־��� ��¥�� n��ŭ�� ���� ���� ��¥ ��ȯ
    SELECT ADD_MONTHS(SYSDATE,2) --�̹��޿��� 2�� ���� ��¥ => �δ� ��
    FROM DUAL; 
    
    3) NEXT_DAY
    SELECT NEXT_DAY(SYSDATE,'�ݿ���') -- ���ÿ��Ͽ��� �� ���� �ݿ���
    FROM DUAL;
    
    
    
    
    
    
