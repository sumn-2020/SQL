2022-0805-01)데이터타입
- 오라클에는 문자열, 숫자, 날짜, 이진수 자료타입이 제공 
1. 문자 데이터타입 
    . 오라클의 문자자료는 ''안에 기술된 자료
    . 대소문자 구별 (따옴표안에서는)
    . CHAR(고정길이), VARCHAR(가변길이), VARCHAR2(오라클에서만 쓰는 가변길이), NVARCHAR2(다국어지원), LONG(2BG 문자열), CLOB(4GB 문자열), NCLOB등이 제공됨(CHAR 제외한 나머지는 전부 가변길이)
    1) CHAR(n[BYTE|CHAR])
        - 고정길이 문자열 저장
        - 최대 2000BYTE까지 저장가능 (2000글자까지 쓸수있음(영자기준) , 한글의 경우 2000/3으로 나눈 글자까지밖에 저장안됨)
        - 'n[BYTE|CHAR]' : '[BYTE|CHAR]'이 생략되면 BYTE로 취급 
            'CHAR'은 n글자수까지 저장
        - 한글 한 글자는 3BYTE로 저장 
        - 기본키나 길이가 고정된 자료(주민번호, 우현번호)의 정당성을 확보하기위해 사용
사용예)
CREATE TABLE TEMP01(
    COL1 CHAR(10), -- BYTE가 DEFAULT로 취급됨
    COL2 CHAR(10 BYTE),
    COL3 CHAR(10CHAR)
);

INSERT INTO TEMP01 VALUES('대한(6BYITE)', '대한민', '대한민국');
-- 대한: 2글자 6바이트
-- 대한민 : 3글자 9바이트
-- 대한민국 : 4글자 12바이트

SELECT * FROM TEMP01;
SELECT  LENGTHB(COL1) AS COL1,
        LENGTHB(COL2) AS COL2,
        LENGTHB(COL3) AS COL3
FROM TEMP01;





2) VARCHAR2(n[BYTE|CHAR])
    - 가변길이 문자열 자료 저장 
    - 최대 4000BYTE까지 저장 가능 
    - VARCHAR, NVARCHAR2와 저장형식을 동일 
 
 사용예)
 CREATE TABLE TEMP02(
    COL1 CHAR(20),
    COL2 VARCHAR2(2000 BYTE),
    COL3 VARCHAR2(4000 CHAR)
 );
 
INSERT INTO TEMP02 VALUES('ILPOSTINO', 'BOYHOOD','무궁화 꽃이 피었습니다-김진명');
 
 SELECT * FROM TEMP02;
 
 SELECT LENGTHB(COL1) AS COL1,
        LENGTHB(COL2) AS COL2,
        LENGTHB(COL3) AS COL3,
        LENGTH(COL1) AS COL1,
        LENGTH(COL2) AS COL2,
        LENGTH(COL3) AS COL3
FROM TEMP02;
        
 
 
 
 
 
 
 
 
 
 
 
 3) LONG
    - 가변길이 문자열 자료 저장
    - 최대 2GB까지 저장 가능
    - 한 테이블에 한 컬럼만 LONG타입 사용 가능
    - 현재 기능 개선서비스 종료(8i) => CLOB로 UPGRADE
(사용형식)
    컬럼명 LONG 
        . LONG 타입으로 저장된 자료를 참조하기 위해 최소 31bit가 필요
        => 일부 기능(LENGTHB 등의 함수)이 제한
        . SELECT문의 SELECT절, UPGRADE의 SET절, INSERT문의 VALUES절에서 사용 가능 
        
(사용예)
CREATE TABLE TEMP03(
    COL1 VARCHAR2(2000),
    COL2 LONG
);

INSERT INTO TEMP03 VALUES('대전시 중구 계룡로 846', '대전시 중구 계룡로 846'); 


SELECT SUBSTR(COL1, 8, 3)
       --SUBSTR(COL2, 8, 3)
FROM TEMP03;

SELECT LENGTHB(COL2)
       --SUBSTR(COL2, 8, 3)
FROM TEMP03;



        
        
SELECT * FROM TEMP03;
 
 
 
 
 
 4) CLOB (Character Large Objects)
    - 대용량의 가변길이 문자열 저장
    - 최대 4GB까지 처리 가능 
    - 한 테이블에 복수개의 CLOB 타입 정의 가능 
    - 일부 기능은 DBMS_LOB API(Application Programming Interface)에서 제공하는 함수 사용
    (사용형식)
    컬럼명 CLOB 
    
    (사용예)
    CREATE TABLE TEMP04(
        COL1 VARCHAR2(255),
        COL2 CLOB,
        COL3 CLOB
    );
 
    INSERT INTO TEMP04 VALUES('APPLE BANANA PERSIMMON', 'APPLE BANANA PERSIMMON', 'APPLE BANANA PERSIMMON');

    SELECT * FROM TEMP04; 
    --사용자가 지정한 길이만큼만 제공하고 나머지는 전부 반납 
    
    SELECT SUBSTR(COL1, 7, 6) FROM TEMP04;
    -- TEMP04테이블에서 COL1 7번째 자리에서부터 6글자반환 
    
    SELECT SUBSTR(COL1, 7, 6) AS COL1,
            SUBSTR(COL3, 7, 6) AS COL3,
            -- LENGTHB(COL2) AS COL4,
            DBMS_LOB.GETLENGTH(COL2) AS COL4, -- 글자수 반환
            DBMS_LOB.SUBSTR(COL2, 7, 6) AS COL2
    FROM TEMP04;
    
    




