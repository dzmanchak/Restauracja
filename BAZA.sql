-- DZMITRY MANCHAK (MySQL 8.0)
DROP TABLE IF EXISTS `Gotowanie`; -- Usuwa tabelę `Gotowanie` jeśli istnieje
DROP TABLE IF EXISTS `Zamówione_dania`;
DROP TABLE IF EXISTS `Zamówienie`;
DROP TABLE IF EXISTS `Rezerwacja`;
DROP TABLE IF EXISTS `Klient`;
DROP TABLE IF EXISTS `Stolik`;
DROP TABLE IF EXISTS `Sala`;
DROP TABLE IF EXISTS `Skład_dania`;
DROP TABLE IF EXISTS `Danie`;
DROP TABLE IF EXISTS `Składnik`;
DROP TABLE IF EXISTS `Kucharz`;
DROP TABLE IF EXISTS `Kelner`;
DROP TABLE IF EXISTS `Menadżer`;

/****************************************************************************************************************************************************************************************************************/
-- Table Menadżer

CREATE TABLE `Menadżer` -- Tworzy tabelę o nazwie `Menadżer`
(
  `Id_menadżera` Int NOT NULL AUTO_INCREMENT, -- Dodaje do tabeli `Menadżer` atrybut o nazwie `Id_menadżera` typu INTEGER, nie może być NULL i ma AUTO_INCREMENT
  `Imię` Varchar(20) NOT NULL, -- Dodaje do tabeli `Menadżer` atrybut o nazwie `Imię` typu Varchar (20 (długość)), nie może być NULL
  `Nazwisko` Varchar(20) NOT NULL,
  `Plec` Char(1) NOT NULL DEFAULT 'M', -- Dodaje do tabeli `Menadżer` atrybut o nazwie `Plec` typu char(1), nie może być NULL oraz o wartości początkowej 'M'
  CONSTRAINT `menadżer_plec_chk` CHECK (`Plec` IN ('M', 'K')), -- Tworzenie ograniczenia integralnościowego o nazwie `menadżer_plec_chk` które sprawdza czy atrybut `Plec` ma wartość 'M' lub 'K'
  `Data_zatrudnienia` Date NOT NULL,
  `Data_zwolnienia` Date DEFAULT NULL,
  CONSTRAINT `menadżer_data_zwolnienia_chk` CHECK (`Data_zwolnienia` > `Data_zatrudnienia` ), -- Tworzenie ograniczenia integralnościowego o nazwie `menadżer_data_zwolnienia_chk` które sprawdza `Data_zwolnienia` > `Data_zatrudnienia`
  CONSTRAINT `menadżer_id_pk` PRIMARY KEY (`Id_menadżera`) -- Tworzenie klucza głównego
)
;

/****************************************************************************************************************************************************************************************************************/
-- Table Kelner

CREATE TABLE `Kelner`
(
  `Id_kelnera` Int NOT NULL AUTO_INCREMENT,
  `Imię` Varchar(20) NOT NULL,
  `Nazwisko` Varchar(20) NOT NULL,
  `Plec` Char(1) NOT NULL DEFAULT 'M',
  CONSTRAINT `kelner_plec_chk` CHECK (`Plec` IN ('M', 'K')),
  `Data_zatrudnienia` Date NOT NULL,
  `Data_zwolnienia` Date DEFAULT NULL,
  CONSTRAINT `kelner_data_zwolnienia_chk` CHECK (`Data_zwolnienia` > `Data_zatrudnienia` ),
  CONSTRAINT `kelner_id_pk` PRIMARY KEY (`Id_kelnera`)
)
;


/****************************************************************************************************************************************************************************************************************/
-- Table Kucharz

CREATE TABLE `Kucharz`
(
  `Id_kucharza` Int NOT NULL AUTO_INCREMENT,
  `Imię` Varchar(20) NOT NULL,
  `Nazwisko` Varchar(20) NOT NULL,
  `Plec` Char(1) NOT NULL DEFAULT 'M',
  `Szef_kuchni` Int,
  CONSTRAINT `kucharz_plec_chk` CHECK (`Plec` IN ('M', 'K')),
  `Data_zatrudnienia` Date NOT NULL,
  `Data_zwolnienia` Date DEFAULT NULL,
  CONSTRAINT `kucharz_data_zwolnienia_chk` CHECK (`Data_zwolnienia` > `Data_zatrudnienia` ),
  CONSTRAINT `kucharz_id_pk` PRIMARY KEY (`Id_kucharza`)
)
;


/****************************************************************************************************************************************************************************************************************/
-- Table Składnik

