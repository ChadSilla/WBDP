-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: bida_portal
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Soft delete flag',
  `user_id` int(11) DEFAULT NULL COMMENT 'The affected user',
  `admin_id` int(11) DEFAULT NULL COMMENT 'The staff/admin who performed the action',
  `action` varchar(100) NOT NULL COMMENT 'Categorical action (e.g. Password Reset)',
  `details` text DEFAULT NULL COMMENT 'Descriptive details of the action',
  `ip_address` varchar(45) DEFAULT NULL COMMENT 'IP address of the actor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_logs_user` (`user_id`),
  KEY `idx_logs_admin` (`admin_id`),
  KEY `idx_logs_action` (`action`),
  KEY `idx_logs_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='System audit trail for admin and user actions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `approved_transaction_docs`
--

DROP TABLE IF EXISTS `approved_transaction_docs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approved_transaction_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) NOT NULL,
  `requirement_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `approved_transaction_docs_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `approved_transactions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `approved_transactions`
--

DROP TABLE IF EXISTS `approved_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approved_transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `application_type` enum('PWD','Senior Citizen') NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Approved' COMMENT 'Approved, Processing, Releasing, Claimed',
  `processing_remark` varchar(255) DEFAULT '' COMMENT 'Staff remark during processing',
  `claiming_ticket_number` varchar(50) DEFAULT '' COMMENT 'Generated claiming ticket',
  `queue_ticket_number` varchar(50) DEFAULT NULL,
  `purpose_of_visit` text DEFAULT NULL,
  `reference_number` varchar(50) DEFAULT NULL,
  `original_created_at` timestamp NULL DEFAULT NULL,
  `approved_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Soft delete flag',
  PRIMARY KEY (`id`),
  KEY `idx_atx_user` (`user_id`),
  CONSTRAINT `approved_transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carousel_slides`
--

DROP TABLE IF EXISTS `carousel_slides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carousel_slides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `badge_text` varchar(50) NOT NULL COMMENT 'e.g. DISASTER RESPONSE',
  `title` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `expiration_date` datetime DEFAULT NULL COMMENT 'Manual expiration date/time',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Soft delete flag',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chat_messages`
--

DROP TABLE IF EXISTS `chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT 'The citizen user this conversation belongs to',
  `sender` enum('user','admin') NOT NULL DEFAULT 'user' COMMENT 'Who sent this message',
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `is_archived` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_chat_user` (`user_id`),
  KEY `idx_chat_unread` (`user_id`,`sender`,`is_read`),
  CONSTRAINT `chat_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Live chat messages between citizens and CSWDO staff';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_requests`
--

DROP TABLE IF EXISTS `document_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `document_name` varchar(255) NOT NULL,
  `reason` text NOT NULL,
  `status` enum('Pending','Processing','Ready','Rejected') NOT NULL DEFAULT 'Pending',
  `requested_file` varchar(500) DEFAULT NULL COMMENT 'Admin-uploaded file path when Ready',
  `date_requested` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_doc_requests_user` (`user_id`),
  CONSTRAINT `document_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pending_contact_changes`
--

DROP TABLE IF EXISTS `pending_contact_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pending_contact_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Soft delete flag',
  `user_id` int(11) NOT NULL,
  `field` enum('email','contact_number','first_name','middle_name','last_name','dob','sex','civil_status','barangay','house_street') NOT NULL,
  `new_value` varchar(255) NOT NULL,
  `status` enum('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  `rejection_reason` text DEFAULT NULL COMMENT 'Reason for rejection',
  `requested_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `proof_document` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `pending_contact_changes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile_documents`
--

