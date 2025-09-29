-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for community_attendance
CREATE DATABASE IF NOT EXISTS `community_attendance` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `community_attendance`;

-- Dumping structure for table community_attendance.admins
CREATE TABLE IF NOT EXISTS `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `organization_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table community_attendance.admins: ~3 rows (approximately)
INSERT INTO `admins` (`id`, `name`, `email`, `password`, `organization_name`, `created_at`, `updated_at`) VALUES
	(1, 'Admin Default', 'admin@community.com', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Community Organization', '2025-09-26 17:02:51', '2025-09-26 17:02:51'),
	(2, 'admin bk', 'adminbk@gmail.com', '$2b$10$N0oC14ekYgMXJts9r0fcgOAQMzp.XKmWa8sQWoiDQnrPrF.z1cFCa', 'Yayasan Nurul Hakim', '2025-09-26 17:06:18', '2025-09-26 17:06:18'),
	(3, 'Muhammad Zakariya Ansori', 'himeansori@gmail.com', '$2b$10$8Fr7prTFtSKd.XvmwoH26O/dWqoHvo6TapS4I4rSRq81THwLXLiFO', 'Yayasan Nurul Hakim', '2025-09-26 23:14:05', '2025-09-26 23:14:05'),
	(4, 'Muhamamad AKbar', 'akbar@gmail.com', '$2b$10$vFv959T6Jxsonw5Rwg7BcOATVvyPWS5mplf3S5IeK/4KJQ5pp1O46', 'Yayasan Nurul Hakim', '2025-09-27 02:34:51', '2025-09-27 02:34:51'),
	(5, 'Fadli Insani', 'fadli@gmail.com', '$2b$10$FKrOi6OpLiGaCRo3JrHtfOLZXRulmImyJrckk/I1x11QI6q0EAVzO', 'Yayasan Nurul Hakim', '2025-09-27 15:53:11', '2025-09-27 15:53:11');


-- Dumping structure for table community_attendance.events
CREATE TABLE IF NOT EXISTS `events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin_id` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `event_date` date NOT NULL,
  `event_time` time NOT NULL,
  `location` varchar(200) DEFAULT NULL,
  `max_participants` int DEFAULT NULL,
  `qr_code` text,
  `qr_secret` varchar(100) DEFAULT NULL,
  `status` enum('scheduled','ongoing','completed','cancelled') DEFAULT 'scheduled',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table community_attendance.events: ~7 rows (approximately)
INSERT INTO `events` (`id`, `admin_id`, `title`, `description`, `event_date`, `event_time`, `location`, `max_participants`, `qr_code`, `qr_secret`, `status`, `created_at`, `updated_at`) VALUES
	(1, 2, 'Community Meeting', 'Malabar gabungan', '2025-10-20', '19:30:00', 'Masjid Nurul Hakim', 100, NULL, NULL, 'scheduled', '2025-09-26 17:11:31', '2025-09-26 17:11:31'),
	(2, 3, 'Pengajian Malabar gabungan', 'Assalamualaikum wr.wb\n\nPengajian Muda-Mudi Desa\nDesa Karees selatan, Bandung Timur 1 \n\n🔅 Usia Pra Nikah\n🗓 : Sabtu, 13 September 2025\n🕖 : isya (sholat berjamaah di masjid nh) - Selesai\n👥 : Seluruh MM Desa Karsel Usia Pra Nikah (18 ++)\n🕌 : Masjid Nurul hakim (Offline) \n📚 : Quran Bacaan & Nasehat\n\n🔅 2. Usia Remaja\n🗓 : Sabtu, 13 September 2025\n🕖 : isya (sholat berjamaah di masjid nh) - Selesai\n👥 : Seluruh MM Desa Karsel Usia Remaja (SMA/K/Sederajat)\n🕌 : Masjid Nurul Hakim (Offline)\n📚 : Quran Bacaan & Nasehat\n\n🔅 NB:\n1. Mohon Amal soleh diperhatikan  waku kehadiran supaya tepat waktu\n2. Bagi yang izin sakit atau ada uzur silahkan izin ke keimaman desa & koordinator muda/i desa/kelompok  \n\n\nContact person:\nIvan (KMM Desa)\n+62 812-1049-4352\nHadi (WKMM Desa) \n+62 857-8583-9159\n\nAlhamdulillah Jaza Kumullohu Khoiro', '2025-09-27', '06:21:00', 'Masjid Nurul Hakim ', 200, 'data:image/png;base64,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8QmVqWJSmVSmijcqJpUTlaniROWNikllqjhReaNiUpkq3lCZKj5RMalMFZ94WGtd42GtdY2HtdY1fviyim9SOVGZKiaVqWJSmSomlU+oTBWTylTxRsUbFZ+omFSmipOKNyo+UfGGyknFb3pYa13jYa11jYe11jV++GUqb1T8TRW/qeKkYlI5UfmEylRxonJScVJxojJVfELlExUnKr/pYa11jYe11jUe1lrX+OE/RmWqmFQ+oTJVTConKicVJypTxRsqk8obFZPKVDGpTBVTxYnKScWJylQxqdzkYa11jYe11jUe1lrX+OE/TmWqOFE5qZhUTlSmikllUpkqpooTlanipOJE5aTipOJEZaqYKr5JZaqYVE4qJpVvelhrXeNhrXWNh7XWNX74ZRW/qeKbKn6Tyhsqb1R8QmWqmFSmijdUTlSmihOVk4oTlaniX3pYa13jYa11jYe11jV++DKVv0llqphUTireUHmj4kTlpGJSOVGZKqaKSWWq+ITKJyomlaliqjhROal4Q+U3Pay1rvGw1rrGw1rrGvYHa60rPKy1rvGw1rrGw1rrGg9rrWs8rLWu8bDWusbDWusaD2utazysta7xsNa6xsNa6xoPa61rPKy1rvGw1rrGw1rrGv8HuqvGxHqtmuQAAAAASUVORK5CYII=', 'b838646347a49e462af6ce9cf495d58fed68e29b90ee655897ee157b1fbb4097', 'completed', '2025-09-26 23:16:48', '2025-09-27 17:47:53'),
	(3, 3, 'Pengajian Kelompok', 'pengajian rutin kelompok', '2025-09-26', '07:46:00', 'Kelompok Kawaluyaan', 200, NULL, NULL, 'completed', '2025-09-27 00:46:04', '2025-09-27 15:51:15'),
	(4, 3, 'Pengajian Muda mudi daerah', 'Pengajian muda-mudi daerah', '2025-09-26', '08:56:00', 'Masjid Nurul Hakim Lt 1', 200, NULL, NULL, 'completed', '2025-09-27 01:55:37', '2025-09-27 15:51:02'),
	(5, 3, 'Pengajian ibu-ibu daerah', 'pengajian ibu-ibu daerah bulan september\nnote:\n- membawa uang seharga beras\n- membawa uang sodakoh', '2025-09-28', '08:00:00', 'Masjid Nurul Hakim Lt 1', 200, NULL, NULL, 'scheduled', '2025-09-27 14:44:35', '2025-09-27 14:44:35'),
	(7, 5, 'Talkshow keputrian daerah', 'tema : kesehatan reproduksi wanita', '2025-09-28', '08:00:00', 'Masjid Nurul Hakim Lt 1', 200, NULL, NULL, 'scheduled', '2025-09-27 16:01:58', '2025-09-27 16:01:58'),
	(8, 3, 'test event', 'test', '2025-09-28', '01:18:00', 'test', 200, 'data:image/png;base64,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', '8736d729eb8e7b8bc6f53a75904ea695eb4ee034c9893a455eedb36aae17783c', 'scheduled', '2025-09-27 18:19:55', '2025-09-28 13:09:49'),
	(9, 3, 'test2', 'rest2', '2025-09-28', '20:13:00', 'test2', 200, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOQAAADkCAYAAACIV4iNAAAAAklEQVR4AewaftIAAAxaSURBVO3BQY4kRxLAQDLR//8yd45+CiBR1aOQ1s3sD9ZaV3hYa13jYa11jYe11jUe1lrXeFhrXeNhrXWNh7XWNR7WWtd4WGtd42GtdY2HtdY1HtZa13hYa13jYa11jYe11jV++JDK31RxojJVTCo3qZhUpop/E5VPVLyhMlVMKn9TxSce1lrXeFhrXeNhrXWNH76s4ptUPqHyTRWTylQxqZyoTBWTyicqJpWp4kTlpGKqmFQ+ofJNFd+k8k0Pa61rPKy1rvGw1rrGD79M5Y2KN1SmijdUflPFpDJVTCpTxaRyUnFSMalMFScVk8pJxaQyVZxUTCrfpPJGxW96WGtd42GtdY2HtdY1fviPUZkqJpWpYlKZKj6h8gmVqWJSOVE5qTipmFSmihOVE5Wp4o2K/5KHtdY1HtZa13hYa13jh/+YikllqjipmFSmijcqvknlROWbVKaKNyreUJkqpor/soe11jUe1lrXeFhrXeOHX1bxN6l8QmWqmFSmiknljYo3Kt5QeUNlqphUpopJ5aRiUpkqJpWp4psqbvKw1rrGw1rrGg9rrWv88GUq/6SKSeVEZaqYVKaKSWWqmFSmikllqphUTlSmipOKSWWqmFSmikllqphUfpPKVHGicrOHtdY1HtZa13hYa13jhw9V/D+rOKk4qfhExRsqn1B5o2JSmSomlanipOKk4t/kYa11jYe11jUe1lrX+OFDKlPFpPJNFVPFpPIJlaliUpkqJpU3Kt5Q+UTFicpJxYnKVDFVTCpTxTepfFPFb3pYa13jYa11jYe11jV++FDFJyomlaliUjmpmFROKiaVk4pJZao4UZlUvqniROWbVD5R8QmVqWKqmFSmikllqvibHtZa13hYa13jYa11DfuDL1KZKk5UpopJZaqYVN6oeENlqjhReaNiUjmpmFQ+UfGGylRxovJNFScqJxWTylRxonJS8YmHtdY1HtZa13hYa13D/uADKlPFGypTxTepvFHxhspJxYnKb6o4UZkqJpWpYlKZKk5UpopJZaqYVN6oOFGZKt5QmSo+8bDWusbDWusaD2uta/zwoYpJZaqYVN5QeaNiqjhR+aaKSWWqmCpOVL5JZaqYVN6omFSmihOVqWJSeaPiRGWqmFROKqaKb3pYa13jYa11jYe11jXsD36RylQxqZxUTCqfqDhRmSomlaliUpkqJpWTikllqphUpooTlU9U3Ezlmyr+poe11jUe1lrXeFhrXeOHD6l8U8WkMlVMKlPFGypTxaTyRsWkMlVMKpPKicpUMamcVHxCZaqYVE4qJpU3Kt6o+E0qU8UnHtZa13hYa13jYa11jR8+VDGpvFExqUwV/6SKSWVSOamYVE4qJpWp4o2KSWWq+JtUTipOVE4qJpWpYlL5RMU3Pay1rvGw1rrGw1rrGvYHv0hlqnhDZar4JpWpYlKZKn6TylQxqZxUvKHyRsWkMlV8QmWqOFGZKk5UpoqbPKy1rvGw1rrGw1rrGj/8sopJ5Y2KE5U3Kk5U/iaVE5Wp4g2VT1RMKlPFpPKbVKaKSeUTKlPFicpU8YmHtdY1HtZa13hYa13jhw+pTBUnFZPKVDGpnFScqHyTylQxqUwVJxWTylQxqZxUnFRMKp9QmSreUDlRmSomlaniROUNlZOKb3pYa13jYa11jYe11jV+uIzKVPGGylTxiYpJ5TdVvFExqbxR8U+qeENlqphUTiomlaniRGVSmSo+8bDWusbDWusaD2uta9gffJHKVDGpfFPFpPKJiknlExUnKm9UTCpTxaRyUvGGylTxCZWpYlJ5o+JEZaqYVD5R8YmHtdY1HtZa13hYa13jh1+mclLxhspvUjmpmFROVE4qvknlDZWpYlI5UZkqvqniDZVPVJyoTBXf9LDWusbDWusaD2uta/zwyyomlUnlEypTxT+p4kTlROUmFW+ovFExqZxUTCqfUHmjYlKZKj7xsNa6xsNa6xoPa61r/PBlFZPKVDGpTBVvqEwqU8WkMlWcqEwVJyonFZ+oeEPlEypTxaRyUvGJiknlpOINlZOKSWWq+KaHtdY1HtZa13hYa13jh8upTBUnFb9JZaqYVN5Q+YTKVHFScaIyVUwqU8WJyhsVk8onVKaKk4pJZaqYVKaKTzysta7xsNa6xsNa6xo/fEhlqvimik+ofFPFpDJVnKhMFZPKGxVvqJxUTCpTxYnKVDGpvFFxonJS8YbKVDGpTBXf9LDWusbDWusaD2uta9gffEDlJhWfUJkqTlSmikllqnhD5TdVTCpTxaQyVZyoTBWTyhsVk8o3VbyhMlV84mGtdY2HtdY1HtZa1/jhQxUnKicVb6hMFZPKVHGi8omKk4pvqviEyqTyCZVPVJyonFS8oTJV3ORhrXWNh7XWNR7WWtewP/gilZOKSeWNik+ofKLiRGWqmFSmiknlpGJSmSo+ofJGxSdUpoo3VN6oOFH5RMUnHtZa13hYa13jYa11jR++rOKbKt5QmSpOKiaVE5Wp4kRlqjipmFQmlaliUjmp+DdT+SaVqeJEZar4poe11jUe1lrXeFhrXcP+4AMqn6iYVE4qTlROKiaVk4pJZao4UTmpmFROKn6TylQxqUwVk8obFZPKN1W8oTJVTConFZ94WGtd42GtdY2HtdY17A++SGWqmFTeqJhU3qiYVKaKSeWk4kRlqnhD5Y2KSeWk4kTlpOJEZaqYVD5RcaJyUjGpvFHxmx7WWtd4WGtd42GtdQ37gw+ovFExqbxRcaLyT6qYVD5RMalMFW+oTBUnKlPFpDJVnKhMFZPKVDGp/E0Vk8pJxSce1lrXeFhrXeNhrXUN+4MvUjmpmFSmihOVk4pJZaqYVKaKSeWbKiaVNypOVE4q3lA5qZhUPlExqUwVb6hMFTd7WGtd42GtdY2HtdY1fviyiknlDZVvqphUpopJZaqYVE4qJpWTikllqvhExaQyVbxRMamcVJyonFRMKlPFpPKGylRxojJVfNPDWusaD2utazysta7xw4dUTio+UXGiMqlMFd9UMalMKicqb6hMFZPKVDGpTBWTylRxovJNFScqU8Wk8obKVPEJlaniEw9rrWs8rLWu8bDWuob9wQdUpopJZao4Ufk3qzhROamYVE4qJpU3Kt5QmSpOVKaKSWWqmFROKiaVT1RMKlPFpDJVfOJhrXWNh7XWNR7WWtewP/iAyknFicpJxYnKGxWTylQxqXxTxYnKVHGi8k0Vk8pJxd+k8omKE5U3Kr7pYa11jYe11jUe1lrX+OFDFZPKGxWTyqRyUnGiMqm8UTGpTBWTylQxqZxUnKhMFZPKGxWTylQxqbyhMlVMKp+oOFE5UTmpOFGZKj7xsNa6xsNa6xoPa61r2B98kcobFW+oTBUnKicVJypTxW9SOamYVKaKSWWqmFSmiknljYq/SeWk4ptUTio+8bDWusbDWusaD2uta9gffEDljYo3VKaKSeUTFW+o/JdU/CaVNyomlX+Tik88rLWu8bDWusbDWusa9gf/YipTxYnKScUbKlPFN6lMFW+ovFExqZxUTCpTxRsqU8WJylTxhspJxaQyVXzTw1rrGg9rrWs8rLWu8cOHVP6miqliUpkqpooTlaliUjlROamYVKaKN1SmijcqJpWp4o2KSeWNikllqnhDZao4qZhUpopJZar4xMNa6xoPa61rPKy1rvHDl1V8k8qJyonKVPFNFZPKGxWTyhsVn1CZKiaVqWJSmSpOKt6o+ETFJyomld/0sNa6xsNa6xoPa61r/PDLVN6o+E0q36QyVUwq36TyiYpPqEwVJxUnKm9UnKh8QuWkYlL5poe11jUe1lrXeFhrXeOH/5iKSWWq+ETFicpUMamcVEwqJxV/U8WkMlWcqJxUvFFxojJVTCqfqPimh7XWNR7WWtd4WGtd44f/GJWbVUwqk8pUcaJyUjGpTBUnFScVk8pJxRsqn6iYVKaKSWWqmFROKj7xsNa6xsNa6xoPa61r/PDLKn5TxaTym1ROKiaVv6niEypTxaRyUnGi8kbFJ1SmikllqphUpopJ5Zse1lrXeFhrXeNhrXWNH75M5W9SmSomlROVb1KZKk5UpooTlROVqWKqmFSmipOKSeUTFZPKicobFZPKVDGpnKj8poe11jUe1lrXeFhrXcP+YK11hYe11jUe1lrXeFhrXeNhrXWNh7XWNR7WWtd4WGtd42GtdY2HtdY1HtZa13hYa13jYa11jYe11jUe1lrXeFhrXeN/WFvW9sSAcccAAAAASUVORK5CYII=', '1ef234868f20a48f8b5be4c462faf43714f1c222be3c6b4331e31acf3fc39f83', 'scheduled', '2025-09-28 13:12:26', '2025-09-28 14:27:36'),
	(10, 3, 'test3', 'test3', '2025-09-28', '21:39:00', 'test3', 200, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOQAAADkCAYAAACIV4iNAAAAAklEQVR4AewaftIAAAxlSURBVO3BQY4cybIgQdVA3f/KOtx9WzkQyCzSX4+J2B+sta7wsNa6xsNa6xoPa61rPKy1rvGw1rrGw1rrGg9rrWs8rLWu8bDWusbDWusaD2utazysta7xsNa6xsNa6xoPa61r/PAhlb+p4jepTBWTylTxX6JyUnGiclLxTSpTxaTyN1V84mGtdY2HtdY1HtZa1/jhyyq+SeUTKlPFpDJVnFRMKm9UnKh8U8WkMlVMFScqb1RMKlPFico3VXyTyjc9rLWu8bDWusbDWusaP/wylTcq3lCZKr5J5TepfFPFpDJVvKFyUjGpnFS8UTGpfJPKGxW/6WGtdY2HtdY1HtZa1/jh/zMqU8WkclJxojJVTCpTxSdUTipOVKaKqeJE5UTljYo3Kv5LHtZa13hYa13jYa11jR/+Y1TeUJkqTlROKk4q3lB5Q+WkYqqYVL6pYlI5UZkqpor/soe11jUe1lrXeFhrXeOHX1bxL1WcqEwqU8VUMalMKlPFpDJVTConFW+oTCpTxVTxhsqJylQxqUwVk8pU8U0VN3lYa13jYa11jYe11jV++DKVf6liUpkqTiomlanipGJSmSomlaliUjlRmSpOKiaVqWJSmSpOKiaV36QyVZyo3OxhrXWNh7XWNR7WWtewP/gfpjJVfEJlqviXVKaKN1SmihOVk4pPqEwV6/88rLWu8bDWusbDWusa9gcfUJkqJpVvqnhD5Y2KSeUTFW+o/EsVJyonFW+oTBWTyhsVk8o3Vfymh7XWNR7WWtd4WGtdw/7gi1SmikllqvibVKaKE5WTik+oTBUnKicVf5PKScU3qfxNFX/Tw1rrGg9rrWs8rLWu8cOHVD6h8psq3lA5qZhUPlExqZxUTCqTyicqJpWpYqo4UflNFScqJxUnKm9UfOJhrXWNh7XWNR7WWtewP/gilaniROWk4jep/KaKSWWqeEPlpGJSmSomlaniROWNit+kclLxhspU8Tc9rLWu8bDWusbDWusa9gdfpHJS8YbKScUnVN6omFSmikllqvgmlZOKSWWqmFSmikllqviEyknFb1KZKiaVNyo+8bDWusbDWusaD2uta9gffEDlExXfpDJVvKEyVUwqU8WkMlVMKicVk8pJxYnKGxUnKm9UnKhMFZPKb6o4UZkqftPDWusaD2utazysta7xwy+rmFQmlaliUvkmlaliqnhDZao4qZhUJpVvqphUpoo3Kn6TylTxhspU8ZtUpopPPKy1rvGw1rrGw1rrGj98WcWk8obKVDGpTBWTyqRyovJGxaRyovJGxaQyVfwmlaniEypTxRsqJxVTxaQyVUwqJxWTylTxTQ9rrWs8rLWu8bDWuob9wRepTBVvqLxRMamcVJyoTBWTyknFpDJVTConFScqU8UbKlPFpPKJijdUpopJ5aTiRGWqmFROKn7Tw1rrGg9rrWs8rLWu8cOHVD6hMlWcqLxRcaJyonJSMalMFZPKVDGpnKhMFScqn6iYVKaKSWVSmSreUJkqTlROKiaVk4oTlaniEw9rrWs8rLWu8bDWuob9wQdUPlExqbxR8QmVqeJEZaqYVD5R8YbKVPGGylRxovJNFW+onFScqEwVk8pJxW96WGtd42GtdY2HtdY17A8+oDJVTCpTxSdUTipOVKaKSWWqmFSmikllqvibVE4qTlROKiaVqWJSeaPib1KZKv6lh7XWNR7WWtd4WGtd44cPVUwqb6hMFZPKVPGJijdU3qh4Q+WbKiaVSWWq+ETFpDJVnKicqPymiknljYpvelhrXeNhrXWNh7XWNX74kMpJxaRyojJVTConFW+onFR8QmWq+ETFicpJxSdUPqHyRsUbKlPFpPJGxaTymx7WWtd4WGtd42GtdQ37gw+oTBWTyv+yiknlpGJSOamYVP6mikllqjhReaNiUnmjYlL5popJZaqYVKaKTzysta7xsNa6xsNa6xo//LKKE5Wp4g2Vk4oTlb+pYlKZKiaVqeINlaniX1KZKiaVqWJSOal4Q2VSmSomlanimx7WWtd4WGtd42GtdY0fvkzlpOINlaniDZWp4g2VT1RMKt+kMlWcqEwVn6iYVKaKE5UTlU+oTBUnFZPKVDGpTBWfeFhrXeNhrXWNh7XWNX74ZRWTyhsVn6g4qZhU3qiYVE4qTlTeqHijYlKZKiaVqeKk4kTlpOINlZOKN1SmipOKb3pYa13jYa11jYe11jV++LKKSWWqmFQmld+kMlWcVHyTylTxhsonVKaKb1L5hMonVD5RMam8UfGJh7XWNR7WWtd4WGtdw/7gAyrfVPGGylTxTSqfqPgmlZOKE5WTikllqphUTiomlaniROWNiknlpGJSmSomlanimx7WWtd4WGtd42GtdY0f/rGKSeWk4kRlqjhRmSqmikllqphUTlSmikllqpgqJpVJZao4qZhUpopJZao4UZkqJpWTijdUTipOKt5QmSo+8bDWusbDWusaD2uta/zwl1VMKicVk8pJxaQyVZyo/KaKk4oTlaniROVEZaqYVN5QOVE5qZhUpopJZaqYVCaVqeJE5aTimx7WWtd4WGtd42GtdY0fPlRxonJScaJyUnFScVIxqUwVn1A5qZhUpoqp4kRlqphU/qWKSeWbVE4qTlTeUJkqPvGw1rrGw1rrGg9rrWv88CGVqWKqmFROKqaKN1SmikllqjhReaNiUpkqPqEyVUwVk8pJxaRyUjGpTBWTyknFpHKiMlWcqEwqU8VJxaTymx7WWtd4WGtd42GtdY0ffpnKVDGpnKhMFZPKb6qYVKaKm1VMKicVk8pJxUnFicpUMalMFZPKJ1TeqPhND2utazysta7xsNa6xg+/rGJSOVGZKiaVqWJSOamYVD6h8gmVE5UTlW9S+SaVqeITKlPFicpU8U0qU8UnHtZa13hYa13jYa11DfuDi6h8omJSeaPiDZU3KiaVk4pJ5aTiRGWqOFH5RMWkMlV8k8onKk5UTio+8bDWusbDWusaD2uta/zwZSpvVJxUTCpTxRsVJypTxScqPqHyCZU3VE4qJpXfpDJVTCpvVEwqb1RMKt/0sNa6xsNa6xoPa61r/PCXVbyh8omKSeWk4o2Kb6o4UZkqTiomlUllqphUJpWpYlKZVKaKT6j8TSp/08Na6xoPa61rPKy1rmF/8AGVqWJSmSq+SeWk4g2VT1RMKlPFpPJGxYnKVHGiMlVMKm9UnKicVJyonFRMKicVb6icVHziYa11jYe11jUe1lrX+OFDFZPKVPGGyknFVPGGylRxUjGpTBVvqEwVb6icVEwqn6g4UTlRmSreUDmpeKPiRGWqmComlW96WGtd42GtdY2HtdY1fvhlKicVU8UbKp9QeaNiUpkqpooTlTcqvqliUpkqJpWp4qTiDZWp4kTlpGJSmSreUJkqvulhrXWNh7XWNR7WWtewP/iAyhsVb6hMFW+oTBUnKlPFpHJScaLyL1W8oTJVfELlpOJE5TdVTCpTxaQyVXziYa11jYe11jUe1lrXsD/4H6ZyUnGiMlW8ofJGxYnKScUbKlPFN6lMFScqU8UnVKaKN1Q+UfFND2utazysta7xsNa6xg8fUvmbKqaKE5W/qeJEZaqYKiaVE5Wp4kRlqnhDZaqYVN5QeaPiDZWp4qTiDZWp4hMPa61rPKy1rvGw1rrGD19W8U0qJyonFScqk8pUMalMFScqU8U3VbxRMalMFScVk8pJxaQyVfymik+oTBW/6WGtdY2HtdY1HtZa1/jhl6m8UfGJijcqJpVJZao4UfmEyonKJ1SmikllqphUpooTlaliUnmj4kTlEypTxUnFNz2sta7xsNa6xsNa6xo//MeovFExVbyh8obKScVvUplUTlROVKaKqeKk4g2Vk4o3VKaKSeWk4pse1lrXeFhrXeNhrXWNH/5jKt5Q+UTFpDJVnKhMKlPFpPJGxUnFN6lMFScqU8UnVKaKSWWqmFSmihOVqeITD2utazysta7xsNa6xg+/rOI3VbyhMlVMKlPFGxWTyhsVk8obFW+onFS8UTGpTBVTxYnKScWJylQxqZyoTBW/6WGtdY2HtdY1HtZa1/jhy1T+JpWp4qRiUpkqJpWTiknlpGJSOak4UZlUporfpHJSMalMFZPKScWkMlWcqEwVk8qJym96WGtd42GtdY2HtdY17A/WWld4WGtd42GtdY2HtdY1HtZa13hYa13jYa11jYe11jUe1lrXeFhrXeNhrXWNh7XWNR7WWtd4WGtd42GtdY2HtdY1/h9TRs0Mt6MQHwAAAABJRU5ErkJggg==', '86affac1187fc44fbd5fb747e658ef71057225c30e6e50354bffc9f19a2234a6', 'scheduled', '2025-09-28 14:39:52', '2025-09-28 15:02:50'),
	(11, 3, 'test4', 'test4', '2025-09-28', '22:04:00', 'test4', 200, 'data:image/png;base64,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', 'dda9caaa05d3fd626c69f79389d707e0068c614f2a8368a409ea13ebe5ae9db3', 'scheduled', '2025-09-28 15:04:45', '2025-09-28 15:05:13');

-- Dumping structure for table community_attendance.participants
CREATE TABLE IF NOT EXISTS `participants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `institution` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `participants_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table community_attendance.participants: ~8 rows (approximately)
INSERT INTO `participants` (`id`, `admin_id`, `name`, `email`, `phone`, `institution`, `created_at`) VALUES
	(1, 1, 'John Doe', 'john@email.com', '08123456789', 'University A', '2025-09-26 17:02:51'),
	(2, 1, 'Jane Smith', 'jane@email.com', '08123456780', 'University B', '2025-09-26 17:02:51'),
	(3, 1, 'Bob Wilson', 'bob@email.com', '08123456781', 'Company X', '2025-09-26 17:02:51'),
	(4, 2, 'Alice Johnson', 'alice@email.com', '08123456782', 'Company Y', '2025-09-26 17:08:00'),
	(5, 3, 'Muhammad Rifai', 'rifai@gmail.com', '081200002020', '', '2025-09-26 23:18:00'),
	(6, 3, 'Dylan permana', 'dylan@gmail.com', '082290902323', '', '2025-09-26 23:18:43'),
	(7, 3, 'Dandy gumilar', 'dandy@gmail.com', '082290902121', '', '2025-09-26 23:19:14'),
	(8, 3, 'Nanda Nurrohman', 'nanda@gmail.com', '082290901111', '', '2025-09-26 23:20:03'),
	(9, 5, 'Muhammad Zakariya Ansori', 'himeansori@gmail.com', '081215800843', '', '2025-09-27 15:56:52'),
	(10, 5, 'dian sastro', 'dian@mail.com', '081215800843', '', '2025-09-27 16:02:27');

-- Dumping structure for table community_attendance.attendance
CREATE TABLE IF NOT EXISTS `attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `participant_id` int NOT NULL,
  `attendance_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('present','absent','late') DEFAULT 'present',
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `attendance_method` enum('qr_code','manual') DEFAULT 'manual',
  `qr_data` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_attendance` (`event_id`,`participant_id`),
  KEY `participant_id` (`participant_id`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1493 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table community_attendance.attendance: ~20 rows (approximately)
INSERT INTO `attendance` (`id`, `event_id`, `participant_id`, `attendance_time`, `status`, `notes`, `created_at`, `attendance_method`, `qr_data`) VALUES
	(1, 1, 1, '2025-09-26 17:14:55', 'present', 'On time', '2025-09-26 17:14:25', 'manual', NULL),
	(3, 1, 2, '2025-09-26 17:14:55', 'late', '10 minutes late', '2025-09-26 17:14:55', 'manual', NULL),
	(4, 2, 8, '2025-09-27 14:45:40', 'present', '', '2025-09-26 23:22:10', 'manual', NULL),
	(5, 2, 6, '2025-09-27 14:45:40', 'present', '', '2025-09-26 23:22:51', 'manual', NULL),
	(8, 2, 7, '2025-09-27 14:45:40', 'present', '', '2025-09-26 23:23:18', 'manual', NULL),
	(10, 2, 5, '2025-09-27 14:45:40', 'present', '', '2025-09-26 23:23:31', 'manual', NULL),
	(14, 3, 5, '2025-09-27 05:28:59', 'present', '', '2025-09-27 00:48:27', 'manual', NULL),
	(15, 4, 6, '2025-09-27 05:27:31', 'present', '', '2025-09-27 03:06:21', 'manual', NULL),
	(16, 4, 5, '2025-09-27 05:27:31', 'present', '', '2025-09-27 05:27:14', 'manual', NULL),
	(18, 4, 7, '2025-09-27 05:27:31', 'present', '', '2025-09-27 05:27:14', 'manual', NULL),
	(22, 4, 8, '2025-09-27 05:27:31', 'present', '', '2025-09-27 05:27:31', 'manual', NULL),
	(24, 3, 6, '2025-09-27 05:28:59', 'absent', '', '2025-09-27 05:28:59', 'manual', NULL),
	(25, 3, 7, '2025-09-27 05:28:59', 'present', '', '2025-09-27 05:28:59', 'manual', NULL),
	(26, 3, 8, '2025-09-27 05:28:59', 'absent', '', '2025-09-27 05:28:59', 'manual', NULL),
	(40, 7, 10, '2025-09-27 16:03:42', 'late', 'terlambat karena macet', '2025-09-27 16:02:55', 'manual', NULL),
	(43, 5, 5, '2025-09-27 16:33:02', 'present', '', '2025-09-27 16:33:02', 'manual', NULL),
	(44, 8, 5, '2025-09-28 13:11:31', 'absent', '', '2025-09-27 18:20:27', 'manual', NULL),
	(46, 8, 6, '2025-09-28 13:11:31', 'absent', '', '2025-09-27 18:32:40', 'manual', NULL),
	(47, 8, 8, '2025-09-28 13:11:31', 'present', '', '2025-09-27 19:24:30', 'manual', NULL),
	(50, 8, 7, '2025-09-28 13:11:31', 'present', '', '2025-09-28 13:11:31', 'manual', NULL),
	(52, 9, 5, '2025-09-28 15:02:17', 'present', 'QR code attendance', '2025-09-28 14:28:37', 'manual', NULL),
	(97, 9, 6, '2025-09-28 14:56:05', 'present', 'QR code attendance', '2025-09-28 14:30:01', 'manual', NULL),
	(149, 9, 7, '2025-09-28 14:59:21', 'present', 'QR code attendance', '2025-09-28 14:31:44', 'manual', NULL),
	(194, 9, 8, '2025-09-28 15:03:37', 'present', 'QR code attendance', '2025-09-28 14:34:29', 'manual', NULL),
	(1418, 10, 5, '2025-09-28 15:02:41', 'present', '', '2025-09-28 15:02:41', 'manual', NULL),
	(1419, 10, 6, '2025-09-28 15:02:41', 'absent', '', '2025-09-28 15:02:41', 'manual', NULL),
	(1420, 10, 7, '2025-09-28 15:02:41', 'absent', '', '2025-09-28 15:02:41', 'manual', NULL),
	(1467, 11, 5, '2025-09-28 15:05:52', 'present', 'QR code attendance', '2025-09-28 15:05:47', 'manual', NULL),
	(1492, 11, 6, '2025-09-28 15:06:54', 'present', 'QR code attendance', '2025-09-28 15:06:54', 'manual', NULL);


-- Dumping structure for table community_attendance.event_participants
CREATE TABLE IF NOT EXISTS `event_participants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `participant_id` int NOT NULL,
  `registered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_event_participant` (`event_id`,`participant_id`),
  KEY `participant_id` (`participant_id`),
  CONSTRAINT `event_participants_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `event_participants_ibfk_2` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table community_attendance.event_participants: ~19 rows (approximately)
INSERT INTO `event_participants` (`id`, `event_id`, `participant_id`, `registered_at`) VALUES
	(1, 1, 1, '2025-09-26 17:13:47'),
	(2, 2, 8, '2025-09-26 23:21:47'),
	(3, 2, 6, '2025-09-26 23:22:31'),
	(4, 2, 7, '2025-09-26 23:23:08'),
	(5, 2, 5, '2025-09-26 23:23:25'),
	(6, 3, 5, '2025-09-27 00:48:07'),
	(7, 4, 6, '2025-09-27 03:06:03'),
	(8, 4, 5, '2025-09-27 05:26:21'),
	(9, 4, 7, '2025-09-27 05:26:50'),
	(11, 4, 8, '2025-09-27 05:27:19'),
	(13, 3, 6, '2025-09-27 05:28:15'),
	(14, 3, 8, '2025-09-27 05:28:32'),
	(15, 3, 7, '2025-09-27 05:28:50'),
	(17, 5, 5, '2025-09-27 14:46:48'),
	(19, 7, 10, '2025-09-27 16:02:51'),
	(20, 8, 5, '2025-09-27 18:20:20'),
	(21, 8, 6, '2025-09-27 18:31:10'),
	(23, 8, 8, '2025-09-27 18:35:16'),
	(24, 8, 7, '2025-09-27 19:57:03'),
	(25, 9, 5, '2025-09-28 13:35:01'),
	(26, 9, 6, '2025-09-28 14:29:37'),
	(27, 9, 7, '2025-09-28 14:31:19'),
	(28, 9, 8, '2025-09-28 14:34:04'),
	(29, 10, 5, '2025-09-28 14:40:00'),
	(30, 10, 6, '2025-09-28 14:45:38'),
	(31, 10, 7, '2025-09-28 14:58:26'),
	(32, 10, 8, '2025-09-28 15:03:01'),
	(33, 11, 5, '2025-09-28 15:04:55'),
	(34, 11, 6, '2025-09-28 15:06:39');


/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
