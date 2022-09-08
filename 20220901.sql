2022-0901-01)
  ** 재고수불테이블 생성
  1)테이블명 : REMAIN
  2)컬럼명
  --------------------------------------------------------------------
    컬럼명         데이터타입              NULLABLE          PK, FK
  --------------------------------------------------------------------
   REMAIN_YEAR    CHAR(4)                                 PK            --연도
   PROD_ID        VARCHAR2(10)                            PK & FK       --상품코드
   REMAIN_J_00    NUMBER(5)             DEFAULT 0                       --기초재고
   REMAIN_I       NUMBER(5)                                             --입고수량
   REMAIN_O       NUMBER(5)                                             --출고수량
   REMAIN_J_99    NUMBER(5)             DEFAULT 0                       --기말(현)재고 : 현재재고
   REMAIN_DATE    DATE                  DEFAULT SYSDATE                 --수정일자           
  --------------------------------------------------------------------
  
CREATE TABLE REMAIN(
   REMAIN_YEAR    CHAR(4),                                 
   PROD_ID        VARCHAR2(10),                            
   REMAIN_J_00    NUMBER(5) DEFAULT 0,                    
   REMAIN_I       NUMBER(5),                                            
   REMAIN_O       NUMBER(5),                                            
   REMAIN_J_99    NUMBER(5) DEFAULT 0,                      
   REMAIN_DATE    DATE DEFAULT SYSDATE,  

   CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR,PROD_ID),
   CONSTRAINT fk_remain_prod FOREIGN KEY(PROD_ID) REFERENCES PROD(PROD_ID));
   
** 재고수불테이블(REMAIN)에 다음 자료를 입력하세요
  연도 : 2020년
  상품코드 : PROD 테이블의 모든 상품코드
  기초재고 : PROD 테이블의 적정재고량(PROD_PROPERSTOCK)
  입고/출고수량 : 0
  기말재고 : PROD 테이블의 적정재고량(PROD_PROPERSTOCK)
  갱신일자 : 2020년 1월 1일
  
1) INSERT문과 SUBQUERY
  . '( )' 사용하지 않음
  . VALUES 절을 생략하고 서브쿼리를 기술
  
  INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_I,REMAIN_O,REMAIN_J_99,REMAIN_DATE) 
    SELECT '2020',PROD_ID,PROD_PROPERSTOCK,0,0,PROD_PROPERSTOCK,TO_DATE('20200101')
      FROM PROD;
      
COMMIT;   
  SELECT * FROM REMAIN;
  
2) 서브쿼리를 이용한 UPDATE문
(사용형식)
   UPDATE 테이블명
      SET (컬럼명1[,컬럼명2,...])=(서브쿼리)   
   [WHERE 조건]  -- 어디를 업데이트할 건지
    . SET 절에서 연결시킬 컬럼이 하나 이상인 경우 보통 ( ) 안에 컬럼명을 기술하며
      서브쿼리의 SELECT 절의 컬럼들이 기술된 순서대로 1대1 대응되어 할당됨
    . SET 절에서 ()를 사용하지 않으면 변경시킬 컬럼마다 서브쿼리를 기술해야 함
    
    
    
    
    
    
    
사용예)2020년 1월 상품들의 매입집계를 이용하여 재고수불테이블을 갱신하시오.
      작업일자는 2020년 1월 31일이다.
      
      
 (메인쿼리 : 재고수불테이블 갱신)     
  UPDATE REMAIN A
     SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE)=
         (서브쿼리 : 2020년 1월 제품별 매입수량집계)
   WHERE A.PROD_ID IN(SELECT BUY_PROD
                        FROM BUYPROD
                       WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')) 
                       
                       
(서브쿼리 : 2020년 1월 제품별 매입수량집계)
SELECT BUY_PROD
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
                       
                       
                    
(결합)
--74개의 자료가 업데이트 됨 , 39개는 데이터가 있으니까 업데이트 잘됨 -> 업데이트 실행 
UPDATE REMAIN A 
   SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
       (SELECT A.REMAIN_I + B.BSUM, -- 0+22
               A.REMAIN_J_99 + B.BSUM, --33+22
               TO_DATE('20200131')
         FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM --서브쿼리의 결과중 일부분만 필요한 경우 FROM절에 기술하고, 바깥쪽 쿼리에 참조되는 형식으로 사용
                FROM BUYPROD
               WHERE BUY_DATE BETWEEN TO_DATE('20200101') 
                 AND TO_DATE('20200131')
               GROUP BY BUY_PROD
               ORDER BY 1) B    
        WHERE A.PROD_ID=B.BUY_PROD
       )
