CREATE OR REPLACE FUNCTION "BatchUpdateRole"(customer_ids uuid[], currencies int[])
RETURNS VOID AS 
$$

DECLARE 

vip_status INT := 3;
regular_status INT := 2;

BEGIN 

UPDATE  "Accounts"
SET "IsDeactivated" = FALSE
WHERE "CustomerId" IN (
 SELECT "Id" FROM "Customers"
    WHERE "Id" = ANY(customer_ids)
      AND "IsDeactivated" = FALSE
      AND "Role" != vip_status)
AND "Currency" = ANY(currencies);

UPDATE "Customers"
SET "Role" = vip_status
WHERE "Id"  = ANY(customer_ids)
AND "IsDeactivated" = FALSE
AND "Role" != vip_status; 

UPDATE "Accounts"
SET "IsDeactivated" = TRUE
WHERE "CustomerId" IN (SELECT "Id" FROM  "Customers"
WHERE NOT ("Id" = ANY(customer_ids))
AND "Role" = vip_status
AND ("CustomVipDueDate" IS NULL OR "CustomVipDueDate" < NOW()))
AND "Currency" = ANY(currencies);

UPDATE "Customers"
SET "Role" = regular_status
WHERE "Id" IN ( 
SELECT "Id" FROM "Customers"
WHERE NOT ("Id" = ANY(customer_ids))
AND "Role" = vip_status
AND ("CustomVipDueDate" IS NULL
OR "CustomVipDueDate" < NOW()));

END;
$$
LANGUAGE plpgsql;