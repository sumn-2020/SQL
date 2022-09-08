��뿹) Ű����� �μ��� �Է¹޾� �ش�μ��� ���� ���� �Ի��� ����� �����ȣ, �����, ��å�ڵ�, �Ի����� ����ϴ� ����� �ۼ��Ͻÿ�.

ACCEPT P_DID PROMPT '�μ���ȣ �Է� :'  -- ���ڿ� ���·� ����� 
DECLARE 
  V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;  --V_DID�� HR.DEPARTMENTS������ DEPARTMENT_ID�� ���� Ÿ������ 
  V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- �����ȣ�� �� ����
  V_NAME  VARCHAR2(100); --������� �� ����
  V_JID HR.JOBS.JOB_ID%TYPE; --��å�ڵ��� �� ����
  V_HDATE DATE; -- �Ի����� �� ����
BEGIN
  V_DID := TO_NUMBER('&P_DID');  --> := (=)�� ����  / =  equal TO
  SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.JOB_ID, A.HIRE_DATE
    INTO V_EID, V_NAME, V_JID, V_HDATE
    FROM (SELECT EMPLOYEE_ID, EMP_NAME, JOB_ID, HIRE_DATE  -- 2) EMPLOYEE_ID�� V_EID�� / EMP_NAME �� V_NAME�� ����
            FROM HR.EMPLOYEES
           WHERE DEPARTMENT_ID = V_DID
           ORDER BY 4) A
   WHERE ROWNUM = 1; -- 1) ������ �ִ� ����� ������ �� �����
   
   DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || V_EID); -- SYSTEM.OUT.PRINTLN  
   DBMS_OUTPUT.PUT_LINE('����� : ' || V_NAME);
   DBMS_OUTPUT.PUT_LINE('��å�ڵ� : ' || V_JID);
   DBMS_OUTPUT.PUT_LINE('�Ի��� : ' || V_HDATE);
   DBMS_OUTPUT.PUT_LINE('-------------------------------------');
END;



SELECT EMP_NAME, HIRE_DATE
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = 60;


---------------------------------------------------------------------------

��뿹) ȸ�����̺��� ������  '�ֺ�'�� ȸ������ 2020�� 5�� ������Ȳ�� ��ȸ�Ͻÿ�
       Alias�� ȸ����ȣ, ȸ����, ����, ���űݾ��հ�
       
(�͸��� ��� ���� ��)      
 SELECT  A.MEM_ID AS ȸ����ȣ, 
         A.MEM_NAME AS ȸ����, 
         A.MEM_JOB AS ����, 
         D.BSUM AS ���űݾ��հ�
   FROM (SELECT MEM_ID, MEM_NAME, MEM_JOB
           FROM MEMBER 
          WHERE MEM_JOB='�ֺ�') A,
        (SELECT B.CART_MEMBER AS BMID,
                SUM(B.CART_QTY * C.PROD_PRICE) AS BSUM
           FROM CART B, PROD C
          WHERE B.CART_PROD = C.PROD_ID
            AND B.CART_NO LIKE '202005%'
          GROUP BY B.CART_MEMBER) D
WHERE A.MEM_ID = D.BMID;
       
       
(�͸��� ����� ��)
DECLARE
    V_MID MEMBER.MEM_ID%TYPE; --MEMBER.MEM_ID�� ���� Ÿ������ V_MID�� �����Ѵ�. 
    V_NAME VARCHAR2(100); 
    V_JOB MEMBER.MEM_JOB%TYPE;
    V_SUM NUMBER:=0; -- �ڸ��� ���� �������൵ 27�ڸ������� �ڵ����� ����� /NUMBERŸ���� ������ 0���� �ʱ�ȭ ���Ѿ� �� 
    
    CURSOR CUR_MEM IS  -- SELECT ���� ���Ǵ� CURSOR�� INTO�� �Ⱦ�
     SELECT MEM_ID, MEM_NAME, MEM_JOB --�ֺ��� ����� MEM_ID, MEM_NAME, MEM_JOB ������ CUR_MEM�ȿ� �ֱ� 
           FROM MEMBER 
          WHERE MEM_JOB='�ֺ�';