-- NULL값이 있는 자료들은 업데이트 하지 X
 WHERE A.PROD_ID IN(SELECT BUY_PROD
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'));
                     -- 이 안에서 참인 결과값만 A.PROD_ID에 담아서 반영


ROLLBACK;
COMMIT;




------------------------------------------------------------------------------------
사용예) 2020년 2-3월 상품들의 매입집계를 이용하여 재고수블테이블을 갱신하시오
작업일자는 2020년 3월 31일이다.

UPDATE REMAIN A
   SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
       (SELECT A.REMAIN_I + B.BSUM, 
               A.REMAIN_J_99 + B.BSUM, 
               TO_DATE('20200331')
         FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                FROM BUYPROD
               WHERE BUY_DATE BETWEEN TO_DATE('20200201') 
                 AND TO_DATE('20200331')
               GROUP BY BUY_PROD
               ORDER BY 1) B   
               
        WHERE A.PROD_ID=B.BUY_PROD
       )    
 WHERE A.PROD_ID IN(SELECT BUY_PROD
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200331'));
                     





사용예) 2020년 4-7월 매입매출집계를 이용하여 재고수불테이블을 갱신하시오
작업일자는 2020년 8월 1일이다. 


UPDATE 재고테이블 
SET (입고수량, 기말재고, 수정일자) =
    (입고수량+1월매입합계, 기말재고+1월매입합계, 작업일자) 
WHERE 상품코드 IN(1월에 매입된 상품코드) 


(매입)
UPDATE REMAIN A
   SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
   
       (SELECT A.REMAIN_I + B.BSUM,
               A.REMAIN_J_99 + B.BSUM,
               TO_DATE('20200801')
               
         FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                 FROM BUYPROD
                WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
                GROUP BY BUY_PROD) B
               
        WHERE A.PROD_ID=B.BUY_PROD)
          
  WHERE A.PROD_ID IN(SELECT BUY_PROD
                       FROM BUYPROD
                      WHERE BUY_DATE BETWEEN TO_DATE('20200401') 
                            AND TO_DATE('20200731'));
                   
   
  
  (매출)
  UPDATE REMAIN A
   SET (A.REMAIN_O, A.REMAIN_J_99,A.REMAIN_DATE)=
   
       (SELECT A.REMAIN_O + C.CSUM,
               A.REMAIN_J_99 - C.CSUM,
               TO_DATE('20200801')
               
         FROM (SELECT CART_PROD, SUM(CART_QTY) AS CSUM
                  FROM CART 
                WHERE SUBSTR(CART_NO, 1, 6) BETWEEN '202004' AND '2020070'
                GROUP BY CART_PROD ) C 
               
        WHERE A.PROD_ID=C.CART_PROD)
          
  WHERE A.PROD_ID IN(SELECT CART_PROD
                        FROM CART 
                       WHERE SUBSTR(CART_NO, 1, 6) BETWEEN '202004' AND '2020070');
   
  
  
  ---------------------------------------------------------------
사용예) 회원테이블에서 직업이 주부인 회원과 마일리지가 3000이상인 모든 회원들의 회원번호, 회원명, 직업, 마일리지를 조회하시오.
  SELECT MEM_ID AS 회원번호, 
         MEM_NAME AS 회원명, 
         MEM_JOB AS 직업, 
         MEM_MILEAGE AS 마일리지
    FROM MEMBER
   WHERE MEM_JOB ='주부'
UNION ALL 
  SELECT MEM_ID, 
         MEM_NAME, 
         MEM_JOB, 
         TO_NUMBER(MEM_REGNO1)
    FROM MEMBER
   WHERE MEM_MILEAGE>=3000;
   
   
   
   
사용예) 2020년 4, 5, 6, 7월 구매액이 가장 많은 회원들의 회원번호, 회원명, 구매금액합계를 조회하시오. 

