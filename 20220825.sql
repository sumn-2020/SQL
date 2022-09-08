사용예) 사원테이블에서 영업실적이 NULL이 아닌 사원을 조회하시오.
      Alias는 사원번호, 사원명, 영업실적, 부서코드 
      
      SELECT EMPLOYEE_ID AS 사원번호, 
             EMP_NAME AS 사원명, 
             COMMISSION_PCT AS 영업실적, 
             DEPARTMENT_ID AS 부서코드
      FROM HR.EMPLOYEES
      WHERE COMMISSION_PCT IS NOT NULL;
      --WHERE COMMISSION_PCT != NULL;
      
      
--------------------------------------------------------------




** 상품테이블에서 분류코드가 'P301'을 제외한 모든 상품의 마일리지 해당 상품의 
  판매가의 0.5%로 변경하시오. 
  UPDATE 테이블명 SET 컬럼명  --대상이 되어지는 테이블 명
  
  UPDATE PROD
     SET PROD_MILEAGE = ROUND(PROD_PRICE*0.0005) --판매가(PROD_PRICE)의 0.5%(*100)
  WHERE PROD_LGU <> 'P301'; --분류코드가 'P301'을 제외한('P301'와 같지 않은)
  COMMIT;
  
  사용예) 상품테이블에서 상품의 마일리지가 NULL인 상품은 '마일리지가 제공되지 않는 상품' 
         이라는 메시지를 마일리지 출력컬럼에 출력하시오
         Alias는 상품번호, 상품명, 마일리지


SELECT PROD_ID AS 상품번호, 
       PROD_NAME AS 상품명, 
       NVL(TO_CHAR(PROD_MILEAGE),'마일리지가 제공되지 않는 상품')  AS 마일리지 -- PROD_MILEAGE가 NULL이 아니면 PROD_MILEAGE가 참이면 '마일리지가 제공되지 않는 상품' 
        --TO_CHAR :  숫자를 문자로 변경 / 마일리지가 제공되지 않는상품이라는 문자열과 마일리지의 숫자를 서로 비교하면 오류. 둘중하나를 바꿔서 동일한 타입으로 변경해줘야됨 
FROM PROD;

SELECT PROD_ID AS 상품번호, 
       PROD_NAME AS 상품명, 
       NVL(LPAD(TO_CHAR(PROD_MILEAGE), 5),'마일리지가 제공되지 않는 상품')  AS 마일리지 
FROM PROD;


사용예) 2020년 6월 모든 제품별 판매집계를 조회하시오. 
      SELECT A.PROD_ID AS 제품코드, 
             A.PROD_NAME AS 제품명, 
             COUNT(B.CART_PROD) AS 판매횟수, 
             NVL(SUM(B.CART_QTY),0) AS 판매수량합계, 
             NVL(SUM(B.CART_QTY*A.PROD_PRICE),0) AS 판매금액합계
      FROM PROD A
      LEFT OUTER JOIN CART B ON(A.PROD_ID=B.CART_PROD AND  --CART B 이 PROD보다 내용물이 많으면 LEFT, CART B이 PROD보다 내용물이 적으면 RIGHT, 
            B.CART_NO LIKE '202006%')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;



COMMIT;


----------------------------------------
  UPDATE PROD
     SET PROD_MILEAGE = ROUND(PROD_PRICE*0.0005) 

 COMMIT;





** 2020년 4월 판매자료를 이용하여 모든 구매회원들의 마일리지를 변경하시오.

(1. 2020년 4월 판매자료를 이용한 회원별 마일리지 합계)
SELECT A.CART_MEMBER, 
       SUM(A.CART_QTY*B.PROD_PRICE),
       SUM(A.CART_QTY*B.PROD_MILEAGE)
FROM CART A, PROD B
WHERE A.CART_PROD = B.PROD_ID
AND A.CART_NO LIKE '202004%' 
GROUP BY A.CART_MEMBER;


(2. 회원테이블의 마일리지 갱신) 
UPDATE MEMBER TA
   SET TA.MEM_MILEAGE = TA.MEM_MILEAGE + 
                        NVL((SELECT TB.MSUM -- NULL 값이 주어지면 0으로 출력되도록 
                           FROM (SELECT A.CART_MEMBER AS MID, 
                                        SUM(A.CART_QTY*B.PROD_MILEAGE) AS MSUM
                                 FROM CART A, PROD B
                                 WHERE A.CART_PROD = B.PROD_ID
                                   AND A.CART_NO LIKE '202004%' 
                                 GROUP BY A.CART_MEMBER) TB
                           WHERE TB.MID = TA.MEM_ID),0);

