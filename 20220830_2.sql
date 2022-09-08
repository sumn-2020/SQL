외부조인



(일반 외부조인 형식)
SELECT 컬럼list
  FROM 테이블명1 [별칭1], 테이블명2 [별칭2],...
 WHERE 별칭1.컬럼명(+)=별칭2.컬럼명2 => 테이블명1이 자료가 부족한 테이블인 경우 
 
 
(ANSI 외부조인 사용형식)
 SELECT 컬럼list
   FROM 테이블명1 [별칭1]
 RIGHT|LEFT|FULL OUTER JOIN 테이블명2 [별칭2] ON(조인조건1 [AND 일반조건1])
                            :
 [WHERE 일반조건]
 
 

 -------------------------------------------------------
 
 사용예) 모든 분류에 속한 상품의 수를 출력하시오.
 SELECT A.PROD_LGU AS 분류코드, 
        B.LPROD_NM AS 상품명, 
        COUNT(*) AS "상품의 수"
   FROM PROD A, LPROD B
  WHERE A.PROD_LGU(+)=B.LPROD_GU -- LPROD가 많으니까 부족한 PROD한테 (+)외부조인 
  GROUP BY A.PROD_LGU, B.LPROD_NM
  ORDER BY 1;
   
 
 
 
 
 
 SELECT B.LPROD_GU AS 분류코드, 
        B.LPROD_NM AS 상품명, 
        COUNT(A.PROD_ID) AS "상품의 수"
   FROM PROD A, LPROD B
  WHERE A.PROD_LGU(+)=B.LPROD_GU 
  GROUP BY B.LPROD_GU, B.LPROD_NM
  ORDER BY 1;
 
 
 SELECT  B.LPROD_GU AS 분류코드, 
        B.LPROD_NM AS 상품명, 
        COUNT(A.PROD_ID) AS "상품의 수"
   FROM PROD A
   RIGHT OUTER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU)
  GROUP BY B.LPROD_GU, B.LPROD_NM
  ORDER BY 1;
 
 
 
 
 
 
 SELECT DISTINCT PROD_LGU
   FROM PROD 
 
 
 
 -------------------------------------
 
 
 사용예) 2020년 6월 모든 거래처별 매입집계를 조회하시오.
        Alias는 거래처코드, 거래처명, 매입금액합계
 
--일반외부조인       
SELECT A.BUYER_ID AS 거래처코드, 
       A.BUYER_NAME AS 거래처명, 
       SUM(B.BUY_QTY * C.PROD_COST) AS 매입금액합계 --거래처별(BUYER) 매입(BUYPROD)
FROM BUYER A, BUYPROD B, PROD C
WHERE B.BUY_PROD(+)= C.PROD_ID
  AND A.BUYER_ID=C.PROD_BUYER(+)
  AND BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
GROUP BY A.BUYER_ID, A.BUYER_NAME;


-- ANSI 외부조인
SELECT A.BUYER_ID AS 거래처코드, 
       A.BUYER_NAME AS 거래처명, 
       NVL(SUM(B.BUY_QTY * C.PROD_COST),0) AS 매입금액합계 
FROM BUYER A
LEFT OUTER JOIN PROD C ON(A.BUYER_ID=C.PROD_BUYER) --FROM절테이블보다 내용물이 더 많아서 LEFT 
LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD= C.PROD_ID AND BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')) --PROD 상품테이블코드보다 BUYPROD상품테이블 코드가 내용물이 더 많아서 LEFT 
GROUP BY A.BUYER_ID, A.BUYER_NAME
ORDER BY 1;


--서브쿼리를 이용하는 방법
SELECT A.BUYER_ID AS 거래처코드, 
       A.BUYER_NAME AS 거래처명, 
       NVL(TBL.BSUM, 0) AS 매입금액합계
FROM BUYER A,

     --(2020년 6월 거래처별 매입금액합계)
     (SELECT C.PROD_BUYER AS CID,
             SUM(B.BUY_QTY*C.PROD_COST) AS BSUM
        FROM BUYPROD B, PROD C
       WHERE B.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
         AND B.BUY_PROD=C.PROD_ID
       GROUP BY C.PROD_BUYER) TBL
       
WHERE A.BUYER_ID= TBL.CID(+)
ORDER BY 1;




사용예) 2020년 상반기 (1~6월) 모든 제품별 매입수량집계를 조회하시오.

사용예) 2020년 상반기 (1~6월) 모든 제품별 매출수량집계를 조회하시오.

사용예) 2020년 상반기 (1~6월) 모든 제품별 매입/매출수량집계를 조회하시오.






SELECT DISTINCT BUY_PROD
FROM BUYPROD
WHERE BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630');
 
 

 
 사용예) 2020년 상반기(1-6월) 모든 제품별 매입수량집계를 조회하시오.
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 