--(WITH절을 사용한 경우)
WITH T1 AS 
     (SELECT '4월' AS MON, C.MEM_ID AS CID, C.MEM_NAME AS CNAME, D.TOT1 AS CTOT1 
        FROM (SELECT A.CART_MEMBER AS AMID, 
                     SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                FROM CART A, PROD B
               WHERE A.CART_NO LIKE '202004%'
                 AND A.CART_PROD = B.PROD_ID
                GROUP BY A.CART_MEMBER
              ORDER BY 2 DESC) D, MEMBER C
      WHERE C.MEM_ID = D.AMID
        AND ROWNUM = 1
    UNION ALL 
    SELECT '5월' AS MON , C.MEM_ID, C.MEM_NAME, D.TOT1 
        FROM (SELECT A.CART_MEMBER AS AMID, 
                     SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                FROM CART A, PROD B
               WHERE A.CART_NO LIKE '202005%'
                 AND A.CART_PROD = B.PROD_ID
                GROUP BY A.CART_MEMBER
              ORDER BY 2 DESC) D, MEMBER C
      WHERE C.MEM_ID = D.AMID
        AND ROWNUM = 1
       UNION ALL    
    SELECT '6월' AS MON, C.MEM_ID, C.MEM_NAME, D.TOT1 
        FROM (SELECT A.CART_MEMBER AS AMID, 
                     SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                FROM CART A, PROD B, MEMBER C
               WHERE A.CART_NO LIKE '202006%'
                 AND A.CART_PROD = B.PROD_ID
                GROUP BY A.CART_MEMBER
              ORDER BY 2 DESC) D, MEMBER C
      WHERE C.MEM_ID = D.AMID
        AND ROWNUM = 1 
    UNION ALL  
    SELECT '7월' AS MON, C.MEM_ID, C.MEM_NAME, D.TOT1 
        FROM (SELECT A.CART_MEMBER AS AMID, 
                     SUM(A.CART_QTY*B.PROD_PRICE) AS TOT1
                FROM CART A, PROD B, MEMBER C
               WHERE A.CART_NO LIKE '202007%'
                 AND A.CART_PROD = B.PROD_ID
                GROUP BY A.CART_MEMBER
              ORDER BY 2 DESC) D, MEMBER C
      WHERE C.MEM_ID = D.AMID
        AND ROWNUM = 1       
)
SELECT MON AS 월,
       CID AS 회원번호,
       CNAME AS 회원명,
       CTOT1 AS 구매금액
FROM T1;
  
  
  
사용예) 6월과 7월에 판매된 모든 상품을 중복하지 않고 출력하시오.
       Alias는 상품코드, 상품명
       
SELECT DISTINCT A.CART_PROD AS 상품코드,
       B.PROD_NAME AS 상품명
  FROM CART A, PROD B
 WHERE A.CART_PROD=B.PROD_ID
   AND A.CART_NO LIKE '202006%'
   
UNION --중복하지 않고

SELECT DISTINCT A.CART_PROD,
       B.PROD_NAME
  FROM CART A, PROD B
 WHERE A.CART_PROD=B.PROD_ID
   AND A.CART_NO LIKE '202007%'
ORDER BY 1; --제일 마지막에 적용 (전체결과에 적용되어 짐)
  
  
  
---------------------------------------------------------------

사용예) 2020년 매입상품 중 1월과 5월에 모두 매입된 상품의 상품코드, 상품명, 매입처명을 조회하시오

SELECT DISTINCT A.BUY_PROD AS 상품코드, 
       C.PROD_NAME AS 상품명, 
       B.BUYER_NAME AS 매입처명
  FROM BUYPROD A, BUYER B, PROD C
 WHERE A.BUY_PROD = C.PROD_ID
   AND C.PROD_BUYER = B.BUYER_ID
   AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')

INTERSECT

SELECT DISTINCT A.BUY_PROD AS 상품코드, 
       C.PROD_NAME AS 상품명, 
       B.BUYER_NAME AS 매입처명
  FROM BUYPROD A, BUYER B, PROD C
 WHERE A.BUY_PROD = C.PROD_ID
   AND C.PROD_BUYER = B.BUYER_ID
   AND A.BUY_DATE BETWEEN TO_DATE('20200501') AND TO_DATE('20200531')

ORDER BY 1;


----------------------------------------------------------------------------------

사용예) 1월 매입상품 중 5월 판매 수량기준 5위 안에 존재하는 상품정보를 조회하시오.


WITH T1 AS 

