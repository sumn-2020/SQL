사용예)
    SELECT LTRIM('APPLE PERSIMMON BANANA', 'PPLE'), --PPLE는 일치하더라도 A라는 시작글자가 일치하지 않기 때문에 지울수 없음 
           LTRIM('   APPLE PERSIMMON BANANA'), -- 공백 삭제
           LTRIM('APPLE PERSIMMON BANANA', 'AP'),
           LTRIM('APTPLEAP PERSIMMON BANANA', 'AP'), -- AP가 일치하므로 AP 삭제 한 후 해당 문자에 A나 P가 연속해서 있으면 삭제(불연속적으로 있으면 삭제 불가능)
           LTRIM('APPALEAP APPERSIMMON APBANANA', 'AP'),  --AP다음에 P가 연속적으로 있으므로 삭제 
           LTRIM('PRAPALEAP APPERSIMMON APBANANA', 'AP')
    FROM DUAL;
    
    
    
------------------------------------------------------------


사용예) 직무테이블(JOBS)에서 직무명(JOB_TITLE) 'Accounting Manager'인 직무를 조회하시오. 

SELECT JOB_ID AS 직무코드, 
       JOB_TITLE AS 직무명, 
       LENGTHB(JOB_TITLE) AS "직무명의 길이", 
       MIN_SALARY AS 최저급여 , 
       MAX_SALARY AS 최고급여 
FROM HR.JOBS
WHERE TRIM(JOB_TITLE) = 'Accounting Manager';


사용예) JOBS테이블의 직무명의 데이터 타입을 VARCHAR2(40)으로 변경하시오.
UPDATE HR.JOBS
    SET JOB_TITLE=TRIM(JOB_TITLE);

COMMIT;


--------------------------------------
사용예)
SELECT SUBSTR('ABCDEFGHIJK', 3, 5), -- 3번째부터 다섯개의 글자를 자름 
       SUBSTR('ABCDEFGHIJK', 3),
       SUBSTR('ABCDEFGHIJK', -3, 5), -- 뒤에서 세번째부터 다섯글자  
       SUBSTR('ABCDEFGHIJK', 3, 15) -- 글자수보다 큰 수가 더 큰 값이 있으면 나머지 모든 수 전부 다를 뜻함 
FROM DUAL;
--------------------------------------------------------------------------------------
사용예) 회원테이블의 주민번호 필드(MEM_REGNO1, MEMGEGNO2)를 이용하여 회원들의 나이를 구하고, 
        회원번호, 회원명, 주민번호, 나이를 출력하시오.
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호, 
           CASE WHEN SUBSTR(MEM_REGNO2, 1,1) IN ('1','2') THEN  -- MEM_REGNO2 첫번째 글자에서 첫번째 글자만 추출했을때 그 글자가 1또는 2일때 
                2022-(TO_NUMBER(SUBSTR(MEM_REGNO1, 1, 2))+1900) -- 1990에서 첫번째 글자에서 두글자 자르기(SUBSTR) => 90 그리고 이걸 숫자로 변경하고(TO_NUMBER) 90+1900 = 1990 => 2022 - 1990 = 현재 나이
           ELSE 
                2022-(TO_NUMBER(SUBSTR(MEM_REGNO1, 1, 2))+2000)
           END AS 나이 
    FROM MEMBER;


사용예) 오늘이 2020년 4월 1일이라고 가정하여 'c001'회원이 상품을 구매 할 때 
        필요한 장바구니번호를 생성하시오. (MAX(), TO_CHAR()함수사용)
        
        SELECT '20200401' || TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO, 9))) + 1, '0000'))
        -- TO_NUMBER(SUBSTR(CART_NO, 9)): CART_NUM중 9번째 글자를 기준으로 전부 출력하고 문자열을 숫자로 변환 
        -- MAX(TO_NUMBER(SUBSTR(CART_NO, 9)) : 그 중에서 제일 큰 값 출력  3 
        -- TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO, 9)) : 문자열과 합치기 위해서 다시 문자열로 변환
        -- 2020040100003말고 2020040100004부터 저장되어야 되기 때문에 3+1
        -- ||: 20200401와TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO, 9))) + 1, '0000')합치기 
        -- TRIM : 불필요한 공백 제거 
        FROM CART
        WHERE SUBSTR(CART_NO, 1, 8) = '20200401';
        
        
        SELECT MAX(CART_NO) + 1 
        FROM CART
        WHERE SUBSTR(CART_NO, 1, 8) = '20200401';
    

사용예) 이번달 생일인 회원들을 조회하시오. 
    Alias는 회원번호, 회원명, 생년월일, 생일 
    단, 생일은 주민등록번호를 이용할 것 
    
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_REGNO1 AS 생년월일, 
           SUBSTR(MEM_REGNO1,3,2) AS 생일 
    FROM MEMBER
    WHERE SUBSTR(MEM_REGNO1,3,2) = '09';


-----------------------------------------------------------------------
사용예)
    SELECT REPLACE('APPLE   PERSIMMON BANANA', 'A', '에이'),  -- 모든 A를 에이로 변경
           REPLACE('APPLE   PERSIMMON BANANA', 'A'), -- 모든 A를 삭제
           REPLACE('APPLE   PERSIMMON BANANA', ' ', '-'), -- 모든 한칸 공백을 찾아서 -으로 변경 
           REPLACE('APPLE   PERSIMMON BANANA   ', ' ')    -- 모든 한칸공백 삭제
    FROM DUAL;









