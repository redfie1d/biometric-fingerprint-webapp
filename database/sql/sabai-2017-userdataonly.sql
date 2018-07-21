-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 21, 2018 at 03:46 PM
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
-- Table structure for table `consults`
--

DROP TABLE IF EXISTS `consults`;
CREATE TABLE IF NOT EXISTS `consults` (
  `consult_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) UNSIGNED NOT NULL,
  `date` varchar(100) NOT NULL,
  `doctor` varchar(255) NOT NULL,
  `notes` longtext NOT NULL,
  `diagnosis` longtext NOT NULL,
  `problems` varchar(255) NOT NULL,
  `urine_test` varchar(255) DEFAULT NULL,
  `hemocue_count` varchar(255) DEFAULT NULL,
  `blood_glucose` varchar(255) DEFAULT NULL,
  `referrals` varchar(255) DEFAULT NULL,
  `chronic_referral` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`consult_id`),
  KEY `visit_id` (`visit_id`)
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
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`medicine_name`)
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
  `visit_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_visit_id_fk` (`visit_id`)
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
  `date_of_birth` varchar(10) DEFAULT NULL,
  `drug_allergy` text,
  `parent` int(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `postreferrals`
--

DROP TABLE IF EXISTS `postreferrals`;
CREATE TABLE IF NOT EXISTS `postreferrals` (
  `postreferral_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) UNSIGNED NOT NULL,
  `date` varchar(100) DEFAULT NULL,
  `recorder` varchar(255) NOT NULL DEFAULT '',
  `remarks` longtext,
  PRIMARY KEY (`postreferral_id`),
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

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`name`, `username`, `password`, `account_type`) VALUES
('Admin', 'admin', 'sabaisuper2017', 'admin'),
('Dr Allyson Tan', 'allyson_tan', 'alum9', 'alumni'),
('Dr Angeline Lim', 'angeline_lim', 'acts4', 'acts'),
('Dr Anu Pandey', 'anu_pandey', 'acts9', 'acts'),
('Arturo Neo', 'arturo_neo', 'afterglow2', 'm4'),
('Dr Benjamin Tang', 'benjamin_tang', 'acts15', 'acts'),
('Cassandra Ang', 'cassandra_ang', 'afterglow1', 'm4'),
('Dr Charles Chuah', 'charles_chuah', 'acts6', 'acts'),
('Dr Christian Heng', 'christian_heng', 'alum5', 'alumni'),
('Dr Christopher Gn', 'christopher_gn', 'alum8', 'alumni'),
('Dr Christopher Wee', 'christopher_wee', 'acts3', 'acts'),
('Colin Quek', 'colin_quek', 'afterglow5', 'm4'),
('Dawne Lim', 'dawne_lim', 'afterglow3', 'm4'),
('Dr Deborah Lee', 'deborah_lee', 'acts12', 'acts'),
('Dr Gerard Low', 'gerard_low', 'acts2', 'acts'),
('Dr Hemashree Rajesh', 'hemashree_rajesh', 'acts11', 'acts'),
('Dr Joan Chin', 'joan_chin', 'acts5', 'acts'),
('Dr Joel Lee', 'joel_lee', 'alum4', 'alumni'),
('Dr John Hui', 'john_hui', 'acts7', 'acts'),
('Dr Kwong Seh Meng', 'kwong_sehmeng', 'alum7', 'alumni'),
('Dr Lawrence Ng', 'lawrence_ng', 'acts16', 'acts'),
('Maehanyi Frances', 'maehanyi_frances', 'afterglow4', 'm4'),
('Dr Ng Ee Yang', 'ng_eeyang', 'alum3', 'alumni'),
('Dr Penny Lo', 'penny_lo', 'acts8', 'acts'),
('Pharmacy', 'pharmacy', 'sabaipharm', 'pharmacy'),
('Dr Priscilla Lim', 'priscilla_lim', 'acts1', 'acts'),
('Dr Regina Tan', 'regina_tan', 'acts14', 'acts'),
('Registration', 'registration', 'sabai2017', 'registration'),
('Dr Rohan Puthran', 'rohan_puthran', 'alum2', 'alumni'),
('Student', 'student', 'sabai2017', 'student'),
('Dr Tan Juanmin', 'tan_juanmin', 'alum1', 'alumni'),
('Dr Teo Jia Hui', 'teo_jiahui', 'alum6', 'alumni'),
('Dr Vanessa Tan', 'vanessa_tan', 'acts10', 'acts'),
('Viewer', 'viewer', 'sabaipublic', 'viewer'),
('Dr Vinith Menezes', 'vinith_menezes', 'acts13', 'acts'),
('Vitals', 'vitals', 'sabai2017', 'vitals');

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

-- --------------------------------------------------------

--
-- Table structure for table `vitals`
--

DROP TABLE IF EXISTS `vitals`;
CREATE TABLE IF NOT EXISTS `vitals` (
  `vitals_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) UNSIGNED NOT NULL,
  `height` double UNSIGNED DEFAULT NULL,
  `weight` double UNSIGNED DEFAULT NULL,
  `systolic` double UNSIGNED DEFAULT NULL,
  `diastolic` double UNSIGNED DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `hiv_positive` int(11) DEFAULT NULL,
  `ptb_positive` int(11) DEFAULT NULL,
  `hepC_positive` int(11) NOT NULL,
  PRIMARY KEY (`vitals_id`),
  KEY `visit_id` (`visit_id`)
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
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_visit_id_fk` FOREIGN KEY (`visit_id`) REFERENCES `visits` (`id`);

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `patients` (`id`);

--
-- Constraints for table `postreferrals`
--
ALTER TABLE `postreferrals`
  ADD CONSTRAINT `visit_postreferral_fk` FOREIGN KEY (`visit_id`) REFERENCES `visits` (`id`);

--
-- Constraints for table `visits`
--
ALTER TABLE `visits`
  ADD CONSTRAINT `fk_visit_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);

--
-- Constraints for table `vitals`
--
ALTER TABLE `vitals`
  ADD CONSTRAINT `visit_vitals_fk` FOREIGN KEY (`visit_id`) REFERENCES `visits` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
