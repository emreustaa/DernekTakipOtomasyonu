BEGIN;

-- CREATE FUNCTION "kullanicisay()" ----------------------------
CREATE OR REPLACE FUNCTION public.kullanicisay()
 RETURNS INTEGER
 LANGUAGE plpgsql
AS $function$
DECLARE 
toplam INTEGER;
BEGIN
SELECT count(*) INTO toplam FROM kullanici;
RETURN toplam;
END;
$function$;
-- -------------------------------------------------------------

COMMIT;
