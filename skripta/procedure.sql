SET SERVEROUTPUT ON

DROP PROCEDURE unos_azuriranje_parcela;
DROP PROCEDURE dostupnost_parcela;
DROP PROCEDURE rezerviranje;
DROP PROCEDURE gost_prijava;
DROP PROCEDURE unos_azuriranje_ponude;
DROP PROCEDURE unos_troskovi;
DROP PROCEDURE izdavanje_racuna;
DROP PROCEDURE placanje_racuna;


DROP SEQUENCE brojevi_u;
DROP SEQUENCE brojevi_r;
DROP SEQUENCE brojevi_g;
DROP SEQUENCE brojevi_t;
DROP SEQUENCE brojevi_tt;
DROP SEQUENCE brojevi_ra;

DROP INDEX i_br_rezervacije;
DROP INDEX i_datum;

				----------------------------------PROCEDURE--------------------------------------

--unos i azuriranje parcele ----------------------------------

CREATE PROCEDURE unos_azuriranje_parcela(
	p_br_parcele IN parcela.br_parcele%TYPE,
	p_vrsta_parcele IN parcela.vrsta_parcele%TYPE,
	p_opis_parcele IN parcela.opis_parcele%TYPE 
)
AS
	p_count number;
BEGIN
	SELECT COUNT(*)
	INTO p_count
	FROM parcela
	WHERE br_parcele = p_br_parcele;

	IF p_count = 0 THEN
		IF p_vrsta_parcele IS NOT NULL THEN
            INSERT INTO parcela(br_parcele, vrsta_parcele, opis_parcele) VALUES(p_br_parcele, p_vrsta_parcele, p_opis_parcele);
			COMMIT;
		ELSE
            DBMS_OUTPUT.PUT_LINE('Niste unijeli obavezne argumente za unos nove parcele.');
        END IF;
	ELSIF p_count = 1 THEN
		IF p_vrsta_parcele IS NOT NULL  AND p_opis_parcele IS NOT NULL THEN
			UPDATE parcela
			SET parcela.vrsta_parcele = p_vrsta_parcele, parcela.opis_parcele = p_opis_parcele
			WHERE br_parcele = p_br_parcele;
		ELSIF p_vrsta_parcele IS NOT NULL AND p_opis_parcele IS NULL THEN
			UPDATE parcela
			SET parcela.vrsta_parcele = p_vrsta_parcele
			WHERE br_parcele = p_br_parcele;
		ELSIF p_vrsta_parcele IS NULL AND p_opis_parcele IS NOT NULL THEN
			UPDATE parcela
			SET parcela.opis_parcele = p_opis_parcele
			WHERE br_parcele = p_br_parcele;
		ELSE
            DBMS_OUTPUT.PUT_LINE('Pogreska.');
        END IF;
		COMMIT;
	END IF;
END unos_azuriranje_parcela;
/

--dostpunost parcele na odredeni datum i prema vrsti------------------------------------------

CREATE PROCEDURE dostupnost_parcela(
    p_vrsta IN parcela.vrsta_parcele%TYPE,
    p_datum_prijave IN rezervacija.prijava%TYPE,
    p_datum_odjave IN rezervacija.prijava%TYPE
)
AS
BEGIN 
	IF (p_vrsta = 'sator' OR p_vrsta = 'kamp kucica' OR p_vrsta = 'kamp prikolica') AND p_datum_prijave < p_datum_odjave THEN
		
		DECLARE 
            c_br_parcele parcela.br_parcele%TYPE;            
            c_vrsta_parcele parcela.vrsta_parcele%TYPE;
            c_opis_parcele parcela.opis_parcele%TYPE;
        
	        CURSOR printaj_parcele IS
				SELECT *
		        FROM parcela pa
				WHERE vrsta_parcele = p_vrsta AND br_parcele NOT IN (
		    		SELECT br_parcele 
		    		FROM rezervacija
		     		WHERE br_parcele = pa.br_parcele AND p_datum_prijave < odjava AND p_datum_odjave > prijava);
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Dostupne parcele su: ');
        	OPEN printaj_parcele;

        	LOOP
	         	FETCH printaj_parcele
	        	INTO c_br_parcele, c_vrsta_parcele, c_opis_parcele;
	        	EXIT WHEN printaj_parcele%NOTFOUND;
	        	DBMS_OUTPUT.PUT_LINE(c_br_parcele || ' ' || c_vrsta_parcele || ' ' || c_opis_parcele);
			END LOOP;

			CLOSE printaj_parcele;
		END;

    ELSIF p_datum_prijave > p_datum_odjave THEN
        DBMS_OUTPUT.PUT_LINE('Datum prijave mora biti prije datuma odjave!');
	ELSE 
		DBMS_OUTPUT.PUT_LINE('Pogresan unos za vrstu. Vrsta  moze biti sator, kamp kucica ili kamp prikolica.');
	END IF;
