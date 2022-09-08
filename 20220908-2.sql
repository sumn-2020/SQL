��뿹) ������ 2020�� 5�� 17���̶�� �����ϰ� ���� ��¥�� �Է¹޾� ��ٱ��� ��ȣ�� �����ϴ� �Լ��� �����Ͻÿ�.

CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(P_DATE IN DATE)
  RETURN CHAR
  
IS 
  V_CARTNO CART.CART_NO%TYPE;
  V_FLAG NUMBER:=0;
  V_DAY CHAR(9):=TO_CHAR(P_DATE,'YYYYMMDD')||TRIM('%');
  
BEGIN
  SELECT COUNT(*) INTO V_FLAG
    FROM CART
   WHERE CART_NO LIKE V_DAY;
   
   
   IF V_FLAG=0 THEN
      V_CARTNO:=TO_CHAR(P_DATE,'YYYYMMDD')||TRIM('00001');
   ELSE
      SELECT MAX(CART_NO)+1 INTO V_CARTNO
        FROM CART 
       WHERE CART_NO LIKE V_DAY;
   END IF;
   
   RETURN V_CARTNO;
END;

(����) �����ڷḦ CART���̺� �����Ͻÿ�.
    ���Ż�ǰ: 'j001'
    ���Ż�ǰ: 'P201000012'
    ���ż���: 5
    ��������: ����
    
INSERT INTO CART (CART_MEMBER, CART_NO,CART_PROD, CART_QTY)
   VALUES('j001', FN_CREATE_CARTNO(SYSDATE), 'P201000012', 5);

-----------------------------------------------------------------------------------------

��뿹) �⵵�� ���� ��ǰ��ȣ��  �Է� �޾� �ش� �Ⱓ�� �߻��� ��ǰ�� �������踦 ��ȸ�Ͻÿ�
       Alias�� ��ǰ��ȣ, ��ǰ��, ���Լ���, ���Աݾ�
       
--�Ѳ����� �ΰ��� ��ȯ���ִ� �Լ��� ���� ������ �ΰ� (���Լ������ϴ� �Լ� , ���Աݾ��� ���ϴ� �Լ�)


(���������Լ�)
CREATE OR REPLACE FUNCTION FN_SUM_BUYQTY(
   P_PERIOD IN CHAR,P_PID IN VARCHAR2)
   RETURN NUMBER 
IS 
   V_SUM NUMBER:=0; --��������
   V_SDATE DATE:= TO_DATE(P_PERIOD||'01');
   V_EDATE DATE:= LAST_DAY(V_SDATE); --LAST_DAY: ���� ������ ��¥ ��� 
BEGIN 
   SELECT NVL(SUM(BUY_QTY),0) INTO V_SUM -- SUM(BUY_QTY)�� V_SUM�� �Ѱ��ֱ�
     FROM  BUYPROD
    WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATE
      AND BUY_PROD=P_PID; -- ��ǰ�ڵ�� ���� ���� �������ָ� �ϳ��� ��ǰ�� �˻� 
      
   RETURN V_SUM;
END;

(����)
SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��,
       FN_SUM_BUYQTY('202002', PROD_ID) AS ���Լ���
  FROM PROD;


(�ݾ������Լ�)
CREATE OR REPLACE FUNCTION FN_COST(
   P_PERIOD IN CHAR,P_PID IN VARCHAR2)
   RETURN NUMBER 
IS 
   V_SUM NUMBER:=0;
   V_SDATE DATE:= TO_DATE(P_PERIOD||'01');
   V_EDATE DATE:= LAST_DAY(V_SDATE); 
BEGIN 
   SELECT NVL(SUM(BUY_QTY * BUY_COST),0) INTO V_SUM  
     FROM  BUYPROD
    WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATE
      AND BUY_PROD=P_PID; 
      
   RETURN V_SUM;
END;

(����)
SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��,
       FN_SUM_BUYQTY('202002', PROD_ID) AS ���Լ���,
       FN_COST('202002', PROD_ID) AS ���Աݾ��հ�
 FROM PROD;


(���ڿ��� ��ġ��)
CREATE OR REPLACE FUNCTION FN_SAMPLE(
   P_PERIOD IN CHAR,P_PID IN VARCHAR2)
   RETURN VARCHAR2 
IS 
   V_SUM2 VARCHAR2(100);
   V_SDATE DATE:= TO_DATE(P_PERIOD||'01');
   V_EDATE DATE:= LAST_DAY(V_SDATE); 
BEGIN 
   SELECT NVL(SUM(BUY_QTY * BUY_COST),0)||NVL(SUM(BUY_QTY),0) INTO V_SUM2  
     FROM BUYPROD
    WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATE
      AND BUY_PROD=P_PID; 
      
   RETURN V_SUM2;
END;

(����)
SELECT PROD_ID AS ��ǰ�ڵ�,
       PROD_NAME AS ��ǰ��,
       FN_SAMPLE('202002', PROD_ID) AS �������Աݾ��հ�
 FROM PROD;

