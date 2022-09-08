테이블 조



SELECT COUNT(*) AS "PROD 테이블 행의 수" FROM PROD;
SELECT COUNT(*) AS "CART 테이블 행의 수" FROM CART;
SELECT COUNT(*) AS "BUYPROD 테이블 행의 수" FROM BUYPROD;

SELECT COUNT(*) FROM PROD, CART, BUYPROD;


-- CART와 BUYPROD는 관계가 맺어져 있지 X
SELECT COUNT(*)
FROM PROD
CROSS JOIN CART
CROSS JOIN BUYPROD;

-- ANSI 
SELECT * 
FROM PROD
CROSS JOIN CART
CROSS JOIN BUYPROD;



사용예) 매입테이블에서 2020년 6월 매입상품정보를 조회하시오.
       Alias는 일자, 상품번호, 상품명, 수량, 금액

--(일반조인)
SELECT A.BUY_DATE AS 일자, 
       B.PROD_ID AS 상품번호, 
       B.PROD_NAME AS 상품명, 
       A.BUY_QTY AS 수량, 
       A.BUY_QTY * B.PROD_COST AS 금액 --수량*단가
FROM BUYPROD A, PROD B
WHERE A.BUY_PROD=B.PROD_ID --조인조건
AND A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') --일반조건
ORDER BY 1;


--(ANSI 조인)
SELECT A.BUY_DATE AS 일자, 
       B.PROD_ID AS 상품번호, 
       B.PROD_NAME AS 상품명, 
       A.BUY_QTY AS 수량, 
       A.BUY_QTY * B.PROD_COST AS 금액 --수량*단가
FROM BUYPROD A
--INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID AND
--      (A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')))
INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID)
WHERE A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
ORDER BY 1;







(사용예) 상품테이블에서 'P10202'거래처에서 납품하는 상품정보를 조회하시오.
        Alias는 상품코드, 상품명, 거래처명, 매입단가
        
    --일반조인
    SELECT A.PROD_ID AS 상품코드, 
           A.PROD_NAME AS 상품명, 
           A.PROD_BUYER AS 거래처코드,
           B.BUYER_NAME AS 거래처명, 
           A.PROD_COST AS 매입단가
    FROM PROD A, BUYER B
    WHERE A.PROD_BUYER = B.BUYER_ID -- 두 테이블 중 이름이 같은 거끼리 비교해서 연결 시켜줌 (이너조인)
        AND A.PROD_BUYER = 'P10202';
        
        
    --ANSI조인
    SELECT A.PROD_ID AS 상품코드, 
           A.PROD_NAME AS 상품명, 
           A.PROD_BUYER AS 거래처코드,
           B.BUYER_NAME AS 거래처명, 
           A.PROD_COST AS 매입단가
    FROM PROD A 
    INNER JOIN BUYER B ON(A.PROD_BUYER = B.BUYER_ID)
    WHERE A.PROD_BUYER = 'P10202';



   
사용예) 상품테이블에서 다음정보를 조회하시오.
      Alias는 상품코드 상품명, 분류명, 판매단가
      
      --일반조인
      SELECT A.PROD_ID AS 상품코드, 
             A.PROD_NAME AS 상품명, 
             B.LPROD_NM AS 분류명, 
             A.PROD_PRICE AS 판매단가
      FROM PROD A, LPROD B
      WHERE A.PROD_LGU = B.LPROD_GU; -- 두 테이블 중 이름이 같은 거끼리 비교해서 연결 시켜줌 (이너조인)
      
      --ANSI조인
      SELECT A.PROD_ID AS 상품코드, 
             A.PROD_NAME AS 상품명, 
             B.LPROD_NM AS 분류명, 
             A.PROD_PRICE AS 판매단가
      FROM LPROD B
      INNER JOIN PROD A ON (A.PROD_LGU = B.LPROD_GU);
      
      
      
      
사용예) 사원테이블에서 사원번호, 사원명, 부서명, 입사일을 출력하시오.

SELECT A.EMPLOYEE_ID AS 사원번호, 
       A.EMP_NAME  AS 사원명, 
       B.DEPARTMENT_NAME AS 부서명, 
       A.HIRE_DATE AS 입사일
FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE A.DEPARTMENT_ID  = B.DEPARTMENT_ID; 
-- 두 테이블 중 이름이 같은 거끼리 비교해서 연결 시켜줌 (이너조인)
-- 이너조인은 조인조건을 만족하는 것만 출력
-- NULL은 DEPARTMENT_ID부서코드에 없음  : KIMBERY GRANT는 NULL이기 때문에 출력X
-- KIMBERY GRANT도 나오게 하려면 OUTER JOIN 써야됨 


