BEGIN;

-- CREATE FUNCTION "bursekle( int4,  varchar,  varchar,  varchar,  int4 )" 
CREATE OR REPLACE FUNCTION public.bursekle(tutar INTEGER, verilmetarihi CHARACTER VARYING, baslangictarihi CHARACTER VARYING, bitistarihi CHARACTER VARYING, bursiyer INTEGER)
 RETURNS CHARACTER VARYING
 LANGUAGE plpgsql
AS $function$
DECLARE
BEGIN
INSERT INTO burs(tutar,"verilmeTarihi","baslangicTarihi","bitisTarihi",bursiyer) VALUES (tutar,verilmeTarihi,baslangicTarihi,bitisTarihi,bursiyer);

RETURN 'başarıyla eklendi';
END;
$function$;
-- -------------------------------------------------------------

COMMIT;
