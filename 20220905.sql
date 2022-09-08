사용예) 회원테이블에서 마일리지가 3000이상인 회원의 회원번호, 회원명, 직업, 마일리지로 뷰를 생성하시오

CREATE OR REPLACE VIEW V_MEM01(MID,MNAME, MJOB, MILE)
AS 
  SELECT MEM_ID, 
         MEM_NAME, 
         MEM_JOB, 
         MEM_MILEAGE
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000;
   



CREATE OR REPLACE VIEW V_MEM01
AS 
  SELECT MEM_ID AS 회원번호, 
         MEM_NAME AS 회원명, 
         MEM_JOB AS 직업, 
         MEM_MILEAGE AS  마일리지
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000;
   




CREATE OR REPLACE VIEW V_MEM01 (MID,MNAME, MJOB, MILE)
AS 
  SELECT MEM_ID AS 회원번호, 
         MEM_NAME AS 회원명, 
         MEM_JOB AS 직업, 
         MEM_MILEAGE AS  마일리지
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000;
   


CREATE OR REPLACE VIEW V_MEM01
AS 
  SELECT MEM_ID, 
         MEM_NAME, 
         MEM_JOB, 
         MEM_MILEAGE
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000;
   
   
   

SELECT * FROM V_MEM01;




*** V_MEM01에서 오철희회원(k001)의 마일리지를 2000으로 변경

UPDATE V_MEM01
   SET MEM_MILEAGE=2000
 WHERE MEM_ID ='k001';


*** MEMBER테이블에서 오철희회원(k001)의 마일리지를 5000으로 변경

UPDATE MEMBER 
   SET MEM_MILEAGE=5000
 WHERE MEM_ID='k001';


*** MEMBER테이블에서 모든 회원들의 마일리지를 1000씩 지급하시오

UPDATE MEMBER 
   SET MEM_MILEAGE = MEM_MILEAGE + 1000; -- 마일리지 = 현재마일리지값 + 1000
   
--원본테이블이 바뀌면 뷰는 자동으로 바뀜 
   
   
 ---------------------------------------------------------------------
 
 
 
 
CREATE OR REPLACE VIEW V_MEM01 (MID,MNAME, MJOB, MILE)
AS 
  SELECT MEM_ID, 
         MEM_NAME, 
         MEM_JOB, 
         MEM_MILEAGE
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000
   WITH READ ONLY; --읽기전용 뷰 생성(원본테이블 대상 아님, 아무리 뷰에서 READ ONLY한다 하더라도 원본테이블은 바뀜. 원본테이블바뀌면 뷰도 바뀜 -> 단 뷰자체는 update 못함)
   
   
 SELECT * FROM V_MEM01;  


** MEMBER 테이블에서 모든 회원의 마일리지를 1000씩 감소시키시오
UPDATE MEMBER 
   SET MEM_MILEAGE = MEM_MILEAGE - 1000;

SELECT * FROM V_MEM01;  
COMMIT;


** 뷰 V_MEM01의 자료에서 오철희 외원의 마일리지 ('k001')를 3700으로 변경
UPDATE V_MEM01
   SET MILE = 3700
 WHERE MID ='k001'; (X) -- 읽기전용으로 해놨기 때문에 오류 뜸
 
 
----------------------------------------------------------------------------------
 
(조건뷰여 뷰)
CREATE OR REPLACE VIEW V_MEM01 (MID,MNAME, MJOB, MILE)
AS 
  SELECT MEM_ID, 
         MEM_NAME, 
         MEM_JOB, 
         MEM_MILEAGE
    FROM MEMBER 
   WHERE MEM_MILEAGE>=3000
   WITH CHECK OPTION;

SELECT * FROM V_MEM01; 

** 뷰 V_MEM01에서 신용환회원('c001')의 마일리지를 5500으로 변경하시오. 
-- MEM_MILEAGE>=3000 조건을 위배하지 않았기 때문에 성공적으로 출력 
UPDATE V_MEM01
   SET MILE = 5500
 WHERE MID='c001';


** 뷰 V_MEM01에서 신용환회원('c001')의 마일리지를 1500으로 변경하시오. 
-- MEM_MILEAGE>=3000 조건을 위배했기 때문에 오류
UPDATE V_MEM01
   SET MILE = 1500
 WHERE MID='c001'; (X)
 
 
 UPDATE MEMBER
   SET MEM_MILEAGE = 1500
 WHERE MEM_ID='c001'; (o) --원본테이블은 언제든지 변경 가능하고 이것은 즉시 뷰에 반영됨
 

ROLLBACK;