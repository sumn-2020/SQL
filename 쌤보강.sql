C  Cartessian product
E  Equi join
N  Non-equi join
O  Outer join
S  Self join


-- Cartessian product (12행 * 74행 = 888행)
SELECT *
FROM LPROD, PROD
WHERE LPROD_GU = PROD_LGU; -- 연결고리 


SELECT *
FROM CART, MEMBER, PROD
WHERE CART_MEMBER = MEM_ID -- CART와 MEMBER 합치기 
  AND PROD_ID = CART_PROD; --PROD와 CART,MEMBER 합쳐진테이블 다시 합치기 





--PROD : 어떤상품이 있는데,
--BUYER: 그 상품을 납품한 업체는?
--CART : 그 상품을 누가 장바구니에 담았는가?
-- MEMBER: 누가가 누가인가? 
-- 조인조건 갯수 = 테이블 개수 - 1



SELECT B.BUYER_ID, B.BUYER_NAME, 
       P.PROD_ID, P.PROD_NAME,
       C.CART_PROD, C.CART_MEMBER, C.CART_QTY,
       M.MEM_ID, M.MEM_NAME
FROM BUYER B, PROD P, CART C, MEMBER M
WHERE B.BUYER_ID = P.PROD_BUYER
 AND P.PROD_ID = C.CART_PROD
 AND M.MEM_ID = C.CART_MEMBER;
















--ANSI 표준

1) 쉼표없애기
SELECT B.BUYER_ID, B.BUYER_NAME, 
       P.PROD_ID, P.PROD_NAME,
       C.CART_PROD, C.CART_MEMBER, C.CART_QTY,
       M.MEM_ID, M.MEM_NAME
FROM BUYER B
     PROD P
     CART C 
     MEMBER M
WHERE B.BUYER_ID = P.PROD_BUYER
 AND P.PROD_ID = C.CART_PROD
 AND M.MEM_ID = C.CART_MEMBER;


2) 직접적으로 연결가능한 테이블들을 INNER JOIN으로 묶고 ON안에 조인조건 넣어주기 
SELECT B.BUYER_ID, B.BUYER_NAME, 
       P.PROD_ID, P.PROD_NAME,
       C.CART_PROD, C.CART_MEMBER, C.CART_QTY,
       M.MEM_ID, M.MEM_NAME
FROM BUYER B INNER JOIN PROD P ON(B.BUYER_ID = P.PROD_BUYER)    
     CART C 
     MEMBER M
WHERE 
 AND P.PROD_ID = C.CART_PROD
 AND M.MEM_ID = C.CART_MEMBER;



3) 뭉탱이와 그 다음 테이블 INNER JOIN 으로 묶어주기 
SELECT B.BUYER_ID, B.BUYER_NAME, 
       P.PROD_ID, P.PROD_NAME,
       C.CART_PROD, C.CART_MEMBER, C.CART_QTY,
       M.MEM_ID, M.MEM_NAME
FROM 뭉탱이 INNER JOIN CART C ON(P.PROD_ID = C.CART_PROD)
     MEMBER M
WHERE 
 AND 
 AND M.MEM_ID = C.CART_MEMBER;



4) 뭉탱이와 그 다음 테이블 INNER JOIN 으로 묶어주기 
SELECT B.BUYER_ID, B.BUYER_NAME, 
       P.PROD_ID, P.PROD_NAME,
       C.CART_PROD, C.CART_MEMBER, C.CART_QTY,
       M.MEM_ID, M.MEM_NAME
FROM BUYER B INNER JOIN PROD P ON(B.BUYER_ID = P.PROD_BUYER)    
             INNER JOIN CART C ON(P.PROD_ID = C.CART_PROD)
     MEMBER M
WHERE 
 AND 
 AND M.MEM_ID = C.CART_MEMBER;


5) 뭉탱이와 그 다음 테이블 INNER JOIN 으로 묶어주기 
SELECT B.BUYER_ID, B.BUYER_NAME, 
       P.PROD_ID, P.PROD_NAME,
       C.CART_PROD, C.CART_MEMBER, C.CART_QTY,
       M.MEM_ID, M.MEM_NAME
FROM 뭉탱이 INNER JOIN MEMBER M ON( M.MEM_ID = C.CART_MEMBER);


6) 완성
SELECT B.BUYER_ID, B.BUYER_NAME, 
       P.PROD_ID, P.PROD_NAME,
       C.CART_PROD, C.CART_MEMBER, C.CART_QTY,
       M.MEM_ID, M.MEM_NAME
FROM  BUYER B INNER JOIN PROD P ON(B.BUYER_ID = P.PROD_BUYER)    
             INNER JOIN CART C ON(P.PROD_ID = C.CART_PROD)
             INNER JOIN MEMBER M ON( M.MEM_ID = C.CART_MEMBER);



7)  일반조건 있으면 맨 하단에 추가 
SELECT B.BUYER_ID, B.BUYER_NAME, 
       P.PROD_ID, P.PROD_NAME,
       C.CART_PROD, C.CART_MEMBER, C.CART_QTY,
       M.MEM_ID, M.MEM_NAME
FROM  BUYER B INNER JOIN PROD P ON(B.BUYER_ID = P.PROD_BUYER)    
             INNER JOIN CART C ON(P.PROD_ID = C.CART_PROD)
             INNER JOIN MEMBER M ON( M.MEM_ID = C.CART_MEMBER)
WHERE PROD_NAME LIKE '%샤넬';
