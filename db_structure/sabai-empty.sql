-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 03, 2017 at 06:48 AM
-- Server version: 5.7.19
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sabai`
--

-- --------------------------------------------------------

--
-- Table structure for table `allergies`
--

DROP TABLE IF EXISTS `allergies`;
CREATE TABLE IF NOT EXISTS `allergies` (
  `allergy_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `allergy_name` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`allergy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
CREATE TABLE IF NOT EXISTS `conditions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `condition_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `consults`
--

DROP TABLE IF EXISTS `consults`;
CREATE TABLE IF NOT EXISTS `consults` (
  `consult_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) UNSIGNED NOT NULL,
  `date` varchar(15) DEFAULT NULL,
  `doctor` varchar(255) NOT NULL,
  `notes` longtext NOT NULL,
  `diagnosis` longtext NOT NULL,
  `problems` varchar(255) NOT NULL,
  `urine_test` varchar(255) DEFAULT NULL,
  `hemocue_count` varchar(255) DEFAULT NULL,
  `blood_glucose` varchar(255) DEFAULT NULL,
  `referrals` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`consult_id`),
  KEY `visit_id` (`visit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `drugs`
--

DROP TABLE IF EXISTS `drugs`;
CREATE TABLE IF NOT EXISTS `drugs` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `drug` varchar(255) NOT NULL DEFAULT '',
  `dosage` varchar(255) NOT NULL DEFAULT '',
  `batch` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `per_consumption` text,
  `frequency` text,
  `default_qty_for_prescription` int(11) DEFAULT NULL,
  `dateOfModification` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fingerprint`
--

DROP TABLE IF EXISTS `fingerprint`;
CREATE TABLE IF NOT EXISTS `fingerprint` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) UNSIGNED NOT NULL,
  `fg_value` blob NOT NULL,
  `size` int(11) NOT NULL,
  `fg_image` mediumtext,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE IF NOT EXISTS `inventory` (
  `medicine_name` varchar(255) NOT NULL,
  `quantity` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orderlist`
--

DROP TABLE IF EXISTS `orderlist`;
CREATE TABLE IF NOT EXISTS `orderlist` (
  `order_id` int(10) UNSIGNED NOT NULL,
  `medicine_name` varchar(255) NOT NULL,
  `quantity` int(10) NOT NULL DEFAULT '0',
  `notes` varchar(255) NOT NULL DEFAULT '0',
  `remarks` varchar(255) NOT NULL DEFAULT '-',
  KEY `orderlist_order_id_fk` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `doctor` varchar(255) NOT NULL,
  `patient_id` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
CREATE TABLE IF NOT EXISTS `patients` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `village_prefix` varchar(5) NOT NULL,
  `name` varchar(255) DEFAULT '',
  `image` varchar(255) DEFAULT '',
  `contactNo` varchar(255) DEFAULT NULL,
  `gender` varchar(6) DEFAULT '',
  `travelling_time_to_village` int(11) DEFAULT NULL,
  `year_of_birth` int(11) UNSIGNED DEFAULT NULL,
  `drug_allergy` text,
  `parent` int(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
CREATE TABLE IF NOT EXISTS `prescriptions` (
  `prescript_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `consult_id` int(11) UNSIGNED NOT NULL,
  `drug` varchar(255) NOT NULL DEFAULT '',
  `frequency` varchar(255) NOT NULL DEFAULT '',
  `dosage` varchar(255) NOT NULL DEFAULT '',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `date` datetime DEFAULT NULL,
  `drug_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`prescript_id`),
  KEY `consult_med` (`consult_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `problems`
--

DROP TABLE IF EXISTS `problems`;
CREATE TABLE IF NOT EXISTS `problems` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `referrals`
--

DROP TABLE IF EXISTS `referrals`;
CREATE TABLE IF NOT EXISTS `referrals` (
  `referral_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `consult_id` int(11) UNSIGNED NOT NULL,
  `condition` varchar(255) DEFAULT NULL,
  `test` varchar(255) DEFAULT NULL,
  `parameters` varchar(255) DEFAULT NULL,
  `remarks` longtext,
  PRIMARY KEY (`referral_id`),
  KEY `consult_referral` (`consult_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `triages`
--

DROP TABLE IF EXISTS `triages`;
CREATE TABLE IF NOT EXISTS `triages` (
  `triage_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) UNSIGNED NOT NULL,
  `height` double UNSIGNED DEFAULT NULL,
  `weight` double UNSIGNED DEFAULT NULL,
  `systolic` double UNSIGNED DEFAULT NULL,
  `diastolic` double UNSIGNED DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `hiv_positive` int(11) DEFAULT NULL,
  `ptb_positive` int(11) DEFAULT NULL,
  `hepC_positive` int(11) NOT NULL,
  PRIMARY KEY (`triage_id`),
  KEY `visit_id` (`visit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `account_type` varchar(255) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `visits`
--

DROP TABLE IF EXISTS `visits`;
CREATE TABLE IF NOT EXISTS `visits` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) UNSIGNED NOT NULL,
  `date` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `consults`
--
ALTER TABLE `consults`
  ADD CONSTRAINT `consult_visit_id_fk` FOREIGN KEY (`visit_id`) REFERENCES `visits` (`id`);

--
-- Constraints for table `fingerprint`
--
ALTER TABLE `fingerprint`
  ADD CONSTRAINT `fg_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);

--
-- Constraints for table `orderlist`
--
ALTER TABLE `orderlist`
  ADD CONSTRAINT `orderlist_order_id_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `patients` (`id`);

--
-- Constraints for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `consult_med` FOREIGN KEY (`consult_id`) REFERENCES `consults` (`consult_id`);

--
-- Constraints for table `referrals`
--
ALTER TABLE `referrals`
  ADD CONSTRAINT `consult_referral` FOREIGN KEY (`consult_id`) REFERENCES `consults` (`consult_id`);

--
-- Constraints for table `triages`
--
ALTER TABLE `triages`
  ADD CONSTRAINT `visit_triage_fk` FOREIGN KEY (`visit_id`) REFERENCES `visits` (`id`);

--
-- Constraints for table `visits`
--
ALTER TABLE `visits`
  ADD CONSTRAINT `fk_visit_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
