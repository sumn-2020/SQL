2022-0907-02) Stored Procedure(Procedure)  
  - Ư�� ������ ó���ϰ� �� ��� ���� ��ȯ���� �ʴ� ���� ���α׷�  
  - �̸� ������ �Ǿ� ����(������ ȿ������ ����, ��Ʈ��ũ�� ���� ���޵Ǵ� �ڷ��� ���� �۴�)
  (�������)
   CREATE [OR REPLACE] PROCEDURE ���ν�����[(
     ������ [IN|OUT|INOUT] ������Ÿ��[:=����Ʈ��],
                     :
     ������ [IN|OUT|INOUT] ������Ÿ��[:=����Ʈ��])]
   IS|AS
     ���𿵿�
   BEGIN
     ���࿵��
   END;
    . '������' : �Ű�������
    . 'IN|OUT|INOUT' : �Ű������� ���� ����(IN : �Է¿�, OUT : ��¿�, INOUT : ����� ����)  -- ��ȯ�� �ƴ�. �����ϸ� IN�� �⺻��
    . '������Ÿ��' : ũ�⸦ ����ϸ� ����  -- ������ Ÿ�Ը� ����, ũ�� �����ϸ� �� ����
    . '����Ʈ��' : ����ڰ� �Ű������� ����ϰ� ���� �������� �ʾ��� �� �ڵ����� �Ҵ�� ��
    
  (���๮)
  EXECUTE|EXEC ���ν�����[(�Ű�����list)];
  �Ǵ� ���ν����� �ٸ� ��Ͽ��� ������ ���
  ���ν�����[(�Ű�����list)];
 -- FUCTION�� ��� / ��ȯ���� ���� �Լ� / �ڹ��� void Ÿ�� �޼ҵ�ó�� 
 -- OUT ���� ������ ���� ��ȯ���� �ƴ� ��°�  
 -- ���ν��� �̸��̳� �Լ����� ���� ��ȯ�Ǵ� ���� ��ȯ��
 -- ���ν����� ��ȯ�� �����Ƿ� SELECT��, WHERE���� ����� �� ����
 -- INOUT�� �����Ϸ��� �δ��� �ǹǷ� �� �� ������ �� ���� �� ����
 -- �����ϸ� IN�� �⺻��. �Է¿�
 -- ũ�� �����ϸ� �� ����
 -- ����Ʈ���� �� �� ������ �� ���� �� ���� => ������ �� �Ű����� ���� ���

��뿹)�μ���ȣ�� �Է¹޾� �ش� �μ��� �μ����� �̸�, ��å, �μ���, �޿��� ����ϴ� ���ν����� �ۼ��Ͻÿ�.
  CREATE OR REPLACE PROCEDURE PROC_EMP01(
    P_DID IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
  IS
    V_NAME VARCHAR2(100);
    V_JOBID HR.JOBS.JOB_ID%TYPE;
    V_DNAME VARCHAR2(100);
    V_SAL NUMBER:=0;
  BEGIN
    SELECT B.EMP_NAME, B.JOB_ID, A.DEPARTMENT_NAME, B.SALARY
      INTO V_NAME, V_JOBID, V_DNAME, V_SAL
      FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
     WHERE A.DEPARTMENT_ID=P_DID
       AND A.MANAGER_ID=B.EMPLOYEE_ID;
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : '||P_DID);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : '||V_JOBID);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '||V_DNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||V_SAL);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
  END;
  
(����)
EXECUTE PROC_EMP01(60);  
  
  