END dostupnost_parcela;
/

--unos rezervacije----------------------------------------------

--niz brojeva za broj rezervacije
CREATE SEQUENCE brojevi_r
	START WITH 10000
	INCREMENT BY 1;

--niz brojeva za ID unajmljivaca
CREATE SEQUENCE brojevi_u
	START WITH 1
	INCREMENT BY 1;



CREATE PROCEDURE rezerviranje(
	p_ime IN unajmljivac.ime%TYPE,
	p_prezime IN unajmljivac.prezime%TYPE,
	p_telefon IN unajmljivac.telefon%TYPE,
	p_email IN unajmljivac.email%TYPE,
	p_br_parcele IN parcela.br_parcele%TYPE,
	p_prijava IN rezervacija.prijava%TYPE,
	p_odjava IN rezervacija.odjava%TYPE,
	p_osobe IN rezervacija.osobe%TYPE,
	p_kucni_ljubimci IN rezervacija.kucni_ljubimci%TYPE,
	p_napomena IN rezervacija.napomena%TYPE
)
AS
	p_unajmljivac_id varchar(20);
	p_count number;
	p_count_unajmljivac number;
	p_br_rez varchar(20);
BEGIN
	
	IF p_prijava < p_odjava THEN
		SELECT COUNT(*)
		INTO p_count
		FROM (	SELECT br_parcele FROM parcela pa
				WHERE br_parcele NOT IN
	    			(SELECT br_parcele FROM rezervacija r
	     			 WHERE br_parcele = pa.br_parcele AND p_prijava < r.odjava AND p_odjava > r.prijava))
	    WHERE br_parcele = p_br_parcele;

	    IF p_count = 1 THEN
            
            SELECT COUNT(*)
    		INTO p_count_unajmljivac
    		FROM unajmljivac
    		WHERE ime = p_ime AND prezime = p_prezime AND telefon = p_telefon AND email = p_email;
            
            IF p_count_unajmljivac = 1 THEN 
	    		SELECT unajmljivac_id
	    		INTO p_unajmljivac_id
	    		FROM unajmljivac
	    		WHERE ime = p_ime AND prezime = p_prezime AND telefon = p_telefon AND email = p_email;    		
            ELSE 
				SELECT CONCAT('U', brojevi_u.nextval)
    			INTO p_unajmljivac_id
				FROM DUAL;

				INSERT INTO unajmljivac(unajmljivac_id, ime, prezime, telefon, email) VALUES(p_unajmljivac_id, p_ime, p_prezime, p_telefon, p_email);
                COMMIT;
			END IF;

			SELECT CONCAT('R', brojevi_r.nextval)
    			INTO p_br_rez
				FROM DUAL;

    		INSERT INTO rezervacija(br_rezervacije, prijava, odjava, osobe, kucni_ljubimci, napomena, br_parcele, unajmljivac_id) VALUES(p_br_rez, p_prijava, p_odjava, p_osobe, p_kucni_ljubimci, p_napomena, p_br_parcele, p_unajmljivac_id);
    		COMMIT;
        ELSE
        	DBMS_OUTPUT.PUT_LINE('Parcela ' || p_br_parcele || ' nije dostupna u trazenom razdoblju');
        END IF;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Datum odjave mora biti nakon datuma prijave!');
	END IF;    
END rezerviranje;
/

-----------------------------Prijava gosstiju---------------------------------------------

--niz brojeva za ID gosta
CREATE SEQUENCE brojevi_g
	START WITH 100
	INCREMENT BY 1;

