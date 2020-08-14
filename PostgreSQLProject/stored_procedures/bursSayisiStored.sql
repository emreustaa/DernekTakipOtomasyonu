BEGIN;

-- CREATE FUNCTION "burssayisi()" ------------------------------
CREATE OR REPLACE FUNCTION public.burssayisi()
 RETURNS INTEGER
 LANGUAGE plpgsql
AS $function$
DECLARE 
toplam INTEGER;
BEGIN
SELECT count(*) INTO toplam FROM burs;
RETURN toplam;
END;
$function$;
-- -------------------------------------------------------------

COMMIT;
