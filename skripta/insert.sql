SET SERVEROUTPUT ON;

-------------------------cjenik_ponuda ---------------------
CALL unos_azuriranje_ponude('djeca nocenje', 34, 27, 'Cijena jednog nocenja za djecu od 3 do 18 godina');
CALL unos_azuriranje_ponude('odrasli nocenje', 57, 42, 'Cijena jednog nocenja za odraslu osobu.');
CALL unos_azuriranje_ponude('sator', 46, 42, 'Cijena jednog nocenja za sator');
CALL unos_azuriranje_ponude('kamp kucica', 75, 57, 'Cijena jednog nocenja za kamp kucicu.');
CALL unos_azuriranje_ponude('kamp prikolica', 61, 50, 'Cijena jedno nocenja za kamp priklicu');
CALL unos_azuriranje_ponude('kucni ljubimac', 23, 23, 'Cijena nocenja za kucnog ljubimca.');
CALL unos_azuriranje_ponude('pristojba odrasli', 8, 8, 'Cijena boravisne pristojbe po danu za odraslu osobu.');
CALL unos_azuriranje_ponude('pristojba djeca', 4, 4, 'Cijena boravisne pristojbe po danu za djecu od 3 do 18 godina.');

CALL unos_azuriranje_ponude('parking auto', 31, 21, 'Cijena parkinga za auto po danu.');
CALL unos_azuriranje_ponude('parking motor', 27, 23, 'Cijena parkinga za motor po danu.');
CALL unos_azuriranje_ponude('struja', 31, 31, 'Cijena prikljucka na struju po danu.');
CALL unos_azuriranje_ponude('masina', 31, 31, 'Cijena jednog koristenja masine za pranje rublja.');
CALL unos_azuriranje_ponude('bicikl', 75, 50, 'Cijena najma bicikla po danu.');
CALL unos_azuriranje_ponude('pedalina sat', 60, 40, 'Cijena najma pedaline po satu.');
CALL unos_azuriranje_ponude('kajak sat', 50, 30, 'Cijena najma kajaka po satu.');
CALL unos_azuriranje_ponude('rostilj', 25, 15, 'Cijena najma za jedno koristenje.');



-----------------------parcele-----------------------------
CALL unos_azuriranje_parcela(1, 'sator', 'Parcela ispod masline, prvi red do mora.');
CALL unos_azuriranje_parcela(2, 'kamp kucica', 'Parcela prvi red do mora za kamp kucicu.');
CALL unos_azuriranje_parcela(3, 'kamp prikolica', 'Parcela ispod masline, prvi red do mora.');
CALL unos_azuriranje_parcela(4, 'kamp kucica', 'Parcela ispod masline.');
CALL unos_azuriranje_parcela(5, 'sator', 'Parcela u hladu za sator.');
CALL unos_azuriranje_parcela(6, 'kamp prikolica', 'Parcela ispod masline, pored rostilja.');
CALL unos_azuriranje_parcela(7, 'kamp prikolica', 'Parcela u blizini tuseva, ispod bora.');
CALL unos_azuriranje_parcela(8, 'sator', 'Parcela u hladu za sator.');
CALL unos_azuriranje_parcela(9, 'kamp kucica', 'Parcela pored recepcije, u hladu.');
CALL unos_azuriranje_parcela(10, 'sator', 'Parcela ispod masline, prvi red do mora.');




--------------------rezervacije-------------------------------