CREATE PROCEDURE gost_prijava(
	p_ime IN prijava.ime%TYPE,
	p_prezime IN prijava.prezime%TYPE,
	p_broj_dokumenta IN prijava.broj_dokumenta%TYPE,
	p_datum_rodenja IN prijava.datum_rodenja%TYPE,
	p_br_rezervacije  IN prijava.br_rezervacije%TYPE
)
AS
	p_count_rezervacija number;
	p_count_osobe number;
	p_br_osoba number;
	p_g_id varchar(20);
BEGIN
	SELECT COUNT(*)
	INTO p_count_rezervacija
	FROM rezervacija
	WHERE br_rezervacije = p_br_rezervacije;

	IF p_count_rezervacija = 1 THEN

		SELECT COUNT(*)
		INTO p_count_osobe
		FROM prijava	
		WHERE br_rezervacije = p_br_rezervacije;

		SELECT osobe 
		INTO p_br_osoba
		FROM rezervacija
		WHERE br_rezervacije = p_br_rezervacije;

		IF p_count_osobe < p_br_osoba THEN
			SELECT CONCAT('G', brojevi_g.nextval)
    			INTO p_g_id
				FROM DUAL;

			INSERT INTO prijava(gost_id, ime, prezime, broj_dokumenta, datum_rodenja, br_rezervacije) 
			VALUES(p_g_id, p_ime, p_prezime, p_broj_dokumenta, p_datum_rodenja, p_br_rezervacije);
            COMMIT;
		ELSE 
			DBMS_OUTPUT.PUT_LINE('Vec su unesene sve osobe za rezervaciju broj ' || p_br_rezervacije);

		END IF;
	ELSE
	    DBMS_OUTPUT.PUT_LINE('Ne postoji rezervacija s brojem ' || p_br_rezervacije);
	END  IF;
END gost_prijava;
/

--unos azuriranje ponude----------------------------------------------------
CREATE PROCEDURE unos_azuriranje_ponude(
	p_naziv_usluge IN ponuda_cjenik.naziv_usluge%TYPE,
	p_cijena_sezona IN ponuda_cjenik.naziv_usluge%TYPE,
	p_cijena_van_sezone IN ponuda_cjenik.naziv_usluge%TYPE,
	p_opis IN ponuda_cjenik.naziv_usluge%TYPE
)
AS
	p_count number;
BEGIN
	SELECT COUNT(*)
	INTO p_count
	FROM ponuda_cjenik
	WHERE naziv_usluge = p_naziv_usluge;

	IF p_naziv_usluge IS NOT NULL THEN 
		IF p_count = 0 THEN
            IF   p_cijena_sezona IS NOT NULL  AND p_cijena_van_sezone IS NOT NULL THEN
                INSERT INTO ponuda_cjenik(naziv_usluge, cijena_sezona, cijena_van_sezone, opis)
                VALUES(p_naziv_usluge, p_cijena_sezona, p_cijena_van_sezone, p_opis);
                COMMIT;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Za unos nove usluge potrebno je unijeti cijenu u sezoni i cijenu van sezone.');
            END IF;
		ELSE
			IF p_cijena_sezona IS NOT NULL THEN
				UPDATE ponuda_cjenik
				SET cijena_sezona = p_cijena_sezona
				WHERE naziv_usluge = p_naziv_usluge;
            END IF;
			IF p_cijena_van_sezone IS NOT NULL THEN
				UPDATE ponuda_cjenik
				SET cijena_van_sezone = p_cijena_van_sezone
				WHERE naziv_usluge = p_naziv_usluge;
			END IF;
            IF p_opis IS NOT NULL THEN
				UPDATE ponuda_cjenik
				SET opis = p_opis
				WHERE naziv_usluge = p_naziv_usluge;
			END IF;
            COMMIT;
		END IF;
	ELSE 
		DBMS_OUTPUT.PUT_LINE('Potrebno je unijet naziv usluge kako bi unijeli novu uslugu ili kako bi azurirali postojecu.');
	END IF;
END unos_azuriranje_ponude;	
/


--troskovi unos-----------------------------------------------------------------------------------------------------

--niz borjeva za ID troska
CREATE SEQUENCE brojevi_t
	START WITH 1
	INCREMENT BY 1;

CREATE PROCEDURE unos_troskovi(
	p_datum IN troskovi.datum%TYPE,
	p_naziv_usluge IN troskovi.naziv_usluge%TYPE,
	p_kolicina IN troskovi.kolicina%TYPE,
	p_br_rezervacije IN troskovi.br_rezervacije%TYPE
)
AS
	p_trosak_id varchar(20);
	p_count number;
    p_count_rez number;
