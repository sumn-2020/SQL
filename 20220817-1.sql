2022-08-17) �Լ� 

1. ���ڿ��Լ�
 1) CONCAT(c1, c2)
    - �־��� �� ���ڿ� c1�� c2�� �����Ͽ� ���ο� ���ڿ��� ��ȯ 
    - ���ڿ� ���տ����� '||'�� ���� ��� 
    
    
    
    ��뿹) ȸ�����̺��� ����ȸ���� ȸ����ȣ, ȸ����, �ֹι�ȣ, ������ ����Ͻÿ�. 
            ��, �ֹι�ȣ�� 'XXXXXX-XXXXXXX'�������� ����Ͻÿ�.
    
    (���ڿ� ���տ����� '||' ���)
    SELECT MEM_ID AS ȸ����ȣ, 
    MEM_NAME AS ȸ����, 
    MEM_REGNO1 ||'-'|| MEM_REGNO2 AS �ֹι�ȣ, 
    MEM_JOB AS ����
    FROM MEMBER
    WHERE SUBSTR(MEM_REGNO2,1,1) IN('2', '4') --MEM_REGNO2�÷����� �� ù��° �ڸ� ù��° ���ڰ� 2�Ǵ� 4�϶�
    
    
   (CONCAT ���)
    SELECT MEM_ID AS ȸ����ȣ, 
    MEM_NAME AS ȸ����, 
    CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) AS �ֹι�ȣ, -- MEM_REGNO1�� -�� ������ ��, MEM_REGNO2 �ֹε�ϵ޹�ȣ�� �ٽ� ����
    MEM_JOB AS ����
    FROM MEMBER
    WHERE SUBSTR(MEM_REGNO2,1,1) IN('2', '4')
    
    
    ��뿹) ��ǰ�� �з��ڵ尡 'P202'�� ���� �з���� ��ǰ�� ���� ����Ͻÿ�. 
    SELECT  B.LPROD_NM AS �з���,
            COUNT(*) AS "��ǰ�� ��"
    FROM PROD A, LPROD B --���̺� ��Ī �ο�
    WHERE A.PROD_LGU=B.LPROD_GU  --A���̺� �ִ� �з��ڵ尡 B���̺� �ִ� �з��ڵ�� ������
        AND A.PROD_LGU='p202' 
    GROUP BY B.LPROD_NM;
    
    
    SELECT  B.LPROD_NM AS �з���,
            COUNT(*) AS "��ǰ�� ��"
    FROM PROD A, LPROD B
    WHERE A.PROD_LGU=B.LPROD_GU 
        AND LOWER(A.PROD_LGU)='p202' --A.PROD_LGU�ȿ� �ִ� �빮�� P202�� �ҹ��ڷ� �ٲ㼭  p202�� ���� �� 
    GROUP BY B.LPROD_NM;
    
    
    
    ��뿹)
    SELECT EMPLOYEE_ID AS �����ȣ,
            EMP_NAME AS �����,
            LOWER(EMP_NAME), -- �̸��� �ҹ��ڷ� ����
            UPPER(EMP_NAME), -- �̸��� �빮�ڷ� ����
            INITCAP(LOWER(EMP_NAME)) --�ҹ��ڷ� ���� �� �ܾ��� ù���ڸ� �빮�ڷ� ����
    FROM HR.EMPLOYEES;
    
    
    SELECT LOWER(EMAIL)||'@gmail.com' AS �̸����ּ�
    FROM HR.EMPLOYEES;
    
    
------------------------------------------------------------------------------------------------
     
��뿹)
SELECT LPAD('������ �߱�', 20, '*'),
        LPAD ('������ �߱�', 20),
        RPAD ('������ �߱�', 20, '*'),
        RPAD ('������ �߱�', 20)
FROM DUAL;
    
    

��뿹) ȸ�����̺��� ���ϸ����� ���� ȸ�� 3����  2020�� 4-6�� ������ ������ ��ȸ�Ͻÿ�. ��ȸ�� �÷��� ȸ����ȣ, ȸ����, ���ϸ���, ���űݾ��հ��̴�. 

SELECT  A.MEM_ID AS ȸ����ȣ,
        A.MEM_NAME AS ȸ����, 
        A.MEM_MILEAGE AS ���ϸ���, 
        F.FSUM AS ���űݾ��հ�
FROM MEMBER A, 
    (SELECT E.CART_MEMBER AS CMID,
        SUM(E.CART_QTY*D.PROD_PRICE) AS FSUM
        FROM (SELECT C.MEM_ID AS DMID
                FROM (SELECT MEM_ID, MEM_MILEAGE
                        FROM MEMBER
                        ORDER BY 2 DESC) C
               WHERE ROWNUM<=3) B, PROD D, CART E
     WHERE B.DMID=E.CART_MEMBER
        AND D.PROD_ID = E.CART_PROD
        AND SUBSTR(E.CART_NO, 1, 6) BETWEEN '202004' AND '202006'
    GROUP BY E.CART_MEMBER) F
    WHERE F.CMID=A.MEM_ID;
    
    
DECLARE
    CURSOR CUR_MILE IS 
        SELECT C.MEM_ID AS DMID,
               C.MEM_MILEAGE AS DMILE,
               C.MEM_NAME AS DNAME
           FROM (SELECT MEM_ID, MEM_MILEAGE, MEM_NAME
                   FROM MEMBER
                   ORDER BY 2 DESC) C
           WHERE ROWNUM<=3;  
     V_SUM NUMBER :=0;       
     V_RES VARCHAR2(100);
BEGIN 
    FOR REC IN CUR_MILE LOOP
        SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM
            FROM CART A, PROD B
            WHERE A.CART_MEMBER=REC.DMID
                AND SUBSTR(A.CART_NO,1,6) BETWEEN '202004' AND '202006'
                AND A.CART_PROD=B.PROD_ID;
                
        V_RES:=REC.DMID||'   '||REC.DNAME||'   '||REC.DMILE||LPAD(V_SUM,12);
        DBMS_OUTPUT.PUT_LINE(V_RES);
    END LOOP;
END;
        

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    