
-- ~별 : 무조건 집계함수 사용해야됨 

사용예) 장바구니테이블에서 2020년 5월 제품별 판매집계를 조회하시오. 
       Alias는 제품코드, 판매건수, 판매수량, 금액
SELECT A.CART_PROD AS 제품코드, 
       COUNT(*) AS 판매건수, 
       SUM(A.CART_QTY) AS 판매수량, 
       SUM(A.CART_QTY*B.PROD_PRICE) AS 금액
FROM CART A, PROD B
WHERE A.CART_NO LIKE '202005%'
  AND A.CART_PROD = B.PROD_ID -- 조인
GROUP BY A.CART_PROD
ORDER BY  1;


사용예) 장바구니테이블에서 2020년 5월 회원별 판매집계를 조회하시오. 
       Alias는 회원번호(기준), 구매수량, 구매금액
       
SELECT A.CART_MEMBER AS 회원번호, 
       SUM(A.CART_QTY) AS 구매수량,
       SUM(A.CART_QTY * B.PROD_PRICE) AS 구매금액
FROM CART A, PROD B
WHERE A.CART_NO LIKE '202005%'
  AND A.CART_PROD = B.PROD_ID -- 조인
GROUP BY A.CART_MEMBER
ORDER BY 1;
       
       
사용예) 장바구니테이블에서 2020년 월별, 회원별 판매집계를 조회하시오. 
       Alias는 월, 회원번호, 구매수량, 구매금액
       

SELECT SUBSTR(A.CART_NO, 5, 2) AS 월, 
       A.CART_MEMBER AS 회원번호, 
       SUM(A.CART_QTY) AS 구매수량, 
       SUM(A.CART_QTY * B.PROD_PRICE) AS 구매금액
FROM CART A, PROD B
WHERE SUBSTR(A.CART_NO, 1,4) = '2020'
  AND A.CART_PROD = B.PROD_ID -- 조인
GROUP BY SUBSTR(A.CART_NO, 5, 2), A.CART_MEMBER
ORDER BY 1;



사용예) 장바구니테이블에서 2020년 5월 제품별 판매집계를 조회하되 판매금액이 100만원 이상인 자료만 조회하시오. 
       Alias는 제품코드, 판매수량, 금액
       
       SELECT A.CART_PROD AS 제품코드, 
              SUM(A.CART_QTY) AS 판매수량, 
              SUM(A.CART_QTY * B.PROD_PRICE) AS 금액
       FROM CART A, PROD B
       WHERE A.CART_NO LIKE '202005%'
         AND A.CART_PROD = B.PROD_ID
         --AND SUM(A.CART_QTY * B.PROD_PRICE) >= 1000000 -- WHERE 절에서는 집계함수 사용 불가능 HAVING 절 써야됨 
       GROUP BY A.CART_PROD
       HAVING SUM(A.CART_QTY * B.PROD_PRICE) >= 1000000 
       ORDER BY 1;
       
       
       
    