BEGIN 
	SELECT COUNT(*)
	INTO p_count
	FROM ponuda_cjenik
	WHERE naziv_usluge = p_naziv_usluge;
    
    SELECT COUNT(*)
	INTO p_count_rez
	FROM rezervacija
	WHERE br_rezervacije = p_br_rezervacije AND prijava <= p_datum AND odjava >= p_datum;

	IF p_count = 1 AND p_count_rez = 1 THEN
		SELECT CONCAT('T', brojevi_t.nextval)
    	INTO p_trosak_id
		FROM DUAL;

		INSERT INTO troskovi(trosak_id, datum, naziv_usluge, kolicina, br_rezervacije)
		VALUES(p_trosak_id, p_datum, p_naziv_usluge, p_kolicina, p_br_rezervacije);
		COMMIT;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Niste unijeli dobar naziv usluge ili dobar datum');
	END IF;
END unos_troskovi;		
/


--IZDAVANJE RACUNA----------------------------------------------------------------------

--niz brojeva za ID troskova koje povlacimo iz rezervacije
CREATE SEQUENCE brojevi_tt
	START WITH 1
	INCREMENT BY 1;

--niz brojeva za broj racuna
CREATE SEQUENCE brojevi_ra
	START WITH 100
	INCREMENT BY 1;

CREATE PROCEDURE izdavanje_racuna(
    p_br_rezervacije IN rezervacija.br_rezervacije%TYPE
)
AS
    p_trosak number(7,2);
    p_count_rez number;
    br_odraslih number;
    br_djece number;
    p_datum_prijave date;
    p_br_dana number;
    p_br_ljubimci number;
    p_parcela varchar(20);
    p_count_ra number;
BEGIN
    
    SELECT COUNT(*)
    INTO p_count_rez
    FROM rezervacija
    WHERE br_rezervacije = p_br_rezervacije;

    SELECT COUNT(*)
    INTO p_count_ra
    FROM racuni
    WHERE br_rezervacije = p_br_rezervacije;

    
    IF p_count_rez=1 AND p_count_ra = 0 THEN     
        SELECT prijava
        INTO p_datum_prijave
        FROM rezervacija
        WHERE br_rezervacije = p_br_rezervacije;
        
        SELECT odjava-prijava
        INTO p_br_dana
        FROM rezervacija
        WHERE br_rezervacije = p_br_rezervacije;
        
        SELECT COUNT(*)
        INTO p_br_ljubimci
        FROM rezervacija
        WHERE br_rezervacije = p_br_rezervacije;
        
        SELECT vrsta_parcele
        INTO p_parcela
        FROM parcela pa
        JOIN rezervacija re USING(br_parcele)
        WHERE br_rezervacije = p_br_rezervacije;
            
        SELECT COUNT(*)
        INTO br_odraslih
        FROM prijava
        WHERE br_rezervacije = p_br_rezervacije AND
            (SELECT ROUND(dob, 0)
                FROM (SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, datum_rodenja))/12 as dob
                FROM DUAL)) > 18;
        
        SELECT COUNT(*)
        INTO br_djece
        FROM prijava
        WHERE br_rezervacije = p_br_rezervacije AND
            (SELECT ROUND(dob, 0)
                FROM (SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, datum_rodenja))/12 as dob
                FROM DUAL)) < 18 AND (SELECT ROUND(dob, 0)
                FROM (SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, datum_rodenja))/12 as dob
                FROM DUAL))>2;
            
            IF br_odraslih > 0 THEN
                INSERT INTO troskovi(trosak_id, datum, naziv_usluge, kolicina, br_rezervacije) VALUES(CONCAT('TT', brojevi_tt.nextval),p_datum_prijave, 'odrasli nocenje', br_odraslih*p_br_dana, p_br_rezervacije);
                INSERT INTO troskovi(trosak_id, datum, naziv_usluge, kolicina, br_rezervacije) VALUES(CONCAT('TT', brojevi_tt.nextval),p_datum_prijave, 'pristojba odrasli', br_odraslih*p_br_dana, p_br_rezervacije);
            END IF;
            IF br_djece > 0 THEN
                INSERT INTO troskovi(trosak_id, datum, naziv_usluge, kolicina, br_rezervacije) VALUES(CONCAT('TT', brojevi_tt.nextval),p_datum_prijave, 'djeca nocenje', br_djece*p_br_dana, p_br_rezervacije);
                INSERT INTO troskovi(trosak_id, datum, naziv_usluge, kolicina, br_rezervacije) VALUES(CONCAT('TT', brojevi_tt.nextval),p_datum_prijave, 'pristojba djeca', br_djece*p_br_dana, p_br_rezervacije);
            END IF;
            IF p_br_ljubimci > 0 THEN 
                INSERT INTO troskovi(trosak_id, datum, naziv_usluge, kolicina, br_rezervacije) VALUES(CONCAT('TT', brojevi_tt.nextval),p_datum_prijave, 'kucni ljubimac', p_br_ljubimci*p_br_dana, p_br_rezervacije);
            END IF;
            
            INSERT INTO troskovi(trosak_id, datum, naziv_usluge, kolicina, br_rezervacije) VALUES(CONCAT('TT', brojevi_tt.nextval),p_datum_prijave, p_parcela , p_br_dana, p_br_rezervacije);
            COMMIT;
        
        IF EXTRACT(MONTH FROM p_datum_prijave)>=6 AND   EXTRACT(MONTH FROM p_datum_prijave)<=8 THEN
            SELECT SUM(cijena)
            INTO p_trosak
            FROM (
                SELECT kolicina*pc.cijena_sezona as cijena
                FROM troskovi 
                JOIN ponuda_cjenik pc USING(naziv_usluge)
                WHERE naziv_usluge=naziv_usluge AND br_rezervacije=p_br_rezervacije);
                
        ELSE 
            SELECT SUM(cijena)
            INTO p_trosak
            FROM (
                SELECT kolicina*pc.cijena_van_sezone as cijena
                FROM troskovi 
                JOIN ponuda_cjenik pc USING(naziv_usluge)
                WHERE naziv_usluge=naziv_usluge AND br_rezervacije=p_br_rezervacije);
        END IF;
        INSERT INTO racuni(br_racuna, br_rezervacije,iznos, datum, status) VALUES(CONCAT('RA', brojevi_ra.nextval), p_br_rezervacije, p_trosak, p_datum_prijave + p_br_dana, 'izdan');
        COMMIT;
    ELSIF p_count_rez = 0 THEN
    	DBMS_OUTPUT.PUT_LINE('Niste unijeli dobar broj rezervacije.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Vec postoji racun za tu rezervaciju.');
    END IF;
