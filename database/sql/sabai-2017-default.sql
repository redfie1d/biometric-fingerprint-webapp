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

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`medicine_name`, `quantity`) VALUES
('1. Acetaminophen 325mg suppository*', 23),
('10. Antacid (with Simethicone) 250mg tab [Suntacid]', 1190),
('100. Prednisolone 5mg tab*', 1740),
('101. Promethazine 0.1g suspension 90ml*', 10),
('102. Promethazine 5mg/5ml suspension 100ml', 260),
('103. Ranitidine 150mg tab [Aciloc 150]', 130),
('104. Salbutamol 2mg tab*', 2122),
('105. Sennosides 7.5mg tab [Senokot]', 96),
('106. Tetracycline Eye Ointment 1% 3g*', 15),
('108. Tolbutamide 500mg tab*', 150),
('109. Tramadol HCl 50mg tab* [Acugesic, Pangesic]', 772),
('11. Antiseptic (Chlorhexidine Gluconate 0.1%) cream 15g* [Bacidin]', 65),
('110. Tranexamic acid 500mg tab [Cyklokapron]', 292),
('111. UU Care Feminine Wash 250ml', 2),
('112. Vitamin B1 (Thiamine) 10mg tab', 20),
('113. Vitamin B1 100mg, Vitamin B6 200mg, Vitamin B12 200mg tab [Daneuron, Neuroforte]', 1760),
('114. Vitamin C (Ascorbic acid) 100mg tab', 60),
('115. Vitamin C (Ascorbic acid) 250mg tab [High C-250]', 1800),
('116. Zecuf Lozenges', 48),
('117. Econazole Nitrate 1% cream 10g', 21),
('118. Metronidazole 500mg pessary* [Flagyl]', 15),
('119. Ylang Anti-Parasitic Shampoo', 50),
('12. Aqueous cream 100g', 21),
('120. Acyclovir 50mg cream 5g', 10),
('13. Atenolol 50mg tab*', 982),
('14. Atenolol 100mg tab* [Hypernol 100]', 30),
('15. Betamethasone Dipropionate 0.05%, Clotrimazole 1%, Gentamicin Suphate 0.1% cream 15g* [Combiderm]', 17),
('16. Betamethasone Dipropionate 0.05%, Clotrimazole 1%, Gentamicin Sulphate 0.1% cream 10g* [Gentrisone]', 46),
('17. Bisacodyl EC 5mg tab*', 712),
('18. Bisacodyl 10mg suppository', 50),
('19. Bromhexine HCl 8mg tab [Bislan]', 187),
('2. Acetylcysteine 600mg tab*', 16),
('20. Calcitonin 200IU Nasal Spray [Miacalcic Nasal 200]', 2),
('21. Calcium Acetate 667mg tab (Calcium Supplements)', 96),
('22. Calcium Carbonate 450mg, Vitamin D 200IU tab* [Calowlin]', 1962),
('23. Candid cream 20g*', 3),
('24. Carbonyl Iron Vitamins [Ironyl]', 50),
('25. Cefuroxime 250mg tab* [Zinnat]', 16),
('26. Cephalexin 250mg sachets', 216),
('27. Cephalexin 250mg tab', 700),
('28. Cetirizine HCl 10mg tab [Sunizine]', 3067),
('29. Charcoal 250mg tab', 650),
('3. Acyclovir cream 10g*', 17),
('30. Chloramphenicol 0.5% Eye/Ear Drops 5ml', 50),
('32. Chlorpheniramine Maleate 4mg tab* [Antamin, Piriton]', 1076),
('33. Cinnarizine 25mg tab [Cinna]', 1024),
('34. Ciprofloxacin 0.2% Ear Drops*', 4),
('35. Ciprofloxacin 500mg tab', 400),
('36. Clarithromycin 125mg/5ml suspension 60ml', 10),
('37. Clarithromycin 250mg tab*', 756),
('38. Clarithromycin 500mg tab', 60),
('39. Clobetasol Propionate 0.5mg cream 15g* [Dermosol]', 30),
('4. Acyclovir 200mg tab', 200),
('40. Clotrimazole Pessary*', 132),
('41. Co-amoxiclav 312.5mg/5ml suspension 60ml [Curam]', 21),
('42. Co-amoxiclav 625mg tab [Augmentin, Curam]', 240),
('43. Co-trimoxazole 400mg tab* [Bactrim]', 99),
('44. Dequalinum Lozenge 0.25mg tab', 1232),
('45. Dexamethasone 0.1%, Neomycin 0.35% Eye/Ear Drops 5ml* [Dextracin]', 34),
('46. Dextromethorphan 15mg tab', 1100),
('47. Diclofenac 25mg tab [Voltaren]', 1075),
('48. Diclofenac 50mg tab [Voltaren]', 2266),
('5. Albendazole 400mg/10ml Suspension [Zentel]', 5),
('50. Dimenhydrinate 50mg tab [Dimenate]', 420),
('51. Docusate Sodium 0.5% Ear Drops 10ml', 4),
('52. Domperidone 10mg tab* [Domper, Doridone]', 815),
('53. Doxycycline 100mg tab* [Doxyline]', 472),
('54. Emolin ointment 100mg*', 3),
('55. Erythromycin 200mg/5ml suspension 60ml* [Erogran]', 24),
('56. Erythromycin 250mg tab (D)', 390),
('57. Estradiol 10micrograms Vaginal Tablet* [Vagifem]', 31),
('58. Famotidine 20mg tab (D)', 3632),
('59. Ferrous Fumarate 200mg tab [Ferro-Tab]', 709),
('6. Amlodipine 5mg tab [Anlodin, Norvase]', 530),
('60. Fluconazole 150mg tab*', 4),
('61. Folic Acid 5mg tab*', 616),
('63. Gentamicin Sulphate 0.17% cream 15g', 24),
('64. Gliclazide 80mg tab* [Glimicron 80]', 175),
('65. Glipizide 5mg tab', 221),
('66. Glucosamine Sulphate 500mg tab [Hovid Cosamine]', 12),
('67. Hydrochlorothiazide 25mg tab* [Di-ertride]', 25),
('68. Hydrocortisone 1% cream 28g', 35),
('69. Hyoscine butylbromide 10mg tab [Buscopan, Hyomide]', 1258),
('7. Amoxicillin 125mg/5ml suspension 150ml (D)', 30),
('70. Hypromellose Eye Drops 10ml* [Genteal]', 29),
('71. Ibuprofen 400mg tab (D) [Neurofen]', 600),
('72. Indomethacin 25mg tab [Indomen]', 400),
('73. Ionized Zinc Lozenges (Butter Mint & Menthol)', 240),
('74. Ionized Zinc Lozenges (Peppermint & Menthol)', 240),
('75. Ketoconazole 2% cream 15g', 1),
('76. Ketoconazole 100mg tab', 200),
('77. Kizz Pastilles', 1733),
('78. Lacteol Fort Capsules', 278),
('79. Lacteol Fort Sachets*', 516),
('8. Amoxicillin 250mg tab (D)*', 1971),
('80. Lisinopril 20mg tab [Dapril 20]', 40),
('81. Loperamide 2mg tab', 1558),
('82. Loratadine 10mg tab [Carin, Loradine, Rinityn]', 2980),
('83. Macrogrol 4000 10g [Forlax 10g]', 8),
('84. Metformin HCl 500mg BP tab [Diabetmin]', 40),
('85. Methyl salicylate 25% liniment 50ml', 24),
('86. Metronidazole 200mg tab (D)', 625),
('87. Metronidazole and Nystatin 500mg pessary* [GynoMax]', 282),
('89. Multivitamins* [Daily Vit-M Tablets, R&D]', 1200),
('9. Antacid (Magnesium Hydroxide 200mg, Aluminium Hydroxide Gel Dried 200mg, Dimethylpolysiloxane 25mg) tab* [Macgel]', 960),
('90. Muscle Pain Reliever cream 25g [Nox Pain]', 61),
('91. Naproxen Sodium 275mg tab [Sunprox 275]', 50),
('92. Norethisterone 5mg tab [SonuLut]', 640),
('93. Ofloxacin 200mg tab* [Ofcin]', 1200),
('94. Omeprazole 20mg tab', 971),
('95. ORS Sachets 5.145g*', 18),
('96. Oxymetazoline HCL 0.01% Nose Drops 5ml', 54),
('97. Paracetamol 120mg/5ml suspension 100ml (D)', 42),
('98. Paracetamol 450mg/Orphenadrine Citrate 35mg [Anarex, Camgesic]', 2514),
('99. Paracetamol 500mg tab (D) [Paracil]', 3203);

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
