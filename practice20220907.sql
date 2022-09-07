사용예) 상품의 분류코드가 'P202'에 속한 분류명과 상품의 수를 출력하시오. 
SELECT B.LPROD_NM AS 분류명,
       COUNT(*) AS "상품의 수"
FROM PROD A, LPROD B
WHERE B.LPROD_GU = A.PROD_LGU
  AND B.LPROD_GU = 'P202'
GROUP BY B.LPROD_NM;

SELECT LTRIM('APPLE PERSON', 'PPLE')
FROM DUAL;

SELECT LTRIM('APPLE PERSON', 'AP')
FROM DUAL; 
    
    
사용예) 직무테이블(JOBS)에서 직무명(JOB_TITLE) 'Accounting Manager'인 직무를 조회하시오.
SELECT JOB_TITLE AS 직무명,
       LENGTHB(JOB_TITLE) AS "직무명의 길이",
       MIN_SALARY AS 최저급여,
       MAX_SALARY AS 최고급여
FROM HR.JOBS
WHERE TRIM(JOB_TITLE) = 'Accounting Manager';


사용예) JOBS테이블의 직무명의 데이터 타입을 VARCHAR2(40)으로 변경하시오.
UPDATE HR.JOBS
    SET JOB_TITLE=TRIM(JOB_TITLE);


사용예) 회원테이블의 주민번호 필드(MEM_REGNO1, MEMGEGNO2)를 이용하여 회원들의 나이를 구하고, 
회원번호, 회원명, 주민번호, 나이를 출력하시오.

SELECT MEM_ID AS 회원번호, 
       MEM_NAME AS 회원명, 
       MEM_REGNO1 ||'-'|| MEM_REGNO2 AS 주민번호, 
       CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '2') THEN
            2022 - (TO_NUMBER(SUBSTR(MEM_REGNO1, 1,2)) + 1900) 
        ELSE 
            2022 - (TO_NUMBER(SUBSTR(MEM_REGNO1, 1, 2))+ 2000)
        END AS 나이
FROM MEMBER;


SELECT GREATEST ('KOREA', 1000, '홍길동'),
       LEAST('ABC', '홍길동', '200')
FROM DUAL;




사용예) 회원테이블에서 마일리지가 1000미만인 회원을 찾아 1000으로 변경 출력하시오.
Alias는 회원번호, 회원명, 원본마일리지, 변경된 마일리지



SELECT MEM_ID AS 회원번호, 
       MEM_NAME  AS 회원명, 
       MEM_MILEAGE AS 원본마일리지, 
       MEM_MILEAGE < 1000 AS 변경된 마일리지
FROM MEMBER;



사용예) 회원테이블에서 회원번호, 회원명, 마일리지, 순위를 조회하시오.
      순위는 마일리지가 많은 회원부터 부여하고 같은 마일리지면 같은 순위를 부여하시오.
SELECT MEM_ID AS 회원번호, 
       MEM_NAME AS 회원명, 
       MEM_MILEAGE AS 마일리지,
       RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS 순위
FROM MEMBER;
       
SELECT PROD_ID AS 상품번호,
       PROD_NAME AS 상품명,
       NVL(TO_CHAR(PROD_MILEAGE),'마일리지가 제공되지 않는 상품') AS 마일리지
FROM PROD;

SELECT PROD_ID AS 상품번호,
       PROD_NAME AS 상품명,
       NVL(LPAD(TO_CHAR(PROD_MILEAGE),5), '마일리지가 제공되지 않는 상품') AS 마일리지
FROM PROD;