END izdavanje_racuna;
/


--placanje racuna--------------------------------------------------------

CREATE PROCEDURE placanje_racuna(
    p_br_racuna IN racuni.br_racuna%TYPE,
    p_datum IN date
)
AS
    p_count number;
BEGIN 
    SELECT COUNT(*)
    INTO p_count
    FROM racuni
    WHERE br_racuna = p_br_racuna AND status = 'izdan';
    
    IF p_count = 1 THEN
        UPDATE racuni
        SET status = 'placen', datum = p_datum
        WHERE br_racuna = p_br_racuna;
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Racun s tim brojem ne postoji ili je vec placen.');
    END IF;
END placanje_racuna;
/



-------------------INDEXI----------------------------

CREATE INDEX i_br_rezervacije
ON troskovi(br_rezervacije);


CREATE INDEX i_datum
ON rezervacija(prijava, odjava);


-------------- TRIGGERI------------------------------

--trigger za vrstu parcele
CREATE TRIGGER parcela_vrsta
BEFORE INSERT ON parcela
FOR EACH ROW WHEN 
	(NEW.vrsta_parcele != 'sator' AND NEW.vrsta_parcele != 'kamp kucica' AND NEW.vrsta_parcele != 'kamp prikolica')
BEGIN 
    RAISE_APPLICATION_ERROR( -20001, 'Krivi unos za atribut vrsta parcele, vrsta parcele moze biti sator, kamp kucica ili kamp prikolica!');
END parcela_vrsta;
/

CREATE TRIGGER racun_status
BEFORE INSERT ON racuni
FOR EACH ROW WHEN 
	(NEW.status != 'placen' AND NEW.status != 'izdan')
BEGIN 
    RAISE_APPLICATION_ERROR( -20001, 'Status racuna moze biti: izdan ili placen.');
END racun_status;
/











