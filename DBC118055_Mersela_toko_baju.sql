/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 10.1.38-MariaDB : Database - toko_baju
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`toko_baju` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `toko_baju`;

/*Table structure for table `baju` */

DROP TABLE IF EXISTS `baju`;

CREATE TABLE `baju` (
  `no_baju` varchar(10) NOT NULL,
  `Ukuran_baju` varchar(20) DEFAULT NULL,
  `Kapasitas_Pesan` int(10) DEFAULT NULL,
  PRIMARY KEY (`no_baju`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `baju` */

insert  into `baju`(`no_baju`,`Ukuran_baju`,`Kapasitas_Pesan`) values 
('23','M',10),
('24','M',20),
('25','M',10),
('31','x',0);

/*Table structure for table `detailpesan` */

DROP TABLE IF EXISTS `detailpesan`;

CREATE TABLE `detailpesan` (
  `NoFaktur` varchar(10) DEFAULT NULL,
  `NoPesan` varchar(10) NOT NULL,
  `NamaMerek` varchar(20) DEFAULT NULL,
  `Banyak` int(10) DEFAULT NULL,
  `Biaya` int(10) DEFAULT NULL,
  PRIMARY KEY (`NoPesan`),
  KEY `NamaMerek` (`NamaMerek`),
  KEY `NoFaktur` (`NoFaktur`),
  CONSTRAINT `detailpesan_ibfk_1` FOREIGN KEY (`NamaMerek`) REFERENCES `merek` (`NamaMerek_baju`),
  CONSTRAINT `detailpesan_ibfk_2` FOREIGN KEY (`NoFaktur`) REFERENCES `pembayaran` (`NoFaktur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `detailpesan` */

insert  into `detailpesan`(`NoFaktur`,`NoPesan`,`NamaMerek`,`Banyak`,`Biaya`) values 
('K01','A1','adidas',2,200000),
('K02','A2','Eiger',4,1000000),
('K03','A3','oke',1,25000);

/*Table structure for table `merek` */

DROP TABLE IF EXISTS `merek`;

CREATE TABLE `merek` (
  `Id_merek` varchar(20) DEFAULT NULL,
  `NamaMerek_baju` varchar(20) NOT NULL,
  `Jenis_baju` varchar(30) DEFAULT NULL,
  `Harga` int(10) DEFAULT NULL,
  PRIMARY KEY (`NamaMerek_baju`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `merek` */

insert  into `merek`(`Id_merek`,`NamaMerek_baju`,`Jenis_baju`,`Harga`) values 
('A2','adidas','hoodie',100000),
('A3','Eiger','jaket',250000),
('A1','oke','kaos',25000);

/*Table structure for table `pembayaran` */

DROP TABLE IF EXISTS `pembayaran`;

CREATE TABLE `pembayaran` (
  `NoFaktur` varchar(10) NOT NULL,
  `Tanggal` date DEFAULT NULL,
  `Nobaju` varchar(10) DEFAULT NULL,
  `Jumlah_Pemesanan` int(10) DEFAULT NULL,
  `Total` int(10) DEFAULT NULL,
  `Diskon` int(10) DEFAULT NULL,
  `Total_Pembayaran` int(10) DEFAULT NULL,
  PRIMARY KEY (`NoFaktur`),
  KEY `Nobaju` (`Nobaju`),
  CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`Nobaju`) REFERENCES `baju` (`no_baju`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pembayaran` */

insert  into `pembayaran`(`NoFaktur`,`Tanggal`,`Nobaju`,`Jumlah_Pemesanan`,`Total`,`Diskon`,`Total_Pembayaran`) values 
('K01','2020-10-05','23',2,200000,10,180000),
('K02','2020-10-06','25',1,25000,50,17500),
('K03','2020-10-07','31',4,1000000,50,500000);

/* Function  structure for function  `lap` */

/*!50003 DROP FUNCTION IF EXISTS `lap` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `lap`(tanggal DATE) RETURNS varchar(100) CHARSET latin1
BEGIN
	DECLARE lap VARCHAR(100);

	SELECT CONCAT(Tanggal,' |', NoFaktur,' |', Nobaju,' |', Total_Pembayaran) AS 'Laporan Total Pemasukan Harian' INTO lap FROM pembayaran WHERE Tanggal=tanggal ;
	RETURN lap;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `hapusBaju` */

/*!50003 DROP PROCEDURE IF EXISTS  `hapusBaju` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `hapusBaju`(no_baju varchar(10))
BEGIN
		delete from baju where no_baju = no_baju;

	END */$$
DELIMITER ;

/* Procedure structure for procedure `tambahBaju` */

/*!50003 DROP PROCEDURE IF EXISTS  `tambahBaju` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `tambahBaju`(no_baju varchar(10),Ukuran_baju varchar(20),Kapasitas_Pesan int(10))
BEGIN
		INSERT INTO baju VALUES (no_baju, Ukuran_baju, Kapasitas_Pesan);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `tambahmerek` */

/*!50003 DROP PROCEDURE IF EXISTS  `tambahmerek` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `tambahmerek`(Id_merek varchar(20), NamaMerek_baju varchar(20), Jenis_baju varchar(30), Harga int(10))
BEGIN
		insert into merek VALUES (Id_merek, NamaMerek_baju, Jenis_baju, Harga);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateBaju` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateBaju` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBaju`(In no_baju VARCHAR(10),IN Ukuran_baju VARCHAR(20),IN Kapasitas_Pesan INT(10))
BEGIN
		update baju set Ukuran_baju = Ukuran_baju WHERE no_baju = no_baju;

	END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
