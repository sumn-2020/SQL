SEMI join

사용예) 사원테이블에서 급여가 10000이상인 사원이 존재하는 부서를 조회하시오.
       Alias는 부서코드, 부서명, 관리사원명
       
       -- 1) IN 연산자 사용
       SELECT 부서코드, 부서명, 관리사원명
       FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE A.DEPARTMENT_ID IN(서브쿼리)
         AND A.MANAGER_ID=B.EMPLOYEE_ID
       ORDER BY 1;
       
       -- 2) 서브쿼리: 급여가 10000이상인 사원이 존재하는 부서 조회
       SELECT DISTINCT DEPARTMENT_ID
         FROM HR.EMPLOYEES
        WHERE SALARY >= 10000
        
      -- 3) 결합
       SELECT A.DEPARTMENT_ID AS 부서코드, 
              A.DEPARTMENT_NAME AS 부서명, 
              B.EMP_NAME AS 관리사원명
       FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE A.DEPARTMENT_ID IN(SELECT DISTINCT DEPARTMENT_ID
                                  FROM HR.EMPLOYEES
                                 WHERE SALARY >= 10000)
         AND A.MANAGER_ID=B.EMPLOYEE_ID
       ORDER BY 1;
       
       
    --- 3-1) EXISTS 연산자 사용
        SELECT A.DEPARTMENT_ID AS 부서코드, 
              A.DEPARTMENT_NAME AS 부서명, 
              B.EMP_NAME AS 관리사원명
       FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE EXISTS(SELECT * 
                       FROM HR.EMPLOYEES C
                      WHERE C.SALARY>=10000
                      AND A.DEPARTMENT_ID=C.DEPARTMENT_ID) -- HR.EMPLOYEES C 20번직원중에서 월급이 10000이상인 직원들만 뽑아서 그 사람들만 1출력
         AND A.MANAGER_ID=B.EMPLOYEE_ID
       ORDER BY 1;
       
    
-------------------------------------------------------------------------------------
    
사용예) 회원테이블에서 직업이 주부인 회원들의 평균 마일리지보다 많은 마일리지를 보유한 회원정보를 출력하시오.
      Alias는 회원번호, 회원명, 직업, 마일리지 
    
    SELECT B.MEM_ID AS 회원번호, 
           B.MEM_NAME AS 회원명, 
           B.MEM_JOB AS 직업, 
           B.MEM_MILEAGE AS 마일리지 
      FROM MEMBER A, MEMBER B
    WHERE A.MEM_NAME='오철희'
      AND A.MEM_MILEAGE<B.MEM_MILEAGE;
      -- A테이블: 오철희 회원 정보가 들은 테이블
      -- B테이블: 오철희 뿐아니라 나머지 회원들 정보 전부가 들은 테이블
      
      
사용예) 상품코드 'P202000012'와 같은 분류에 속한 상품 중 'P202000012'보다 매입단가가 큰 상품을 조회하시오
       Alias는 상품코드, 상품명, 분류명, 매입단가
       
       SELECT B.PROD_ID AS 상품코드,
              B.PROD_NAME AS 상품명,
              C.LPROD_NM AS 분류명,
              B.PROD_COST AS 매입단가
        FROM PROD A, PROD B, LPROD C
       WHERE A.PROD_ID='P202000012' --일반조건
         AND A.PROD_LGU=B.PROD_LGU -- EUI JOIN 조인조건
         AND A.PROD_COST<B.PROD_COST -- NON EUI JOIN 조인조건
         AND A.PROD_LGU=C.LPROD_GU;   -- EUI JOIN 조인조건:  분류명 꺼내오기
       
       
       















       
       
       
       
       
        