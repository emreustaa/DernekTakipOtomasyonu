BEGIN;

-- CREATE FUNCTION "kurucuguncelle()" --------------------------
CREATE OR REPLACE FUNCTION public.kurucuguncelle()
 RETURNS TRIGGER
 LANGUAGE plpgsql
AS $function$
BEGIN
IF NEW."vakifGorevi"<>OLD."vakifGorevi" THEN
INSERT INTO guncelkurucu VALUES (old."kurucuId",old.adi,old.soyadi,old."vakifGorevi",new."vakifGorevi");
END IF;
RETURN NEW;
END;
$function$;
-- -------------------------------------------------------------

COMMIT;
