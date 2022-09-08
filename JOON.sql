-- 상품테이블의 상품별 매입가격 평균 값
SELECT PROD_COST
FROM PROD
ORDER BY 1;

--DISTINCT : 중복제거
SELECT AVG(DISTINCT PROD_COST),  -- AS "중복된값은 제외",
       AVG(ALL PROD_COST) , -- AS "DEFAULT로써 모든 값을 포함",
       AVG(PROD_COST)  -- AS "매입가 평균"
FROM PROD;

--상품테이블의 상품분류별 매입가격 평균 값
-- BY : ~별 / GROUP:묶음
-- ASC : 오름차순(생략가능) / DESC: 내림차순 
SELECT PROD_LGU,
       ROUND(AVG(PROD_COST),2) PROD_COST -- 소수점 둘째자리까지 출력
FROM PROD
GROUP BY PROD_LGU
ORDER BY PROD_LGU;


--상품분류별 구매가격(=판매가격) 평균
SELECT PROD_LGU AS 상품분류,
       ROUND(AVG(PROD_SALE),2) AS 구매가격평균
FROM PROD
GROUP BY PROD_LGU
ORDER BY PROD_LGU;

SELECT PROD_LGU,
       PROD_BUYER,
       ROUND(AVG(PROD_COST),2) PROD_COST,
       SUM(PROD_COST),
       MAX(PROD_COST),
       MIN(PROD_COST),
       COUNT(PROD_COST)
FROM PROD
GROUP BY PROD_LGU, PROD_BUYER -- 대그룹 : PROD_LGU  / 소그룹 : PROD_BUYER
ORDER BY 1,2;


--P.282
--상품테이블(PROD)의
--총 판매가격(PROD_SALE) 
--평균 값을 구하시오 ?
--(Alias는 상품총판매가평균)
-- Alias 허용 bytes는 30bytes
SELECT ROUND(AVG(PROD_SALE), 2)  AS 상품총판매가평균
FROM PROD;

SELECT * FROM PROD;

--P.282
--상품테이블의 상품분류(PROD_LGU)별 
--판매가격(PROD_SALE) 평균 값을 구하시오 ?
--(Alias는 상품분류(PROD_LGU), 상품분류별판매가격평균)

SELECT  PROD_LGU AS 상품분류, 
        ROUND(AVG(PROD_SALE), 2) AS  상품분류별판매가평균
FROM PROD
GROUP BY PROD_LGU;


SELECT  PROD_LGU AS 상품분류, 
        TO_CHAR(ROUND(AVG(PROD_SALE), 2), 'L9,999,999.00') AS  상품분류별판매가평균  --#### 숫자를 더 써라 
FROM PROD
GROUP BY PROD_LGU;


--P.283
--거래처테이블(BUYER)의 
--담당자(BUYER_CHARGER)를 컬럼으로 하여 
--COUNT집계 하시오 ? 
--( Alias는 자료수(DISTINCT), 
--  자료수, 자료수(*) )
SELECT COUNT(DISTINCT BUYER_CHARGER) "자료수(DISTINCT)",
       COUNT(BUYER_CHARGER) 자료수,
       COUNT(*) "자료수(*)"
FROM BUYER;


-- 행의 수 : 카디널리티
-- 열의 수: 차수 
SELECT COUNT(*), -- * : 행으로 셈 
       COUNT(PROD_ID), 
       COUNT(PROD_NAME),
       COUNT(PROD_COLOR) -- NULL 제외 
FROM PROD;

-- p283
--회원테이블(MEMBER)의 취미(MEM_LIKE)별
--COUNT 집계하시오.
--회원의 취미별 인원수를 구해보자
--Alias는 취미, 자료수, 자료수(*)
SELECT MEM_LIKE 취미,
       COUNT(MEM_ID) 인원수, -- 인원수는 기본키로 세는게 제일 정확하다  다른 컬럼들은 NULL값이 있을수도있으니까 
       COUNT(*) "자료수(*)"
FROM MEMBER
GROUP BY MEM_LIKE
ORDER BY MEM_LIKE;



--P.284
--장바구니테이블의 회원별 최대구매수량
--을 검색하시오?
--ALIAS : 회원ID, 최대수량, 최소수량
SELECT  CART_MEMBER AS 회원ID, 
        MAX(CART_QTY) AS 최대수량, -- CART_QTY구매수량 
        MIN(CART_QTY) AS  최소수량
FROM CART
GROUP BY CART_MEMBER
ORDER BY CART_MEMBER;




-- 오늘이 2020년도7월11일이라 가정하고 
-- 장바구니테이블(CART)에 발생될 
-- 추가주문번호(CART_NO)를 검색 하시오 ? 
--( Alias는 최고치주문번호MAX(CART_NO), 
-- 추가주문번호 MAX(CART_NO)+1 )

SELECT MAX(CART_NO) AS 최고치주문번호,
       MAX(CART_NO)+1 AS 추가주문번호
FROM CART
WHERE SUBSTR(CART_NO, 1, 8) = '20200711'
GROUP BY CART_NO
ORDER BY CART_NO; 

SELECT *
FROM CART
WHERE SUBSTR(CART_NO, 1, 8) = '20200711'; 


SELECT *
FROM CART
WHERE SUBSTR(CART_NO, 1, 8) = '20200711'
  AND CART_NO LIKE '20200711%';
-- LIKE와 함께 쓰인 %, _를 와일드카드라고 함
-- % : 여러글자 / _ : 한 글자



--P.285
--상품테이블에서 상품분류, 거래처별로 
--최고판매가, 최소판매가, 자료수를 검색하시오?



SELECT MAX(PROD_SALE) 최고판매가, 
       MIN(PROD_SALE) 최소판매가, 
       COUNT(*) 자료수
FROM PROD
GROUP BY PROD_LGU, PROD_BUYER;


