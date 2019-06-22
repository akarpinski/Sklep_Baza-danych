DROP TABLE elementy;
DROP TABLE zamowienia;
DROP TABLE produkty;
DROP TABLE klienci;

SET client_encoding='UTF-8';
SET datestyle TO 'ISO,European';


CREATE TABLE klienci
(
	id_klienta		integer	PRIMARY KEY,
	imie			varchar(16)	NOT NULL,
	nazwisko		varchar(32)	NOT NULL,
	adres			varchar(32),    
	kod				char(6),
	miasto			varchar(32),
	telefon			varchar(16),
	email			varchar(32)
);

CREATE TABLE produkty
(
	id_produktu		integer	PRIMARY KEY,
	rodzaj			varchar(32)	NOT NULL,
	komponenty		varchar(32)	NOT NULL,	
	producent		varchar(32)	NOT NULL,    
	model			varchar(32)	NOT NULL,	
	gwarancja		varchar(16),
	cena			numeric(6,2) 
);

CREATE TABLE zamowienia
(
	id_zamowienia		integer	PRIMARY KEY,
	termin_zamowienia	date	NOT NULL,
	termin_dostawy		date	NOT NULL,
	forma_dostawy		varchar(16)	NOT NULL,
	id_klienta			integer		REFERENCES klienci(id_klienta)
);

CREATE TABLE elementy
(
	id_elementu		integer	PRIMARY KEY,
	id_zamowienia	integer		REFERENCES zamowienia(id_zamowienia),
	id_produktu		integer		REFERENCES produkty(id_produktu),
	ilosc			integer	NOT NULL
);



INSERT INTO klienci(id_klienta, imie, nazwisko, adres, kod, miasto, telefon, email)
	VALUES	(1,'Jan','Kowalski','Kadetów 6/3','80-298','Gdańsk',NULL,NULL),
			(2,'Władysław','Dobrowolski','Grunwaldzka 111','80-123','Gdańsk','58260860','wdobrowolski@wp.pl'),
      		(3,'Anna','Szepietowska','Podchorążych 10/1','82-386','Sopot','663123432',NULL),
			(4,'Artur','Leszczyński','Grunwaldzka 24','81-245','Gdynia','581235478','a.leszczynski@onet.pl'),
			(5,'Jan','Dobrowolski','Miszewskiego 2/4','09-400','Płock',NULL,'jaroslaw_d@gmail.pl');   

INSERT INTO produkty(id_produktu, rodzaj, komponenty, producent, model, gwarancja, cena)
	VALUES  (1,'użytkowe','CD','Verbatim','DVD-R 10szt.',NULL,10),
			(2,'sprzęt','drukarka','Canon','MP550','2 lata',316),
      		(3,'oprogramowanie','systemy operacyjne','Microsoft','Windows 7','5 lat',320),
			(4,'sprzęt','drukarka','HP','1018','2 lata',520),
      		(5,'oprogramowanie','systemy operacyjne','Microsoft','Windows XP','2 lata',200),
			(6,'sprzęt','notbook','Toshiba','A300-121','2 lata',1700),
      		(7,'oprogramowanie','gry','Gameover','Street Fighter 4',NULL,60),
      		(8,'oprogramowanie','gry','Steam','Counter Strike',NULL,50),
     		(9,'oprogramowanie','gry','Gameover','Street Fighter 4 full',NULL,120),
			(10,'użytkowe','CD','TDK','DVD-RW 10szt.',NULL,45);
			



INSERT INTO zamowienia(id_zamowienia, termin_zamowienia, termin_dostawy, forma_dostawy, id_klienta) 
	VALUES	(1,'15-03-2011','17-03-2011','kurier',3),
    	  	(2,'22-04-2011','23-04-2011','poczta',1),
    	  	(3,'22-04-2011','29-04-2011','osobisty',4),
    	  	(4,'22-04-2011','23-04-2011','poczta',1),
    	  	(5,'25-04-2011','30-04-2011','kurier',5),
    	  	(6,'25-04-2011','26-04-2011','osobisty',3),
    	  	(7,'27-04-2011','29-04-2011','osobisty',2),
    	  	(8,'29-04-2011','01-05-2011','poczta',5),
    	  	(9,'30-04-2011','01-05-2011','kurier',3),
    	  	(10,'30-04-2011','02-05-2011','kurier',1),
    	  	(11,'01-05-2011','03-05-2011','poczta',4),
    	  	(12,'01-05-2011','01-05-2011','osobisty',1),
    	  	(13,'02-05-2011','02-05-2011','osobisty',3),
    	  	(14,'04-05-2011','06-05-2011','poczta',4),
    	  	(15,'05-05-2011','06-05-2011','osobisty',2);


INSERT INTO elementy(id_elementu, id_zamowienia, id_produktu, ilosc) 
	VALUES	(1,1,1,2),
    	  	(2,2,2,5),
    	  	(3,3,3,4),
    	  	(4,3,1,1),
    	  	(5,4,1,4),
    	  	(6,4,2,5),
    	  	(7,4,3,4),
    	  	(8,5,2,1),
    	  	(9,5,3,4),
			(10,6,1,2);



SELECT * FROM klienci;

SELECT * FROM produkty;

SELECT * FROM zamowienia;

SELECT * FROM elementy;

SELECT imie,nazwisko,adres FROM klienci;

SELECT producent,model,cena FROM produkty;

ALTER TABLE klienci ADD status varchar(16);
SELECT * FROM klienci;

SELECT model,producent FROM produkty WHERE producent='Gameover';

SELECT count(id_zamowienia) AS ilosc_zamowien FROM zamowienia;

SELECT k.imie,k.nazwisko,z.forma_dostawy FROM klienci k JOIN zamowienia z ON k.id_klienta=z.id_zamowienia;

SELECT imie,nazwisko,miasto,
	CASE WHEN nazwisko='Kowalski' OR nazwisko='Dobrowolski' THEN 'kolega'
		ELSE 'inny'
	END AS znajomi
FROM klienci;

SELECT id_elementu,ilosc FROM elementy;
DELETE FROM elementy WHERE ilosc<2;
SELECT id_elementu,ilosc FROM elementy;

SELECT producent,model FROM produkty;
DELETE FROM produkty WHERE producent='Toshiba';
SELECT producent,model FROM produkty;

SELECT rodzaj,producent,model FROM produkty;
UPDATE produkty SET rodzaj='programy' WHERE rodzaj='oprogramowanie';
SELECT rodzaj,producent,model FROM produkty;

SELECT producent,model,cena FROM produkty WHERE producent='Canon';

ALTER TABLE produkty ADD rabat numeric(6,2);
SELECT * FROM produkty;

UPDATE produkty SET rabat=0.10*cena WHERE producent='Canon';

ALTER TABLE produkty ADD nowa_cena numeric(6,2);
SELECT * FROM produkty;

UPDATE produkty SET nowa_cena=cena-rabat WHERE producent='Canon';
SELECT producent,model,cena,nowa_cena FROM produkty WHERE producent='Canon';

CREATE VIEW wartosc AS SELECT sum(cena) AS wartosc_towarow From produkty;
SELECT * FROM wartosc;
