* 상품테이블에서 분류코드가 'P301'인 상품의 판매가를 매입가와 같도록 변경하시오. 
UPDATE PROD
   SET PROD_PRICE = PROD_COST
WHERE PROD_LGU = 'P301';

사용예) 상품테이블에서 매입가격과 매출가격을 조회하고, 두 가격이 같은 제품을 찾아 비고난에 '판매중단예정상품'을 출력하고, 
       두 가격이 같지 않은 상품은 매출이익을 비고난에 출력하시오.
       Alias는 상품번호, 상품명, 매입가, 매출가, 비고
       
SELECT PROD_ID AS 상품번호, 
       PROD_NAME AS 상품명, 
       PROD_COST AS 매입가, 
       PROD_PRICE AS 매출가, 
       NVL2(NULLIF(PROD_PRICE,PROD_COST), TO_CHAR((PROD_PRICE-PROD_COST), '9,999,999'), '판매중단예정상품') AS 비고 --PROD_PRICE와PROD_COST를 비교하고, 참이면 매출이익(판매겨격 - 매입가격) 거짓이면  '판매중단예정상품', )출력 
FROM PROD;


-----------------------------------------------------------------------------


사용예) 2020년 1월 모든 제품별 매입수량집계를 조회하시오.
    
    SELECT B.PROD_ID AS 제품코드, 
           B.PROD_NAME AS 제품명, 
           SUM(A.BUY_QTY) AS 매입수량합계 
    FROM BUYPROD A, PROD B
    WHERE A.BUY_PROD(+)=B.PROD_ID --제품의 종류는 PROD가 많음
      AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
    GROUP BY B.PROD_ID, B.PROD_NAME
    ORDER BY 1;
    
    
    (ANSI조인)
    SELECT B.PROD_ID AS 제품코드, 
           B.PROD_NAME AS 제품명, 
           NVL(SUM(A.BUY_QTY), 0) AS 매입수량합계 
    FROM BUYPROD A
   -- RIGHT OUTER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID AND 
          --A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
    RIGHT OUTER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID) -- 74개 출력 
    WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131') -- 1월 35개는 제외시키고 39건만 출력 
    GROUP BY B.PROD_ID, B.PROD_NAME
    ORDER BY 1;
    
    
    (SUBQUERY)
    SELECT B.PROD_ID AS 제품코드, 
           B.PROD_NAME AS 제품명, 
           A.BSUM AS 매입수량합계 
    FROM PROD B,
         (2020년 1월 제품별 매입수량 집계) -- 내부조인 A
    WHERE B.PROD_ID = A.제품코드(+)
    ORDER BY 1;
    
    (서브쿼리: 2020년 1월 제품별 매입수량 집계)
    SELECT BUY_PROD, 
           SUM(BUY_QTY) AS BSUM -- 매입수량합계(A.BSUM)를 불러다가 참조해서 사용함 
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE ('20200131')
    GROUP BY BUY_PROD
    
    (결합)
    SELECT B.PROD_ID AS 제품코드, 
           B.PROD_NAME AS 제품명, 
           A.BSUM AS 매입수량합계 
    FROM PROD B,
         (SELECT BUY_PROD, 
           SUM(BUY_QTY) AS BSUM -- 매입수량합계(A.BSUM)를 불러다가 참조해서 사용함 
          FROM BUYPROD
          WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE ('20200131')
          GROUP BY BUY_PROD ) A
    WHERE B.PROD_ID = A.BUY_PROD(+)
    ORDER BY 1;
    





사용예) 2020년 4월 모든 제품별 매출수량집계를 조회하시오.
    Alias는 제품코드, 제품명, 매출수량합계
    
    (ANSI FORMAT)
    SELECT A.PROD_ID AS 제품코드, 
           A.PROD_NAME AS 제품명, 
           SUM(CART_QTY) AS 매출수량합계
    FROM PROD A  -- FROM절에 나오는 양이 더 많을 경우 LEFT 
    LEFT OUTER JOIN CART B ON(B.CART_PROD=A.PROD_ID AND B.CART_NO LIKE '202004%')
    GROUP BY A.PROD_ID, A.PROD_NAME
    ORDER BY 1;
    
          
    
    

