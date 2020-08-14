BEGIN;

-- CREATE FUNCTION "kullaniciguncelle()" -----------------------
CREATE OR REPLACE FUNCTION public.kullaniciguncelle()
 RETURNS TRIGGER
 LANGUAGE plpgsql
AS $function$
BEGIN
IF NEW.mail<>OLD.mail THEN
INSERT INTO guncellenen VALUES (old."bursiyerId",old.ad,old.soyad,old.mail,new.mail);
END IF;
RETURN NEW;
END;
$function$;
-- -------------------------------------------------------------

COMMIT;
