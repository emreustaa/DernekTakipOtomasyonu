BEGIN;

-- CREATE FUNCTION "bursguncelle()" ----------------------------
CREATE OR REPLACE FUNCTION public.bursguncelle()
 RETURNS TRIGGER
 LANGUAGE plpgsql
AS $function$
BEGIN
IF NEW.tutar<>OLD.tutar THEN
INSERT INTO bursguncelle VALUES (old."bursId",old."verilmeTarihi",old."baslangicTarihi",old.tutar,new.tutar);
END IF;
RETURN NEW;
END;
$function$;
-- -------------------------------------------------------------

COMMIT;
