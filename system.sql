2022-0801-01)����� ���� �� ���� ����
1)����� ����
    - CREATE USER ��� ��� 
    (�������)
    CREATE USER ����ڸ�  IDENTIFIED BY ��ȣ;
    
    CREATE USER JHS IDENTIFIED BY java; 
    
2)���Ѻο�
    - GRANT ��ɻ��
    (�������)
    GRANT ���Ѹ�[,���Ѹ�,...] TO ����ڸ�;
    . ���Ѹ� : CONNECT, RESOURCE, DBA ���� �ַ� ��� 
    
   GRANT CONNECT,RESOURCE,DBA TO JHS; 
   
 3) HR ���� Ȱ��ȭ 
     - AlTER ��� ����Ͽ� Ȱ��ȭ �� ��ȣ ����
     
     
 ALTER USER HR ACCOUNT UNLOCK; 
 ALTER USER HR IDENTIFIED BY java;
 



CREATE USER ABCDS IDENTIFIED BY java;
GRANT CONNECT,RESOURCE,DBA TO ABCDS; 


CREATE USER CCC IDENTITIED BY java;
GRANT CONNECT, RESOURCE, DBA TO CCC;
    