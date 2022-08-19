[함수]
1. 문자열함수 
    1) CONCAT : 문자열 결합
    SELECT  MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            CONCAT(CONCAT(MEM_REGNO1, '-'), MEM_REGNO2) AS 주민번호, --MEM_REGNO1과 -를 합치고, MEM_REGNO1-와 MEM_REGNO2를 합친다. => MEM_REGNO1-MEM_REGNO2
            -- MEM_REGNO1 ||'-'|| MEM_REGNO2 AS 주민번호
            MEM_JOB AS 직업
    FROM MEMBER;

    2) LOWER, UPPER, INITCAP : 대문자를 소문자로(LOWER), 소문자를 대문자로(UPPER), 단어의 첫글자를 대문자로(INITCAP)
    SELECT LOWER(EMAIL) || '@gamil.com' AS 이메일주소 -- 이메일 주소를 소문자로 변경후 @gamil.com붙여서 출력
    FROM HR.EMPLOYEES;

    3) LPAD, RPAD : 삽입 순서 - LPAD는 왼쪽부터, RPAD는 오른쪽부터
    SELECT LPAD('대전시 중구', 20, '*'), -- 20칸이 주어지고 문자열을 오른쪽에서부터 삽입, 나머지는 *로 채우기
           LPAD('대전시 중구', 20), -- 20칸이 주어지고 문자열을 오른쪽에서부터 삽입, 나머지는 공백으로 채우기
           RPAD('대전시 중구', 20, '*'),
           RPAD('대전시 중구' , 20)
    FROM DUAL; 
    
    4) LTRIM, RTRIM: 문자열 삭제 
    SELECT LTRIM('APPLE PERSIMMON BANANA', 'PPLE'), 
           LTRIM('   APPLE PERSIMMON BANANA') -- 공백삭제
    FROM DUAL;
    
    5) TRIM: 공백제거
    SELECT TRIM('     SAMPLE TEXT')
    FROM DUAL;
    
    6) SUBSTR: 문자 추출
    SELECT SUBSTR('ABCDEFGHIJK', 3, 5), -- 3번째부터 다섯개의 글자추출 
           SUBSTR('ABCDEFGHIJK', -3, 5) -- 뒤에서 세번째부터 다섯개의 글자 추축
    FROM DUAL; 
    
    7) REPLACE: 문자교체
    SELECT REPLACE('APPLE    PERSIMMON BANANA', 'A', '에이'), -- 모든 A를 에이로 변경
           REPLACE('APPLE    PERSIMMON BANANA', 'A') -- 모든 A삭제
    FROM DUAL;
    
    
2. 숫자함수 
    1) ABS, SIGN, POWER, SQRT 
    - ABS: 절대값 반환
    - SIGN : 양수면 1, 음수면 -1, 0이면 0
    - POWER : e의 n승 값
    - SQRT: n의 제곱근
    
    2) GREATEST, LEAST
    - GREATEST: 한 행(가로줄)으로 나열되어있는 값들 중 가장 큰 값, 
    - LEAST : 한 행(가로줄)으로 나열되어있는 값들 중 제일 작은 값 추출 
    
    SELECT GREATEST(100, 200, 300),
           LEAST(100, 200, 300)
    FROM DUAL;
    
    3) ROUND, TRUNC
    - ROUND: 반올림 
    - TRUNC: 버림
    SELECT ROUND(12345.678945, 3), -- 소수점 세번째 자리+1에서 반올림
           ROUND(12345.678945, -3) ???????????
    FROM DUAL;
    
    SELECT TRUNC(12345.678945, 3), -- 소수점 세번째 자리 + 1에서 그냥 삭제
           TRUNC(12345.678945), --6부터 그냥 삭제
           TRUNC(12345.678945, -3) -- 세번째 자리부터 그냥 0으로 대체 
    FROM DUAL;
    
    4) FLOOR, CEIL
    - FLOOR: n보다 작은 정수 (n=2745.675 반환: 2745)
    - CEIL: n보다 큰 정수 (n=2745.675 반환: 2746)

    SELECT FLOOR(23.456), FLOOR(23), FLOOR(-23.456),
           CEIL(23.456), CEIL(23), CEIL(-23.456)
    FROM DUAL;
    
    5) MOD, REMAINDER
    - MOD : 나머지 반환, n - b * FLOOR(n/b)
    - REMAINDER: 나머지의 크기가  b보다 작으면 그냥 반환하고, 크면 현재 값을 뺀 값 반환, n - b * ROUND(n/b)
    MOD(23,7) = 23 - (7 * FLOOR(23/7))
          = 23 - 7 * FLOOR(3.286)
					= 23 - 7 * 3
					= 2

    REMAINDER(23,7) = 23 - (7 * ROUND(23/7))
					= 23 - 7 * ROUND(3.286)
					= 23 - 7 * 3
					= 2

    6) WIDTH_BUCKET : b개의 구간으로 나눈 후 어느 구간에 속하는지 판단하는 거
    SELECT WIDTH_BUCKET(28, 10, 39, 3) -- 10부터 39까지 3개의 영역으로 나눴을 때 28은 몇 번째 구간에 속하는가
    FROM DUAL;
    

3. 날짜함수
    1) SYSDATE : 현재 날짜 및 시각정보 제공
    2) ADD_MONTHS : 주어진 날짜에 n만큼의 월을 더한 날짜 반환
    SELECT ADD_MONTHS(SYSDATE,2) --이번달에서 2를 더한 날짜 => 두달 후
    FROM DUAL; 
    
    3) NEXT_DAY
    SELECT NEXT_DAY(SYSDATE,'금요일') -- 오늘요일에서 그 다음 금요일
    FROM DUAL;
    
    
    
    
    
    
