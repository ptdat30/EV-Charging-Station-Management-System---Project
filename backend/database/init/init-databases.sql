-- Set UTF-8 encoding for client connections
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET character_set_client = utf8mb4;
SET character_set_connection = utf8mb4;
SET character_set_results = utf8mb4;

-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.43 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for analytics_service_db
CREATE DATABASE IF NOT EXISTS `analytics_service_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `analytics_service_db`;

-- Dumping structure for table analytics_service_db.daily_reports
CREATE TABLE IF NOT EXISTS `daily_reports` (
  `report_id` bigint NOT NULL AUTO_INCREMENT,
  `average_session_duration` int DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `peak_hour_end` int DEFAULT NULL,
  `peak_hour_start` int DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `total_energy_consumed` decimal(15,2) DEFAULT NULL,
  `total_revenue` decimal(15,2) DEFAULT NULL,
  `total_sessions` int DEFAULT NULL,
  `unique_users` int DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `UKdbg8t2vpgghe0hlwucet0rg6d` (`report_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table analytics_service_db.daily_reports: ~0 rows (approximately)

-- Dumping structure for table analytics_service_db.revenue_reports
CREATE TABLE IF NOT EXISTS `revenue_reports` (
  `report_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `report_period` enum('daily','weekly','monthly','quarterly','yearly') COLLATE utf8mb4_unicode_ci NOT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `total_revenue` decimal(15,2) NOT NULL,
  `charging_revenue` decimal(15,2) DEFAULT NULL,
  `service_fee_revenue` decimal(15,2) DEFAULT NULL,
  `total_sessions` int DEFAULT NULL,
  `total_energy_sold` decimal(15,2) DEFAULT NULL COMMENT 'kWh',
  `payment_breakdown` json DEFAULT NULL COMMENT '{"wallet": 0, "e_wallet": 0, "card": 0, "cash": 0}',
  `top_stations` json DEFAULT NULL COMMENT '[{"station_id", "revenue", "sessions"}]',
  `comparison_previous_period` json DEFAULT NULL COMMENT '{"revenue_change_pct", "session_change_pct"}',
  `generated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `generated_by` bigint unsigned DEFAULT NULL COMMENT 'Reference to user_service (admin)',
  PRIMARY KEY (`report_id`),
  KEY `idx_period` (`period_start`,`period_end`),
  KEY `idx_report_period` (`report_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table analytics_service_db.revenue_reports: ~0 rows (approximately)

-- Dumping structure for table analytics_service_db.session_analytics
CREATE TABLE IF NOT EXISTS `session_analytics` (
  `analytics_id` bigint NOT NULL AUTO_INCREMENT,
  `charging_point_id` bigint DEFAULT NULL,
  `cost` decimal(15,2) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `day_of_week` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `energy_consumed` decimal(10,2) DEFAULT NULL,
  `hour_of_day` int DEFAULT NULL,
  `is_peak_hour` bit(1) DEFAULT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session_duration` int DEFAULT NULL,
  `session_id` bigint DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `station_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`analytics_id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table analytics_service_db.session_analytics: ~103 rows (approximately)
INSERT INTO `session_analytics` (`analytics_id`, `charging_point_id`, `cost`, `created_at`, `day_of_week`, `end_time`, `energy_consumed`, `hour_of_day`, `is_peak_hour`, `payment_method`, `session_duration`, `session_id`, `start_time`, `station_id`, `user_id`) VALUES
	(1, 1, 39090600.00, '2025-11-16 19:58:08.198089', 'FRIDAY', '2025-11-01 11:57:17.000000', 13030.20, 16, b'1', 'wallet', 21717, 1, '2025-10-17 09:59:51.000000', 1, 1),
	(2, 1, 39043800.00, '2025-11-16 19:58:08.255023', 'FRIDAY', '2025-11-01 11:57:13.000000', 13014.60, 17, b'1', 'cash', 21691, 2, '2025-10-17 10:25:43.000000', 1, 1),
	(3, 2, 7281180.00, '2025-11-16 19:58:08.268870', 'SATURDAY', '2025-10-20 15:14:32.000000', 2427.06, 2, b'0', 'cash', 4045, 3, '2025-10-17 19:49:25.000000', 1, 1),
	(4, 1, 30749400.00, '2025-11-16 19:58:08.282460', 'MONDAY', '2025-11-01 11:57:11.000000', 10249.80, 22, b'0', 'cash', 17083, 4, '2025-10-20 15:13:52.000000', 1, 1),
	(5, 1, 19413000.00, '2025-11-16 19:58:08.296815', 'SATURDAY', '2025-11-01 11:57:10.000000', 6471.00, 7, b'0', 'cash', 10785, 5, '2025-10-25 00:11:11.000000', 2, 1),
	(6, 1, 270.00, '2025-11-16 19:58:08.309919', 'SATURDAY', '2025-10-25 00:11:30.000000', 0.09, 7, b'0', 'wallet', 0, 6, '2025-10-25 00:11:20.000000', 1, 1),
	(7, 1, 1650.00, '2025-11-16 19:58:08.323322', 'SATURDAY', '2025-10-25 00:13:45.000000', 0.55, 7, b'0', 'wallet', 0, 7, '2025-10-25 00:12:50.000000', 1, 1),
	(8, 1, 180.00, '2025-11-16 19:58:08.338839', 'SATURDAY', '2025-10-25 00:15:14.000000', 0.06, 7, b'0', 'cash', 0, 8, '2025-10-25 00:15:07.000000', 1, 7),
	(9, 1, 240.00, '2025-11-16 19:58:08.353501', 'SATURDAY', '2025-10-25 02:57:35.000000', 0.08, 9, b'1', 'wallet', 0, 9, '2025-10-25 02:57:26.000000', 1, 1),
	(10, 1, 16050600.00, '2025-11-16 19:58:08.367052', 'SUNDAY', '2025-11-01 11:57:06.000000', 5350.20, 14, b'1', 'cash', 8917, 10, '2025-10-26 07:19:52.000000', 1, 1),
	(11, 1, 540.00, '2025-11-16 19:58:08.380796', 'SUNDAY', '2025-10-26 07:23:24.000000', 0.18, 14, b'1', 'wallet', 0, 11, '2025-10-26 07:23:05.000000', 19, 1),
	(12, 25, 19800.00, '2025-11-16 19:58:08.395780', 'FRIDAY', '2025-10-31 14:38:42.000000', 6.60, 21, b'0', 'cash', 11, 12, '2025-10-31 14:27:01.000000', 21, 11),
	(13, 45, 1800.00, '2025-11-16 19:58:08.410171', 'SATURDAY', '2025-10-31 19:01:04.000000', 0.60, 2, b'0', 'cash', 0, 13, '2025-10-31 19:00:40.000000', 41, 11),
	(14, 5, 1800.00, '2025-11-16 19:58:08.424327', 'SATURDAY', '2025-11-01 07:41:43.000000', 0.60, 14, b'1', 'wallet', 0, 14, '2025-11-01 07:41:31.000000', 1, 11),
	(15, 25, 1800.00, '2025-11-16 19:58:08.439653', 'SATURDAY', '2025-11-01 12:08:29.000000', 0.60, 19, b'1', 'cash', 1, 15, '2025-11-01 12:07:11.000000', 21, 8),
	(16, 45, 1800.00, '2025-11-16 19:58:08.457285', 'SATURDAY', '2025-11-01 12:11:43.000000', 0.60, 19, b'1', 'wallet', 1, 16, '2025-11-01 12:10:29.000000', 41, 8),
	(17, 46, 1800.00, '2025-11-16 19:58:08.471992', 'SATURDAY', '2025-11-01 12:24:15.000000', 0.60, 19, b'1', 'cash', 1, 17, '2025-11-01 12:23:00.000000', 42, 8),
	(18, 5, 5400.00, '2025-11-16 19:58:08.484712', 'SATURDAY', '2025-11-01 12:39:09.000000', 1.80, 19, b'1', 'cash', 3, 18, '2025-11-01 12:35:47.000000', 1, 11),
	(19, 26, 3600.00, '2025-11-16 19:58:08.499654', 'SATURDAY', '2025-11-01 12:59:20.000000', 1.20, 19, b'1', 'cash', 2, 19, '2025-11-01 12:57:07.000000', 22, 7),
	(20, 25, 1800.00, '2025-11-16 19:58:08.512594', 'SATURDAY', '2025-11-01 13:16:03.000000', 0.60, 20, b'1', 'cash', 1, 20, '2025-11-01 13:14:19.000000', 21, 15),
	(21, 25, 1800.00, '2025-11-16 19:58:08.527529', 'SATURDAY', '2025-11-01 13:25:33.000000', 0.60, 20, b'1', 'cash', 2, 21, '2025-11-01 13:23:33.000000', 21, 15),
	(22, 25, NULL, '2025-11-16 19:58:08.542183', 'SUNDAY', '2025-11-01 17:55:57.000000', NULL, 0, b'0', 'UNKNOWN', 4, 22, '2025-11-01 17:51:37.000000', 21, 15),
	(23, 5, 1296000.00, '2025-11-16 19:58:08.558426', 'SUNDAY', '2025-11-04 10:36:36.000000', 432.00, 18, b'1', 'cash', 2845, 23, '2025-11-02 11:11:12.000000', 1, 15),
	(24, 16, 1800.00, '2025-11-16 19:58:08.574416', 'TUESDAY', '2025-11-04 10:48:44.000000', 0.60, 17, b'1', 'cash', 1, 24, '2025-11-04 10:46:58.000000', 12, 15),
	(25, 25, 63000.00, '2025-11-16 19:58:08.587688', 'TUESDAY', '2025-11-04 17:04:36.000000', 21.00, 23, b'0', 'cash', 35, 25, '2025-11-04 16:29:00.000000', 21, 16),
	(26, 25, 3600.00, '2025-11-16 19:58:08.602046', 'WEDNESDAY', '2025-11-05 11:09:27.000000', 1.20, 18, b'1', 'cash', 2, 26, '2025-11-05 11:06:47.000000', 21, 15),
	(27, 25, 1800.00, '2025-11-16 19:58:08.612629', 'WEDNESDAY', '2025-11-05 11:11:13.000000', 0.60, 18, b'1', 'wallet', 0, 27, '2025-11-05 11:11:04.000000', 21, 15),
	(28, 25, 1800.00, '2025-11-16 19:58:08.626541', 'SUNDAY', '2025-11-09 12:44:22.000000', 0.60, 19, b'1', 'cash', 0, 28, '2025-11-09 12:44:14.000000', 21, 15),
	(29, 25, 1800.00, '2025-11-16 19:58:08.638926', 'SUNDAY', '2025-11-09 15:26:58.000000', 0.60, 22, b'0', 'cash', 1, 29, '2025-11-09 15:25:20.000000', 21, 15),
	(30, 25, 1800.00, '2025-11-16 19:58:08.658722', 'MONDAY', '2025-11-09 17:59:31.000000', 0.60, 0, b'0', 'cash', 0, 30, '2025-11-09 17:58:44.000000', 21, 15),
	(31, 25, 3600.00, '2025-11-16 19:58:08.670802', 'MONDAY', '2025-11-10 01:47:46.000000', 1.20, 8, b'1', 'wallet', 2, 31, '2025-11-10 01:45:39.000000', 21, 15),
	(32, 25, 10800.00, '2025-11-16 19:58:08.700689', 'MONDAY', '2025-11-10 01:58:13.000000', 3.60, 8, b'1', 'wallet', 6, 32, '2025-11-10 01:51:39.000000', 21, 15),
	(33, 25, 5400.00, '2025-11-16 19:58:08.713422', 'MONDAY', '2025-11-10 02:02:16.000000', 1.80, 8, b'1', 'cash', 3, 33, '2025-11-10 01:58:27.000000', 21, 15),
	(34, 25, 3600.00, '2025-11-16 19:58:08.726626', 'MONDAY', '2025-11-10 02:05:50.000000', 1.20, 9, b'1', 'cash', 2, 34, '2025-11-10 02:03:30.000000', 21, 15),
	(35, 25, 1800.00, '2025-11-16 19:58:08.738524', 'MONDAY', '2025-11-10 02:06:38.000000', 0.60, 9, b'1', 'cash', 0, 35, '2025-11-10 02:06:30.000000', 21, 15),
	(36, 25, 1800.00, '2025-11-16 19:58:08.750746', 'MONDAY', '2025-11-10 02:21:12.000000', 0.60, 9, b'1', 'wallet', 0, 36, '2025-11-10 02:21:03.000000', 21, 15),
	(37, 25, 1800.00, '2025-11-16 19:58:08.763463', 'MONDAY', '2025-11-10 02:22:41.000000', 0.60, 9, b'1', 'cash', 0, 37, '2025-11-10 02:22:29.000000', 21, 15),
	(38, 25, 1800.00, '2025-11-16 19:58:08.777345', 'MONDAY', '2025-11-10 02:23:49.000000', 0.60, 9, b'1', 'wallet', 0, 38, '2025-11-10 02:23:41.000000', 21, 15),
	(39, 46, 1800.00, '2025-11-16 19:58:08.790636', 'MONDAY', '2025-11-10 13:37:44.000000', 0.60, 20, b'1', 'cash', 0, 39, '2025-11-10 13:37:31.000000', 42, 15),
	(40, 25, 240000.00, '2025-11-16 19:58:08.804118', 'MONDAY', '2025-11-10 13:46:57.000000', 80.00, 20, b'1', 'wallet', 0, 40, '2025-11-10 13:46:46.000000', 21, 15),
	(41, 25, 240000.00, '2025-11-16 19:58:08.817779', 'MONDAY', '2025-11-10 13:53:32.000000', 80.00, 20, b'1', 'wallet', 0, 41, '2025-11-10 13:53:22.000000', 21, 15),
	(42, 25, 240000.00, '2025-11-16 19:58:08.829916', 'MONDAY', '2025-11-10 14:07:07.000000', 80.00, 21, b'0', 'wallet', 0, 42, '2025-11-10 14:06:57.000000', 21, 15),
	(43, 25, 240000.00, '2025-11-16 19:58:08.841675', 'MONDAY', '2025-11-10 14:49:03.000000', 80.00, 21, b'0', 'wallet', 0, 43, '2025-11-10 14:48:56.000000', 21, 15),
	(44, 25, 240000.00, '2025-11-16 19:58:08.853498', 'TUESDAY', '2025-11-10 18:04:21.000000', 80.00, 1, b'0', 'wallet', 0, 44, '2025-11-10 18:04:01.000000', 21, 15),
	(45, 25, 240000.00, '2025-11-16 19:58:08.864507', 'TUESDAY', '2025-11-10 18:11:20.000000', 80.00, 1, b'0', 'wallet', 0, 45, '2025-11-10 18:11:13.000000', 21, 15),
	(46, 25, 240000.00, '2025-11-16 19:58:08.875973', 'TUESDAY', '2025-11-10 18:27:19.000000', 80.00, 1, b'0', 'wallet', 0, 46, '2025-11-10 18:26:57.000000', 21, 15),
	(47, 25, 1800.00, '2025-11-16 19:58:08.888139', 'TUESDAY', '2025-11-10 18:30:10.000000', 0.60, 1, b'0', 'wallet', 1, 47, '2025-11-10 18:28:50.000000', 21, 15),
	(48, 25, 240000.00, '2025-11-16 19:58:08.901006', 'TUESDAY', '2025-11-10 18:35:04.000000', 80.00, 1, b'0', 'wallet', 0, 48, '2025-11-10 18:34:50.000000', 21, 15),
	(49, 25, 240000.00, '2025-11-16 19:58:08.912146', 'TUESDAY', '2025-11-11 15:48:38.000000', 80.00, 22, b'0', 'wallet', 0, 49, '2025-11-11 15:48:28.000000', 21, 15),
	(50, 25, 240000.00, '2025-11-16 19:58:08.924965', 'TUESDAY', '2025-11-11 15:49:36.000000', 80.00, 22, b'0', 'wallet', 0, 50, '2025-11-11 15:49:29.000000', 21, 15),
	(51, 25, 240000.00, '2025-11-16 19:58:08.937283', 'TUESDAY', '2025-11-11 15:51:24.000000', 80.00, 22, b'0', 'wallet', 1, 51, '2025-11-11 15:50:02.000000', 21, 15),
	(52, 25, 240000.00, '2025-11-16 19:58:08.948807', 'TUESDAY', '2025-11-11 15:51:52.000000', 80.00, 22, b'0', 'wallet', 0, 52, '2025-11-11 15:51:45.000000', 21, 15),
	(53, 25, 240000.00, '2025-11-16 19:58:08.961350', 'TUESDAY', '2025-11-11 16:10:23.000000', 80.00, 23, b'0', 'wallet', 1, 53, '2025-11-11 16:09:20.000000', 21, 15),
	(54, 5, 240000.00, '2025-11-16 19:58:08.972752', 'WEDNESDAY', '2025-11-12 05:58:31.000000', 80.00, 12, b'1', 'wallet', 0, 54, '2025-11-12 05:58:14.000000', 1, 15),
	(55, 5, 240000.00, '2025-11-16 19:58:08.985032', 'WEDNESDAY', '2025-11-12 06:38:04.000000', 80.00, 13, b'1', 'wallet', 0, 55, '2025-11-12 06:37:50.000000', 1, 15),
	(56, 25, 240000.00, '2025-11-16 19:58:08.998864', 'WEDNESDAY', '2025-11-12 06:45:35.000000', 80.00, 13, b'1', 'wallet', 0, 56, '2025-11-12 06:45:23.000000', 21, 15),
	(57, 25, 240000.00, '2025-11-16 19:58:09.010780', 'WEDNESDAY', '2025-11-12 10:33:25.000000', 80.00, 17, b'1', 'wallet', 0, 57, '2025-11-12 10:32:58.000000', 21, 15),
	(58, 25, 240000.00, '2025-11-16 19:58:09.023101', 'WEDNESDAY', '2025-11-12 10:34:00.000000', 80.00, 17, b'1', 'wallet', 0, 58, '2025-11-12 10:33:51.000000', 21, 15),
	(59, 25, 120000.00, '2025-11-16 19:58:09.034716', 'WEDNESDAY', '2025-11-12 11:37:38.000000', 80.00, 18, b'1', 'wallet', 0, 59, '2025-11-12 11:37:29.000000', 21, 15),
	(60, 25, 120000.00, '2025-11-16 19:58:09.047591', 'WEDNESDAY', '2025-11-12 11:38:59.000000', 80.00, 18, b'1', 'cash', 0, 60, '2025-11-12 11:38:03.000000', 21, 15),
	(61, 25, 1800.00, '2025-11-16 19:58:09.059981', 'WEDNESDAY', '2025-11-12 11:40:48.000000', 0.60, 18, b'1', 'cash', 0, 61, '2025-11-12 11:40:08.000000', 21, 17),
	(62, 25, 120000.00, '2025-11-16 19:58:09.071338', 'WEDNESDAY', '2025-11-12 16:59:08.000000', 80.00, 23, b'0', 'wallet', 0, 62, '2025-11-12 16:58:49.000000', 21, 15),
	(63, 25, 120000.00, '2025-11-16 19:58:09.081834', 'WEDNESDAY', '2025-11-12 16:59:46.000000', 80.00, 23, b'0', 'wallet', 0, 63, '2025-11-12 16:59:33.000000', 21, 15),
	(64, 25, 120000.00, '2025-11-16 19:58:09.096078', 'WEDNESDAY', '2025-11-12 17:00:22.000000', 80.00, 23, b'0', 'wallet', 0, 64, '2025-11-12 16:59:53.000000', 21, 15),
	(65, 25, 900.00, '2025-11-16 19:58:09.110707', 'THURSDAY', '2025-11-12 17:01:53.000000', 0.60, 0, b'0', 'wallet', 0, 65, '2025-11-12 17:01:00.000000', 21, 15),
	(66, 26, 120000.00, '2025-11-16 19:58:09.127376', 'THURSDAY', '2025-11-12 17:01:24.000000', 80.00, 0, b'0', 'wallet', 0, 66, '2025-11-12 17:01:14.000000', 22, 15),
	(67, 25, 240000.00, '2025-11-16 19:58:09.143034', 'THURSDAY', '2025-11-12 17:11:06.000000', 80.00, 0, b'0', 'wallet', 0, 67, '2025-11-12 17:10:58.000000', 21, 17),
	(68, 25, 7200.00, '2025-11-16 19:58:09.158932', 'THURSDAY', '2025-11-12 17:21:51.000000', 4.80, 0, b'0', 'wallet', 8, 68, '2025-11-12 17:13:34.000000', 21, 15),
	(69, 25, 4500.00, '2025-11-16 19:58:09.174167', 'THURSDAY', '2025-11-12 17:27:25.000000', 3.00, 0, b'0', 'wallet', 5, 69, '2025-11-12 17:22:05.000000', 21, 15),
	(70, 25, 96000.00, '2025-11-16 19:58:09.191591', 'THURSDAY', '2025-11-12 17:35:02.000000', 64.00, 0, b'0', 'wallet', 0, 70, '2025-11-12 17:34:47.000000', 21, 15),
	(71, 5, 192000.00, '2025-11-16 19:58:09.213048', 'THURSDAY', '2025-11-12 18:24:30.000000', 64.00, 1, b'0', 'wallet', 0, 71, '2025-11-12 18:24:10.000000', 1, 15),
	(72, 25, 96000.00, '2025-11-16 19:58:09.233790', 'THURSDAY', '2025-11-12 18:36:38.000000', 64.00, 1, b'0', 'wallet', 0, 72, '2025-11-12 18:35:40.000000', 21, 15),
	(73, 5, 192000.00, '2025-11-16 19:58:09.248970', 'THURSDAY', '2025-11-13 09:28:36.000000', 64.00, 16, b'1', 'cash', 1, 73, '2025-11-13 09:27:00.000000', 1, 18),
	(74, 5, 192000.00, '2025-11-16 19:58:09.264347', 'THURSDAY', '2025-11-13 09:30:09.000000', 64.00, 16, b'1', 'wallet', 0, 74, '2025-11-13 09:29:57.000000', 1, 18),
	(75, 5, 1319400.00, '2025-11-16 19:58:09.280348', 'THURSDAY', '2025-11-13 21:44:07.000000', 439.80, 16, b'1', 'cash', 733, 75, '2025-11-13 09:30:36.000000', 1, 18),
	(76, 25, 96000.00, '2025-11-16 19:58:09.296350', 'FRIDAY', '2025-11-13 22:05:17.000000', 64.00, 5, b'0', 'cash', 0, 76, '2025-11-13 22:04:27.000000', 21, 15),
	(77, 25, 96000.00, '2025-11-16 19:58:09.311055', 'FRIDAY', '2025-11-13 22:10:44.000000', 64.00, 5, b'0', 'wallet', 1, 77, '2025-11-13 22:09:43.000000', 21, 15),
	(78, 5, 96000.00, '2025-11-16 19:58:09.324263', 'FRIDAY', '2025-11-13 23:10:54.000000', 64.00, 6, b'0', 'wallet', 0, 78, '2025-11-13 23:10:18.000000', 1, 15),
	(79, 14, 96000.00, '2025-11-16 19:58:09.337559', 'SATURDAY', '2025-11-15 03:18:05.000000', 64.00, 10, b'1', 'wallet', 14, 79, '2025-11-15 03:03:40.000000', 10, 15),
	(80, 5, 60480.00, '2025-11-16 19:58:09.349423', 'SATURDAY', '2025-11-15 04:07:37.000000', 33.60, 10, b'1', 'wallet', 56, 80, '2025-11-15 03:11:17.000000', 1, 17),
	(81, 6, 1800.00, '2025-11-16 19:58:09.360677', 'SATURDAY', '2025-11-15 03:28:00.000000', 1.20, 10, b'1', 'wallet', 2, 81, '2025-11-15 03:25:17.000000', 2, 15),
	(82, 7, 27900.00, '2025-11-16 19:58:09.374463', 'SATURDAY', '2025-11-15 03:59:48.000000', 18.60, 10, b'1', 'wallet', 31, 82, '2025-11-15 03:28:23.000000', 3, 15),
	(83, 5, 115200.00, '2025-11-16 19:58:09.387185', 'SATURDAY', '2025-11-15 04:08:41.000000', 64.00, 11, b'1', 'wallet', 0, 83, '2025-11-15 04:08:28.000000', 1, 17),
	(84, 5, 115200.00, '2025-11-16 19:58:09.399979', 'SATURDAY', '2025-11-15 04:11:05.000000', 64.00, 11, b'1', 'cash', 0, 84, '2025-11-15 04:10:54.000000', 1, 17),
	(85, 5, 115200.00, '2025-11-16 19:58:09.413576', 'SATURDAY', '2025-11-15 04:24:52.000000', 64.00, 11, b'1', 'cash', 0, 85, '2025-11-15 04:24:43.000000', 1, 17),
	(86, 5, 96000.00, '2025-11-16 19:58:09.428286', 'SATURDAY', '2025-11-15 04:39:30.000000', 64.00, 11, b'1', 'wallet', 0, 86, '2025-11-15 04:39:12.000000', 1, 15),
	(87, 5, 192000.00, '2025-11-16 19:58:09.440689', 'SUNDAY', '2025-11-15 20:58:50.000000', 64.00, 3, b'0', 'wallet', 0, 87, '2025-11-15 20:58:39.000000', 1, 19),
	(88, 25, 192000.00, '2025-11-16 19:58:09.452027', 'SUNDAY', '2025-11-15 21:03:55.000000', 64.00, 3, b'0', 'cash', 4, 88, '2025-11-15 20:59:23.000000', 21, 19),
	(89, 5, 192000.00, '2025-11-16 19:58:09.467025', 'SUNDAY', '2025-11-15 21:04:36.000000', 64.00, 4, b'0', 'wallet', 0, 89, '2025-11-15 21:04:22.000000', 1, 19),
	(90, 25, 192000.00, '2025-11-16 19:58:09.481597', 'SUNDAY', '2025-11-15 21:04:51.000000', 64.00, 4, b'0', 'wallet', 0, 90, '2025-11-15 21:04:42.000000', 21, 19),
	(91, 25, 96000.00, '2025-11-17 04:56:21.055066', 'MONDAY', '2025-11-17 04:06:53.000000', 64.00, 11, b'1', 'cash', 2, 91, '2025-11-17 04:04:52.000000', 21, 15),
	(92, 26, 96000.00, '2025-11-17 04:56:21.110702', 'MONDAY', '2025-11-17 04:10:44.000000', 64.00, 11, b'1', 'wallet', 2, 92, '2025-11-17 04:08:19.000000', 22, 15),
	(93, 25, 1080.00, '2025-11-17 04:56:21.123534', 'MONDAY', '2025-11-17 04:09:34.000000', 0.60, 11, b'1', 'cash', 0, 93, '2025-11-17 04:09:19.000000', 21, 17),
	(94, 5, 96000.00, '2025-11-17 04:56:21.135149', 'MONDAY', '2025-11-17 04:12:57.000000', 64.00, 11, b'1', 'wallet', 0, 94, '2025-11-17 04:12:06.000000', 1, 15),
	(95, 25, 96000.00, '2025-11-17 04:56:21.144364', 'MONDAY', '2025-11-17 04:20:00.000000', 64.00, 11, b'1', 'wallet', 0, 95, '2025-11-17 04:19:44.000000', 21, 15),
	(96, 25, 96000.00, '2025-11-19 03:24:17.517355', 'TUESDAY', '2025-11-18 15:19:35.000000', 64.00, 22, b'0', 'wallet', 0, 96, '2025-11-18 15:19:22.000000', 21, 15),
	(97, 25, 96000.00, '2025-11-19 03:24:17.601498', 'TUESDAY', '2025-11-18 15:25:35.000000', 64.00, 22, b'0', 'wallet', 0, 97, '2025-11-18 15:25:18.000000', 21, 15),
	(98, 25, 96000.00, '2025-11-19 03:24:17.620166', 'TUESDAY', '2025-11-18 15:29:26.000000', 64.00, 22, b'0', 'wallet', 0, 98, '2025-11-18 15:28:32.000000', 21, 15),
	(99, 25, 96000.00, '2025-11-19 03:24:17.639208', 'TUESDAY', '2025-11-18 15:35:19.000000', 64.00, 22, b'0', 'wallet', 0, 99, '2025-11-18 15:35:07.000000', 21, 15),
	(100, 25, 96000.00, '2025-11-19 06:30:12.760396', 'WEDNESDAY', '2025-11-19 06:26:34.000000', 64.00, 13, b'1', 'wallet', 0, 100, '2025-11-19 06:25:56.000000', 21, 15),
	(101, 25, 96000.00, '2025-11-19 06:30:12.832485', 'WEDNESDAY', '2025-11-19 06:27:53.000000', 64.00, 13, b'1', 'wallet', 0, 101, '2025-11-19 06:27:43.000000', 21, 15),
	(102, 5, 2700.00, '2025-11-19 09:33:34.191485', 'WEDNESDAY', '2025-11-19 06:39:42.000000', 1.80, 13, b'1', 'UNKNOWN', 3, 102, '2025-11-19 06:36:02.000000', 1, 15),
	(103, 25, 96000.00, '2025-11-19 10:33:34.062303', 'WEDNESDAY', '2025-11-19 09:41:26.000000', 64.00, 16, b'1', 'cash', 0, 103, '2025-11-19 09:41:17.000000', 21, 15);

-- Dumping structure for table analytics_service_db.station_performance_daily
CREATE TABLE IF NOT EXISTS `station_performance_daily` (
  `record_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `station_id` bigint unsigned NOT NULL COMMENT 'Reference to station_service',
  `date` date NOT NULL,
  `total_sessions` int DEFAULT '0',
  `completed_sessions` int DEFAULT '0',
  `cancelled_sessions` int DEFAULT '0',
  `total_energy_delivered` decimal(12,2) DEFAULT '0.00' COMMENT 'kWh',
  `total_revenue` decimal(15,2) DEFAULT '0.00',
  `average_session_duration` int DEFAULT NULL COMMENT 'minutes',
  `average_charging_power` decimal(8,2) DEFAULT NULL COMMENT 'kW',
  `peak_hour_start` time DEFAULT NULL,
  `peak_hour_end` time DEFAULT NULL,
  `unique_users` int DEFAULT '0',
  `new_users` int DEFAULT '0',
  `charger_uptime_percentage` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `unique_station_date` (`station_id`,`date`),
  KEY `idx_station_id` (`station_id`),
  KEY `idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table analytics_service_db.station_performance_daily: ~0 rows (approximately)

-- Dumping structure for table analytics_service_db.system_metrics
CREATE TABLE IF NOT EXISTS `system_metrics` (
  `metric_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `total_stations` int DEFAULT NULL,
  `active_stations` int DEFAULT NULL,
  `total_chargers` int DEFAULT NULL,
  `available_chargers` int DEFAULT NULL,
  `total_users` int DEFAULT NULL,
  `active_users_today` int DEFAULT NULL,
  `new_users_today` int DEFAULT NULL,
  `total_sessions_today` int DEFAULT NULL,
  `total_energy_today` decimal(15,2) DEFAULT NULL,
  `total_revenue_today` decimal(15,2) DEFAULT NULL,
  `average_session_duration` int DEFAULT NULL,
  `charger_utilization_rate` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`metric_id`),
  UNIQUE KEY `date` (`date`),
  KEY `idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table analytics_service_db.system_metrics: ~0 rows (approximately)

-- Dumping structure for table analytics_service_db.user_activity_summary
CREATE TABLE IF NOT EXISTS `user_activity_summary` (
  `record_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `period_type` enum('daily','weekly','monthly','yearly') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_sessions` int DEFAULT '0',
  `total_energy_consumed` decimal(12,2) DEFAULT '0.00' COMMENT 'kWh',
  `total_spent` decimal(15,2) DEFAULT '0.00',
  `favorite_station_id` bigint unsigned DEFAULT NULL,
  `favorite_charger_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `average_soc_start` decimal(5,2) DEFAULT NULL,
  `average_soc_end` decimal(5,2) DEFAULT NULL,
  `most_active_day` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `most_active_hour` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `unique_user_period` (`user_id`,`period_start`,`period_end`,`period_type`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_period` (`period_start`,`period_end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table analytics_service_db.user_activity_summary: ~0 rows (approximately)


-- Dumping database structure for charging_service_db
CREATE DATABASE IF NOT EXISTS `charging_service_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `charging_service_db`;

-- Dumping structure for table charging_service_db.charging_alerts
CREATE TABLE IF NOT EXISTS `charging_alerts` (
  `alert_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `alert_type` enum('charging_started','charging_complete','target_reached','low_speed','error','payment_required') COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `sent_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`alert_id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_is_read` (`is_read`),
  CONSTRAINT `charging_alerts_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `charging_sessions` (`session_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table charging_service_db.charging_alerts: ~0 rows (approximately)

-- Dumping structure for table charging_service_db.charging_sessions
CREATE TABLE IF NOT EXISTS `charging_sessions` (
  `session_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `station_id` bigint unsigned NOT NULL COMMENT 'Reference to station_service',
  `charger_id` bigint unsigned NOT NULL COMMENT 'Reference to station_service',
  `session_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reserved_at` timestamp NULL DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `initial_soc` decimal(5,2) DEFAULT NULL COMMENT 'State of Charge %',
  `final_soc` decimal(5,2) DEFAULT NULL,
  `target_soc` decimal(5,2) DEFAULT NULL COMMENT 'User target %',
  `energy_consumed` decimal(10,2) DEFAULT NULL COMMENT 'kWh',
  `peak_power` decimal(8,2) DEFAULT NULL COMMENT 'kW',
  `average_power` decimal(8,2) DEFAULT NULL COMMENT 'kW',
  `session_status` enum('reserved','starting','charging','paused','completed','cancelled','failed','timeout') COLLATE utf8mb4_unicode_ci DEFAULT 'reserved',
  `qr_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancellation_reason` text COLLATE utf8mb4_unicode_ci,
  `failure_reason` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_paid` tinyint(1) DEFAULT '0',
  `payment_id` bigint DEFAULT NULL,
  `price_per_kwh` decimal(10,2) DEFAULT '3000.00' COMMENT 'Price per kWh at the time of session creation',
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `session_code` (`session_code`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_station_id` (`station_id`),
  KEY `idx_charger_id` (`charger_id`),
  KEY `idx_status` (`session_status`),
  KEY `idx_start_time` (`start_time`),
  KEY `idx_session_code` (`session_code`),
  KEY `idx_charging_sessions_is_paid` (`is_paid`),
  KEY `idx_charging_sessions_price_per_kwh` (`price_per_kwh`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table charging_service_db.charging_sessions: ~103 rows (approximately)
INSERT INTO `charging_sessions` (`session_id`, `user_id`, `station_id`, `charger_id`, `session_code`, `reserved_at`, `start_time`, `end_time`, `initial_soc`, `final_soc`, `target_soc`, `energy_consumed`, `peak_power`, `average_power`, `session_status`, `qr_code`, `cancellation_reason`, `failure_reason`, `created_at`, `updated_at`, `is_paid`, `payment_id`, `price_per_kwh`) VALUES
	(1, 1, 1, 1, '9a304d5c-9387-48bc-aa2d-2b3fbcdbf846', NULL, '2025-10-17 09:59:51', '2025-11-01 11:57:17', NULL, NULL, NULL, 13030.20, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-17 09:59:51', '2025-11-01 11:57:17', 0, NULL, 3000.00),
	(2, 1, 1, 1, 'b994c899-ad65-48cc-929a-b8940a92a3d8', NULL, '2025-10-17 10:25:43', '2025-11-01 11:57:13', NULL, NULL, NULL, 13014.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-17 10:25:43', '2025-11-01 11:57:13', 0, NULL, 3000.00),
	(3, 1, 1, 2, '1789b1d2-db8f-4e67-b1e2-db2ed3195658', NULL, '2025-10-17 19:49:25', '2025-10-20 15:14:32', NULL, NULL, NULL, 2427.06, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-17 19:49:25', '2025-10-20 15:14:32', 0, NULL, 3000.00),
	(4, 1, 1, 1, '288a8eca-811b-4e9f-9370-1f48b1bc381b', NULL, '2025-10-20 15:13:52', '2025-11-01 11:57:11', NULL, NULL, NULL, 10249.80, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-20 15:13:52', '2025-11-01 11:57:11', 0, NULL, 3000.00),
	(5, 1, 2, 1, '8ca19a00-69e3-4a83-a251-6ba0e17fda34', NULL, '2025-10-25 00:11:11', '2025-11-01 11:57:10', NULL, NULL, NULL, 6471.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-25 00:11:11', '2025-11-01 11:57:10', 0, NULL, 3000.00),
	(6, 1, 1, 1, '427caa77-a0a6-4d70-a3fe-cdc445e57d43', NULL, '2025-10-25 00:11:20', '2025-10-25 00:11:30', NULL, NULL, NULL, 0.09, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-25 00:11:20', '2025-10-25 00:11:30', 0, NULL, 3000.00),
	(7, 1, 1, 1, 'c093b7c3-39bc-4ba3-8b21-74212b64c910', NULL, '2025-10-25 00:12:50', '2025-10-25 00:13:45', NULL, NULL, NULL, 0.55, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-25 00:12:50', '2025-10-25 00:13:45', 0, NULL, 3000.00),
	(8, 7, 1, 1, 'eac0092a-d038-4fe3-baab-2878f9b2f82f', NULL, '2025-10-25 00:15:07', '2025-10-25 00:15:14', NULL, NULL, NULL, 0.06, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-25 00:15:07', '2025-10-25 00:15:14', 0, NULL, 3000.00),
	(9, 1, 1, 1, '331d28ee-c731-4b31-b98b-a10ef55e4229', NULL, '2025-10-25 02:57:26', '2025-10-25 02:57:35', NULL, NULL, NULL, 0.08, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-25 02:57:26', '2025-10-25 02:57:35', 0, NULL, 3000.00),
	(10, 1, 1, 1, '1ca46455-c41b-4528-9a2b-440a4be841a7', NULL, '2025-10-26 07:19:52', '2025-11-01 11:57:06', NULL, NULL, NULL, 5350.20, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-26 07:19:52', '2025-11-01 11:57:06', 0, NULL, 3000.00),
	(11, 1, 19, 1, 'a68e1ab7-2f8c-4bbe-a5be-bb0c0b6c46ea', NULL, '2025-10-26 07:23:05', '2025-10-26 07:23:24', NULL, NULL, NULL, 0.18, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-26 07:23:05', '2025-10-26 07:23:24', 0, NULL, 3000.00),
	(12, 11, 21, 25, 'c8c6625c-1dd2-48f1-87df-bbea45e5ddbf', NULL, '2025-10-31 14:27:01', '2025-10-31 14:38:42', NULL, NULL, NULL, 6.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-31 14:27:01', '2025-10-31 14:38:42', 0, NULL, 3000.00),
	(13, 11, 41, 45, 'b791283c-cb12-44d6-bf9b-27f8ec7e4d2f', NULL, '2025-10-31 19:00:40', '2025-10-31 19:01:04', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-10-31 19:00:40', '2025-10-31 19:01:04', 0, NULL, 3000.00),
	(14, 11, 1, 5, '7d9e74b3-bef3-4403-93b3-a404297fc001', NULL, '2025-11-01 07:41:31', '2025-11-01 07:41:43', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-01 07:41:31', '2025-11-01 07:41:43', 0, NULL, 3000.00),
	(15, 8, 21, 25, '24c32cd8-db61-42d4-905b-a71671255299', NULL, '2025-11-01 12:07:11', '2025-11-01 12:08:29', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-01 12:07:11', '2025-11-01 12:08:29', 0, NULL, 3000.00),
	(16, 8, 41, 45, 'a5a71208-cb90-400d-aa64-e59448601bf4', NULL, '2025-11-01 12:10:29', '2025-11-01 12:11:43', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-01 12:10:29', '2025-11-01 12:11:43', 0, NULL, 3000.00),
	(17, 8, 42, 46, '20e04b20-a1e1-4d15-ba5b-0653d6cc7e22', NULL, '2025-11-01 12:23:00', '2025-11-01 12:24:15', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-01 12:23:00', '2025-11-01 12:24:15', 0, NULL, 3000.00),
	(18, 11, 1, 5, '7a9d3586-0a24-4380-acea-a5ddeccce2ba', NULL, '2025-11-01 12:35:47', '2025-11-01 12:39:09', NULL, NULL, NULL, 1.80, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-01 12:35:47', '2025-11-01 12:39:09', 0, NULL, 3000.00),
	(19, 7, 22, 26, 'bd00a9e5-5405-42c1-8c01-cdd05e9c8113', NULL, '2025-11-01 12:57:07', '2025-11-01 12:59:20', NULL, NULL, NULL, 1.20, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-01 12:57:07', '2025-11-01 12:59:20', 0, NULL, 3000.00),
	(20, 15, 21, 25, 'af19ee2d-ddb9-4a6e-84a2-20c7537f0cc6', NULL, '2025-11-01 13:14:19', '2025-11-01 13:16:03', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-01 13:14:19', '2025-11-01 13:16:03', 0, NULL, 3000.00),
	(21, 15, 21, 25, 'df5048aa-339d-48c3-9060-8af20b0c307b', NULL, '2025-11-01 13:23:33', '2025-11-01 13:25:33', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-01 13:23:33', '2025-11-01 13:25:33', 0, NULL, 3000.00),
	(22, 15, 21, 25, '754f667a-4b84-40bd-8c02-6a9cf7301a3c', NULL, '2025-11-01 17:51:37', '2025-11-01 17:55:57', NULL, NULL, NULL, NULL, NULL, NULL, 'cancelled', NULL, NULL, NULL, '2025-11-01 17:51:37', '2025-11-01 17:55:57', 0, NULL, 3000.00),
	(23, 15, 1, 5, '50f9219b-ebfe-4ba0-ac8d-87c2dd5f9a29', NULL, '2025-11-02 11:11:12', '2025-11-04 10:36:36', NULL, NULL, NULL, 432.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-02 11:11:12', '2025-11-04 10:36:37', 0, NULL, 3000.00),
	(24, 15, 12, 16, 'f5c43110-f1cf-4e93-b702-c5b6c16082b5', NULL, '2025-11-04 10:46:58', '2025-11-04 10:48:44', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-04 10:46:58', '2025-11-04 10:48:44', 0, NULL, 3000.00),
	(25, 16, 21, 25, 'bc2476bd-d95b-4351-8640-b7a6f267dfaf', NULL, '2025-11-04 16:29:00', '2025-11-04 17:04:36', NULL, NULL, NULL, 21.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-04 16:29:00', '2025-11-04 17:04:36', 0, NULL, 3000.00),
	(26, 15, 21, 25, 'b4f52bc7-1c54-4f5f-958f-94f7dfd3ae01', NULL, '2025-11-05 11:06:47', '2025-11-05 11:09:27', NULL, NULL, NULL, 1.20, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-05 11:06:47', '2025-11-05 11:09:27', 0, NULL, 3000.00),
	(27, 15, 21, 25, '565077af-b61b-4eb2-b1ac-b8417cf8ba58', NULL, '2025-11-05 11:11:04', '2025-11-05 11:11:13', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-05 11:11:04', '2025-11-05 11:11:13', 0, NULL, 3000.00),
	(28, 15, 21, 25, 'd702e564-2815-4557-baa9-c1b4de617af3', NULL, '2025-11-09 12:44:14', '2025-11-09 12:44:22', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-09 12:44:14', '2025-11-09 18:00:02', 1, 38, 3000.00),
	(29, 15, 21, 25, '3687d000-e438-4bd0-bc74-5441490c27aa', NULL, '2025-11-09 15:25:20', '2025-11-09 15:26:58', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-09 15:25:20', '2025-11-09 15:26:58', 0, NULL, 3000.00),
	(30, 15, 21, 25, '046ee46e-edd6-4db8-9a57-5f6c5728f9df', NULL, '2025-11-09 17:58:44', '2025-11-09 17:59:31', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-09 17:58:44', '2025-11-09 17:59:31', 0, NULL, 3000.00),
	(31, 15, 21, 25, '85de7d2a-e6e8-4ce9-8a11-4fe3c6533e02', NULL, '2025-11-10 01:45:39', '2025-11-10 01:47:46', NULL, NULL, NULL, 1.20, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 01:45:39', '2025-11-10 01:47:52', 1, 39, 3000.00),
	(32, 15, 21, 25, 'fd2c2e47-481a-48c7-8247-3d6060b1b3f4', NULL, '2025-11-10 01:51:39', '2025-11-10 01:58:13', NULL, NULL, NULL, 3.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 01:51:39', '2025-11-10 01:58:20', 1, 40, 3000.00),
	(33, 15, 21, 25, '129629fb-8884-42e6-a3da-b9bd489e1416', NULL, '2025-11-10 01:58:27', '2025-11-10 02:02:16', NULL, NULL, NULL, 1.80, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 01:58:27', '2025-11-10 02:08:24', 1, 43, 3000.00),
	(34, 15, 21, 25, '8eebd286-b891-492a-bd0e-f90817db4151', NULL, '2025-11-10 02:03:30', '2025-11-10 02:05:50', NULL, NULL, NULL, 1.20, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 02:03:30', '2025-11-10 02:08:21', 1, 42, 3000.00),
	(35, 15, 21, 25, '43d02605-3f7c-4a29-ba3e-05c31f5467d3', NULL, '2025-11-10 02:06:30', '2025-11-10 02:06:38', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 02:06:30', '2025-11-10 02:06:38', 0, NULL, 3000.00),
	(36, 15, 21, 25, 'ea240550-d8e9-48f3-9ce4-649977c61221', NULL, '2025-11-10 02:21:03', '2025-11-10 02:21:12', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 02:21:03', '2025-11-10 02:21:31', 1, 44, 3000.00),
	(37, 15, 21, 25, 'd0ef7bd5-5bb0-4f1d-bbc7-9e35a16144c1', NULL, '2025-11-10 02:22:29', '2025-11-10 02:22:41', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 02:22:29', '2025-11-10 13:38:35', 1, 46, 3000.00),
	(38, 15, 21, 25, '21825e1a-62b0-46e3-9ae3-708bfa508cdd', NULL, '2025-11-10 02:23:41', '2025-11-10 02:23:49', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 02:23:41', '2025-11-10 02:23:58', 1, 45, 3000.00),
	(39, 15, 42, 46, 'baa3e2a5-5753-41e2-8bf8-01df9eeec672', NULL, '2025-11-10 13:37:31', '2025-11-10 13:37:44', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 13:37:31', '2025-11-10 13:38:38', 1, 47, 3000.00),
	(40, 15, 21, 25, 'f9a0ee48-279a-4343-82ff-dc516bbf85e1', NULL, '2025-11-10 13:46:46', '2025-11-10 13:46:57', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 13:46:46', '2025-11-10 13:47:08', 1, 48, 3000.00),
	(41, 15, 21, 25, '0a355657-ee9a-49a0-b0eb-0da8eae833c8', NULL, '2025-11-10 13:53:22', '2025-11-10 13:53:32', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 13:53:22', '2025-11-10 13:53:37', 1, 49, 3000.00),
	(42, 15, 21, 25, 'f7b4d118-b025-43bb-b329-64395eaf14eb', NULL, '2025-11-10 14:06:57', '2025-11-10 14:07:07', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 14:06:57', '2025-11-10 14:07:16', 1, 50, 3000.00),
	(43, 15, 21, 25, 'ea2ac4cc-c0b5-4fa3-b8ab-691e7a7ba0cf', NULL, '2025-11-10 14:48:56', '2025-11-10 14:49:03', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 14:48:56', '2025-11-10 14:49:10', 1, 51, 3000.00),
	(44, 15, 21, 25, '491c8f49-46f9-4eaf-a174-f2af4d140630', NULL, '2025-11-10 18:04:01', '2025-11-10 18:04:21', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 18:04:01', '2025-11-10 18:04:27', 1, 52, 3000.00),
	(45, 15, 21, 25, '5951a819-4c17-4381-b6bf-97720e77a293', NULL, '2025-11-10 18:11:13', '2025-11-10 18:11:20', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 18:11:13', '2025-11-10 18:11:26', 1, 53, 3000.00),
	(46, 15, 21, 25, '9bb84a75-a23b-40b8-a17c-3e8e3189f6b9', NULL, '2025-11-10 18:26:57', '2025-11-10 18:27:19', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 18:26:57', '2025-11-10 18:27:25', 1, 54, 3000.00),
	(47, 15, 21, 25, '91c5cd93-eba6-4a7f-b32b-64f23c362e14', NULL, '2025-11-10 18:28:50', '2025-11-10 18:30:10', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 18:28:50', '2025-11-10 18:30:40', 1, 56, 3000.00),
	(48, 15, 21, 25, '1276f502-4f34-4997-9a04-f07f659e5dfe', NULL, '2025-11-10 18:34:50', '2025-11-10 18:35:04', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-10 18:34:50', '2025-11-10 18:36:14', 1, 57, 3000.00),
	(49, 15, 21, 25, '836934a5-ac8c-477c-92a9-6ef29762db1c', NULL, '2025-11-11 15:48:28', '2025-11-11 15:48:38', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-11 15:48:28', '2025-11-11 15:49:16', 1, 58, 3000.00),
	(50, 15, 21, 25, '67451985-e7c7-4447-89da-fe44c254f549', NULL, '2025-11-11 15:49:29', '2025-11-11 15:49:36', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-11 15:49:29', '2025-11-11 15:50:09', 1, 60, 3000.00),
	(51, 15, 21, 25, '6cff832c-164e-4f74-845c-5c8809eb4153', NULL, '2025-11-11 15:50:02', '2025-11-11 15:51:24', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-11 15:50:02', '2025-11-11 15:51:35', 1, 62, 3000.00),
	(52, 15, 21, 25, 'c13a8c47-2d2f-4007-a144-f5e04cb06777', NULL, '2025-11-11 15:51:45', '2025-11-11 15:51:52', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-11 15:51:45', '2025-11-11 15:56:43', 1, 63, 3000.00),
	(53, 15, 21, 25, '5a069a6c-89b7-4efa-ba63-e9056ef9e383', NULL, '2025-11-11 16:09:20', '2025-11-11 16:10:23', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-11 16:09:20', '2025-11-11 16:10:27', 1, 64, 3000.00),
	(54, 15, 1, 5, '3236565f-b07f-4b0c-8d08-74111fd6f32c', NULL, '2025-11-12 05:58:14', '2025-11-12 05:58:31', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 05:58:14', '2025-11-12 06:00:13', 1, 65, 3000.00),
	(55, 15, 1, 5, '217b1228-b465-4ca9-87ad-abc25b6c2b1a', NULL, '2025-11-12 06:37:50', '2025-11-12 06:38:04', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 06:37:50', '2025-11-12 06:38:15', 1, 66, 3000.00),
	(56, 15, 21, 25, '8fe76bce-a95a-445c-873a-312951dd1db3', NULL, '2025-11-12 06:45:23', '2025-11-12 06:45:35', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 06:45:23', '2025-11-12 10:33:06', 1, 68, 3000.00),
	(57, 15, 21, 25, '2c7bcc9b-8056-4ce4-8809-b7dd3d58d82a', NULL, '2025-11-12 10:32:58', '2025-11-12 10:33:25', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 10:32:58', '2025-11-12 10:33:31', 1, 70, 3000.00),
	(58, 15, 21, 25, '358984a1-d207-4832-9667-a652e3a8585d', NULL, '2025-11-12 10:33:51', '2025-11-12 10:34:00', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 10:33:51', '2025-11-12 10:34:07', 1, 71, 3000.00),
	(59, 15, 21, 25, '70249d48-98b0-403d-bb1e-cc8a04b0ed0f', NULL, '2025-11-12 11:37:29', '2025-11-12 11:37:38', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 11:37:29', '2025-11-12 11:37:48', 1, 72, 1500.00),
	(60, 15, 21, 25, 'd5617eae-1a83-4117-aed5-31a39a544edd', NULL, '2025-11-12 11:38:03', '2025-11-12 11:38:59', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 11:38:03', '2025-11-12 11:39:01', 1, 73, 1500.00),
	(61, 17, 21, 25, '8fd77f9b-9935-4cdb-a282-48c4c63ab22e', NULL, '2025-11-12 11:40:08', '2025-11-12 11:40:48', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 11:40:08', '2025-11-12 11:41:02', 1, 75, 3000.00),
	(62, 15, 21, 25, '4fb2a802-f1f1-448d-a1c2-823a04f9ffda', NULL, '2025-11-12 16:58:49', '2025-11-12 16:59:08', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 16:58:49', '2025-11-12 16:59:25', 1, 76, 1500.00),
	(63, 15, 21, 25, '700a5d36-557a-4e30-b3f2-b758163b741e', NULL, '2025-11-12 16:59:33', '2025-11-12 16:59:46', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 16:59:33', '2025-11-12 17:00:03', 1, 78, 1500.00),
	(64, 15, 21, 25, 'd29f7bfb-c7c4-452f-b05f-9c9e80365175', NULL, '2025-11-12 16:59:53', '2025-11-12 17:00:22', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 16:59:53', '2025-11-12 17:01:08', 1, 80, 1500.00),
	(65, 15, 21, 25, 'e59ec035-0268-4279-811b-b81a16b18edb', NULL, '2025-11-12 17:01:00', '2025-11-12 17:01:53', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 17:01:00', '2025-11-12 17:01:57', 1, 83, 1500.00),
	(66, 15, 22, 26, '52e456e7-6cda-4098-bfe3-87aae31e1634', NULL, '2025-11-12 17:01:14', '2025-11-12 17:01:24', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 17:01:14', '2025-11-12 17:01:47', 1, 82, 1500.00),
	(67, 17, 21, 25, '4c464329-0ab0-40a7-af06-d10c84989a51', NULL, '2025-11-12 17:10:58', '2025-11-12 17:11:06', NULL, NULL, NULL, 80.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 17:10:58', '2025-11-12 17:14:40', 1, 85, 3000.00),
	(68, 15, 21, 25, 'ef95a0a2-00c1-4c98-b80d-e6455689d033', NULL, '2025-11-12 17:13:34', '2025-11-12 17:21:51', NULL, NULL, NULL, 4.80, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 17:13:34', '2025-11-12 17:21:56', 1, 86, 1500.00),
	(69, 15, 21, 25, '36aa8632-b6b3-4b19-93ac-2a54f37ae7d2', NULL, '2025-11-12 17:22:05', '2025-11-12 17:27:25', NULL, NULL, NULL, 3.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 17:22:05', '2025-11-12 17:27:30', 1, 87, 1500.00),
	(70, 15, 21, 25, 'c538a91a-4071-4be1-a5fc-abc3dcbb49e7', NULL, '2025-11-12 17:34:47', '2025-11-12 17:35:02', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 17:34:47', '2025-11-12 17:35:06', 1, 88, 1500.00),
	(71, 15, 1, 5, 'ffb21a4c-d19e-4ade-b9e8-f367f52b28d4', NULL, '2025-11-12 18:24:10', '2025-11-12 18:24:30', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 18:24:10', '2025-11-12 18:35:49', 1, 90, 3000.00),
	(72, 15, 21, 25, '39ff5a4a-9e5d-460c-bf3c-146704c80936', NULL, '2025-11-12 18:35:40', '2025-11-12 18:36:38', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-12 18:35:40', '2025-11-12 18:36:45', 1, 92, 1500.00),
	(73, 18, 1, 5, '606b5d56-40f9-4787-ac70-2cd99ecb9c57', NULL, '2025-11-13 09:27:00', '2025-11-13 09:28:36', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-13 09:27:00', '2025-11-13 09:28:36', 0, NULL, 3000.00),
	(74, 18, 1, 5, '3d83191e-f99e-4a8d-ac76-40019525c7e6', NULL, '2025-11-13 09:29:57', '2025-11-13 09:30:09', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-13 09:29:57', '2025-11-13 09:30:46', 1, 95, 3000.00),
	(75, 18, 1, 5, 'dd5c1d91-36cd-4d31-a5cf-b6dd2ee3f747', NULL, '2025-11-13 09:30:36', '2025-11-13 21:44:07', NULL, NULL, NULL, 439.80, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-13 09:30:36', '2025-11-13 21:44:07', 0, NULL, 3000.00),
	(76, 15, 21, 25, 'd121d78a-7a39-4dbf-b534-af8a152d0598', NULL, '2025-11-13 22:04:27', '2025-11-13 22:05:17', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-13 22:04:27', '2025-11-13 22:10:01', 1, 98, 1500.00),
	(77, 15, 21, 25, 'f9e2146f-047b-4f8e-98f5-69b5214d9d03', NULL, '2025-11-13 22:09:43', '2025-11-13 22:10:44', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-13 22:09:43', '2025-11-13 23:10:30', 1, 100, 1500.00),
	(78, 15, 1, 5, 'bf0401bb-724c-430c-a198-9623248d7087', NULL, '2025-11-13 23:10:18', '2025-11-13 23:10:54', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-13 23:10:18', '2025-11-15 03:04:42', 1, 102, 1500.00),
	(79, 15, 10, 14, 'da69f259-7cd4-48de-bc30-0976b07b1ddd', NULL, '2025-11-15 03:03:40', '2025-11-15 03:18:05', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 03:03:40', '2025-11-15 03:24:37', 1, 104, 1500.00),
	(80, 17, 1, 5, 'e263c132-bbd4-4d08-a0db-ceff3b599830', NULL, '2025-11-15 03:11:17', '2025-11-15 04:07:37', NULL, NULL, NULL, 33.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 03:11:17', '2025-11-15 04:07:48', 1, 109, 1800.00),
	(81, 15, 2, 6, 'a0a586fa-1cd9-4728-916b-dfcda9116e23', NULL, '2025-11-15 03:25:17', '2025-11-15 03:28:00', NULL, NULL, NULL, 1.20, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 03:25:17', '2025-11-15 03:28:06', 1, 105, 1500.00),
	(82, 15, 3, 7, '267337c2-0343-4f9a-b704-939c86044bc2', NULL, '2025-11-15 03:28:23', '2025-11-15 03:59:48', NULL, NULL, NULL, 18.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 03:28:23', '2025-11-15 04:00:00', 1, 107, 1500.00),
	(83, 17, 1, 5, '22a7db22-d8dd-4fd6-a3d2-cbe5162a66ff', NULL, '2025-11-15 04:08:28', '2025-11-15 04:08:41', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 04:08:28', '2025-11-15 04:08:55', 1, 111, 1800.00),
	(84, 17, 1, 5, '9c027029-684a-46ff-b0a1-997cc8011f33', NULL, '2025-11-15 04:10:54', '2025-11-15 04:11:05', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 04:10:54', '2025-11-15 04:39:51', 1, 112, 1800.00),
	(85, 17, 1, 5, '429a2d28-f94e-4763-b2c2-f33145777e23', NULL, '2025-11-15 04:24:43', '2025-11-15 04:24:52', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 04:24:43', '2025-11-15 04:39:47', 1, 113, 1800.00),
	(86, 15, 1, 5, '304a396a-8f09-417f-92ed-7714fcdf59ae', NULL, '2025-11-15 04:39:12', '2025-11-15 04:39:30', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 04:39:12', '2025-11-15 05:21:48', 1, 115, 1500.00),
	(87, 19, 1, 5, '73e9c7db-1f0d-4229-a206-f51fa899791a', NULL, '2025-11-15 20:58:39', '2025-11-15 20:58:50', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 20:58:39', '2025-11-15 21:03:44', 1, 117, 3000.00),
	(88, 19, 21, 25, '339b7283-d8e5-434b-a8ed-7b5557bc47ae', NULL, '2025-11-15 20:59:23', '2025-11-15 21:03:55', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 20:59:23', '2025-11-15 21:04:06', 1, 118, 3000.00),
	(89, 19, 1, 5, '69efcbd3-46a3-4696-818c-5406cc80b8b0', NULL, '2025-11-15 21:04:22', '2025-11-15 21:04:36', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 21:04:22', '2025-11-15 21:04:37', 1, 119, 3000.00),
	(90, 19, 21, 25, '02d2a1da-2a1d-471e-a0a3-b0cb0136af81', NULL, '2025-11-15 21:04:42', '2025-11-15 21:04:51', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-15 21:04:42', '2025-11-15 21:04:53', 1, 120, 3000.00),
	(91, 15, 21, 25, '33132ce9-b299-4885-864d-9a14275f0480', NULL, '2025-11-17 04:04:52', '2025-11-17 04:06:53', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-17 04:04:52', '2025-11-17 04:07:40', 1, 121, 1500.00),
	(92, 15, 22, 26, '18830fad-03fb-4dc1-8c85-527a74dcc690', NULL, '2025-11-17 04:08:19', '2025-11-17 04:10:44', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-17 04:08:19', '2025-11-17 04:11:16', 1, 125, 1500.00),
	(93, 17, 21, 25, 'ba779fb0-abac-43d3-9051-c41f6df867e7', NULL, '2025-11-17 04:09:19', '2025-11-17 04:09:34', NULL, NULL, NULL, 0.60, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-17 04:09:19', '2025-11-17 04:10:10', 1, 123, 1800.00),
	(94, 15, 1, 5, '7fb7387c-f47e-402b-92a6-2540073320a1', NULL, '2025-11-17 04:12:06', '2025-11-17 04:12:57', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-17 04:12:06', '2025-11-17 04:13:12', 1, 127, 1500.00),
	(95, 15, 21, 25, 'aa24df83-2c8a-4e35-a82c-b0e9434e9cc2', NULL, '2025-11-17 04:19:44', '2025-11-17 04:20:00', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-17 04:19:44', '2025-11-18 15:05:37', 1, 129, 1500.00),
	(96, 15, 21, 25, 'fd105d9e-4be8-4b30-b04e-a1360a837eb9', NULL, '2025-11-18 15:19:22', '2025-11-18 15:19:35', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-18 15:19:22', '2025-11-18 15:19:36', 1, 130, 1500.00),
	(97, 15, 21, 25, 'd187b041-581a-4695-b504-67ca2c644660', NULL, '2025-11-18 15:25:18', '2025-11-18 15:25:35', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-18 15:25:18', '2025-11-18 15:25:37', 1, 131, 1500.00),
	(98, 15, 21, 25, '1a725144-ee06-4620-a304-f925555abf86', NULL, '2025-11-18 15:28:32', '2025-11-18 15:29:26', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-18 15:28:32', '2025-11-18 15:31:30', 1, 133, 1500.00),
	(99, 15, 21, 25, 'ebf1dae1-c90b-4cf5-8e66-ca1256bdda16', NULL, '2025-11-18 15:35:07', '2025-11-18 15:35:19', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-18 15:35:07', '2025-11-18 15:35:21', 1, 134, 1500.00),
	(100, 15, 21, 25, '7bc68bbf-8f85-47aa-a48d-d411085fecd4', NULL, '2025-11-19 06:25:56', '2025-11-19 06:26:34', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-19 06:25:56', '2025-11-19 06:26:39', 1, 135, 1500.00),
	(101, 15, 21, 25, 'be8f0ae5-e19a-49b5-bd98-d8ac1f077b37', NULL, '2025-11-19 06:27:43', '2025-11-19 06:27:53', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-19 06:27:43', '2025-11-19 06:28:47', 1, 136, 1500.00),
	(102, 15, 1, 5, '8470a062-895b-44f6-b5cb-ff93c88b8d22', NULL, '2025-11-19 06:36:02', '2025-11-19 06:39:42', NULL, NULL, NULL, 1.80, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-19 06:36:02', '2025-11-19 06:39:44', 1, 137, 1500.00),
	(103, 15, 21, 25, '60f43bad-b193-4d97-82d3-42531f365f29', NULL, '2025-11-19 09:41:17', '2025-11-19 09:41:26', NULL, NULL, NULL, 64.00, NULL, NULL, 'completed', NULL, NULL, NULL, '2025-11-19 09:41:17', '2025-11-23 07:43:59', 1, 141, 1500.00);

-- Dumping structure for table charging_service_db.reservations
CREATE TABLE IF NOT EXISTS `reservations` (
  `reservation_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `station_id` bigint unsigned NOT NULL COMMENT 'Reference to station_service',
  `charger_id` bigint unsigned DEFAULT NULL COMMENT 'Can be null for any available charger',
  `session_id` bigint unsigned DEFAULT NULL,
  `reserved_start_time` timestamp NOT NULL,
  `reserved_end_time` timestamp NOT NULL,
  `duration_minutes` int NOT NULL,
  `status` enum('pending','confirmed','active','completed','cancelled','expired','no_show') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `qr_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confirmation_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancellation_reason` text COLLATE utf8mb4_unicode_ci,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `check_in_deadline` datetime(6) DEFAULT NULL,
  `check_in_time` datetime(6) DEFAULT NULL,
  `deposit_amount` decimal(15,2) DEFAULT NULL,
  `deposit_payment_id` bigint DEFAULT NULL,
  `deposit_refunded` bit(1) DEFAULT NULL,
  `is_checked_in` bit(1) DEFAULT NULL,
  `no_show_count` int DEFAULT NULL,
  `no_show_penalty_applied` bit(1) DEFAULT NULL,
  `reminder_sent` bit(1) DEFAULT NULL,
  `reminder_sent_at` datetime(6) DEFAULT NULL,
  `priority_level` int DEFAULT '0',
  `subscription_package` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_station_id` (`station_id`),
  KEY `idx_charger_id` (`charger_id`),
  KEY `idx_status` (`status`),
  KEY `idx_reserved_start_time` (`reserved_start_time`),
  KEY `session_id` (`session_id`),
  KEY `idx_reservations_priority_level` (`priority_level`),
  KEY `idx_reservations_subscription_package` (`subscription_package`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `charging_sessions` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table charging_service_db.reservations: ~27 rows (approximately)
INSERT INTO `reservations` (`reservation_id`, `user_id`, `station_id`, `charger_id`, `session_id`, `reserved_start_time`, `reserved_end_time`, `duration_minutes`, `status`, `qr_code`, `confirmation_code`, `cancellation_reason`, `cancelled_at`, `created_at`, `updated_at`, `check_in_deadline`, `check_in_time`, `deposit_amount`, `deposit_payment_id`, `deposit_refunded`, `is_checked_in`, `no_show_count`, `no_show_penalty_applied`, `reminder_sent`, `reminder_sent_at`, `priority_level`, `subscription_package`) VALUES
	(25, 11, 21, 25, 12, '2025-10-31 16:00:00', '2025-10-31 17:00:00', 60, 'active', 'RES:25:7176EE4E', '7176EE4E', NULL, NULL, '2025-10-31 14:14:25', '2025-10-31 14:27:05', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(26, 11, 41, 45, NULL, '2025-10-31 16:00:00', '2025-10-31 17:00:00', 60, 'no_show', 'RES:26:87D3ED67', '87D3ED67', NULL, NULL, '2025-10-31 14:26:33', '2025-10-31 17:15:29', NULL, NULL, NULL, NULL, b'0', b'0', 1, b'1', b'1', '2025-10-31 22:01:07.998800', 0, NULL),
	(27, 11, 41, 45, 13, '2025-10-31 21:00:00', '2025-10-31 22:00:00', 60, 'active', 'RES:27:2B6AAE37', '2B6AAE37', NULL, NULL, '2025-10-31 19:00:15', '2025-10-31 19:00:45', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(28, 11, 1, 5, 14, '2025-11-01 09:00:00', '2025-11-01 10:00:00', 60, 'active', 'RES:28:D3E070A5', 'D3E070A5', NULL, NULL, '2025-11-01 07:40:07', '2025-11-01 07:41:35', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(29, 11, 22, 26, NULL, '2025-11-01 10:00:00', '2025-11-01 11:00:00', 60, 'cancelled', 'RES:29:0CAFF205', '0CAFF205', 'aaaaaaa', '2025-11-01 08:05:07', '2025-11-01 08:04:46', '2025-11-01 08:05:07', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(30, 8, 21, 25, 15, '2025-11-01 14:00:00', '2025-11-01 15:00:00', 60, 'active', 'RES:30:CB65CBA6', 'CB65CBA6', NULL, NULL, '2025-11-01 12:06:56', '2025-11-01 12:07:14', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(31, 8, 41, 45, 16, '2025-11-01 14:00:00', '2025-11-01 15:00:00', 60, 'active', 'RES:31:B47E5AA6', 'B47E5AA6', NULL, NULL, '2025-11-01 12:09:40', '2025-11-01 12:10:33', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(32, 8, 42, 46, 17, '2025-11-01 14:00:00', '2025-11-01 15:00:00', 60, 'active', 'RES:32:BC090101', 'BC090101', NULL, NULL, '2025-11-01 12:22:42', '2025-11-01 12:23:04', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(33, 11, 1, 5, 18, '2025-11-01 14:00:00', '2025-11-01 15:00:00', 60, 'active', 'RES:33:3D0F1F67', '3D0F1F67', NULL, NULL, '2025-11-01 12:35:34', '2025-11-01 12:35:50', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(34, 7, 22, 26, 19, '2025-11-01 14:00:00', '2025-11-01 15:00:00', 60, 'active', 'RES:34:739E8356', '739E8356', NULL, NULL, '2025-11-01 12:56:54', '2025-11-01 12:57:10', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(35, 15, 12, 16, NULL, '2025-11-04 13:00:00', '2025-11-04 14:00:00', 60, 'cancelled', 'RES:35:337BBC60', '337BBC60', 'saddddddddddddddddddddddd', '2025-11-04 11:09:05', '2025-11-04 11:08:27', '2025-11-04 11:09:05', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(36, 16, 21, 25, 25, '2025-11-05 18:00:00', '2025-11-05 19:00:00', 60, 'active', 'RES:36:5EF10157', '5EF10157', NULL, NULL, '2025-11-04 16:28:43', '2025-11-04 16:29:03', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(39, 15, 8, 12, NULL, '2025-11-04 20:00:00', '2025-11-04 20:45:00', 45, 'cancelled', 'RES:39:9C47D526', 'R-280177-15-9C47D526', 'aaaa', '2025-11-04 18:34:34', '2025-11-04 18:16:17', '2025-11-04 18:34:34', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(40, 15, 9, 13, NULL, '2025-11-04 21:15:00', '2025-11-04 21:55:00', 40, 'cancelled', 'RES:40:7FFC5332', 'R-280177-15-7FFC5332', 'â·âaaaaaa', '2025-11-04 18:21:48', '2025-11-04 18:16:22', '2025-11-04 18:21:49', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(41, 15, 21, 25, 27, '2025-11-05 13:00:00', '2025-11-05 14:00:00', 60, 'active', 'RES:41:A8C113A8', 'A8C113A8', NULL, NULL, '2025-11-05 11:10:48', '2025-11-05 11:11:07', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(42, 15, 1, 5, NULL, '2025-11-12 07:00:00', '2025-11-12 08:00:00', 60, 'cancelled', 'RES:42:F421D574', 'F421D574', 'aaa', '2025-11-12 05:56:27', '2025-11-12 05:56:03', '2025-11-12 05:56:27', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 3, 'PLATINUM'),
	(43, 15, 1, 5, 54, '2025-11-12 07:00:00', '2025-11-12 07:30:00', 30, 'active', 'RES:43:1ED525AC', 'R-927059-15-1ED525AC', NULL, NULL, '2025-11-12 05:57:40', '2025-11-12 05:58:19', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 3, 'PLATINUM'),
	(44, 15, 2, 6, NULL, '2025-11-12 08:00:00', '2025-11-12 08:25:00', 25, 'cancelled', 'RES:44:4DB32C58', 'R-927059-15-4DB32C58', 'aaaa', '2025-11-12 06:02:51', '2025-11-12 05:57:46', '2025-11-12 06:02:51', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 3, 'PLATINUM'),
	(45, 15, 1, 5, NULL, '2025-11-12 08:00:00', '2025-11-12 09:00:00', 60, 'cancelled', 'RES:45:D590C316', 'D590C316', 'aaaaa', '2025-11-12 06:26:56', '2025-11-12 06:26:12', '2025-11-12 06:26:56', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 3, 'PLATINUM'),
	(46, 15, 1, 5, NULL, '2025-11-12 08:00:00', '2025-11-12 09:00:00', 60, 'cancelled', 'RES:46:5F9D78D8', '5F9D78D8', 'aaaa', '2025-11-12 06:37:44', '2025-11-12 06:37:20', '2025-11-12 06:37:44', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 3, 'PLATINUM'),
	(47, 17, 21, 25, NULL, '2025-11-12 19:00:00', '2025-11-12 20:00:00', 60, 'cancelled', 'RES:47:9F6EB3CF', '9F6EB3CF', 'Không thể đến', '2025-11-12 17:12:52', '2025-11-12 17:12:31', '2025-11-12 17:12:52', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 0, NULL),
	(48, 17, 1, 5, 80, '2025-11-15 05:00:00', '2025-11-15 06:00:00', 60, 'active', 'RES:48:B90C951B', 'B90C951B', NULL, NULL, '2025-11-15 03:10:32', '2025-11-15 03:11:21', NULL, NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 2, 'GOLD'),
	(49, 15, 22, 26, 92, '2025-11-17 06:00:00', '2025-11-17 07:00:00', 60, 'completed', 'RES:49:391CFBC2', '391CFBC2', NULL, NULL, '2025-11-17 04:07:59', '2025-11-17 04:10:44', '2025-11-17 13:15:00.000000', NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 3, 'PLATINUM'),
	(50, 15, 21, 25, 96, '2025-11-18 17:00:00', '2025-11-18 18:00:00', 60, 'completed', 'RES:50:38BFE0FC', '38BFE0FC', NULL, NULL, '2025-11-18 15:18:33', '2025-11-18 15:19:35', '2025-11-19 00:15:00.000000', NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 3, 'PLATINUM'),
	(51, 15, 21, 25, 97, '2025-11-18 17:00:00', '2025-11-18 18:00:00', 60, 'completed', 'RES:51:BA1EB1C1', 'BA1EB1C1', NULL, NULL, '2025-11-18 15:20:50', '2025-11-18 15:25:35', '2025-11-19 00:15:00.000000', NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 3, 'PLATINUM'),
	(52, 15, 21, 25, 98, '2025-11-18 17:00:00', '2025-11-18 18:00:00', 60, 'completed', 'RES:52:4B29F152', '4B29F152', NULL, NULL, '2025-11-18 15:28:03', '2025-11-18 15:29:26', '2025-11-19 00:15:00.000000', NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 3, 'PLATINUM'),
	(53, 15, 21, 25, 100, '2025-11-19 08:00:00', '2025-11-19 09:00:00', 60, 'completed', 'RES:53:59BADF70', '59BADF70', NULL, NULL, '2025-11-19 06:24:45', '2025-11-19 06:26:34', '2025-11-19 15:15:00.000000', NULL, NULL, NULL, b'0', b'0', 0, b'0', b'0', NULL, 3, 'PLATINUM');

-- Dumping structure for table charging_service_db.session_metrics
CREATE TABLE IF NOT EXISTS `session_metrics` (
  `metric_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` bigint unsigned NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `current_soc` decimal(5,2) DEFAULT NULL,
  `instant_power` decimal(8,2) DEFAULT NULL COMMENT 'kW',
  `voltage` decimal(6,2) DEFAULT NULL COMMENT 'V',
  `current` decimal(6,2) DEFAULT NULL COMMENT 'A',
  `temperature` decimal(5,2) DEFAULT NULL COMMENT '°C',
  `energy_delivered` decimal(10,2) DEFAULT NULL COMMENT 'kWh accumulated',
  `estimated_time_remaining` int DEFAULT NULL COMMENT 'minutes',
  PRIMARY KEY (`metric_id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_timestamp` (`timestamp`),
  CONSTRAINT `session_metrics_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `charging_sessions` (`session_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table charging_service_db.session_metrics: ~0 rows (approximately)


-- Dumping database structure for loyalty_service_db
CREATE DATABASE IF NOT EXISTS `loyalty_service_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `loyalty_service_db`;

-- Dumping structure for table loyalty_service_db.loyalty_accounts
CREATE TABLE IF NOT EXISTS `loyalty_accounts` (
  `account_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `points_balance` int DEFAULT '0',
  `lifetime_points` int DEFAULT '0',
  `tier_level` enum('bronze','silver','gold','platinum','diamond') COLLATE utf8mb4_unicode_ci DEFAULT 'bronze',
  `tier_progress` int DEFAULT '0' COMMENT 'Points towards next tier',
  `tier_updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_tier_level` (`tier_level`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table loyalty_service_db.loyalty_accounts: ~5 rows (approximately)
INSERT INTO `loyalty_accounts` (`account_id`, `user_id`, `points_balance`, `lifetime_points`, `tier_level`, `tier_progress`, `tier_updated_at`, `created_at`, `updated_at`) VALUES
	(1, 15, 6023, 6023, 'gold', 0, '2025-11-16 21:12:59', '2025-11-09 18:34:52', '2025-11-19 02:42:48'),
	(2, 17, 968, 968, 'bronze', 0, NULL, '2025-11-12 04:41:02', '2025-11-23 00:43:59'),
	(3, 18, 192, 192, 'bronze', 0, '2025-11-13 02:29:33', '2025-11-13 02:29:33', '2025-11-13 02:30:46'),
	(4, 19, 960, 960, 'bronze', 0, NULL, '2025-11-15 13:58:53', '2025-11-15 14:04:53'),
	(5, 12, 1, 1, 'bronze', 0, NULL, '2025-11-16 21:09:46', '2025-11-16 21:09:46');

-- Dumping structure for table loyalty_service_db.points_transaction
CREATE TABLE IF NOT EXISTS `points_transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `points` int NOT NULL,
  `type` enum('EARN','REDEEM') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loyalty_account_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKk9u51cy77qnlcxchumvwm29s4` (`loyalty_account_id`),
  CONSTRAINT `FKk9u51cy77qnlcxchumvwm29s4` FOREIGN KEY (`loyalty_account_id`) REFERENCES `loyalty_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table loyalty_service_db.points_transaction: ~0 rows (approximately)

-- Dumping structure for table loyalty_service_db.points_transactions
CREATE TABLE IF NOT EXISTS `points_transactions` (
  `transaction_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint unsigned NOT NULL,
  `transaction_type` enum('earn','redeem','expire','bonus','adjustment','refund') COLLATE utf8mb4_unicode_ci NOT NULL,
  `points` int NOT NULL COMMENT 'Positive for earn, negative for redeem',
  `balance_after` int NOT NULL,
  `reference_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` bigint unsigned DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `idx_account_id` (`account_id`),
  KEY `idx_transaction_type` (`transaction_type`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `points_transactions_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `loyalty_accounts` (`account_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table loyalty_service_db.points_transactions: ~80 rows (approximately)
INSERT INTO `points_transactions` (`transaction_id`, `account_id`, `transaction_type`, `points`, `balance_after`, `reference_type`, `reference_id`, `description`, `expires_at`, `created_at`) VALUES
	(1, 1, 'earn', 120, 120, 'payment', 53, 'Earned points from charging session', NULL, '2025-11-10 11:11:26'),
	(2, 1, 'earn', 120, 240, 'payment', 54, 'Earned points from charging session', NULL, '2025-11-10 11:27:25'),
	(3, 1, 'earn', 3, 243, 'payment', 55, 'Earned points from charging session', NULL, '2025-11-10 11:30:18'),
	(4, 1, 'earn', 120, 363, 'payment', 57, 'Earned points from charging session', NULL, '2025-11-10 11:36:14'),
	(5, 1, 'earn', 120, 483, 'payment', 58, 'Earned points from charging session', NULL, '2025-11-11 08:49:16'),
	(6, 1, 'earn', 120, 603, 'payment', 59, 'Earned points from charging session', NULL, '2025-11-11 08:49:39'),
	(7, 1, 'earn', 120, 723, 'payment', 60, 'Earned points from charging session', NULL, '2025-11-11 08:50:09'),
	(8, 1, 'earn', 120, 843, 'payment', 61, 'Earned points from charging session', NULL, '2025-11-11 08:51:26'),
	(9, 1, 'earn', 120, 963, 'payment', 62, 'Earned points from charging session', NULL, '2025-11-11 08:51:35'),
	(10, 1, 'earn', 120, 1083, 'payment', 63, 'Earned points from charging session', NULL, '2025-11-11 08:56:43'),
	(11, 1, 'earn', 120, 1203, 'payment', 64, 'Earned points from charging session', NULL, '2025-11-11 09:10:27'),
	(12, 1, 'earn', 120, 1323, 'payment', 65, 'Earned points from charging session', NULL, '2025-11-11 23:00:13'),
	(13, 1, 'earn', 120, 1443, 'payment', 66, 'Earned points from charging session', NULL, '2025-11-11 23:38:15'),
	(14, 1, 'earn', 120, 1563, 'payment', 67, 'Earned points from charging session', NULL, '2025-11-11 23:45:38'),
	(15, 1, 'earn', 120, 1683, 'payment', 68, 'Earned points from charging session', NULL, '2025-11-12 03:33:06'),
	(16, 1, 'earn', 120, 1803, 'payment', 69, 'Earned points from charging session', NULL, '2025-11-12 03:33:27'),
	(17, 1, 'earn', 120, 1923, 'payment', 70, 'Earned points from charging session', NULL, '2025-11-12 03:33:31'),
	(18, 1, 'earn', 120, 2043, 'payment', 71, 'Earned points from charging session', NULL, '2025-11-12 03:34:07'),
	(19, 1, 'earn', 120, 2163, 'payment', 72, 'Earned points from charging session', NULL, '2025-11-12 04:37:48'),
	(20, 1, 'earn', 120, 2283, 'payment', 73, 'Earned points from charging session', NULL, '2025-11-12 04:39:01'),
	(21, 2, 'earn', 3, 3, 'payment', 75, 'Earned points from charging session', NULL, '2025-11-12 04:41:02'),
	(22, 1, 'earn', 120, 2403, 'payment', 76, 'Earned points from charging session', NULL, '2025-11-12 09:59:25'),
	(23, 1, 'earn', 120, 2523, 'payment', 77, 'Earned points from charging session', NULL, '2025-11-12 09:59:48'),
	(24, 1, 'earn', 120, 2643, 'payment', 78, 'Earned points from charging session', NULL, '2025-11-12 10:00:03'),
	(25, 1, 'earn', 120, 2763, 'payment', 79, 'Earned points from charging session', NULL, '2025-11-12 10:00:23'),
	(26, 1, 'earn', 120, 2883, 'payment', 80, 'Earned points from charging session', NULL, '2025-11-12 10:01:08'),
	(27, 1, 'earn', 120, 3003, 'payment', 81, 'Earned points from charging session', NULL, '2025-11-12 10:01:26'),
	(28, 1, 'earn', 120, 3123, 'payment', 82, 'Earned points from charging session', NULL, '2025-11-12 10:01:47'),
	(29, 1, 'earn', 240, 3363, 'payment', 85, 'Earned points from charging session', NULL, '2025-11-12 10:14:40'),
	(30, 1, 'earn', 7, 3370, 'payment', 86, 'Earned points from charging session', NULL, '2025-11-12 10:21:57'),
	(31, 1, 'earn', 4, 3374, 'payment', 87, 'Earned points from charging session', NULL, '2025-11-12 10:27:30'),
	(32, 1, 'earn', 96, 3470, 'payment', 88, 'Earned points from charging session', NULL, '2025-11-12 10:35:06'),
	(33, 1, 'earn', 96, 3566, 'payment', 89, 'Earned points from charging session', NULL, '2025-11-12 11:24:33'),
	(34, 1, 'earn', 96, 3662, 'payment', 90, 'Earned points from charging session', NULL, '2025-11-12 11:35:50'),
	(35, 1, 'earn', 96, 3758, 'payment', 91, 'Earned points from charging session', NULL, '2025-11-12 11:36:39'),
	(36, 1, 'earn', 96, 3854, 'payment', 92, 'Earned points from charging session', NULL, '2025-11-12 11:36:45'),
	(37, 3, 'earn', 192, 192, 'payment', 95, 'Earned points from charging session', NULL, '2025-11-13 02:30:46'),
	(38, 1, 'earn', 96, 3950, 'payment', 97, 'Earned points from charging session', NULL, '2025-11-13 15:05:19'),
	(39, 1, 'earn', 96, 4046, 'payment', 98, 'Earned points from charging session', NULL, '2025-11-13 15:10:02'),
	(40, 1, 'earn', 96, 4142, 'payment', 99, 'Earned points from charging session', NULL, '2025-11-13 15:10:53'),
	(41, 1, 'earn', 96, 4238, 'payment', 100, 'Earned points from charging session', NULL, '2025-11-13 16:10:30'),
	(42, 1, 'earn', 96, 4334, 'payment', 101, 'Earned points from charging session', NULL, '2025-11-13 16:10:57'),
	(43, 1, 'earn', 96, 4430, 'payment', 102, 'Earned points from charging session', NULL, '2025-11-14 20:04:42'),
	(44, 1, 'earn', 96, 4526, 'payment', 103, 'Earned points from charging session', NULL, '2025-11-14 20:18:08'),
	(45, 1, 'earn', 96, 4622, 'payment', 104, 'Earned points from charging session', NULL, '2025-11-14 20:24:37'),
	(46, 1, 'earn', 1, 4623, 'payment', 105, 'Earned points from charging session', NULL, '2025-11-14 20:28:06'),
	(47, 1, 'earn', 27, 4650, 'payment', 106, 'Earned points from charging session', NULL, '2025-11-14 20:59:52'),
	(48, 1, 'earn', 27, 4677, 'payment', 107, 'Earned points from charging session', NULL, '2025-11-14 21:00:00'),
	(49, 2, 'earn', 60, 63, 'payment', 108, 'Earned points from charging session', NULL, '2025-11-14 21:07:41'),
	(50, 2, 'earn', 60, 123, 'payment', 109, 'Earned points from charging session', NULL, '2025-11-14 21:07:48'),
	(51, 2, 'earn', 115, 238, 'payment', 110, 'Earned points from charging session', NULL, '2025-11-14 21:08:44'),
	(52, 2, 'earn', 115, 353, 'payment', 111, 'Earned points from charging session', NULL, '2025-11-14 21:08:55'),
	(53, 1, 'earn', 96, 4773, 'payment', 114, 'Earned points from charging session', NULL, '2025-11-14 21:39:33'),
	(54, 2, 'earn', 115, 468, 'payment', 113, 'Earned points from charging session', NULL, '2025-11-14 21:39:47'),
	(55, 2, 'earn', 115, 583, 'payment', 112, 'Earned points from charging session', NULL, '2025-11-14 21:39:51'),
	(56, 2, 'earn', 96, 679, 'payment', 115, 'Earned points from charging session', NULL, '2025-11-14 22:21:48'),
	(57, 4, 'earn', 192, 192, 'payment', 116, 'Earned points from charging session', NULL, '2025-11-15 13:58:53'),
	(58, 4, 'earn', 192, 384, 'payment', 117, 'Earned points from charging session', NULL, '2025-11-15 14:03:44'),
	(59, 4, 'earn', 192, 576, 'payment', 118, 'Earned points from charging session', NULL, '2025-11-15 14:04:06'),
	(60, 4, 'earn', 192, 768, 'payment', 119, 'Earned points from charging session', NULL, '2025-11-15 14:04:37'),
	(61, 4, 'earn', 192, 960, 'payment', 120, 'Earned points from charging session', NULL, '2025-11-15 14:04:53'),
	(62, 1, 'earn', 96, 4869, 'payment', 121, 'Earned points from charging session', NULL, '2025-11-16 21:07:40'),
	(63, 5, 'earn', 1, 1, 'payment', 122, 'Earned points from charging session', NULL, '2025-11-16 21:09:46'),
	(64, 2, 'earn', 1, 680, 'payment', 123, 'Earned points from charging session', NULL, '2025-11-16 21:10:10'),
	(65, 1, 'earn', 96, 4965, 'payment', 124, 'Earned points from charging session', NULL, '2025-11-16 21:10:50'),
	(66, 2, 'earn', 96, 776, 'payment', 125, 'Earned points from charging session', NULL, '2025-11-16 21:11:16'),
	(67, 1, 'earn', 96, 5061, 'payment', 126, 'Earned points from charging session', NULL, '2025-11-16 21:12:59'),
	(68, 1, 'earn', 96, 5157, 'payment', 127, 'Earned points from charging session', NULL, '2025-11-16 21:13:12'),
	(69, 1, 'earn', 96, 5253, 'payment', 128, 'Earned points from charging session', NULL, '2025-11-16 21:20:02'),
	(70, 2, 'earn', 96, 872, 'payment', 129, 'Earned points from charging session', NULL, '2025-11-18 08:05:37'),
	(71, 1, 'earn', 96, 5349, 'payment', 130, 'Earned points from charging session', NULL, '2025-11-18 08:19:36'),
	(72, 1, 'earn', 96, 5445, 'payment', 131, 'Earned points from charging session', NULL, '2025-11-18 08:25:37'),
	(73, 1, 'earn', 96, 5541, 'payment', 132, 'Earned points from charging session', NULL, '2025-11-18 08:29:28'),
	(74, 1, 'earn', 96, 5637, 'payment', 133, 'Earned points from charging session', NULL, '2025-11-18 08:31:30'),
	(75, 1, 'earn', 96, 5733, 'payment', 134, 'Earned points from charging session', NULL, '2025-11-18 08:35:21'),
	(76, 1, 'earn', 96, 5829, 'payment', 135, 'Earned points from charging session', NULL, '2025-11-18 23:26:39'),
	(77, 1, 'earn', 96, 5925, 'payment', 136, 'Earned points from charging session', NULL, '2025-11-18 23:28:47'),
	(78, 1, 'earn', 2, 5927, 'payment', 137, 'Earned points from charging session', NULL, '2025-11-18 23:39:44'),
	(79, 1, 'earn', 96, 6023, 'payment', 140, 'Earned points from charging session', NULL, '2025-11-19 02:42:48'),
	(80, 2, 'earn', 96, 968, 'payment', 141, 'Earned points from charging session', NULL, '2025-11-23 00:43:59');

-- Dumping structure for table loyalty_service_db.referrals
CREATE TABLE IF NOT EXISTS `referrals` (
  `referral_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `referrer_user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `referred_user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `referral_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','completed','rewarded','expired') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `referrer_reward_points` int DEFAULT NULL,
  `referred_reward_points` int DEFAULT NULL,
  `rewarded_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`referral_id`),
  UNIQUE KEY `referral_code` (`referral_code`),
  KEY `idx_referrer_user_id` (`referrer_user_id`),
  KEY `idx_referred_user_id` (`referred_user_id`),
  KEY `idx_referral_code` (`referral_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table loyalty_service_db.referrals: ~0 rows (approximately)

-- Dumping structure for table loyalty_service_db.vip_benefits
CREATE TABLE IF NOT EXISTS `vip_benefits` (
  `benefit_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tier_level` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `benefit_type` enum('discount','priority_booking','free_cancellation','points_multiplier','free_kwh') COLLATE utf8mb4_unicode_ci NOT NULL,
  `benefit_value` json NOT NULL COMMENT '{"discount_pct": 10} or {"multiplier": 1.5}',
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`benefit_id`),
  KEY `idx_tier_level` (`tier_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table loyalty_service_db.vip_benefits: ~0 rows (approximately)


-- Dumping database structure for notification_service_db
CREATE DATABASE IF NOT EXISTS `notification_service_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `notification_service_db`;

-- Dumping structure for table notification_service_db.fcm_tokens
CREATE TABLE IF NOT EXISTS `fcm_tokens` (
  `fcm_token_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `device_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `token` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `device_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`fcm_token_id`),
  UNIQUE KEY `UKmt41a23jdgkyprxusa97ss4er` (`user_id`,`token`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table notification_service_db.fcm_tokens: ~1 rows (approximately)
INSERT INTO `fcm_tokens` (`fcm_token_id`, `created_at`, `device_type`, `is_active`, `token`, `updated_at`, `user_id`, `device_id`, `last_used_at`) VALUES
	(1, '2025-11-10 01:32:10.064447', 'web', b'1', 'fmvQADMU2hFqzmTA8ADyLv:APA91bHXZwpsHpQnBKQLQb6BG5crZ7SwOLbOAJCKVFs6P50ZlfUk-1_63fps-2UsDn00RvQnDZc0ZzfBftqgn_TnoHzVtP_8HFT0979KlCNPsX4enMriTnU', '2025-11-13 09:32:15.870108', 18, NULL, '2025-11-13 09:32:15.870109');

-- Dumping structure for table notification_service_db.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `notification_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `notification_type` enum('charging_started','charging_complete','charging_failed','reservation_confirmed','reservation_reminder','reservation_cancelled','payment_success','payment_failed','wallet_low_balance','promotion','system_maintenance','station_offline','review_request','account_update') COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'session, payment, reservation, etc.',
  `reference_id` bigint unsigned DEFAULT NULL,
  `push_sent` tinyint(1) DEFAULT '0',
  `push_sent_at` timestamp NULL DEFAULT NULL,
  `email_sent` tinyint(1) DEFAULT '0',
  `email_sent_at` timestamp NULL DEFAULT NULL,
  `sms_sent` tinyint(1) DEFAULT '0',
  `sms_sent_at` timestamp NULL DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `priority` enum('low','normal','high','urgent') COLLATE utf8mb4_unicode_ci DEFAULT 'normal',
  `data` json DEFAULT NULL COMMENT 'Additional data for deep linking',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_notification_type` (`notification_type`),
  KEY `idx_is_read` (`is_read`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table notification_service_db.notifications: ~249 rows (approximately)
INSERT INTO `notifications` (`notification_id`, `user_id`, `notification_type`, `title`, `message`, `reference_type`, `reference_id`, `push_sent`, `push_sent_at`, `email_sent`, `email_sent_at`, `sms_sent`, `sms_sent_at`, `is_read`, `read_at`, `priority`, `data`, `created_at`, `expires_at`) VALUES
	(1, 1, 'charging_started', 'Charging Started', 'Your charging session for session ID 123 has started.', NULL, 123, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-20 07:33:41', NULL),
	(2, 3, 'promotion', 'Special Discount!', 'Get 20% off on your next charge.', NULL, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-20 09:51:00', NULL),
	(3, 1, 'charging_started', 'Charging Started', 'Your charging session (ID: 4) has started.', NULL, 4, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-20 15:13:52', NULL),
	(4, 1, 'charging_complete', 'Charging Complete', 'Your charging session (ID: 3) is complete. Energy consumed: 2427.06 kWh. Payment Status: failed', NULL, 3, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-20 15:14:32', NULL),
	(5, 1, 'payment_failed', 'Payment Failed', 'Payment for session ID 3 was failed.', NULL, 3, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-20 15:14:36', NULL),
	(6, 1, 'charging_started', 'Charging Started', 'Your charging session for session ID 123 has started.', NULL, 123, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-23 20:19:30', NULL),
	(7, 1, 'charging_started', 'Charging Started', 'Your charging session (ID: 5) has started.', NULL, 5, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-24 17:11:11', NULL),
	(8, 1, 'charging_started', 'Charging Started', 'Your charging session (ID: 6) has started.', NULL, 6, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-24 17:11:20', NULL),
	(9, 1, 'charging_complete', 'Charging Complete', 'Your charging session (ID: 6) is complete. Energy consumed: 0.09 kWh. Payment Status: completed', NULL, 6, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-24 17:11:30', NULL),
	(10, 1, 'payment_success', 'Payment Successful', 'Payment for session ID 6 was successful.', NULL, 6, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-24 17:11:34', NULL),
	(11, 1, 'charging_started', 'Charging Started', 'Your charging session (ID: 7) has started.', NULL, 7, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-24 17:12:50', NULL),
	(12, 1, 'charging_complete', 'Charging Complete', 'Your charging session (ID: 7) is complete. Energy consumed: 0.55 kWh. Payment Status: completed', NULL, 7, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-24 17:13:45', NULL),
	(13, 1, 'payment_success', 'Payment Successful', 'Payment for session ID 7 was successful.', NULL, 7, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-24 17:13:49', NULL),
	(14, 7, 'charging_started', 'Charging Started', 'Your charging session (ID: 8) has started.', NULL, 8, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-10-24 17:15:07', NULL),
	(15, 7, 'charging_complete', 'Charging Complete', 'Your charging session (ID: 8) is complete. Energy consumed: 0.06 kWh. Payment Status: failed', NULL, 8, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-10-24 17:15:14', NULL),
	(16, 7, 'payment_failed', 'Payment Failed', 'Payment for session ID 8 was failed.', NULL, 8, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-10-24 17:15:17', NULL),
	(17, 1, 'charging_started', 'Charging Started', 'Your charging session (ID: 9) has started.', NULL, 9, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-24 19:57:27', NULL),
	(18, 1, 'charging_complete', 'Charging Complete', 'Your charging session (ID: 9) is complete. Energy consumed: 0.08 kWh. Payment Status: completed', NULL, 9, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-24 19:57:35', NULL),
	(19, 1, 'payment_success', 'Payment Successful', 'Payment for session ID 9 was successful.', NULL, 9, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-24 19:57:39', NULL),
	(20, 1, 'charging_started', 'Charging Started', 'Your charging session (ID: 10) has started.', NULL, 10, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-26 00:19:53', NULL),
	(21, 1, 'charging_started', 'Charging Started', 'Your charging session (ID: 11) has started.', NULL, 11, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-26 00:23:05', NULL),
	(22, 1, 'charging_complete', 'Charging Complete', 'Your charging session (ID: 11) is complete. Energy consumed: 0.18 kWh. Payment Status: completed', NULL, 11, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-26 00:23:24', NULL),
	(23, 1, 'payment_success', 'Payment Successful', 'Payment for session ID 11 was successful.', NULL, 11, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-26 00:23:28', NULL),
	(24, 11, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 7176EE4E. Thời gian: 2025-10-31T23:00 đến 2025-11-01T00:00', NULL, 25, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-31 07:14:25', NULL),
	(25, 11, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 87D3ED67. Thời gian: 2025-10-31T23:00 đến 2025-11-01T00:00', NULL, 26, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-31 07:26:34', NULL),
	(26, 11, 'charging_started', 'Charging Started', 'Your charging session (ID: 12) has started.', NULL, 12, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-31 07:27:01', NULL),
	(27, 11, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 12) hoàn tất. Năng lượng: 6,60 kWh. SOC: 26,6%. Trạng thái thanh toán: failed', NULL, 12, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-31 07:38:43', NULL),
	(28, 11, 'payment_failed', 'Payment Failed', 'Payment for session ID 12 was failed.', NULL, 12, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-31 07:38:47', NULL),
	(29, 11, 'reservation_reminder', 'Nhắc nhở đặt chỗ sạc', 'Bạn có đặt chỗ sạc tại trạm ID 41 trong 58 phút nữa (lúc 23:00 31/10/2025). Vui lòng đến đúng giờ và check-in trong vòng 15 phút sau thời gian đặt để nhận lại tiền cọc.', NULL, 26, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-31 08:01:08', NULL),
	(30, 11, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 2B6AAE37. Thời gian: 2025-11-01T04:00 đến 2025-11-01T05:00', NULL, 27, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-31 12:00:16', NULL),
	(31, 11, 'charging_started', 'Charging Started', 'Your charging session (ID: 13) has started.', NULL, 13, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-31 12:00:41', NULL),
	(32, 11, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 13) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Trạng thái thanh toán: failed', NULL, 13, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-31 12:01:04', NULL),
	(33, 11, 'payment_failed', 'Payment Failed', 'Payment for session ID 13 was failed.', NULL, 13, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-10-31 12:01:08', NULL),
	(34, 11, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: D3E070A5. Thời gian: 2025-11-01T16:00 đến 2025-11-01T17:00', NULL, 28, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 00:40:08', NULL),
	(35, 11, 'charging_started', 'Charging Started', 'Your charging session (ID: 14) has started.', NULL, 14, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 00:41:32', NULL),
	(36, 11, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 14) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Trạng thái thanh toán: completed', NULL, 14, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 00:41:43', NULL),
	(37, 11, 'payment_success', 'Payment Successful', 'Payment for session ID 14 was successful.', NULL, 14, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 00:41:47', NULL),
	(38, 11, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 0CAFF205. Thời gian: 2025-11-01T17:00 đến 2025-11-01T18:00', NULL, 29, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 01:04:46', NULL),
	(39, 1, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 10) hoàn tất. Năng lượng: 5350,20 kWh. SOC: 100,0%. Trạng thái thanh toán: failed', NULL, 10, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 04:57:07', NULL),
	(40, 1, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 5) hoàn tất. Năng lượng: 6471,00 kWh. SOC: 100,0%. Trạng thái thanh toán: failed', NULL, 5, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 04:57:10', NULL),
	(41, 1, 'payment_failed', 'Payment Failed', 'Payment for session ID 10 was failed.', NULL, 10, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 04:57:11', NULL),
	(42, 1, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 4) hoàn tất. Năng lượng: 10249,80 kWh. SOC: 100,0%. Trạng thái thanh toán: failed', NULL, 4, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 04:57:12', NULL),
	(43, 1, 'payment_failed', 'Payment Failed', 'Payment for session ID 5 was failed.', NULL, 5, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 04:57:13', NULL),
	(44, 1, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 2) hoàn tất. Năng lượng: 13014,60 kWh. SOC: 100,0%. Trạng thái thanh toán: failed', NULL, 2, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 04:57:14', NULL),
	(45, 1, 'payment_failed', 'Payment Failed', 'Payment for session ID 4 was failed.', NULL, 4, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 04:57:15', NULL),
	(46, 1, 'payment_failed', 'Payment Failed', 'Payment for session ID 2 was failed.', NULL, 2, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 04:57:17', NULL),
	(47, 1, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 1) hoàn tất. Năng lượng: 13030,20 kWh. SOC: 100,0%. Trạng thái thanh toán: failed', NULL, 1, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 04:57:17', NULL),
	(48, 1, 'payment_failed', 'Payment Failed', 'Payment for session ID 1 was failed.', NULL, 1, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 04:57:20', NULL),
	(49, 8, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: CB65CBA6. Thời gian: 2025-11-01T21:00 đến 2025-11-01T22:00', NULL, 30, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:06:56', NULL),
	(50, 8, 'charging_started', 'Charging Started', 'Your charging session (ID: 15) has started.', NULL, 15, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:07:11', NULL),
	(51, 8, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 15) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Trạng thái thanh toán: failed', NULL, 15, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:08:29', NULL),
	(52, 8, 'payment_failed', 'Payment Failed', 'Payment for session ID 15 was failed.', NULL, 15, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:08:32', NULL),
	(53, 8, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: B47E5AA6. Thời gian: 2025-11-01T21:00 đến 2025-11-01T22:00', NULL, 31, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:09:40', NULL),
	(54, 8, 'charging_started', 'Charging Started', 'Your charging session (ID: 16) has started.', NULL, 16, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:10:29', NULL),
	(55, 8, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 16) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Trạng thái thanh toán: completed', NULL, 16, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:11:43', NULL),
	(56, 8, 'payment_success', 'Payment Successful', 'Payment for session ID 16 was successful.', NULL, 16, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:11:46', NULL),
	(57, 8, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: BC090101. Thời gian: 2025-11-01T21:00 đến 2025-11-01T22:00', NULL, 32, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:22:43', NULL),
	(58, 8, 'charging_started', 'Charging Started', 'Your charging session (ID: 17) has started.', NULL, 17, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:23:00', NULL),
	(59, 8, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 17) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 17, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:24:15', NULL),
	(60, 11, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 3D0F1F67. Thời gian: 2025-11-01T21:00 đến 2025-11-01T22:00', NULL, 33, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:35:35', NULL),
	(61, 11, 'charging_started', 'Charging Started', 'Your charging session (ID: 18) has started.', NULL, 18, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:35:47', NULL),
	(62, 11, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 18) hoàn tất. Năng lượng: 1,80 kWh. SOC: 21,8%. Vui lòng thanh toán.', NULL, 18, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-01 05:39:09', NULL),
	(63, 7, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 739E8356. Thời gian: 2025-11-01T21:00 đến 2025-11-01T22:00', NULL, 34, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-01 05:56:54', NULL),
	(64, 7, 'charging_started', 'Charging Started', 'Your charging session (ID: 19) has started.', NULL, 19, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-01 05:57:07', NULL),
	(65, 7, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 19) hoàn tất. Năng lượng: 1,20 kWh. SOC: 21,2%. Vui lòng thanh toán.', NULL, 19, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-01 05:59:20', NULL),
	(82, 16, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 5EF10157. Thời gian: 2025-11-06T01:00 đến 2025-11-06T02:00', NULL, 36, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-04 09:28:43', NULL),
	(83, 16, 'charging_started', 'Charging Started', 'Your charging session (ID: 25) has started.', NULL, 25, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-04 09:29:00', NULL),
	(84, 16, 'promotion', 'Khuyến Mãi 50%', 'abc Mã khuyến mãi: PHONGDAT', NULL, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-04 09:29:49', NULL),
	(85, 16, 'promotion', '1111', 'aaa Mã khuyến mãi: aaaa', NULL, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-04 09:36:11', NULL),
	(86, 16, 'promotion', '1111', '1111 Mã khuyến mãi: 1111', NULL, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-04 09:45:30', NULL),
	(87, 16, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 25) hoàn tất. Năng lượng: 21,00 kWh. SOC: 41,0%. Vui lòng thanh toán.', NULL, 25, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-04 10:04:37', NULL),
	(92, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 26) has started.', NULL, 26, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-05 04:06:47', NULL),
	(93, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 26) hoàn tất. Năng lượng: 1,20 kWh. SOC: 21,2%. Vui lòng thanh toán.', NULL, 26, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-05 04:09:27', NULL),
	(94, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: A8C113A8. Thời gian: 2025-11-05T20:00 đến 2025-11-05T21:00', NULL, 41, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-05 04:10:48', NULL),
	(95, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 27) has started.', NULL, 27, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-05 04:11:04', NULL),
	(96, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 27) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 27, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-05 04:11:13', NULL),
	(97, 7, 'promotion', 'Khuyến Mãi', 'aaa Mã khuyến mãi: aaa', NULL, NULL, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-05 04:13:54', NULL),
	(98, 15, 'promotion', 'Khuyến Mãi', '111 Mã khuyến mãi: 1111', NULL, NULL, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-05 04:14:48', NULL),
	(99, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 28) has started.', NULL, 28, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 05:44:14', NULL),
	(100, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 28) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 28, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 05:44:22', NULL),
	(101, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 29) has started.', NULL, 29, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 08:25:20', NULL),
	(102, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 29) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 29, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 08:26:58', NULL),
	(103, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 30) has started.', NULL, 30, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 10:58:44', NULL),
	(104, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 30) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 30, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 10:59:31', NULL),
	(105, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 31) has started.', NULL, 31, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 18:45:39', NULL),
	(106, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 31) hoàn tất. Năng lượng: 1,20 kWh. SOC: 21,2%. Vui lòng thanh toán.', NULL, 31, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 18:47:46', NULL),
	(107, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 32) has started.', NULL, 32, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 18:51:39', NULL),
	(108, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 32) hoàn tất. Năng lượng: 3,60 kWh. SOC: 23,6%. Vui lòng thanh toán.', NULL, 32, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 18:58:14', NULL),
	(109, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 33) has started.', NULL, 33, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 18:58:28', NULL),
	(110, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 33) hoàn tất. Năng lượng: 1,80 kWh. SOC: 21,8%. Vui lòng thanh toán.', NULL, 33, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:02:16', NULL),
	(111, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 34) has started.', NULL, 34, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:03:30', NULL),
	(112, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 34) hoàn tất. Năng lượng: 1,20 kWh. SOC: 21,2%. Vui lòng thanh toán.', NULL, 34, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:05:51', NULL),
	(113, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 35) has started.', NULL, 35, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:06:30', NULL),
	(114, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 35) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 35, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:06:38', NULL),
	(115, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 36) has started.', NULL, 36, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:21:03', NULL),
	(116, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 36) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 36, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:21:12', NULL),
	(117, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 37) has started.', NULL, 37, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:22:29', NULL),
	(118, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 37) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 37, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:22:41', NULL),
	(119, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 38) has started.', NULL, 38, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:23:41', NULL),
	(120, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 38) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 38, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-09 19:23:49', NULL),
	(121, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 39) has started.', NULL, 39, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 06:37:31', NULL),
	(122, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 39) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 39, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 06:37:44', NULL),
	(123, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 40) has started.', NULL, 40, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 06:46:46', NULL),
	(124, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 40) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 40, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 06:46:57', NULL),
	(125, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 41) has started.', NULL, 41, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 06:53:23', NULL),
	(126, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 41) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 41, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 06:53:32', NULL),
	(127, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 42) has started.', NULL, 42, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 07:06:58', NULL),
	(128, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 42) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 42, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 07:07:07', NULL),
	(129, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 43) has started.', NULL, 43, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 07:48:56', NULL),
	(130, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 43) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 43, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 07:49:03', NULL),
	(131, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 44) has started.', NULL, 44, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 11:04:02', NULL),
	(132, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 44) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 44, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 11:04:21', NULL),
	(133, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 45) has started.', NULL, 45, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 11:11:13', NULL),
	(134, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 45) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 45, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 11:11:20', NULL),
	(135, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 46) has started.', NULL, 46, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 11:26:57', NULL),
	(136, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 46) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 46, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 11:27:19', NULL),
	(137, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 47) has started.', NULL, 47, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 11:28:50', NULL),
	(138, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 47) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 47, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 11:30:11', NULL),
	(139, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 48) has started.', NULL, 48, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 11:34:50', NULL),
	(140, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 48) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 48, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-10 11:35:04', NULL),
	(141, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 49) has started.', NULL, 49, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 08:48:28', NULL),
	(142, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 49) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 49, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 08:48:38', NULL),
	(143, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 50) has started.', NULL, 50, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 08:49:29', NULL),
	(144, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 50) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 50, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 08:49:36', NULL),
	(145, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 51) has started.', NULL, 51, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 08:50:02', NULL),
	(146, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 51) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 51, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 08:51:24', NULL),
	(147, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 52) has started.', NULL, 52, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 08:51:45', NULL),
	(148, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 52) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 52, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 08:51:52', NULL),
	(149, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 53) has started.', NULL, 53, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 09:09:20', NULL),
	(150, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 53) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 53, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 09:10:23', NULL),
	(151, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: F421D574. Thời gian: 2025-11-12T14:00 đến 2025-11-12T15:00', NULL, 42, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 22:56:03', NULL),
	(152, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 1ED525AC. Thời gian: 2025-11-12T14:00 đến 2025-11-12T14:30', NULL, 43, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 22:57:40', NULL),
	(153, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 4DB32C58. Thời gian: 2025-11-12T15:00 đến 2025-11-12T15:25', NULL, 44, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 22:57:46', NULL),
	(154, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 54) has started.', NULL, 54, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 22:58:14', NULL),
	(155, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 54) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 54, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 22:58:31', NULL),
	(156, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: D590C316. Thời gian: 2025-11-12T15:00 đến 2025-11-12T16:00', NULL, 45, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 23:26:12', NULL),
	(157, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 5F9D78D8. Thời gian: 2025-11-12T15:00 đến 2025-11-12T16:00', NULL, 46, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 23:37:20', NULL),
	(158, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 55) has started.', NULL, 55, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 23:37:50', NULL),
	(159, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 55) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 55, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 23:38:04', NULL),
	(160, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 56) has started.', NULL, 56, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 23:45:23', NULL),
	(161, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 56) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 56, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-11 23:45:35', NULL),
	(162, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 57) has started.', NULL, 57, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 03:32:58', NULL),
	(163, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 57) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 57, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 03:33:25', NULL),
	(164, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 58) has started.', NULL, 58, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 03:33:51', NULL),
	(165, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 58) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 58, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 03:34:00', NULL),
	(166, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 59) has started.', NULL, 59, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 04:37:29', NULL),
	(167, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 59) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 59, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 04:37:38', NULL),
	(168, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 60) has started.', NULL, 60, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 04:38:03', NULL),
	(169, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 60) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 60, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 04:38:59', NULL),
	(170, 17, 'charging_started', 'Charging Started', 'Your charging session (ID: 61) has started.', NULL, 61, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 04:40:08', NULL),
	(171, 17, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 61) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 61, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 04:40:48', NULL),
	(172, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 62) has started.', NULL, 62, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 09:58:50', NULL),
	(173, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 62) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 62, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 09:59:08', NULL),
	(174, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 63) has started.', NULL, 63, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 09:59:33', NULL),
	(175, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 63) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 63, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 09:59:46', NULL),
	(176, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 64) has started.', NULL, 64, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 09:59:53', NULL),
	(177, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 64) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 64, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:00:22', NULL),
	(178, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 65) has started.', NULL, 65, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:01:00', NULL),
	(179, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 66) has started.', NULL, 66, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:01:14', NULL),
	(180, 15, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 66) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 66, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:01:24', NULL),
	(181, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 65) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 65, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:01:53', NULL),
	(182, 17, 'charging_started', 'Charging Started', 'Your charging session (ID: 67) has started.', NULL, 67, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:10:58', NULL),
	(183, 17, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 67) hoàn tất. Năng lượng: 80,00 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 67, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:11:06', NULL),
	(184, 7, 'reservation_confirmed', 'Đặt chỗ mới', 'Có đặt chỗ mới tại trạm 21, trụ sạc 25. Thời gian: 2025-11-13T02:00 đến 2025-11-13T03:00', NULL, 47, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:12:31', NULL),
	(185, 17, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 9F6EB3CF. Thời gian: 2025-11-13T02:00 đến 2025-11-13T03:00', NULL, 47, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:12:35', NULL),
	(186, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 68) has started.', NULL, 68, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:13:34', NULL),
	(187, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 68) hoàn tất. Năng lượng: 4,80 kWh. SOC: 24,8%. Vui lòng thanh toán.', NULL, 68, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:21:51', NULL),
	(188, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 69) has started.', NULL, 69, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:22:05', NULL),
	(189, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 69) hoàn tất. Năng lượng: 3,00 kWh. SOC: 23,0%. Vui lòng thanh toán.', NULL, 69, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:27:25', NULL),
	(190, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 70) has started.', NULL, 70, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:34:48', NULL),
	(191, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 70) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 70, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 10:35:02', NULL),
	(192, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 71) has started.', NULL, 71, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 11:24:11', NULL),
	(193, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 71) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 71, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 11:24:30', NULL),
	(194, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 72) has started.', NULL, 72, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 11:35:41', NULL),
	(195, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 72) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 72, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-12 11:36:38', NULL),
	(196, 18, 'charging_started', 'Charging Started', 'Your charging session (ID: 73) has started.', NULL, 73, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 02:27:00', NULL),
	(197, 18, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 73) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 73, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 02:28:36', NULL),
	(198, 18, 'charging_started', 'Charging Started', 'Your charging session (ID: 74) has started.', NULL, 74, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 02:29:57', NULL),
	(199, 18, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 74) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 74, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 02:30:09', NULL),
	(200, 18, 'charging_started', 'Charging Started', 'Your charging session (ID: 75) has started.', NULL, 75, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 02:30:36', NULL),
	(201, 18, 'charging_complete', 'Pin đã sạc đầy!', 'Pin đã sạc đầy! Phiên sạc (ID: 75) hoàn tất. Năng lượng: 439,80 kWh. SOC: 100,0%. Vui lòng thanh toán.', NULL, 75, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-13 14:44:07', NULL),
	(202, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 76) has started.', NULL, 76, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 15:04:27', NULL),
	(203, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 76) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 76, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 15:05:17', NULL),
	(204, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 77) has started.', NULL, 77, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 15:09:43', NULL),
	(205, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 77) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 77, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 15:10:44', NULL),
	(206, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 78) has started.', NULL, 78, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 16:10:18', NULL),
	(207, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 78) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 78, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-13 16:10:55', NULL),
	(208, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 79) has started.', NULL, 79, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 20:03:40', NULL),
	(209, 7, 'reservation_confirmed', 'Đặt chỗ mới', 'Có đặt chỗ mới tại trạm 1, trụ sạc 5. Thời gian: 2025-11-15T12:00 đến 2025-11-15T13:00', NULL, 48, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 20:10:32', NULL),
	(210, 17, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: B90C951B. Thời gian: 2025-11-15T12:00 đến 2025-11-15T13:00', NULL, 48, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 20:10:35', NULL),
	(211, 17, 'charging_started', 'Charging Started', 'Your charging session (ID: 80) has started.', NULL, 80, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 20:11:17', NULL),
	(212, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 79) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 79, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 20:18:05', NULL),
	(213, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 81) has started.', NULL, 81, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 20:25:17', NULL),
	(214, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 81) hoàn tất. Năng lượng: 1,20 kWh. SOC: 21,2%. Vui lòng thanh toán.', NULL, 81, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 20:28:00', NULL),
	(215, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 82) has started.', NULL, 82, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 20:28:23', NULL),
	(216, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 82) hoàn tất. Năng lượng: 18,60 kWh. SOC: 38,6%. Vui lòng thanh toán.', NULL, 82, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 20:59:49', NULL),
	(217, 17, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 80) hoàn tất. Năng lượng: 33,60 kWh. SOC: 53,6%. Vui lòng thanh toán.', NULL, 80, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 21:07:37', NULL),
	(218, 17, 'charging_started', 'Charging Started', 'Your charging session (ID: 83) has started.', NULL, 83, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 21:08:28', NULL),
	(219, 17, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 83) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 83, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 21:08:41', NULL),
	(220, 17, 'charging_started', 'Charging Started', 'Your charging session (ID: 84) has started.', NULL, 84, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 21:10:54', NULL),
	(221, 17, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 84) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 84, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 21:11:05', NULL),
	(222, 17, 'charging_started', 'Charging Started', 'Your charging session (ID: 85) has started.', NULL, 85, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 21:24:43', NULL),
	(223, 17, 'charging_complete', 'Pin đã sạc đầy!', 'Phiên sạc (ID: 85) đã tự động hoàn thành. Pin đã sạc đầy 100%. Năng lượng: 64,00 kWh. Vui lòng thanh toán.', NULL, 85, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 21:24:53', NULL),
	(224, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 86) has started.', NULL, 86, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 21:39:13', NULL),
	(225, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 86) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 86, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-14 21:39:30', NULL),
	(226, 19, 'charging_started', 'Charging Started', 'Your charging session (ID: 87) has started.', NULL, 87, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-15 13:58:39', NULL),
	(227, 19, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 87) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 87, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-15 13:58:50', NULL),
	(228, 19, 'charging_started', 'Charging Started', 'Your charging session (ID: 88) has started.', NULL, 88, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-15 13:59:23', NULL),
	(229, 19, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 88) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 88, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-15 14:03:56', NULL),
	(230, 19, 'charging_started', 'Charging Started', 'Your charging session (ID: 89) has started.', NULL, 89, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-15 14:04:22', NULL),
	(231, 19, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 89) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 89, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-15 14:04:36', NULL),
	(232, 19, 'charging_started', 'Charging Started', 'Your charging session (ID: 90) has started.', NULL, 90, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-15 14:04:42', NULL),
	(233, 19, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 90) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 90, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-15 14:04:51', NULL),
	(234, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 91) has started.', NULL, 91, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:04:52', NULL),
	(235, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 91) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 91, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:06:53', NULL),
	(236, 7, 'reservation_confirmed', 'Đặt chỗ mới', 'Có đặt chỗ mới tại trạm 22, trụ sạc 26. Thời gian: 2025-11-17T13:00 đến 2025-11-17T14:00', NULL, 49, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:07:59', NULL),
	(237, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 391CFBC2. Thời gian: 2025-11-17T13:00 đến 2025-11-17T14:00', NULL, 49, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:08:02', NULL),
	(238, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 92) has started.', NULL, 92, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:08:19', NULL),
	(239, 17, 'charging_started', 'Charging Started', 'Your charging session (ID: 93) has started.', NULL, 93, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:09:19', NULL),
	(240, 17, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 93) hoàn tất. Năng lượng: 0,60 kWh. SOC: 20,6%. Vui lòng thanh toán.', NULL, 93, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:09:34', NULL),
	(241, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 92) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 92, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:10:44', NULL),
	(242, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 94) has started.', NULL, 94, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:12:06', NULL),
	(243, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 94) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 94, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:12:57', NULL),
	(244, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 95) has started.', NULL, 95, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:19:44', NULL),
	(245, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 95) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 95, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-16 21:20:00', NULL),
	(246, 7, 'reservation_confirmed', 'Đặt chỗ mới', 'Có đặt chỗ mới tại trạm 21, trụ sạc 25. Thời gian: 2025-11-19T00:00 đến 2025-11-19T01:00', NULL, 50, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:18:33', NULL),
	(247, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 38BFE0FC. Thời gian: 2025-11-19T00:00 đến 2025-11-19T01:00', NULL, 50, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:18:37', NULL),
	(248, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 96) has started.', NULL, 96, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:19:22', NULL),
	(249, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 96) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 96, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:19:35', NULL),
	(250, 7, 'reservation_confirmed', 'Đặt chỗ mới', 'Có đặt chỗ mới tại trạm 21, trụ sạc 25. Thời gian: 2025-11-19T00:00 đến 2025-11-19T01:00', NULL, 51, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:20:50', NULL),
	(251, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: BA1EB1C1. Thời gian: 2025-11-19T00:00 đến 2025-11-19T01:00', NULL, 51, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:20:54', NULL),
	(252, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 97) has started.', NULL, 97, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:25:18', NULL),
	(253, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 97) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 97, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:25:35', NULL),
	(254, 7, 'reservation_confirmed', 'Đặt chỗ mới', 'Có đặt chỗ mới tại trạm 21, trụ sạc 25. Thời gian: 2025-11-19T00:00 đến 2025-11-19T01:00', NULL, 52, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:28:03', NULL),
	(255, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 4B29F152. Thời gian: 2025-11-19T00:00 đến 2025-11-19T01:00', NULL, 52, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:28:07', NULL),
	(256, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 98) has started.', NULL, 98, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:28:32', NULL),
	(257, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 98) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 98, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:29:26', NULL),
	(258, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 99) has started.', NULL, 99, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:35:07', NULL),
	(259, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 99) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 99, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 08:35:19', NULL),
	(260, 7, 'reservation_confirmed', 'Đặt chỗ mới', 'Có đặt chỗ mới tại trạm 21, trụ sạc 25. Thời gian: 2025-11-19T15:00 đến 2025-11-19T16:00', NULL, 53, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 23:24:46', NULL),
	(261, 15, 'reservation_confirmed', 'Đặt chỗ thành công', 'Bạn đã đặt chỗ thành công. Mã xác nhận: 59BADF70. Thời gian: 2025-11-19T15:00 đến 2025-11-19T16:00', NULL, 53, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 23:24:50', NULL),
	(262, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 100) has started.', NULL, 100, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 23:25:56', NULL),
	(263, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 100) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 100, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 23:26:35', NULL),
	(264, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 101) has started.', NULL, 101, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 23:27:43', NULL),
	(265, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 101) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 101, 0, NULL, 0, NULL, 0, NULL, 1, NULL, 'normal', NULL, '2025-11-18 23:27:53', NULL),
	(266, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 102) has started.', NULL, 102, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-18 23:36:02', NULL),
	(267, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 102) hoàn tất. Năng lượng: 1,80 kWh. SOC: 21,8%. Vui lòng thanh toán.', NULL, 102, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-18 23:39:42', NULL),
	(268, 15, 'charging_started', 'Charging Started', 'Your charging session (ID: 103) has started.', NULL, 103, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-19 02:41:17', NULL),
	(269, 15, 'charging_complete', 'Sạc hoàn tất', 'Phiên sạc (ID: 103) hoàn tất. Năng lượng: 64,00 kWh. SOC: 84,0%. Vui lòng thanh toán.', NULL, 103, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 'normal', NULL, '2025-11-19 02:41:26', NULL);

-- Dumping structure for table notification_service_db.notification_templates
CREATE TABLE IF NOT EXISTS `notification_templates` (
  `template_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `template_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `template_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notification_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_template` json NOT NULL COMMENT '{"vi": "...", "en": "..."}',
  `message_template` json NOT NULL,
  `channels` json DEFAULT NULL COMMENT '["push", "email", "sms"]',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `template_code` (`template_code`),
  KEY `idx_template_code` (`template_code`),
  KEY `idx_notification_type` (`notification_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table notification_service_db.notification_templates: ~0 rows (approximately)

-- Dumping structure for table notification_service_db.push_tokens
CREATE TABLE IF NOT EXISTS `push_tokens` (
  `token_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `device_token` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_type` enum('ios','android','web') COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_info` json DEFAULT NULL COMMENT '{"model", "os_version", "app_version"}',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_used_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_device_token` (`device_token`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table notification_service_db.push_tokens: ~0 rows (approximately)


-- Dumping database structure for payment_service_db
CREATE DATABASE IF NOT EXISTS `payment_service_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `payment_service_db`;

-- Dumping structure for table payment_service_db.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `payment_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `session_id` bigint unsigned NOT NULL COMMENT 'Reference to charging_service',
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `amount` decimal(15,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'VND',
  `payment_method` enum('wallet','e_wallet','banking','credit_card','debit_card','cash','qr_payment') COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'VNPay, MoMo, ZaloPay, etc.',
  `provider_transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_response` json DEFAULT NULL,
  `payment_status` enum('pending','processing','completed','failed','refunded','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `base_amount` decimal(15,2) DEFAULT NULL COMMENT 'Base charging cost',
  `service_fee` decimal(15,2) DEFAULT '0.00',
  `discount_amount` decimal(15,2) DEFAULT '0.00',
  `tax_amount` decimal(15,2) DEFAULT '0.00',
  `payment_time` timestamp NULL DEFAULT NULL,
  `refund_time` timestamp NULL DEFAULT NULL,
  `refund_amount` decimal(15,2) DEFAULT NULL,
  `refund_reason` text COLLATE utf8mb4_unicode_ci,
  `invoice_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `price_per_kwh` decimal(10,2) DEFAULT '3000.00' COMMENT 'Price per kWh used for this payment',
  `energy_consumed` decimal(10,2) DEFAULT NULL COMMENT 'Energy consumed for this payment (kWh)',
  PRIMARY KEY (`payment_id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_payment_status` (`payment_status`),
  KEY `idx_payment_time` (`payment_time`),
  KEY `idx_payments_price_per_kwh` (`price_per_kwh`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table payment_service_db.payments: ~141 rows (approximately)
INSERT INTO `payments` (`payment_id`, `session_id`, `user_id`, `amount`, `currency`, `payment_method`, `provider`, `provider_transaction_id`, `provider_response`, `payment_status`, `base_amount`, `service_fee`, `discount_amount`, `tax_amount`, `payment_time`, `refund_time`, `refund_amount`, `refund_reason`, `invoice_url`, `receipt_number`, `created_at`, `updated_at`, `price_per_kwh`, `energy_consumed`) VALUES
	(1, 1, 1, 46500.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-10-20 09:49:51', NULL, NULL, NULL, NULL, NULL, '2025-10-20 09:49:51', '2025-10-20 16:49:51', 3000.00, NULL),
	(2, 3, 1, 7281180.00, 'VND', 'wallet', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-20 15:14:32', '2025-10-20 22:14:32', 3000.00, NULL),
	(3, 6, 1, 270.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-10-24 17:11:30', NULL, NULL, NULL, NULL, NULL, '2025-10-24 17:11:30', '2025-10-25 00:11:29', 3000.00, NULL),
	(4, 7, 1, 1650.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-10-24 17:13:45', NULL, NULL, NULL, NULL, NULL, '2025-10-24 17:13:45', '2025-10-25 00:13:45', 3000.00, NULL),
	(5, 9, 1, 240.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-10-24 19:57:35', NULL, NULL, NULL, NULL, NULL, '2025-10-24 19:57:35', '2025-10-25 02:57:35', 3000.00, NULL),
	(6, 11, 1, 540.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-10-26 00:23:24', NULL, NULL, NULL, NULL, NULL, '2025-10-26 00:23:24', '2025-10-26 07:23:24', 3000.00, NULL),
	(7, 14, 11, 1800.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 00:41:43', NULL, NULL, NULL, NULL, NULL, '2025-11-01 00:41:43', '2025-11-01 07:41:43', 3000.00, NULL),
	(8, 10, 1, 16050600.00, 'VND', 'wallet', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-01 04:57:06', '2025-11-01 11:57:06', 3000.00, NULL),
	(9, 5, 1, 19413000.00, 'VND', 'wallet', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-01 04:57:10', '2025-11-01 11:57:09', 3000.00, NULL),
	(10, 4, 1, 30749400.00, 'VND', 'wallet', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-01 04:57:11', '2025-11-01 11:57:11', 3000.00, NULL),
	(11, 2, 1, 39043800.00, 'VND', 'wallet', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-01 04:57:14', '2025-11-01 11:57:13', 3000.00, NULL),
	(12, 1, 1, 39090600.00, 'VND', 'wallet', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-01 04:57:17', '2025-11-01 11:57:16', 3000.00, NULL),
	(13, 10, 1, 26751000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 04:59:39', NULL, NULL, NULL, NULL, NULL, '2025-11-01 04:59:39', '2025-11-01 11:59:39', 3000.00, NULL),
	(14, 13, 11, 3000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 04:59:49', NULL, NULL, NULL, NULL, NULL, '2025-11-01 04:59:49', '2025-11-01 11:59:48', 3000.00, NULL),
	(15, 12, 11, 33000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 04:59:51', NULL, NULL, NULL, NULL, NULL, '2025-11-01 04:59:51', '2025-11-01 11:59:51', 3000.00, NULL),
	(16, 8, 7, 1000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 05:00:06', NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:00:06', '2025-11-01 12:00:06', 3000.00, NULL),
	(17, 5, 1, 32355000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 05:00:09', NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:00:09', '2025-11-01 12:00:09', 3000.00, NULL),
	(18, 4, 1, 51249000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 05:00:12', NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:00:12', '2025-11-01 12:00:11', 3000.00, NULL),
	(19, 3, 1, 12136000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 05:00:17', NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:00:17', '2025-11-01 12:00:16', 3000.00, NULL),
	(20, 2, 1, 65073000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 05:00:19', NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:00:19', '2025-11-01 12:00:18', 3000.00, NULL),
	(21, 15, 8, 1800.00, 'VND', 'wallet', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:08:29', '2025-11-01 12:08:28', 3000.00, NULL),
	(22, 15, 8, 3000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 05:09:17', NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:09:17', '2025-11-01 12:09:16', 3000.00, NULL),
	(23, 16, 8, 1800.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 05:11:43', NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:11:43', '2025-11-01 12:11:43', 3000.00, NULL),
	(24, 17, 8, 1800.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 05:24:22', NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:24:22', '2025-11-01 12:24:22', 3000.00, NULL),
	(25, 18, 15, 5400.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 05:40:00', NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:39:15', '2025-11-01 12:39:59', 3000.00, NULL),
	(26, 19, 7, 6000.00, 'VND', 'wallet', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-01 05:59:53', '2025-11-01 12:59:53', 3000.00, NULL),
	(27, 19, 7, 6000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 06:00:11', NULL, NULL, NULL, NULL, NULL, '2025-11-01 06:00:11', '2025-11-01 13:00:10', 3000.00, NULL),
	(28, 20, 12, 1800.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 06:16:16', NULL, NULL, NULL, NULL, NULL, '2025-11-01 06:16:09', '2025-11-01 13:16:16', 3000.00, NULL),
	(29, 21, 15, 1800.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-01 06:25:51', NULL, NULL, NULL, NULL, NULL, '2025-11-01 06:25:40', '2025-11-01 13:25:51', 3000.00, NULL),
	(30, 24, 15, 1800.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-04 03:49:55', NULL, NULL, NULL, NULL, NULL, '2025-11-04 03:49:20', '2025-11-04 10:49:54', 3000.00, NULL),
	(31, 25, 16, 63000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-04 10:05:03', NULL, NULL, NULL, NULL, NULL, '2025-11-04 10:04:55', '2025-11-04 17:05:02', 3000.00, NULL),
	(32, 23, 15, 2160000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-04 10:12:10', NULL, NULL, NULL, NULL, NULL, '2025-11-04 10:12:10', '2025-11-04 17:12:09', 3000.00, NULL),
	(33, 26, 15, 3600.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-05 04:10:22', NULL, NULL, NULL, NULL, NULL, '2025-11-05 04:10:09', '2025-11-05 11:10:21', 3000.00, NULL),
	(34, 27, 15, 1800.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-05 04:11:17', NULL, NULL, NULL, NULL, NULL, '2025-11-05 04:11:17', '2025-11-05 11:11:17', 3000.00, NULL),
	(35, 28, 15, 1800.00, 'VND', 'cash', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, '2025-11-09 08:22:43', NULL, NULL, NULL, NULL, NULL, '2025-11-09 05:44:29', '2025-11-09 15:22:43', 3000.00, NULL),
	(36, 29, 15, 1800.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-09 08:27:28', NULL, NULL, NULL, NULL, NULL, '2025-11-09 08:27:06', '2025-11-09 15:27:28', 3000.00, NULL),
	(37, 30, 15, 1800.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-09 10:59:48', NULL, NULL, NULL, NULL, NULL, '2025-11-09 10:59:38', '2025-11-09 17:59:47', 3000.00, NULL),
	(38, 28, 15, 3000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-09 11:00:02', NULL, NULL, NULL, NULL, NULL, '2025-11-09 11:00:02', '2025-11-09 18:00:01', 3000.00, NULL),
	(39, 31, 15, 3600.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-09 18:47:52', NULL, NULL, NULL, NULL, NULL, '2025-11-09 18:47:52', '2025-11-10 01:47:52', 3000.00, NULL),
	(40, 32, 15, 10800.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-09 18:58:20', NULL, NULL, NULL, NULL, NULL, '2025-11-09 18:58:20', '2025-11-10 01:58:20', 3000.00, NULL),
	(41, 35, 15, 3000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-09 19:08:15', NULL, NULL, NULL, NULL, NULL, '2025-11-09 19:08:15', '2025-11-10 02:08:15', 3000.00, NULL),
	(42, 34, 15, 6000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-09 19:08:21', NULL, NULL, NULL, NULL, NULL, '2025-11-09 19:08:21', '2025-11-10 02:08:20', 3000.00, NULL),
	(43, 33, 15, 9000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-09 19:08:24', NULL, NULL, NULL, NULL, NULL, '2025-11-09 19:08:24', '2025-11-10 02:08:23', 3000.00, NULL),
	(44, 36, 15, 1800.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-09 19:21:31', NULL, NULL, NULL, NULL, NULL, '2025-11-09 19:21:31', '2025-11-10 02:21:31', 3000.00, NULL),
	(45, 38, 15, 1800.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-09 19:23:58', NULL, NULL, NULL, NULL, NULL, '2025-11-09 19:23:58', '2025-11-10 02:23:58', 3000.00, NULL),
	(46, 37, 15, 3000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 06:38:35', NULL, NULL, NULL, NULL, NULL, '2025-11-10 06:38:35', '2025-11-10 13:38:35', 3000.00, NULL),
	(47, 39, 15, 3000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 06:38:38', NULL, NULL, NULL, NULL, NULL, '2025-11-10 06:38:38', '2025-11-10 13:38:38', 3000.00, NULL),
	(48, 40, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 06:47:08', NULL, NULL, NULL, NULL, NULL, '2025-11-10 06:47:07', '2025-11-10 13:47:07', 3000.00, NULL),
	(49, 41, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 06:53:37', NULL, NULL, NULL, NULL, NULL, '2025-11-10 06:53:37', '2025-11-10 13:53:37', 3000.00, NULL),
	(50, 42, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 07:07:16', NULL, NULL, NULL, NULL, NULL, '2025-11-10 07:07:16', '2025-11-10 14:07:16', 3000.00, NULL),
	(51, 43, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 07:49:10', NULL, NULL, NULL, NULL, NULL, '2025-11-10 07:49:10', '2025-11-10 14:49:09', 3000.00, NULL),
	(52, 44, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 11:04:27', NULL, NULL, NULL, NULL, NULL, '2025-11-10 11:04:27', '2025-11-10 18:04:27', 3000.00, NULL),
	(53, 45, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 11:11:26', NULL, NULL, NULL, NULL, NULL, '2025-11-10 11:11:26', '2025-11-10 18:11:25', 3000.00, NULL),
	(54, 46, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 11:27:25', NULL, NULL, NULL, NULL, NULL, '2025-11-10 11:27:24', '2025-11-10 18:27:24', 3000.00, NULL),
	(55, 47, 15, 3000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 11:30:18', NULL, NULL, NULL, NULL, NULL, '2025-11-10 11:30:18', '2025-11-10 18:30:17', 3000.00, NULL),
	(56, 47, 15, 900.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 11:30:40', NULL, NULL, NULL, NULL, NULL, '2025-11-10 11:30:40', '2025-11-10 18:30:40', 3000.00, NULL),
	(57, 48, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-10 11:36:14', NULL, NULL, NULL, NULL, NULL, '2025-11-10 11:36:14', '2025-11-10 18:36:13', 3000.00, NULL),
	(58, 49, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-11 08:49:16', NULL, NULL, NULL, NULL, NULL, '2025-11-11 08:49:16', '2025-11-11 15:49:16', 3000.00, NULL),
	(59, 50, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-11 08:49:39', NULL, NULL, NULL, NULL, NULL, '2025-11-11 08:49:39', '2025-11-11 15:49:38', 3000.00, NULL),
	(60, 50, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-11 08:50:09', NULL, NULL, NULL, NULL, NULL, '2025-11-11 08:50:09', '2025-11-11 15:50:08', 3000.00, NULL),
	(61, 51, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-11 08:51:26', NULL, NULL, NULL, NULL, NULL, '2025-11-11 08:51:26', '2025-11-11 15:51:26', 3000.00, NULL),
	(62, 51, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-11 08:51:35', NULL, NULL, NULL, NULL, NULL, '2025-11-11 08:51:35', '2025-11-11 15:51:34', 3000.00, NULL),
	(63, 52, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-11 08:56:43', NULL, NULL, NULL, NULL, NULL, '2025-11-11 08:56:43', '2025-11-11 15:56:42', 3000.00, NULL),
	(64, 53, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-11 09:10:27', NULL, NULL, NULL, NULL, NULL, '2025-11-11 09:10:27', '2025-11-11 16:10:26', 3000.00, NULL),
	(65, 54, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-11 23:00:12', NULL, NULL, NULL, NULL, NULL, '2025-11-11 23:00:12', '2025-11-12 06:00:12', 3000.00, NULL),
	(66, 55, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-11 23:38:15', NULL, NULL, NULL, NULL, NULL, '2025-11-11 23:38:15', '2025-11-12 06:38:14', 3000.00, NULL),
	(67, 56, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-11 23:45:38', NULL, NULL, NULL, NULL, NULL, '2025-11-11 23:45:38', '2025-11-12 06:45:38', 3000.00, NULL),
	(68, 56, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 03:33:06', NULL, NULL, NULL, NULL, NULL, '2025-11-12 03:33:06', '2025-11-12 10:33:06', 3000.00, NULL),
	(69, 57, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 03:33:27', NULL, NULL, NULL, NULL, NULL, '2025-11-12 03:33:27', '2025-11-12 10:33:26', 3000.00, NULL),
	(70, 57, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 03:33:31', NULL, NULL, NULL, NULL, NULL, '2025-11-12 03:33:31', '2025-11-12 10:33:31', 3000.00, NULL),
	(71, 58, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 03:34:07', NULL, NULL, NULL, NULL, NULL, '2025-11-12 03:34:07', '2025-11-12 10:34:06', 3000.00, NULL),
	(72, 59, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 04:37:47', NULL, NULL, NULL, NULL, NULL, '2025-11-12 04:37:47', '2025-11-12 11:37:47', 1500.00, 80.00),
	(73, 60, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 04:39:01', NULL, NULL, NULL, NULL, NULL, '2025-11-12 04:39:01', '2025-11-12 11:39:01', 1500.00, 80.00),
	(74, 60, 17, 120000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 04:40:56', NULL, NULL, NULL, NULL, NULL, '2025-11-12 04:40:34', '2025-11-12 11:40:55', 1500.00, 80.00),
	(75, 61, 17, 3000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 04:41:02', NULL, NULL, NULL, NULL, NULL, '2025-11-12 04:41:02', '2025-11-12 11:41:01', NULL, NULL),
	(76, 62, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 09:59:25', NULL, NULL, NULL, NULL, NULL, '2025-11-12 09:59:25', '2025-11-12 16:59:24', 1500.00, 80.00),
	(77, 63, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 09:59:48', NULL, NULL, NULL, NULL, NULL, '2025-11-12 09:59:48', '2025-11-12 16:59:48', 1500.00, 80.00),
	(78, 63, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:00:03', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:00:03', '2025-11-12 17:00:02', 1500.00, 80.00),
	(79, 64, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:00:23', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:00:23', '2025-11-12 17:00:23', 1500.00, 80.00),
	(80, 64, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:01:08', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:01:08', '2025-11-12 17:01:08', 1500.00, 80.00),
	(81, 66, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:01:26', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:01:26', '2025-11-12 17:01:25', 1500.00, 80.00),
	(82, 66, 15, 120000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:01:47', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:01:47', '2025-11-12 17:01:47', 1500.00, 80.00),
	(83, 65, 15, 900.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:01:57', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:01:57', '2025-11-12 17:01:57', 1500.00, 0.60),
	(84, 67, 17, 240000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:12:15', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:11:09', '2025-11-12 17:12:15', 3000.00, 80.00),
	(85, 67, 15, 240000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:14:40', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:14:40', '2025-11-12 17:14:40', 3000.00, 80.00),
	(86, 68, 15, 7200.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:21:56', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:21:56', '2025-11-12 17:21:56', 1500.00, 4.80),
	(87, 69, 15, 4500.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:27:30', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:27:30', '2025-11-12 17:27:29', 1500.00, 3.00),
	(88, 70, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 10:35:05', NULL, NULL, NULL, NULL, NULL, '2025-11-12 10:35:05', '2025-11-12 17:35:05', 1500.00, 64.00),
	(89, 71, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 11:24:32', NULL, NULL, NULL, NULL, NULL, '2025-11-12 11:24:32', '2025-11-12 18:24:32', 1500.00, 64.00),
	(90, 71, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 11:35:49', NULL, NULL, NULL, NULL, NULL, '2025-11-12 11:35:49', '2025-11-12 18:35:49', 1500.00, 64.00),
	(91, 72, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 11:36:39', NULL, NULL, NULL, NULL, NULL, '2025-11-12 11:36:39', '2025-11-12 18:36:39', 1500.00, 64.00),
	(92, 72, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-12 11:36:45', NULL, NULL, NULL, NULL, NULL, '2025-11-12 11:36:45', '2025-11-12 18:36:44', 1500.00, 64.00),
	(93, 73, 18, 192000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-13 02:29:22', NULL, NULL, NULL, NULL, NULL, '2025-11-13 02:28:41', '2025-11-13 09:29:22', 3000.00, 64.00),
	(94, 74, 18, 192000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-13 02:30:29', NULL, NULL, NULL, NULL, NULL, '2025-11-13 02:30:13', '2025-11-13 09:30:28', 3000.00, 64.00),
	(95, 74, 18, 192000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-13 02:30:46', NULL, NULL, NULL, NULL, NULL, '2025-11-13 02:30:46', '2025-11-13 09:30:46', 3000.00, 64.00),
	(96, 75, 12, 1319400.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-13 14:44:20', NULL, NULL, NULL, NULL, NULL, '2025-11-13 14:44:15', '2025-11-13 21:44:19', 3000.00, 439.80),
	(97, 76, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-13 15:05:19', NULL, NULL, NULL, NULL, NULL, '2025-11-13 15:05:19', '2025-11-13 22:05:19', 1500.00, 64.00),
	(98, 76, 15, 96000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-13 15:10:01', NULL, NULL, NULL, NULL, NULL, '2025-11-13 15:09:52', '2025-11-13 22:10:01', 1500.00, 64.00),
	(99, 77, 15, 96000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-13 15:10:53', NULL, NULL, NULL, NULL, NULL, '2025-11-13 15:10:46', '2025-11-13 22:10:52', 1500.00, 64.00),
	(100, 77, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-13 16:10:30', NULL, NULL, NULL, NULL, NULL, '2025-11-13 16:10:30', '2025-11-13 23:10:30', 1500.00, 64.00),
	(101, 78, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-13 16:10:57', NULL, NULL, NULL, NULL, NULL, '2025-11-13 16:10:57', '2025-11-13 23:10:56', 1500.00, 64.00),
	(102, 78, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 20:04:42', NULL, NULL, NULL, NULL, NULL, '2025-11-14 20:04:42', '2025-11-15 03:04:42', 1500.00, 64.00),
	(103, 79, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 20:18:07', NULL, NULL, NULL, NULL, NULL, '2025-11-14 20:18:07', '2025-11-15 03:18:07', 1500.00, 64.00),
	(104, 79, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 20:24:37', NULL, NULL, NULL, NULL, NULL, '2025-11-14 20:24:37', '2025-11-15 03:24:36', 1500.00, 64.00),
	(105, 81, 15, 1800.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 20:28:06', NULL, NULL, NULL, NULL, NULL, '2025-11-14 20:28:06', '2025-11-15 03:28:06', 1500.00, 1.20),
	(106, 82, 15, 27900.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 20:59:51', NULL, NULL, NULL, NULL, NULL, '2025-11-14 20:59:51', '2025-11-15 03:59:51', 1500.00, 18.60),
	(107, 82, 15, 27900.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 21:00:00', NULL, NULL, NULL, NULL, NULL, '2025-11-14 21:00:00', '2025-11-15 03:59:59', 1500.00, 18.60),
	(108, 80, 17, 60480.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 21:07:40', NULL, NULL, NULL, NULL, NULL, '2025-11-14 21:07:40', '2025-11-15 04:07:40', 1800.00, 33.60),
	(109, 80, 17, 60480.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 21:07:48', NULL, NULL, NULL, NULL, NULL, '2025-11-14 21:07:48', '2025-11-15 04:07:48', 1800.00, 33.60),
	(110, 83, 17, 115200.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 21:08:43', NULL, NULL, NULL, NULL, NULL, '2025-11-14 21:08:43', '2025-11-15 04:08:43', 1800.00, 64.00),
	(111, 83, 17, 115200.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 21:08:55', NULL, NULL, NULL, NULL, NULL, '2025-11-14 21:08:55', '2025-11-15 04:08:54', 1800.00, 64.00),
	(112, 84, 17, 115200.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 21:39:51', NULL, NULL, NULL, NULL, NULL, '2025-11-14 21:11:20', '2025-11-15 04:39:51', 1800.00, 64.00),
	(113, 85, 17, 115200.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 21:39:47', NULL, NULL, NULL, NULL, NULL, '2025-11-14 21:25:00', '2025-11-15 04:39:47', 1800.00, 64.00),
	(114, 86, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 21:39:32', NULL, NULL, NULL, NULL, NULL, '2025-11-14 21:39:32', '2025-11-15 04:39:32', 1500.00, 64.00),
	(115, 86, 17, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-14 22:21:48', NULL, NULL, NULL, NULL, NULL, '2025-11-14 22:21:48', '2025-11-15 05:21:48', 1500.00, 64.00),
	(116, 87, 19, 192000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-15 13:58:52', NULL, NULL, NULL, NULL, NULL, '2025-11-15 13:58:52', '2025-11-15 20:58:52', 3000.00, 64.00),
	(117, 87, 19, 192000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-15 14:03:44', NULL, NULL, NULL, NULL, NULL, '2025-11-15 14:03:44', '2025-11-15 21:03:43', 3000.00, 64.00),
	(118, 88, 19, 192000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-15 14:04:06', NULL, NULL, NULL, NULL, NULL, '2025-11-15 14:03:58', '2025-11-15 21:04:06', 3000.00, 64.00),
	(119, 89, 19, 192000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-15 14:04:37', NULL, NULL, NULL, NULL, NULL, '2025-11-15 14:04:37', '2025-11-15 21:04:37', 3000.00, 64.00),
	(120, 90, 19, 192000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-15 14:04:53', NULL, NULL, NULL, NULL, NULL, '2025-11-15 14:04:53', '2025-11-15 21:04:52', 3000.00, 64.00),
	(121, 91, 15, 96000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-16 21:07:40', NULL, NULL, NULL, NULL, NULL, '2025-11-16 21:07:05', '2025-11-17 04:07:40', 1500.00, 64.00),
	(122, 93, 12, 1080.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-16 21:09:46', NULL, NULL, NULL, NULL, NULL, '2025-11-16 21:09:41', '2025-11-17 04:09:45', 1800.00, 0.60),
	(123, 93, 17, 1080.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-16 21:10:10', NULL, NULL, NULL, NULL, NULL, '2025-11-16 21:10:00', '2025-11-17 04:10:09', 1800.00, 0.60),
	(124, 92, 15, 96000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-16 21:10:50', NULL, NULL, NULL, NULL, NULL, '2025-11-16 21:10:46', '2025-11-17 04:10:50', 1500.00, 64.00),
	(125, 92, 17, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-16 21:11:16', NULL, NULL, NULL, NULL, NULL, '2025-11-16 21:11:16', '2025-11-17 04:11:15', 1500.00, 64.00),
	(126, 94, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-16 21:12:59', NULL, NULL, NULL, NULL, NULL, '2025-11-16 21:12:59', '2025-11-17 04:12:58', 1500.00, 64.00),
	(127, 94, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-16 21:13:12', NULL, NULL, NULL, NULL, NULL, '2025-11-16 21:13:12', '2025-11-17 04:13:12', 1500.00, 64.00),
	(128, 95, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-16 21:20:02', NULL, NULL, NULL, NULL, NULL, '2025-11-16 21:20:02', '2025-11-17 04:20:02', 1500.00, 64.00),
	(129, 95, 17, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-18 08:05:36', NULL, NULL, NULL, NULL, NULL, '2025-11-18 08:05:36', '2025-11-18 15:05:36', 1500.00, 64.00),
	(130, 96, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-18 08:19:36', NULL, NULL, NULL, NULL, NULL, '2025-11-18 08:19:36', '2025-11-18 15:19:36', 1500.00, 64.00),
	(131, 97, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-18 08:25:37', NULL, NULL, NULL, NULL, NULL, '2025-11-18 08:25:37', '2025-11-18 15:25:37', 1500.00, 64.00),
	(132, 98, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-18 08:29:28', NULL, NULL, NULL, NULL, NULL, '2025-11-18 08:29:28', '2025-11-18 15:29:28', 1500.00, 64.00),
	(133, 98, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-18 08:31:30', NULL, NULL, NULL, NULL, NULL, '2025-11-18 08:31:30', '2025-11-18 15:31:30', 1500.00, 64.00),
	(134, 99, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-18 08:35:21', NULL, NULL, NULL, NULL, NULL, '2025-11-18 08:35:21', '2025-11-18 15:35:20', 1500.00, 64.00),
	(135, 100, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-18 23:26:38', NULL, NULL, NULL, NULL, NULL, '2025-11-18 23:26:38', '2025-11-19 06:26:38', 1500.00, 64.00),
	(136, 101, 15, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-18 23:28:47', NULL, NULL, NULL, NULL, NULL, '2025-11-18 23:28:47', '2025-11-19 06:28:46', 1500.00, 64.00),
	(137, 102, 15, 2700.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-18 23:39:44', NULL, NULL, NULL, NULL, NULL, '2025-11-18 23:39:44', '2025-11-19 06:39:43', 1500.00, 1.80),
	(138, 102, 15, 2700.00, 'VND', 'cash', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, '2025-11-19 03:13:39', NULL, NULL, NULL, NULL, NULL, '2025-11-19 02:41:04', '2025-11-19 10:13:39', 1500.00, 1.80),
	(139, 103, 15, 96000.00, 'VND', 'cash', NULL, NULL, NULL, 'failed', NULL, 0.00, 0.00, 0.00, '2025-11-19 03:13:39', NULL, NULL, NULL, NULL, NULL, '2025-11-19 02:41:29', '2025-11-19 10:13:39', 1500.00, 64.00),
	(140, 103, 15, 96000.00, 'VND', 'cash', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-19 02:42:47', NULL, NULL, NULL, NULL, NULL, '2025-11-19 02:42:47', '2025-11-19 09:42:47', NULL, NULL),
	(141, 103, 17, 96000.00, 'VND', 'wallet', NULL, NULL, NULL, 'completed', NULL, 0.00, 0.00, 0.00, '2025-11-23 00:43:59', NULL, NULL, NULL, NULL, NULL, '2025-11-23 00:43:58', '2025-11-23 07:43:58', 1500.00, 64.00);

-- Dumping structure for table payment_service_db.pricing_rules
CREATE TABLE IF NOT EXISTS `pricing_rules` (
  `pricing_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `station_id` bigint unsigned DEFAULT NULL COMMENT 'NULL for global rules',
  `charger_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_price_per_kwh` decimal(8,2) NOT NULL,
  `service_fee_percentage` decimal(5,2) DEFAULT '0.00',
  `peak_hours` json DEFAULT NULL COMMENT '[{"start": "17:00", "end": "21:00", "multiplier": 1.5}]',
  `off_peak_discount` decimal(5,2) DEFAULT '0.00',
  `weekend_multiplier` decimal(4,2) DEFAULT '1.00',
  `holiday_multiplier` decimal(4,2) DEFAULT '1.00',
  `effective_from` date NOT NULL,
  `effective_to` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_by` bigint unsigned DEFAULT NULL COMMENT 'Reference to user_service (admin)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pricing_id`),
  KEY `idx_station_id` (`station_id`),
  KEY `idx_effective_dates` (`effective_from`,`effective_to`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table payment_service_db.pricing_rules: ~0 rows (approximately)

-- Dumping structure for table payment_service_db.promotions
CREATE TABLE IF NOT EXISTS `promotions` (
  `promotion_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `promotion_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `promotion_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `discount_type` enum('percentage','fixed_amount','free_kwh') COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `max_discount_amount` decimal(10,2) DEFAULT NULL,
  `applicable_stations` json DEFAULT NULL COMMENT '[station_ids] or null for all',
  `applicable_user_types` json DEFAULT NULL COMMENT '["driver", "vip"] or null for all',
  `min_charge_amount` decimal(10,2) DEFAULT NULL,
  `usage_limit_per_user` int DEFAULT NULL,
  `total_usage_limit` int DEFAULT NULL,
  `current_usage_count` int DEFAULT '0',
  `valid_from` timestamp NOT NULL,
  `valid_to` timestamp NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`promotion_id`),
  UNIQUE KEY `promotion_code` (`promotion_code`),
  KEY `idx_promotion_code` (`promotion_code`),
  KEY `idx_valid_dates` (`valid_from`,`valid_to`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table payment_service_db.promotions: ~0 rows (approximately)

-- Dumping structure for table payment_service_db.promotion_usage
CREATE TABLE IF NOT EXISTS `promotion_usage` (
  `usage_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `promotion_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `payment_id` bigint unsigned NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL,
  `used_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`usage_id`),
  KEY `idx_promotion_id` (`promotion_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `payment_id` (`payment_id`),
  CONSTRAINT `promotion_usage_ibfk_1` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`promotion_id`) ON DELETE CASCADE,
  CONSTRAINT `promotion_usage_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table payment_service_db.promotion_usage: ~0 rows (approximately)

-- Dumping structure for table payment_service_db.wallets
CREATE TABLE IF NOT EXISTS `wallets` (
  `wallet_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `balance` decimal(15,2) DEFAULT '0.00',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'VND',
  `status` enum('active','frozen','closed') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`wallet_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table payment_service_db.wallets: ~12 rows (approximately)
INSERT INTO `wallets` (`wallet_id`, `user_id`, `balance`, `currency`, `status`, `created_at`, `updated_at`) VALUES
	(1, 1, 800.00, 'VND', 'active', '2025-10-17 20:36:42', '2025-10-26 00:23:24'),
	(2, 2, 50000.00, 'VND', 'active', '2025-10-17 20:40:42', '2025-10-17 20:40:42'),
	(3, 11, 1000000.00, 'VND', 'active', '2025-10-31 12:11:08', '2025-11-01 12:28:25'),
	(4, 8, 98200.00, 'VND', 'active', '2025-11-01 03:15:54', '2025-11-01 05:11:43'),
	(5, 10, 0.00, 'VND', 'active', '2025-11-01 03:24:58', '2025-11-01 03:24:58'),
	(6, 7, 0.00, 'VND', 'active', '2025-11-01 05:03:01', '2025-11-01 05:03:01'),
	(7, 15, 6036200.00, 'VND', 'active', '2025-11-01 05:38:07', '2025-11-18 23:39:44'),
	(8, 12, 0.00, 'VND', 'active', '2025-11-01 05:55:51', '2025-11-01 05:55:51'),
	(9, 16, 1102000.00, 'VND', 'active', '2025-11-04 09:27:50', '2025-11-04 15:40:26'),
	(10, 17, 1666640.00, 'VND', 'active', '2025-11-12 04:40:01', '2025-11-23 00:43:59'),
	(11, 18, 809000.00, 'VND', 'active', '2025-11-13 02:28:36', '2025-11-13 02:31:03'),
	(12, 19, 732000.00, 'VND', 'active', '2025-11-15 13:58:12', '2025-11-15 14:04:53');

-- Dumping structure for table payment_service_db.wallet_transactions
CREATE TABLE IF NOT EXISTS `wallet_transactions` (
  `transaction_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint unsigned NOT NULL,
  `transaction_type` enum('deposit','withdraw','charge','refund','bonus') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `balance_before` decimal(15,2) NOT NULL,
  `balance_after` decimal(15,2) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `reference_id` bigint unsigned DEFAULT NULL COMMENT 'session_id or payment_id',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `idx_wallet_id` (`wallet_id`),
  KEY `idx_transaction_type` (`transaction_type`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `wallet_transactions_ibfk_1` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`wallet_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table payment_service_db.wallet_transactions: ~0 rows (approximately)


-- Dumping database structure for station_service_db
CREATE DATABASE IF NOT EXISTS `station_service_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `station_service_db`;

-- Dumping structure for table station_service_db.chargers
CREATE TABLE IF NOT EXISTS `chargers` (
  `charger_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `station_id` bigint unsigned NOT NULL,
  `charger_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `charger_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charger_type` enum('CCS','CHAdeMO','AC_Type2','GB/T') COLLATE utf8mb4_unicode_ci NOT NULL,
  `power_rating` decimal(6,2) NOT NULL COMMENT 'kW',
  `connector_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('available','in_use','offline','maintenance','reserved') COLLATE utf8mb4_unicode_ci DEFAULT 'available',
  `current_session_id` bigint unsigned DEFAULT NULL COMMENT 'Reference to charging_service',
  `firmware_version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `installation_date` date DEFAULT NULL,
  `last_maintenance_date` date DEFAULT NULL,
  `next_maintenance_date` date DEFAULT NULL,
  `total_sessions` int DEFAULT '0',
  `total_energy_delivered` decimal(12,2) DEFAULT '0.00' COMMENT 'kWh',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`charger_id`),
  UNIQUE KEY `charger_code` (`charger_code`),
  KEY `idx_station_id` (`station_id`),
  KEY `idx_status` (`status`),
  KEY `idx_charger_type` (`charger_type`),
  CONSTRAINT `chargers_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `stations` (`station_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table station_service_db.chargers: ~45 rows (approximately)
INSERT INTO `chargers` (`charger_id`, `station_id`, `charger_code`, `charger_name`, `charger_type`, `power_rating`, `connector_type`, `status`, `current_session_id`, `firmware_version`, `installation_date`, `last_maintenance_date`, `next_maintenance_date`, `total_sessions`, `total_energy_delivered`, `created_at`, `updated_at`) VALUES
	(5, 1, 'HCM-Q1-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-19 06:39:41'),
	(6, 2, 'HCM-Q1-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-15 03:28:00'),
	(7, 3, 'HCM-Q1-003-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-15 03:59:48'),
	(8, 4, 'HCM-Q3-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(9, 5, 'HCM-Q3-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(10, 6, 'HCM-Q7-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(11, 7, 'HCM-Q7-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(12, 8, 'HCM-Q10-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-04 18:34:33'),
	(13, 9, 'HCM-Q10-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-04 18:21:48'),
	(14, 10, 'HCM-BT-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-15 03:18:05'),
	(15, 11, 'HCM-BT-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(16, 12, 'HCM-TB-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-04 11:09:05'),
	(17, 13, 'HCM-TB-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(18, 14, 'HCM-GV-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(19, 15, 'HCM-GV-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(20, 16, 'HCM-PN-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(21, 17, 'HCM-PN-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(22, 18, 'HCM-TD-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(23, 19, 'HCM-TD-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(24, 20, 'HCM-TD-003-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(25, 21, 'HCM-Q12-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-19 09:41:26'),
	(26, 22, 'HCM-Q12-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-17 04:10:44'),
	(27, 23, 'HCM-TP-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(28, 24, 'HCM-TP-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(29, 25, 'HCM-Q4-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(30, 26, 'HCM-Q4-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(31, 27, 'HCM-Q5-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(32, 28, 'HCM-Q5-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(33, 29, 'HCM-Q6-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(35, 31, 'HCM-Q8-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(36, 32, 'HCM-Q8-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(37, 33, 'HCM-Q11-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(38, 34, 'HCM-Q11-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(39, 35, 'HCM-BT2-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(40, 36, 'HCM-BT2-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(41, 37, 'HCM-BC-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(42, 38, 'HCM-BC-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(43, 39, 'HCM-CC-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(44, 40, 'HCM-CC-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(45, 41, 'HCM-HM-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-01 12:11:43'),
	(46, 42, 'HCM-HM-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-11-10 13:37:43'),
	(47, 43, 'HCM-NB-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(48, 44, 'HCM-NB-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(49, 45, 'HCM-CG-001-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51'),
	(50, 46, 'HCM-CG-002-CHG-001', NULL, 'CCS', 50.00, NULL, 'available', NULL, NULL, NULL, NULL, NULL, 0, 0.00, '2025-10-31 12:07:51', '2025-10-31 12:07:51');

-- Dumping structure for table station_service_db.charger_status_logs
CREATE TABLE IF NOT EXISTS `charger_status_logs` (
  `log_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `charger_id` bigint unsigned NOT NULL,
  `previous_status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `changed_by` bigint unsigned DEFAULT NULL COMMENT 'Reference to user_service',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`),
  KEY `idx_charger_id` (`charger_id`),
  KEY `idx_timestamp` (`timestamp`),
  CONSTRAINT `charger_status_logs_ibfk_1` FOREIGN KEY (`charger_id`) REFERENCES `chargers` (`charger_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table station_service_db.charger_status_logs: ~0 rows (approximately)

-- Dumping structure for table station_service_db.incidents
CREATE TABLE IF NOT EXISTS `incidents` (
  `incident_id` bigint NOT NULL AUTO_INCREMENT,
  `station_id` bigint NOT NULL,
  `charger_id` bigint DEFAULT NULL COMMENT 'Nullable - can be null for station-wide incidents',
  `incident_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'equipment, power, network, other',
  `severity` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'low, medium, high, critical',
  `description` text COLLATE utf8mb4_unicode_ci,
  `reported_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of staff member or person who reported',
  `status` enum('pending','in_progress','resolved','closed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint DEFAULT NULL COMMENT 'ID của user báo cáo (từ user-service)',
  `assigned_to` bigint DEFAULT NULL COMMENT 'ID của staff/admin được phân công xử lý',
  `assigned_at` datetime DEFAULT NULL COMMENT 'Thời gian phân công',
  `priority` enum('low','medium','high','urgent') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium' COMMENT 'Ưu tiên sự cố',
  `resolution_notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Ghi chú về cách xử lý',
  `resolution_rating` int DEFAULT NULL COMMENT 'Đánh giá hiệu quả (1-5)',
  `estimated_resolution_time` datetime DEFAULT NULL COMMENT 'Thời gian dự kiến xử lý xong',
  PRIMARY KEY (`incident_id`),
  KEY `idx_incidents_station_id` (`station_id`),
  KEY `idx_incidents_charger_id` (`charger_id`),
  KEY `idx_incidents_status` (`status`),
  KEY `idx_incidents_severity` (`severity`),
  KEY `idx_incidents_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Incident reports for stations and chargers';

-- Dumping data for table station_service_db.incidents: ~5 rows (approximately)
INSERT INTO `incidents` (`incident_id`, `station_id`, `charger_id`, `incident_type`, `severity`, `description`, `reported_by`, `status`, `created_at`, `updated_at`, `resolved_at`, `user_id`, `assigned_to`, `assigned_at`, `priority`, `resolution_notes`, `resolution_rating`, `estimated_resolution_time`) VALUES
	(1, 1, NULL, 'power', 'medium', '111111', 'Lê Hoàn Nguyên Vũ', 'resolved', '2025-11-12 04:49:49', '2025-11-12 05:02:30', '2025-11-12 05:02:30', NULL, NULL, NULL, 'medium', NULL, NULL, NULL),
	(2, 1, NULL, 'power', 'medium', '11111', 'Lê Hoàn Nguyên Vũ', 'resolved', '2025-11-12 05:01:35', '2025-11-12 05:02:26', '2025-11-12 05:02:26', NULL, NULL, NULL, 'medium', NULL, NULL, NULL),
	(3, 1, NULL, 'power', 'medium', '1111', 'Lê Hoàn Nguyên Vũ', 'resolved', '2025-11-12 05:10:34', '2025-11-13 15:00:27', '2025-11-13 15:00:27', NULL, NULL, NULL, 'medium', NULL, NULL, NULL),
	(4, 1, NULL, 'power', 'medium', '1111', 'Lê Hoàn Nguyên Vũ', 'resolved', '2025-11-12 05:10:34', '2025-11-13 15:00:32', '2025-11-13 15:00:32', NULL, NULL, NULL, 'medium', NULL, NULL, NULL),
	(5, 1, NULL, 'power', 'critical', 'Sạc cháy', 'Lê Hoàn Nguyên Vũ', 'resolved', '2025-11-19 23:27:52', '2025-11-19 23:28:33', '2025-11-19 23:28:33', NULL, 3, '2025-11-20 06:28:19', 'medium', 'aaaa', 5, NULL);

-- Dumping structure for table station_service_db.incident_history
CREATE TABLE IF NOT EXISTS `incident_history` (
  `history_id` bigint NOT NULL AUTO_INCREMENT,
  `incident_id` bigint NOT NULL,
  `action_type` enum('created','status_changed','priority_changed','assigned','reassigned','note_added','resolved','closed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_by` bigint DEFAULT NULL COMMENT 'ID của user thực hiện action',
  `action_by_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Tên người thực hiện',
  `old_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_priority` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_priority` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_assigned_to` bigint DEFAULT NULL,
  `new_assigned_to` bigint DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`history_id`),
  KEY `idx_incident_id` (`incident_id`),
  KEY `idx_action_by` (`action_by`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_incident_history_incident` FOREIGN KEY (`incident_id`) REFERENCES `incidents` (`incident_id`) ON DELETE CASCADE,
  CONSTRAINT `incident_history_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incidents` (`incident_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table station_service_db.incident_history: ~3 rows (approximately)
INSERT INTO `incident_history` (`history_id`, `incident_id`, `action_type`, `action_by`, `action_by_name`, `old_status`, `new_status`, `old_priority`, `new_priority`, `old_assigned_to`, `new_assigned_to`, `notes`, `created_at`) VALUES
	(1, 5, 'created', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sự cố được tạo mới', '2025-11-20 06:27:52'),
	(2, 5, 'assigned', 7, NULL, NULL, NULL, NULL, NULL, NULL, 3, '', '2025-11-20 06:28:19'),
	(3, 5, 'resolved', 7, NULL, 'resolved', 'resolved', NULL, NULL, NULL, NULL, 'Đã xử lý: aaaa', '2025-11-20 06:28:33');

-- Dumping structure for table station_service_db.maintenance_records
CREATE TABLE IF NOT EXISTS `maintenance_records` (
  `maintenance_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `charger_id` bigint unsigned NOT NULL,
  `maintenance_type` enum('routine','repair','emergency','upgrade') COLLATE utf8mb4_unicode_ci NOT NULL,
  `technician_id` bigint unsigned DEFAULT NULL COMMENT 'Reference to user_service',
  `issue_description` text COLLATE utf8mb4_unicode_ci,
  `action_taken` text COLLATE utf8mb4_unicode_ci,
  `parts_replaced` json DEFAULT NULL COMMENT '[{"part_name", "quantity", "cost"}]',
  `start_time` timestamp NOT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `status` enum('scheduled','in_progress','completed','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'scheduled',
  `cost` decimal(12,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`maintenance_id`),
  KEY `idx_charger_id` (`charger_id`),
  KEY `idx_status` (`status`),
  KEY `idx_start_time` (`start_time`),
  CONSTRAINT `maintenance_records_ibfk_1` FOREIGN KEY (`charger_id`) REFERENCES `chargers` (`charger_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table station_service_db.maintenance_records: ~0 rows (approximately)

-- Dumping structure for table station_service_db.maintenance_schedules
CREATE TABLE IF NOT EXISTS `maintenance_schedules` (
  `schedule_id` bigint NOT NULL AUTO_INCREMENT,
  `station_id` bigint NOT NULL,
  `charger_id` bigint DEFAULT NULL,
  `maintenance_type` enum('preventive','corrective','emergency','upgrade','inspection') COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `scheduled_start_time` datetime NOT NULL,
  `scheduled_end_time` datetime NOT NULL,
  `actual_start_time` datetime DEFAULT NULL,
  `actual_end_time` datetime DEFAULT NULL,
  `assigned_to` bigint DEFAULT NULL,
  `status` enum('scheduled','in_progress','completed','cancelled','skipped') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'scheduled',
  `recurrence_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurrence_interval` int DEFAULT NULL,
  `next_scheduled_time` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`schedule_id`),
  KEY `idx_station_id` (`station_id`),
  KEY `idx_status` (`status`),
  KEY `idx_assigned_to` (`assigned_to`),
  KEY `idx_scheduled_start_time` (`scheduled_start_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table station_service_db.maintenance_schedules: ~3 rows (approximately)
INSERT INTO `maintenance_schedules` (`schedule_id`, `station_id`, `charger_id`, `maintenance_type`, `title`, `description`, `scheduled_start_time`, `scheduled_end_time`, `actual_start_time`, `actual_end_time`, `assigned_to`, `status`, `recurrence_type`, `recurrence_interval`, `next_scheduled_time`, `notes`, `created_at`, `updated_at`) VALUES
	(1, 1, NULL, 'corrective', '111', '111', '2025-11-20 07:00:00', '2025-11-21 07:00:00', '2025-11-22 07:54:16', '2025-11-22 07:54:30', 12, 'completed', 'daily', NULL, NULL, '1111\n', '2025-11-20 06:40:09', '2025-11-22 07:54:30'),
	(2, 1, 5, 'preventive', '111', '111', '2025-11-20 07:00:00', '2025-11-21 06:40:00', '2025-11-22 07:54:22', '2025-11-22 07:54:26', 12, 'completed', 'daily', 1, '2025-11-27 07:00:00', '111\n', '2025-11-20 06:40:59', '2025-11-22 07:54:26'),
	(3, 1, 5, 'preventive', '111', '111', '2025-11-27 07:00:00', '2025-11-28 06:40:00', '2025-11-23 07:43:22', '2025-11-23 07:43:25', 12, 'completed', 'daily', 1, '2025-11-28 07:00:00', '', '2025-11-22 07:54:26', '2025-11-23 07:43:25');

-- Dumping structure for table station_service_db.stations
CREATE TABLE IF NOT EXISTS `stations` (
  `station_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `station_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `station_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` bigint unsigned DEFAULT NULL COMMENT 'Reference to user_service',
  `location` json NOT NULL COMMENT '{"address", "city", "district", "latitude", "longitude"}',
  `contact_info` json DEFAULT NULL COMMENT '{"phone", "email", "manager_name"}',
  `operating_hours` json DEFAULT NULL COMMENT '{"monday": {"open": "08:00", "close": "22:00"}}',
  `amenities` json DEFAULT NULL COMMENT '["wifi", "restroom", "cafe", "parking"]',
  `total_chargers` int DEFAULT '0',
  `available_chargers` int DEFAULT '0',
  `status` enum('online','offline','maintenance','closed') COLLATE utf8mb4_unicode_ci DEFAULT 'online',
  `rating` decimal(3,2) DEFAULT '0.00',
  `total_reviews` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`station_id`),
  UNIQUE KEY `station_code` (`station_code`),
  KEY `idx_status` (`status`),
  KEY `idx_rating` (`rating`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table station_service_db.stations: ~45 rows (approximately)
INSERT INTO `stations` (`station_id`, `station_code`, `station_name`, `owner_id`, `location`, `contact_info`, `operating_hours`, `amenities`, `total_chargers`, `available_chargers`, `status`, `rating`, `total_reviews`, `created_at`, `updated_at`) VALUES
	(1, 'HCM-Q1-001', 'Trạm sạc VinFast Quận 1 - Nguyễn Huệ', NULL, '{"city": "Hồ Chí Minh", "address": "123 Nguyễn Huệ, Quận 1, TP.HCM", "district": "Quận 1", "latitude": 10.7769, "longitude": 106.7009}', NULL, NULL, NULL, 0, 0, 'online', 4.50, 0, '2025-10-31 12:02:59', '2025-11-14 19:43:23'),
	(2, 'HCM-Q1-002', 'Trạm sạc Đồng Khởi', NULL, '{"city": "Hồ Chí Minh", "address": "45 Đồng Khởi, Quận 1, TP.HCM", "district": "Quận 1", "latitude": 10.7794, "longitude": 106.6994}', NULL, NULL, NULL, 0, 0, 'online', 4.30, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:02'),
	(3, 'HCM-Q1-003', 'Trạm sạc Landmark 81', NULL, '{"city": "Hồ Chí Minh", "address": "Vinhomes Central Park, Quận Bình Thạnh, TP.HCM", "district": "Quận Bình Thạnh", "latitude": 10.8019, "longitude": 106.7208}', NULL, NULL, NULL, 0, 0, 'online', 4.70, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:03'),
	(4, 'HCM-Q3-001', 'Trạm sạc Lê Văn Sỹ', NULL, '{"city": "Hồ Chí Minh", "address": "234 Lê Văn Sỹ, Quận 3, TP.HCM", "district": "Quận 3", "latitude": 10.7908, "longitude": 106.6876}', NULL, NULL, NULL, 0, 0, 'online', 4.20, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:08'),
	(5, 'HCM-Q3-002', 'Trạm sạc Nguyễn Đình Chiểu', NULL, '{"city": "Hồ Chí Minh", "address": "456 Nguyễn Đình Chiểu, Quận 3, TP.HCM", "district": "Quận 3", "latitude": 10.7956, "longitude": 106.6917}', NULL, NULL, NULL, 0, 0, 'online', 4.40, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:09'),
	(6, 'HCM-Q7-001', 'Trạm sạc Phú Mỹ Hưng', NULL, '{"city": "Hồ Chí Minh", "address": "Nguyễn Đức Cảnh, Phú Mỹ Hưng, Quận 7, TP.HCM", "district": "Quận 7", "latitude": 10.7314, "longitude": 106.7179}', NULL, NULL, NULL, 0, 0, 'online', 4.60, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:10'),
	(7, 'HCM-Q7-002', 'Trạm sạc Crescent Mall', NULL, '{"city": "Hồ Chí Minh", "address": "101 Tôn Dật Tiên, Phú Mỹ Hưng, Quận 7, TP.HCM", "district": "Quận 7", "latitude": 10.7297, "longitude": 106.7192}', NULL, NULL, NULL, 0, 0, 'online', 4.50, 0, '2025-10-31 12:02:59', '2025-11-01 03:13:13'),
	(8, 'HCM-Q10-001', 'Trạm sạc Lý Thái Tổ', NULL, '{"city": "Hồ Chí Minh", "address": "789 Lý Thái Tổ, Quận 10, TP.HCM", "district": "Quận 10", "latitude": 10.7716, "longitude": 106.6682}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:13'),
	(9, 'HCM-Q10-002', 'Trạm sạc Nguyễn Tri Phương', NULL, '{"city": "Hồ Chí Minh", "address": "321 Nguyễn Tri Phương, Quận 10, TP.HCM", "district": "Quận 10", "latitude": 10.7694, "longitude": 106.6647}', NULL, NULL, NULL, 0, 0, 'online', 4.00, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:15'),
	(10, 'HCM-BT-001', 'Trạm sạc Xô Viết Nghệ Tĩnh', NULL, '{"city": "Hồ Chí Minh", "address": "567 Xô Viết Nghệ Tĩnh, Quận Bình Thạnh, TP.HCM", "district": "Quận Bình Thạnh", "latitude": 10.8014, "longitude": 106.7143}', NULL, NULL, NULL, 0, 0, 'online', 4.30, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:18'),
	(11, 'HCM-BT-002', 'Trạm sạc Điện Biên Phủ', NULL, '{"city": "Hồ Chí Minh", "address": "890 Điện Biên Phủ, Quận Bình Thạnh, TP.HCM", "district": "Quận Bình Thạnh", "latitude": 10.8033, "longitude": 106.7189}', NULL, NULL, NULL, 0, 0, 'online', 4.40, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:19'),
	(12, 'HCM-TB-001', 'Trạm sạc Tân Sơn Nhì', NULL, '{"city": "Hồ Chí Minh", "address": "234 Tân Sơn Nhì, Quận Tân Bình, TP.HCM", "district": "Quận Tân Bình", "latitude": 10.8026, "longitude": 106.6447}', NULL, NULL, NULL, 0, 0, 'online', 4.20, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:22'),
	(13, 'HCM-TB-002', 'Trạm sạc Sân Bay Tân Sơn Nhất', NULL, '{"city": "Hồ Chí Minh", "address": "Trường Sơn, Quận Tân Bình, TP.HCM", "district": "Quận Tân Bình", "latitude": 10.8188, "longitude": 106.652}', NULL, NULL, NULL, 0, 0, 'online', 4.60, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:25'),
	(14, 'HCM-GV-001', 'Trạm sạc Quang Trung', NULL, '{"city": "Hồ Chí Minh", "address": "456 Quang Trung, Quận Gò Vấp, TP.HCM", "district": "Quận Gò Vấp", "latitude": 10.8418, "longitude": 106.6711}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:27'),
	(15, 'HCM-GV-002', 'Trạm sạc Nguyễn Oanh', NULL, '{"city": "Hồ Chí Minh", "address": "789 Nguyễn Oanh, Quận Gò Vấp, TP.HCM", "district": "Quận Gò Vấp", "latitude": 10.8477, "longitude": 106.6756}', NULL, NULL, NULL, 0, 0, 'online', 4.00, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:29'),
	(16, 'HCM-PN-001', 'Trạm sạc Phan Xích Long', NULL, '{"city": "Hồ Chí Minh", "address": "123 Phan Xích Long, Quận Phú Nhuận, TP.HCM", "district": "Quận Phú Nhuận", "latitude": 10.8007, "longitude": 106.686}', NULL, NULL, NULL, 0, 0, 'online', 4.50, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:31'),
	(17, 'HCM-PN-002', 'Trạm sạc Hoàng Văn Thụ', NULL, '{"city": "Hồ Chí Minh", "address": "456 Hoàng Văn Thụ, Quận Phú Nhuận, TP.HCM", "district": "Quận Phú Nhuận", "latitude": 10.7984, "longitude": 106.6833}', NULL, NULL, NULL, 0, 0, 'online', 4.30, 0, '2025-10-31 12:02:59', '2025-11-01 06:28:07'),
	(18, 'HCM-TD-001', 'Trạm sạc Khu Công Nghệ Cao', NULL, '{"city": "Hồ Chí Minh", "address": "Khu Công Nghệ Cao, Quận 9, TP.HCM", "district": "Quận 9", "latitude": 10.8416, "longitude": 106.8101}', NULL, NULL, NULL, 0, 0, 'online', 4.40, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:37'),
	(19, 'HCM-TD-002', 'Trạm sạc Đại Học Quốc Gia', NULL, '{"city": "Hồ Chí Minh", "address": "Đại Học Quốc Gia, Thủ Đức, TP.HCM", "district": "Thủ Đức", "latitude": 10.87, "longitude": 106.8031}', NULL, NULL, NULL, 0, 0, 'online', 4.60, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:39'),
	(20, 'HCM-TD-003', 'Trạm sạc Quận 2 - Thủ Đức', NULL, '{"city": "Hồ Chí Minh", "address": "Nguyễn Thị Định, Quận 2, TP.HCM", "district": "Quận 2", "latitude": 10.7878, "longitude": 106.7508}', NULL, NULL, NULL, 0, 0, 'online', 4.50, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:41'),
	(21, 'HCM-Q12-001', 'Trạm sạc Tân Hưng Thuận', NULL, '{"city": "Hồ Chí Minh", "address": "123 Tân Hưng Thuận, Quận 12, TP.HCM", "district": "Quận 12", "latitude": 10.8633, "longitude": 106.63}', NULL, NULL, NULL, 0, 0, 'online', 4.20, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:44'),
	(22, 'HCM-Q12-002', 'Trạm sạc An Phú Đông', NULL, '{"city": "Hồ Chí Minh", "address": "456 An Phú Đông, Quận 12, TP.HCM", "district": "Quận 12", "latitude": 10.8717, "longitude": 106.6389}', NULL, NULL, NULL, 0, 0, 'online', 4.00, 0, '2025-10-31 12:02:59', '2025-11-11 08:59:11'),
	(23, 'HCM-TP-001', 'Trạm sạc Tân Sơn Hòa', NULL, '{"city": "Hồ Chí Minh", "address": "789 Tân Sơn Hòa, Quận Tân Phú, TP.HCM", "district": "Quận Tân Phú", "latitude": 10.7726, "longitude": 106.6258}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:47'),
	(24, 'HCM-TP-002', 'Trạm sạc Lê Trọng Tấn', NULL, '{"city": "Hồ Chí Minh", "address": "321 Lê Trọng Tấn, Quận Tân Phú, TP.HCM", "district": "Quận Tân Phú", "latitude": 10.7789, "longitude": 106.6311}', NULL, NULL, NULL, 0, 0, 'online', 4.20, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:48'),
	(25, 'HCM-Q4-001', 'Trạm sạc Khánh Hội', NULL, '{"city": "Hồ Chí Minh", "address": "234 Khánh Hội, Quận 4, TP.HCM", "district": "Quận 4", "latitude": 10.7499, "longitude": 106.6974}', NULL, NULL, NULL, 0, 0, 'online', 4.00, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:50'),
	(26, 'HCM-Q4-002', 'Trạm sạc Nguyễn Tất Thành', NULL, '{"city": "Hồ Chí Minh", "address": "567 Nguyễn Tất Thành, Quận 4, TP.HCM", "district": "Quận 4", "latitude": 10.7544, "longitude": 106.7008}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:52'),
	(27, 'HCM-Q5-001', 'Trạm sạc Chợ Lớn', NULL, '{"city": "Hồ Chí Minh", "address": "890 Chợ Lớn, Quận 5, TP.HCM", "district": "Quận 5", "latitude": 10.7541, "longitude": 106.6746}', NULL, NULL, NULL, 0, 0, 'online', 4.20, 0, '2025-10-31 12:02:59', '2025-11-01 03:13:13'),
	(28, 'HCM-Q5-002', 'Trạm sạc Nguyễn Trãi', NULL, '{"city": "Hồ Chí Minh", "address": "123 Nguyễn Trãi, Quận 5, TP.HCM", "district": "Quận 5", "latitude": 10.7567, "longitude": 106.6772}', NULL, NULL, NULL, 0, 0, 'online', 4.30, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:56'),
	(29, 'HCM-Q6-001', 'Trạm sạc Hậu Giang', NULL, '{"city": "Hồ Chí Minh", "address": "456 Hậu Giang, Quận 6, TP.HCM", "district": "Quận 6", "latitude": 10.7478, "longitude": 106.6394}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:04:58'),
	(31, 'HCM-Q8-001', 'Trạm sạc Ba Tơ', NULL, '{"city": "Hồ Chí Minh", "address": "321 Ba Tơ, Quận 8, TP.HCM", "district": "Quận 8", "latitude": 10.7269, "longitude": 106.6289}', NULL, NULL, NULL, 0, 0, 'online', 4.00, 0, '2025-10-31 12:02:59', '2025-11-01 05:56:49'),
	(32, 'HCM-Q8-002', 'Trạm sạc Dương Bá Trạc', NULL, '{"city": "Hồ Chí Minh", "address": "654 Dương Bá Trạc, Quận 8, TP.HCM", "district": "Quận 8", "latitude": 10.7306, "longitude": 106.6322}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-11-01 03:13:12'),
	(33, 'HCM-Q11-001', 'Trạm sạc Lạc Long Quân', NULL, '{"city": "Hồ Chí Minh", "address": "234 Lạc Long Quân, Quận 11, TP.HCM", "district": "Quận 11", "latitude": 10.7647, "longitude": 106.6503}', NULL, NULL, NULL, 0, 0, 'online', 4.20, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:07'),
	(34, 'HCM-Q11-002', 'Trạm sạc Nguyễn Thị Nhỏ', NULL, '{"city": "Hồ Chí Minh", "address": "567 Nguyễn Thị Nhỏ, Quận 11, TP.HCM", "district": "Quận 11", "latitude": 10.7689, "longitude": 106.6536}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:10'),
	(35, 'HCM-BT2-001', 'Trạm sạc An Dương Vương', NULL, '{"city": "Hồ Chí Minh", "address": "890 An Dương Vương, Quận Bình Tân, TP.HCM", "district": "Quận Bình Tân", "latitude": 10.7369, "longitude": 106.6056}', NULL, NULL, NULL, 0, 0, 'online', 4.20, 0, '2025-10-31 12:02:59', '2025-11-14 19:41:36'),
	(36, 'HCM-BT2-002', 'Trạm sạc Khu Công Nghiệp Tân Tạo', NULL, '{"city": "Hồ Chí Minh", "address": "Khu Công Nghiệp Tân Tạo, Quận Bình Tân, TP.HCM", "district": "Quận Bình Tân", "latitude": 10.7411, "longitude": 106.6094}', NULL, NULL, NULL, 0, 0, 'online', 4.30, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:18'),
	(37, 'HCM-BC-001', 'Trạm sạc Quốc Lộ 1A', NULL, '{"city": "Hồ Chí Minh", "address": "Quốc Lộ 1A, Huyện Bình Chánh, TP.HCM", "district": "Bình Chánh", "latitude": 10.6914, "longitude": 106.5872}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:21'),
	(38, 'HCM-BC-002', 'Trạm sạc Đa Phước', NULL, '{"city": "Hồ Chí Minh", "address": "Đa Phước, Huyện Bình Chánh, TP.HCM", "district": "Bình Chánh", "latitude": 10.6956, "longitude": 106.5911}', NULL, NULL, NULL, 0, 0, 'online', 4.00, 0, '2025-10-31 12:02:59', '2025-11-01 03:13:11'),
	(39, 'HCM-CC-001', 'Trạm sạc Trung Tâm Củ Chi', NULL, '{"city": "Hồ Chí Minh", "address": "Trung Tâm Củ Chi, Huyện Củ Chi, TP.HCM", "district": "Củ Chi", "latitude": 10.9733, "longitude": 106.4931}', NULL, NULL, NULL, 0, 0, 'online', 4.00, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:29'),
	(40, 'HCM-CC-002', 'Trạm sạc Tân Phú Trung', NULL, '{"city": "Hồ Chí Minh", "address": "Tân Phú Trung, Huyện Củ Chi, TP.HCM", "district": "Củ Chi", "latitude": 10.9789, "longitude": 106.4978}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:32'),
	(41, 'HCM-HM-001', 'Trạm sạc Hóc Môn', NULL, '{"city": "Hồ Chí Minh", "address": "Trung Tâm Hóc Môn, Huyện Hóc Môn, TP.HCM", "district": "Hóc Môn", "latitude": 10.8822, "longitude": 106.5889}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:34'),
	(42, 'HCM-HM-002', 'Trạm sạc Quốc Lộ 22', NULL, '{"city": "Hồ Chí Minh", "address": "Quốc Lộ 22, Huyện Hóc Môn, TP.HCM", "district": "Hóc Môn", "latitude": 10.8867, "longitude": 106.5933}', NULL, NULL, NULL, 0, 0, 'online', 4.00, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:36'),
	(43, 'HCM-NB-001', 'Trạm sạc Nhà Bè', NULL, '{"city": "Hồ Chí Minh", "address": "Trung Tâm Nhà Bè, Huyện Nhà Bè, TP.HCM", "district": "Nhà Bè", "latitude": 10.6872, "longitude": 106.7319}', NULL, NULL, NULL, 0, 0, 'online', 4.20, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:37'),
	(44, 'HCM-NB-002', 'Trạm sạc Phú Xuân', NULL, '{"city": "Hồ Chí Minh", "address": "Phú Xuân, Huyện Nhà Bè, TP.HCM", "district": "Nhà Bè", "latitude": 10.6917, "longitude": 106.7364}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:38'),
	(45, 'HCM-CG-001', 'Trạm sạc Cần Thạnh', NULL, '{"city": "Hồ Chí Minh", "address": "Cần Thạnh, Huyện Cần Giờ, TP.HCM", "district": "Cần Giờ", "latitude": 10.4114, "longitude": 106.9564}', NULL, NULL, NULL, 0, 0, 'online', 4.00, 0, '2025-10-31 12:02:59', '2025-11-01 03:13:14'),
	(46, 'HCM-CG-002', 'Trạm sạc Đảo Thạnh An', NULL, '{"city": "Hồ Chí Minh", "address": "Đảo Thạnh An, Huyện Cần Giờ, TP.HCM", "district": "Cần Giờ", "latitude": 10.4167, "longitude": 106.9611}', NULL, NULL, NULL, 0, 0, 'online', 4.10, 0, '2025-10-31 12:02:59', '2025-10-31 12:05:48');

-- Dumping structure for table station_service_db.station_reviews
CREATE TABLE IF NOT EXISTS `station_reviews` (
  `review_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `station_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL COMMENT 'Reference to user_service',
  `rating` int NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `photos` json DEFAULT NULL COMMENT '[photo_urls]',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `idx_station_id` (`station_id`),
  KEY `idx_rating` (`rating`),
  CONSTRAINT `station_reviews_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `stations` (`station_id`) ON DELETE CASCADE,
  CONSTRAINT `station_reviews_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table station_service_db.station_reviews: ~0 rows (approximately)


-- Dumping database structure for user_service_db
CREATE DATABASE IF NOT EXISTS `user_service_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `user_service_db`;

-- Dumping structure for table user_service_db.admin_profiles
CREATE TABLE IF NOT EXISTS `admin_profiles` (
  `profile_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `role` enum('admin,staff,user') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `permissions` json NOT NULL COMMENT '{"stations": ["read", "write"], "users": ["read"], "reports": ["read", "write"]}',
  `assigned_regions` json DEFAULT NULL COMMENT '[region_ids]',
  PRIMARY KEY (`profile_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `admin_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.admin_profiles: ~0 rows (approximately)

-- Dumping structure for table user_service_db.chargers
CREATE TABLE IF NOT EXISTS `chargers` (
  `charger_id` bigint NOT NULL AUTO_INCREMENT,
  `charger_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `charger_type` enum('AC_Type2','CCS','CHAdeMO','GB_T') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `power_rating` decimal(6,2) NOT NULL,
  `status` enum('available','in_use','maintenance','offline','reserved') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `station_id` bigint NOT NULL,
  PRIMARY KEY (`charger_id`),
  UNIQUE KEY `UKfr14x8kdrpnnhymx68g0mptvk` (`charger_code`),
  KEY `FKfkso7tl9icegthb1th8tg1324` (`station_id`),
  CONSTRAINT `FKfkso7tl9icegthb1th8tg1324` FOREIGN KEY (`station_id`) REFERENCES `stations` (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.chargers: ~0 rows (approximately)

-- Dumping structure for table user_service_db.driver_profiles
CREATE TABLE IF NOT EXISTS `driver_profiles` (
  `profile_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `vehicle_info` json DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `emergency_contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferred_language` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notification_preferences` json DEFAULT NULL,
  `preferred_payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`profile_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `driver_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.driver_profiles: ~6 rows (approximately)
INSERT INTO `driver_profiles` (`profile_id`, `user_id`, `vehicle_info`, `address`, `emergency_contact`, `preferred_language`, `notification_preferences`, `preferred_payment_method`) VALUES
	(1, 7, '[]', 'Tân Chánh Hiệp, Quận 12', '', NULL, NULL, NULL),
	(5, 15, '[{"id": 1, "name": "VF e34 GreenCar", "imageUrl": "https://res.cloudinary.com/dksgckopr/image/upload/v1762722518/vehicles/15/d0080d6a-510d-430e-977f-52cbddf8dc52.jpg", "isDefault": true, "plateNumber": "62E1 123456", "batteryCapacityKwh": 60.0, "preferredChargerType": "AC"}]', '480 Đ. Tô Ký, Tân Chánh Hiệp, Quận 12, Thành phố Hồ Chí Minh, Việt Nam', '', NULL, NULL, NULL),
	(6, 12, '[]', NULL, NULL, NULL, NULL, NULL),
	(8, 17, '[]', NULL, NULL, NULL, NULL, NULL),
	(9, 18, '[]', NULL, NULL, NULL, NULL, NULL),
	(10, 19, '[]', NULL, NULL, NULL, NULL, NULL);

-- Dumping structure for table user_service_db.incidents
CREATE TABLE IF NOT EXISTS `incidents` (
  `incident_id` bigint NOT NULL AUTO_INCREMENT,
  `charger_id` bigint DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `incident_type` enum('equipment','network','other','power') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reported_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resolved_at` datetime(6) DEFAULT NULL,
  `severity` enum('critical','high','low','medium') COLLATE utf8mb4_unicode_ci NOT NULL,
  `station_id` bigint NOT NULL,
  `status` enum('in_progress','pending','resolved') COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.incidents: ~0 rows (approximately)

-- Dumping structure for table user_service_db.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `notification_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `is_read` bit(1) DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `notification_type` enum('account_update','charging_complete','charging_failed','charging_started','payment_failed','payment_success','promotion','reservation_cancelled','reservation_confirmed','reservation_reminder','review_request','station_offline','system_maintenance','wallet_low_balance') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` bigint DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.notifications: ~0 rows (approximately)

-- Dumping structure for table user_service_db.packages
CREATE TABLE IF NOT EXISTS `packages` (
  `package_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `discount_percentage` int DEFAULT NULL,
  `duration_days` int NOT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `package_type` enum('GOLD','PLATINUM','SILVER') COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`package_id`),
  UNIQUE KEY `UK72jq9ghrk0t6oo0ix895lih0t` (`package_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.packages: ~3 rows (approximately)
INSERT INTO `packages` (`package_id`, `created_at`, `description`, `discount_percentage`, `duration_days`, `is_active`, `name`, `package_type`, `price`, `updated_at`) VALUES
	(1, '2025-11-15 06:08:12.229762', 'Gói dịch vụ cơ bản dành cho người dùng mới. Phù hợp với nhu cầu sạc điện xe thông thường.', 0, 30, b'1', 'Gói Bạc', 'SILVER', 299000.00, '2025-11-15 06:08:12.229762'),
	(2, '2025-11-15 06:08:12.283382', 'Gói dịch vụ nâng cao với nhiều ưu đãi. Phù hợp cho người dùng thường xuyên sử dụng dịch vụ sạc.', 10, 30, b'1', 'Gói Vàng', 'GOLD', 599000.00, '2025-11-15 06:08:12.283382'),
	(3, '2025-11-15 06:08:12.295253', 'Gói dịch vụ cao cấp nhất với đầy đủ tính năng và ưu đãi tối đa. Dành cho doanh nghiệp và người dùng VIP.', 20, 30, b'1', 'Gói Bạch Kim', 'PLATINUM', 999000.00, '2025-11-15 06:08:12.295253');

-- Dumping structure for table user_service_db.package_features
CREATE TABLE IF NOT EXISTS `package_features` (
  `package_id` bigint NOT NULL,
  `feature` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  KEY `FK4wl1mupapa2x89d2dbnrwyro8` (`package_id`),
  CONSTRAINT `FK4wl1mupapa2x89d2dbnrwyro8` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.package_features: ~19 rows (approximately)
INSERT INTO `package_features` (`package_id`, `feature`) VALUES
	(1, 'Sạc không giới hạn tại tất cả các trạm'),
	(1, 'Ưu tiên đặt chỗ tại trạm phổ biến'),
	(1, 'Hỗ trợ khách hàng 24/7'),
	(1, 'Thông báo trạng thái sạc real-time'),
	(2, 'Tất cả tính năng của Gói Bạc'),
	(2, 'Giảm giá 10% cho mỗi lần sạc'),
	(2, 'Ưu tiên cao hơn khi đặt chỗ'),
	(2, 'Đặt trước tối đa 3 chỗ cùng lúc'),
	(2, 'Truy cập vào các trạm VIP'),
	(2, 'Báo cáo sử dụng chi tiết'),
	(3, 'Tất cả tính năng của Gói Vàng'),
	(3, 'Giảm giá 20% cho mỗi lần sạc'),
	(3, 'Ưu tiên tuyệt đối khi đặt chỗ'),
	(3, 'Đặt trước không giới hạn số chỗ'),
	(3, 'Truy cập độc quyền các trạm Premium'),
	(3, 'Hỗ trợ ưu tiên 24/7'),
	(3, 'Quản lý nhiều phương tiện'),
	(3, 'Báo cáo và phân tích nâng cao'),
	(3, 'Dịch vụ bảo trì định kỳ');

-- Dumping structure for table user_service_db.refresh_tokens
CREATE TABLE IF NOT EXISTS `refresh_tokens` (
  `token_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `token_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `revoked` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`token_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_token_hash` (`token_hash`),
  CONSTRAINT `refresh_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.refresh_tokens: ~0 rows (approximately)

-- Dumping structure for table user_service_db.staff_profiles
CREATE TABLE IF NOT EXISTS `staff_profiles` (
  `profile_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `station_id` bigint unsigned DEFAULT NULL COMMENT 'Reference to station service',
  `role` enum('staff','supervisor','technician') COLLATE utf8mb4_unicode_ci NOT NULL,
  `hire_date` date DEFAULT NULL,
  `employee_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certifications` json DEFAULT NULL COMMENT '[{"name", "issued_date", "expiry_date"}]',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `employee_code` (`employee_code`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_station_id` (`station_id`),
  CONSTRAINT `staff_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.staff_profiles: ~0 rows (approximately)

-- Dumping structure for table user_service_db.stations
CREATE TABLE IF NOT EXISTS `stations` (
  `station_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `location` json DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT NULL,
  `station_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `station_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('closed','maintenance','offline','online') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`station_id`),
  UNIQUE KEY `UKdaicwr36v49pvw5yf6h2m75i5` (`station_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.stations: ~0 rows (approximately)

-- Dumping structure for table user_service_db.users
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_type` enum('driver','staff','admin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive','suspended','deleted') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `email_verified` tinyint(1) DEFAULT '0',
  `phone_verified` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `verification_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_expires_at` datetime(6) DEFAULT NULL,
  `subscription_package` enum('GOLD','PLATINUM','SILVER') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `idx_email` (`email`),
  KEY `idx_user_type` (`user_type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table user_service_db.users: ~6 rows (approximately)
INSERT INTO `users` (`user_id`, `email`, `phone`, `password_hash`, `full_name`, `user_type`, `status`, `email_verified`, `phone_verified`, `created_at`, `updated_at`, `last_login`, `verification_token`, `subscription_expires_at`, `subscription_package`, `avatar_url`) VALUES
	(7, 'admin@gmail.com', '0375110945', '$2a$10$2K.DP0zTMVXTpiHTiONqWeosyy9Ma5GmMJpdOJ4h3s51WwCuKtcBG', 'Huỳnh Phong Đạt', 'admin', 'active', 0, 0, '2025-10-24 16:44:40', '2025-11-16 11:33:59', NULL, NULL, NULL, NULL, 'https://res.cloudinary.com/dksgckopr/image/upload/v1762715346/avatars/15/56d3c755-5a4f-4357-99b4-ca86efa83657.gif'),
	(12, 'staff@gmail.com', '0123745489', '$2a$10$uBJL3F4bxiTGPHJQ5XWHeOLM8VddDkbc.h6VObvbEtuS80DSdg1l.', 'Lê Hoàn Nguyên Vũ', 'staff', 'active', 0, 0, '2025-10-29 22:23:19', '2025-11-09 14:14:01', NULL, NULL, NULL, NULL, NULL),
	(15, 'driver@gmail.com', '037175832', '$2a$10$NlBhqaNhO1360iHW1GkiT.LNqEAUWj4mZ/6djFFouocQ8pHxJzpD6', 'Đặng Tấn Trọng', 'driver', 'active', 0, 0, '2025-11-01 05:37:50', '2025-11-10 11:38:45', NULL, NULL, '2025-12-09 17:30:46.268995', 'PLATINUM', 'https://res.cloudinary.com/dksgckopr/image/upload/v1762799925/avatars/15/f548e823-9aa3-4a1f-9dc5-1325344ba944.jpg'),
	(17, 'driver1@gmail.com', '012345678', '$2a$10$sBRwF1a3O.QJWHaIl1yjYuklfk29rJpzTG/rJifRg9icB5Ylg3qsS', 'Lưu Nhật Bình', 'driver', 'active', 0, 0, '2025-11-12 04:39:46', '2025-11-14 13:37:02', NULL, NULL, '2025-12-14 20:37:02.216889', 'GOLD', 'https://res.cloudinary.com/dksgckopr/image/upload/v1762967494/avatars/17/232d9832-603f-4293-b01a-54e1ce0fae39.jpg'),
	(18, 'nga02974@gmail.com', '0327532678', '$2a$10$gPyKSTNoSpKijrLzoaosleLRdfVNoQF/ht0JHTMHiKb6RxoDTN0l2', 'Trần Ngô Phương Nga', 'driver', 'active', 0, 0, '2025-11-13 02:26:44', '2025-11-13 02:36:33', NULL, NULL, '2025-12-13 09:31:03.097446', 'PLATINUM', 'https://res.cloudinary.com/dksgckopr/image/upload/v1763026593/avatars/18/c5df9169-dfcc-49d3-9871-4a2886e91d28.jpg'),
	(19, 'driverdemo@gmail.com', '012224394', '$2a$10$Eze3.gHtI.RDGmSYrG2X8urSxOnoTlIJk2rVePwpiUcBqQsFA8bWC', 'Nguyễn Lê Quốc Trung', 'driver', 'active', 0, 0, '2025-11-15 13:57:50', '2025-11-15 13:57:50', NULL, NULL, NULL, NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
