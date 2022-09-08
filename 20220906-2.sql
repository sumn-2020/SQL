커서


-----------------------------------------------------------
속성               의미
-----------------------------------------------------------
SQL%ISOPEN        커서가 OPEN 되었으면 참(ture) 반환 항상 false임
SQL%FOUND         커서 내부에 FETCH할 자료가 존재하면 참(true)
SQL%NOTFOUND      커서 내부에 FETCH할 자료가 없으면 참(true)
SQL%ROWCOUNT      커서 내부의 행의 수 반환
-----------------------------------------------------------



----------------------------------------------------------------------


사용예) 사원테이블에서 부서번호를 입력받아 그 부서에 속한 사원정보를 출력하는 커서 작성


DECLARE 
 CURSOR EMP_CUR(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS 
  SELECT  EMPLOYEE_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM HR.EMPLOYEES
   WHERE DEPARTMENT_ID=P_DID;
























