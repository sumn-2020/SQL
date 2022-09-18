-- 진료과 테이블 생성
CREATE TABLE DEPARTMENT(
    DEPT_CODE VARCHAR2(11) NOT NULL,
    DEPT_NAME VARCHAR2(20)NOT NULL,
    DEPT_PHONE VARCHAR2(200),
    CONSTRAINT pk_dept PRIMARY KEY(DEPT_CODE)); 

-- 관리자 테이블 생성
CREATE TABLE ADMIN(
    ADMIN_CODE VARCHAR2(11) NOT NULL,
    ADMIN_NAME VARCHAR2(20) NOT NULL,
    ADMIN_ID VARCHAR2(11) NOT NULL,
    ADMIN_PW VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_admin PRIMARY KEY(ADMIN_CODE));

-- 공지사항 테이블 생성
CREATE TABLE NOTICE(
  NOTICE_CODE VARCHAR2(11) NOT NULL,
  NOTICE_SUB VARCHAR2(50) NOT NULL,
  NOTICE_NOTE VARCHAR2(200),
  NOTICE_DATE DATE NOT NULL,
  ADMIN_CODE VARCHAR2(11) NOT NULL,
  CONSTRAINT pk_notice PRIMARY KEY(NOTICE_CODE),
  CONSTRAINT fk_notice_admin FOREIGN KEY(ADMIN_CODE) REFERENCES ADMIN(ADMIN_CODE)); 

-- 환자 테이블 생성
CREATE TABLE PATIENT(
    PAT_CODE VARCHAR2(11) NOT NULL,
    PAT_NAME VARCHAR2(20) NOT NULL,
    PAT_ADDR VARCHAR2(200),
    PAT_PHONE VARCHAR2(11),
    PAT_REG NUMBER(7) NOT NULL,
    PAT_HIREDATE DATE DEFAULT SYSDATE,
    PAT_ID VARCHAR2(11) NOT NULL,
    PAT_PW VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_patient PRIMARY KEY(PAT_CODE));

-- 의사 테이블 생성
CREATE TABLE DOCTOR(
    DOC_CODE VARCHAR2(11) NOT NULL,
    DOC_NAME VARCHAR2(20) NOT NULL,
    DEPT_CODE VARCHAR2(11) NOT NULL,
    DOC_OFF VARCHAR2(30),
    DOC_LOCATION VARCHAR2(4) NOT NULL,
    DOC_ID VARCHAR2(11) NOT NULL,
    DOC_PW VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_doctor PRIMARY KEY(DOC_CODE),
    CONSTRAINT fk_doctor_dept FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_CODE));

-- 예약 테이블 생성
CREATE TABLE RESERVATION(
    RES_CODE VARCHAR2(11) NOT NULL,
    RES_DATE DATE NOT NULL,
    PAT_CODE VARCHAR2(11) NOT NULL,
    DOC_CODE VARCHAR2(11) NOT NULL,
    RES_MEMO VARCHAR2(200),
    CONSTRAINT pk_res PRIMARY KEY(RES_CODE),
    CONSTRAINT fk_res_patient FOREIGN KEY(PAT_CODE) REFERENCES PATIENT(PAT_CODE),
    CONSTRAINT fk_res_doctor FOREIGN KEY(DOC_CODE) REFERENCES DOCTOR(DOC_CODE));
    
-- 문의 테이블 생성  
CREATE TABLE QNA(
  QNA_CODE VARCHAR2(11) NOT NULL,
  QNA_SUB VARCHAR2(20) NOT NULL,
  QNA_NOTE VARCHAR2(200),
  QNA_DATE DATE NOT NULL,
  PAT_CODE VARCHAR2(11) NOT NULL,
  CONSTRAINT pk_qna PRIMARY KEY(QNA_CODE),
  CONSTRAINT fk_qna_admin FOREIGN KEY(PAT_CODE) REFERENCES PATIENT(PAT_CODE));
  
-- 답변 테이블 생성
CREATE TABLE REPLY(
    QNA_CODE VARCHAR2(11) NOT NULL,
    REPLY_NOTE VARCHAR2(200) NOT NULL,
    REPLY_DATE DATE NOT NULL,
    ADMIN_CODE VARCHAR2(11) NOT NULL,
    CONSTRAINT pk_reply PRIMARY KEY(QNA_CODE),
    CONSTRAINT fk_reply_admin FOREIGN KEY(ADMIN_CODE) REFERENCES ADMIN(ADMIN_CODE));

