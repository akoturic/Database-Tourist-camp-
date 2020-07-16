DROP TABLE racuni;
DROP TABLE prijava;
DROP TABLE troskovi;
DROP TABLE rezervacija;
DROP TABLE parcela;
DROP TABLE unajmljivac;
DROP TABLE ponuda_cjenik;


----------------KREIRANJE TABLICA----------------

CREATE TABLE parcela
(
	br_parcele number(5) PRIMARY KEY,
	vrsta_parcele varchar(20) NOT NULL,
	opis_parcele varchar(100)
);


CREATE TABLE unajmljivac
(
	unajmljivac_id varchar(20) PRIMARY KEY,
	ime varchar(30) NOT NULL,
	prezime varchar(30) NOT NULL,
	telefon varchar(20) NOT NULL,
	email varchar(20) NOT NULL
);

CREATE TABLE rezervacija
(
	br_rezervacije varchar(20) PRIMARY KEY,
	prijava date NOT NULL,
	odjava date NOT NULL,
	osobe number(2) NOT NULL,
	kucni_ljubimci number(1) NOT NULL,
	napomena varchar(100),
	br_parcele number(5) NOT NULL REFERENCES parcela(br_parcele),
	unajmljivac_id varchar(20) NOT NULL REFERENCES unajmljivac(unajmljivac_id)
); 

CREATE TABLE prijava
(
	gost_id varchar(20) PRIMARY KEY, 
	ime varchar(30) NOT NULL,
	prezime varchar(30) NOT NULL,
	broj_dokumenta varchar(30) NOT NULL,
	datum_rodenja date NOT NULL,
	br_rezervacije varchar(20) NOT NULL REFERENCES rezervacija(br_rezervacije)
);

CREATE TABLE ponuda_cjenik
(
	naziv_usluge varchar(30) PRIMARY KEY,
	cijena_sezona number(5,2) NOT NULL,
	cijena_van_sezone number(5,2) NOT NULL,
	opis varchar(100)
);

CREATE TABLE troskovi
(
	trosak_id varchar(20) PRIMARY KEY,
	datum date NOT NULL,
	naziv_usluge varchar(30) NOT NULL REFERENCES ponuda_cjenik(naziv_usluge),
	kolicina number(3) NOT NULL,
	br_rezervacije varchar(20) NOT NULL REFERENCES rezervacija(br_rezervacije)
);

CREATE TABLE racuni
(
	br_racuna varchar(20) PRIMARY KEY,
	br_rezervacije varchar(20) NOT NULL REFERENCES rezervacija(br_rezervacije),
	iznos number(7,2) NOT NULL,
	datum date NOT NULL,
	status varchar(20) NOT NULL
);


