20220907-01 �б⹮�� �ݺ���

��뿹) ������̺��� ������ �μ��� �����Ͽ� ù��° �˻��� ����� �޿��� ��ȸ�ϰ� 
       �� �޿��� 
              1 ~ 5000 : '�� ��� ���'
          5001 ~ 10000 : '��պ�� ���'
         10001 ~ 20000 : '���� ���'
                �� �̻� : '�ʰ���� ���'�� �����, �޿��� �Բ� ����Ͻÿ�
    
                
DECLARE 
    V_RES VARCHAR2(100); -- ����ڵ� ����� ����
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; -- �����
    V_SAL NUMBER:= 0; -- �޿�
    V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; -- �μ��ڵ�
BEGIN 
    V_DID := TRUNC(DBMS_RANDOM.VALUE(10, 119), -1); -- DBMS_RANDOM.VALUE :  ������ ���� �߻� ��Ŵ / DEPARTMENT_ID 10 ~ 119���� �������� ��� / TRUNC: 19 ���͵� 10���� ����, 119���͵� 9���ְ� 110����
    SELECT EMP_NAME, SALARY INTO V_ENAME, V_SAL
      FROM HR.EMPLOYEES
     WHERE DEPARTMENT_ID =  V_DID
       AND ROWNUM = 1; -- ���� ù��° ��ȸ�Ǿ����� ���
       
    CASE WHEN V_SAL<=5000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'�� ��� ���';
         WHEN V_SAL<=10000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'��պ�� ���';
         WHEN V_SAL<=20000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'�� ��� ���';
         ELSE   
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'�ʰ���� ���';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(V_RES);
END;

------------------------------------------------------------------------

��뿹) �������� 5���� ����Ͻÿ�.
DECLARE
    V_CNT NUMBER:=0;
BEGIN
    LOOP
      
       EXIT WHEN V_CNT>9; --9���� ���ǹ� �ݺ�,
       DBMS_OUTPUT.PUT_LINE('5 *'||V_CNT||' = '||5*V_CNT);
        V_CNT := V_CNT + 1; 
    END LOOP;
END;


----------------------------------------------------------------

��뿹) ������̺��� ������ �μ��� �����Ͽ� �ش�μ��� �Ҽӵ� ������� �޿��� ��ȸ�ϰ� 
       �� �޿��� 
              1 ~ 5000 : '�� ��� ���'
          5001 ~ 10000 : '��պ�� ���'
         10001 ~ 20000 : '���� ���'
                �� �̻� : '�ʰ���� ���'�� �����, �޿��� �Բ� ����Ͻÿ�
    


DECLARE
    V_RES VARCHAR2(100); -- ���
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; --�����
    V_SAL NUMBER:= 0;  -- �޿�
    V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; -- �μ���ȣ
    CURSOR EMP01_CUR(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS 
      SELECT EMP_NAME, SALARY --DECLARE�������� SELECT INTO �Ⱦ� BE. INTO�� BEGIN�������� ���� ���������� ����(���������������� �Ⱦ���)
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID=P_DID; -- DEPARTMENT_ID�� P_DID�� �����Ǿ��� Ŀ��
BEGIN
  V_DID:=TRUNC(DBMS_RANDOM.VALUE(10,119),-1);
  OPEN EMP01_CUR(V_DID); --  : V_DID(argument)�� P_DID(�Ķ����)�� ���޵�
  DBMS_OUTPUT.PUT_LINE('�μ��ڵ� :' || V_DID); -- �μ��ڵ� ���
  LOOP
    FETCH EMP01_CUR INTO V_ENAME, V_SAL; --EMP01_CUR�� �����ͼ� V_ENAME, V_SAL�� �־�� 
    EXIT WHEN EMP01_CUR%NOTFOUND; -- �о���� ������ �̰� ���� �ȵ� ������ FETCH�ϰ� �� �Ŀ� ����� / Ŀ������ ���̻� �о�� �����Ͱ� ������ ������ ���� ������.
    CASE WHEN V_SAL<=5000 THEN    -- Ŀ���� ���빰�� ������ ����
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'�� ��� ���';
         WHEN V_SAL<=10000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'��պ�� ���';
         WHEN V_SAL<=20000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'�� ��� ���';
         ELSE   
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'�ʰ���� ���';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(V_RES);
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('--------------------------------');
   DBMS_OUTPUT.PUT_LINE('��� ��: ' || EMP01_CUR%ROWCOUNT||'��'); -- ����� ��� / ROWCOUNTĿ���� ����ִ� ��ü ���� ��
  CLOSE EMP01_CUR;
END;

---------------------------------------------------------------------------------

��뿹) �������� 5���� ����Ͻÿ�.
DECLARE
    V_CNT NUMBER:=1;