CREATE TABLE `Składnik`
(
  `Id_składnika` Int NOT NULL AUTO_INCREMENT,
  `Nazwa` Varchar(20) NOT NULL,
  `Opis` Varchar(400),
  `Producent` Varchar(35) NOT NULL,
  `Producent_contact` Varchar(45) NOT NULL,
  `Adres_producenta` Varchar(60) NOT NULL,
  CONSTRAINT `nazwa_składnika_ak` UNIQUE (`Nazwa`),
  CONSTRAINT `id_składnika_pk` PRIMARY KEY (`Id_składnika`)
)
;


/****************************************************************************************************************************************************************************************************************/
-- Table Danie

CREATE TABLE `Danie`
(
  `Id_dania` Int NOT NULL AUTO_INCREMENT,
  `Nazwa` Varchar(20) NOT NULL,
  `Waga` Float NOT NULL,
  `Cena` Float NOT NULL,
  `Opis` Varchar(400),
  `Obrazek` Mediumblob NOT NULL,
  `Nazwa_obrazku` Varchar(255) NOT NULL,
  CONSTRAINT `id_dania_pk` PRIMARY KEY (`Id_dania`),
  CONSTRAINT `nazwa_dania_ak` UNIQUE (`Nazwa`)
)
;

/****************************************************************************************************************************************************************************************************************/
-- Table Skład dania

CREATE TABLE `Skład_dania`
(
  `Id_dania` Int NOT NULL,
  `Id_składnika` Int NOT NULL,
  CONSTRAINT `skład_dania_pk` PRIMARY KEY (`Id_dania`,`Id_składnika`)
)
;

/****************************************************************************************************************************************************************************************************************/
-- Table Sala

CREATE TABLE `Sala`
(
  `Numer_sali` Int NOT NULL AUTO_INCREMENT,
  `Powierzchnia` Float NOT NULL,
  `Opis` Varchar(400),
  `Id_menadżera` Int NOT NULL,
  CONSTRAINT `numer_sali_pk` PRIMARY KEY (`Numer_sali`)
)
;


/****************************************************************************************************************************************************************************************************************/
-- Table Stolik

CREATE TABLE `Stolik`
(
  `Numer_stolika` Int NOT NULL AUTO_INCREMENT,
  `Liczba_osób` Int NOT NULL,
  CONSTRAINT `liczba_osób_chk` CHECK (`Liczba_osób` > 0),
  `Numer_sali` Int NOT NULL,
  CONSTRAINT `numer_stolika_pk` PRIMARY KEY (`Numer_stolika`)
)
;

/****************************************************************************************************************************************************************************************************************/
-- Table Klient

CREATE TABLE `Klient`
(
  `Klient_id` Int NOT NULL AUTO_INCREMENT,
  `Imię` Varchar(20) NOT NULL,
  `Nazwisko` Varchar(20) NOT NULL,
  `Plec` Char(1) NOT NULL DEFAULT 'M',
  CONSTRAINT `klient_plec_chk` CHECK (`Plec` IN ('M', 'K')),
  `E-mail` Varchar(255) NOT NULL,
  CONSTRAINT `klient_email_ak` UNIQUE (`E-mail`), -- Tworzenie ograniczenia integralnościowego o nazwie `klient_email_ak` które sprawdza, czy ten atrybut zawiera tylko unikalne wartości
  `Numer_komurkowy` Varchar(25) NOT NULL,
  CONSTRAINT `klient_numer_komurkowy_ak` UNIQUE (`Numer_komurkowy`),
  `Ocena` Int,
  `Komentaz` Varchar(600),
  CONSTRAINT `ocena_check` CHECK (`Ocena` IN (1 , 2 , 3 , 4 , 5)),
  CONSTRAINT `klient_id_pk` PRIMARY KEY (`Klient_id`)
)
;

/****************************************************************************************************************************************************************************************************************/
-- Table Rezerwacja

CREATE TABLE `Rezerwacja`
(
  `Id_rezerwacji` Int NOT NULL AUTO_INCREMENT,
  `Klient_id` Int NOT NULL,
  `Numer_stolika` Int NOT NULL,
  `Data` DATETIME NOT NULL,
  CONSTRAINT `rezerwacja_ak` UNIQUE (`Klient_id`,`Numer_stolika`,`Data`),
  CONSTRAINT `id_rezerwacji_pk` PRIMARY KEY (`Id_rezerwacji`)
)
;

/****************************************************************************************************************************************************************************************************************/
-- Table Zamówienie

CREATE TABLE `Zamówienie`
(
  `Id_zamówienia` Int NOT NULL AUTO_INCREMENT,
  `Cena_zamówiena` Float NOT NULL,
  `Czas` Datetime NOT NULL,
  `Klient_id` Int NOT NULL,
  `Id_kelnera` Int NOT NULL,
  `Numer_stolika` Int NOT NULL,
  CONSTRAINT `id_zamówienia_pk` PRIMARY KEY (`Id_zamówienia`)
)
;

/****************************************************************************************************************************************************************************************************************/
-- Table Zamówione dania