BEGIN
   OPEN CUR_MEM; -- Ŀ���� ������ ���� ǥ�ȿ� ���� �ټ����� �ֺ��� ȸ���� �ϳ��ϳ� ���ü� ����(FETCH).Ŀ���� CLOSE �Ǵ� ���� ǥ�� ������ ���ٸ���  
   LOOP
     FETCH CUR_MEM INTO V_MID, V_NAME, V_JOB;  -- �������� �����鼭 ������ ������ �־�� 
     EXIT WHEN CUR_MEM%NOTFOUND; --�� �̻� ���� ������ ���� ��� EXIT : LOOP���� ������ 
     SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM  --SUM(A.CART_QTY*B.PROD_PRICE)�� V_SUM���ٰ� �־��
       FROM CART A, PROD B
      WHERE A.CART_PROD = B.PROD_ID
        AND A.CART_NO LIKE '202005%'
        AND A.CART_MEMBER = V_MID;
     DBMS_OUTPUT.PUT_LINE('ȸ����ȣ:'||V_MID); --FETCH�ٿ� �ִ� V_MID�� ���ͼ� ���
     DBMS_OUTPUT.PUT_LINE('ȸ����:'||V_NAME);
     DBMS_OUTPUT.PUT_LINE('����:'||V_JOB);
     DBMS_OUTPUT.PUT_LINE('���űݾ�:'||V_SUM);
     DBMS_OUTPUT.PUT_LINE('-------------------------------------');
   END LOOP; -- �ݺ��� ����������
   CLOSE CUR_MEM; -- ������� CURSOR�� �ݾƶ�
END;
    
    
-- Ŀ���� ����� ����: �� �پ� �о �ϳ��ϳ� ���� �ȿ� ������� ...
-------------------------------------------------------------------------------------


��뿹) �⵵�� �Է� �޾� �������� ������� �����ϴ� ����� �ۼ��Ͻÿ�.


-- 1) ��ϸ����
DECLARE

BEGIN

END;


-- 2) �⵵�� �Է� �޾�
ACCEPT P_YEAR PROMPT '�⵵�Է� : '
DECLARE

BEGIN

END;


-- 3) ������ �����ϸ鼭 �޾ƿ� ������ ���ڷ� �ٲ㼭 V_YEAR�� ����
ACCEPT P_YEAR PROMPT '�⵵�Է� : '
DECLARE
    V_YEAR NUMBER:=TO_NUBMER('&P_YEAR'); 
    V_RES VARCHAR2(200);
BEGIN

END;



-- 4)  �������� ������� ���� : 4�� ��� - ����
ACCEPT P_YEAR PROMPT '�⵵�Է� : '
DECLARE
    V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');
    V_RES VARCHAR2(200);
BEGIN
    IF(MOD(V_YEAR, 4) = 0 AND MOD(V_YEAR, 100) != 0) OR (MOD(V_YEAR,400) = 0) THEN -- YEAR�� 4�γ��� �������� 0�� ����
       V_RES:=V_YEAR||'���� �����Դϴ�.';
    ELSE
       V_RES:=V_YEAR||'���� ����Դϴ�.';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_RES); --V_RES���
END;


-------------------------------------------------------------------------------------

��뿹) �������� �Է¹޾� ���� ���̿� ������ ���̸� ���Ͻÿ�.
       ���� ����: ������ * ������* ������(3.1415926) - ����Ἥ �غ���
       �� �ѷ�: ���� * 3.1415926



ACCEPT V_RADIUS PROMPT '�������Է� : '
DECLARE
    V_RADIUS NUMBER := 15;
    V_PIE CONSTANT NUMBER := 3.1415926;
    V_AREA NUMBER := 0;
    V_CIRCUM NUMBER := 0;
BEGIN
    V_AREA :=  V_RADIUS * V_RADIUS * V_PIE;
    V_CIRCUM := V_RADIUS  * 2 * V_PIE;
    
    
    DBMS_OUTPUT.PUT_LINE('���� �ʺ� = ' || V_AREA);
    DBMS_OUTPUT.PUT_LINE('���� �ѷ� = ' || V_CIRCUM);
END;

