ROLLBACK;


사용예) 2020년 4월 구매회원들에게 특별 마일리지 300포인트를 지급하시오.

ROLLBACK;
UPDATE MEMBER 
SET MEM_MILEAGE = MEM_MILEAGE + 300
WHERE MEM_ID IN (SELECT DISTINCT CART_MEMBER
                   FROM CART
                  WHERE CART_NO LIKE '202004%');
















--[ 검토용 ]

CREATE OR REPLACE VIEW V_MEM_MILEAGE
AS
  SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
    FROM MEMBER
  WITH READ ONLY;
  
  
DELETE FROM MEMBER;
    
SELECT  * FROM V_MEM_MILEAGE;











UPDATE MEMBER SET MEM_MILEAGE=1000 WHERE MEM_ID='a001';
UPDATE MEMBER SET MEM_MILEAGE=2300 WHERE MEM_ID='b001';
UPDATE MEMBER SET MEM_MILEAGE=3500 WHERE MEM_ID='c001';
UPDATE MEMBER SET MEM_MILEAGE=1700 WHERE MEM_ID='d001';
UPDATE MEMBER SET MEM_MILEAGE=6500 WHERE MEM_ID='e001';
UPDATE MEMBER SET MEM_MILEAGE=2700 WHERE MEM_ID='f001';
UPDATE MEMBER SET MEM_MILEAGE=800 WHERE MEM_ID='g001';
UPDATE MEMBER SET MEM_MILEAGE=1500 WHERE MEM_ID='h001';
UPDATE MEMBER SET MEM_MILEAGE=900 WHERE MEM_ID='i001';
UPDATE MEMBER SET MEM_MILEAGE=1100 WHERE MEM_ID='j001';
UPDATE MEMBER SET MEM_MILEAGE=3700 WHERE MEM_ID='k001';
UPDATE MEMBER SET MEM_MILEAGE=5300 WHERE MEM_ID='l001';
UPDATE MEMBER SET MEM_MILEAGE=1300 WHERE MEM_ID='m001';
UPDATE MEMBER SET MEM_MILEAGE=2700 WHERE MEM_ID='n001';
UPDATE MEMBER SET MEM_MILEAGE=2600 WHERE MEM_ID='o001';
UPDATE MEMBER SET MEM_MILEAGE=2200 WHERE MEM_ID='p001';
UPDATE MEMBER SET MEM_MILEAGE=1500 WHERE MEM_ID='q001';
UPDATE MEMBER SET MEM_MILEAGE=700 WHERE MEM_ID='r001';
UPDATE MEMBER SET MEM_MILEAGE=3200 WHERE MEM_ID='s001';
UPDATE MEMBER SET MEM_MILEAGE=2200 WHERE MEM_ID='t001';
UPDATE MEMBER SET MEM_MILEAGE=2700 WHERE MEM_ID='u001';
UPDATE MEMBER SET MEM_MILEAGE=4300 WHERE MEM_ID='v001';
UPDATE MEMBER SET MEM_MILEAGE=2700 WHERE MEM_ID='w001';
UPDATE MEMBER SET MEM_MILEAGE=8700 WHERE MEM_ID='x001';

COMMIT;







사용예) 상품테이블에서 상품의 색상을 출력하시오.  
       단, 색상값이 없으면 '색상없음'을 출력하시오.(NVL과 NVL2로 각각 구현)
       Alias는 상품번호, 상품명, 색상

        (NVL 사용)
        SELECT PROD_ID AS 상품번호, 
               PROD_NAME AS 상품명, 
               NVL(PROD_COLOR,'색상없음') AS 색상 --PROD_COLOR 값이 NULL이 아니면 본인 값, NULL이면 색상없음 출력
        FROM PROD;
        
        (NVL2 사용)
        SELECT PROD_ID AS 상품번호, 
               PROD_NAME AS 상품명, 
               NVL2(PROD_COLOR, PROD_COLOR,'색상없음') AS 색상 -- PROD_COLOR 값이 NULL이 아니면 PROD_COLOR, NULL이면 색상없음 출력 
        FROM PROD;




















