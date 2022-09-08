2022-0810-01) 

4. ��Ÿ������
- ����Ŭ���� �����ϴ� ��Ÿ�����ڴ� IN, ANY, SOME, ALL, EXISTS, BETWEEN, LIKE �����ڰ� ����
1) IN 
�������) 
expr IN(��, ��2,...��n);
=> expr = ��1
   OR expr = ��2
   OR    :
   OR expr = ��n
   
   ��뿹) ������̺��� �μ���ȣ�� 20, 50, 60, 100���� ���� ������� ��ȸ�Ͻÿ�. 
   Alias�� �����ȣ, �����, �μ���ȣ, �Ի���
   
   (OR ������ ���)
   SELECT EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����, 
       DEPARTMENT_ID AS �μ���ȣ, 
       HIRE_DATE AS �Ի���
   FROM HR.EMPLOYEES -- hr������ employees ���̺�
   WHERE DEPARTMENT_ID=20
        OR DEPARTMENT_ID=50
        OR DEPARTMENT_ID=60
        OR DEPARTMENT_ID=100
   ORDER BY  3; --�μ���ȣ�� �������� �������� ���� 
   
   
   (IN ������ ���)
   SELECT EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����, 
       DEPARTMENT_ID AS �μ���ȣ, 
       HIRE_DATE AS �Ի���
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID IN(20, 50, 60, 100) -- DEPARTMENT_ID�� 20�̰ų�, 50�̰ų�, 60�̰ų� 100�̸� 
   ORDER BY 3;
   
   
   (ANY ������ ���)
   SELECT EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����, 
       DEPARTMENT_ID AS �μ���ȣ, 
       HIRE_DATE AS �Ի���
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID =ANY(20, 50, 60, 100)
   ORDER BY 3;
   
   (SOME ������ ���)
   SELECT EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����, 
       DEPARTMENT_ID AS �μ���ȣ, 
       HIRE_DATE AS �Ի���
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID =SOME(20, 50, 60, 100)
   ORDER BY 3;
   
   
   2) ANY(SOME) ������ (���迬���ں��� �� �Ŀ� any(some)����� �� ����)
    ��뿹) ������̺��� �μ���ȣ 60���μ��� ���� ������� �޿� �� ���� ���� �޿����� 
    �� ���� �޿��� �޴� ������� ��ȸ�Ͻÿ�.
    Alias�� �����ȣ, �����, �޿�, �μ���ȣ�̸� �޿��� ����������� ����Ͻÿ�
    --�˰����� ���� ���� ������ ���� ���ϴ� �� = �������� 
    
    SELECT EMPLOYEE_ID AS �����ȣ, 
            EMP_NAME AS �����, 
            SALARY AS �޿�, 
            DEPARTMENT_ID AS �μ���ȣ
    FROM HR.EMPLOYEES
    WHERE  SALARY > (SELECT SALARY     --EMPLOYEE���̺� ���� ù��° ����� �������� �����ͼ� ���ض�. 1�� > 5�� (����)
                    FROM HR.EMPLOYEES
                    WHERE DEPARTMENT_ID = 60)
    ORDER BY 3; --�޿��� ����������� �������� ������ 
    
    
    
    SELECT EMPLOYEE_ID AS �����ȣ, 
            EMP_NAME AS �����, 
            SALARY AS �޿�, 
            DEPARTMENT_ID AS �μ���ȣ
    FROM HR.EMPLOYEES
    WHERE  SALARY >ANY (SELECT SALARY     
                    FROM HR.EMPLOYEES
                    WHERE DEPARTMENT_ID = 60)
    ORDER BY 3;
    
     SELECT EMPLOYEE_ID AS �����ȣ, 
            EMP_NAME AS �����, 
            SALARY AS �޿�, 
            DEPARTMENT_ID AS �μ���ȣ
    FROM HR.EMPLOYEES
    WHERE  SALARY >ANY (9000,6000,4800,4800,4200)
     AND DEPARTMENT_ID !=60
    ORDER BY 3;
    
    
    SELECT EMPLOYEE_ID AS �����ȣ, 
            EMP_NAME AS �����, 
            SALARY AS �޿�, 
            DEPARTMENT_ID AS �μ���ȣ
    FROM HR.EMPLOYEES
    WHERE  SALARY >ANY (SELECT SALARY   
                           FROM HR.EMPLOYEES
                           WHERE DEPARTMENT_ID = 60)
    AND DEPARTMENT_ID !=60
    ORDER BY 3;
   
   
   
   SELECT SALARY   
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID = 60; -- 4200
   
   
   
   ��뿹) 2020�� 4�� �Ǹŵ� ��ǰ �� ���Ե��� ���� ��ǰ�� ��ȸ�Ͻÿ�.
   Alias�� ��ǰ�ڵ��̴�. 
   
    SELECT CART_PROD AS ��ǰ�ڵ� 
    FROM CART
    WHERE CART_NO LIKE '202004%'-- 2020�� 4���޿� �߻��� �����ڷ� ��
        AND CART_PROD =ANY (SELECT DISTINCT BUY_PROD -- DISTICT: �ߺ��Ǵ� �ڷ� �ѹ��� ���
                                  FROM BUYPROD
                                  WHERE BUY_DATE >= '20200401' AND BUY_DATE <= '20200430'); -- 2020�� 4�� 1��~202�� 04��30�ϱ��� �߻��� ��ǰ�ڵ�
    
    -- CART_PROD�� 26���� ���ٸ� : �� 
    -- �ٸ��ٸ� : ����
    
    
    
    
    
    3) ALL ������
    ��뿹) ������̺��� �μ���ȣ 60���μ��� ���� ������� �޿� �� ���� ���� �޿����� 
    �� ���� �޿��� �޴� ������� ��ȸ�Ͻÿ�.
    Alias�� �����ȣ, �����, �޿�, �μ���ȣ�̸� �޿��� ����������� ����Ͻÿ�
    
    SELECT EMPLOYEE_ID AS �����ȣ, 
            EMP_NAME AS �����, 
            SALARY AS �޿�, 
            DEPARTMENT_ID AS �μ���ȣ
    FROM HR.EMPLOYEES
    WHERE SALARY >ALL(9000,6000,4800,4200)
    ORDER BY 3; 
    
    
    
    
    
        