CALL rezerviranje('Sanja', 'Horvat', '0956714325', 'sanja@gmail.com', 4, '10-05-2020', '15-05-2020', 4, 1, 'Dolaze u vecernjim satima');
CALL rezerviranje('Ivan', 'Kovačević', '0961614325', 'ivank@gmail.com', 5, '13-05-2020', '25-05-2020', 5, 0, null);
CALL rezerviranje('Marko', 'Kesegić', '0999714325', 'markok@gmail.com', 1, '02-06-2020', '18-06-2020', 3, 0, null);
CALL rezerviranje('Filip', 'Glavaš', '095671443', 'filipg@gmail.com', 1, '20-06-2020', '25-06-2020', 2, 1, null);
CALL rezerviranje('Kristijan', 'Martinov', '095655325', 'kmartinov@gmail.com', 6, '15-06-2020', '15-07-2020', 4, 1, null);
CALL rezerviranje('Andrija', 'Erceg', '099475885', 'aerceg@gmail.com', 8, '10-06-2020', '30-06-2020', 3, 1, null);
CALL rezerviranje('Ivica', 'Voncina', '0995576836', 'ivicav@gmail.com', 10, '03-06-2020', '10-06-2020', 5, 0, null);
CALL rezerviranje('Josip', 'Rako', '0978840382', 'josipr@gmail.com', 7, '13-06-2020', '21-06-2020', 3, 0, null);
CALL rezerviranje('Matej', 'Vrbanic', '096995038', 'matejv@gmail.com', 5, '20-06-2020', '27-06-2020', 6, 0, null);
CALL rezerviranje('Mislav', 'Ljubicic', '095334753', 'mislavl@gmail.com', 1, '27-06-2020', '05-07-2020', 2, 2, null);
CALL rezerviranje('Mate', 'Sulic', '0956714325', 'sulicm@gmail.com', 4, '29-06-2020', '08-07-2020', 5, 0, null);
CALL rezerviranje('Nikola', 'Zubcic', '095445753', 'nikolaz@gmail.com', 2, '04-07-2020', '11-07-2020', 4, 0, null);
CALL rezerviranje('Ana', 'Horvat', '096233940', 'anahorvat@gmail.com', 3, '03-07-2020', '10-07-2020', 4, 0, null);
CALL rezerviranje('Iva', 'Linic', '097885403', 'ivalinic@gmail.com', 9, '01-07-2020', '15-07-2020', 3, 0, null);
CALL rezerviranje('Ema', 'Travarevic', '099548454', 'emaema@gmail.com', 10, '10-07-2020', '25-07-2020', 5, 0, null);
CALL rezerviranje('Ivana', 'Dasovic', '095994005', 'ivanad@gmail.com', 7, '04-07-2020', '11-07-2020', 6, 1, null);
CALL rezerviranje('Ljubica', 'Maric', '0952340656', 'maricl@gmail.com', 4, '10-07-2020', '30-07-2020', 2, 1, null);
CALL rezerviranje('Kristina', 'Pranjic', '096669540', 'kristinap@gmail.com', 6, '25-07-2020', '03-08-2020', 4, 0, null);
CALL rezerviranje('Sandra', 'Barišic', '095348577', 'sandrab@gmail.com', 2, '13-07-2020', '20-07-2020', 6, 1, 'Dolaze u vecernjim satima');
CALL rezerviranje('Suzana', 'Felic', '097349506', 'felics@gmail.com', 8, '09-07-2020', '15-07-2020', 3, 0, null);
CALL rezerviranje('Petra', 'Filic', '095547699', 'filicp@gmail.com', 9, '18-07-2020', '28-07-2020', 4, 0, null);
CALL rezerviranje('Ena', 'Ban', '0994730537', 'enaban@gmail.com', 3, '17-07-2020', '29-07-2020', 5, 1, 'Dolaze u vecernjim satima');

--------------------prijava gostiju---------------------------

CALL gost_prijava('Sanja', 'Horvat', '2312332291', '23-04-1979', 'R10000');
CALL gost_prijava('Marko', 'Horvat', '1455345784', '15-07-1975', 'R10000');
CALL gost_prijava('Ivona', 'Horvat', '6783425912', '23-04-2003', 'R10000');
CALL gost_prijava('Luka', 'Horvat', '3478932143', '03-10-2006', 'R10000');

CALL gost_prijava('Ivan','Kovacevic', '23879546', '21-01-1973', 'R10001');
CALL gost_prijava('Sandra','Kovacevic', '678346289', '08-05-1978', 'R10001');
CALL gost_prijava('Mladen','Duric', '7894320', '13-10-1972', 'R10001');
CALL gost_prijava('Nikolina','Duric', '62923402', '11-09-1974', 'R10001');
CALL gost_prijava('Luka','Kovacevic', '22307434', '29-04-2005', 'R10001');

CALL gost_prijava('Marko', 'Kesegic', '1325475', '02-12-1990', 'R10002');
CALL gost_prijava('Karlo', 'Bozic', '75432512', '06-10-1992', 'R10002');
CALL gost_prijava('Damjan', 'Boskovic', '2544575', '12-08-1991', 'R10002');

CALL gost_prijava('Marija', 'Voncina', '84326735', '25-04-1985', 'R10006');
CALL gost_prijava('Ivica', 'Voncina', '26127325', '21-09-1982', 'R10006');
CALL gost_prijava('Masa', 'Voncina', '73258343', '05-07-2009', 'R10006');
CALL gost_prijava('Tibor', 'Voncina', '18423593', '16-03-2011', 'R10006');
CALL gost_prijava('Filip', 'Voncina', '67352551', '10-08-2015', 'R10006');

CALL gost_prijava('Mirta', 'Erceg', '27432684', '12-06-2007', 'R10005');
CALL gost_prijava('Josip', 'Erceg', '64284937', '14-09-2005', 'R10005');
CALL gost_prijava('Ljubica', 'Erceg', '36783728', '19-11-1980', 'R10005');

