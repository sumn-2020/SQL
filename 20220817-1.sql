2022-08-17) 함수 

1. 문자열함수
 1) CONCAT(c1, c2)
    - 주어진 두 문자열 c1과 c2를 결합하여 새로운 문자열을 반환 
    - 문자열 결합연산자 '||'와 같은 기능 
    
    
    
    사용예) 회원테이블에서 여성회원의 회원번호, 회원명, 주민번호, 직업을 출력하시오. 
            단, 주민번호는 'XXXXXX-XXXXXXX'형식으로 출력하시오.
    
    (문자열 결합연산자 '||' 사용)
    SELECT MEM_ID AS 회원번호, 
    MEM_NAME AS 회원명, 
    MEM_REGNO1 ||'-'|| MEM_REGNO2 AS 주민번호, 
    MEM_JOB AS 직업
    FROM MEMBER
    WHERE SUBSTR(MEM_REGNO2,1,1) IN('2', '4') --MEM_REGNO2컬럼에서 맨 첫번째 자리 첫번째 글자가 2또는 4일때
    
    
   (CONCAT 사용)
    SELECT MEM_ID AS 회원번호, 
    MEM_NAME AS 회원명, 
    CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) AS 주민번호, -- MEM_REGNO1와 -를 결합한 후, MEM_REGNO2 주민등록뒷번호를 다시 결합
    MEM_JOB AS 직업
    FROM MEMBER
    WHERE SUBSTR(MEM_REGNO2,1,1) IN('2', '4')
    
    
    사용예) 상품의 분류코드가 'P202'에 속한 분류명과 상품의 수를 출력하시오. 
    SELECT  B.LPROD_NM AS 분류명,
            COUNT(*) AS "상품의 수"
    FROM PROD A, LPROD B --테이블에 별칭 부여
    WHERE A.PROD_LGU=B.LPROD_GU  --A테이블에 있는 분류코드가 B테이블에 있는 분류코드와 같을때
        AND A.PROD_LGU='p202' 
    GROUP BY B.LPROD_NM;
    
    
    SELECT  B.LPROD_NM AS 분류명,
            COUNT(*) AS "상품의 수"
    FROM PROD A, LPROD B
    WHERE A.PROD_LGU=B.LPROD_GU 
        AND LOWER(A.PROD_LGU)='p202' --A.PROD_LGU안에 있는 대문자 P202를 소문자로 바꿔서  p202랑 같을 때 
    GROUP BY B.LPROD_NM;
    
    
    
    사용예)
    SELECT EMPLOYEE_ID AS 사원번호,
            EMP_NAME AS 사원명,
            LOWER(EMP_NAME), -- 이름을 소문자로 변경
            UPPER(EMP_NAME), -- 이름을 대문자로 변경
            INITCAP(LOWER(EMP_NAME)) --소문자로 변경 후 단어의 첫글자만 대문자로 변경
    FROM HR.EMPLOYEES;
    
    
    SELECT LOWER(EMAIL)||'@gmail.com' AS 이메일주소
    FROM HR.EMPLOYEES;
    
    
------------------------------------------------------------------------------------------------
     
사용예)
SELECT LPAD('대전시 중구', 20, '*'),
        LPAD ('대전시 중구', 20),
        RPAD ('대전시 중구', 20, '*'),
        RPAD ('대전시 중구', 20)
FROM DUAL;
    
    

사용예) 회원테이블에서 마일리지가 많은 회원 3명이  2020년 4-6월 구매한 정보를 조회하시오. 조회할 컬럼은 회원번호, 회원명, 마일리지, 구매금액합계이다. 

SELECT  A.MEM_ID AS 회원번호,
        A.MEM_NAME AS 회원명, 
        A.MEM_MILEAGE AS 마일리지, 
        F.FSUM AS 구매금액합계
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
        

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    