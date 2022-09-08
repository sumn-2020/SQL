사용예) 키보드로 부서를 입력받아 해당부서에 가장 먼저 입사한 사원의 사원번호, 사원명, 직책코드, 입사일을 출력하는 블록을 작성하시오.

ACCEPT P_DID PROMPT '부서번호 입력 :'  -- 문자열 형태로 저장됨 
DECLARE 
  V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;  --V_DID를 HR.DEPARTMENTS계정의 DEPARTMENT_ID와 같은 타입으로 
  V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- 사원번호이 들어갈 공간
  V_NAME  VARCHAR2(100); --사원명이 들어갈 공간
  V_JID HR.JOBS.JOB_ID%TYPE; --직책코드이 들어갈 공간
  V_HDATE DATE; -- 입사일이 들어갈 공간
BEGIN
  V_DID := TO_NUMBER('&P_DID');  --> := (=)와 같음  / =  equal TO
  SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.JOB_ID, A.HIRE_DATE
    INTO V_EID, V_NAME, V_JID, V_HDATE
    FROM (SELECT EMPLOYEE_ID, EMP_NAME, JOB_ID, HIRE_DATE  -- 2) EMPLOYEE_ID는 V_EID에 / EMP_NAME 은 V_NAME에 저장
            FROM HR.EMPLOYEES
           WHERE DEPARTMENT_ID = V_DID
           ORDER BY 4) A
   WHERE ROWNUM = 1; -- 1) 맨위에 있는 사람만 꺼내서 그 사람의
   
   DBMS_OUTPUT.PUT_LINE('사원번호 : ' || V_EID); -- SYSTEM.OUT.PRINTLN  
   DBMS_OUTPUT.PUT_LINE('사원명 : ' || V_NAME);
   DBMS_OUTPUT.PUT_LINE('직책코드 : ' || V_JID);
   DBMS_OUTPUT.PUT_LINE('입사일 : ' || V_HDATE);
   DBMS_OUTPUT.PUT_LINE('-------------------------------------');
END;



SELECT EMP_NAME, HIRE_DATE
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = 60;


---------------------------------------------------------------------------

사용예) 회원테이블에서 직업이  '주부'인 회원들의 2020년 5월 구매현황을 조회하시오
       Alias는 회원번호, 회원명, 직업, 구매금액합계
       
(익명블록 사용 안한 예)      
 SELECT  A.MEM_ID AS 회원번호, 
         A.MEM_NAME AS 회원명, 
         A.MEM_JOB AS 직업, 
         D.BSUM AS 구매금액합계
   FROM (SELECT MEM_ID, MEM_NAME, MEM_JOB
           FROM MEMBER 
          WHERE MEM_JOB='주부') A,
        (SELECT B.CART_MEMBER AS BMID,
                SUM(B.CART_QTY * C.PROD_PRICE) AS BSUM
           FROM CART B, PROD C
          WHERE B.CART_PROD = C.PROD_ID
            AND B.CART_NO LIKE '202005%'
          GROUP BY B.CART_MEMBER) D
WHERE A.MEM_ID = D.BMID;
       
       
(익명블록 사용한 예)
DECLARE
    V_MID MEMBER.MEM_ID%TYPE; --MEMBER.MEM_ID와 같은 타입으로 V_MID를 설정한다. 
    V_NAME VARCHAR2(100); 
    V_JOB MEMBER.MEM_JOB%TYPE;
    V_SUM NUMBER:=0; -- 자리수 따로 안적어줘도 27자리까지는 자동으로 잡아줌 /NUMBER타입은 무조건 0으로 초기화 시켜야 함 
    
    CURSOR CUR_MEM IS  -- SELECT 문에 사용되는 CURSOR는 INTO절 안씀
     SELECT MEM_ID, MEM_NAME, MEM_JOB --주부인 사람의 MEM_ID, MEM_NAME, MEM_JOB 정보를 CUR_MEM안에 넣기 
           FROM MEMBER 
          WHERE MEM_JOB='주부';
