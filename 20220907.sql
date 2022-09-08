20220907-01 분기문과 반복문

사용예) 사원테이블에서 임의의 부서를 선택하여 첫번째 검색된 사원의 급여를 조회하고 
       그 급여가 
              1 ~ 5000 : '저 비용 사원'
          5001 ~ 10000 : '평균비용 사원'
         10001 ~ 20000 : '고비용 사원'
                그 이상 : '초고도비용 사원'을 사원명, 급여와 함께 출력하시오
    
                
DECLARE 
    V_RES VARCHAR2(100); -- 사원코드 저장될 변수
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; -- 사원명
    V_SAL NUMBER:= 0; -- 급여
    V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; -- 부서코드
BEGIN 
    V_DID := TRUNC(DBMS_RANDOM.VALUE(10, 119), -1); -- DBMS_RANDOM.VALUE :  정수형 난수 발생 시킴 / DEPARTMENT_ID 10 ~ 119까지 랜덤으로 출력 / TRUNC: 19 나와도 10으로 만듬, 119나와도 9없애고 110나옴
    SELECT EMP_NAME, SALARY INTO V_ENAME, V_SAL
      FROM HR.EMPLOYEES
     WHERE DEPARTMENT_ID =  V_DID
       AND ROWNUM = 1; -- 제일 첫번째 조회되어지는 사람
       
    CASE WHEN V_SAL<=5000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'저 비용 사원';
         WHEN V_SAL<=10000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'평균비용 사원';
         WHEN V_SAL<=20000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'고 비용 사원';
         ELSE   
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'초고도비용 사원';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(V_RES);
END;

------------------------------------------------------------------------

사용예) 구구단의 5단을 출력하시오.
DECLARE
    V_CNT NUMBER:=0;
BEGIN
    LOOP
      
       EXIT WHEN V_CNT>9; --9까지 조건문 반복,
       DBMS_OUTPUT.PUT_LINE('5 *'||V_CNT||' = '||5*V_CNT);
        V_CNT := V_CNT + 1; 
    END LOOP;
END;


----------------------------------------------------------------

사용예) 사원테이블에서 임의의 부서를 선택하여 해당부서에 소속된 사원들의 급여를 조회하고 
       그 급여가 
              1 ~ 5000 : '저 비용 사원'
          5001 ~ 10000 : '평균비용 사원'
         10001 ~ 20000 : '고비용 사원'
                그 이상 : '초고도비용 사원'을 사원명, 급여와 함께 출력하시오
    


DECLARE
    V_RES VARCHAR2(100); -- 결과
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; --사원명
    V_SAL NUMBER:= 0;  -- 급여
    V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; -- 부서번호
    CURSOR EMP01_CUR(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS 
      SELECT EMP_NAME, SALARY --DECLARE문에서는 SELECT INTO 안씀 BE. INTO는 BEGIN구문에서 메인 쿼리에서만 쓰임(서브쿼리절에서도 안쓰임)
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID=P_DID; -- DEPARTMENT_ID가 P_DID로 구성되어진 커서
BEGIN
  V_DID:=TRUNC(DBMS_RANDOM.VALUE(10,119),-1);
  OPEN EMP01_CUR(V_DID); --  : V_DID(argument)가 P_DID(파라미터)로 전달됨
  DBMS_OUTPUT.PUT_LINE('부서코드 :' || V_DID); -- 부서코드 출력
  LOOP
    FETCH EMP01_CUR INTO V_ENAME, V_SAL; --EMP01_CUR을 가져와서 V_ENAME, V_SAL에 넣어라 
    EXIT WHEN EMP01_CUR%NOTFOUND; -- 읽어오지 않으면 이거 실행 안됨 무조건 FETCH하고 난 후에 실행됨 / 커서에서 더이상 읽어올 데이터가 없으면 밖으로 빠져 나가라.
    CASE WHEN V_SAL<=5000 THEN    -- 커서에 내용물이 있으면 실행
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'저 비용 사원';
         WHEN V_SAL<=10000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'평균비용 사원';
         WHEN V_SAL<=20000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'고 비용 사원';
         ELSE   
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'초고도비용 사원';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(V_RES);
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('--------------------------------');
   DBMS_OUTPUT.PUT_LINE('사원 수: ' || EMP01_CUR%ROWCOUNT||'명'); -- 사원수 출력 / ROWCOUNT커서에 들어있는 전체 행의 수
  CLOSE EMP01_CUR;
END;

---------------------------------------------------------------------------------

사용예) 구구단의 5단을 출력하시오.
DECLARE
    V_CNT NUMBER:=1;
BEGIN
    WHILE V_CNT<=9 LOOP
      DBMS_OUTPUT.PUT_LINE('5 *' || V_CNT||' = '||5*V_CNT);
      V_CNT := V_CNT + 1;
    END LOOP;
END;