사용예) 2020년 상반기(1-6월) 매입액 기준 가장 많이 매입된 상품 5개를 조회하시오.
       Alias는 상품코드, 매입수량, 매입금액
       
      -- 제품별 매입액을 계산 
      -- BUY_DATE 
      -- BUY PROD 매입상품코드 
      -- BUY_QTY 매입상품수량
      -- BUY_COST 매입상품단가
       
       
    (1) 2020년 상반기(1-6월) 제품별 매입액을 계산하고 매입액이 많은 순으로 출력
    
    SELECT BUY_PROD AS 제품코드, 
           SUM(BUY_QTY * BUY_COST) AS 매입액
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
    GROUP BY BUY_PROD
    ORDER BY 2 DESC;
       
    (2) 가장 많이 매입된 상품 1개를 조회
    SELECT BUY_PROD AS 제품코드, 
           SUM(BUY_QTY) AS 매입수량합계,
           MAX(SUM(BUY_QTY * BUY_COST)) AS 매입액 -- 집계함수끼리는 중복 될 수 없음 
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
    GROUP BY BUY_PROD
    ORDER BY 3 DESC;
    
    
    
    
    
    문제] 사원테이블에서 부서별 평균급여를 조회하시오.
        SELECT DEPARTMENT_ID AS 부서코드,
               ROUND(AVG(SALARY)) AS 평균급여
        FROM HR.EMPLOYEES 
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
    
    
    문제] 사원테이블에서 부서별 가장 먼저 입사한 사원의 사원번호, 사원명, 부서번호, 입사일을 출력하시오. 
    SELECT EMPLOYEE_ID AS 사원번호, 
           EMP_NAME AS 사원명, 
           DEPARTMENT_ID  AS 부서번호, 
           MIN(HIRE_DATE) AS 입사일
    FROM HR.EMPLOYEES
    GROUP BY EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID;B -- 쓸모 없는데 SELECT 절에서 쓰였기 때문에 억지로 쓰인거임...이건 그룹으로 묶지 않은 것과 같음.. (주민번호다 다 다르듯이 사원번호가 같은 사람 없음)

    
    문제] 사원들의 평균급여보다 더 많이 받는 사원의 사원번호, 사원명, 부서번호, 급여를 출력
    (사원들의 평균급여)
    SELECT AVG(SALARY) 
    FROM HR.EMPLOYEES;

    SELECT A.EMPLOYEE_ID AS 사원번호, 
           A.EMP_NAME AS 사원명, 
           A.DEPARTMENT_ID AS 부서번호, 
           A.SALARY AS 급여
    FROM HR.EMPLOYEES A
    WHERE A.SALARY > (SELECT AVG(SALARY) --이런식으로 쓰면 WHERE 절에도 집계함수 올수 있음 
                       FROM HR.EMPLOYEES)
    ORDER BY 4 DESC;
  
  
    문제] 회원테이블에서 남녀회원별 마일리지 합계와 평균 마일리지를 조회하시오
         Alias는 구분, 마일리지합계, 평균마일리지 
         
         SELECT CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN('1','3') THEN 
                        '남성회원'
                    ELSE 
                        '여성회원' 
                END AS 구분,
                COUNT(*) AS 회원수,
                SUM(MEM_MILEAGE) AS 마일리지합계,
                ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
        FROM MEMBER
        GROUP BY CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN('1','3') THEN 
                        '남성회원'
                    ELSE 
                        '여성회원' 
                END;
        
        
        
         
         
         
       
       
  ----------------------------------------------------------
  ROLLUP과 CUBE
  - 다양한 집게결과를 얻기위해 사용 
  - 반드시 GROUP BY절에 사용되어야 함
  
  
  사용예) 2020년 4-7월 월별,회원별, 상품별 구매수량합계를 조회하시오. 
  
       (ROLLUP 사용전)
       SELECT SUBSTR(CART_NO, 5, 2) AS 월,
              CART_MEMBER AS 회원번호, 
              CART_PROD AS 상품코드,
              SUM(CART_QTY) AS  구매수량합계
        FROM CART
        WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
        GROUP BY SUBSTR(CART_NO, 5, 2), CART_MEMBER, CART_PROD
        ORDER BY 1;
              
       (ROLLUP 사용후)
       SELECT SUBSTR(CART_NO, 5, 2) AS 월,
              CART_MEMBER AS 회원번호, 
              CART_PROD AS 상품코드,
              SUM(CART_QTY) AS  구매수량합계
        FROM CART
        WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
        GROUP BY ROLLUP(SUBSTR(CART_NO, 5, 2), CART_MEMBER, CART_PROD)
        ORDER BY 1;
              
       
       
      
------------------------------------------------------------------------
      
 사용예) 상품테이블에서 상품의 분류별, 거래처별 상품의 수를 조회하시오. 
-- (GROUP BY절만 사용)
 SELECT PROD_LGU AS "상품의 분류", 
        PROD_BUYER AS "거래처 코드",
        COUNT(*) AS "상품의 수"
 FROM PROD
 GROUP BY PROD_LGU, PROD_BUYER
 ORDER BY 1;
      
      
--(ROLLUP 사용)
 SELECT PROD_LGU AS "상품의 분류", 
        PROD_BUYER AS "거래처 코드",
        COUNT(*) AS "상품의 수"
 FROM PROD
 GROUP BY ROLLUP(PROD_LGU, PROD_BUYER)
 ORDER BY 1;
      
      
--(부분 ROLLUP)
 SELECT PROD_LGU AS "상품의 분류", 
        PROD_BUYER AS "거래처 코드",
        COUNT(*) AS "상품의 수"
 FROM PROD
 GROUP BY PROD_LGU, ROLLUP(PROD_BUYER) -- PROD_LGU: 상수 // ROLLUP 왼쪽에 있으면 대분류, ROLLUP 오른쪽에 있으면 소분류
 ORDER BY 1;
      
      
      
-------------------------------------------      



       --(CUBE사용) 
       SELECT SUBSTR(CART_NO, 5, 2) AS 월,
              CART_MEMBER AS 회원번호, 
              CART_PROD AS 상품코드,
              SUM(CART_QTY) AS  구매수량합계
        FROM CART
        WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
        GROUP BY CUBE(SUBSTR(CART_NO, 5, 2), CART_MEMBER, CART_PROD)
        ORDER BY 1;  
      
        --(부분 CUBE사용)
        SELECT SUBSTR(CART_NO, 5, 2) AS 월,
              CART_MEMBER AS 회원번호, 
              CART_PROD AS 상품코드,
              SUM(CART_QTY) AS  구매수량합계
        FROM CART
        WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
        GROUP BY SUBSTR(CART_NO, 5, 2), CUBE(CART_MEMBER, CART_PROD)
        ORDER BY 1;  
        
        
        
        
        
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
       
       