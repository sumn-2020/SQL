2022-0805-02) �����ڷ��� 
- ������ �Ǽ� ����
- NUMBERŸ�� ����
(�������)
    NUMBER [(���е�|* [,������])]
        - ���� ǥ�� ����: 10e-130 ~ 9.999 ... 9e125
        - ���е�: ��ü �ڸ���(1-38)
        - ������ : �Ҽ��� ������ �ڸ��� 
        - '*'�� 38�ڸ� �̳����� ����ڰ� �Է��� �����͸� ������ �� �ִ� ������ �������� �ý����� ����
        - ������ �Ҽ��� ���� '������ ' + 1��° �ڸ����� �ݿø��Ͽ� '������'�ڸ����� ����(�������� ����ΰ��) 
          '������'�� �����̸� �����κ� '������'�ڸ����� �ݿø��Ͽ� ���� 
          
          ..
          
(���忹)
--------------------------------------------------------------------------------------
����             �Է°�              ��������  
--------------------------------------------------------------------------------------
NUMBER          12345.6789         12345.6789      -- �״�� ����Ǿ� �� 
NUMBER(*, 2)    12345.6789         12345.68        -- �Ҽ��� ����° �ڸ����� �ݿø��Ͽ� �Ҽ��� 2��° �ڸ����� ��Ÿ����
NUMBER(6, 2)    12345.6789         ����              
NUMBER(7, 2)    12345.6789         12345.68
NUMBER(8, 0)    12345.6789         12346           -- �Ҽ��� ù°�ڸ����� �ݿø�
NUMBER(6)       12345.6789         12346           -- �������� �����Ǿ����� 0�� ���ɷ� ����
NUMBER(6, -2)   12345.6789         12300           -- �Ҽ��� ���� ���� (�����κи� 6�ڸ�) 4���� �ݿø��ؾߵǴµ� 4�ϱ� �ݿø� ����


CREATE TABLE TEMP05(
    COL1 NUMBER,
    COL2 NUMBER(*,2),
    COL3 NUMBER(6, 2),
    COL4 NUMBER(7, 2),
    COL5 NUMBER(8, 0),
    COL6 NUMBER(6),
    COL7 NUMBER(6, -2)
);



INSERT INTO TEMP05 VALUES(12345.6789, 12345.6789, 12345.6789, 12345.6789, 12345.6789, 12345.6789, 12345.6789); -- ���� ������ �������� ū���� ���ͼ� ���� �� 
 
INSERT INTO TEMP05 VALUES(12345.6789, 12345.6789, 2345.6789, 12345.6789, 12345.6789, 12345.6789, 12345.6789);
SELECT * FROM TEMP05;




** ���е�<�������� ���
- ���е� : �Ҽ��� ���Ͽ��� 0�� �ƴ� �Ϲݼ����� ����
- ������ : �Ҽ��� ������ �ڸ��� 
- [������ - ���е�] : �Ҽ��� ���Ͽ��� �����ؾ��� 0�� ���� 

---------------------------------------------
�Է°�           ����              ����� �� 
---------------------------------------------
1234.5678       NUMBER(2,4)      ����
0.12            NUMBER(3,5)      ���� 
0.003456        NUMBER(2,4)      0.0035
0.0345678       NUMBER(2,3)      0.035








    
    
    .
    
    
    
    .
    
