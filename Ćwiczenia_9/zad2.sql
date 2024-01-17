-- A
BEGIN;
UPDATE production.product
SET listprice = listprice * 1.1
WHERE productid = 680;
COMMIT;

-- B
BEGIN;
DELETE FROM production.product
WHERE productid = 707;
ROLLBACK;


-- C
BEGIN;
INSERT INTO production.product 
(productid, name, productnumber, makeflag, finishedgoodsflag, safetystocklevel, reorderpoint, 
 standardcost, listprice, daystomanufacture, sellstartdate)
VALUES (1000, 'Adjustable Race', 'AR-5381', 'false', 'false', 1000, 750, 
        0, 0, 0, '2024-01-17 16:12:18.180037');
COMMIT;

