BEGIN;

-- CREATE FUNCTION "demirbasguncelle()" ------------------------
CREATE OR REPLACE FUNCTION public.demirbasguncelle()
 RETURNS TRIGGER
 LANGUAGE plpgsql
AS $function$
BEGIN
IF NEW.tur<>OLD.tur THEN
INSERT INTO demirbasguncelle VALUES (old."demirbasId",old.tur,new.tur);
END IF;
RETURN NEW;
END;
$function$;
-- -------------------------------------------------------------

COMMIT;