CREATE TABLE `Zamówione_dania`
(
  `Id_zamówienia` Int NOT NULL,
  `Id_dania` Int NOT NULL,
  `Ilość` Int NOT NULL,
  CONSTRAINT `zamówione_dania_pk` PRIMARY KEY (`Id_zamówienia`,`Id_dania`)
)
;

/****************************************************************************************************************************************************************************************************************/
-- Table Gotowanie

CREATE TABLE `Gotowanie`
(
  `Id_dania` Int NOT NULL,
  `Id_kucharza` Int NOT NULL,
   CONSTRAINT `gotowanie_pk` PRIMARY KEY (`Id_dania`, `Id_kucharza`)
)
;

/****************************************************************************************************************************************************************************************************************/
-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE `Rezerwacja` ADD CONSTRAINT `rezerwacja_klient` FOREIGN KEY (`Klient_id`) REFERENCES `Klient` (`Klient_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
; -- Tworzenie klucza obcego który wskazuje na klucz główny `Klient_id` w tabeli `Klient`

ALTER TABLE `Rezerwacja` ADD CONSTRAINT `stolik_rezerwacja` FOREIGN KEY (`Numer_stolika`) REFERENCES `Stolik` (`Numer_stolika`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Zamówienie` ADD CONSTRAINT `klient_zamówienie` FOREIGN KEY (`Klient_id`) REFERENCES `Klient` (`Klient_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Zamówione_dania` ADD CONSTRAINT `zamówienie_zamówione_dania` FOREIGN KEY (`Id_zamówienia`) REFERENCES `Zamówienie` (`Id_zamówienia`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Zamówione_dania` ADD CONSTRAINT `zamówione_dania_danie` FOREIGN KEY (`Id_dania`) REFERENCES `Danie` (`Id_dania`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Skład_dania` ADD CONSTRAINT `danie_skład_dania` FOREIGN KEY (`Id_dania`) REFERENCES `Danie` (`Id_dania`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Skład_dania` ADD CONSTRAINT `skład_dania_składniki` FOREIGN KEY (`Id_składnika`) REFERENCES `Składnik` (`Id_składnika`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Zamówienie` ADD CONSTRAINT `kelner_zamówienie` FOREIGN KEY (`Id_kelnera`) REFERENCES `Kelner` (`Id_kelnera`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Stolik` ADD CONSTRAINT `sala_stolik` FOREIGN KEY (`Numer_sali`) REFERENCES `Sala` (`Numer_sali`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Gotowanie` ADD CONSTRAINT `danie_gotowanie` FOREIGN KEY (`Id_dania`) REFERENCES `Danie` (`Id_dania`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Gotowanie` ADD CONSTRAINT `gotowanie_kucharz` FOREIGN KEY (`Id_kucharza`) REFERENCES `Kucharz` (`Id_kucharza`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Kucharz` ADD CONSTRAINT `kucharz_szef_kuchni` FOREIGN KEY (`Szef_kuchni`) REFERENCES `Kucharz` (`Id_kucharza`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Sala` ADD CONSTRAINT `menadrzer_sala` FOREIGN KEY (`Id_menadżera`) REFERENCES `Menadżer` (`Id_menadżera`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Zamówienie` ADD CONSTRAINT `stolik_zamówienie` FOREIGN KEY (`Numer_stolika`) REFERENCES `Stolik` (`Numer_stolika`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

-- INSERT

INSERT INTO `Menadżer` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Andrzej", "Kowalski", 'M', '1996-11-26'); -- Dodaje nowy rekord do tabeli `Menadżer` 
INSERT INTO `Menadżer` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`, `Data_zwolnienia`) VALUES ("Mikołaj", "Gotowko", 'M', '2001-06-13', '2011-06-13');
INSERT INTO `Menadżer` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Anna", "Krot", 'K', '2001-06-13');
INSERT INTO `Menadżer` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Wiktar", "Gubich", 'M', '2012-05-12');
INSERT INTO `Menadżer` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Dzmitry", "Manchak", 'M', '2012-05-14');
INSERT INTO `Menadżer` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Karolina", "Buuter", 'K', '2012-05-21');
INSERT INTO `Menadżer` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Andrzej", "Bulawka", 'M', '2012-05-29');
INSERT INTO `Menadżer` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Katsiaryna", "Dedkow", 'K', '2012-06-01');
INSERT INTO `Menadżer` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Aleksaner", "Wiśniewski", 'M', '2012-06-12');
INSERT INTO `Menadżer` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Volha", "Kamińska", 'K', '2012-06-12');

INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Alberta" , "Zamojska" , 'K' , '1996-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Aida" , "Wysocka" , 'K' , '1997-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Alisa" , "Lewandowska" , 'K' , '1998-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Anna" , "Zielińska" , 'K' , '1999-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Barbara" , "Tomaszewska" , 'K' , '2000-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Brenda" , "Tomaszewska" , 'K' , '2001-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Anton" , "Kustanovich" , 'M' , '2002-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Aleh" , "Bykow" , 'M' , '2003-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Lech" , "Kowalski" , 'M' , '2004-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Wiktar" , "Adamecki" , 'M' , '2005-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Vitalij" , "Araszkiewicz" , 'M' , '2006-11-26' );
INSERT INTO `Kelner` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES ("Kuba" , "Bagiński" , 'M' , '2007-11-26' );

INSERT INTO `Kucharz` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`) VALUES  ("Jakub" , "Wróbel",  'M' , '1996-11-26');
INSERT INTO `Kucharz` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`, `Szef_kuchni`) VALUES  ("Marcel" , "Kowalewski",  'M' , '1997-11-26', 1);
INSERT INTO `Kucharz` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`, `Szef_kuchni`) VALUES  ("Ignacy" , "Brzozowski",  'M' , '1998-11-26', 1);
INSERT INTO `Kucharz` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`, `Szef_kuchni`) VALUES  ("Dawid" , "Wójtowicz",  'M' , '1999-11-26', 1);
INSERT INTO `Kucharz` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`, `Szef_kuchni`) VALUES  ("Mateusz" , "Wieczorek",  'M' , '2000-11-26', 1);
INSERT INTO `Kucharz` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`, `Szef_kuchni`) VALUES  ("Sylwia" , "Szymańska",  'K' , '2001-11-26', 1);
INSERT INTO `Kucharz` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`, `Szef_kuchni`) VALUES  ("Maja" , "Kucharska",  'K' , '2002-11-26', 1);
INSERT INTO `Kucharz` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`, `Szef_kuchni`) VALUES  ("Milena" , "Kubicka",  'K' , '2003-11-26', 1);
INSERT INTO `Kucharz` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`, `Szef_kuchni`) VALUES  ("Wiktoria" , "Wróbel",  'K' , '2004-11-26', 1);
INSERT INTO `Kucharz` (`Imię`,`Nazwisko`, `Plec`, `Data_zatrudnienia`, `Szef_kuchni`) VALUES  ("Zofia" , "Kowalska",  'K' , '2005-11-26', 1);

INSERT INTO `Składnik` (`Nazwa`, `Opis`, `Producent`, `Producent_contact`, `Adres_producenta`) VALUES ("Skladnik 1" , "Opis 1" , "Producent 1" , "example1@gmail.com" , "adres1");
INSERT INTO `Składnik` (`Nazwa`, `Opis`, `Producent`, `Producent_contact`, `Adres_producenta`) VALUES ("Skladnik 2" , "Opis 2" , "Producent 2" , "example2@gmail.com" , "adres2");
INSERT INTO `Składnik` (`Nazwa`, `Opis`, `Producent`, `Producent_contact`, `Adres_producenta`) VALUES ("Skladnik 3" , "Opis 3" , "Producent 3" , "example3@gmail.com" , "adres3");
INSERT INTO `Składnik` (`Nazwa`, `Opis`, `Producent`, `Producent_contact`, `Adres_producenta`) VALUES ("Skladnik 4" , "Opis 4" , "Producent 4" , "example4@gmail.com" , "adres4");
INSERT INTO `Składnik` (`Nazwa`, `Opis`, `Producent`, `Producent_contact`, `Adres_producenta`) VALUES ("Skladnik 5" , "Opis 5" , "Producent 5" , "example5@gmail.com" , "adres5");
INSERT INTO `Składnik` (`Nazwa`, `Opis`, `Producent`, `Producent_contact`, `Adres_producenta`) VALUES ("Skladnik 6" , "Opis 6" , "Producent 6" , "example6@gmail.com" , "adres6");
INSERT INTO `Składnik` (`Nazwa`, `Opis`, `Producent`, `Producent_contact`, `Adres_producenta`) VALUES ("Skladnik 7" , "Opis 7" , "Producent 7" , "example7@gmail.com" , "adres7");
INSERT INTO `Składnik` (`Nazwa`, `Opis`, `Producent`, `Producent_contact`, `Adres_producenta`) VALUES ("Skladnik 8" , "Opis 1" , "Producent 8" , "example8@gmail.com" , "adres8");
INSERT INTO `Składnik` (`Nazwa`, `Opis`, `Producent`, `Producent_contact`, `Adres_producenta`) VALUES ("Skladnik 9" , "Opis 1" , "Producent 9" , "example9@gmail.com" , "adres9");
INSERT INTO `Składnik` (`Nazwa`, `Opis`, `Producent`, `Producent_contact`, `Adres_producenta`) VALUES ("Skladnik 10" , "Opis 1" , "Producent 1" , "example10@gmail.com" , "adres10");

INSERT INTO `Danie` (`Nazwa` , `Waga` , `Cena` , `Opis` , `Obrazek` , `Nazwa_obrazku`) VALUES ("Danie 1" , 100 , 2.5 , "Opis 1", LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Danie1.jpg') , "Danie1.jpg");
INSERT INTO `Danie` (`Nazwa` , `Waga` , `Cena` , `Opis` , `Obrazek` , `Nazwa_obrazku`) VALUES ("Danie 2" , 100 , 4.7 , "Opis 2", LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Danie2.jpg') , "Danie2.jpg");
INSERT INTO `Danie` (`Nazwa` , `Waga` , `Cena` , `Opis` , `Obrazek` , `Nazwa_obrazku`) VALUES ("Danie 3" , 100 , 1.2 , "Opis 3", LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Danie3.jpg') , "Danie3.jpg");
INSERT INTO `Danie` (`Nazwa` , `Waga` , `Cena` , `Opis` , `Obrazek` , `Nazwa_obrazku`) VALUES ("Danie 4" , 100 , 3.4 , "Opis 4", LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Danie4.jpg') , "Danie4.jpg");
INSERT INTO `Danie` (`Nazwa` , `Waga` , `Cena` , `Opis` , `Obrazek` , `Nazwa_obrazku`) VALUES ("Danie 5" , 100 , 2.5 , "Opis 5", LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Danie5.jpg') , "Danie5.jpg");
INSERT INTO `Danie` (`Nazwa` , `Waga` , `Cena` , `Opis` , `Obrazek` , `Nazwa_obrazku`) VALUES ("Danie 6" , 100 , 7.5 , "Opis 6", LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Danie6.jpg') , "Danie6.jpg");
INSERT INTO `Danie` (`Nazwa` , `Waga` , `Cena` , `Opis` , `Obrazek` , `Nazwa_obrazku`) VALUES ("Danie 7" , 100 , 2.5 , "Opis 7", LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Danie7.jpg') , "Danie7.jpg");
INSERT INTO `Danie` (`Nazwa` , `Waga` , `Cena` , `Opis` , `Obrazek` , `Nazwa_obrazku`) VALUES ("Danie 8" , 100 , 4.3 , "Opis 8", LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Danie8.jpg') , "Danie8.jpg");
INSERT INTO `Danie` (`Nazwa` , `Waga` , `Cena` , `Opis` , `Obrazek` , `Nazwa_obrazku`) VALUES ("Danie 9" , 100 , 6.8 , "Opis 9", LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Danie9.jpg') , "Danie9.jpg");
INSERT INTO `Danie` (`Nazwa` , `Waga` , `Cena` , `Opis` , `Obrazek` , `Nazwa_obrazku`) VALUES ("Danie 10" , 100 , 5 , "Opis 10", LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Danie10.jpg') , "Danie10.jpg");

INSERT INTO `Skład_dania` VALUES (1,4);
INSERT INTO `Skład_dania` VALUES (1,2);
INSERT INTO `Skład_dania` VALUES (2,6);
INSERT INTO `Skład_dania` VALUES (2,8);
INSERT INTO `Skład_dania` VALUES (3,3);
INSERT INTO `Skład_dania` VALUES (3,1);
INSERT INTO `Skład_dania` VALUES (4,5);
INSERT INTO `Skład_dania` VALUES (4,6);
INSERT INTO `Skład_dania` VALUES (5,7);
INSERT INTO `Skład_dania` VALUES (5,9);
INSERT INTO `Skład_dania` VALUES (6,10);
INSERT INTO `Skład_dania` VALUES (7,1);
INSERT INTO `Skład_dania` VALUES (7,2);
INSERT INTO `Skład_dania` VALUES (7,3);
INSERT INTO `Skład_dania` VALUES (8,4);
INSERT INTO `Skład_dania` VALUES (8,5);
INSERT INTO `Skład_dania` VALUES (9,6);
INSERT INTO `Skład_dania` VALUES (9,7);
INSERT INTO `Skład_dania` VALUES (10,8);
INSERT INTO `Skład_dania` VALUES (10,9);

INSERT INTO `Sala` VALUES (1 , 400,  "Sala numer 1", 1);
INSERT INTO `Sala` VALUES (2 , 600,  "Sala numer 2", 3);
INSERT INTO `Sala` VALUES (3 , 500,  "Sala numer 3", 3);
INSERT INTO `Sala` VALUES (4 , 300,  "Sala numer 4", 4);
INSERT INTO `Sala` VALUES (5 , 250,  "Sala numer 5", 5);
INSERT INTO `Sala` VALUES (6 , 150,  "Sala numer 6", 6);
INSERT INTO `Sala` VALUES (7 , 100,  "Sala numer 7", 7);
INSERT INTO `Sala` VALUES (8 , 300,  "Sala numer 8", 8);
INSERT INTO `Sala` VALUES (9 , 400,  "Sala numer 9", 9);
INSERT INTO `Sala` VALUES (10 , 400,  "Sala numer 10", 10);
INSERT INTO `Sala` VALUES (11 , 400,  "Sala numer 11", 10);

INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (2 , 1);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (2 , 1);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (2 , 1);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (2 , 2);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (3 , 2);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (4 , 3);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (1 , 3);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (2 , 4);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (3 , 5);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (4 , 6);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (2 , 7);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (3 , 8);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (2 , 9);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (3 , 10);
INSERT INTO `Stolik` (`Liczba_osób`,  `Numer_sali`) VALUES (2 , 10);

INSERT INTO `Klient` (`Imię` , `Nazwisko` , `Plec` , `E-mail` , `Numer_komurkowy` , `Ocena`, `Komentaz`) VALUES ("Alberta" , "Zamojska" , 'K' , "example1@gmail.com" , "jakiśnumer1" , 4 , "Wszytko OK");
INSERT INTO `Klient` (`Imię` , `Nazwisko` , `Plec` , `E-mail` , `Numer_komurkowy` , `Ocena`, `Komentaz`) VALUES ("Mikołaj", "Gotowko", 'M' , "example2@gmail.com" , "jakiśnumer2" , 5 , "Dobrze");
INSERT INTO `Klient` (`Imię` , `Nazwisko` , `Plec` , `E-mail` , `Numer_komurkowy` , `Ocena`, `Komentaz`) VALUES ("Wiktoria" , "Wróbel",  'K' , "example3@gmail.com" , "jakiśnumer3" , 5 , "GOOD:)");
INSERT INTO `Klient` (`Imię` , `Nazwisko` , `Plec` , `E-mail` , `Numer_komurkowy` , `Ocena`, `Komentaz`) VALUES ("Ignacy" , "Brzozowski",  'M' , "example4@gmail.com" , "jakiśnumer4" , 5 , "+");
INSERT INTO `Klient` (`Imię` , `Nazwisko` , `Plec` , `E-mail` , `Numer_komurkowy` , `Ocena`, `Komentaz`) VALUES ("Anton" , "Kustanovich" , 'M' , "example5@gmail.com" , "jakiśnumer5" , 5 , "NICE");
INSERT INTO `Klient` (`Imię` , `Nazwisko` , `Plec` , `E-mail` , `Numer_komurkowy` , `Ocena`, `Komentaz`) VALUES ("Wiktar", "Gubich", 'M' , "example6@gmail.com" , "jakiśnumer6" , 1 , NULL);
INSERT INTO `Klient` (`Imię` , `Nazwisko` , `Plec` , `E-mail` , `Numer_komurkowy` , `Ocena`, `Komentaz`) VALUES ("Kuba" , "Bagiński" , 'M' , "example7@gmail.com" , "jakiśnumer7" , 3 , "Wszytko OK");
INSERT INTO `Klient` (`Imię` , `Nazwisko` , `Plec` , `E-mail` , `Numer_komurkowy` , `Ocena`, `Komentaz`) VALUES ("Zofia" , "Kowalska",  'K' , "example8@gmail.com" , "jakiśnumer8" , 2 , NULL);
INSERT INTO `Klient` (`Imię` , `Nazwisko` , `Plec` , `E-mail` , `Numer_komurkowy` , `Ocena`, `Komentaz`) VALUES ("Alisa" , "Lewandowska" , 'K' , "example9@gmail.com" , "jakiśnumer9" , 4 , "Wszytko OK");
INSERT INTO `Klient` (`Imię` , `Nazwisko` , `Plec` , `E-mail` , `Numer_komurkowy` , `Ocena`, `Komentaz`) VALUES ("Mateusz" , "Wieczorek",  'M' , "example10@gmail.com" , "jakiśnumer10" , 4 , "GOOD FOOD!");

INSERT INTO `Rezerwacja` (`Klient_id`,`Numer_stolika`,`Data`) VALUES (1,1,'01:07:23 12/30');
INSERT INTO `Rezerwacja` (`Klient_id`,`Numer_stolika`,`Data`) VALUES (2,1,'01:07:23 12/30');
INSERT INTO `Rezerwacja` (`Klient_id`,`Numer_stolika`,`Data`) VALUES (1,1,'01:07:28 12/30');
INSERT INTO `Rezerwacja` (`Klient_id`,`Numer_stolika`,`Data`) VALUES (2,1,'01:07:28 12/30');
INSERT INTO `Rezerwacja` (`Klient_id`,`Numer_stolika`,`Data`) VALUES (3,7,'12:4:12 21/00');
INSERT INTO `Rezerwacja` (`Klient_id`,`Numer_stolika`,`Data`) VALUES (4,1,'03:04:15 13/20');
INSERT INTO `Rezerwacja` (`Klient_id`,`Numer_stolika`,`Data`) VALUES (8,1,'03:04:15 13/20');
INSERT INTO `Rezerwacja` (`Klient_id`,`Numer_stolika`,`Data`) VALUES (3,7,'12:9:12 21/00');
INSERT INTO `Rezerwacja` (`Klient_id`,`Numer_stolika`,`Data`) VALUES (4,1,'03:04:25 13/20');
INSERT INTO `Rezerwacja` (`Klient_id`,`Numer_stolika`,`Data`) VALUES (8,1,'03:04:25 13/20');


INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (15.6, '01:07:23 12/30' , 2 , 1 , 1);
INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (7.3, '01:07:23 12/30' , 1 , 1 , 1);
INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (4.5, '01:07:25 12/30' , 4 , 3 , 2);
INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (25, '01:08:23 12/30' , 7 , 5 , 1);
INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (15, '01:09:25 12/00' , 2 , 8 , 10);
INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (16, '02:07:23 12/30' , 8 , 4 , 3);
INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (5.6, '02:06:23 12/30' , 2 , 1 , 1);
INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (4.6, '01:08:23 12/30' , 8 , 2 , 4);
INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (3.7, '01:07:23 12/30' , 2 , 1 , 1);
INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (10.6, '01:09:23 12/30' , 5 , 4 , 2);
INSERT INTO `Zamówienie` (`Cena_zamówiena`, `Czas`, `Klient_id`, `Id_kelnera`, `Numer_stolika`) VALUES (11.6, '01:07:30 12/30' , 2 , 1 , 1);


INSERT INTO `Zamówione_dania` VALUES (1, 2 , 7);
INSERT INTO `Zamówione_dania` VALUES (1, 3, 2);
INSERT INTO `Zamówione_dania` VALUES (2, 2, 3);
INSERT INTO `Zamówione_dania` VALUES (2, 3, 4);
INSERT INTO `Zamówione_dania` VALUES (3, 4, 8);
INSERT INTO `Zamówione_dania` VALUES (4, 6, 7);
INSERT INTO `Zamówione_dania` VALUES (5, 8, 5);
INSERT INTO `Zamówione_dania` VALUES (6, 7, 4);
INSERT INTO `Zamówione_dania` VALUES (7, 4, 3);
INSERT INTO `Zamówione_dania` VALUES (8, 3, 4);
INSERT INTO `Zamówione_dania` VALUES (9, 6, 6);
INSERT INTO `Zamówione_dania` VALUES (10, 4, 4);
INSERT INTO `Zamówione_dania` VALUES (11, 10, 2);
INSERT INTO `Zamówione_dania` VALUES (11, 5, 1);


INSERT INTO `gotowanie` VALUES (1,1);
INSERT INTO `gotowanie` VALUES (1,2);
INSERT INTO `gotowanie` VALUES (1,3);
INSERT INTO `gotowanie` VALUES (2,4);
INSERT INTO `gotowanie` VALUES (3,7);
INSERT INTO `gotowanie` VALUES (3,5);
INSERT INTO `gotowanie` VALUES (4,3);
INSERT INTO `gotowanie` VALUES (4,9);
INSERT INTO `gotowanie` VALUES (5,6);
INSERT INTO `gotowanie` VALUES (6,4);
INSERT INTO `gotowanie` VALUES (7,3);
INSERT INTO `gotowanie` VALUES (8,7);
INSERT INTO `gotowanie` VALUES (9,9);
INSERT INTO `gotowanie` VALUES (10,4);
INSERT INTO `gotowanie` VALUES (10,6);

COMMIT;

 -- Zapytania
 -- Projekcja

SELECT `imię` , `nazwisko` FROM `klient`; -- Wybiera imię i nazwiko ze wzyskich rekordów tabeli `klient`
SELECT `imię` , `nazwisko` FROM `menadżer`; -- Wybiera imię i nazwiko ze wzyskich rekordów tabeli `menadżer`
SELECT `imię` , `nazwisko` FROM `kelner`;
SELECT `imię` , `nazwisko` FROM `kucharz`;
SELECT `numer_sali` , `opis` FROM `sala`;
SELECT `numer_stolika` , `liczba_osób` FROM `stolik`;
SELECT `nazwa` , `opis`, `obrazek` FROM `danie`;
SELECT `nazwa` , `opis` , `producent` FROM `składnik`;
SELECT `klient_id`, `Numer_stolika` FROM `rezerwacja`;
SELECT `czas`, `Cena_zamówiena` ,`Klient_id` FROM `zamówienie`;

-- selekcja
SELECT * FROM `klient` WHERE `Klient_id` = 4; -- Wybiera rekord z tabeli `Klient` `Klient_id` którego jest = 4
SELECT * FROM `klient` WHERE `Ocena` IN (4,5);  -- Wybiera rekordy z tabeli `Klient` `Ocena` którego jest = 4 lub = 5
SELECT * FROM `menadżer` WHERE `Data_zwolnienia` IS NOT NULL;
SELECT * FROM `kucharz` WHERE `Data_zwolnienia` IS NOT NULL;
SELECT * FROM `kelner` WHERE `Data_zwolnienia` IS NOT NULL;
SELECT * FROM `stolik` WHERE `Liczba_osób` = 3;
SELECT * FROM `danie` WHERE `cena` BETWEEN 1 AND 3;
SELECT * FROM `rezerwacja` WHERE `Numer_stolika` = 1;
SELECT * FROM `zamówienie` WHERE `Cena_zamówiena` BETWEEN 3 AND 14;
SELECT * FROM `sala` WHERE `Powierzchnia` >= 300 ORDER BY `Powierzchnia`;

-- join 2
SELECT  k.Klient_id, k.Imię, k.Nazwisko, z.Id_zamówienia, z.Numer_stolika, z.Cena_zamówiena, z.Czas FROM `klient` k INNER JOIN `zamówienie` z ON k.Klient_id = z.Klient_id ORDER BY z.czas; -- Łączy tabeli `klient` i `zamówienie` i sortuje wynik według atrybutu `czas`
SELECT  k.Klient_id, k.Imię, k.Nazwisko, r.Id_rezerwacji, r.Numer_stolika, r.Data FROM `klient` k INNER JOIN `rezerwacja` r ON k.Klient_id = r.Klient_id ORDER BY `Data`; -- Łączy tabeli `klient` i `rezerwacja` i sortuje wynik według atrybutu `Data`
SELECT * FROM `menadżer` m NATURAL INNER JOIN `sala` s WHERE m.`Data_zwolnienia` IS NULL ;
SELECT * FROM `kelner` k NATURAL INNER JOIN `zamówienie` z ORDER BY z.czas; 
SELECT * FROM `stolik` s NATURAL LEFT JOIN `rezerwacja` r ORDER BY `Liczba_osób`;
SELECT * FROM `stolik` s NATURAL INNER JOIN `zamówienie` z ORDER BY `Numer_stolika`; 
SELECT * FROM `danie` d NATURAL INNER JOIN `skład_dania` s ;
SELECT * FROM `danie` d NATURAL INNER JOIN `gotowanie` g ;
SELECT * FROM `kucharz` k NATURAL INNER JOIN `gotowanie` g ;
SELECT * FROM `kucharz` k INNER JOIN `kucharz` kr ON  k.`Id_kucharza` = kr.`Szef_kuchni`;

-- JOIN 3

SELECT m.Id_menadżera, m.Imię, m.Nazwisko, m.Plec, s.*, stolik.Numer_stolika, stolik.Liczba_osób FROM `menadżer` m NATURAL INNER JOIN (`sala` s NATURAL INNER JOIN `stolik`) ; -- Łączy 3 tabeli (`menadżer` , `sala` i `stolik`)
SELECT  k.Klient_id, k.Imię, k.Nazwisko, r.Id_rezerwacji, r.Numer_stolika,  s.Liczba_osób, s.Numer_sali, r.Data FROM (`klient` k INNER JOIN `rezerwacja` r ON k.`klient_id` = r.`Klient_id`) INNER JOIN `stolik` s ON s.Numer_stolika = r.Numer_stolika; -- Łączy 3 tabeli (`menadżer` , `sala` i `stolik`)
SELECT * FROM `kucharz` k NATURAL INNER JOIN (`gotowanie` g NATURAL INNER JOIN `danie`d );  -- Łączy 3 tabeli (`kucharz` ,`gotowanie` i `danie`)
SELECT * FROM `składnik`s  INNER JOIN  (`skład_dania` sd NATURAL INNER JOIN `danie`d ) ON s.Id_składnika = sd.Id_składnika;
SELECT * FROM (`zamówienie` z NATURAL INNER JOIN `zamówione_dania` zd ) INNER JOIN `danie` d ON zd.Id_dania = d.id_dania;
SELECT * FROM (`sala` s NATURAL INNER JOIN `stolik` st) INNER JOIN `zamówienie` z ON z.Numer_stolika = st.Numer_stolika;
SELECT * FROM (`kelner` k NATURAL INNER JOIN `zamówienie` z) INNER JOIN `klient` kl ON z.klient_id = kl.klient_id; 
SELECT * FROM `sala` s NATURAL INNER JOIN (`stolik` st NATURAL INNER JOIN `REZERWACJA`);
SELECT * FROM `zamówione_dania` zd NATURAL INNER JOIN (`danie` d NATURAL INNER JOIN `gotowanie` g);
SELECT * FROM `zamówione_dania` zd NATURAL INNER JOIN (`danie` d NATURAL INNER JOIN `skład_dania` sd);