CALL gost_prijava('Josip', 'Rako', '34784878', '23-05-1995', 'R10007');
CALL gost_prijava('Mirna', 'Ljubic', '1374787', '29-01-1996', 'R10007');
CALL gost_prijava('Nikolina', 'Matic', '6438483', '02-11-1995', 'R10007');

CALL gost_prijava('Kristijan', 'Martinov', '32577247', '13-12-1996', 'R10004');
CALL gost_prijava('Lena', 'Mihic', '13592316', '17-05-1997', 'R10004');
CALL gost_prijava('Matija', 'Vuko', '47838788', '18-10-1999', 'R10004');
CALL gost_prijava('Sebastijan', 'Grgic', '3748290', '23-10-1997', 'R10004');

CALL gost_prijava('Filip', 'Glavas', '3267363', '14-03-1989', 'R10003');
CALL gost_prijava('Marija', 'Glavas', '3148997', '07-08-1991', 'R10003');

CALL gost_prijava('Matija', 'Vrbanic', '4536281', '19-02-1975', 'R10008');
CALL gost_prijava('Tajana', 'Vrbanic', '7395924', '24-06-1978', 'R10008');
CALL gost_prijava('Mia', 'Vrbanic', '592748', '11-08-2011', 'R10008');
CALL gost_prijava('Stjepan', 'Vrbanic', '3830137', '01-12-2006', 'R10008');
CALL gost_prijava('Darko', 'Kojic', '7394612', '27-06-1947', 'R10008');
CALL gost_prijava('Ana', 'Kojic', '3878271', '26-03-1950', 'R10008');

CALL gost_prijava('Mate', 'Sulic', '4387835', '28-01-1967', 'R10010');
CALL gost_prijava('Ljerka', 'Sulic', '479240', '21-07-1970', 'R10010');
CALL gost_prijava('Mihaela', 'Sulic', '1245397', '16-05-2002', 'R10010');
CALL gost_prijava('Danijel', 'Sulic', '5479291', '14-10-1998', 'R10010');
CALL gost_prijava('Dora', 'Sulic', '7745271', '07-06-2000', 'R10010');

CALL gost_prijava('Iva', 'Linic', '7439291', '08-11-1987', 'R10013');
CALL gost_prijava('Dorotea', 'Baric', '7439291', '09-08-1989', 'R10013');
CALL gost_prijava('Marina', 'Dedic', '1357351', '28-01-1989', 'R10013');


CALL gost_prijava('Ana', 'Horvat', '58829991', '29-11-1985', 'R10012');
CALL gost_prijava('Darko', 'Bradaric', '6962892', '07-02-1982', 'R10012');
CALL gost_prijava('Matilda', 'Bradaric', '82842788', '14-04-2016', 'R10012');
CALL gost_prijava('Marin', 'Bradaric', '5829547', '05-10-2019', 'R10012');

CALL gost_prijava('Nikola', 'Zubcic', '4682781', '25-04-1990', 'R10011');
CALL gost_prijava('Marina', 'Zubcic', '8520038', '12-09-1992', 'R10011');
CALL gost_prijava('Luka', 'Konjevic', '8390012', '30-12-1989', 'R10011');
CALL gost_prijava('Rebeka', 'Malinovic', '24749291', '25-04-1990', 'R10011');


CALL gost_prijava('Ivana', 'Dasovic', '8245294', '25-03-1979', 'R10015');
CALL gost_prijava('Goran', 'Dasovic', '3742181', '12-09-1981', 'R10015');
CALL gost_prijava('Maja', 'Dasovic', '9836471', '19-12-2007', 'R10015');
CALL gost_prijava('Sinisa', 'Lukic', '4238902', '21-07-1978', 'R10015');
CALL gost_prijava('Dubravka', 'Lukic', '2429084', '07-11-1980', 'R10015');
CALL gost_prijava('Katja', 'Lukic', '8245294', '01-08-2009', 'R10015');

