
------------------------------------------------------------------------
의사컬럼                        의미
------------------------------------------------------------------------
시퀀스명.NEXTVAL               '시퀀스' 객체의 다음 값 반환 
시퀀스명.CURVAL                '시퀀스' 객체의 현재 값 반환 

** 시퀀스 생성 후 반드시 '시퀀스명.NEXTVAL' 명령이 1번이상, 맨 처음으로 수행되어야 함


사용예) 분류테이블에서 LPROD_ID값을 시퀀스로 구하여 다음 자료를 입력하시오
----------------------------
분류코드     분류명
----------------------------
p501       농산물
p502       수산물
p503       임산물

CREATE SEQUENCE SEQ_LPROD_ID
  START WITH 10;
  
INSERT INTO LPROD(LPROD_ID, LPROD_GU,LPROD_NM) 
VALUES(SEQ_LPROD_ID.NEXTVAL, 'P501', '농산물');

  
INSERT INTO LPROD(LPROD_ID, LPROD_GU,LPROD_NM) 
VALUES(SEQ_LPROD_ID.NEXTVAL, 'P502', '수산물');

INSERT INTO LPROD(LPROD_ID, LPROD_GU,LPROD_NM) 
VALUES(SEQ_LPROD_ID.NEXTVAL, 'P503', '임산물');

SELECT * FROM LPROD;
  
SELECT SEQ_LPROD_ID.CURRVAL FROM DUAL; -- 오류뜸
SELECT SEQ_LPROD_ID.NEXTVAL FROM DUAL;













