CREATE OR REPLACE PROCEDURE PROC_EMP01(
    P_DID IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
  IS
    V_NAME VARCHAR2(100);
    V_JOBID HR.JOBS.JOB_ID%TYPE;
    V_DNAME VARCHAR2(100);
    V_SAL NUMBER:=0;
  BEGIN
    SELECT B.EMP_NAME, B.JOB_ID, A.DEPARTMENT_NAME, B.SALARY
      INTO V_NAME, V_JOBID, V_DNAME, V_SAL
      FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
     WHERE A.DEPARTMENT_ID=P_DID
       AND A.MANAGER_ID=B.EMPLOYEE_ID;
    DBMS_OUTPUT.PUT_LINE('부서번호 : '||P_DID);
    DBMS_OUTPUT.PUT_LINE('부서장 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('직무코드 : '||V_JOBID);
    DBMS_OUTPUT.PUT_LINE('부서명 : '||V_DNAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||V_SAL);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
  END;
  
(실행)
EXECUTE PROC_EMP01(60);




------------------------------------------------
사용예) 년도와 월을 입력 받아 해당 기간에 가장많은 구매액을 기록한 회원정보를 조회하시오.
       Alias는 회원번호, 회원명, 구매금액, 주소이다. 

(프로시저)
입력 : 년도와 월
처리 : cart테이블에서 최대구매액을 기록한 회원번호, 구매액 합계 계산
출력 : 회원번호, 구매액 합계

CREATE OR REPLACE PROCEDURE PROC_CART01(
  P_PERIOD IN VARCHAR2, -- 년월 입력 
  P_MID OUT MEMBER.MEM_ID%TYPE, --회원번호 출력
  P_SUM OUT NUMBER) -- 구매금액 합계출력
IS 
  
BEGIN
  SELECT TA.CID, TA.CSUM INTO P_MID, P_SUM
    FROM (SELECT  A.CART_MEMBER AS CID,
                  SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
            FROM CART A,PROD B
           WHERE A.CART_PROD = B.PROD_ID
             AND SUBSTR(A.CART_NO, 1, 6) = P_PERIOD
           GROUP BY A.CART_MEMBER
           ORDER BY 2 DESC) TA
   WHERE ROWNUM = 1;
END;
  
  
 
(실행)
입력 : 회원번호, 구매액 합계
처리 : member테이블에서 회원번호, 회원명, 주소를 검색 
출력 : 회원번호, 회원명, 주소, 구매액 합계

DECLARE 
   V_MID MEMBER.MEM_ID%TYPE;
   V_SUM NUMBER:= 0;
   V_ADDR VARCHAR2(100);
   V_NAME MEMBER.MEM_NAME%TYPE;
BEGIN
   PROC_CART01('202005', V_MID, V_SUM);
   SELECT MEM_NAME, MEM_ADD1 ||'-'|| MEM_ADD2 INTO V_NAME, V_ADDR
     FROM MEMBER
    WHERE MEM_ID = V_MID;
   DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MID);
   DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
   DBMS_OUTPUT.PUT_LINE('주소 : '||V_ADDR);
   DBMS_OUTPUT.PUT_LINE('구매금액 : '||V_SUM);
   DBMS_OUTPUT.PUT_LINE('=--------------------------------------');
END;
   
   
   
--------------------------------------------------------------------------

사용예) 직업이 '자영업'인 회원번호를 입력 받아 2020년 상반기(1-6월) 구매현황을 출력하는 프로시저를 작성하시오.
       Alias는 회원번호, 회원명, 구매금액합계




사용예) 다음 자료를 판매한 경우 매출처리를 프로시져로 작성하시오

판매자료
----------------------------------------------
구매회원번호       날짜         상품코드      수량 
----------------------------------------------
n001         2020-07-28     P102000005    3


CREATE OR REPLACE PROCEDURE PROD_CART_INPUT(
  P_MID IN MEMBER.MEM_ID%TYPE, -- 구매회원번호는 MEMBER.MEM_ID와 같은 타입 / IN : 입력용(출력용x)
  P_DATE IN DATE, -- IN : 입력용(출력용x)
  P_PID PROD.PROD_ID%TYPE,
  P_QTY NUMBER)
IS 
    V_CART_NO CART.CART_NO%TYPE; -- V_CART_NO는 CART.CART_NO와 같은 타입으로 변수 만들기
    V_FLAG NUMBER:=0; --오늘 로그인한 회원 수
    V_DAY CHAR(9):= TO_CHAR(P_DATE, 'YYYYMMDD') ||'%';
BEGIN 
    -- 1) CART테이블에 저장 
    SELECT COUNT(*) INTO V_FLAG --로그인한 사람이 있으면 V_FLAG에 넣어줘라 
      FROM CART
     WHERE CART_NO LIKE V_DAY;

    IF V_FLAG=0 THEN 
       V_CART_NO:=TO_CHAR(P_DATE, 'YYYYMMDD')||TRIM('00001'); -- YYYYMMDD + TRIM공백이 있으면 자르고 
    ELSE
       SELECT MAX(CART_NO)+1 INTO V_CART_NO  -- V_CART_NO에 제일큰값을 V_CART_NO에 넣기
         FROM CART
        WHERE CART_NO LIKE V_DAY;
    END IF;
    
    INSERT  INTO CART VALUES(P_MID,V_CART_NO, P_PID,P_QTY);
    COMMIT;
    -- 2) 재고 조정
    UPDATE REMAIN A
       SET A.REMAIN_O = A.REMAIN_O+P_QTY, 
           A.REMAIN_J_99 = A.REMAIN_J_99 - P_QTY, 
           A.REMAIN_DATE =P_DATE -- 이거 세개를 변경
     WHERE A.PROD_ID = P_PID
       AND A.REMAIN_YEAR = '2020';
    
    -- 3) 마일리지 부여 후 합산
END; 








