-- 관리자 데이터 입력
INSERT INTO ADMIN VALUES('A001', '민선이', 'amsi', 'amsipwtest');
INSERT INTO ADMIN VALUES('A002', '양순치', 'aysc', 'ayscpwtest');
INSERT INTO ADMIN VALUES('A003', '김말희', 'akmh', 'akmhpwtest');
    
-- 진료과 데이터 입력
INSERT INTO DEPARTMENT VALUES('C001', '내과', '042-223-0001');
INSERT INTO DEPARTMENT VALUES('C002', '외과', '042-223-0002');
INSERT INTO DEPARTMENT VALUES('C003', '신경과', '042-223-0003');
INSERT INTO DEPARTMENT VALUES('C004', '안과', '042-223-0004');
INSERT INTO DEPARTMENT VALUES('C005', '피부과', '042-223-0005');

-- 의사 데이터 입력
INSERT INTO DOCTOR VALUES('D001', '홍재범', 'C001', '월요일', 'F101', 'dhjb', 'dhjbpwtest');
INSERT INTO DOCTOR VALUES('D002', '배요한', 'C001', '화요일', 'F102', 'dbyh', 'dbyhpwtest');
INSERT INTO DOCTOR VALUES('D003', '심현승', 'C001', '수요일', 'F103', 'dshs', 'dshspwtest');
INSERT INTO DOCTOR VALUES('D004', '복병헌', 'C001', '목요일', 'F104', 'dbbh', 'dbbhpwtest');
INSERT INTO DOCTOR VALUES('D005', '남승헌', 'C001', '금요일', 'F105', 'dnsh', 'dnshpwtest');
INSERT INTO DOCTOR VALUES('D006', '홍현승', 'C002', '월요일', 'F201', 'dhhs', 'dhhspwtest');
INSERT INTO DOCTOR VALUES('D007', '강오성', 'C002', '화요일', 'F202', 'dkos', 'dkospwtest');
INSERT INTO DOCTOR VALUES('D008', '문이수', 'C002', '수요일', 'F203', 'dmis', 'dmispwtest');
INSERT INTO DOCTOR VALUES('D009', '최덕수', 'C002', '목요일', 'F204', 'dcds', 'dcdspwtest');
INSERT INTO DOCTOR VALUES('D010', '안동건', 'C002', '금요일', 'F205', 'dadg', 'dadgpwtest');
INSERT INTO DOCTOR VALUES('D011', '김경택', 'C003', '월요일', 'F301', 'dkkt', 'dkktpwtest');
INSERT INTO DOCTOR VALUES('D012', '류요한', 'C003', '화요일', 'F302', 'dryh', 'dryhpwtest');
INSERT INTO DOCTOR VALUES('D013', '예재범', 'C003', '수요일', 'F303', 'dyjb', 'dyjbpwtest');
INSERT INTO DOCTOR VALUES('D014', '정무열', 'C003', '목요일', 'F304', 'djmy', 'djmypwtest');
INSERT INTO DOCTOR VALUES('D015', '장이수', 'C003', '금요일', 'F305', 'djis', 'djispwtest');
INSERT INTO DOCTOR VALUES('D016', '성경택', 'C004', '월요일', 'F401', 'dskt', 'dsktpwtest');
INSERT INTO DOCTOR VALUES('D017', '설요한', 'C004', '화요일', 'F402', 'dsyh', 'dsyhpwtest');
INSERT INTO DOCTOR VALUES('D018', '손동건', 'C004', '수요일', 'F403', 'dsdg', 'dsdgpwtest');
INSERT INTO DOCTOR VALUES('D019', '문이경', 'C004', '목요일', 'F404', 'dmik', 'dmikpwtest');
INSERT INTO DOCTOR VALUES('D020', '양미래', 'C004', '금요일', 'F405', 'dymr', 'dymrpwtest');
INSERT INTO DOCTOR VALUES('D021', '한이경', 'C005', '월요일', 'F501', 'dhik', 'dhikpwtest');
INSERT INTO DOCTOR VALUES('D022', '손은채', 'C005', '화요일', 'F502', 'dsec', 'dsecpwtest');
INSERT INTO DOCTOR VALUES('D023', '문자경', 'C005', '수요일', 'F503', 'dmjk', 'dmjkpwtest');
INSERT INTO DOCTOR VALUES('D024', '임혜림', 'C005', '목요일', 'F504', 'dlhl', 'dlhlpwtest');
INSERT INTO DOCTOR VALUES('D025', '양영신', 'C005', '금요일', 'F505', 'dyys', 'dyyspwtest');

COMMIT;    