사용예) 2020년 6월 모든 제품별 매입/매출수량집계를 조회하시오.
    Alias 제품코드, 제품명, 매입수량, 매출수량 

SELECT A.PROD_ID AS 제품코드, 
       A.PROD_NAME AS 제품명, 
       SUM(B.BUY_QTY) AS 매입수량, 
       SUM(C.CART_QTY) AS 매출수량 
FROM PROD A 
LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.BUY_PROD AND 
     B.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))
LEFT OUTER JOIN CART C ON(C.CART_PROD = A.PROD_ID AND C.CART_NO LIKE '202006%')
GROUP BY A.PROD_ID,A.PROD_NAME 
ORDER BY 1;





------------------------
사용예) 사원테이블에서 사원들의 평균급여보다 많은 급여를 받는 사원을 조회하시오. 
Alias는 사원번호, 사원명, 직책코드, 급여 

(메인쿼리: 사원테이블에서 사원들의 사원번호, 사원명, 직책코드, 급여조회)
SELECT 사원번호, 사원명, 직책코드, 급여조회
FROM HR.EMPLOYEES
WHERE SALARY > (평균급여)

(서브쿼리: 평균급여)
SELECT AVG(SALARY)
FROM HR.EMPLOYEES

(결합 - 중첩서브쿼리: WHERE절에 사용됐기 때문 )

SELECT EMPLOYEE_ID AS 사원번호, 
       EMP_NAME AS 사원명, 
       JOB_ID AS 직책코드, 
       SALARY AS 급여
FROM HR.EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                FROM HR.EMPLOYEES)
ORDER BY 4 DESC; -- 급여가 많은 사람부터 적은 사람 순으로 출력 



(IN-LINE)
SELECT A.EMPLOYEE_ID AS 사원번호, 
       A.EMP_NAME AS 사원명, 
       A.JOB_ID AS 직책코드, 
       A.SALARY AS 급여
FROM HR.EMPLOYEES A, (SELECT AVG(SALARY) AS SAL
                      FROM HR.EMPLOYEES) B
WHERE A.SALARY > B.SAL
ORDER BY 4 DESC; 






사용예) 2017년 이후에 입사한 사원이 존재하는 부서를 조회하시오. 
      Alias는 부서번호, 부서명, 관리사원번호 
      
(메인쿼리: 부서의 부서번호, 부서명, 관리사원번호 출력)
    SELECT DISTINCT A.DEPARTMENT_ID AS 부서번호,  --부서번호 : EMPLOYEES, DEPARTMENTS 둘중 많은쪽거 쓰면됨 
           B.DEPARTMENT_NAME AS 부서명, 
           A.MANAGER_ID AS 관리사원번호 
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID  -- 부서명 꺼내올려고 조인시킴
      AND B.DEPARTMENT_ID IN(서브쿼리)
      
      
      
(서브쿼리: 2017년 이후에 입사한 사원이 존재하는 부서번호)
SELECT DEPARTMENT_ID
FROM HR.EMPLOYEES
WHERE HIRE_DATE>TO_DATE('20161231')



(결합- 방법1 : 다중행서브쿼리)
    SELECT DISTINCT A.DEPARTMENT_ID AS 부서번호, 
           B.DEPARTMENT_NAME AS 부서명 
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID  
      AND B.DEPARTMENT_ID IN(SELECT  DEPARTMENT_ID
                            FROM HR.EMPLOYEES
                            WHERE HIRE_DATE>TO_DATE('20161231'))
     ORDER BY 1;


(결합- 방법2 : 관련성 있는 서브쿼리 )
SELECT DISTINCT A.DEPARTMENT_ID AS 부서번호, 
           B.DEPARTMENT_NAME AS 부서명, 
           A.MANAGER_ID AS 관리사원번호 
    FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID  
      AND EXISTS(SELECT 1
                   FROM HR.EMPLOYEES C
                   WHERE HIRE_DATE>TO_DATE('20161231')
                   AND C.EMPLOYEE_ID = A.EMPLOYEE_ID); -- 독립실행 불가 : A.EMPLOYEE_ID를 참조하지 못하기 때문에 이 서브쿼리만 따로 빼서 실행해도 출력안됨



