2022-0810-01) 

4. 기타연산자
- 오라클에서 제공하는 기타연산자는 IN, ANY, SOME, ALL, EXISTS, BETWEEN, LIKE 연산자가 있음
1) IN 
사용형식) 
expr IN(값, 값2,...값n);
=> expr = 값1
   OR expr = 값2
   OR    :
   OR expr = 값n
   
   사용예) 사원테이블에서 부서번호가 20, 50, 60, 100번에 속한 사원들을 조회하시오. 
   Alias는 사원번호, 사원명, 부서번호, 입사일
   
   (OR 연산자 사용)
   SELECT EMPLOYEE_ID AS 사원번호, 
       EMP_NAME AS 사원명, 
       DEPARTMENT_ID AS 부서번호, 
       HIRE_DATE AS 입사일
   FROM HR.EMPLOYEES -- hr계정의 employees 테이블
   WHERE DEPARTMENT_ID=20
        OR DEPARTMENT_ID=50
        OR DEPARTMENT_ID=60
        OR DEPARTMENT_ID=100
   ORDER BY  3; --부서번호를 기준으로 오름차순 정렬 
   
   
   (IN 연산자 사용)
   SELECT EMPLOYEE_ID AS 사원번호, 
       EMP_NAME AS 사원명, 
       DEPARTMENT_ID AS 부서번호, 
       HIRE_DATE AS 입사일
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID IN(20, 50, 60, 100) -- DEPARTMENT_ID가 20이거나, 50이거나, 60이거나 100이면 
   ORDER BY 3;
   
   
   (ANY 연산자 사용)
   SELECT EMPLOYEE_ID AS 사원번호, 
       EMP_NAME AS 사원명, 
       DEPARTMENT_ID AS 부서번호, 
       HIRE_DATE AS 입사일
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID =ANY(20, 50, 60, 100)
   ORDER BY 3;
   
   (SOME 연산자 사용)
   SELECT EMPLOYEE_ID AS 사원번호, 
       EMP_NAME AS 사원명, 
       DEPARTMENT_ID AS 부서번호, 
       HIRE_DATE AS 입사일
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID =SOME(20, 50, 60, 100)
   ORDER BY 3;
   
   
   2) ANY(SOME) 연산자 (관계연산자부터 쓴 후에 any(some)사용할 수 있음)
    사용예) 사원테이블에서 부서번호 60번부서에 속한 사원들의 급여 중 가장 적은 급여보다 
    더 많은 급여를 받는 사원들을 조회하시오.
    Alias는 사원번호, 사원명, 급여, 부서번호이며 급여가 적은사람부터 출력하시오
    --알고있지 않은 값을 가지고 서로 비교하는 것 = 서브쿼리 
    
    SELECT EMPLOYEE_ID AS 사원번호, 
            EMP_NAME AS 사원명, 
            SALARY AS 급여, 
            DEPARTMENT_ID AS 부서번호
    FROM HR.EMPLOYEES
    WHERE  SALARY > (SELECT SALARY     --EMPLOYEE테이블에 가서 첫번째 사람의 샐러리를 가져와서 비교해라. 1행 > 5행 (오류)
                    FROM HR.EMPLOYEES
                    WHERE DEPARTMENT_ID = 60)
    ORDER BY 3; --급여가 적은사람부터 오름차순 순으로 
    
    
    
    SELECT EMPLOYEE_ID AS 사원번호, 
            EMP_NAME AS 사원명, 
            SALARY AS 급여, 
            DEPARTMENT_ID AS 부서번호
    FROM HR.EMPLOYEES
    WHERE  SALARY >ANY (SELECT SALARY     
                    FROM HR.EMPLOYEES
                    WHERE DEPARTMENT_ID = 60)
    ORDER BY 3;
    
     SELECT EMPLOYEE_ID AS 사원번호, 
            EMP_NAME AS 사원명, 
            SALARY AS 급여, 
            DEPARTMENT_ID AS 부서번호
    FROM HR.EMPLOYEES
    WHERE  SALARY >ANY (9000,6000,4800,4800,4200)
     AND DEPARTMENT_ID !=60
    ORDER BY 3;
    
    
    SELECT EMPLOYEE_ID AS 사원번호, 
            EMP_NAME AS 사원명, 
            SALARY AS 급여, 
            DEPARTMENT_ID AS 부서번호
    FROM HR.EMPLOYEES
    WHERE  SALARY >ANY (SELECT SALARY   
                           FROM HR.EMPLOYEES
                           WHERE DEPARTMENT_ID = 60)
    AND DEPARTMENT_ID !=60
    ORDER BY 3;
   
   
   
   SELECT SALARY   
   FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID = 60; -- 4200
   
   
   
   사용예) 2020년 4월 판매된 상품 중 매입되지 않은 상품을 조회하시오.
   Alias는 상품코드이다. 
   
    SELECT CART_PROD AS 상품코드 
    FROM CART
    WHERE CART_NO LIKE '202004%'-- 2020년 4월달에 발생한 매출자료 중
        AND CART_PROD =ANY (SELECT DISTINCT BUY_PROD -- DISTICT: 중복되는 자료 한번만 사용
                                  FROM BUYPROD
                                  WHERE BUY_DATE >= '20200401' AND BUY_DATE <= '20200430'); -- 2020년 4월 1일~202년 04월30일까지 발생된 상품코드
    
    -- CART_PROD가 26개와 같다면 : 참 
    -- 다르다면 : 거짓
    
    
    
    
    
    3) ALL 연산자
    사용예) 사원테이블에서 부서번호 60번부서에 속한 사원들의 급여 중 가장 적은 급여보다 
    더 많은 급여를 받는 사원들을 조회하시오.
    Alias는 사원번호, 사원명, 급여, 부서번호이며 급여가 적은사람부터 출력하시오
    
    SELECT EMPLOYEE_ID AS 사원번호, 
            EMP_NAME AS 사원명, 
            SALARY AS 급여, 
            DEPARTMENT_ID AS 부서번호
    FROM HR.EMPLOYEES
    WHERE SALARY >ALL(9000,6000,4800,4200)
    ORDER BY 3; 
    
    
    
    
    
        