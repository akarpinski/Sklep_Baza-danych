SET client_encoding='UTF-8';
SET datestyle TO 'ISO,European';


insert into zamowienia(id_zamowienia, id_klienta, termin_zamowienia, termin_dostawy) 
values(1,3,'15-03-2011','17-03-2011', 12.99),
      (2,5,'22-04-2010','23-04-2011', 7.00),
      (3,'27-04-2011','29-04-2011', 122.50);

insert into klienci(id_klienta, imie, nazwisko, adres, kod_pocztowy, miasto, telefon, email)
values(1,'Jan','Kowalski','Kadetów6/3','80-298','Gdańsk','0583522840',NULL),   
	  (2,'Władysław','Dobrowolski','Grunwaldzka111','Gdańsk','058260860','wdobrowolski@wp.pl'),
      (3,'Anna','Szepietowska','Podchorążych 10/1','82-386','Sopot','663 123 432','NULL');     

insert into specyfikacja_zamowienia(id_zamowienia, id_produktu, ilosc) 
values(1, 5, 11),
      (1, 17, 8),
      (1, 9, 22);
 
insert into produkty(id_produktu, rodzaj, producent, model, okres_gwarancji, cena)
values(1,'użytkowe', 'CD', 'Verbatim', 'DVD-R','1 rok', 10.00),
      (2,'sprzęt', 'drukarka', 'Canon', 'MP550', '2 lata', 316.00),
      (3,'systemy operacyjne', 'Microsoft', 'Windows 7','5 lat',2.49);