--(1월 매입상품)
(SELECT BUY_PROD
  FROM BUYPROD 
 WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')

INTERSECT

--(5월 판매 수량기준 1-5위 상품)
SELECT A.CART_PROD
  FROM (SELECT CART_PROD,
               SUM(CART_QTY)
          FROM CART
         WHERE CART_NO LIKE '202005%'
        GROUP BY CART_PROD
        ORDER BY 2 DESC) A
  WHERE  ROWNUM <=5) --ROWNUM : 5번까지만 나오게
  
  

SELECT BUY_PROD AS 상품코드, PROD_NAME AS 상품명
FROM T1,PROD
WHERE T1.BUY_PROD=PROD_ID;

-- 1월 매입상품, 5월 판매 수량기준 1-5위 상품 이걸 T1 테이블을 만들어서 넣고  
-- 맨 하단 SELECT 절에서 조회 



--------------------------------------------------------------------

4) MINUS

사용예) 2020년 매출테이블(CART)에서 5월과 6월 매출 중 5월에만 판매된 상품을 조회하시오.

(일반적인 방법)
SELECT DISTINCT A.CART_PROD AS CID, B.PROD_NAME AS CNAME
  FROM CART A, PROD B
 WHERE  A.CART_PROD = B.PROD_ID
   AND SUBSTR(A.CART_NO, 1, 6)='202005'

MINUS

SELECT DISTINCT A.CART_PROD, B.PROD_NAME
  FROM CART A, PROD B
 WHERE  A.CART_PROD = B.PROD_ID
   AND SUBSTR(A.CART_NO, 1, 6)='202006'


(WITH절 사용)
WITH T1 AS (

    SELECT DISTINCT CART_PROD AS CID
      FROM CART 
     WHERE SUBSTR(CART_NO, 1, 6)='202005'
    
    MINUS
    
    SELECT DISTINCT CART_PROD
      FROM CART
     WHERE SUBSTR(CART_NO, 1, 6)='202006'

)
SELECT A.CID AS 상품코드, 
       B.PROD_NAME AS 상품명 
  FROM  T1 A, PROD B
  WHERE A.CID=B.PROD_ID;

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
   UPDATE REMAIN A
   SET (A.REMAIN_I,A.REMAIN_O, A.REMAIN_J_99,A.REMAIN_DATE)=
   
       (SELECT A.REMAIN_I + B.BSUM,
               A.REMAIN_O + C.CSUM,
               A.REMAIN_J_99 + B.BSUM - C.CSUM,
               TO_DATE('20200801')
               
         FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                 FROM BUYPROD
                WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
                GROUP BY BUY_PROD) B,  -- 4-7월사이의 매입집계
               
              (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                FROM BUYPROD
               WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
               GROUP BY BUY_PROD ) C  -- 4-7월사이의 매출집계
               
        WHERE A.PROD_ID=B.BUY_PROD
          AND A.PROD_ID=C.CART_PROD)
          
  WHERE A.PROD_ID IN(SELECT BUY_PROD
                       FROM BUYPROD
                      WHERE BUY_DATE BETWEEN TO_DATE('20200401') 
                            AND TO_DATE('20200731')
                      UNION --합집합 : 공통되어지는 것은 
                      SELECT CART_PROD
                        FROM CART 
                       WHERE SUBSTR(CART_NO, 1, 6) BETWEEN '202004' AND '2020070');





   
  
   
(4-7월사이의 매입집계) B
SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
  FROM BUYPROD
WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
GROUP BY BUY_PROD
        
(4-7월사이의 매출집계) C
SELECT CART_PROD, SUM(CART_QTY) AS CSUM
  FROM CART 
WHERE SUBSTR(CART_NO, 1, 6) BETWEEN '202004' AND '2020070'
GROUP BY CART_PROD





----------------------------------------------
(사용형식)
DELETE FROM 테이블명
 WHERE 조건



사용예) 장바구니테이블에서 2020년 4월 'm001'회원의 구매자료 중 'p202000005' 제품의 구매내역을 삭제하시오. 

DELETE FROM CART A 
 WHERE EXISTS(SELECT 1
                FROM MEMBER B
               WHERE  B.MEM_ID='m001'
                 AND B.MEM_ID = A.CART_MEMBER)
   AND A.CART_NO LIKE '202004%'
   AND A.CART_PROD = 'P202000005';
   
   
ROLLBACK;
COMMIT;