DROP TABLE IF EXISTS `profile_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Soft delete flag',
  `user_id` int(11) NOT NULL,
  `profile_type` enum('PWD','Senior') NOT NULL,
  `document_type` varchar(100) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` int(11) NOT NULL,
  `file_mime` varchar(100) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_pdoc_user` (`user_id`),
  CONSTRAINT `profile_documents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pwd_profiles`
--

DROP TABLE IF EXISTS `pwd_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pwd_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `application_type` enum('New','Renewal','Transfer From') NOT NULL,
  `transfer_from_location` varchar(255) DEFAULT NULL COMMENT 'Location/address transferred from (for Transfer From application type)',
  `blood_type` varchar(5) DEFAULT NULL,
  `religion` varchar(100) DEFAULT NULL,
  `lahi` varchar(100) DEFAULT NULL,
  `educational_attainment` varchar(50) DEFAULT NULL,
  `employment_status` varchar(50) DEFAULT NULL,
  `employment_category` varchar(50) DEFAULT NULL,
  `employment_type` varchar(50) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `gsis_no` varchar(50) DEFAULT NULL,
  `pagibig_no` varchar(50) DEFAULT NULL,
  `philhealth_no` varchar(50) DEFAULT NULL,
  `philhealth_status` enum('Member','Dependent') DEFAULT NULL,
  `emergency_contact_name` varchar(100) DEFAULT NULL,
  `emergency_contact_num` varchar(50) DEFAULT NULL,
  `emergency_relationship` varchar(50) DEFAULT NULL,
  `disability_type` text DEFAULT NULL,
  `is_apparent` enum('Apparent','Non-Apparent') DEFAULT NULL,
  `pdao_cert_issued` varchar(100) DEFAULT NULL,
  `cause_congenital` text DEFAULT NULL,
  `cause_acquired` text DEFAULT NULL,
  `disability_cause` text DEFAULT NULL,
  `certifying_physician` varchar(100) DEFAULT NULL,
  `physician_specialization` varchar(100) DEFAULT NULL,
  `med_cert_submitted` enum('Yes','No') DEFAULT NULL,
  `med_cert_date` date DEFAULT NULL,
  `med_cert_expiry_date` date DEFAULT NULL COMMENT 'Computed as med_cert_date + 6 months',
  `physician_license_no` varchar(50) DEFAULT NULL,
  `father_name` varchar(100) DEFAULT NULL,
  `father_last_name` varchar(100) DEFAULT NULL,
  `father_first_name` varchar(100) DEFAULT NULL,
  `father_middle_name` varchar(100) DEFAULT NULL,
  `mother_name` varchar(100) DEFAULT NULL,
  `mother_last_name` varchar(100) DEFAULT NULL,
  `mother_first_name` varchar(100) DEFAULT NULL,
  `mother_middle_name` varchar(100) DEFAULT NULL,
  `guardian_name` varchar(100) DEFAULT NULL,
  `guardian_last_name` varchar(100) DEFAULT NULL,
  `guardian_first_name` varchar(100) DEFAULT NULL,
  `guardian_middle_name` varchar(100) DEFAULT NULL,
  `accomplished_by` enum('Applicant','Guardian','Representative') DEFAULT NULL,
  `accomplished_by_name` varchar(150) DEFAULT NULL,
  `status` enum('Pending Approval','Approved','Rejected') NOT NULL DEFAULT 'Pending Approval',
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `emergency_contact_address` varchar(255) DEFAULT NULL,
  `digital_id_number` varchar(50) DEFAULT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `pwd_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `senior_profiles`
--

DROP TABLE IF EXISTS `senior_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `senior_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `application_type` enum('New','Renewal','Replacement') NOT NULL,
  `blood_type` varchar(5) DEFAULT NULL,
  `civil_status` varchar(50) DEFAULT NULL,
  `religion` varchar(100) DEFAULT NULL,
  `lahi` varchar(100) DEFAULT NULL,
  `is_widow_widower` varchar(10) DEFAULT NULL,
  `educational_attainment` varchar(50) DEFAULT NULL,
  `employment_status` varchar(50) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `occupation_income` varchar(100) DEFAULT NULL,
  `id_number` varchar(50) DEFAULT NULL,
  `pensioner` enum('Yes','No') DEFAULT NULL,
  `pension_type` varchar(100) DEFAULT NULL,
  `spouse_name` varchar(100) DEFAULT NULL,
  `spouse_address` varchar(255) DEFAULT NULL,
  `spouse_dob` date DEFAULT NULL,
  `spouse_pob` varchar(100) DEFAULT NULL,
  `spouse_age` int(11) DEFAULT NULL,
  `spouse_occupation_income` varchar(100) DEFAULT NULL,
  `spouse_educational_attainment` varchar(100) DEFAULT NULL,
  `children_data` text DEFAULT NULL COMMENT 'JSON storage for children details',
  `emergency_contact_name` varchar(100) DEFAULT NULL,
  `emergency_contact_num` varchar(50) DEFAULT NULL,
  `emergency_relationship` varchar(50) DEFAULT NULL,
  `accomplished_by` enum('Applicant','Guardian','Representative') DEFAULT NULL,
  `accomplished_by_name` varchar(150) DEFAULT NULL,
  `status` enum('Pending Approval','Approved','Rejected') NOT NULL DEFAULT 'Pending Approval',
  `brgy_cert_date` date DEFAULT NULL,
  `brgy_cert_expiry_date` date DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `emergency_contact_address` varchar(255) DEFAULT NULL,
  `digital_id_number` varchar(50) DEFAULT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `senior_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service_application_docs`
--

DROP TABLE IF EXISTS `service_application_docs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_application_docs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` int(11) NOT NULL,
  `requirement_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `application_id` (`application_id`),
  CONSTRAINT `service_application_docs_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `service_applications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service_applications`
--

DROP TABLE IF EXISTS `service_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `application_type` enum('PWD','Senior Citizen') NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` varchar(50) NOT NULL COMMENT 'e.g. 08:00 AM - 09:00 AM',
  `status` enum('Pending Review','Approved','Rejected','Processing','For Claiming') NOT NULL DEFAULT 'Pending Review',
  `rejection_reason` text DEFAULT NULL COMMENT 'Reason for rejection (if rejected)',
  `purpose_of_visit` text DEFAULT NULL,
  `reference_number` varchar(50) DEFAULT NULL,
  `queue_ticket_number` varchar(50) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Soft delete flag',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `duplicate_flag` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_app_user` (`user_id`),
  KEY `idx_app_date_time` (`appointment_date`,`appointment_time`),
  CONSTRAINT `service_applications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_documents`
