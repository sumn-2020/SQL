2022-0808-01)  
3. 날짜 자료형 
- 날짜 시각 정보를 저장(년, 월, 일, 시, 분, 초)
- 날짜 자료는 덧셈과 뺄셈이 가능함
- date, timestamp 타입 제공

1) DATE타입
. 기본 날짜 및 시각정보 저장
    (사용형식)
    컬럼명 DATE 
        . 덧셈은 더해진 정수만큼 다가올 날짜 (미래)
        . 뺄셈은 차감한 정수만큼 지나온 날짜 (과거)
        . 날짜 자료 사이의 뺄셈은 날수(DAYS) 반환
        . 날짜자료는 년/월/일 부분과 시/분/초 부분으로 구분하여 저장
        ** 시스템이 제공하는 날짜정보는 **SYSDATE함수**를 통하여 참조할 수 있음
    
    (사용예) 
    CREATE TABLE TEMP16(
        COL1 DATE,
        COL2 DATE,
        COL3 DATE
    );
    INSERT INTO TEMP16 VALUES(SYSDATE, SYSDATE-10, SYSDATE+10);
    SELECT TO_CHAR(COL1, 'YYYY-MM-DD'),
           TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
           TO_CHAR(COL1, 'YYYY-MM-DD HH12:MI:SS')
    FROM TEMP16;
    
    -- TO_DATE(00010101) : 현재 날짜 - 서기 1년 1월 1일가 = 오늘 근데 오늘이 다 지나지 않았기 때문에 -1해줘야됨 
    -- MOD: 7로 나눈 나머지가  1일면 월요일, 2이면 화요일, 3이면 수요일... 
    -- DUAL: SELECT문을 사용하기 위해서 필요없지만 규격을 맞추기 위해서 사용되는 가상의 테이블 
    SELECT CASE MOD(TRUNC(SYSDATE)-TRUNC(TO_DATE('00010101'))-1,7) 
                WHEN 1 THEN '월요일',
                WHEN 2 THEN '화요일',
                WHEN 3 THEN '수요일',
                WHEN 4 THEN '목요일',
                WHEN 5 THEN '금요일',
                WHEN 6 THEN '토요일',
                ELSE 7 THEN '일요일'
            END AS 요일
    FROM DUAL;

    SELECT SYSDATE - TO_DATE('20200807') FROM DUAL; -- 오늘 날짜에서 2020년08월 07일이 몇일 지났는가
    SELECT * FROM TEMP16;
        
    2)( TIMESTAMP 타입
    . 시간대 정보(TIME ZOME)나 정교한 시각정보(10억분의 1초)가 필요한 경우 사용 
      
    (사용형식)
       컬럼명 TIMESTAMP  - 시간대 정보없이 정교한 시각정보 저장
       컬럼명 TIMESTAMP WITH LOCAL TIME ZONE
       컬럼명 TIMESTAMP WITH TIME ZONE
       
       
       . 초를 최대 9자리까지 표현할 수 있으나 기본은 6자리임
       
    
    
    CREATE TABLE TEMP117(
        COL1 DATE,
        COL2 TIMESTAMP,
        COL3 TIMESTAMP WITH LOCAL TIME ZONE,
        COL4 TIMESTAMP WITH TIME ZONE
    );
    
    INSERT INTO TEMP117 VALUES(SYSDATE,SYSDATE,SYSDATE,SYSDATE);
    
    
    
    
    SELECT * FROM TEMP117;
    
    
    
    
    
    
    
    
        
    
    
    
    