문제1) 사원테이블(HR.EMPLOYEES)에서 보너스를 계산하고 지급액을 결정하여 출력하시오.

보너스 = 본봉 * 영업실적의 30%
지급액 = 본봉 + 보너스
Alias는 사원번호, 사원명, 본봉, 영업실적, 보너스, 지급액
모든값은 정수부분만 출력


SELECT EMPLOYEE_ID AS 사원번호, 
       EMP_NAME AS 사원명, 
       SALARY AS 본봉,
       COMMISSION_PCT AS 영업실적, 
       NVL(SALARY * COMMISSION_PCT * 0.3, 0) AS 보너스, 
       SALARY + SALARY * (COMMISSION_PCT * 0.03) AS 지급액
  FROM HR.EMPLOYEES;
  
  
  
문제2) 상품테이블(PROD)에서 판매가격이 30만원 이상이고 적정재고가 5개 이상인
제품의 제품번호, 제품명, 매입가, 판매가를 조회하시오.

SELECT PROD_ID AS 제품번호, 
       PROD_NAME AS 제품명, 
       PROD_COST AS 매입가, 
       PROD_PRICE AS 판매가
       PROD_PROPERSTOCK AS 적정재고
FROM PROD
WHERE PROD_PRICE >= 300000 AND  PROD_PROPERSTOCK >= 5; 



문제3) 매입테이블(BUYPROD)에서 이고 매입수량이 10개 이상인 매입정보를 조회하시오.  
2020년 1월 (= 1월1일~31일까지)
Alias는 매입일, 매입상품, 매입수량, 매입금액

SELECT BUY_DATE AS 매입일, 
       BUY_PROD AS 매입상품, 
       BUY_QTY AS 매입수량, 
       BUY_QTY * BUY_COST AS 매입금액
FROM BUYPROD
WHERE BUY_QTY >= 10
  AND BUY_DATE>=TO_DATE('20200101') AND BUY_DATE>=TO_DATE('20200131');
  
  
  
문제4) 회원테이블에서 연령대가 20대이거나 여성인 회원을 조회하시오.
Alias는 회원번호, 회원명, 주민번호, 마일리지

SELECT MEM_ID AS 회원번호, 
       MEM_NAME AS 회원명, 
       MEM_REGNO1 ||'-'|| MEM_REGNO2 AS 주민번호, 
       MEM_MILEAGE AS 마일리지
FROM MEMBER 
WHERE STR(MEM_REGNO2, 1, 1) IN ('2', '4');






  
  