--

DROP TABLE IF EXISTS `user_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `document_type` varchar(100) NOT NULL,
  `file_name` varchar(255) NOT NULL COMMENT 'Original filename',
  `file_path` varchar(500) NOT NULL COMMENT 'Stored filename in Uploads/documents/',
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Pending','Verified','Rejected') NOT NULL DEFAULT 'Pending',
  `rejection_reason` text DEFAULT NULL COMMENT 'Reason for rejection (if rejected)',
  `issued_date` date DEFAULT NULL COMMENT 'Document issue date',
  `expiry_date` date DEFAULT NULL COMMENT 'Document expiry date',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Soft delete flag',
  PRIMARY KEY (`id`),
  KEY `idx_user_documents_user` (`user_id`),
  CONSTRAINT `user_documents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_notifications`
--

DROP TABLE IF EXISTS `user_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT 'Recipient user',
  `title` varchar(100) NOT NULL COMMENT 'Short notification heading',
  `message` text NOT NULL COMMENT 'Full notification body',
  `link` varchar(500) DEFAULT NULL COMMENT 'Optional action URL',
  `is_read` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = unread, 1 = read',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_notif_user` (`user_id`),
  KEY `idx_notif_read` (`is_read`),
  CONSTRAINT `user_notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Per-user in-app notifications';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique user ID',
  `member_id` varchar(20) DEFAULT NULL COMMENT 'Formatted Member ID (e.g. 2026-04-1024)',
  `first_name` varchar(100) NOT NULL COMMENT 'User first name (letters only)',
  `last_name` varchar(100) NOT NULL COMMENT 'User last name (letters only)',
  `suffix` varchar(20) DEFAULT NULL COMMENT 'User suffix (optional)',
  `middle_name` varchar(100) DEFAULT NULL COMMENT 'User middle name (optional)',
  `date_of_birth` date DEFAULT NULL COMMENT 'Date of birth',
  `sex` enum('Male','Female') DEFAULT NULL COMMENT 'Sex',
  `civil_status` enum('Single','Married','Widowed','Legally Separated','Annulled') DEFAULT NULL COMMENT 'Civil Status',
  `contact_number` varchar(15) NOT NULL COMMENT 'Unique phone number with +63 prefix (e.g., +639xxxxxxxxx)',
  `email` varchar(255) NOT NULL COMMENT 'Unique email address',
  `password` varchar(255) NOT NULL COMMENT 'Hashed password using password_hash()',
  `role` enum('user','admin','staff') NOT NULL DEFAULT 'user' COMMENT 'User role for access control',
  `house_street` varchar(255) DEFAULT NULL COMMENT 'House No./Street/Subdivision',
  `barangay` varchar(100) DEFAULT NULL COMMENT 'Barangay in Dasmariñas',
  `user_type` varchar(50) DEFAULT NULL COMMENT 'User classification (PWD, Senior Citizen, or both)',
  `classification_id` text DEFAULT NULL COMMENT 'Classification IDs (stored as JSON)',
  `profile_photo` varchar(255) DEFAULT NULL COMMENT 'Profile photo filename in Uploads/profile_photos/',
  `e_signature` varchar(255) DEFAULT NULL,
  `security_question` varchar(255) DEFAULT NULL COMMENT 'Security question for account recovery',
  `security_answer` varchar(255) DEFAULT NULL COMMENT 'Hashed answer to security question',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Soft delete flag (0=active, 1=archived)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Account creation timestamp',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last update timestamp',
  `signature_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_number` (`contact_number`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `member_id` (`member_id`),
  KEY `idx_contact_number` (`contact_number`),
  KEY `idx_email` (`email`),
  KEY `idx_role` (`role`),
  KEY `idx_user_type` (`user_type`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='BIDA Portal user accounts';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-11  8:02:37


-- ============================================================================
-- SEED DATA: Default Admin & Staff Accounts
-- ============================================================================

INSERT INTO `users` (`first_name`, `last_name`, `contact_number`, `email`, `password`, `role`, `barangay`, `user_type`, `date_of_birth`, `gender`, `civil_status`, `house_street`)
VALUES
    ('System', 'Administrator', '+639000000001', 'admin@cswdo.gov.ph',
     '$2y$10$j8MH7IMW6qoPM.IvGa/9yOqBBnEJY7yMYYWDudK2uNzGOb4DFUhCa',
     'admin', 'San Jose', NULL, '1990-01-01', 'Male', 'Single', 'CSWDO Office'),

    ('CSWDO', 'Staff', '+639000000002', 'staff@cswdo.gov.ph',
     '$2y$10$JA3noAfbqYQwNJRMpM.4f.m37qEsXUsmtTBez8RjK5PHOcgVqVMTW',
     'staff', 'San Jose', NULL, '1995-06-15', 'Female', 'Single', 'CSWDO Office')
ON DUPLICATE KEY UPDATE `id` = `id`;