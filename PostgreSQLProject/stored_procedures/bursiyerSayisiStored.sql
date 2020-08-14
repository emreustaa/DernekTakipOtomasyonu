BEGIN;

-- CREATE FUNCTION "bursiyersayisi()" --------------------------
CREATE OR REPLACE FUNCTION public.bursiyersayisi()
 RETURNS INTEGER
 LANGUAGE plpgsql
AS $function$
DECLARE 
toplam INTEGER;
BEGIN
SELECT count(*) INTO toplam FROM bursiyerler;
RETURN toplam;
END;
$function$;
-- -------------------------------------------------------------

COMMIT;