BEGIN
    WHILE V_CNT<=9 LOOP
      DBMS_OUTPUT.PUT_LINE('5 *' || V_CNT||' = '||5*V_CNT);
      V_CNT := V_CNT + 1;
    END LOOP;
END;


��뿹) ������̺��� ������ �μ��� �����Ͽ� �ش�μ��� �Ҽӵ� ������� �޿��� ��ȸ�ϰ� 
       �� �޿��� 
              1 ~ 5000 : '�� ��� ���'
          5001 ~ 10000 : '��պ�� ���'
         10001 ~ 20000 : '���� ���'
                �� �̻� : '�ʰ���� ���'�� �����, �޿��� �Բ� ����ϴ� ����� WHILE������ �����Ͻÿ�


DECLARE
    V_RES VARCHAR2(100); -- ���
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; --�����
    V_SAL NUMBER:= 0;  -- �޿�
    V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; -- �μ���ȣ
    CURSOR EMP01_CUR(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS 
      SELECT EMP_NAME, SALARY 
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID=P_DID; 
BEGIN
  V_DID:=TRUNC(DBMS_RANDOM.VALUE(10,119),-1);
  OPEN EMP01_CUR(V_DID); 
  DBMS_OUTPUT.PUT_LINE('�μ��ڵ� :' || V_DID); 
  FETCH EMP01_CUR INTO V_ENAME, V_SAL;  -- ù��° ��� ó��
  WHILE EMP01_CUR%FOUND LOOP -- "������ FETCH�ϰ� �� �Ŀ�"  �����
  --FETCH EMP01_CUR INTO V_ENAME, V_SAL; -- FETCH�� ���� ������ �� ������ ����� �ι�����
    CASE WHEN V_SAL<=5000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'�� ��� ���';
         WHEN V_SAL<=10000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'��պ�� ���';
         WHEN V_SAL<=20000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'�� ��� ���';
         ELSE   
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'�ʰ���� ���';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(V_RES);
    FETCH EMP01_CUR INTO V_ENAME, V_SAL; -- �ι�° ��� ������ �ٽ� �ݺ��� ���� 
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('--------------------------------');
   DBMS_OUTPUT.PUT_LINE('��� ��: ' || EMP01_CUR%ROWCOUNT||'��');
  CLOSE EMP01_CUR;
END;
--WHILE���� �׻� FETCH�� �ι� �������ߵ� 



-------------------------------------------------------------------------------



��뿹) �������� 5���� FOR���� �̿��Ͽ� ����Ͻÿ�.
DECLARE
BEGIN
    FOR I IN 1..9 LOOP
      DBMS_OUTPUT.PUT_LINE('5 * '|| I || ' = ' || 5*I);
    END LOOP;
END;



------------------------------------------------------------------------

��뿹) ������̺��� ������ �μ��� �����Ͽ� �ش�μ��� �Ҽӵ� ������� �޿��� ��ȸ�ϰ� 
       �� �޿��� 
              1 ~ 5000 : '�� ��� ���'
          5001 ~ 10000 : '��պ�� ���'
         10001 ~ 20000 : '���� ���'
                �� �̻� : '�ʰ���� ���'�� �����, �޿��� �Բ� ����ϴ� ����� FOR������ �����Ͻÿ�-
                

(CURSOR ���)
DECLARE
    V_CNT NUMBER:=0; 
    V_RES VARCHAR2(100); -- ���

    CURSOR EMP01_CUR IS 
      SELECT EMP_NAME, SALARY 
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID=80; 
BEGIN
  DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : 80'); 
  FOR REC IN EMP01_CUR LOOP
    V_CNT:=V_CNT + 1;
    CASE WHEN REC.SALARY<=5000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'�� ��� ���';
         WHEN REC.SALARY<=10000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'��պ�� ���';
         WHEN REC.SALARY<=20000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'�� ��� ���';
         ELSE   
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'�ʰ���� ���';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(V_RES);
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('--------------------------------');
   DBMS_OUTPUT.PUT_LINE('��� ��: ' || V_CNT ||'��');
END;


(IN-LINE SUBQUERY) - Ŀ�� ���� �ʿ� ���� 
DECLARE
    V_CNT NUMBER:=0; 
    V_RES VARCHAR2(100); -- ���
BEGIN
  DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : 80'); 
  FOR REC IN ( SELECT EMP_NAME, SALARY FROM HR.EMPLOYEES
               WHERE DEPARTMENT_ID=80) LOOP
    V_CNT:=V_CNT + 1;
    CASE WHEN REC.SALARY<=5000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'�� ��� ���';
         WHEN REC.SALARY<=10000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'��պ�� ���';
         WHEN REC.SALARY<=20000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'�� ��� ���';
         ELSE   
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'�ʰ���� ���';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(V_RES);
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('--------------------------------');
   DBMS_OUTPUT.PUT_LINE('��� ��: ' || V_CNT ||'��');
END;

































