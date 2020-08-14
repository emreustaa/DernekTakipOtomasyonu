-- CREATE FUNCTION "burstoplam()" ------------------------------
CREATE OR REPLACE FUNCTION public.burstoplam()
 RETURNS INTEGER
 LANGUAGE plpgsql
AS $function$
DECLARE 
toplam INTEGER;
BEGIN
toplam = (SELECT SUM(burs.tutar) FROM burs);
RETURN toplam;
END;
$function$;