CALL gost_prijava('Mislav', 'Ljubicic', '38562912', '23-07-1991', 'R10009');
CALL gost_prijava('Korina', 'Barisic', '43974329', '09-01-1990', 'R10009');
----------------troskovi-----------------------------------------
CALL unos_troskovi('10-05-2020', 'struja', 5, 'R10000');
CALL unos_troskovi('13-05-2020', 'parking auto', 12, 'R10001');
CALL unos_troskovi('13-05-2020', 'rostilj', 1, 'R10000');
CALL unos_troskovi('14-05-2020', 'pedalina sat', 2, 'R10000');
CALL unos_troskovi('14-05-2020', 'kajak sat', 1, 'R10001');
CALL unos_troskovi('15-05-2020', 'masina', 1, 'R10001');
CALL unos_troskovi('20-05-2020', 'bicikl', 2, 'R10001');
CALL unos_troskovi('02-06-2020', 'parking motor', 16, 'R10002');
CALL unos_troskovi('02-06-2020', 'parking motor', 16, 'R10002');
CALL unos_troskovi('03-06-2020', 'parking auto', 7, 'R10006');  
CALL unos_troskovi('05-06-2020', 'rostilj', 1, 'R10006');
CALL unos_troskovi('07-06-2020', 'kajak sat', 3, 'R10002');
CALL unos_troskovi('09-06-2020', 'pedalina sat', 1, 'R10006');
CALL unos_troskovi('10-06-2020', 'parking auto', 20, 'R10005');
CALL unos_troskovi('13-06-2020', 'parking auto', 8, 'R10007');
CALL unos_troskovi('15-06-2020', 'parking motor', 30, 'R10004');
CALL unos_troskovi('15-06-2020', 'kajak sat', 2, 'R10005');
CALL unos_troskovi('15-06-2020', 'masina', 1, 'R10002');
CALL unos_troskovi('17-06-2020', 'pedalina sat', 1, 'R10005');
CALL unos_troskovi('19-06-2020', 'rostilj', 1, 'R10007');
CALL unos_troskovi('20-06-2020', 'parking motor', 5, 'R10003');
CALL unos_troskovi('20-06-2020', 'parking auto', 7, 'R10008');
CALL unos_troskovi('20-06-2020', 'parking motor', 7, 'R10008');
CALL unos_troskovi('21-06-2020', 'bicikl', 2, 'R10004');
CALL unos_troskovi('22-06-2020', 'pedalina sat', 1, 'R10008');
CALL unos_troskovi('22-06-2020', 'kajak sat', 1, 'R10008');
CALL unos_troskovi('23-06-2020', 'kajak sat', 1, 'R10003');
CALL unos_troskovi('25-06-2020', 'rostilj', 1, 'R10005');
CALL unos_troskovi('25-06-2020', 'masina', 1, 'R10004');
CALL unos_troskovi('27-06-2020', 'parking auto', 8, 'R10009');
CALL unos_troskovi('29-06-2020', 'struja', 9, 'R10010');
CALL unos_troskovi('01-07-2020', 'pedalina sat', 1, 'R10004');
CALL unos_troskovi('01-07-2020', 'pedalina sat', 1, 'R10010');
CALL unos_troskovi('01-07-2020', 'struja', 14, 'R10013'); 
CALL unos_troskovi('03-07-2020', 'kajak sat', 1, 'R10009');
CALL unos_troskovi('03-07-2020', 'struja', 7, 'R10012');
CALL unos_troskovi('04-07-2020', 'rostilj', 1, 'R10010');
CALL unos_troskovi('04-07-2020', 'struja', 7, 'R10011'); 
CALL unos_troskovi('04-07-2020', 'parking motor', 7, 'R10011');
CALL unos_troskovi('04-07-2020', 'parking auto', 7, 'R10015');
CALL unos_troskovi('04-07-2020', 'struja', 7, 'R10015');
CALL unos_troskovi('05-07-2020', 'rostilj', 1, 'R10010');
CALL unos_troskovi('06-07-2020', 'masina', 1, 'R10013'); 
CALL unos_troskovi('06-07-2020', 'rostilj', 1, 'R10015');
CALL unos_troskovi('07-07-2020', 'rostilj', 1, 'R10012');
CALL unos_troskovi('07-07-2020', 'pedalina sat', 1, 'R10011');


---------------izdavanje racuna----------------------------------
CALL izdavanje_racuna('R10000');
CALL izdavanje_racuna('R10001');
CALL izdavanje_racuna('R10002');
CALL izdavanje_racuna('R10006');
CALL izdavanje_racuna('R10005');
CALL izdavanje_racuna('R10007');
CALL izdavanje_racuna('R10004'); 
CALL izdavanje_racuna('R10003');
CALL izdavanje_racuna('R10008');
CALL izdavanje_racuna('R10009');

--------------placanje racuna------------------------------------
CALL placanje_racuna('RA100', '15-05-2020');
CALL placanje_racuna('RA101', '25-05-2020');
CALL placanje_racuna('RA102', '18-06-2020');
CALL placanje_racuna('RA103', '10-06-2020');
CALL placanje_racuna('RA104', '30-06-2020');
CALL placanje_racuna('RA105', '21-06-2020');
CALL placanje_racuna('RA106', '15-07-2020');
CALL placanje_racuna('RA107', '25-06-2020');
CALL placanje_racuna('RA108', '27-06-2020');
CALL placanje_racuna('RA109', '05-07-2020');

