2022-0810-02)
4.LIKE 연산자

사용예) 회원테이블에서 거주지가 '대전'인 회원들을 조회하시오
        Alias는 회원번호, 회원명, 주소
        
        SELECT MEM_ID AS 회원번호, 
                MEM_NAME AS 회원명, 
                MEM_ADD1||' '||MEM_ADD2 AS 주소
        FROM MEMBER
        WHERE MEM_ADD1 LIKE  '대전%';
        
        
        
사용예) 장바구니테이블에서 2020년  6월에 판매된 상품을 조회하시오. 
    Alias는 상품번호 
    
    SELECT DISTINCT CART_PROD AS 상품번호
    FROM CART 
    WHERE CART_NO LIKE '202006%' -- 날짜가 202006으로 시작되는 컬럼 (202006% : 문자열)
    ORDER BY 1; 
    

    
사용예) 매입테이블에서 2020년  6월에 매입된 상품을 조회하시오. 
    Alias는 상품번호 
    
    
    
    SELECT DISTINCT BUY_PROD AS 상품번호
    FROM BUYPROD 
    WHERE BUY_DATE >= '20200601' AND BUY_DATE <= '20200630';
        
   -- WHERE BUY_DATE >= TO_DATE('20200601') AND BUY_DATE <=TO_DATE('20200630');
   -- BETWEEN BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'); -- BETWEEN(기간)
    



5) BETWEEN 연산자


사용예) 상품테이블에서 판매가격이 10만원~20만원사이의 상품을 조회하시오. 
    Alias 상품번호, 상품명, 판매가격
    
    SELECT  PROD_ID AS 상품번호, 
            PROD_NAME AS 상품명, 
            PROD_PRICE AS 판매가격
    FROM PROD
    WHERE PROD_PRICE BETWEEN 100000 AND 200000;
   
    
    (AND 연산자일경우)
    SELECT  PROD_ID AS 상품번호, 
            PROD_NAME AS 상품명, 
            PROD_PRICE AS 판매가격
    FROM PROD
    WHERE PROD_PRICE>=100000 AND PROD_PRICE<=200000
    ORDER BY 3 ASC;
    
    
    
    
사용예) 사원테이블에서 2005년~2007년 사이에 입사한 사원들을 조회하시오.
Alias는 사원번호, 사원명, 부서코드,직무코드, 입사일 
입사일이 빠른사람부터 늦은 사람순으로 정렬.

SELECT  EMPLOYEE_ID AS 사원번호, 
        FIRST_NAME||' '||LAST_NAME AS 사원명, 
        DEPARTMENT_ID AS 부서코드,
        JOB_ID AS 직무코드, 
        HIRE_DATE AS 입사일 
FROM HR.EMPLOYEES
WHERE HIRE_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20071231')
ORDER BY 5 ASC;


사용예) 상품테이블에서 상품의 분류코드가 'P100'번대와 'P300'번대의 상품들을 조회하시오. 
ALIAS는 상품번호, 상품명, 분류코드, 판매가격

SELECT  PROD_ID AS 상품번호, 
        PROD_NAME AS 상품명, 
        PROD_LGU AS 분류코드, 
        PROD_PRICE AS 판매가격
FROM PROD
WHERE PROD_LGU BETWEEN 'P100' AND 'P399';





















