2022-0826-03] 순위함수

사용예) 회원테이블에서 회원번호, 회원명, 마일리지, 순위를 조회하시오.
       순위는 마일리지가 많은 회원부터 부여하고 같은 마일리지면 같은 순위를 부여하시오.
       
SELECT MEM_ID AS 회원번호, 
       MEM_NAME AS 회원명, 
       MEM_MILEAGE AS 마일리지, 
       EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이,
       RANK() OVER(ORDER BY MEM_MILEAGE DESC, 
                  (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)) DESC) AS  순위 --마일리지가 같으면 나이 순으로 정렬하겠다.
FROM MEMBER;
--마일리지가 많은 회원부터 부여 (=동점자 처리해라)










SELECT MEM_ID AS 회원번호, 
       MEM_NAME AS 회원명, 
       MEM_MILEAGE AS 마일리지, 
       EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이,
       ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC)  AS  순위 
FROM MEMBER;

사용예) 사원테이블에서 부서별로 급여에 따른 순위를 부여하시오.
       Alias는 사원번호, 사원명, 부서번호, 급여, 순위이여 순위는 급여가 많은 사람순으로 부여하시오. 
       같은 급여는 동일 순위 부여할 것
       
SELECT EMPLOYEE_ID  AS 사원번호, 
       EMP_NAME AS 사원명, 
       DEPARTMENT_ID AS 부서번호, 
       SALARY AS 급여, 
       RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS 순위
FROM HR.EMPLOYEES;
-- PARTITION BY : =GROUP BY