사용예) 사원테이블에서 임의의 부서를 선택하여 해당부서에 소속된 사원들의 급여를 조회하고 
       그 급여가 
              1 ~ 5000 : '저 비용 사원'
          5001 ~ 10000 : '평균비용 사원'
         10001 ~ 20000 : '고비용 사원'
                그 이상 : '초고도비용 사원'을 사원명, 급여와 함께 출력하는 블록을 WHILE문으로 구성하시오


DECLARE
    V_RES VARCHAR2(100); -- 결과
    V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; --사원명
    V_SAL NUMBER:= 0;  -- 급여
    V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; -- 부서번호
    CURSOR EMP01_CUR(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS 
      SELECT EMP_NAME, SALARY 
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID=P_DID; 
BEGIN
  V_DID:=TRUNC(DBMS_RANDOM.VALUE(10,119),-1);
  OPEN EMP01_CUR(V_DID); 
  DBMS_OUTPUT.PUT_LINE('부서코드 :' || V_DID); 
  FETCH EMP01_CUR INTO V_ENAME, V_SAL;  -- 첫번째 사람 처리
  WHILE EMP01_CUR%FOUND LOOP -- "무조건 FETCH하고 난 후에"  실행됨
  --FETCH EMP01_CUR INTO V_ENAME, V_SAL; -- FETCH가 여기 있으면 맨 마지막 사람이 두번찍힘
    CASE WHEN V_SAL<=5000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'저 비용 사원';
         WHEN V_SAL<=10000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'평균비용 사원';
         WHEN V_SAL<=20000 THEN    
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'고 비용 사원';
         ELSE   
              V_RES:=RPAD(V_ENAME,40)|| TO_CHAR(V_SAL, '99,999')||'초고도비용 사원';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(V_RES);
    FETCH EMP01_CUR INTO V_ENAME, V_SAL; -- 두번째 사람 있으면 다시 반복문 실행 
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('--------------------------------');
   DBMS_OUTPUT.PUT_LINE('사원 수: ' || EMP01_CUR%ROWCOUNT||'명');
  CLOSE EMP01_CUR;
END;
--WHILE문은 항상 FETCH가 두번 씌여져야됨 



-------------------------------------------------------------------------------



사용예) 구구단의 5단을 FOR문을 이용하여 출력하시오.
DECLARE
BEGIN
    FOR I IN 1..9 LOOP
      DBMS_OUTPUT.PUT_LINE('5 * '|| I || ' = ' || 5*I);
    END LOOP;
END;



------------------------------------------------------------------------

사용예) 사원테이블에서 임의의 부서를 선택하여 해당부서에 소속된 사원들의 급여를 조회하고 
       그 급여가 
              1 ~ 5000 : '저 비용 사원'
          5001 ~ 10000 : '평균비용 사원'
         10001 ~ 20000 : '고비용 사원'
                그 이상 : '초고도비용 사원'을 사원명, 급여와 함께 출력하는 블록을 FOR문으로 구성하시오-
                

(CURSOR 사용)
DECLARE
    V_CNT NUMBER:=0; 
    V_RES VARCHAR2(100); -- 결과

    CURSOR EMP01_CUR IS 
      SELECT EMP_NAME, SALARY 
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID=80; 
BEGIN
  DBMS_OUTPUT.PUT_LINE('부서코드 : 80'); 
  FOR REC IN EMP01_CUR LOOP
    V_CNT:=V_CNT + 1;
    CASE WHEN REC.SALARY<=5000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'저 비용 사원';
         WHEN REC.SALARY<=10000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'평균비용 사원';
         WHEN REC.SALARY<=20000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'고 비용 사원';
         ELSE   
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'초고도비용 사원';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(V_RES);
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('--------------------------------');
   DBMS_OUTPUT.PUT_LINE('사원 수: ' || V_CNT ||'명');
END;


(IN-LINE SUBQUERY) - 커서 선언문 필요 없음 
DECLARE
    V_CNT NUMBER:=0; 
    V_RES VARCHAR2(100); -- 결과
BEGIN
  DBMS_OUTPUT.PUT_LINE('부서코드 : 80'); 
  FOR REC IN ( SELECT EMP_NAME, SALARY FROM HR.EMPLOYEES
               WHERE DEPARTMENT_ID=80) LOOP
    V_CNT:=V_CNT + 1;
    CASE WHEN REC.SALARY<=5000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'저 비용 사원';
         WHEN REC.SALARY<=10000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'평균비용 사원';
         WHEN REC.SALARY<=20000 THEN    
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'고 비용 사원';
         ELSE   
              V_RES:=RPAD(REC.EMP_NAME,40)|| TO_CHAR(REC.SALARY, '99,999')||'초고도비용 사원';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(V_RES);
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('--------------------------------');
   DBMS_OUTPUT.PUT_LINE('사원 수: ' || V_CNT ||'명');
END;

































