Ŀ��


-----------------------------------------------------------
�Ӽ�               �ǹ�
-----------------------------------------------------------
SQL%ISOPEN        Ŀ���� OPEN �Ǿ����� ��(ture) ��ȯ �׻� false��
SQL%FOUND         Ŀ�� ���ο� FETCH�� �ڷᰡ �����ϸ� ��(true)
SQL%NOTFOUND      Ŀ�� ���ο� FETCH�� �ڷᰡ ������ ��(true)
SQL%ROWCOUNT      Ŀ�� ������ ���� �� ��ȯ
-----------------------------------------------------------



----------------------------------------------------------------------


��뿹) ������̺��� �μ���ȣ�� �Է¹޾� �� �μ��� ���� ��������� ����ϴ� Ŀ�� �ۼ�


DECLARE 
 CURSOR EMP_CUR(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS 
  SELECT  EMPLOYEE_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID=P_DID;
























