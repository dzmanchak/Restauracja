-- DZMITRY MANCHAK
/**************************************************************************************************************************************************************************/
-- 1
DROP TABLE IF EXISTS `Producent`;

CREATE TABLE `Producent` 
(`Producent_id` INT NOT NULL AUTO_INCREMENT,
`Nazwa_producenta` Varchar(35),
`Producent_contact` Varchar(45),
`Adres_producenta` Varchar(60),
 CONSTRAINT `producent_id_pk` PRIMARY KEY (`Producent_id`)
) 
AS 
SELECT `Producent` AS `Nazwa_producenta`, `Producent_contact`, `Adres_producenta` FROM `składnik` GROUP BY `Producent`
;

ALTER TABLE `składnik` DROP COLUMN `Producent_contact`;
ALTER TABLE `składnik` DROP COLUMN `Adres_producenta`;

ALTER TABLE `składnik` ADD COLUMN `Producent_id` INT ;
UPDATE `składnik`, `Producent`  SET składnik.`Producent_id` = producent.`Producent_id` WHERE składnik.`Producent` = Producent.`Nazwa_producenta`;
ALTER TABLE `składnik` DROP COLUMN `Producent`;

ALTER TABLE `składnik` ADD CONSTRAINT `producent_składnik` FOREIGN KEY (`Producent_id`) REFERENCES `Producent` (`Producent_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE `składnik` MODIFY  `Producent_id` INT NOT NULL;

ALTER TABLE `Producent` MODIFY `Nazwa_producenta` Varchar(35) NOT NULL;
ALTER TABLE `Producent` MODIFY `Producent_contact` Varchar(45) NOT NULL;
ALTER TABLE `Producent` MODIFY `Adres_producenta` Varchar(60) NOT NULL;

SELECT * FROM `składnik` ;

SELECT * FROM `Producent`;
/********************************************************************************************************************************************************************************/
-- 2
DROP TABLE IF EXISTS `Komentarz`;

CREATE TABLE `Komentarz`
(`Komentarz_id` Int NOT NULL AUTO_INCREMENT,
 `Klient_id` Int,
 `Ocena` Int,
 `Komentaz` Varchar(600),
 `Data` DATETIME NOT NULL DEFAULT NOW(),
  CONSTRAINT `komentarz_ocena_check` CHECK (`Ocena` IN (1 , 2 , 3 , 4 , 5)),
  CONSTRAINT `komentarz_id_pk` PRIMARY KEY (`Komentarz_id`)
)
AS
SELECT `Klient_id`,`Ocena`, `Komentaz` FROM `Klient`;

ALTER TABLE `Komentarz` MODIFY `Klient_id` INT NOT NULL;
ALTER TABLE `Komentarz` ADD CONSTRAINT `klient_komentarz` FOREIGN KEY (`Klient_id`) REFERENCES `Klient` (`Klient_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `klient` DROP COLUMN `Ocena`;
ALTER TABLE `klient` DROP COLUMN `Komentaz`;

SELECT * FROM `Komentarz`;
SELECT * FROM `Klient`;
/***********************************************************************************************************************************************************************************/
-- 3

DROP TABLE IF EXISTS `Obrazek`;

CREATE TABLE `Obrazek`
(`Obrazek_id` INT NOT NULL AUTO_INCREMENT,
CONSTRAINT `obrazek_id_pk` PRIMARY KEY (`Obrazek_id`)
)
AS 
SELECT `Obrazek`, `Nazwa_obrazku` FROM `Danie`;

ALTER TABLE `Obrazek` ADD CONSTRAINT `nazwa_obrazku_ak` UNIQUE (`Nazwa_obrazku`);

ALTER TABLE `Danie` ADD COLUMN `Obrazek_id` INT;
UPDATE `Obrazek` o, `Danie` d SET d.`Obrazek_id` = o.`Obrazek_id` WHERE d.`Nazwa_obrazku` = o.`Nazwa_obrazku`;

ALTER TABLE `Danie` DROP COLUMN `Obrazek`;
ALTER TABLE `Danie` DROP COLUMN `Nazwa_obrazku`;

ALTER TABLE `Danie` ADD CONSTRAINT `obrazek_danie` FOREIGN KEY (`Obrazek_id`) REFERENCES `Obrazek` (`Obrazek_id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

SELECT * FROM `Obrazek`;
SELECT * FROM `danie`;
SHOW CHARACTER SET;
/****************************************************************************************************************************************************************************************/
COMMIT;