--ANSI조인
SELECT A.EMPLOYEE_ID AS 사원번호, 
       A.EMP_NAME  AS 사원명, 
       B.DEPARTMENT_NAME AS 부서명, 
       A.HIRE_DATE AS 입사일
FROM HR.EMPLOYEES A
INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID  = B.DEPARTMENT_ID);




사용예) 2020년 4월 회원별, 상품별 판매집계를 조회하시오.
       Alias는 회원번호, 회원명, 상품명, 구매수량합계, 구매금액합계 

SELECT A.CART_MEMBER AS 회원번호,
       B.MEM_NAME AS 회원명, 
       C.PROD_NAME AS 상품명, 
       SUM(A.CART_QTY) AS 구매수량합계, 
       SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액합계 -- 수량 * 가격
FROM CART A, MEMBER B, PROD C
WHERE A.CART_MEMBER = B.MEM_ID -- 조인조건: 회원명가져오기 위함 
  AND A.CART_PROD = C.PROD_ID --상품명, 판매단가가져오기 위한 조인조건
  AND A.CART_NO LIKE '202004%'
GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
ORDER BY 1;


--ANSI조인
SELECT A.CART_MEMBER AS 회원번호,
       B.MEM_NAME AS 회원명, 
       C.PROD_NAME AS 상품명, 
       SUM(A.CART_QTY) AS 구매수량합계, 
       SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액합계 -- 수량 * 가격
FROM CART A 
INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID) -- 여기서는 날짜에 관련된 정보 필요 없음
INNER JOIN PROD C ON(A.CART_PROD = C.PROD_ID)
WHERE A.CART_NO LIKE '202004%'
-- INNER JOIN PROD C ON(A.CART_PROD = C.PROD_ID  AND A.CART_NO LIKE '202004%')
GROUP BY A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
ORDER BY 1;

----------------------------------------------------------

사용예) 2020년 5월 거래처별(buyer) 매출집계(cart)를 조회하시오. 
    Alias는 거래처코드, 거래처명, 매출금액합계
 
--일반조인
SELECT  A.BUYER_ID AS 거래처코드, 
        A.BUYER_NAME AS 거래처명, 
        SUM(C.CART_QTY * B.PROD_PRICE) AS 매출금액합계   
FROM  BUYER A, PROD B, CART C 
WHERE C.CART_NO LIKE '202005%'  -- 일반조건
  AND A.BUYER_ID = B.PROD_BUYER --조인조건
  AND B.PROD_ID = C.CART_PROD   --조인조건
GROUP BY A.BUYER_ID, A.BUYER_NAME
ORDER BY 1; --거래처코드순으로 출력


 
 
--ANSI조인
SELECT  A.BUYER_ID AS 거래처코드, 
        A.BUYER_NAME AS 거래처명, 
        SUM(C.CART_QTY * B.PROD_PRICE) AS 매출금액합계   
FROM  BUYER A
INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
INNER JOIN CART C ON(B.PROD_ID = C.CART_PROD AND C.CART_NO LIKE '202005%')
GROUP BY A.BUYER_ID, A.BUYER_NAME
ORDER BY 1;
    
    
    
사용예) HR계정에서 미국이외의 국가에 위치한 부서정보를 조회하시오.
Alias는 부서번호, 부서명, 주소, 국가명
--일반조인
SELECT A.DEPARTMENT_ID AS 부서번호, 
       A.DEPARTMENT_NAME AS 부서명, 
       B.STREET_ADDRESS||', '||B.CITY||', '||B.STATE_PROVINCE AS 주소, 
       C.COUNTRY_NAME AS 국가명
FROM HR.DEPARTMENTS A,  HR.LOCATIONS B, HR.COUNTRIES C
WHERE A.LOCATION_ID = B.LOCATION_ID
  AND B.COUNTRY_ID  = C.COUNTRY_ID  
  AND B.COUNTRY_ID != 'US'
ORDER BY 1;
  
-- ANSI조인
SELECT A.DEPARTMENT_ID AS 부서번호, 
       A.DEPARTMENT_NAME AS 부서명, 
       B.STREET_ADDRESS||', '||B.CITY||', '||B.STATE_PROVINCE AS 주소, 
       C.COUNTRY_NAME AS 국가명
FROM HR.DEPARTMENTS A
INNER JOIN HR.LOCATIONS B ON(A.LOCATION_ID = B.LOCATION_ID)
INNER JOIN  HR.COUNTRIES C ON(B.COUNTRY_ID=C.COUNTRY_ID AND B.COUNTRY_ID NOT IN('US'));




















































