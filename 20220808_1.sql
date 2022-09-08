2022-0808-01)  
3. ��¥ �ڷ��� 
- ��¥ �ð� ������ ����(��, ��, ��, ��, ��, ��)
- ��¥ �ڷ�� ������ ������ ������
- date, timestamp Ÿ�� ����

1) DATEŸ��
. �⺻ ��¥ �� �ð����� ����
    (�������)
    �÷��� DATE 
        . ������ ������ ������ŭ �ٰ��� ��¥ (�̷�)
        . ������ ������ ������ŭ ������ ��¥ (����)
        . ��¥ �ڷ� ������ ������ ����(DAYS) ��ȯ
        . ��¥�ڷ�� ��/��/�� �κа� ��/��/�� �κ����� �����Ͽ� ����
        ** �ý����� �����ϴ� ��¥������ **SYSDATE�Լ�**�� ���Ͽ� ������ �� ����
    
    (��뿹) 
    CREATE TABLE TEMP16(
        COL1 DATE,
        COL2 DATE,
        COL3 DATE
    );
    INSERT INTO TEMP16 VALUES(SYSDATE, SYSDATE-10, SYSDATE+10);
    SELECT TO_CHAR(COL1, 'YYYY-MM-DD'),
           TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
           TO_CHAR(COL1, 'YYYY-MM-DD HH12:MI:SS')
    FROM TEMP16;
    
    -- TO_DATE(00010101) : ���� ��¥ - ���� 1�� 1�� 1�ϰ� = ���� �ٵ� ������ �� ������ �ʾұ� ������ -1����ߵ� 
    -- MOD: 7�� ���� ��������  1�ϸ� ������, 2�̸� ȭ����, 3�̸� ������... 
    -- DUAL: SELECT���� ����ϱ� ���ؼ� �ʿ������ �԰��� ���߱� ���ؼ� ���Ǵ� ������ ���̺� 
    SELECT CASE MOD(TRUNC(SYSDATE)-TRUNC(TO_DATE('00010101'))-1,7) 
                WHEN 1 THEN '������',
                WHEN 2 THEN 'ȭ����',
                WHEN 3 THEN '������',
                WHEN 4 THEN '�����',
                WHEN 5 THEN '�ݿ���',
                WHEN 6 THEN '�����',
                ELSE 7 THEN '�Ͽ���'
            END AS ����
    FROM DUAL;

    SELECT SYSDATE - TO_DATE('20200807') FROM DUAL; -- ���� ��¥���� 2020��08�� 07���� ���� �����°�
    SELECT * FROM TEMP16;
        
    2)( TIMESTAMP Ÿ��
    . �ð��� ����(TIME ZOME)�� ������ �ð�����(10����� 1��)�� �ʿ��� ��� ��� 
      
    (�������)
       �÷��� TIMESTAMP  - �ð��� �������� ������ �ð����� ����
       �÷��� TIMESTAMP WITH LOCAL TIME ZONE
       �÷��� TIMESTAMP WITH TIME ZONE
       
       
       . �ʸ� �ִ� 9�ڸ����� ǥ���� �� ������ �⺻�� 6�ڸ���
       
    
    
    CREATE TABLE TEMP117(
        COL1 DATE,
        COL2 TIMESTAMP,
        COL3 TIMESTAMP WITH LOCAL TIME ZONE,
        COL4 TIMESTAMP WITH TIME ZONE
    );
    
    INSERT INTO TEMP117 VALUES(SYSDATE,SYSDATE,SYSDATE,SYSDATE);
    
    
    
    
    SELECT * FROM TEMP117;
    
    
    
    
    
    
    
    
        
    
    
    
    