2022-0818-02) 
2. 숫자함수


사용예)  
SELECT ABS(10), ABS(-100), ABS(0),
       SIGN(-20000), SIGN(-0.0099), SIGN(0.000005), SIGN(500000), SIGN(0),
       POWER(2,10),
       SQRT(3.3)
FROM DUAL; 
----------------------------

SELECT GREATEST('KOREA', 1000, '홍길동'),
       LEAST('ABC', '홍길동', '200')
FROM DUAL;


SELECT ASCII('홍') FROM DUAL; 



사용예) 회원테이블에서 마일리지가 1000미만인 회원을 찾아 1000으로 변경 출력하시오. 
    Alias는 회원번호, 회원명, 원본마일리지, 변경된 마일리지
    
SELECT MEM_ID AS 회원번호, 
       MEM_NAME AS 회원명, 
       MEM_MILEAGE AS 원본마일리지, 
       GREATEST(MEM_MILEAGE , 1000) AS 변경된마일리지   -- 1000과 회원들이 가지고있는 마일리지를 비교한 후 둘 중에 1000보다 작으면 출력하고 아니면 1000으로 
FROM MEMBER; 
-- 조건은 없음 24명 다 찍어야 되니까






-----------------------------------------------------------------

사용예) 
SELECT ROUND(12345.678945,3), --9를 반올림  
       ROUND(12345.678945), -- 6을 반올림 
       ROUND(12345.678945,-3) -- 3을 반올림 
FROM DUAL; 

SELECT TRUNC(12345.678945,3), -- 9부터 삭제
       TRUNC(12345.678945), -- 6부터 삭제 
       TRUNC(12999.678945,-3) -- 세번째 9부터 삭제
FROM DUAL;


사용예) HR계정의 사원테이블에서 사원들의 근속연수를 구하여 근속연수에 따른 근속 수당을 계산하시오.
       근속수당 = 기본급(SALARY) * (근속년수/100)
       급여합계 = 기본급 + 근속수당 
       세금 = 급여합계의 13%
       지급액 = 급여합계-세금이며 소수 2째자리에서 반올림하시오. 
       Alias는 사원번호, 사원명, 입사일, 근속년수, 급여, 근속수당, 세금, 지급액 
       
    SELECT EMPLOYEE_ID AS 사원번호, 
           EMP_NAME AS 사원명, 
           HIRE_DATE AS 입사일, 
           TRUNC((SYSDATE - HIRE_DATE) / 365) AS 근속년수,
           SALARY AS 기본급여,
           ROUND(SALARY * (TRUNC((SYSDATE - HIRE_DATE) / 365)) / 100),1) AS 근속수당,
           ROUND(SALARY + SALARY * (TRUNC((SYSDATE - HIRE_DATE) / 365)) / 100),1) AS 급여합계,
           ROUND(SALARY + ROUND(SALARY + SALARY * (TRUNC((SYSDATE - HIRE_DATE) / 365) / 100),1) AS 세금,
           (SALARY + SALARY * (TRUNC((SYSDATE - HIRE_DATE) / 365)/100)) - (SALARY + (SALARY * (TRUNC((SYSDATE - HIRE_DATE) / 365)/100))) * 0.13 AS 지급액 
    FROM HR.EMPLOYEES;
    
    
    
사용예) 
    SELECT FLOOR(23.456), FLOOR(23), FLOOR(-23.456), 
           CEIL(23.456), CEIL(23), CEIL(-23.456)
    FROM DUAL; 





사용예
SELECT WIDTH_BUCKET(28, 10, 39, 3), -- 10부터 39까지 3개의 영역으로 나눴을때 28은 몇번째 구간에 속하는가
        WIDTH_BUCKET(8, 10, 39, 3), -- 10부터 39까지 3개의 영역으로 나눴을때 8은 몇번째 구간에 속하는가
        WIDTH_BUCKET(39, 10, 39, 3), -- 10부터 39까지 3개의 영역으로 나눴을때 39는 몇번째 구간에 속하는가
        WIDTH_BUCKET(58, 10, 39, 3), -- 10부터 39까지 3개의 영역으로 나눴을때 58는 몇번째 구간에 속하는가
        WIDTH_BUCKET(10, 10, 39, 3) -- 10부터 39까지 3개의 영역으로 나눴을때 10은 몇번째 구간에 속하는가
FROM DUAL; 




사용예) 회원테이블에서 회원들의 마일리지를 조회하여 
1000 - 9000사이를 3개의 구간으로 구분하고 
회원번호, 회원명, 마일리지, 비고를 출력하되 
비고에는 마일리지가 많은 회원부터 '1등급 회원', '2등급 회원', '3등급 회원', '4등급 회원'을 출력하시오. 


SELECT MEM_ID AS 회원번호, 
       MEM_NAME AS 회원명, 
       MEM_MILEAGE AS 마일리지, 
       4 - WIDTH_BUCKET( MEM_MILEAGE ,1000, 9000, 3)||'등급회원' AS 비고
       --WIDTH_BUCKET( MEM_MILEAGE ,9000, 999, 3)||'등급회원'
FROM MEMBER;
























-





, 
       