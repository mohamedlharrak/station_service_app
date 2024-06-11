-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 10, 2024 at 10:13 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `station_service`
--

-- --------------------------------------------------------

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
CREATE TABLE IF NOT EXISTS `stations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ville` varchar(100) DEFAULT NULL,
  `nom_station` varchar(100) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `prix_diesel` decimal(5,2) DEFAULT NULL,
  `prix_essence` decimal(5,2) DEFAULT NULL,
  `prix_services` text,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stations`
--

INSERT INTO `stations` (`id`, `ville`, `nom_station`, `logo_url`, `prix_diesel`, `prix_essence`, `prix_services`, `latitude`, `longitude`) VALUES
(1, 'Tanger', 'Afriquia', 'https://is2-ssl.mzstatic.com/image/thumb/Purple113/v4/f6/83/36/f68336dd-735f-12cc-725a-a6ae5ed3aa29/source/256x256bb.jpg', '12.25', '15.50', 'Car Wash = 50 DH, Tire Change = 120 DH', '35.74621700', '-5.84226700'),
(2, 'Tanger', 'Total', 'https://cdn.iconscout.com/icon/free/png-256/free-total-282691.png', '12.20', '15.45', 'Car Wash = 50 DH, Oil Change = 140 DH', '35.74621700', '-5.84226700'),
(3, 'Tanger', 'Shell', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr3wLmm3WESaGYTBKoGUtTXfew5ZWQJzo3-Q&s.png', '12.22', '15.48', 'Tire Change = 100 DH, Battery Check = 60 DH', '35.74621700', '-5.84226700'),
(4, 'Agadir', 'Afriquia', 'https://is2-ssl.mzstatic.com/image/thumb/Purple113/v4/f6/83/36/f68336dd-735f-12cc-725a-a6ae5ed3aa29/source/256x256bb.jpg', '12.30', '15.55', 'Car Wash = 50 DH, Fuel Injection Service = 40 DH', '35.74732410', '-5.84226700'),
(5, 'Agadir', 'Total', 'https://cdn.iconscout.com/icon/free/png-256/free-total-282691.png', '12.28', '15.53', 'Oil Change = 110 DH, Battery Check = 80 DH', '35.74621700', '-5.84226700');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
