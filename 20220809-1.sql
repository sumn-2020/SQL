2022-0890-01 연산자
1. 관계(비교)연산자
- 자료의 대소관계를 비교하는 연산자로 결과는 참(true)와 거짓(false)로 반환
- >, <, >=, = !=, (<>)
- 표현식(CASE WHEN ~ THEN, DECODE)이나 WHERE 조건절에 사용

사용예)회원테이블(MEMBER)에서 모든 회원들의 회원번호, 회원명, 직업, 마일리지를 조회하되 마일리지가 많은 회원부터 조회하시오. 
SELECT MEM_ID AS 회원번호, 
       MEM_NAME AS 회원명, 
       MEM_JOB AS 직업,
       MEM_MILEAGE AS 마일리지
FROM MEMBER
-- ORDER BY MEM_MILEAGE DESC; --마일리지가 많은 사람부터 적은사람 순으로 조회
ORDER BY 4 DESC;


           
   사용예) 사원테이블(HR.EMPLOYEES)부서번호가 50번인 사원들을 조회하시오. -- hr계정에 들은 EMPLOYEES 테이블
   Alias는 사원번호, 사원명, 부서번호, 급여이다. 
   
   SELECT EMPLOYEE_ID AS 사원번호, 
           EMP_NAME AS 사원명, 
           DEPARTMENT_ID AS 부서번호, 
           SALARY AS 급여
        FROM HR.EMPLOYEES         -- 1) HR계정에 있는 EMPLOYEES테이블 가져옴
        WHERE DEPARTMENT_ID = 50; -- 2)EMPLOYEES테이블의 DEPARTMENT_ID가 50인 사람을 가져온다. 
                                  -- 3) DEPARTMENT_ID가 50인 사람들의 사원번호, 사원명, 부서번호, 급여정보를 가져온다. 
           
          
          
    사용예) 회원테이블(MEMBER)에서 직업이 주부인 회원들을 조회하시오.     -- 내 계정에 있는 회원테이블(MEMBER)
    Alias는 회원번호, 회원명, 직업, 마일리지이다.
    
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_JOB AS  직업, 
           MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_JOB = '주부';
    
   2. 산술연산자 
   
   사용예) 사원테이블(HR.EMPLOYEES)에서 보너스를 계산하고 지급액을 결정하여 출력하시오.
    보너스 = 본봉 * 영업실적의 30%
    지급액 = 본봉 + 보너스 
    Alias는 사원번호, 사원명, 본봉, 영업실적, 보너스, 지급액 
    모든값은 정수부분만 출력 
    
    SELECT EMPLOYEE_ID AS 사원번호, 
           FIRST_NAME||' '||LAST_NAME AS 사원명, 
           SALARY AS 본봉, 
           COMMISSION_PCT AS 영업실적, 
           NVL(ROUND(COMMISSION_PCT * SALARY * 0.3),0) AS 보너스, -- ROUND : 소수 첫째자리에서 반올림하여 정수로 나타내시오 /TRUNC : 소수 첫째자리는 무조건 버려라 
           SALARY + NVL(ROUND(COMMISSION_PCT * SALARY * 0.3),0) AS 지급액 
    FROM HR.EMPLOYEES;
    
    
    3. 논리연산자
    - 두 개이상의 관계식을 연결(AND, OR)하거나 반전(NOT)결과 반환
    - NOT, AND, OR
    ------------------------------
       입력           출력
    A      B      OR      AND
    ------------------------------
    0      0      0       0
    0      1      1       0
    1      0      1       0
    1      1      1       1
    
    
    
    사용예) 상품테이블(PROD)에서 판매가격이 30만원 이상이고 적정재고가 5개 이상인 
            제품의 제품번호, 제품명, 매입가, 판매가를 조회하시오. 
            
        SELECT PROD_ID AS 제품번호, 
                PROD_NAME AS 제품명, 
                PROD_COST AS 매입가, 
                PROD_PRICE AS 판매가,
                PROD_PROPERSTOCK AS 적정재고
       FROM PROD
       WHERE PROD_PRICE >= 300000 AND PROD_PROPERSTOCK >= 5
       ORDER BY 4; -- 저렴한거에서 비싼 순서로 출력 
            
    
    사용예) 매입테이블(BUYPROD)에서 이고 매입수량이 10개 이상인 매입정보를 조회하시오.  -- 2020년 1월 = 1월1일~31일까지
            Alias는 매입일, 매입상품, 매입수량, 매입금액
            
           SELECT  BUY_DATE AS 매입일,
                   BUY_PROD AS 매입상품,  
                   BUY_QTY AS 매입수량, 
                   BUY_QTY * BUY_COST AS 매입금액 -- 수량*단가
           FROM BUYPROD
           WHERE BUY_DATE>=TO_DATE('20200101') AND BUY_DATE>=TO_DATE('20200131') -- TO_DATE : DATE타입으로 변환해라
                AND BUY_QTY >= 10
            ORDER BY 1; -- 매입일자순으로 오름차순으로 정렬해라 
           
           -- 자바 : 'A' + 10 = A10 (CHAR(A) = 65 / 'A' = 그냥 A)
           -- 오라클 : 'A' + 10 = 오류
           -- 날짜와 문자열을 비교하면 날짜가 우선순위가 높아서 문자열이 날짜로 변환됨 : BUY_DATE >= '20200101'
            
    
    사용예) 회원테이블에서 연령대가 20대이거나 여성인 회원을 조회하시오.  -- 20대: 20~29살
           Alias는 회원번호, 회원명, 주민번호, 마일리지 
           
           
           SELECT MEM_ID AS 회원번호, 
                   MEM_NAME AS 회원명, 
                   MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호, 
                   TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1) AS 연령대,
                   MEM_MILEAGE AS 마일리지 
           FROM MEMBER
           WHERE  TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1) = 20
                OR SUBSTR(MEM_REGNO2,1,1) IN ('2', '4'); -- MEM_REGNO2에서 1번째 글자에서 한글자가 2또는 4안에  포함되어 지면 
           -- SYSDATE(년월일시분초)로부터 '년도'를 추출해라 = 2022
           -- MEM_BIR(생년월일)에서부터 YEAR을 추출해라 
           -- TRUNC -1 : 27에서 뒷자리를 0으로 만들기, 25에서 뒷자리를 0으로 만들기 
            2  7      2  3
           -2 -1     -2 -1  
           
           
           -- MEM_REGNO2에서 1번째 글자에서 한글자가 2또는 4안에  포함되어 지면 
           -- SUBSTR(MEM_REGNO2,1,1) ='2'
           -- SUBSTR(MEM_REGNO2,1,1) ='4'
           -- SUBSTR(MEM_REGNO2,1,1) ='2' OR SUBSTR(MEM_REGNO2,1,1) ='4'
              

    사용예) 회원테이블에서 연령대가 20대 여성이거나 회원이면서 마일리지가 2000이상인 회원을 조회하시오. 
           Alias는 회원번호, 회원명, 주민번호, 마일리지
           
           SELECT MEM_ID AS 회원번호, 
                   MEM_NAME AS 회원명, 
                   MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호, 
                   MEM_MILEAGE AS 마일리지
           FROM MEMBER
           WHERE  TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1) = 20 
                    OR SUBSTR(MEM_REGNO2,1,1) IN ('2', '4')
                    AND MEM_MILEAGE >= 2000;
                    
                    
    사용예) 키보드로 년도를 입력받아 윤년과 평년을 판단하시오.
    윤년: 4의배수이면서 100의 배수가 아니거나 또는 400의 배수가 되는 년도
    
    ACCEPT P_YEAR  PROMPT '년도입력 : ' --키보드로 연도를 입력받음 / 키보드로 입력받은 숫자가 문자열로 들어옴
    DECLARE
        V_YEAR NUMBER:=TO_NUMBER('&P_YEAR'); -- 문자열로 들어온 것들을 숫자로 바꿈
        V_RES VARCHAR2(100); 
    BEGIN
        IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100) != 0) OR (MOD(V_YEAR,400)=0) THEN --   V_YEAR을 4로 나눈 나머지가 0이면서 100으로 나눈 나머지가 0이 아니거나 400으로 나눈 나머지가 0이라면     MOD(V_YEAR,4)=0 (V_YEAR을 4로 나눈 나머지가 0)
            V_RES:=TO_CHAR(V_YEAR) || '년도는 윤년입니다.'; -- 문자열로 변환하고 V_RES에 넣어라 
        ELSE -- 그렇지 않으면 
            V_RES:=TO_CHAR(V_YEAR) || '년도는 평년입니다.';
        END IF;
        DBMS_OUTPUT.PUT_LINE(V_RES); -- DBMS_OUTPUT.PUT_LINE = SYSTEM.OUT.PRINTLN
    END;
        
           
           
           
           
           
           
           
           
           
    
    
   
          
          