---------------------------------------
      
사용예) 상품테이블에서 상품의 평균판매가보다 판매가가 더 높은 상품의 상품번호, 상품명, 분류명, 판매가를 조회하시오.



(결합)
SELECT A.PROD_ID AS 상품번호, 
       A.PROD_NAME AS 상품명, 
       B.LPROD_NM AS 분류명,
       A.PROD_PRICE AS 판매가
FROM PROD A, LPROD B
WHERE A.PROD_LGU = B.LPROD_GU  
  AND A.PROD_PRICE > (SELECT AVG(PROD_PRICE)
                      FROM PROD);




---------------------------------------------------

사용예) 회원테이블에서 2000년 이전 출생한 어떤 회원의 마일리지보다 더 많은 마일리지를 보유한 회원의 
       회원번호, 회원명, 주민번호, 마일리지를 조회
       
       
  SELECT MEM_ID AS 회원번호,  
         MEM_NAME AS 회원명, 
         MEM_REGNO1 ||'-'|| MEM_REGNO2 AS 주민번호, 
         MEM_MILEAGE AS 마일리지
  FROM MEMBER 
  --WHERE MEM_MILEAGE >ALL(2000년 이전 출생한 어떤 회원의 마일리지) : 2000년 이전 출생한 어떤 회원의 마일리지보다 더 많은 회원의 마일리지
  WHERE MEM_MILEAGE >ALL(SELECT MEM_MILEAGE 
                         FROM MEMBER
                         WHERE SUBSTR(MEM_REGNO2, 1,1) IN('1', '2'));
  

--------------------------------------------------------------

사용예) 장바구니테이블에서 2020년 5월 회원별 최고 구매금액을 기록한 회원을 조회하시오.
       Alias는 회원번호, 회원명, 구매금액합계
       
(서브쿼리: 2020년 5월 회원별 구매금액 합계를 내림차순으로 정렬)
SELECT A.CART_MEMBER AS CID, -- 회원번호 
       SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM --구매금액합계
FROM CART A, PROD B
WHERE A.CART_PROD=B.PROD_ID
  AND A.CART_NO LIKE '202005%' --2020년 5월달에 발생된 
GROUP BY A.CART_MEMBER
ORDER BY  2 DESC; -- 구매금액 기준으로 내림차순 


(메인쿼리: 서브쿼리의 결과 중 맨 첫줄에 해당하는 자료 출력)
SELECT TA.CID AS 회원번호, --MEM_ID안에 있는 회원번호나 TA속에 들어있는 회원번호 둘중 하나 아무거나 쓰면됨
       M.MEM_NAME AS 회원명, 
       TA.CSUM AS 구매금액합계
FROM MEMBER M, (SELECT A.CART_MEMBER AS CID,
                       SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                FROM CART A, PROD B
                WHERE A.CART_PROD=B.PROD_ID
                  AND A.CART_NO LIKE '202005%' 
                GROUP BY A.CART_MEMBER
                ORDER BY  2 DESC) TA 
WHERE M.MEM_ID=TA.CID 
  AND ROWNUM <=5; --5사람 출력 (*ROWNUM = 1: 한사람출력)



(WITH 절 사용 : 서브쿼리 없이 WITH사용할 수도 있음)
-- 괄호속에 들어있는 것들의 결과값을 A1에 저장 
WITH A1 AS (SELECT A.CART_MEMBER AS CID, 
                   SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
            FROM CART A, PROD B
            WHERE A.CART_PROD=B.PROD_ID
              AND A.CART_NO LIKE '202005%' 
            GROUP BY A.CART_MEMBER
            ORDER BY  2 DESC)
SELECT B. MEM_ID, B.MEM_NAME, A1.CSUM
  FROM MEMBER B, A1
 WHERE B.MEM_ID=A1.CID -- 조인연결
   AND ROWNUM=1;







  
  
  
  
  
  
  
       
       
      
      
      
      
      
      
      
      