BEGIN
   OPEN CUR_MEM; -- 커서가 열리는 순간 표안에 들어가서 다섯명인 주부인 회원을 하나하나 빼올수 있음(FETCH).커서가 CLOSE 되는 순간 표가 닫혀서 접근못함  
   LOOP
     FETCH CUR_MEM INTO V_MID, V_NAME, V_JOB;  -- 한줄한줄 읽으면서 각각의 변수에 넣어라 
     EXIT WHEN CUR_MEM%NOTFOUND; --더 이상 읽을 내용이 없을 경우 EXIT : LOOP문을 나가라 
     SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO V_SUM  --SUM(A.CART_QTY*B.PROD_PRICE)를 V_SUM에다가 넣어라
       FROM CART A, PROD B
      WHERE A.CART_PROD = B.PROD_ID
        AND A.CART_NO LIKE '202005%'
        AND A.CART_MEMBER = V_MID;
     DBMS_OUTPUT.PUT_LINE('회원번호:'||V_MID); --FETCH줄에 있는 V_MID거 들고와서 출력
     DBMS_OUTPUT.PUT_LINE('회원명:'||V_NAME);
     DBMS_OUTPUT.PUT_LINE('직업:'||V_JOB);
     DBMS_OUTPUT.PUT_LINE('구매금액:'||V_SUM);
     DBMS_OUTPUT.PUT_LINE('-------------------------------------');
   END LOOP; -- 반복문 빠져나가라
   CLOSE CUR_MEM; -- 열어놓은 CURSOR을 닫아라
END;
    
    
-- 커서를 만드는 이유: 한 줄씩 읽어서 하나하나 변수 안에 넣을라고 ...
-------------------------------------------------------------------------------------


사용예) 년도를 입력 받아 윤년인지 평년인지 구별하는 블록을 작성하시오.


-- 1) 블록만들기
DECLARE

BEGIN

END;


-- 2) 년도를 입력 받아
ACCEPT P_YEAR PROMPT '년도입력 : '
DECLARE

BEGIN

END;


-- 3) 변수를 선언하면서 받아온 연도를 숫자로 바꿔서 V_YEAR에 넣음
ACCEPT P_YEAR PROMPT '년도입력 : '
DECLARE
    V_YEAR NUMBER:=TO_NUBMER('&P_YEAR'); 
    V_RES VARCHAR2(200);
BEGIN

END;



-- 4)  윤년인지 평년인지 구분 : 4의 배수 - 윤년
ACCEPT P_YEAR PROMPT '년도입력 : '
DECLARE
    V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');
    V_RES VARCHAR2(200);
BEGIN
    IF(MOD(V_YEAR, 4) = 0 AND MOD(V_YEAR, 100) != 0) OR (MOD(V_YEAR,400) = 0) THEN -- YEAR을 4로나눈 나머지가 0과 같고
       V_RES:=V_YEAR||'년은 윤년입니다.';
    ELSE
       V_RES:=V_YEAR||'년은 평년입니다.';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_RES); --V_RES출력
END;


-------------------------------------------------------------------------------------

사용예) 반지름을 입력받아 원의 넓이와 원주의 길이를 구하시오.
       원의 넓이: 반지름 * 반지름* 원주율(3.1415926) - 상수써서 해보기
       원 둘레: 지름 * 3.1415926



ACCEPT V_RADIUS PROMPT '반지름입력 : '
DECLARE
    V_RADIUS NUMBER := 15;
    V_PIE CONSTANT NUMBER := 3.1415926;
    V_AREA NUMBER := 0;
    V_CIRCUM NUMBER := 0;
BEGIN
    V_AREA :=  V_RADIUS * V_RADIUS * V_PIE;
    V_CIRCUM := V_RADIUS  * 2 * V_PIE;
    
    
    DBMS_OUTPUT.PUT_LINE('원의 너비 = ' || V_AREA);
    DBMS_OUTPUT.PUT_LINE('원의 둘레 = ' || V_CIRCUM);
END;

























