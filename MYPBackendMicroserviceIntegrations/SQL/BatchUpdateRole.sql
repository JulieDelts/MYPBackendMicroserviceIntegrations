CREATE OR REPLACE FUNCTION "BatchUpdateRole"(customer_ids uuid[], currencies int[])
RETURNS VOID AS 
$$
DECLARE 
    vip_status INT := 3;
    regular_status INT := 2;
BEGIN 

    UPDATE "Accounts" a
    SET "IsDeactivated" = FALSE
    FROM "Customers" c
    WHERE a."CustomerId" = c."Id"
      AND c."Id" = ANY(customer_ids)
      AND c."IsDeactivated" = FALSE
      AND c."Role" != vip_status
      AND a."Currency" = ANY(currencies);

    UPDATE "Customers" c
    SET "Role" = vip_status
    WHERE c."Id" = ANY(customer_ids)
      AND c."IsDeactivated" = FALSE
      AND c."Role" != vip_status; 

    UPDATE "Accounts" a
    SET "IsDeactivated" = TRUE
    FROM "Customers" c
    WHERE a."CustomerId" = c."Id"
      AND NOT (c."Id" = ANY(customer_ids))
      AND c."Role" = vip_status
      AND (c."CustomVipDueDate" IS NULL OR c."CustomVipDueDate" < NOW())
      AND a."Currency" = ANY(currencies);

    UPDATE "Customers" c
    SET "Role" = regular_status
    WHERE NOT (c."Id" = ANY(customer_ids))
      AND c."Role" = vip_status
      AND (c."CustomVipDueDate" IS NULL OR c."CustomVipDueDate" < NOW());

END;
$$
LANGUAGE plpgsql;