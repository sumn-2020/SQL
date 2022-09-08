SEMI join

��뿹) ������̺��� �޿��� 10000�̻��� ����� �����ϴ� �μ��� ��ȸ�Ͻÿ�.
       Alias�� �μ��ڵ�, �μ���, ���������
       
       -- 1) IN ������ ���
       SELECT �μ��ڵ�, �μ���, ���������
       FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE A.DEPARTMENT_ID IN(��������)
         AND A.MANAGER_ID=B.EMPLOYEE_ID
       ORDER BY 1;
       
       -- 2) ��������: �޿��� 10000�̻��� ����� �����ϴ� �μ� ��ȸ
       SELECT DISTINCT DEPARTMENT_ID
         FROM HR.EMPLOYEES
        WHERE SALARY >= 10000
        
      -- 3) ����
       SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
              A.DEPARTMENT_NAME AS �μ���, 
              B.EMP_NAME AS ���������
       FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE A.DEPARTMENT_ID IN(SELECT DISTINCT DEPARTMENT_ID
                                  FROM HR.EMPLOYEES
                                 WHERE SALARY >= 10000)
         AND A.MANAGER_ID=B.EMPLOYEE_ID
       ORDER BY 1;
       
       
    --- 3-1) EXISTS ������ ���
        SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
              A.DEPARTMENT_NAME AS �μ���, 
              B.EMP_NAME AS ���������
       FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE EXISTS(SELECT * 
                       FROM HR.EMPLOYEES C
                      WHERE C.SALARY>=10000
                      AND A.DEPARTMENT_ID=C.DEPARTMENT_ID) -- HR.EMPLOYEES C 20�������߿��� ������ 10000�̻��� �����鸸 �̾Ƽ� �� ����鸸 1���
         AND A.MANAGER_ID=B.EMPLOYEE_ID
       ORDER BY 1;
       
    
-------------------------------------------------------------------------------------
    
��뿹) ȸ�����̺��� ������ �ֺ��� ȸ������ ��� ���ϸ������� ���� ���ϸ����� ������ ȸ�������� ����Ͻÿ�.
      Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ��� 
    
    SELECT B.MEM_ID AS ȸ����ȣ, 
           B.MEM_NAME AS ȸ����, 
           B.MEM_JOB AS ����, 
           B.MEM_MILEAGE AS ���ϸ��� 
      FROM MEMBER A, MEMBER B
    WHERE A.MEM_NAME='��ö��'
      AND A.MEM_MILEAGE<B.MEM_MILEAGE;
      -- A���̺�: ��ö�� ȸ�� ������ ���� ���̺�
      -- B���̺�: ��ö�� �Ӿƴ϶� ������ ȸ���� ���� ���ΰ� ���� ���̺�
      
      
��뿹) ��ǰ�ڵ� 'P202000012'�� ���� �з��� ���� ��ǰ �� 'P202000012'���� ���Դܰ��� ū ��ǰ�� ��ȸ�Ͻÿ�
       Alias�� ��ǰ�ڵ�, ��ǰ��, �з���, ���Դܰ�
       
       SELECT B.PROD_ID AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��,
              C.LPROD_NM AS �з���,
              B.PROD_COST AS ���Դܰ�
        FROM PROD A, PROD B, LPROD C
       WHERE A.PROD_ID='P202000012' --�Ϲ�����
         AND A.PROD_LGU=B.PROD_LGU -- EUI JOIN ��������
         AND A.PROD_COST<B.PROD_COST -- NON EUI JOIN ��������
         AND A.PROD_LGU=C.LPROD_GU;   -- EUI JOIN ��������:  �з��� ��������
       
       
       















       
       
       
       
       
        