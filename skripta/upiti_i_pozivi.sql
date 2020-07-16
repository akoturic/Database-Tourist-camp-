SET SERVEROUTPUT ON;
--------------------------------pozivi procedura i upita iz seminara-----------------------------------------------------

--unos
CALL unos_azuriranje_parcela(11, 'sator', 'Mala parcela za sator, pored masline.');
--azuriranje
CALL unos_azuriranje_parcela(11, null, 'Mala parcela za sator, pored masline.');
--aktivira triger za vrstu parcele
CALL unos_azuriranje_parcela(11, 'apartman', 'Mala parcela za sator, pored masline.');


CALL dostupnost_parcela('sator', '09-07-2020', '20-07-2020');
--procedura se nece izvrsiti do kraja jer su datum dolaska i odlaska zamjenjeni
CALL dostupnost_parcela('sator', '20-07-2020', '09-07-2020');
--procedura se nece izvrsiti do kraja jer je unesena kriva rijec za vrstu parcele
CALL dostupnost_parcela('apartman', '20-07-2020', '09-07-2020');



CALL rezerviranje('Dora', 'Doric', '0951423666', 'dorad@gmail.com', 1, '09-07-2020', '20-07-2020',3, 0, null);

SELECT *
FROM unajmljivac
WHERE ime = 'Dora' AND prezime='Doric';

SELECT * 
FROM rezervacija 
WHERE unajmljivac_id='U41';

--unos gostiju
CALL gost_prijava('Dora', 'Doric','4352789', '14-08-1993', 'R10040');
CALL gost_prijava('Marko','Doric','8352368', '19-03-1992', 'R10040');
CALL gost_prijava('Josipa', 'Doric', '4628482', '03-04-2016', 'R10040');

--ova procedura se ne izvrsi do kraja, jer su uneseni svi gosti za rezervaciju
CALL gost_prijava('Maja', 'Doric', '63484834', '03-05-2016', 'R10040');

SELECT *
FROM prijava
WHERE br_rezervacije = 'R10040';

--unos
CALL unos_azuriranje_ponude('lezaljka', 25, 20, 'Lezaljka za suncanje, cijena po danu');

SELECT *
FROM ponuda_cjenik
WHERE naziv_usluge='lezaljka';

--azuriranje
CALL unos_azuriranje_ponude('lezaljka', 35, null, null);

SELECT *
FROM ponuda_cjenik
WHERE naziv_usluge='lezaljka';

CALL unos_troskovi('09-07-2020', 'parking auto', 11, 'R10040');
CALL unos_troskovi('10-07-2020', 'lezaljka', 1, 'R10040');
CALL unos_troskovi('14-07-2020', 'rostilj', 1, 'R10040');
CALL unos_troskovi('15-07-2020', 'masina', 1, 'R10040');
CALL unos_troskovi('18-07-2020', 'pedalina sat', 1, 'R10040');

SELECT * 
FROM troskovi
WHERE br_rezervacije = 'R10040';


CALL izdavanje_racuna('R10040');

CALL placanje_racuna('RA120', '20-07-2020');

SELECT *
FROM racuni
WHERE br_rezervacije = 'R10040';


-------------------------------------------------------------------------------------------------------------------------------

---------------------upit za ispis svih troskova za dani broj racuna-----------------------

SELECT datum, naziv_usluge, kolicina, pc.cijena_sezona, kolicina*pc.cijena_sezona as ukupno
FROM troskovi t
JOIN ponuda_cjenik pc USING(naziv_usluge)
WHERE naziv_usluge=naziv_usluge AND br_rezervacije IN (SELECT br_rezervacije
                                                        FROM racuni
                                                        WHERE br_racuna = 'RA120'
                                                        )
ORDER BY datum;


----------------svi troskovi za danu rezervaciju---------------------------------

SELECT datum, naziv_usluge, kolicina, pc.cijena_sezona, kolicina*pc.cijena_sezona as ukupno
FROM troskovi t
JOIN ponuda_cjenik pc USING(naziv_usluge)
WHERE naziv_usluge=naziv_usluge AND br_rezervacije='R10040'
ORDER BY datum;

SELECT * FROM rezervacija;


---------ispis svih gostiju starijih od 18 godina za dani datum--------------
SELECT gost_id, ime, prezime, broj_dokumenta, datum_rodenja, ROUND(TRUNC(MONTHS_BETWEEN(SYSDATE, datum_rodenja))/12,0) as dob, br_rezervacije
FROM prijava
WHERE br_rezervacije IN (SELECT br_rezervacije
                        FROM rezervacija
                        WHERE prijava <= TO_DATE('09-07-2020') AND odjava >= TO_DATE('09-07-2020'))
        AND (SELECT ROUND(dob, 0)
                FROM (SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, datum_rodenja))/12 as dob
                FROM DUAL)) > 18;



---------broj prijavljenih gostiju za dani datum------------------------------

SELECT COUNT(*) as broj_gostiju
FROM prijava
WHERE br_rezervacije IN (SELECT br_rezervacije
                        FROM rezervacija
                        WHERE prijava <= TO_DATE('09-07-2020') AND odjava >= TO_DATE('09-07-2020'));




-----------------izbacuje sve parcele dostupne za zadano razdoblje-----------
SELECT * FROM parcela pa
WHERE br_parcele NOT IN
    (SELECT br_parcele FROM rezervacija
     WHERE br_parcele = pa.br_parcele AND TO_DATE('09-07-2020', 'DD-MM-YYYY') < odjava AND TO_DATE('20-07-2020', 'DD-MM-YYYY') > prijava);




----------broj zauzetih parcela po vrsti za dani datum--------------------------------------
SELECT SUM(CASE WHEN vrsta_parcele = 'sator' THEN 1 ELSE 0 END) br_satora, 
       SUM(CASE WHEN vrsta_parcele = 'kamp kucica' THEN 1 ELSE 0 END) br_kamp_kucica, 
       SUM(CASE WHEN vrsta_parcele = 'kamp prikolica' THEN 1 ELSE 0 END) br_kamp_prikolica  
FROM parcela
JOIN rezervacija USING(br_parcele)
WHERE  br_parcele = br_parcele  AND prijava <= TO_DATE('09-07-2020') AND odjava >= TO_DATE('09-07-2020');

--------------------------------------------------------------------------------------------------------------------


--SELECT *
--FROM rezervacija
--WHERE prijava <= TO_DATE('09-07-2020') AND odjava >= TO_DATE('09-07-2020');

















