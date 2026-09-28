-- MySQL dump 10.13  Distrib 8.4.0, for Win64 (x86_64)
--
-- Host: ::1    Database: local
-- ------------------------------------------------------
-- Server version	8.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `wp_commentmeta`
--

DROP TABLE IF EXISTS `wp_commentmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_commentmeta`
--

LOCK TABLES `wp_commentmeta` WRITE;
/*!40000 ALTER TABLE `wp_commentmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_commentmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_comments`
--

DROP TABLE IF EXISTS `wp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_comments` (
  `comment_ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'comment',
  `comment_parent` bigint unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_comments`
--

LOCK TABLES `wp_comments` WRITE;
/*!40000 ALTER TABLE `wp_comments` DISABLE KEYS */;
INSERT INTO `wp_comments` VALUES (1,1,'A WordPress Commenter','wapuu@wordpress.example','https://wordpress.org/','','2026-09-10 08:26:58','2026-09-10 08:26:58','Hi, this is a comment.\nTo get started with moderating, editing, and deleting comments, please visit the Comments screen in the dashboard.\nCommenter avatars come from <a href=\"https://gravatar.com/\">Gravatar</a>.',0,'1','','comment',0,0);
/*!40000 ALTER TABLE `wp_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_links` (
  `link_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint unsigned NOT NULL DEFAULT '1',
  `link_rating` int NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_links`
--

LOCK TABLES `wp_links` WRITE;
/*!40000 ALTER TABLE `wp_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_options`
--

DROP TABLE IF EXISTS `wp_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_options` (
  `option_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=InnoDB AUTO_INCREMENT=457 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_options`
--

LOCK TABLES `wp_options` WRITE;
/*!40000 ALTER TABLE `wp_options` DISABLE KEYS */;
INSERT INTO `wp_options` VALUES (1,'cron','a:10:{i:1789727217;a:1:{s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1789727222;a:1:{s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1789763259;a:1:{s:21:\"wp_update_user_counts\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1789766817;a:1:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1789768617;a:1:{s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1789806421;a:1:{s:32:\"recovery_mode_clean_expired_keys\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1789806459;a:3:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1790238570;a:1:{s:30:\"wp_delete_temp_updater_backups\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}}i:1790324821;a:1:{s:30:\"wp_site_health_scheduled_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"weekly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:604800;}}}s:7:\"version\";i:2;}','on');
INSERT INTO `wp_options` VALUES (2,'siteurl','http://mkb-student-app-v20.local','on');
INSERT INTO `wp_options` VALUES (3,'home','http://mkb-student-app-v20.local','on');
INSERT INTO `wp_options` VALUES (4,'blogname','MKB student app V2.0','on');
INSERT INTO `wp_options` VALUES (5,'blogdescription','This is the version 2.0 of our student App','on');
INSERT INTO `wp_options` VALUES (6,'users_can_register','1','on');
INSERT INTO `wp_options` VALUES (7,'admin_email','gcherubala11@gmail.com','on');
INSERT INTO `wp_options` VALUES (8,'start_of_week','1','on');
INSERT INTO `wp_options` VALUES (9,'use_balanceTags','0','on');
INSERT INTO `wp_options` VALUES (10,'use_smilies','1','on');
INSERT INTO `wp_options` VALUES (11,'require_name_email','1','on');
INSERT INTO `wp_options` VALUES (12,'comments_notify','1','on');
INSERT INTO `wp_options` VALUES (13,'posts_per_rss','10','on');
INSERT INTO `wp_options` VALUES (14,'rss_use_excerpt','0','on');
INSERT INTO `wp_options` VALUES (15,'mailserver_url','mail.example.com','on');
INSERT INTO `wp_options` VALUES (16,'mailserver_login','login@example.com','on');
INSERT INTO `wp_options` VALUES (17,'mailserver_pass','','on');
INSERT INTO `wp_options` VALUES (18,'mailserver_port','110','on');
INSERT INTO `wp_options` VALUES (19,'default_category','1','on');
INSERT INTO `wp_options` VALUES (20,'default_comment_status','open','on');
INSERT INTO `wp_options` VALUES (21,'default_ping_status','open','on');
INSERT INTO `wp_options` VALUES (22,'default_pingback_flag','1','on');
INSERT INTO `wp_options` VALUES (23,'posts_per_page','10','on');
INSERT INTO `wp_options` VALUES (24,'date_format','F j, Y','on');
INSERT INTO `wp_options` VALUES (25,'time_format','g:i a','on');
INSERT INTO `wp_options` VALUES (26,'links_updated_date_format','F j, Y g:i a','on');
INSERT INTO `wp_options` VALUES (27,'comment_moderation','0','on');
INSERT INTO `wp_options` VALUES (28,'moderation_notify','1','on');
INSERT INTO `wp_options` VALUES (29,'permalink_structure','/%postname%/','on');
INSERT INTO `wp_options` VALUES (30,'rewrite_rules','a:134:{s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:17:\"^wp-sitemap\\.xml$\";s:23:\"index.php?sitemap=index\";s:17:\"^wp-sitemap\\.xsl$\";s:36:\"index.php?sitemap-stylesheet=sitemap\";s:23:\"^wp-sitemap-index\\.xsl$\";s:34:\"index.php?sitemap-stylesheet=index\";s:48:\"^wp-sitemap-([a-z]+?)-([a-z\\d_-]+?)-(\\d+?)\\.xml$\";s:75:\"index.php?sitemap=$matches[1]&sitemap-subtype=$matches[2]&paged=$matches[3]\";s:34:\"^wp-sitemap-([a-z]+?)-(\\d+?)\\.xml$\";s:47:\"index.php?sitemap=$matches[1]&paged=$matches[2]\";s:9:\"survey/?$\";s:26:\"index.php?post_type=survey\";s:39:\"survey/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?post_type=survey&feed=$matches[1]\";s:34:\"survey/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?post_type=survey&feed=$matches[1]\";s:26:\"survey/page/([0-9]{1,})/?$\";s:44:\"index.php?post_type=survey&paged=$matches[1]\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:23:\"category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:20:\"tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:21:\"type/([^/]+)/embed/?$\";s:44:\"index.php?post_format=$matches[1]&embed=true\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:34:\"survey/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:44:\"survey/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:64:\"survey/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:59:\"survey/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:59:\"survey/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:40:\"survey/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:23:\"survey/([^/]+)/embed/?$\";s:39:\"index.php?survey=$matches[1]&embed=true\";s:27:\"survey/([^/]+)/trackback/?$\";s:33:\"index.php?survey=$matches[1]&tb=1\";s:47:\"survey/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:45:\"index.php?survey=$matches[1]&feed=$matches[2]\";s:42:\"survey/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:45:\"index.php?survey=$matches[1]&feed=$matches[2]\";s:35:\"survey/([^/]+)/page/?([0-9]{1,})/?$\";s:46:\"index.php?survey=$matches[1]&paged=$matches[2]\";s:42:\"survey/([^/]+)/comment-page-([0-9]{1,})/?$\";s:46:\"index.php?survey=$matches[1]&cpage=$matches[2]\";s:31:\"survey/([^/]+)(?:/([0-9]+))?/?$\";s:45:\"index.php?survey=$matches[1]&page=$matches[2]\";s:23:\"survey/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:33:\"survey/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:53:\"survey/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:48:\"survey/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:48:\"survey/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:29:\"survey/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:36:\"question/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:46:\"question/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:66:\"question/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:61:\"question/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:61:\"question/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:42:\"question/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:25:\"question/([^/]+)/embed/?$\";s:41:\"index.php?question=$matches[1]&embed=true\";s:29:\"question/([^/]+)/trackback/?$\";s:35:\"index.php?question=$matches[1]&tb=1\";s:37:\"question/([^/]+)/page/?([0-9]{1,})/?$\";s:48:\"index.php?question=$matches[1]&paged=$matches[2]\";s:44:\"question/([^/]+)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?question=$matches[1]&cpage=$matches[2]\";s:33:\"question/([^/]+)(?:/([0-9]+))?/?$\";s:47:\"index.php?question=$matches[1]&page=$matches[2]\";s:25:\"question/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:35:\"question/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:55:\"question/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:50:\"question/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:50:\"question/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:31:\"question/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:13:\"favicon\\.ico$\";s:19:\"index.php?favicon=1\";s:12:\"sitemap\\.xml\";s:24:\"index.php??sitemap=index\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:17:\"comments/embed/?$\";s:21:\"index.php?&embed=true\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:20:\"search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:23:\"author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";s:27:\"[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\"[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\"[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\"[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"([^/]+)/embed/?$\";s:37:\"index.php?name=$matches[1]&embed=true\";s:20:\"([^/]+)/trackback/?$\";s:31:\"index.php?name=$matches[1]&tb=1\";s:40:\"([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:35:\"([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:28:\"([^/]+)/page/?([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&paged=$matches[2]\";s:35:\"([^/]+)/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&cpage=$matches[2]\";s:24:\"([^/]+)(?:/([0-9]+))?/?$\";s:43:\"index.php?name=$matches[1]&page=$matches[2]\";s:16:\"[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:26:\"[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:46:\"[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:22:\"[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";}','on');
INSERT INTO `wp_options` VALUES (31,'hack_file','0','on');
INSERT INTO `wp_options` VALUES (32,'blog_charset','UTF-8','on');
INSERT INTO `wp_options` VALUES (33,'moderation_keys','','off');
INSERT INTO `wp_options` VALUES (34,'active_plugins','a:0:{}','on');
INSERT INTO `wp_options` VALUES (35,'category_base','','on');
INSERT INTO `wp_options` VALUES (36,'ping_sites','https://rpc.pingomatic.com/','on');
INSERT INTO `wp_options` VALUES (37,'comment_max_links','2','on');
INSERT INTO `wp_options` VALUES (38,'gmt_offset','0','on');
INSERT INTO `wp_options` VALUES (39,'default_email_category','1','on');
INSERT INTO `wp_options` VALUES (40,'recently_edited','a:5:{i:0;s:107:\"C:\\Users\\Free Coe\\Local Sites\\mkb-student-app-v20\\app\\public/wp-content/themes/student-survey-lms/style.css\";i:2;s:118:\"C:\\Users\\Free Coe\\Local Sites\\mkb-student-app-v20\\app\\public/wp-content/themes/student-survey-lms/inc/dynamic-menu.php\";i:3;s:108:\"C:\\Users\\Free Coe\\Local Sites\\mkb-student-app-v20\\app\\public/wp-content/themes/student-survey-lms/header.php\";i:4;s:117:\"C:\\Users\\Free Coe\\Local Sites\\mkb-student-app-v20\\app\\public/wp-content/themes/student-survey-lms/page-my-surveys.php\";i:5;s:113:\"C:\\Users\\Free Coe\\Local Sites\\mkb-student-app-v20\\app\\public/wp-content/themes/student-survey-lms/page-survey.php\";}','off');
INSERT INTO `wp_options` VALUES (41,'template','student-survey-lms','on');
INSERT INTO `wp_options` VALUES (42,'stylesheet','student-survey-lms','on');
INSERT INTO `wp_options` VALUES (43,'comment_registration','0','on');
INSERT INTO `wp_options` VALUES (44,'html_type','text/html','on');
INSERT INTO `wp_options` VALUES (45,'use_trackback','0','on');
INSERT INTO `wp_options` VALUES (46,'default_role','subscriber','on');
INSERT INTO `wp_options` VALUES (47,'db_version','60421','on');
INSERT INTO `wp_options` VALUES (48,'uploads_use_yearmonth_folders','1','on');
INSERT INTO `wp_options` VALUES (49,'upload_path','','on');
INSERT INTO `wp_options` VALUES (50,'blog_public','1','on');
INSERT INTO `wp_options` VALUES (51,'default_link_category','2','on');
INSERT INTO `wp_options` VALUES (52,'show_on_front','posts','on');
INSERT INTO `wp_options` VALUES (53,'tag_base','','on');
INSERT INTO `wp_options` VALUES (54,'show_avatars','1','on');
INSERT INTO `wp_options` VALUES (55,'avatar_rating','G','on');
INSERT INTO `wp_options` VALUES (56,'upload_url_path','','on');
INSERT INTO `wp_options` VALUES (57,'thumbnail_size_w','150','on');
INSERT INTO `wp_options` VALUES (58,'thumbnail_size_h','150','on');
INSERT INTO `wp_options` VALUES (59,'thumbnail_crop','1','on');
INSERT INTO `wp_options` VALUES (60,'medium_size_w','300','on');
INSERT INTO `wp_options` VALUES (61,'medium_size_h','300','on');
INSERT INTO `wp_options` VALUES (62,'avatar_default','mystery','on');
INSERT INTO `wp_options` VALUES (63,'large_size_w','1024','on');
INSERT INTO `wp_options` VALUES (64,'large_size_h','1024','on');
INSERT INTO `wp_options` VALUES (65,'image_default_link_type','none','on');
INSERT INTO `wp_options` VALUES (66,'image_default_size','','on');
INSERT INTO `wp_options` VALUES (67,'image_default_align','','on');
INSERT INTO `wp_options` VALUES (68,'close_comments_for_old_posts','0','on');
INSERT INTO `wp_options` VALUES (69,'close_comments_days_old','14','on');
INSERT INTO `wp_options` VALUES (70,'thread_comments','1','on');
INSERT INTO `wp_options` VALUES (71,'thread_comments_depth','5','on');
INSERT INTO `wp_options` VALUES (72,'page_comments','0','on');
INSERT INTO `wp_options` VALUES (73,'comments_per_page','50','on');
INSERT INTO `wp_options` VALUES (74,'default_comments_page','newest','on');
INSERT INTO `wp_options` VALUES (75,'comment_order','asc','on');
INSERT INTO `wp_options` VALUES (76,'sticky_posts','a:0:{}','on');
INSERT INTO `wp_options` VALUES (77,'widget_categories','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (78,'widget_text','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (79,'widget_rss','a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (80,'uninstall_plugins','a:0:{}','off');
INSERT INTO `wp_options` VALUES (81,'timezone_string','','on');
INSERT INTO `wp_options` VALUES (82,'page_for_posts','0','on');
INSERT INTO `wp_options` VALUES (83,'page_on_front','0','on');
INSERT INTO `wp_options` VALUES (84,'default_post_format','0','on');
INSERT INTO `wp_options` VALUES (85,'link_manager_enabled','0','on');
INSERT INTO `wp_options` VALUES (86,'finished_splitting_shared_terms','1','on');
INSERT INTO `wp_options` VALUES (87,'site_icon','0','on');
INSERT INTO `wp_options` VALUES (88,'medium_large_size_w','768','on');
INSERT INTO `wp_options` VALUES (89,'medium_large_size_h','0','on');
INSERT INTO `wp_options` VALUES (90,'wp_page_for_privacy_policy','3','on');
INSERT INTO `wp_options` VALUES (91,'show_comments_cookies_opt_in','1','on');
INSERT INTO `wp_options` VALUES (92,'admin_email_lifespan','1804580817','on');
INSERT INTO `wp_options` VALUES (93,'disallowed_keys','','off');
INSERT INTO `wp_options` VALUES (94,'comment_previously_approved','1','on');
INSERT INTO `wp_options` VALUES (95,'auto_plugin_theme_update_emails','a:0:{}','off');
INSERT INTO `wp_options` VALUES (96,'auto_update_core_dev','enabled','on');
INSERT INTO `wp_options` VALUES (97,'auto_update_core_minor','enabled','on');
INSERT INTO `wp_options` VALUES (98,'auto_update_core_major','enabled','on');
INSERT INTO `wp_options` VALUES (99,'wp_force_deactivated_plugins','a:0:{}','on');
INSERT INTO `wp_options` VALUES (100,'wp_attachment_pages_enabled','0','on');
INSERT INTO `wp_options` VALUES (101,'initial_db_version','60421','on');
INSERT INTO `wp_options` VALUES (102,'wp_user_roles','a:7:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:87:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;s:11:\"edit_survey\";b:1;s:11:\"read_survey\";b:1;s:13:\"delete_survey\";b:1;s:12:\"edit_surveys\";b:1;s:19:\"edit_others_surveys\";b:1;s:15:\"publish_surveys\";b:1;s:20:\"read_private_surveys\";b:1;s:14:\"delete_surveys\";b:1;s:22:\"delete_private_surveys\";b:1;s:24:\"delete_published_surveys\";b:1;s:21:\"delete_others_surveys\";b:1;s:20:\"edit_private_surveys\";b:1;s:22:\"edit_published_surveys\";b:1;s:13:\"edit_question\";b:1;s:13:\"read_question\";b:1;s:15:\"delete_question\";b:1;s:14:\"edit_questions\";b:1;s:21:\"edit_others_questions\";b:1;s:17:\"publish_questions\";b:1;s:22:\"read_private_questions\";b:1;s:16:\"delete_questions\";b:1;s:24:\"delete_private_questions\";b:1;s:26:\"delete_published_questions\";b:1;s:23:\"delete_others_questions\";b:1;s:22:\"edit_private_questions\";b:1;s:24:\"edit_published_questions\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}s:7:\"student\";a:2:{s:4:\"name\";s:7:\"Student\";s:12:\"capabilities\";a:1:{s:4:\"read\";b:1;}}s:10:\"instructor\";a:2:{s:4:\"name\";s:10:\"Instructor\";s:12:\"capabilities\";a:30:{s:4:\"read\";b:1;s:10:\"edit_posts\";b:1;s:12:\"edit_surveys\";b:1;s:14:\"manage_classes\";b:1;s:11:\"edit_survey\";b:1;s:11:\"read_survey\";b:1;s:13:\"delete_survey\";b:1;s:19:\"edit_others_surveys\";b:1;s:15:\"publish_surveys\";b:1;s:20:\"read_private_surveys\";b:1;s:14:\"delete_surveys\";b:1;s:22:\"delete_private_surveys\";b:1;s:24:\"delete_published_surveys\";b:1;s:21:\"delete_others_surveys\";b:1;s:20:\"edit_private_surveys\";b:1;s:22:\"edit_published_surveys\";b:1;s:13:\"edit_question\";b:1;s:13:\"read_question\";b:1;s:15:\"delete_question\";b:1;s:14:\"edit_questions\";b:1;s:21:\"edit_others_questions\";b:1;s:17:\"publish_questions\";b:1;s:22:\"read_private_questions\";b:1;s:16:\"delete_questions\";b:1;s:24:\"delete_private_questions\";b:1;s:26:\"delete_published_questions\";b:1;s:23:\"delete_others_questions\";b:1;s:22:\"edit_private_questions\";b:1;s:24:\"edit_published_questions\";b:1;s:12:\"upload_files\";b:1;}}}','on');
INSERT INTO `wp_options` VALUES (103,'fresh_site','0','off');
INSERT INTO `wp_options` VALUES (104,'user_count','7','off');
INSERT INTO `wp_options` VALUES (105,'widget_block','a:6:{i:2;a:1:{s:7:\"content\";s:19:\"<!-- wp:search /-->\";}i:3;a:1:{s:7:\"content\";s:154:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Recent Posts</h2><!-- /wp:heading --><!-- wp:latest-posts /--></div><!-- /wp:group -->\";}i:4;a:1:{s:7:\"content\";s:227:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Recent Comments</h2><!-- /wp:heading --><!-- wp:latest-comments {\"displayAvatar\":false,\"displayDate\":false,\"displayExcerpt\":false} /--></div><!-- /wp:group -->\";}i:5;a:1:{s:7:\"content\";s:146:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Archives</h2><!-- /wp:heading --><!-- wp:archives /--></div><!-- /wp:group -->\";}i:6;a:1:{s:7:\"content\";s:150:\"<!-- wp:group --><div class=\"wp-block-group\"><!-- wp:heading --><h2>Categories</h2><!-- /wp:heading --><!-- wp:categories /--></div><!-- /wp:group -->\";}s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (106,'sidebars_widgets','a:4:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:3:{i:0;s:7:\"block-2\";i:1;s:7:\"block-3\";i:2;s:7:\"block-4\";}s:9:\"sidebar-2\";a:2:{i:0;s:7:\"block-5\";i:1;s:7:\"block-6\";}s:13:\"array_version\";i:3;}','auto');
INSERT INTO `wp_options` VALUES (107,'widget_pages','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (108,'widget_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (109,'widget_archives','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (110,'widget_media_audio','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (111,'widget_media_image','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (112,'widget_media_gallery','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (113,'widget_media_video','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (114,'widget_meta','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (115,'widget_search','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (116,'widget_recent-posts','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (117,'widget_recent-comments','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (118,'widget_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (119,'widget_nav_menu','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (120,'widget_custom_html','a:1:{s:12:\"_multiwidget\";i:1;}','auto');
INSERT INTO `wp_options` VALUES (121,'_transient_wp_core_block_css_files','a:2:{s:7:\"version\";s:5:\"6.8.3\";s:5:\"files\";a:536:{i:0;s:23:\"archives/editor-rtl.css\";i:1;s:27:\"archives/editor-rtl.min.css\";i:2;s:19:\"archives/editor.css\";i:3;s:23:\"archives/editor.min.css\";i:4;s:22:\"archives/style-rtl.css\";i:5;s:26:\"archives/style-rtl.min.css\";i:6;s:18:\"archives/style.css\";i:7;s:22:\"archives/style.min.css\";i:8;s:20:\"audio/editor-rtl.css\";i:9;s:24:\"audio/editor-rtl.min.css\";i:10;s:16:\"audio/editor.css\";i:11;s:20:\"audio/editor.min.css\";i:12;s:19:\"audio/style-rtl.css\";i:13;s:23:\"audio/style-rtl.min.css\";i:14;s:15:\"audio/style.css\";i:15;s:19:\"audio/style.min.css\";i:16;s:19:\"audio/theme-rtl.css\";i:17;s:23:\"audio/theme-rtl.min.css\";i:18;s:15:\"audio/theme.css\";i:19;s:19:\"audio/theme.min.css\";i:20;s:21:\"avatar/editor-rtl.css\";i:21;s:25:\"avatar/editor-rtl.min.css\";i:22;s:17:\"avatar/editor.css\";i:23;s:21:\"avatar/editor.min.css\";i:24;s:20:\"avatar/style-rtl.css\";i:25;s:24:\"avatar/style-rtl.min.css\";i:26;s:16:\"avatar/style.css\";i:27;s:20:\"avatar/style.min.css\";i:28;s:21:\"button/editor-rtl.css\";i:29;s:25:\"button/editor-rtl.min.css\";i:30;s:17:\"button/editor.css\";i:31;s:21:\"button/editor.min.css\";i:32;s:20:\"button/style-rtl.css\";i:33;s:24:\"button/style-rtl.min.css\";i:34;s:16:\"button/style.css\";i:35;s:20:\"button/style.min.css\";i:36;s:22:\"buttons/editor-rtl.css\";i:37;s:26:\"buttons/editor-rtl.min.css\";i:38;s:18:\"buttons/editor.css\";i:39;s:22:\"buttons/editor.min.css\";i:40;s:21:\"buttons/style-rtl.css\";i:41;s:25:\"buttons/style-rtl.min.css\";i:42;s:17:\"buttons/style.css\";i:43;s:21:\"buttons/style.min.css\";i:44;s:22:\"calendar/style-rtl.css\";i:45;s:26:\"calendar/style-rtl.min.css\";i:46;s:18:\"calendar/style.css\";i:47;s:22:\"calendar/style.min.css\";i:48;s:25:\"categories/editor-rtl.css\";i:49;s:29:\"categories/editor-rtl.min.css\";i:50;s:21:\"categories/editor.css\";i:51;s:25:\"categories/editor.min.css\";i:52;s:24:\"categories/style-rtl.css\";i:53;s:28:\"categories/style-rtl.min.css\";i:54;s:20:\"categories/style.css\";i:55;s:24:\"categories/style.min.css\";i:56;s:19:\"code/editor-rtl.css\";i:57;s:23:\"code/editor-rtl.min.css\";i:58;s:15:\"code/editor.css\";i:59;s:19:\"code/editor.min.css\";i:60;s:18:\"code/style-rtl.css\";i:61;s:22:\"code/style-rtl.min.css\";i:62;s:14:\"code/style.css\";i:63;s:18:\"code/style.min.css\";i:64;s:18:\"code/theme-rtl.css\";i:65;s:22:\"code/theme-rtl.min.css\";i:66;s:14:\"code/theme.css\";i:67;s:18:\"code/theme.min.css\";i:68;s:22:\"columns/editor-rtl.css\";i:69;s:26:\"columns/editor-rtl.min.css\";i:70;s:18:\"columns/editor.css\";i:71;s:22:\"columns/editor.min.css\";i:72;s:21:\"columns/style-rtl.css\";i:73;s:25:\"columns/style-rtl.min.css\";i:74;s:17:\"columns/style.css\";i:75;s:21:\"columns/style.min.css\";i:76;s:33:\"comment-author-name/style-rtl.css\";i:77;s:37:\"comment-author-name/style-rtl.min.css\";i:78;s:29:\"comment-author-name/style.css\";i:79;s:33:\"comment-author-name/style.min.css\";i:80;s:29:\"comment-content/style-rtl.css\";i:81;s:33:\"comment-content/style-rtl.min.css\";i:82;s:25:\"comment-content/style.css\";i:83;s:29:\"comment-content/style.min.css\";i:84;s:26:\"comment-date/style-rtl.css\";i:85;s:30:\"comment-date/style-rtl.min.css\";i:86;s:22:\"comment-date/style.css\";i:87;s:26:\"comment-date/style.min.css\";i:88;s:31:\"comment-edit-link/style-rtl.css\";i:89;s:35:\"comment-edit-link/style-rtl.min.css\";i:90;s:27:\"comment-edit-link/style.css\";i:91;s:31:\"comment-edit-link/style.min.css\";i:92;s:32:\"comment-reply-link/style-rtl.css\";i:93;s:36:\"comment-reply-link/style-rtl.min.css\";i:94;s:28:\"comment-reply-link/style.css\";i:95;s:32:\"comment-reply-link/style.min.css\";i:96;s:30:\"comment-template/style-rtl.css\";i:97;s:34:\"comment-template/style-rtl.min.css\";i:98;s:26:\"comment-template/style.css\";i:99;s:30:\"comment-template/style.min.css\";i:100;s:42:\"comments-pagination-numbers/editor-rtl.css\";i:101;s:46:\"comments-pagination-numbers/editor-rtl.min.css\";i:102;s:38:\"comments-pagination-numbers/editor.css\";i:103;s:42:\"comments-pagination-numbers/editor.min.css\";i:104;s:34:\"comments-pagination/editor-rtl.css\";i:105;s:38:\"comments-pagination/editor-rtl.min.css\";i:106;s:30:\"comments-pagination/editor.css\";i:107;s:34:\"comments-pagination/editor.min.css\";i:108;s:33:\"comments-pagination/style-rtl.css\";i:109;s:37:\"comments-pagination/style-rtl.min.css\";i:110;s:29:\"comments-pagination/style.css\";i:111;s:33:\"comments-pagination/style.min.css\";i:112;s:29:\"comments-title/editor-rtl.css\";i:113;s:33:\"comments-title/editor-rtl.min.css\";i:114;s:25:\"comments-title/editor.css\";i:115;s:29:\"comments-title/editor.min.css\";i:116;s:23:\"comments/editor-rtl.css\";i:117;s:27:\"comments/editor-rtl.min.css\";i:118;s:19:\"comments/editor.css\";i:119;s:23:\"comments/editor.min.css\";i:120;s:22:\"comments/style-rtl.css\";i:121;s:26:\"comments/style-rtl.min.css\";i:122;s:18:\"comments/style.css\";i:123;s:22:\"comments/style.min.css\";i:124;s:20:\"cover/editor-rtl.css\";i:125;s:24:\"cover/editor-rtl.min.css\";i:126;s:16:\"cover/editor.css\";i:127;s:20:\"cover/editor.min.css\";i:128;s:19:\"cover/style-rtl.css\";i:129;s:23:\"cover/style-rtl.min.css\";i:130;s:15:\"cover/style.css\";i:131;s:19:\"cover/style.min.css\";i:132;s:22:\"details/editor-rtl.css\";i:133;s:26:\"details/editor-rtl.min.css\";i:134;s:18:\"details/editor.css\";i:135;s:22:\"details/editor.min.css\";i:136;s:21:\"details/style-rtl.css\";i:137;s:25:\"details/style-rtl.min.css\";i:138;s:17:\"details/style.css\";i:139;s:21:\"details/style.min.css\";i:140;s:20:\"embed/editor-rtl.css\";i:141;s:24:\"embed/editor-rtl.min.css\";i:142;s:16:\"embed/editor.css\";i:143;s:20:\"embed/editor.min.css\";i:144;s:19:\"embed/style-rtl.css\";i:145;s:23:\"embed/style-rtl.min.css\";i:146;s:15:\"embed/style.css\";i:147;s:19:\"embed/style.min.css\";i:148;s:19:\"embed/theme-rtl.css\";i:149;s:23:\"embed/theme-rtl.min.css\";i:150;s:15:\"embed/theme.css\";i:151;s:19:\"embed/theme.min.css\";i:152;s:19:\"file/editor-rtl.css\";i:153;s:23:\"file/editor-rtl.min.css\";i:154;s:15:\"file/editor.css\";i:155;s:19:\"file/editor.min.css\";i:156;s:18:\"file/style-rtl.css\";i:157;s:22:\"file/style-rtl.min.css\";i:158;s:14:\"file/style.css\";i:159;s:18:\"file/style.min.css\";i:160;s:23:\"footnotes/style-rtl.css\";i:161;s:27:\"footnotes/style-rtl.min.css\";i:162;s:19:\"footnotes/style.css\";i:163;s:23:\"footnotes/style.min.css\";i:164;s:23:\"freeform/editor-rtl.css\";i:165;s:27:\"freeform/editor-rtl.min.css\";i:166;s:19:\"freeform/editor.css\";i:167;s:23:\"freeform/editor.min.css\";i:168;s:22:\"gallery/editor-rtl.css\";i:169;s:26:\"gallery/editor-rtl.min.css\";i:170;s:18:\"gallery/editor.css\";i:171;s:22:\"gallery/editor.min.css\";i:172;s:21:\"gallery/style-rtl.css\";i:173;s:25:\"gallery/style-rtl.min.css\";i:174;s:17:\"gallery/style.css\";i:175;s:21:\"gallery/style.min.css\";i:176;s:21:\"gallery/theme-rtl.css\";i:177;s:25:\"gallery/theme-rtl.min.css\";i:178;s:17:\"gallery/theme.css\";i:179;s:21:\"gallery/theme.min.css\";i:180;s:20:\"group/editor-rtl.css\";i:181;s:24:\"group/editor-rtl.min.css\";i:182;s:16:\"group/editor.css\";i:183;s:20:\"group/editor.min.css\";i:184;s:19:\"group/style-rtl.css\";i:185;s:23:\"group/style-rtl.min.css\";i:186;s:15:\"group/style.css\";i:187;s:19:\"group/style.min.css\";i:188;s:19:\"group/theme-rtl.css\";i:189;s:23:\"group/theme-rtl.min.css\";i:190;s:15:\"group/theme.css\";i:191;s:19:\"group/theme.min.css\";i:192;s:21:\"heading/style-rtl.css\";i:193;s:25:\"heading/style-rtl.min.css\";i:194;s:17:\"heading/style.css\";i:195;s:21:\"heading/style.min.css\";i:196;s:19:\"html/editor-rtl.css\";i:197;s:23:\"html/editor-rtl.min.css\";i:198;s:15:\"html/editor.css\";i:199;s:19:\"html/editor.min.css\";i:200;s:20:\"image/editor-rtl.css\";i:201;s:24:\"image/editor-rtl.min.css\";i:202;s:16:\"image/editor.css\";i:203;s:20:\"image/editor.min.css\";i:204;s:19:\"image/style-rtl.css\";i:205;s:23:\"image/style-rtl.min.css\";i:206;s:15:\"image/style.css\";i:207;s:19:\"image/style.min.css\";i:208;s:19:\"image/theme-rtl.css\";i:209;s:23:\"image/theme-rtl.min.css\";i:210;s:15:\"image/theme.css\";i:211;s:19:\"image/theme.min.css\";i:212;s:29:\"latest-comments/style-rtl.css\";i:213;s:33:\"latest-comments/style-rtl.min.css\";i:214;s:25:\"latest-comments/style.css\";i:215;s:29:\"latest-comments/style.min.css\";i:216;s:27:\"latest-posts/editor-rtl.css\";i:217;s:31:\"latest-posts/editor-rtl.min.css\";i:218;s:23:\"latest-posts/editor.css\";i:219;s:27:\"latest-posts/editor.min.css\";i:220;s:26:\"latest-posts/style-rtl.css\";i:221;s:30:\"latest-posts/style-rtl.min.css\";i:222;s:22:\"latest-posts/style.css\";i:223;s:26:\"latest-posts/style.min.css\";i:224;s:18:\"list/style-rtl.css\";i:225;s:22:\"list/style-rtl.min.css\";i:226;s:14:\"list/style.css\";i:227;s:18:\"list/style.min.css\";i:228;s:22:\"loginout/style-rtl.css\";i:229;s:26:\"loginout/style-rtl.min.css\";i:230;s:18:\"loginout/style.css\";i:231;s:22:\"loginout/style.min.css\";i:232;s:25:\"media-text/editor-rtl.css\";i:233;s:29:\"media-text/editor-rtl.min.css\";i:234;s:21:\"media-text/editor.css\";i:235;s:25:\"media-text/editor.min.css\";i:236;s:24:\"media-text/style-rtl.css\";i:237;s:28:\"media-text/style-rtl.min.css\";i:238;s:20:\"media-text/style.css\";i:239;s:24:\"media-text/style.min.css\";i:240;s:19:\"more/editor-rtl.css\";i:241;s:23:\"more/editor-rtl.min.css\";i:242;s:15:\"more/editor.css\";i:243;s:19:\"more/editor.min.css\";i:244;s:30:\"navigation-link/editor-rtl.css\";i:245;s:34:\"navigation-link/editor-rtl.min.css\";i:246;s:26:\"navigation-link/editor.css\";i:247;s:30:\"navigation-link/editor.min.css\";i:248;s:29:\"navigation-link/style-rtl.css\";i:249;s:33:\"navigation-link/style-rtl.min.css\";i:250;s:25:\"navigation-link/style.css\";i:251;s:29:\"navigation-link/style.min.css\";i:252;s:33:\"navigation-submenu/editor-rtl.css\";i:253;s:37:\"navigation-submenu/editor-rtl.min.css\";i:254;s:29:\"navigation-submenu/editor.css\";i:255;s:33:\"navigation-submenu/editor.min.css\";i:256;s:25:\"navigation/editor-rtl.css\";i:257;s:29:\"navigation/editor-rtl.min.css\";i:258;s:21:\"navigation/editor.css\";i:259;s:25:\"navigation/editor.min.css\";i:260;s:24:\"navigation/style-rtl.css\";i:261;s:28:\"navigation/style-rtl.min.css\";i:262;s:20:\"navigation/style.css\";i:263;s:24:\"navigation/style.min.css\";i:264;s:23:\"nextpage/editor-rtl.css\";i:265;s:27:\"nextpage/editor-rtl.min.css\";i:266;s:19:\"nextpage/editor.css\";i:267;s:23:\"nextpage/editor.min.css\";i:268;s:24:\"page-list/editor-rtl.css\";i:269;s:28:\"page-list/editor-rtl.min.css\";i:270;s:20:\"page-list/editor.css\";i:271;s:24:\"page-list/editor.min.css\";i:272;s:23:\"page-list/style-rtl.css\";i:273;s:27:\"page-list/style-rtl.min.css\";i:274;s:19:\"page-list/style.css\";i:275;s:23:\"page-list/style.min.css\";i:276;s:24:\"paragraph/editor-rtl.css\";i:277;s:28:\"paragraph/editor-rtl.min.css\";i:278;s:20:\"paragraph/editor.css\";i:279;s:24:\"paragraph/editor.min.css\";i:280;s:23:\"paragraph/style-rtl.css\";i:281;s:27:\"paragraph/style-rtl.min.css\";i:282;s:19:\"paragraph/style.css\";i:283;s:23:\"paragraph/style.min.css\";i:284;s:35:\"post-author-biography/style-rtl.css\";i:285;s:39:\"post-author-biography/style-rtl.min.css\";i:286;s:31:\"post-author-biography/style.css\";i:287;s:35:\"post-author-biography/style.min.css\";i:288;s:30:\"post-author-name/style-rtl.css\";i:289;s:34:\"post-author-name/style-rtl.min.css\";i:290;s:26:\"post-author-name/style.css\";i:291;s:30:\"post-author-name/style.min.css\";i:292;s:26:\"post-author/editor-rtl.css\";i:293;s:30:\"post-author/editor-rtl.min.css\";i:294;s:22:\"post-author/editor.css\";i:295;s:26:\"post-author/editor.min.css\";i:296;s:25:\"post-author/style-rtl.css\";i:297;s:29:\"post-author/style-rtl.min.css\";i:298;s:21:\"post-author/style.css\";i:299;s:25:\"post-author/style.min.css\";i:300;s:33:\"post-comments-form/editor-rtl.css\";i:301;s:37:\"post-comments-form/editor-rtl.min.css\";i:302;s:29:\"post-comments-form/editor.css\";i:303;s:33:\"post-comments-form/editor.min.css\";i:304;s:32:\"post-comments-form/style-rtl.css\";i:305;s:36:\"post-comments-form/style-rtl.min.css\";i:306;s:28:\"post-comments-form/style.css\";i:307;s:32:\"post-comments-form/style.min.css\";i:308;s:26:\"post-content/style-rtl.css\";i:309;s:30:\"post-content/style-rtl.min.css\";i:310;s:22:\"post-content/style.css\";i:311;s:26:\"post-content/style.min.css\";i:312;s:23:\"post-date/style-rtl.css\";i:313;s:27:\"post-date/style-rtl.min.css\";i:314;s:19:\"post-date/style.css\";i:315;s:23:\"post-date/style.min.css\";i:316;s:27:\"post-excerpt/editor-rtl.css\";i:317;s:31:\"post-excerpt/editor-rtl.min.css\";i:318;s:23:\"post-excerpt/editor.css\";i:319;s:27:\"post-excerpt/editor.min.css\";i:320;s:26:\"post-excerpt/style-rtl.css\";i:321;s:30:\"post-excerpt/style-rtl.min.css\";i:322;s:22:\"post-excerpt/style.css\";i:323;s:26:\"post-excerpt/style.min.css\";i:324;s:34:\"post-featured-image/editor-rtl.css\";i:325;s:38:\"post-featured-image/editor-rtl.min.css\";i:326;s:30:\"post-featured-image/editor.css\";i:327;s:34:\"post-featured-image/editor.min.css\";i:328;s:33:\"post-featured-image/style-rtl.css\";i:329;s:37:\"post-featured-image/style-rtl.min.css\";i:330;s:29:\"post-featured-image/style.css\";i:331;s:33:\"post-featured-image/style.min.css\";i:332;s:34:\"post-navigation-link/style-rtl.css\";i:333;s:38:\"post-navigation-link/style-rtl.min.css\";i:334;s:30:\"post-navigation-link/style.css\";i:335;s:34:\"post-navigation-link/style.min.css\";i:336;s:27:\"post-template/style-rtl.css\";i:337;s:31:\"post-template/style-rtl.min.css\";i:338;s:23:\"post-template/style.css\";i:339;s:27:\"post-template/style.min.css\";i:340;s:24:\"post-terms/style-rtl.css\";i:341;s:28:\"post-terms/style-rtl.min.css\";i:342;s:20:\"post-terms/style.css\";i:343;s:24:\"post-terms/style.min.css\";i:344;s:24:\"post-title/style-rtl.css\";i:345;s:28:\"post-title/style-rtl.min.css\";i:346;s:20:\"post-title/style.css\";i:347;s:24:\"post-title/style.min.css\";i:348;s:26:\"preformatted/style-rtl.css\";i:349;s:30:\"preformatted/style-rtl.min.css\";i:350;s:22:\"preformatted/style.css\";i:351;s:26:\"preformatted/style.min.css\";i:352;s:24:\"pullquote/editor-rtl.css\";i:353;s:28:\"pullquote/editor-rtl.min.css\";i:354;s:20:\"pullquote/editor.css\";i:355;s:24:\"pullquote/editor.min.css\";i:356;s:23:\"pullquote/style-rtl.css\";i:357;s:27:\"pullquote/style-rtl.min.css\";i:358;s:19:\"pullquote/style.css\";i:359;s:23:\"pullquote/style.min.css\";i:360;s:23:\"pullquote/theme-rtl.css\";i:361;s:27:\"pullquote/theme-rtl.min.css\";i:362;s:19:\"pullquote/theme.css\";i:363;s:23:\"pullquote/theme.min.css\";i:364;s:39:\"query-pagination-numbers/editor-rtl.css\";i:365;s:43:\"query-pagination-numbers/editor-rtl.min.css\";i:366;s:35:\"query-pagination-numbers/editor.css\";i:367;s:39:\"query-pagination-numbers/editor.min.css\";i:368;s:31:\"query-pagination/editor-rtl.css\";i:369;s:35:\"query-pagination/editor-rtl.min.css\";i:370;s:27:\"query-pagination/editor.css\";i:371;s:31:\"query-pagination/editor.min.css\";i:372;s:30:\"query-pagination/style-rtl.css\";i:373;s:34:\"query-pagination/style-rtl.min.css\";i:374;s:26:\"query-pagination/style.css\";i:375;s:30:\"query-pagination/style.min.css\";i:376;s:25:\"query-title/style-rtl.css\";i:377;s:29:\"query-title/style-rtl.min.css\";i:378;s:21:\"query-title/style.css\";i:379;s:25:\"query-title/style.min.css\";i:380;s:25:\"query-total/style-rtl.css\";i:381;s:29:\"query-total/style-rtl.min.css\";i:382;s:21:\"query-total/style.css\";i:383;s:25:\"query-total/style.min.css\";i:384;s:20:\"query/editor-rtl.css\";i:385;s:24:\"query/editor-rtl.min.css\";i:386;s:16:\"query/editor.css\";i:387;s:20:\"query/editor.min.css\";i:388;s:19:\"quote/style-rtl.css\";i:389;s:23:\"quote/style-rtl.min.css\";i:390;s:15:\"quote/style.css\";i:391;s:19:\"quote/style.min.css\";i:392;s:19:\"quote/theme-rtl.css\";i:393;s:23:\"quote/theme-rtl.min.css\";i:394;s:15:\"quote/theme.css\";i:395;s:19:\"quote/theme.min.css\";i:396;s:23:\"read-more/style-rtl.css\";i:397;s:27:\"read-more/style-rtl.min.css\";i:398;s:19:\"read-more/style.css\";i:399;s:23:\"read-more/style.min.css\";i:400;s:18:\"rss/editor-rtl.css\";i:401;s:22:\"rss/editor-rtl.min.css\";i:402;s:14:\"rss/editor.css\";i:403;s:18:\"rss/editor.min.css\";i:404;s:17:\"rss/style-rtl.css\";i:405;s:21:\"rss/style-rtl.min.css\";i:406;s:13:\"rss/style.css\";i:407;s:17:\"rss/style.min.css\";i:408;s:21:\"search/editor-rtl.css\";i:409;s:25:\"search/editor-rtl.min.css\";i:410;s:17:\"search/editor.css\";i:411;s:21:\"search/editor.min.css\";i:412;s:20:\"search/style-rtl.css\";i:413;s:24:\"search/style-rtl.min.css\";i:414;s:16:\"search/style.css\";i:415;s:20:\"search/style.min.css\";i:416;s:20:\"search/theme-rtl.css\";i:417;s:24:\"search/theme-rtl.min.css\";i:418;s:16:\"search/theme.css\";i:419;s:20:\"search/theme.min.css\";i:420;s:24:\"separator/editor-rtl.css\";i:421;s:28:\"separator/editor-rtl.min.css\";i:422;s:20:\"separator/editor.css\";i:423;s:24:\"separator/editor.min.css\";i:424;s:23:\"separator/style-rtl.css\";i:425;s:27:\"separator/style-rtl.min.css\";i:426;s:19:\"separator/style.css\";i:427;s:23:\"separator/style.min.css\";i:428;s:23:\"separator/theme-rtl.css\";i:429;s:27:\"separator/theme-rtl.min.css\";i:430;s:19:\"separator/theme.css\";i:431;s:23:\"separator/theme.min.css\";i:432;s:24:\"shortcode/editor-rtl.css\";i:433;s:28:\"shortcode/editor-rtl.min.css\";i:434;s:20:\"shortcode/editor.css\";i:435;s:24:\"shortcode/editor.min.css\";i:436;s:24:\"site-logo/editor-rtl.css\";i:437;s:28:\"site-logo/editor-rtl.min.css\";i:438;s:20:\"site-logo/editor.css\";i:439;s:24:\"site-logo/editor.min.css\";i:440;s:23:\"site-logo/style-rtl.css\";i:441;s:27:\"site-logo/style-rtl.min.css\";i:442;s:19:\"site-logo/style.css\";i:443;s:23:\"site-logo/style.min.css\";i:444;s:27:\"site-tagline/editor-rtl.css\";i:445;s:31:\"site-tagline/editor-rtl.min.css\";i:446;s:23:\"site-tagline/editor.css\";i:447;s:27:\"site-tagline/editor.min.css\";i:448;s:26:\"site-tagline/style-rtl.css\";i:449;s:30:\"site-tagline/style-rtl.min.css\";i:450;s:22:\"site-tagline/style.css\";i:451;s:26:\"site-tagline/style.min.css\";i:452;s:25:\"site-title/editor-rtl.css\";i:453;s:29:\"site-title/editor-rtl.min.css\";i:454;s:21:\"site-title/editor.css\";i:455;s:25:\"site-title/editor.min.css\";i:456;s:24:\"site-title/style-rtl.css\";i:457;s:28:\"site-title/style-rtl.min.css\";i:458;s:20:\"site-title/style.css\";i:459;s:24:\"site-title/style.min.css\";i:460;s:26:\"social-link/editor-rtl.css\";i:461;s:30:\"social-link/editor-rtl.min.css\";i:462;s:22:\"social-link/editor.css\";i:463;s:26:\"social-link/editor.min.css\";i:464;s:27:\"social-links/editor-rtl.css\";i:465;s:31:\"social-links/editor-rtl.min.css\";i:466;s:23:\"social-links/editor.css\";i:467;s:27:\"social-links/editor.min.css\";i:468;s:26:\"social-links/style-rtl.css\";i:469;s:30:\"social-links/style-rtl.min.css\";i:470;s:22:\"social-links/style.css\";i:471;s:26:\"social-links/style.min.css\";i:472;s:21:\"spacer/editor-rtl.css\";i:473;s:25:\"spacer/editor-rtl.min.css\";i:474;s:17:\"spacer/editor.css\";i:475;s:21:\"spacer/editor.min.css\";i:476;s:20:\"spacer/style-rtl.css\";i:477;s:24:\"spacer/style-rtl.min.css\";i:478;s:16:\"spacer/style.css\";i:479;s:20:\"spacer/style.min.css\";i:480;s:20:\"table/editor-rtl.css\";i:481;s:24:\"table/editor-rtl.min.css\";i:482;s:16:\"table/editor.css\";i:483;s:20:\"table/editor.min.css\";i:484;s:19:\"table/style-rtl.css\";i:485;s:23:\"table/style-rtl.min.css\";i:486;s:15:\"table/style.css\";i:487;s:19:\"table/style.min.css\";i:488;s:19:\"table/theme-rtl.css\";i:489;s:23:\"table/theme-rtl.min.css\";i:490;s:15:\"table/theme.css\";i:491;s:19:\"table/theme.min.css\";i:492;s:24:\"tag-cloud/editor-rtl.css\";i:493;s:28:\"tag-cloud/editor-rtl.min.css\";i:494;s:20:\"tag-cloud/editor.css\";i:495;s:24:\"tag-cloud/editor.min.css\";i:496;s:23:\"tag-cloud/style-rtl.css\";i:497;s:27:\"tag-cloud/style-rtl.min.css\";i:498;s:19:\"tag-cloud/style.css\";i:499;s:23:\"tag-cloud/style.min.css\";i:500;s:28:\"template-part/editor-rtl.css\";i:501;s:32:\"template-part/editor-rtl.min.css\";i:502;s:24:\"template-part/editor.css\";i:503;s:28:\"template-part/editor.min.css\";i:504;s:27:\"template-part/theme-rtl.css\";i:505;s:31:\"template-part/theme-rtl.min.css\";i:506;s:23:\"template-part/theme.css\";i:507;s:27:\"template-part/theme.min.css\";i:508;s:30:\"term-description/style-rtl.css\";i:509;s:34:\"term-description/style-rtl.min.css\";i:510;s:26:\"term-description/style.css\";i:511;s:30:\"term-description/style.min.css\";i:512;s:27:\"text-columns/editor-rtl.css\";i:513;s:31:\"text-columns/editor-rtl.min.css\";i:514;s:23:\"text-columns/editor.css\";i:515;s:27:\"text-columns/editor.min.css\";i:516;s:26:\"text-columns/style-rtl.css\";i:517;s:30:\"text-columns/style-rtl.min.css\";i:518;s:22:\"text-columns/style.css\";i:519;s:26:\"text-columns/style.min.css\";i:520;s:19:\"verse/style-rtl.css\";i:521;s:23:\"verse/style-rtl.min.css\";i:522;s:15:\"verse/style.css\";i:523;s:19:\"verse/style.min.css\";i:524;s:20:\"video/editor-rtl.css\";i:525;s:24:\"video/editor-rtl.min.css\";i:526;s:16:\"video/editor.css\";i:527;s:20:\"video/editor.min.css\";i:528;s:19:\"video/style-rtl.css\";i:529;s:23:\"video/style-rtl.min.css\";i:530;s:15:\"video/style.css\";i:531;s:19:\"video/style.min.css\";i:532;s:19:\"video/theme-rtl.css\";i:533;s:23:\"video/theme-rtl.min.css\";i:534;s:15:\"video/theme.css\";i:535;s:19:\"video/theme.min.css\";}}','on');
INSERT INTO `wp_options` VALUES (125,'recovery_keys','a:0:{}','off');
INSERT INTO `wp_options` VALUES (126,'WPLANG','','auto');
INSERT INTO `wp_options` VALUES (127,'_site_transient_update_core','O:8:\"stdClass\":4:{s:7:\"updates\";a:5:{i:0;O:8:\"stdClass\":10:{s:8:\"response\";s:7:\"upgrade\";s:8:\"download\";s:57:\"https://downloads.wordpress.org/release/wordpress-7.1.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:57:\"https://downloads.wordpress.org/release/wordpress-7.1.zip\";s:10:\"no_content\";s:68:\"https://downloads.wordpress.org/release/wordpress-7.1-no-content.zip\";s:11:\"new_bundled\";s:69:\"https://downloads.wordpress.org/release/wordpress-7.1-new-bundled.zip\";s:7:\"partial\";s:0:\"\";s:8:\"rollback\";s:0:\"\";}s:7:\"current\";s:3:\"7.1\";s:7:\"version\";s:3:\"7.1\";s:11:\"php_version\";s:3:\"7.4\";s:13:\"mysql_version\";s:5:\"5.5.5\";s:11:\"new_bundled\";s:3:\"6.7\";s:15:\"partial_version\";s:0:\"\";}i:1;O:8:\"stdClass\":11:{s:8:\"response\";s:10:\"autoupdate\";s:8:\"download\";s:49:\"https://downloads.w.org/release/wordpress-7.1.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:49:\"https://downloads.w.org/release/wordpress-7.1.zip\";s:10:\"no_content\";s:60:\"https://downloads.w.org/release/wordpress-7.1-no-content.zip\";s:11:\"new_bundled\";s:61:\"https://downloads.w.org/release/wordpress-7.1-new-bundled.zip\";s:7:\"partial\";s:0:\"\";s:8:\"rollback\";s:0:\"\";}s:7:\"current\";s:3:\"7.1\";s:7:\"version\";s:3:\"7.1\";s:11:\"php_version\";s:3:\"7.4\";s:13:\"mysql_version\";s:5:\"5.5.5\";s:11:\"new_bundled\";s:3:\"6.7\";s:15:\"partial_version\";s:0:\"\";s:9:\"new_files\";s:1:\"1\";}i:2;O:8:\"stdClass\":11:{s:8:\"response\";s:10:\"autoupdate\";s:8:\"download\";s:51:\"https://downloads.w.org/release/wordpress-7.0.4.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:51:\"https://downloads.w.org/release/wordpress-7.0.4.zip\";s:10:\"no_content\";s:62:\"https://downloads.w.org/release/wordpress-7.0.4-no-content.zip\";s:11:\"new_bundled\";s:63:\"https://downloads.w.org/release/wordpress-7.0.4-new-bundled.zip\";s:7:\"partial\";s:0:\"\";s:8:\"rollback\";s:0:\"\";}s:7:\"current\";s:5:\"7.0.4\";s:7:\"version\";s:5:\"7.0.4\";s:11:\"php_version\";s:3:\"7.4\";s:13:\"mysql_version\";s:5:\"5.5.5\";s:11:\"new_bundled\";s:3:\"6.7\";s:15:\"partial_version\";s:0:\"\";s:9:\"new_files\";s:1:\"1\";}i:3;O:8:\"stdClass\":11:{s:8:\"response\";s:10:\"autoupdate\";s:8:\"download\";s:51:\"https://downloads.w.org/release/wordpress-6.9.7.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:51:\"https://downloads.w.org/release/wordpress-6.9.7.zip\";s:10:\"no_content\";s:62:\"https://downloads.w.org/release/wordpress-6.9.7-no-content.zip\";s:11:\"new_bundled\";s:63:\"https://downloads.w.org/release/wordpress-6.9.7-new-bundled.zip\";s:7:\"partial\";s:0:\"\";s:8:\"rollback\";s:0:\"\";}s:7:\"current\";s:5:\"6.9.7\";s:7:\"version\";s:5:\"6.9.7\";s:11:\"php_version\";s:6:\"7.2.24\";s:13:\"mysql_version\";s:5:\"5.5.5\";s:11:\"new_bundled\";s:3:\"6.7\";s:15:\"partial_version\";s:0:\"\";s:9:\"new_files\";s:1:\"1\";}i:4;O:8:\"stdClass\":11:{s:8:\"response\";s:10:\"autoupdate\";s:8:\"download\";s:51:\"https://downloads.w.org/release/wordpress-6.8.8.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:51:\"https://downloads.w.org/release/wordpress-6.8.8.zip\";s:10:\"no_content\";s:62:\"https://downloads.w.org/release/wordpress-6.8.8-no-content.zip\";s:11:\"new_bundled\";s:63:\"https://downloads.w.org/release/wordpress-6.8.8-new-bundled.zip\";s:7:\"partial\";s:61:\"https://downloads.w.org/release/wordpress-6.8.8-partial-3.zip\";s:8:\"rollback\";s:62:\"https://downloads.w.org/release/wordpress-6.8.8-rollback-3.zip\";}s:7:\"current\";s:5:\"6.8.8\";s:7:\"version\";s:5:\"6.8.8\";s:11:\"php_version\";s:6:\"7.2.24\";s:13:\"mysql_version\";s:5:\"5.5.5\";s:11:\"new_bundled\";s:3:\"6.7\";s:15:\"partial_version\";s:5:\"6.8.3\";s:9:\"new_files\";s:0:\"\";}}s:12:\"last_checked\";i:1789723817;s:15:\"version_checked\";s:5:\"6.8.3\";s:12:\"translations\";a:0:{}}','off');
INSERT INTO `wp_options` VALUES (128,'_site_transient_update_plugins','O:8:\"stdClass\":4:{s:12:\"last_checked\";i:1789723817;s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:0:{}}','off');
INSERT INTO `wp_options` VALUES (135,'can_compress_scripts','0','on');
INSERT INTO `wp_options` VALUES (138,'finished_updating_comment_type','1','auto');
INSERT INTO `wp_options` VALUES (142,'theme_mods_student-survey-lms','a:1:{s:18:\"custom_css_post_id\";i:-1;}','on');
INSERT INTO `wp_options` VALUES (143,'_transient_wp_styles_for_blocks','a:2:{s:4:\"hash\";s:32:\"8c7d46a72d7d4591fc1dd9485bedb304\";s:6:\"blocks\";a:5:{s:11:\"core/button\";s:0:\"\";s:14:\"core/site-logo\";s:0:\"\";s:18:\"core/post-template\";s:120:\":where(.wp-block-post-template.is-layout-flex){gap: 1.25em;}:where(.wp-block-post-template.is-layout-grid){gap: 1.25em;}\";s:12:\"core/columns\";s:102:\":where(.wp-block-columns.is-layout-flex){gap: 2em;}:where(.wp-block-columns.is-layout-grid){gap: 2em;}\";s:14:\"core/pullquote\";s:69:\":root :where(.wp-block-pullquote){font-size: 1.5em;line-height: 1.6;}\";}}','on');
INSERT INTO `wp_options` VALUES (144,'current_theme','Student Survey LMS','auto');
INSERT INTO `wp_options` VALUES (145,'theme_switched','','auto');
INSERT INTO `wp_options` VALUES (146,'theme_switched_via_customizer','','auto');
INSERT INTO `wp_options` VALUES (147,'customize_stashed_theme_mods','a:0:{}','off');
INSERT INTO `wp_options` VALUES (154,'category_children','a:0:{}','auto');
INSERT INTO `wp_options` VALUES (187,'_site_transient_wp_plugin_dependencies_plugin_data','a:0:{}','off');
INSERT INTO `wp_options` VALUES (188,'recently_activated','a:0:{}','off');
INSERT INTO `wp_options` VALUES (206,'sslms_teacher_role_consolidated_v34','1','auto');
INSERT INTO `wp_options` VALUES (222,'_site_transient_timeout_php_check_986ab27a5c44eb5941b7e3b238532f66','1789995143','off');
INSERT INTO `wp_options` VALUES (223,'_site_transient_php_check_986ab27a5c44eb5941b7e3b238532f66','a:5:{s:19:\"recommended_version\";s:3:\"8.3\";s:15:\"minimum_version\";s:3:\"7.4\";s:12:\"is_supported\";b:0;s:9:\"is_secure\";b:1;s:13:\"is_acceptable\";b:1;}','off');
INSERT INTO `wp_options` VALUES (224,'_transient_health-check-site-status-result','{\"good\":14,\"recommended\":5,\"critical\":1}','on');
INSERT INTO `wp_options` VALUES (227,'_site_transient_timeout_browser_751d56298673b4d1962564d60150a0de','1789995157','off');
INSERT INTO `wp_options` VALUES (228,'_site_transient_browser_751d56298673b4d1962564d60150a0de','a:10:{s:4:\"name\";s:6:\"Chrome\";s:7:\"version\";s:9:\"152.0.0.0\";s:8:\"platform\";s:7:\"Windows\";s:10:\"update_url\";s:29:\"https://www.google.com/chrome\";s:7:\"img_src\";s:43:\"http://s.w.org/images/browsers/chrome.png?1\";s:11:\"img_src_ssl\";s:44:\"https://s.w.org/images/browsers/chrome.png?1\";s:15:\"current_version\";s:2:\"18\";s:7:\"upgrade\";b:0;s:8:\"insecure\";b:0;s:6:\"mobile\";b:0;}','off');
INSERT INTO `wp_options` VALUES (397,'_site_transient_timeout_browser_a654d5eda172d96fed0476f4130cfab1','1790169533','off');
INSERT INTO `wp_options` VALUES (398,'_site_transient_browser_a654d5eda172d96fed0476f4130cfab1','a:10:{s:4:\"name\";s:6:\"Chrome\";s:7:\"version\";s:9:\"153.0.0.0\";s:8:\"platform\";s:7:\"Windows\";s:10:\"update_url\";s:29:\"https://www.google.com/chrome\";s:7:\"img_src\";s:43:\"http://s.w.org/images/browsers/chrome.png?1\";s:11:\"img_src_ssl\";s:44:\"https://s.w.org/images/browsers/chrome.png?1\";s:15:\"current_version\";s:2:\"18\";s:7:\"upgrade\";b:0;s:8:\"insecure\";b:0;s:6:\"mobile\";b:0;}','off');
INSERT INTO `wp_options` VALUES (440,'_site_transient_update_themes','O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1789723817;s:7:\"checked\";a:4:{s:18:\"student-survey-lms\";s:5:\"3.8.0\";s:16:\"twentytwentyfive\";s:3:\"1.3\";s:16:\"twentytwentyfour\";s:3:\"1.3\";s:17:\"twentytwentythree\";s:3:\"1.6\";}s:8:\"response\";a:3:{s:16:\"twentytwentyfive\";a:6:{s:5:\"theme\";s:16:\"twentytwentyfive\";s:11:\"new_version\";s:3:\"1.5\";s:3:\"url\";s:46:\"https://wordpress.org/themes/twentytwentyfive/\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/theme/twentytwentyfive.1.5.zip\";s:8:\"requires\";s:3:\"6.7\";s:12:\"requires_php\";s:3:\"7.2\";}s:16:\"twentytwentyfour\";a:6:{s:5:\"theme\";s:16:\"twentytwentyfour\";s:11:\"new_version\";s:3:\"1.6\";s:3:\"url\";s:46:\"https://wordpress.org/themes/twentytwentyfour/\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/theme/twentytwentyfour.1.6.zip\";s:8:\"requires\";s:3:\"6.4\";s:12:\"requires_php\";s:3:\"7.0\";}s:17:\"twentytwentythree\";a:6:{s:5:\"theme\";s:17:\"twentytwentythree\";s:11:\"new_version\";s:3:\"1.7\";s:3:\"url\";s:47:\"https://wordpress.org/themes/twentytwentythree/\";s:7:\"package\";s:63:\"https://downloads.wordpress.org/theme/twentytwentythree.1.7.zip\";s:8:\"requires\";s:3:\"6.1\";s:12:\"requires_php\";s:3:\"5.6\";}}s:9:\"no_update\";a:0:{}s:12:\"translations\";a:0:{}}','off');
INSERT INTO `wp_options` VALUES (447,'_site_transient_timeout_theme_roots','1789725387','off');
INSERT INTO `wp_options` VALUES (448,'_site_transient_theme_roots','a:4:{s:18:\"student-survey-lms\";s:7:\"/themes\";s:16:\"twentytwentyfive\";s:7:\"/themes\";s:16:\"twentytwentyfour\";s:7:\"/themes\";s:17:\"twentytwentythree\";s:7:\"/themes\";}','off');
INSERT INTO `wp_options` VALUES (450,'_transient_timeout_dash_v2_88ae138922fe95674369b1cb3d215a2b','1789767011','off');
INSERT INTO `wp_options` VALUES (451,'_transient_dash_v2_88ae138922fe95674369b1cb3d215a2b','<div class=\"rss-widget\"><p><strong>RSS Error:</strong> WP HTTP Error: A valid URL was not provided.</p></div><div class=\"rss-widget\"><p><strong>RSS Error:</strong> WP HTTP Error: A valid URL was not provided.</p></div>','off');
INSERT INTO `wp_options` VALUES (452,'_site_transient_timeout_community-events-d41d8cd98f00b204e9800998ecf8427e','1789769275','off');
INSERT INTO `wp_options` VALUES (453,'_site_transient_community-events-d41d8cd98f00b204e9800998ecf8427e','a:4:{s:9:\"sandboxed\";b:0;s:5:\"error\";N;s:8:\"location\";a:1:{s:2:\"ip\";b:0;}s:6:\"events\";a:1:{i:0;a:10:{s:4:\"type\";s:8:\"wordcamp\";s:5:\"title\";s:15:\"WordCamp Europe\";s:3:\"url\";s:33:\"https://europe.wordcamp.org/2027/\";s:6:\"meetup\";s:0:\"\";s:10:\"meetup_url\";s:0:\"\";s:4:\"date\";s:19:\"2027-05-27 00:00:00\";s:8:\"end_date\";s:19:\"2027-05-29 00:00:00\";s:20:\"start_unix_timestamp\";i:1811368800;s:18:\"end_unix_timestamp\";i:1811541600;s:8:\"location\";a:4:{s:8:\"location\";s:7:\"Málaga\";s:7:\"country\";s:2:\"ES\";s:8:\"latitude\";d:36.720131000000002;s:9:\"longitude\";d:-4.4754379999999996;}}}}','off');
INSERT INTO `wp_options` VALUES (454,'_site_transient_timeout_wp_theme_files_patterns-31c94ca12cde79ac5a1bb0304dd8551a','1789727861','off');
INSERT INTO `wp_options` VALUES (455,'_site_transient_wp_theme_files_patterns-31c94ca12cde79ac5a1bb0304dd8551a','a:2:{s:7:\"version\";s:5:\"3.8.0\";s:8:\"patterns\";a:0:{}}','off');
/*!40000 ALTER TABLE `wp_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_postmeta`
--

DROP TABLE IF EXISTS `wp_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_postmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=625 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_postmeta`
--

LOCK TABLES `wp_postmeta` WRITE;
/*!40000 ALTER TABLE `wp_postmeta` DISABLE KEYS */;
INSERT INTO `wp_postmeta` VALUES (1,2,'_wp_page_template','default');
INSERT INTO `wp_postmeta` VALUES (2,3,'_wp_page_template','default');
INSERT INTO `wp_postmeta` VALUES (5,6,'_wp_trash_meta_status','publish');
INSERT INTO `wp_postmeta` VALUES (6,6,'_wp_trash_meta_time','1789029030');
INSERT INTO `wp_postmeta` VALUES (53,19,'_menu_item_type','custom');
INSERT INTO `wp_postmeta` VALUES (54,19,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (55,19,'_menu_item_object_id','19');
INSERT INTO `wp_postmeta` VALUES (56,19,'_menu_item_object','custom');
INSERT INTO `wp_postmeta` VALUES (57,19,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (58,19,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (59,19,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (60,19,'_menu_item_url','http://mkb-student-app-v20.local/');
INSERT INTO `wp_postmeta` VALUES (61,19,'_menu_item_orphaned','1789055992');
INSERT INTO `wp_postmeta` VALUES (62,20,'_menu_item_type','post_type');
INSERT INTO `wp_postmeta` VALUES (63,20,'_menu_item_menu_item_parent','0');
INSERT INTO `wp_postmeta` VALUES (64,20,'_menu_item_object_id','2');
INSERT INTO `wp_postmeta` VALUES (65,20,'_menu_item_object','page');
INSERT INTO `wp_postmeta` VALUES (66,20,'_menu_item_target','');
INSERT INTO `wp_postmeta` VALUES (67,20,'_menu_item_classes','a:1:{i:0;s:0:\"\";}');
INSERT INTO `wp_postmeta` VALUES (68,20,'_menu_item_xfn','');
INSERT INTO `wp_postmeta` VALUES (69,20,'_menu_item_url','');
INSERT INTO `wp_postmeta` VALUES (70,20,'_menu_item_orphaned','1789055992');
INSERT INTO `wp_postmeta` VALUES (75,23,'_wp_page_template','page-my-feedback.php');
INSERT INTO `wp_postmeta` VALUES (83,26,'_wp_attached_file','2026/09/Image-aout-3.jpg');
INSERT INTO `wp_postmeta` VALUES (84,26,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:1920;s:6:\"height\";i:1080;s:4:\"file\";s:24:\"2026/09/Image-aout-3.jpg\";s:8:\"filesize\";i:445986;s:5:\"sizes\";a:5:{s:6:\"medium\";a:5:{s:4:\"file\";s:24:\"Image-aout-3-300x169.jpg\";s:5:\"width\";i:300;s:6:\"height\";i:169;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:21745;}s:5:\"large\";a:5:{s:4:\"file\";s:25:\"Image-aout-3-1024x576.jpg\";s:5:\"width\";i:1024;s:6:\"height\";i:576;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:125731;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:24:\"Image-aout-3-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:12176;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:24:\"Image-aout-3-768x432.jpg\";s:5:\"width\";i:768;s:6:\"height\";i:432;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:81963;}s:9:\"1536x1536\";a:5:{s:4:\"file\";s:25:\"Image-aout-3-1536x864.jpg\";s:5:\"width\";i:1536;s:6:\"height\";i:864;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:222222;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (85,26,'_wp_attachment_image_alt','Lephare Building');
INSERT INTO `wp_postmeta` VALUES (92,28,'_wp_attached_file','2026/09/WhatsApp-Image-2026-08-27-at-16.52.18.jpeg');
INSERT INTO `wp_postmeta` VALUES (93,28,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:938;s:6:\"height\";i:585;s:4:\"file\";s:50:\"2026/09/WhatsApp-Image-2026-08-27-at-16.52.18.jpeg\";s:8:\"filesize\";i:87354;s:5:\"sizes\";a:3:{s:6:\"medium\";a:5:{s:4:\"file\";s:50:\"WhatsApp-Image-2026-08-27-at-16.52.18-300x187.jpeg\";s:5:\"width\";i:300;s:6:\"height\";i:187;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:14906;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:50:\"WhatsApp-Image-2026-08-27-at-16.52.18-150x150.jpeg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:6659;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:50:\"WhatsApp-Image-2026-08-27-at-16.52.18-768x479.jpeg\";s:5:\"width\";i:768;s:6:\"height\";i:479;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:71849;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (94,28,'_wp_attachment_image_alt','Bukavu view');
INSERT INTO `wp_postmeta` VALUES (112,32,'_wp_attached_file','2026/09/WhatsApp-Image-2026-08-27-at-16.52.26.jpeg');
INSERT INTO `wp_postmeta` VALUES (113,32,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:2560;s:6:\"height\";i:1400;s:4:\"file\";s:50:\"2026/09/WhatsApp-Image-2026-08-27-at-16.52.26.jpeg\";s:8:\"filesize\";i:597523;s:5:\"sizes\";a:6:{s:6:\"medium\";a:5:{s:4:\"file\";s:50:\"WhatsApp-Image-2026-08-27-at-16.52.26-300x164.jpeg\";s:5:\"width\";i:300;s:6:\"height\";i:164;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:14250;}s:5:\"large\";a:5:{s:4:\"file\";s:51:\"WhatsApp-Image-2026-08-27-at-16.52.26-1024x560.jpeg\";s:5:\"width\";i:1024;s:6:\"height\";i:560;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:138675;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:50:\"WhatsApp-Image-2026-08-27-at-16.52.26-150x150.jpeg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:6885;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:50:\"WhatsApp-Image-2026-08-27-at-16.52.26-768x420.jpeg\";s:5:\"width\";i:768;s:6:\"height\";i:420;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:82229;}s:9:\"1536x1536\";a:5:{s:4:\"file\";s:51:\"WhatsApp-Image-2026-08-27-at-16.52.26-1536x840.jpeg\";s:5:\"width\";i:1536;s:6:\"height\";i:840;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:290467;}s:9:\"2048x2048\";a:5:{s:4:\"file\";s:52:\"WhatsApp-Image-2026-08-27-at-16.52.26-2048x1120.jpeg\";s:5:\"width\";i:2048;s:6:\"height\";i:1120;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:468760;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (114,32,'_wp_attachment_image_alt','Kadutu view');
INSERT INTO `wp_postmeta` VALUES (150,45,'_wp_page_template','page-all-surveys.php');
INSERT INTO `wp_postmeta` VALUES (151,46,'_wp_page_template','page-student-dashboard.php');
INSERT INTO `wp_postmeta` VALUES (152,47,'_wp_page_template','page-my-surveys.php');
INSERT INTO `wp_postmeta` VALUES (153,49,'_wp_page_template','page-student-profile.php');
INSERT INTO `wp_postmeta` VALUES (154,54,'_wp_attached_file','2026/09/Photos-dine-9-scaled.jpg');
INSERT INTO `wp_postmeta` VALUES (155,54,'_wp_attachment_metadata','a:7:{s:5:\"width\";i:2560;s:6:\"height\";i:1707;s:4:\"file\";s:32:\"2026/09/Photos-dine-9-scaled.jpg\";s:8:\"filesize\";i:615060;s:5:\"sizes\";a:6:{s:6:\"medium\";a:5:{s:4:\"file\";s:25:\"Photos-dine-9-300x200.jpg\";s:5:\"width\";i:300;s:6:\"height\";i:200;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:35935;}s:5:\"large\";a:5:{s:4:\"file\";s:26:\"Photos-dine-9-1024x683.jpg\";s:5:\"width\";i:1024;s:6:\"height\";i:683;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:157806;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:25:\"Photos-dine-9-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:24481;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:25:\"Photos-dine-9-768x512.jpg\";s:5:\"width\";i:768;s:6:\"height\";i:512;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:106989;}s:9:\"1536x1536\";a:5:{s:4:\"file\";s:27:\"Photos-dine-9-1536x1024.jpg\";s:5:\"width\";i:1536;s:6:\"height\";i:1024;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:280187;}s:9:\"2048x2048\";a:5:{s:4:\"file\";s:27:\"Photos-dine-9-2048x1365.jpg\";s:5:\"width\";i:2048;s:6:\"height\";i:1365;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:430889;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:3:\"4.5\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:18:\"Canon EOS REBEL T5\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:10:\"1727542675\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:2:\"32\";s:3:\"iso\";s:3:\"400\";s:13:\"shutter_speed\";s:4:\"0.02\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}s:14:\"original_image\";s:17:\"Photos-dine-9.jpg\";}');
INSERT INTO `wp_postmeta` VALUES (162,57,'_wp_attached_file','2026/09/images.png');
INSERT INTO `wp_postmeta` VALUES (163,57,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:554;s:6:\"height\";i:554;s:4:\"file\";s:18:\"2026/09/images.png\";s:8:\"filesize\";i:11580;s:5:\"sizes\";a:2:{s:6:\"medium\";a:5:{s:4:\"file\";s:18:\"images-300x300.png\";s:5:\"width\";i:300;s:6:\"height\";i:300;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:4662;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:18:\"images-150x150.png\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:2158;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (171,45,'_edit_lock','1789404738:1');
INSERT INTO `wp_postmeta` VALUES (201,65,'_wp_page_template','page-instructor-dashboard.php');
INSERT INTO `wp_postmeta` VALUES (202,66,'_wp_page_template','page-instructor-profile.php');
INSERT INTO `wp_postmeta` VALUES (223,73,'_wp_page_template','page-about.php');
INSERT INTO `wp_postmeta` VALUES (287,75,'_wp_attached_file','2026/09/Capture_2025-12-22-11-49-25.png');
INSERT INTO `wp_postmeta` VALUES (288,75,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:605;s:6:\"height\";i:557;s:4:\"file\";s:39:\"2026/09/Capture_2025-12-22-11-49-25.png\";s:8:\"filesize\";i:166820;s:5:\"sizes\";a:2:{s:6:\"medium\";a:5:{s:4:\"file\";s:39:\"Capture_2025-12-22-11-49-25-300x276.png\";s:5:\"width\";i:300;s:6:\"height\";i:276;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:33826;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:39:\"Capture_2025-12-22-11-49-25-150x150.png\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:10975;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (289,76,'_wp_attached_file','2026/09/Capture_2025-12-22-11-49-25-1.png');
INSERT INTO `wp_postmeta` VALUES (290,76,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:605;s:6:\"height\";i:557;s:4:\"file\";s:41:\"2026/09/Capture_2025-12-22-11-49-25-1.png\";s:8:\"filesize\";i:166820;s:5:\"sizes\";a:2:{s:6:\"medium\";a:5:{s:4:\"file\";s:41:\"Capture_2025-12-22-11-49-25-1-300x276.png\";s:5:\"width\";i:300;s:6:\"height\";i:276;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:33826;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:41:\"Capture_2025-12-22-11-49-25-1-150x150.png\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:10975;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (291,77,'_wp_attached_file','2026/09/Capture_2025-12-22-11-49-25-2.png');
INSERT INTO `wp_postmeta` VALUES (292,77,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:605;s:6:\"height\";i:557;s:4:\"file\";s:41:\"2026/09/Capture_2025-12-22-11-49-25-2.png\";s:8:\"filesize\";i:166820;s:5:\"sizes\";a:2:{s:6:\"medium\";a:5:{s:4:\"file\";s:41:\"Capture_2025-12-22-11-49-25-2-300x276.png\";s:5:\"width\";i:300;s:6:\"height\";i:276;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:33826;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:41:\"Capture_2025-12-22-11-49-25-2-150x150.png\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:10975;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (293,78,'_survey_description','Objectif du survey');
INSERT INTO `wp_postmeta` VALUES (294,78,'_survey_class','Cohorte 2');
INSERT INTO `wp_postmeta` VALUES (295,78,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (296,78,'_survey_end_date','2026-10-15');
INSERT INTO `wp_postmeta` VALUES (297,79,'_question_parent_survey','78');
INSERT INTO `wp_postmeta` VALUES (298,79,'_question_type','multiple_choice');
INSERT INTO `wp_postmeta` VALUES (299,79,'_question_answer_options','A. Gérer la logique métier, les données et les requêtes serveur \r\nB. Modifier uniquement les couleurs \r\nC. Créer des images  \r\nD. Gérer uniquement le HTML');
INSERT INTO `wp_postmeta` VALUES (300,80,'_question_parent_survey','78');
INSERT INTO `wp_postmeta` VALUES (301,80,'_question_type','multiple_choice');
INSERT INTO `wp_postmeta` VALUES (302,80,'_question_answer_options','A. Un système permettant à des applications de communiquer via des requêtes HTTP  \r\nB. Un langage CSS  \r\nC. Un logiciel de design  \r\nD. Un type de base de données');
INSERT INTO `wp_postmeta` VALUES (303,81,'_survey_description','Answer these questions');
INSERT INTO `wp_postmeta` VALUES (304,81,'_survey_class','Cohorte 2');
INSERT INTO `wp_postmeta` VALUES (305,81,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (306,81,'_survey_end_date','2026-10-15');
INSERT INTO `wp_postmeta` VALUES (307,82,'_question_parent_survey','81');
INSERT INTO `wp_postmeta` VALUES (308,82,'_question_type','multiple_choice');
INSERT INTO `wp_postmeta` VALUES (309,82,'_question_answer_options','A. GET  \r\nB. DELETE  \r\nC. POST  \r\nD. PATCH');
INSERT INTO `wp_postmeta` VALUES (310,83,'_survey_description','Answer this question');
INSERT INTO `wp_postmeta` VALUES (311,83,'_survey_class','Cohorte 2');
INSERT INTO `wp_postmeta` VALUES (312,83,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (313,83,'_survey_end_date','2026-10-15');
INSERT INTO `wp_postmeta` VALUES (314,84,'_question_parent_survey','83');
INSERT INTO `wp_postmeta` VALUES (315,84,'_question_type','multiple_choice');
INSERT INTO `wp_postmeta` VALUES (316,84,'_question_answer_options','A. Pour améliorer la vitesse du site  \r\nB. Pour éviter de stocker les mots de passe en claire  \r\nC. Pour réduire la taille des images  \r\nD. Pour améliorer le design');
INSERT INTO `wp_postmeta` VALUES (317,85,'_survey_description','Check the right answer');
INSERT INTO `wp_postmeta` VALUES (318,85,'_survey_class','Cohorte 2');
INSERT INTO `wp_postmeta` VALUES (319,85,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (320,85,'_survey_end_date','2026-10-15');
INSERT INTO `wp_postmeta` VALUES (321,86,'_question_parent_survey','85');
INSERT INTO `wp_postmeta` VALUES (322,86,'_question_type','multiple_choice');
INSERT INTO `wp_postmeta` VALUES (323,86,'_question_answer_options','A. La couleur du bouton  \r\nB. La requête API, les logs serveur et la connexion à la base de données  \r\nC. Le logo  \r\nD. La police utilisée');
INSERT INTO `wp_postmeta` VALUES (324,87,'_survey_description','Tell us more about you');
INSERT INTO `wp_postmeta` VALUES (325,87,'_survey_class','Cohorte 2');
INSERT INTO `wp_postmeta` VALUES (326,87,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (327,87,'_survey_end_date','2026-10-15');
INSERT INTO `wp_postmeta` VALUES (328,88,'_question_parent_survey','87');
INSERT INTO `wp_postmeta` VALUES (329,88,'_question_type','text');
INSERT INTO `wp_postmeta` VALUES (330,88,'_question_answer_options','');
INSERT INTO `wp_postmeta` VALUES (331,89,'_survey_description','Answer these question');
INSERT INTO `wp_postmeta` VALUES (332,89,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (333,89,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (334,89,'_survey_end_date','2026-10-15');
INSERT INTO `wp_postmeta` VALUES (335,90,'_question_parent_survey','89');
INSERT INTO `wp_postmeta` VALUES (336,90,'_question_type','multiple_choice');
INSERT INTO `wp_postmeta` VALUES (337,90,'_question_answer_options','A. Amazon S3  \r\nB. Amazon RDS  \r\nC. Amazon DynamoDB uniquement  \r\nD. Amazon SES');
INSERT INTO `wp_postmeta` VALUES (338,90,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (339,91,'_question_parent_survey','89');
INSERT INTO `wp_postmeta` VALUES (340,91,'_question_type','true_false');
INSERT INTO `wp_postmeta` VALUES (341,91,'_question_answer_options','');
INSERT INTO `wp_postmeta` VALUES (342,91,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (343,92,'_survey_description','Tell us about you deployment process');
INSERT INTO `wp_postmeta` VALUES (344,92,'_survey_class','Cohorte 1');
INSERT INTO `wp_postmeta` VALUES (345,92,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (346,92,'_survey_end_date','2026-10-15');
INSERT INTO `wp_postmeta` VALUES (347,93,'_question_parent_survey','92');
INSERT INTO `wp_postmeta` VALUES (348,93,'_question_type','multiple_choice');
INSERT INTO `wp_postmeta` VALUES (349,93,'_question_answer_options','A. Route 53 · \r\nB. EC2 · \r\nC. S3 · \r\nD. Lambda');
INSERT INTO `wp_postmeta` VALUES (350,94,'_survey_description','what do you know about EC2');
INSERT INTO `wp_postmeta` VALUES (351,94,'_survey_class','Cohorte 1');
INSERT INTO `wp_postmeta` VALUES (352,94,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (353,94,'_survey_end_date','2026-10-15');
INSERT INTO `wp_postmeta` VALUES (354,95,'_question_parent_survey','94');
INSERT INTO `wp_postmeta` VALUES (355,95,'_question_type','radio_button');
INSERT INTO `wp_postmeta` VALUES (356,95,'_question_answer_options','A. Fournir des serveurs virtuels dans le cloud  \r\nB. Stocker uniquement des images  \r\nC. Gérer les noms de domaine  \r\nD. Envoyer uniquement des emails');
INSERT INTO `wp_postmeta` VALUES (357,96,'_survey_description','Check the right answer');
INSERT INTO `wp_postmeta` VALUES (358,96,'_survey_class','Cohorte 1');
INSERT INTO `wp_postmeta` VALUES (359,96,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (360,96,'_survey_end_date','2026-10-15');
INSERT INTO `wp_postmeta` VALUES (361,97,'_question_parent_survey','96');
INSERT INTO `wp_postmeta` VALUES (362,97,'_question_type','checkbox');
INSERT INTO `wp_postmeta` VALUES (363,97,'_question_answer_options','A. Un problème de permissions ou de configuration d\'accès  \r\nB. Une mauvaise couleur CSS  \r\nC. Une image trop grande  \r\nD. Un problème de JavaScript uniquement');
INSERT INTO `wp_postmeta` VALUES (364,97,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (365,98,'_survey_description','Write you answer below');
INSERT INTO `wp_postmeta` VALUES (366,98,'_survey_class','Cohorte 1');
INSERT INTO `wp_postmeta` VALUES (367,98,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (368,98,'_survey_end_date','2026-10-15');
INSERT INTO `wp_postmeta` VALUES (369,99,'_question_parent_survey','98');
INSERT INTO `wp_postmeta` VALUES (370,99,'_question_type','text');
INSERT INTO `wp_postmeta` VALUES (371,99,'_question_answer_options','A. Tester l\'application, vérifier les variables d\'environnement, les permissions et les logs  \r\nB. Donner toutes les permissions à tout le monde  \r\nC. Supprimer les logs  \r\nD. Utiliser les mêmes identifiants pour tous les utilisateurs');
INSERT INTO `wp_postmeta` VALUES (372,100,'_survey_description','Objectif : évaluer les bases en HTML, CSS, JavaScript et responsive design.');
INSERT INTO `wp_postmeta` VALUES (373,100,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (374,100,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (375,100,'_survey_end_date','2026-11-15');
INSERT INTO `wp_postmeta` VALUES (376,101,'_question_parent_survey','100');
INSERT INTO `wp_postmeta` VALUES (377,101,'_question_type','radio_button');
INSERT INTO `wp_postmeta` VALUES (378,101,'_question_answer_options','A. CSS  \r\nB. HTML  \r\nC. JavaScript  \r\nD. PHP');
INSERT INTO `wp_postmeta` VALUES (379,102,'_survey_description','tell us about you dev');
INSERT INTO `wp_postmeta` VALUES (380,102,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (381,102,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (382,102,'_survey_end_date','2026-11-15');
INSERT INTO `wp_postmeta` VALUES (383,103,'_question_parent_survey','102');
INSERT INTO `wp_postmeta` VALUES (384,103,'_question_type','text');
INSERT INTO `wp_postmeta` VALUES (385,103,'_question_answer_options','');
INSERT INTO `wp_postmeta` VALUES (386,103,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (387,104,'_survey_description','Answer this question');
INSERT INTO `wp_postmeta` VALUES (388,104,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (389,104,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (390,104,'_survey_end_date','2026-11-15');
INSERT INTO `wp_postmeta` VALUES (391,105,'_question_parent_survey','104');
INSERT INTO `wp_postmeta` VALUES (392,105,'_question_type','checkbox');
INSERT INTO `wp_postmeta` VALUES (393,105,'_question_answer_options','A. display  \r\nB. position  \r\nC. Media Queries  \r\nD. float');
INSERT INTO `wp_postmeta` VALUES (394,105,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (395,106,'_survey_description','Check your answer');
INSERT INTO `wp_postmeta` VALUES (396,106,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (397,106,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (398,106,'_survey_end_date','2026-11-15');
INSERT INTO `wp_postmeta` VALUES (399,107,'_question_parent_survey','106');
INSERT INTO `wp_postmeta` VALUES (400,107,'_question_type','radio_button');
INSERT INTO `wp_postmeta` VALUES (401,107,'_question_answer_options','A. id est généralement unique, class peut être réutilisée \r\nB. Ils sont identiques \r\nC. class est toujours unique  \r\nD. id fonctionne uniquement en CSS');
INSERT INTO `wp_postmeta` VALUES (402,107,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (403,108,'_survey_description','Objectif : évaluer les bases en HTML, CSS, JavaScript et responsive design.');
INSERT INTO `wp_postmeta` VALUES (404,108,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (405,108,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (406,108,'_survey_end_date','2026-11-15');
INSERT INTO `wp_postmeta` VALUES (407,109,'_question_parent_survey','108');
INSERT INTO `wp_postmeta` VALUES (408,109,'_question_type','checkbox');
INSERT INTO `wp_postmeta` VALUES (409,109,'_question_answer_options','A. Ajouter de l’interactivité et du comportement dynamique \r\nB. Créer uniquement la structure HTML \r\nC. Héberger un site \r\nD. Remplacer un serveur AWS');
INSERT INTO `wp_postmeta` VALUES (410,110,'_survey_description','answer the question');
INSERT INTO `wp_postmeta` VALUES (411,110,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (412,110,'_survey_start_date','2026-09-15');
INSERT INTO `wp_postmeta` VALUES (413,110,'_survey_end_date','2026-11-15');
INSERT INTO `wp_postmeta` VALUES (414,111,'_question_parent_survey','110');
INSERT INTO `wp_postmeta` VALUES (415,111,'_question_type','checkbox');
INSERT INTO `wp_postmeta` VALUES (416,111,'_question_answer_options','A. Supprimer le bouton  \r\nB. Vérifier la console du navigateur et le code JavaScript associé  \r\nC. Réinstaller Windows  \r\nD. Modifier le serveur AWS');
INSERT INTO `wp_postmeta` VALUES (417,111,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (418,112,'_wp_attached_file','2026/09/logo-lighthouses.png');
INSERT INTO `wp_postmeta` VALUES (419,112,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:860;s:6:\"height\";i:533;s:4:\"file\";s:28:\"2026/09/logo-lighthouses.png\";s:8:\"filesize\";i:205339;s:5:\"sizes\";a:3:{s:6:\"medium\";a:5:{s:4:\"file\";s:28:\"logo-lighthouses-300x186.png\";s:5:\"width\";i:300;s:6:\"height\";i:186;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:14283;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:28:\"logo-lighthouses-150x150.png\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:10324;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:28:\"logo-lighthouses-768x476.png\";s:5:\"width\";i:768;s:6:\"height\";i:476;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:161783;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (420,110,'_edit_lock','1789564773:1');
INSERT INTO `wp_postmeta` VALUES (421,73,'_survey_description','');
INSERT INTO `wp_postmeta` VALUES (422,73,'_survey_start_date','2026-09-18');
INSERT INTO `wp_postmeta` VALUES (423,73,'_survey_end_date','2026-09-20');
INSERT INTO `wp_postmeta` VALUES (424,73,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (425,45,'_survey_description','');
INSERT INTO `wp_postmeta` VALUES (426,45,'_survey_start_date','2026-09-18');
INSERT INTO `wp_postmeta` VALUES (427,45,'_survey_end_date','2026-09-20');
INSERT INTO `wp_postmeta` VALUES (428,45,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (429,46,'_survey_description','');
INSERT INTO `wp_postmeta` VALUES (430,46,'_survey_start_date','2026-09-18');
INSERT INTO `wp_postmeta` VALUES (431,46,'_survey_end_date','2026-09-20');
INSERT INTO `wp_postmeta` VALUES (432,46,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (433,47,'_survey_description','');
INSERT INTO `wp_postmeta` VALUES (434,47,'_survey_start_date','2026-09-18');
INSERT INTO `wp_postmeta` VALUES (435,47,'_survey_end_date','2026-09-20');
INSERT INTO `wp_postmeta` VALUES (436,47,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (437,23,'_survey_description','');
INSERT INTO `wp_postmeta` VALUES (438,23,'_survey_start_date','2026-09-18');
INSERT INTO `wp_postmeta` VALUES (439,23,'_survey_end_date','2026-09-20');
INSERT INTO `wp_postmeta` VALUES (440,23,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (441,49,'_survey_description','');
INSERT INTO `wp_postmeta` VALUES (442,49,'_survey_start_date','2026-09-18');
INSERT INTO `wp_postmeta` VALUES (443,49,'_survey_end_date','2026-09-20');
INSERT INTO `wp_postmeta` VALUES (444,49,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (445,65,'_survey_description','');
INSERT INTO `wp_postmeta` VALUES (446,65,'_survey_start_date','2026-09-18');
INSERT INTO `wp_postmeta` VALUES (447,65,'_survey_end_date','2026-09-20');
INSERT INTO `wp_postmeta` VALUES (448,65,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (449,66,'_survey_description','');
INSERT INTO `wp_postmeta` VALUES (450,66,'_survey_start_date','2026-09-18');
INSERT INTO `wp_postmeta` VALUES (451,66,'_survey_end_date','2026-09-20');
INSERT INTO `wp_postmeta` VALUES (452,66,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (453,110,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (454,110,'_thumbnail_id','26');
INSERT INTO `wp_postmeta` VALUES (455,108,'_edit_lock','1789564789:1');
INSERT INTO `wp_postmeta` VALUES (456,108,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (457,108,'_thumbnail_id','28');
INSERT INTO `wp_postmeta` VALUES (458,113,'_response_survey_id','102');
INSERT INTO `wp_postmeta` VALUES (459,113,'_response_student_id','2');
INSERT INTO `wp_postmeta` VALUES (460,113,'_response_answers','a:1:{i:103;s:181:\"There is a friend of mine who interested me to this and i started without knowing that here is were it could bring me today i\'m very thankfull to God the Almighty and to my friend y\";}');
INSERT INTO `wp_postmeta` VALUES (461,114,'_response_survey_id','87');
INSERT INTO `wp_postmeta` VALUES (462,114,'_response_student_id','2');
INSERT INTO `wp_postmeta` VALUES (463,114,'_response_answers','a:1:{i:88;s:20:\"Java Script et Mysql\";}');
INSERT INTO `wp_postmeta` VALUES (464,106,'_edit_lock','1789566004:1');
INSERT INTO `wp_postmeta` VALUES (465,106,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (466,106,'_thumbnail_id','32');
INSERT INTO `wp_postmeta` VALUES (467,104,'_edit_lock','1789566059:1');
INSERT INTO `wp_postmeta` VALUES (468,115,'_wp_attached_file','2026/09/localisation.png');
INSERT INTO `wp_postmeta` VALUES (469,115,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:900;s:6:\"height\";i:980;s:4:\"file\";s:24:\"2026/09/localisation.png\";s:8:\"filesize\";i:10218;s:5:\"sizes\";a:3:{s:6:\"medium\";a:5:{s:4:\"file\";s:24:\"localisation-276x300.png\";s:5:\"width\";i:276;s:6:\"height\";i:300;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:7790;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:24:\"localisation-150x150.png\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:2767;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:24:\"localisation-768x836.png\";s:5:\"width\";i:768;s:6:\"height\";i:836;s:9:\"mime-type\";s:9:\"image/png\";s:8:\"filesize\";i:22057;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (470,104,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (471,104,'_thumbnail_id','115');
INSERT INTO `wp_postmeta` VALUES (472,102,'_edit_lock','1789566101:1');
INSERT INTO `wp_postmeta` VALUES (473,116,'_wp_attached_file','2026/09/Photos-dine-9-1-scaled.jpg');
INSERT INTO `wp_postmeta` VALUES (474,116,'_wp_attachment_metadata','a:7:{s:5:\"width\";i:2560;s:6:\"height\";i:1707;s:4:\"file\";s:34:\"2026/09/Photos-dine-9-1-scaled.jpg\";s:8:\"filesize\";i:615060;s:5:\"sizes\";a:6:{s:6:\"medium\";a:5:{s:4:\"file\";s:27:\"Photos-dine-9-1-300x200.jpg\";s:5:\"width\";i:300;s:6:\"height\";i:200;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:35935;}s:5:\"large\";a:5:{s:4:\"file\";s:28:\"Photos-dine-9-1-1024x683.jpg\";s:5:\"width\";i:1024;s:6:\"height\";i:683;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:157806;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:27:\"Photos-dine-9-1-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:24481;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:27:\"Photos-dine-9-1-768x512.jpg\";s:5:\"width\";i:768;s:6:\"height\";i:512;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:106989;}s:9:\"1536x1536\";a:5:{s:4:\"file\";s:29:\"Photos-dine-9-1-1536x1024.jpg\";s:5:\"width\";i:1536;s:6:\"height\";i:1024;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:280187;}s:9:\"2048x2048\";a:5:{s:4:\"file\";s:29:\"Photos-dine-9-1-2048x1365.jpg\";s:5:\"width\";i:2048;s:6:\"height\";i:1365;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:430889;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:3:\"4.5\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:18:\"Canon EOS REBEL T5\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:10:\"1727542675\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:2:\"32\";s:3:\"iso\";s:3:\"400\";s:13:\"shutter_speed\";s:4:\"0.02\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}s:14:\"original_image\";s:19:\"Photos-dine-9-1.jpg\";}');
INSERT INTO `wp_postmeta` VALUES (475,102,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (476,102,'_thumbnail_id','116');
INSERT INTO `wp_postmeta` VALUES (477,100,'_edit_lock','1789566255:1');
INSERT INTO `wp_postmeta` VALUES (478,117,'_wp_attached_file','2026/09/Photos-dine-8-scaled.jpg');
INSERT INTO `wp_postmeta` VALUES (479,117,'_wp_attachment_metadata','a:7:{s:5:\"width\";i:2560;s:6:\"height\";i:1707;s:4:\"file\";s:32:\"2026/09/Photos-dine-8-scaled.jpg\";s:8:\"filesize\";i:631068;s:5:\"sizes\";a:6:{s:6:\"medium\";a:5:{s:4:\"file\";s:25:\"Photos-dine-8-300x200.jpg\";s:5:\"width\";i:300;s:6:\"height\";i:200;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:34455;}s:5:\"large\";a:5:{s:4:\"file\";s:26:\"Photos-dine-8-1024x683.jpg\";s:5:\"width\";i:1024;s:6:\"height\";i:683;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:153891;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:25:\"Photos-dine-8-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:23205;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:25:\"Photos-dine-8-768x512.jpg\";s:5:\"width\";i:768;s:6:\"height\";i:512;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:102858;}s:9:\"1536x1536\";a:5:{s:4:\"file\";s:27:\"Photos-dine-8-1536x1024.jpg\";s:5:\"width\";i:1536;s:6:\"height\";i:1024;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:278622;}s:9:\"2048x2048\";a:5:{s:4:\"file\";s:27:\"Photos-dine-8-2048x1365.jpg\";s:5:\"width\";i:2048;s:6:\"height\";i:1365;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:437891;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:3:\"4.5\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:18:\"Canon EOS REBEL T5\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:10:\"1727542656\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:2:\"32\";s:3:\"iso\";s:3:\"400\";s:13:\"shutter_speed\";s:4:\"0.02\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}s:14:\"original_image\";s:17:\"Photos-dine-8.jpg\";}');
INSERT INTO `wp_postmeta` VALUES (480,118,'_wp_attached_file','2026/09/Photos-dine-92-scaled.jpg');
INSERT INTO `wp_postmeta` VALUES (481,118,'_wp_attachment_metadata','a:7:{s:5:\"width\";i:2560;s:6:\"height\";i:1707;s:4:\"file\";s:33:\"2026/09/Photos-dine-92-scaled.jpg\";s:8:\"filesize\";i:749273;s:5:\"sizes\";a:6:{s:6:\"medium\";a:5:{s:4:\"file\";s:26:\"Photos-dine-92-300x200.jpg\";s:5:\"width\";i:300;s:6:\"height\";i:200;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:37169;}s:5:\"large\";a:5:{s:4:\"file\";s:27:\"Photos-dine-92-1024x683.jpg\";s:5:\"width\";i:1024;s:6:\"height\";i:683;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:180241;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:26:\"Photos-dine-92-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:24186;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:26:\"Photos-dine-92-768x512.jpg\";s:5:\"width\";i:768;s:6:\"height\";i:512;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:119066;}s:9:\"1536x1536\";a:5:{s:4:\"file\";s:28:\"Photos-dine-92-1536x1024.jpg\";s:5:\"width\";i:1536;s:6:\"height\";i:1024;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:328567;}s:9:\"2048x2048\";a:5:{s:4:\"file\";s:28:\"Photos-dine-92-2048x1365.jpg\";s:5:\"width\";i:2048;s:6:\"height\";i:1365;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:517177;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"4\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:18:\"Canon EOS REBEL T5\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:10:\"1727548100\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:2:\"18\";s:3:\"iso\";s:3:\"800\";s:13:\"shutter_speed\";s:4:\"0.02\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}s:14:\"original_image\";s:18:\"Photos-dine-92.jpg\";}');
INSERT INTO `wp_postmeta` VALUES (482,100,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (483,100,'_thumbnail_id','118');
INSERT INTO `wp_postmeta` VALUES (484,98,'_edit_lock','1789566293:1');
INSERT INTO `wp_postmeta` VALUES (485,119,'_wp_attached_file','2026/09/Photos-dine-5-scaled.jpg');
INSERT INTO `wp_postmeta` VALUES (486,119,'_wp_attachment_metadata','a:7:{s:5:\"width\";i:2560;s:6:\"height\";i:1707;s:4:\"file\";s:32:\"2026/09/Photos-dine-5-scaled.jpg\";s:8:\"filesize\";i:662483;s:5:\"sizes\";a:6:{s:6:\"medium\";a:5:{s:4:\"file\";s:25:\"Photos-dine-5-300x200.jpg\";s:5:\"width\";i:300;s:6:\"height\";i:200;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:35120;}s:5:\"large\";a:5:{s:4:\"file\";s:26:\"Photos-dine-5-1024x683.jpg\";s:5:\"width\";i:1024;s:6:\"height\";i:683;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:164068;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:25:\"Photos-dine-5-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:23804;}s:12:\"medium_large\";a:5:{s:4:\"file\";s:25:\"Photos-dine-5-768x512.jpg\";s:5:\"width\";i:768;s:6:\"height\";i:512;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:108148;}s:9:\"1536x1536\";a:5:{s:4:\"file\";s:27:\"Photos-dine-5-1536x1024.jpg\";s:5:\"width\";i:1536;s:6:\"height\";i:1024;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:299543;}s:9:\"2048x2048\";a:5:{s:4:\"file\";s:27:\"Photos-dine-5-2048x1365.jpg\";s:5:\"width\";i:2048;s:6:\"height\";i:1365;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:465985;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:3:\"3.5\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:18:\"Canon EOS REBEL T5\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:10:\"1727542508\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:2:\"18\";s:3:\"iso\";s:3:\"400\";s:13:\"shutter_speed\";s:4:\"0.02\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}s:14:\"original_image\";s:17:\"Photos-dine-5.jpg\";}');
INSERT INTO `wp_postmeta` VALUES (487,98,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (488,98,'_thumbnail_id','119');
INSERT INTO `wp_postmeta` VALUES (489,111,'_edit_lock','1789567409:1');
INSERT INTO `wp_postmeta` VALUES (490,73,'_question_parent_survey','131');
INSERT INTO `wp_postmeta` VALUES (491,73,'_question_type','true_false');
INSERT INTO `wp_postmeta` VALUES (492,73,'_question_answer_options','a developpers needs  computers to work very good');
INSERT INTO `wp_postmeta` VALUES (494,45,'_question_parent_survey','131');
INSERT INTO `wp_postmeta` VALUES (495,45,'_question_type','true_false');
INSERT INTO `wp_postmeta` VALUES (496,45,'_question_answer_options','a developpers needs  computers to work very good');
INSERT INTO `wp_postmeta` VALUES (498,46,'_question_parent_survey','131');
INSERT INTO `wp_postmeta` VALUES (499,46,'_question_type','true_false');
INSERT INTO `wp_postmeta` VALUES (500,46,'_question_answer_options','a developpers needs  computers to work very good');
INSERT INTO `wp_postmeta` VALUES (502,47,'_question_parent_survey','131');
INSERT INTO `wp_postmeta` VALUES (503,47,'_question_type','true_false');
INSERT INTO `wp_postmeta` VALUES (504,47,'_question_answer_options','a developpers needs  computers to work very good');
INSERT INTO `wp_postmeta` VALUES (506,23,'_question_parent_survey','131');
INSERT INTO `wp_postmeta` VALUES (507,23,'_question_type','true_false');
INSERT INTO `wp_postmeta` VALUES (508,23,'_question_answer_options','a developpers needs  computers to work very good');
INSERT INTO `wp_postmeta` VALUES (510,49,'_question_parent_survey','131');
INSERT INTO `wp_postmeta` VALUES (511,49,'_question_type','true_false');
INSERT INTO `wp_postmeta` VALUES (512,49,'_question_answer_options','a developpers needs  computers to work very good');
INSERT INTO `wp_postmeta` VALUES (514,65,'_question_parent_survey','131');
INSERT INTO `wp_postmeta` VALUES (515,65,'_question_type','true_false');
INSERT INTO `wp_postmeta` VALUES (516,65,'_question_answer_options','a developpers needs  computers to work very good');
INSERT INTO `wp_postmeta` VALUES (518,66,'_question_parent_survey','131');
INSERT INTO `wp_postmeta` VALUES (519,66,'_question_type','true_false');
INSERT INTO `wp_postmeta` VALUES (520,66,'_question_answer_options','a developpers needs  computers to work very good');
INSERT INTO `wp_postmeta` VALUES (522,111,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (523,109,'_edit_lock','1789566954:1');
INSERT INTO `wp_postmeta` VALUES (524,109,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (525,109,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (526,107,'_edit_lock','1789566977:1');
INSERT INTO `wp_postmeta` VALUES (527,107,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (528,105,'_edit_lock','1789567493:1');
INSERT INTO `wp_postmeta` VALUES (529,105,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (530,103,'_edit_lock','1789567035:1');
INSERT INTO `wp_postmeta` VALUES (531,101,'_edit_lock','1789567502:1');
INSERT INTO `wp_postmeta` VALUES (532,101,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (533,101,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (534,99,'_edit_lock','1789567511:1');
INSERT INTO `wp_postmeta` VALUES (535,99,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (536,99,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (537,79,'_edit_lock','1789567124:1');
INSERT INTO `wp_postmeta` VALUES (538,79,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (539,79,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (540,80,'_edit_lock','1789567159:1');
INSERT INTO `wp_postmeta` VALUES (541,80,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (550,80,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (551,82,'_edit_lock','1789567219:1');
INSERT INTO `wp_postmeta` VALUES (552,82,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (553,82,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (554,84,'_edit_lock','1789567271:1');
INSERT INTO `wp_postmeta` VALUES (555,84,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (556,86,'_edit_lock','1789567574:1');
INSERT INTO `wp_postmeta` VALUES (557,73,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (558,45,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (559,46,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (560,47,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (561,23,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (562,49,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (563,65,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (564,66,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (565,86,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (566,86,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (567,88,'_edit_lock','1789567329:1');
INSERT INTO `wp_postmeta` VALUES (568,90,'_edit_lock','1789567552:1');
INSERT INTO `wp_postmeta` VALUES (569,90,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (570,91,'_edit_lock','1789567541:1');
INSERT INTO `wp_postmeta` VALUES (571,93,'_edit_lock','1789567532:1');
INSERT INTO `wp_postmeta` VALUES (572,93,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (573,93,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (574,97,'_edit_lock','1789567522:1');
INSERT INTO `wp_postmeta` VALUES (575,97,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (576,95,'_edit_lock','1789567482:1');
INSERT INTO `wp_postmeta` VALUES (577,95,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (578,95,'_question_required','1');
INSERT INTO `wp_postmeta` VALUES (579,120,'_question_parent_survey','78');
INSERT INTO `wp_postmeta` VALUES (580,120,'_question_type','multiple_choice');
INSERT INTO `wp_postmeta` VALUES (581,120,'_question_answer_options','A. Oui');
INSERT INTO `wp_postmeta` VALUES (582,114,'_response_feedback','Humm very good hope we gonna do more...');
INSERT INTO `wp_postmeta` VALUES (583,121,'_response_survey_id','85');
INSERT INTO `wp_postmeta` VALUES (584,121,'_response_student_id','2');
INSERT INTO `wp_postmeta` VALUES (585,121,'_response_answers','a:1:{i:86;a:1:{i:0;s:75:\"B. La requête API, les logs serveur et la connexion à la base de données\";}}');
INSERT INTO `wp_postmeta` VALUES (586,122,'_response_survey_id','83');
INSERT INTO `wp_postmeta` VALUES (587,122,'_response_student_id','2');
INSERT INTO `wp_postmeta` VALUES (588,122,'_response_answers','a:1:{i:84;a:1:{i:0;s:54:\"B. Pour éviter de stocker les mots de passe en claire\";}}');
INSERT INTO `wp_postmeta` VALUES (589,123,'_response_survey_id','81');
INSERT INTO `wp_postmeta` VALUES (590,123,'_response_student_id','2');
INSERT INTO `wp_postmeta` VALUES (591,123,'_response_answers','a:1:{i:82;a:1:{i:0;s:6:\"A. GET\";}}');
INSERT INTO `wp_postmeta` VALUES (592,124,'_response_survey_id','78');
INSERT INTO `wp_postmeta` VALUES (593,124,'_response_student_id','2');
INSERT INTO `wp_postmeta` VALUES (594,124,'_response_answers','a:3:{i:79;a:1:{i:0;s:67:\"A. Gérer la logique métier, les données et les requêtes serveur\";}i:80;a:1:{i:0;s:83:\"A. Un système permettant à des applications de communiquer via des requêtes HTTP\";}i:120;a:1:{i:0;s:6:\"A. Oui\";}}');
INSERT INTO `wp_postmeta` VALUES (595,125,'_response_survey_id','110');
INSERT INTO `wp_postmeta` VALUES (596,125,'_response_student_id','2');
INSERT INTO `wp_postmeta` VALUES (597,125,'_response_answers','a:1:{i:111;a:1:{i:0;s:68:\"B. Vérifier la console du navigateur et le code JavaScript associé\";}}');
INSERT INTO `wp_postmeta` VALUES (598,126,'_response_survey_id','108');
INSERT INTO `wp_postmeta` VALUES (599,126,'_response_student_id','2');
INSERT INTO `wp_postmeta` VALUES (600,126,'_response_answers','a:1:{i:109;a:1:{i:0;s:61:\"A. Ajouter de l’interactivité et du comportement dynamique\";}}');
INSERT INTO `wp_postmeta` VALUES (601,127,'_response_survey_id','106');
INSERT INTO `wp_postmeta` VALUES (602,127,'_response_student_id','2');
INSERT INTO `wp_postmeta` VALUES (603,127,'_response_answers','a:1:{i:107;s:62:\"A. id est généralement unique, class peut être réutilisée\";}');
INSERT INTO `wp_postmeta` VALUES (604,128,'_response_survey_id','100');
INSERT INTO `wp_postmeta` VALUES (605,128,'_response_student_id','2');
INSERT INTO `wp_postmeta` VALUES (606,128,'_response_answers','a:1:{i:101;s:7:\"B. HTML\";}');
INSERT INTO `wp_postmeta` VALUES (607,128,'_response_feedback','Bonne reponse curieux de savoir votre niveau dans le Html');
INSERT INTO `wp_postmeta` VALUES (608,113,'_response_feedback','Very good of your friend whish i\'could have friend like yours');
INSERT INTO `wp_postmeta` VALUES (609,127,'_response_feedback','Je ne suis tres sure de votre reponse mais pour l\'instant j\'accepte');
INSERT INTO `wp_postmeta` VALUES (610,125,'_response_feedback','Tres bonne reponse ...');
INSERT INTO `wp_postmeta` VALUES (611,129,'_wp_attached_file','2026/09/istockphoto-1211348683-170667a.jpg');
INSERT INTO `wp_postmeta` VALUES (612,129,'_wp_attachment_metadata','a:6:{s:5:\"width\";i:359;s:6:\"height\";i:479;s:4:\"file\";s:42:\"2026/09/istockphoto-1211348683-170667a.jpg\";s:8:\"filesize\";i:39717;s:5:\"sizes\";a:2:{s:6:\"medium\";a:5:{s:4:\"file\";s:42:\"istockphoto-1211348683-170667a-225x300.jpg\";s:5:\"width\";i:225;s:6:\"height\";i:300;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:13129;}s:9:\"thumbnail\";a:5:{s:4:\"file\";s:42:\"istockphoto-1211348683-170667a-150x150.jpg\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:10:\"image/jpeg\";s:8:\"filesize\";i:9273;}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:12:\"Getty Images\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:90:\"Golden stamp with ribbons isolated on white background. Luxury seal. Vector design element\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}');
INSERT INTO `wp_postmeta` VALUES (613,131,'_edit_lock','1789724083:1');
INSERT INTO `wp_postmeta` VALUES (614,131,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (615,131,'_survey_description','');
INSERT INTO `wp_postmeta` VALUES (616,131,'_survey_start_date','2026-09-18');
INSERT INTO `wp_postmeta` VALUES (617,131,'_survey_end_date','2026-09-20');
INSERT INTO `wp_postmeta` VALUES (618,131,'_survey_class','Cohorte 3');
INSERT INTO `wp_postmeta` VALUES (619,132,'_edit_lock','1789724333:1');
INSERT INTO `wp_postmeta` VALUES (620,132,'_edit_last','1');
INSERT INTO `wp_postmeta` VALUES (621,132,'_question_parent_survey','131');
INSERT INTO `wp_postmeta` VALUES (622,132,'_question_type','true_false');
INSERT INTO `wp_postmeta` VALUES (623,132,'_question_answer_options','a developpers needs  computers to work very good');
INSERT INTO `wp_postmeta` VALUES (624,132,'_question_required','1');
/*!40000 ALTER TABLE `wp_postmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_posts` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_posts`
--

LOCK TABLES `wp_posts` WRITE;
/*!40000 ALTER TABLE `wp_posts` DISABLE KEYS */;
INSERT INTO `wp_posts` VALUES (1,1,'2026-09-10 08:26:58','2026-09-10 08:26:58','<!-- wp:paragraph -->\n<p>Welcome to WordPress. This is your first post. Edit or delete it, then start writing!</p>\n<!-- /wp:paragraph -->','Hello world!','','publish','open','open','','hello-world','','','2026-09-10 08:26:58','2026-09-10 08:26:58','',0,'http://mkb-student-app-v20.local/?p=1',0,'post','',1);
INSERT INTO `wp_posts` VALUES (2,1,'2026-09-10 08:26:58','2026-09-10 08:26:58','<!-- wp:paragraph -->\n<p>This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my website. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>...or something like this:</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:quote -->\n<blockquote class=\"wp-block-quote\"><p>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</p></blockquote>\n<!-- /wp:quote -->\n\n<!-- wp:paragraph -->\n<p>As a new WordPress user, you should go to <a href=\"http://mkb-student-app-v20.local/wp-admin/\">your dashboard</a> to delete this page and create new pages for your content. Have fun!</p>\n<!-- /wp:paragraph -->','Sample Page','','publish','closed','open','','sample-page','','','2026-09-10 08:26:58','2026-09-10 08:26:58','',0,'http://mkb-student-app-v20.local/?page_id=2',0,'page','',0);
INSERT INTO `wp_posts` VALUES (3,1,'2026-09-10 08:26:58','2026-09-10 08:26:58','<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Who we are</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Our website address is: http://mkb-student-app-v20.local.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Comments</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>When visitors leave comments on the site we collect the data shown in the comments form, and also the visitor&#8217;s IP address and browser user agent string to help spam detection.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>An anonymized string created from your email address (also called a hash) may be provided to the Gravatar service to see if you are using it. The Gravatar service privacy policy is available here: https://automattic.com/privacy/. After approval of your comment, your profile picture is visible to the public in the context of your comment.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Media</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you upload images to the website, you should avoid uploading images with embedded location data (EXIF GPS) included. Visitors to the website can download and extract any location data from images on the website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Cookies</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment on our site you may opt-in to saving your name, email address and website in cookies. These are for your convenience so that you do not have to fill in your details again when you leave another comment. These cookies will last for one year.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>If you visit our login page, we will set a temporary cookie to determine if your browser accepts cookies. This cookie contains no personal data and is discarded when you close your browser.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>When you log in, we will also set up several cookies to save your login information and your screen display choices. Login cookies last for two days, and screen options cookies last for a year. If you select &quot;Remember Me&quot;, your login will persist for two weeks. If you log out of your account, the login cookies will be removed.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>If you edit or publish an article, an additional cookie will be saved in your browser. This cookie includes no personal data and simply indicates the post ID of the article you just edited. It expires after 1 day.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Embedded content from other websites</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Articles on this site may include embedded content (e.g. videos, images, articles, etc.). Embedded content from other websites behaves in the exact same way as if the visitor has visited the other website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>These websites may collect data about you, use cookies, embed additional third-party tracking, and monitor your interaction with that embedded content, including tracking your interaction with the embedded content if you have an account and are logged in to that website.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Who we share your data with</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you request a password reset, your IP address will be included in the reset email.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">How long we retain your data</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you leave a comment, the comment and its metadata are retained indefinitely. This is so we can recognize and approve any follow-up comments automatically instead of holding them in a moderation queue.</p>\n<!-- /wp:paragraph -->\n<!-- wp:paragraph -->\n<p>For users that register on our website (if any), we also store the personal information they provide in their user profile. All users can see, edit, or delete their personal information at any time (except they cannot change their username). Website administrators can also see and edit that information.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">What rights you have over your data</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>If you have an account on this site, or have left comments, you can request to receive an exported file of the personal data we hold about you, including any data you have provided to us. You can also request that we erase any personal data we hold about you. This does not include any data we are obliged to keep for administrative, legal, or security purposes.</p>\n<!-- /wp:paragraph -->\n<!-- wp:heading -->\n<h2 class=\"wp-block-heading\">Where your data is sent</h2>\n<!-- /wp:heading -->\n<!-- wp:paragraph -->\n<p><strong class=\"privacy-policy-tutorial\">Suggested text: </strong>Visitor comments may be checked through an automated spam detection service.</p>\n<!-- /wp:paragraph -->\n','Privacy Policy','','draft','closed','open','','privacy-policy','','','2026-09-10 08:26:58','2026-09-10 08:26:58','',0,'http://mkb-student-app-v20.local/?page_id=3',0,'page','',0);
INSERT INTO `wp_posts` VALUES (6,1,'2026-09-10 08:30:30','2026-09-10 08:30:30','{\n    \"blogdescription\": {\n        \"value\": \"This is the version 2.0 of our student App\",\n        \"type\": \"option\",\n        \"user_id\": 1,\n        \"date_modified_gmt\": \"2026-09-10 08:30:30\"\n    }\n}','','','trash','closed','closed','','ea0259c1-f300-4449-8a99-c974e0bd47a3','','','2026-09-10 08:30:30','2026-09-10 08:30:30','',0,'http://mkb-student-app-v20.local/ea0259c1-f300-4449-8a99-c974e0bd47a3/',0,'customize_changeset','',0);
INSERT INTO `wp_posts` VALUES (19,1,'2026-09-10 15:59:52','0000-00-00 00:00:00','','Home','','draft','closed','closed','','','','','2026-09-10 15:59:52','0000-00-00 00:00:00','',0,'http://mkb-student-app-v20.local/?p=19',1,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (20,1,'2026-09-10 15:59:52','0000-00-00 00:00:00',' ','','','draft','closed','closed','','','','','2026-09-10 15:59:52','0000-00-00 00:00:00','',0,'http://mkb-student-app-v20.local/?p=20',1,'nav_menu_item','',0);
INSERT INTO `wp_posts` VALUES (23,1,'2026-09-14 12:54:46','2026-09-14 12:54:46','','My Feedback','','publish','closed','closed','','my-feedback','','','2026-09-18 10:24:39','2026-09-18 10:24:39','',0,'http://mkb-student-app-v20.local/my-feedback/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (26,3,'2026-09-14 13:07:56','2026-09-14 13:07:56','Lephare Building','Image aout 3','','inherit','open','closed','','image-aout-3','','','2026-09-14 13:08:36','2026-09-14 13:08:36','',0,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/Image-aout-3.jpg',0,'attachment','image/jpeg',0);
INSERT INTO `wp_posts` VALUES (28,3,'2026-09-14 13:11:06','2026-09-14 13:11:06','Bukavu twon','WhatsApp Image 2026-08-27 at 16.52.18','','inherit','open','closed','','whatsapp-image-2026-08-27-at-16-52-18','','','2026-09-14 13:11:59','2026-09-14 13:11:59','',0,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/WhatsApp-Image-2026-08-27-at-16.52.18.jpeg',0,'attachment','image/jpeg',0);
INSERT INTO `wp_posts` VALUES (32,1,'2026-09-14 13:16:58','2026-09-14 13:16:58','Karta','WhatsApp Image 2026-08-27 at 16.52.26','','inherit','open','closed','','whatsapp-image-2026-08-27-at-16-52-26','','','2026-09-14 13:17:21','2026-09-14 13:17:21','',0,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/WhatsApp-Image-2026-08-27-at-16.52.26.jpeg',0,'attachment','image/jpeg',0);
INSERT INTO `wp_posts` VALUES (44,4,'2026-09-14 15:42:25','0000-00-00 00:00:00','','Auto Draft','','auto-draft','open','open','','','','','2026-09-14 15:42:25','0000-00-00 00:00:00','',0,'http://mkb-student-app-v20.local/?p=44',0,'post','',0);
INSERT INTO `wp_posts` VALUES (45,2,'2026-09-14 16:15:40','2026-09-14 16:15:40','','Surveys','','publish','closed','closed','','survey','','','2026-09-18 10:24:39','2026-09-18 10:24:39','',0,'http://mkb-student-app-v20.local/survey/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (46,2,'2026-09-14 16:15:40','2026-09-14 16:15:40','','Student Dashboard','','publish','closed','closed','','student-dashboard','','','2026-09-18 10:24:39','2026-09-18 10:24:39','',0,'http://mkb-student-app-v20.local/student-dashboard/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (47,2,'2026-09-14 16:15:40','2026-09-14 16:15:40','','My Answers','','publish','closed','closed','','my-completed-surveys','','','2026-09-18 10:24:39','2026-09-18 10:24:39','',0,'http://mkb-student-app-v20.local/my-completed-surveys/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (48,2,'2026-09-14 16:15:40','2026-09-14 16:15:40','','My Feedback','','inherit','closed','closed','','23-revision-v1','','','2026-09-14 16:15:40','2026-09-14 16:15:40','',23,'http://mkb-student-app-v20.local/?p=48',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (49,2,'2026-09-14 16:15:40','2026-09-14 16:15:40','','Student Profile','','publish','closed','closed','','student-profile','','','2026-09-18 10:24:39','2026-09-18 10:24:39','',0,'http://mkb-student-app-v20.local/student-profile/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (50,0,'2026-09-14 16:15:40','2026-09-14 16:15:40','','Surveys','','inherit','closed','closed','','45-revision-v1','','','2026-09-14 16:15:40','2026-09-14 16:15:40','',45,'http://mkb-student-app-v20.local/?p=50',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (51,0,'2026-09-14 16:15:40','2026-09-14 16:15:40','','Student Dashboard','','inherit','closed','closed','','46-revision-v1','','','2026-09-14 16:15:40','2026-09-14 16:15:40','',46,'http://mkb-student-app-v20.local/?p=51',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (52,0,'2026-09-14 16:15:40','2026-09-14 16:15:40','','My Answers','','inherit','closed','closed','','47-revision-v1','','','2026-09-14 16:15:40','2026-09-14 16:15:40','',47,'http://mkb-student-app-v20.local/?p=52',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (53,0,'2026-09-14 16:15:40','2026-09-14 16:15:40','','Student Profile','','inherit','closed','closed','','49-revision-v1','','','2026-09-14 16:15:40','2026-09-14 16:15:40','',49,'http://mkb-student-app-v20.local/?p=53',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (54,2,'2026-09-14 16:26:33','2026-09-14 16:26:33','','Photos diné-9','','inherit','open','closed','','photos-dine-9','','','2026-09-14 16:26:33','2026-09-14 16:26:33','',0,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/Photos-dine-9.jpg',0,'attachment','image/jpeg',0);
INSERT INTO `wp_posts` VALUES (57,5,'2026-09-14 16:36:16','2026-09-14 16:36:16','','images','','inherit','open','closed','','images','','','2026-09-14 16:36:16','2026-09-14 16:36:16','',0,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/images.png',0,'attachment','image/png',0);
INSERT INTO `wp_posts` VALUES (65,4,'2026-09-15 07:32:24','2026-09-15 07:32:24','','Instructor Dashboard','','publish','closed','closed','','instructor-dashboard','','','2026-09-18 10:24:39','2026-09-18 10:24:39','',0,'http://mkb-student-app-v20.local/instructor-dashboard/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (66,4,'2026-09-15 07:32:24','2026-09-15 07:32:24','','Instructor Profile','','publish','closed','closed','','instructor-profile','','','2026-09-18 10:24:39','2026-09-18 10:24:39','',0,'http://mkb-student-app-v20.local/instructor-profile/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (67,0,'2026-09-15 07:32:24','2026-09-15 07:32:24','','Instructor Dashboard','','inherit','closed','closed','','65-revision-v1','','','2026-09-15 07:32:24','2026-09-15 07:32:24','',65,'http://mkb-student-app-v20.local/?p=67',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (68,0,'2026-09-15 07:32:24','2026-09-15 07:32:24','','Instructor Profile','','inherit','closed','closed','','66-revision-v1','','','2026-09-15 07:32:24','2026-09-15 07:32:24','',66,'http://mkb-student-app-v20.local/?p=68',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (73,3,'2026-09-15 10:23:42','2026-09-15 10:23:42','','About','','publish','closed','closed','','about','','','2026-09-18 10:24:39','2026-09-18 10:24:39','',0,'http://mkb-student-app-v20.local/about/',0,'page','',0);
INSERT INTO `wp_posts` VALUES (74,3,'2026-09-15 10:23:44','2026-09-15 10:23:44','','About','','inherit','closed','closed','','73-revision-v1','','','2026-09-15 10:23:44','2026-09-15 10:23:44','',73,'http://mkb-student-app-v20.local/?p=74',0,'revision','',0);
INSERT INTO `wp_posts` VALUES (75,7,'2026-09-15 11:34:54','2026-09-15 11:34:54','','Capture+_2025-12-22-11-49-25','','inherit','open','closed','','capture_2025-12-22-11-49-25','','','2026-09-15 11:34:54','2026-09-15 11:34:54','',0,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/Capture_2025-12-22-11-49-25.png',0,'attachment','image/png',0);
INSERT INTO `wp_posts` VALUES (76,4,'2026-09-15 11:38:10','2026-09-15 11:38:10','','Capture+_2025-12-22-11-49-25','','inherit','open','closed','','capture_2025-12-22-11-49-25-2','','','2026-09-15 11:38:10','2026-09-15 11:38:10','',0,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/Capture_2025-12-22-11-49-25-1.png',0,'attachment','image/png',0);
INSERT INTO `wp_posts` VALUES (77,3,'2026-09-15 11:40:06','2026-09-15 11:40:06','','Capture+_2025-12-22-11-49-25','','inherit','open','closed','','capture_2025-12-22-11-49-25-3','','','2026-09-15 11:40:06','2026-09-15 11:40:06','',0,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/Capture_2025-12-22-11-49-25-2.png',0,'attachment','image/png',0);
INSERT INTO `wp_posts` VALUES (78,3,'2026-09-15 12:10:04','2026-09-15 12:10:04','Tester les connaissances sur les serveurs, API, bases de données et authentification.','Survey Back-End Development','','publish','closed','closed','','survey-back-end-development','','','2026-09-15 12:10:04','2026-09-15 12:10:04','',0,'http://mkb-student-app-v20.local/survey/survey-back-end-development/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (79,3,'2026-09-15 12:12:54','2026-09-15 12:12:54','','Quel est le rôle principal du back-end dans une application web ?','','publish','closed','closed','','quel-est-le-role-principal-du-back-end-dans-une-application-web','','','2026-09-16 14:01:07','2026-09-16 14:01:07','',0,'http://mkb-student-app-v20.local/question/quel-est-le-role-principal-du-back-end-dans-une-application-web/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (80,3,'2026-09-15 12:14:08','2026-09-15 12:14:08','','Qu\'est-ce qu\'une API REST ?','','publish','closed','closed','','quest-ce-quune-api-rest','','','2026-09-16 14:01:42','2026-09-16 14:01:42','',0,'http://mkb-student-app-v20.local/question/quest-ce-quune-api-rest/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (81,3,'2026-09-15 12:15:48','2026-09-15 12:15:48','Tester les connaissances sur les serveurs, API, bases de données et authentification.','Survey Back-End','','publish','closed','closed','','survey-back-end','','','2026-09-15 12:17:22','2026-09-15 12:17:22','',0,'http://mkb-student-app-v20.local/survey/survey-back-end/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (82,3,'2026-09-15 12:16:24','2026-09-15 12:16:24','','Quelle méthode HTTP est généralement utilisée pour créer une nouvelle ressource ?','','publish','closed','closed','','quelle-methode-http-est-generalement-utilisee-pour-creer-une-nouvelle-ressource','','','2026-09-16 14:02:12','2026-09-16 14:02:12','',0,'http://mkb-student-app-v20.local/question/quelle-methode-http-est-generalement-utilisee-pour-creer-une-nouvelle-ressource/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (83,3,'2026-09-15 12:20:18','2026-09-15 12:20:18','Check The right answer','Back-End dev.','','publish','closed','closed','','back-end-dev','','','2026-09-15 12:20:18','2026-09-15 12:20:18','',0,'http://mkb-student-app-v20.local/survey/back-end-dev/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (84,3,'2026-09-15 12:20:41','2026-09-15 12:20:41','','Pourquoi faut-il hacher les mots de passe avant de les stocker dans une base de données ?','','publish','closed','closed','','pourquoi-faut-il-hacher-les-mots-de-passe-avant-de-les-stocker-dans-une-base-de-donnees','','','2026-09-16 14:03:34','2026-09-16 14:03:34','',0,'http://mkb-student-app-v20.local/question/pourquoi-faut-il-hacher-les-mots-de-passe-avant-de-les-stocker-dans-une-base-de-donnees/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (85,3,'2026-09-15 12:22:43','2026-09-15 12:22:43','Think before checking once submitted you can\'t edit','Back end developpement','','publish','closed','closed','','back-end-developpement','','','2026-09-15 12:22:43','2026-09-15 12:22:43','',0,'http://mkb-student-app-v20.local/survey/back-end-developpement/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (86,3,'2026-09-15 12:23:15','2026-09-15 12:23:15','','Une application affiche une erreur lorsqu’elle essaie de récupérer les données des étudiants. Quelle partie devriez-vous vérifier en premier ?','','publish','closed','closed','','une-application-affiche-une-erreur-lorsquelle-essaie-de-recuperer-les-donnees-des-etudiants-quelle-partie-devriez-vous-verifier-en-premier','','','2026-09-16 14:04:11','2026-09-16 14:04:11','',0,'http://mkb-student-app-v20.local/question/une-application-affiche-une-erreur-lorsquelle-essaie-de-recuperer-les-donnees-des-etudiants-quelle-partie-devriez-vous-verifier-en-premier/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (87,3,'2026-09-15 12:26:25','2026-09-15 12:26:25','We want you to be honest','Tell us about your Back-End developement','','publish','closed','closed','','tell-us-about-your-back-end-developement','','','2026-09-15 12:26:25','2026-09-15 12:26:25','',0,'http://mkb-student-app-v20.local/survey/tell-us-about-your-back-end-developement/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (88,3,'2026-09-15 12:27:55','2026-09-15 12:27:55','','Quel sont les language du Back end que vous avez utilise?','','publish','closed','closed','','quel-sont-les-language-du-back-end-que-vous-avez-utilise','','','2026-09-15 12:27:55','2026-09-15 12:27:55','',0,'http://mkb-student-app-v20.local/question/quel-sont-les-language-du-back-end-que-vous-avez-utilise/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (89,7,'2026-09-15 12:36:26','2026-09-15 12:36:26','Check the right answer','Survey : AWS Deployment','','publish','closed','closed','','survey-aws-deployment','','','2026-09-15 12:36:26','2026-09-15 12:36:26','',0,'http://mkb-student-app-v20.local/survey/survey-aws-deployment/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (90,7,'2026-09-15 12:36:53','2026-09-15 12:36:53','','Quel service AWS peut être utilisé pour héberger un site web statique composé de HTML, CSS et JavaScript ?','','publish','closed','closed','','quel-service-aws-peut-etre-utilise-pour-heberger-un-site-web-statique-compose-de-html-css-et-javascript','','','2026-09-16 14:05:05','2026-09-16 14:05:05','',0,'http://mkb-student-app-v20.local/question/quel-service-aws-peut-etre-utilise-pour-heberger-un-site-web-statique-compose-de-html-css-et-javascript/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (91,7,'2026-09-15 12:37:39','2026-09-15 12:37:39','','Do you have any skill in AWS?','','publish','closed','closed','','do-you-have-any-skill-in-aws','','','2026-09-15 12:37:39','2026-09-15 12:37:39','',0,'http://mkb-student-app-v20.local/question/do-you-have-any-skill-in-aws/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (92,7,'2026-09-15 12:39:00','2026-09-15 12:39:00','Check the right answer','AWS Domain and host','','publish','closed','closed','','aws-domain-and-host','','','2026-09-15 12:39:00','2026-09-15 12:39:00','',0,'http://mkb-student-app-v20.local/survey/aws-domain-and-host/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (93,7,'2026-09-15 12:39:42','2026-09-15 12:39:42','','Quel service AWS permet de gérer les noms de domaine et les enregistrements DNS ?','','publish','closed','closed','','quel-service-aws-permet-de-gerer-les-noms-de-domaine-et-les-enregistrements-dns','','','2026-09-16 14:05:42','2026-09-16 14:05:42','',0,'http://mkb-student-app-v20.local/question/quel-service-aws-permet-de-gerer-les-noms-de-domaine-et-les-enregistrements-dns/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (94,7,'2026-09-15 12:42:04','2026-09-15 12:42:04','Check you right answer','Quelle est la fonction principale d\'Amazon EC2 ?','','publish','closed','closed','','quelle-est-la-fonction-principale-damazon-ec2','','','2026-09-15 12:42:04','2026-09-15 12:42:04','',0,'http://mkb-student-app-v20.local/survey/quelle-est-la-fonction-principale-damazon-ec2/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (95,7,'2026-09-15 12:43:07','2026-09-15 12:43:07','','Quelle est la fonction principale d\'Amazon EC2 ?','','publish','closed','closed','','quelle-est-la-fonction-principale-damazon-ec2','','','2026-09-16 14:07:02','2026-09-16 14:07:02','',0,'http://mkb-student-app-v20.local/question/quelle-est-la-fonction-principale-damazon-ec2/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (96,7,'2026-09-15 12:44:22','2026-09-15 12:44:22','Answer the question','AWS subject','','publish','closed','closed','','aws-subject','','','2026-09-15 12:44:22','2026-09-15 12:44:22','',0,'http://mkb-student-app-v20.local/survey/aws-subject/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (97,7,'2026-09-15 12:44:47','2026-09-15 12:44:47','','Après avoir déployé un site, l\'URL affiche une erreur 403 AccessDenied. Quelle pourrait être la cause ?','','publish','closed','closed','','apres-avoir-deploye-un-site-lurl-affiche-une-erreur-403-accessdenied-quelle-pourrait-etre-la-cause','','','2026-09-16 14:06:30','2026-09-16 14:06:30','',0,'http://mkb-student-app-v20.local/question/apres-avoir-deploye-un-site-lurl-affiche-une-erreur-403-accessdenied-quelle-pourrait-etre-la-cause/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (98,7,'2026-09-15 12:46:03','2026-09-15 12:46:03','','Mettre une application en production sur AWS','','publish','closed','closed','','quelle-est-une-bonne-pratique-avant-de-mettre-une-application-en-production-sur-aws','','','2026-09-16 13:47:15','2026-09-16 13:47:15','',0,'http://mkb-student-app-v20.local/survey/quelle-est-une-bonne-pratique-avant-de-mettre-une-application-en-production-sur-aws/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (99,7,'2026-09-15 12:46:27','2026-09-15 12:46:27','','Quelle est une bonne pratique avant de mettre une application en production sur AWS ?','','publish','closed','closed','','quelle-est-une-bonne-pratique-avant-de-mettre-une-application-en-production-sur-aws','','','2026-09-16 14:00:36','2026-09-16 14:00:36','',0,'http://mkb-student-app-v20.local/question/quelle-est-une-bonne-pratique-avant-de-mettre-une-application-en-production-sur-aws/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (100,4,'2026-09-15 12:49:32','2026-09-15 12:49:32','Check the right answer','Survey : Front-End Development','','publish','closed','closed','','survey-front-end-development','','','2026-09-16 13:46:29','2026-09-16 13:46:29','',0,'http://mkb-student-app-v20.local/survey/survey-front-end-development/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (101,4,'2026-09-15 12:49:55','2026-09-15 12:49:55','','Quel langage est principalement utilisé pour structurer le contenu d’une page web ?','','publish','closed','closed','','quel-langage-est-principalement-utilise-pour-structurer-le-contenu-dune-page-web','','','2026-09-16 14:00:04','2026-09-16 14:00:04','',0,'http://mkb-student-app-v20.local/question/quel-langage-est-principalement-utilise-pour-structurer-le-contenu-dune-page-web/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (102,4,'2026-09-15 12:50:42','2026-09-15 12:50:42','Writ your answer here','Front -End dev','','publish','closed','closed','','front-end-dev','','','2026-09-16 13:44:03','2026-09-16 13:44:03','',0,'http://mkb-student-app-v20.local/survey/front-end-dev/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (103,4,'2026-09-15 12:51:11','2026-09-15 12:51:11','','How did you start this journey','','publish','closed','closed','','how-did-you-start-this-journey','','','2026-09-15 12:51:11','2026-09-15 12:51:11','',0,'http://mkb-student-app-v20.local/question/how-did-you-start-this-journey/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (104,4,'2026-09-15 12:52:49','2026-09-15 12:52:49','Check the right answer','Survey : front-End Dev.','','publish','closed','closed','','survey-front-end-dev','','','2026-09-16 13:43:14','2026-09-16 13:43:14','',0,'http://mkb-student-app-v20.local/survey/survey-front-end-dev/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (105,4,'2026-09-15 12:53:28','2026-09-15 12:53:28','','Quelle propriété CSS permet de rendre une page adaptable aux différentes tailles d’écran ?','','publish','closed','closed','','quelle-propriete-css-permet-de-rendre-une-page-adaptable-aux-differentes-tailles-decran','','','2026-09-16 13:59:03','2026-09-16 13:59:03','',0,'http://mkb-student-app-v20.local/question/quelle-propriete-css-permet-de-rendre-une-page-adaptable-aux-differentes-tailles-decran/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (106,4,'2026-09-15 12:55:20','2026-09-15 12:55:20','Read Well first before you check','HTML Structure','','publish','closed','closed','','html-structure','','','2026-09-16 13:42:26','2026-09-16 13:42:26','',0,'http://mkb-student-app-v20.local/survey/html-structure/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (107,4,'2026-09-15 12:55:45','2026-09-15 12:55:45','','Quelle est la différence principale entre id et class en HTML ?','','publish','closed','closed','','quelle-est-la-difference-principale-entre-id-et-class-en-html','','','2026-09-16 13:58:40','2026-09-16 13:58:40','',0,'http://mkb-student-app-v20.local/question/quelle-est-la-difference-principale-entre-id-et-class-en-html/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (108,4,'2026-09-15 12:56:51','2026-09-15 12:56:51','Check the right answer','JavaScript dans une application Web','','publish','closed','closed','','javascript-dans-une-application-web','','','2026-09-16 13:22:10','2026-09-16 13:22:10','',0,'http://mkb-student-app-v20.local/survey/javascript-dans-une-application-web/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (109,4,'2026-09-15 12:57:40','2026-09-15 12:57:40','','Que permet JavaScript dans une application web ?','','publish','closed','closed','','que-permet-javascript-dans-une-application-web','','','2026-09-16 13:58:14','2026-09-16 13:58:14','',0,'http://mkb-student-app-v20.local/question/que-permet-javascript-dans-une-application-web/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (110,4,'2026-09-15 12:59:40','2026-09-15 12:59:40','Check the right answer','HTML and CSS','','publish','closed','closed','','html-and-css','','','2026-09-16 13:21:54','2026-09-16 13:21:54','',0,'http://mkb-student-app-v20.local/survey/html-and-css/',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (111,4,'2026-09-15 13:00:06','2026-09-15 13:00:06','','Un bouton ne fonctionne pas lorsqu’un utilisateur clique dessus. Quelle première étape devriez-vous effectuer pour trouver le problème ?','','publish','closed','closed','','un-bouton-ne-fonctionne-pas-lorsquun-utilisateur-clique-dessus-quelle-premiere-etape-devriez-vous-effectuer-pour-trouver-le-probleme','','','2026-09-16 13:57:48','2026-09-16 13:57:48','',0,'http://mkb-student-app-v20.local/question/un-bouton-ne-fonctionne-pas-lorsquun-utilisateur-clique-dessus-quelle-premiere-etape-devriez-vous-effectuer-pour-trouver-le-probleme/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (112,1,'2026-09-15 13:01:58','2026-09-15 13:01:58','','logo lighthouses','','inherit','open','closed','','logo-lighthouses','','','2026-09-15 13:01:58','2026-09-15 13:01:58','',0,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/logo-lighthouses.png',0,'attachment','image/png',0);
INSERT INTO `wp_posts` VALUES (113,2,'2026-09-16 13:25:58','2026-09-16 13:25:58','','Response for Survey #102 by User #2','','publish','closed','closed','','response-for-survey-102-by-user-2','','','2026-09-16 13:25:58','2026-09-16 13:25:58','',0,'http://mkb-student-app-v20.local/?p=113',0,'response','',0);
INSERT INTO `wp_posts` VALUES (114,2,'2026-09-16 13:29:08','2026-09-16 13:29:08','','Response for Survey #87 by User #2','','publish','closed','closed','','response-for-survey-87-by-user-2','','','2026-09-16 13:29:08','2026-09-16 13:29:08','',0,'http://mkb-student-app-v20.local/?p=114',0,'response','',0);
INSERT INTO `wp_posts` VALUES (115,1,'2026-09-16 13:43:03','2026-09-16 13:43:03','','localisation','','inherit','open','closed','','localisation','','','2026-09-16 13:43:03','2026-09-16 13:43:03','',104,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/localisation.png',0,'attachment','image/png',0);
INSERT INTO `wp_posts` VALUES (116,1,'2026-09-16 13:43:52','2026-09-16 13:43:52','','Photos diné-9','','inherit','open','closed','','photos-dine-9-2','','','2026-09-16 13:43:52','2026-09-16 13:43:52','',102,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/Photos-dine-9-1.jpg',0,'attachment','image/jpeg',0);
INSERT INTO `wp_posts` VALUES (117,1,'2026-09-16 13:45:05','2026-09-16 13:45:05','','Photos diné-8','','inherit','open','closed','','photos-dine-8','','','2026-09-16 13:45:05','2026-09-16 13:45:05','',100,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/Photos-dine-8.jpg',0,'attachment','image/jpeg',0);
INSERT INTO `wp_posts` VALUES (118,1,'2026-09-16 13:46:11','2026-09-16 13:46:11','','Photos diné-92','','inherit','open','closed','','photos-dine-92','','','2026-09-16 13:46:11','2026-09-16 13:46:11','',100,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/Photos-dine-92.jpg',0,'attachment','image/jpeg',0);
INSERT INTO `wp_posts` VALUES (119,1,'2026-09-16 13:46:59','2026-09-16 13:46:59','','Photos diné-5','','inherit','open','closed','','photos-dine-5','','','2026-09-16 13:46:59','2026-09-16 13:46:59','',98,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/Photos-dine-5.jpg',0,'attachment','image/jpeg',0);
INSERT INTO `wp_posts` VALUES (120,3,'2026-09-16 14:11:12','2026-09-16 14:11:12','','Avez-vous une connaissance avec Wordpress?','','publish','closed','closed','','avez-vous-une-connaissance-avec-wordpress','','','2026-09-16 14:16:24','2026-09-16 14:16:24','',0,'http://mkb-student-app-v20.local/question/avez-vous-une-connaissance-avec-wordpress/',0,'question','',0);
INSERT INTO `wp_posts` VALUES (121,2,'2026-09-16 14:42:50','2026-09-16 14:42:50','','Response for Survey #85 by User #2','','publish','closed','closed','','response-for-survey-85-by-user-2','','','2026-09-16 14:42:50','2026-09-16 14:42:50','',0,'http://mkb-student-app-v20.local/?p=121',0,'response','',0);
INSERT INTO `wp_posts` VALUES (122,2,'2026-09-16 14:43:15','2026-09-16 14:43:15','','Response for Survey #83 by User #2','','publish','closed','closed','','response-for-survey-83-by-user-2','','','2026-09-16 14:43:15','2026-09-16 14:43:15','',0,'http://mkb-student-app-v20.local/?p=122',0,'response','',0);
INSERT INTO `wp_posts` VALUES (123,2,'2026-09-16 14:44:10','2026-09-16 14:44:10','','Response for Survey #81 by User #2','','publish','closed','closed','','response-for-survey-81-by-user-2','','','2026-09-16 14:44:10','2026-09-16 14:44:10','',0,'http://mkb-student-app-v20.local/?p=123',0,'response','',0);
INSERT INTO `wp_posts` VALUES (124,2,'2026-09-16 14:45:19','2026-09-16 14:45:19','','Response for Survey #78 by User #2','','publish','closed','closed','','response-for-survey-78-by-user-2','','','2026-09-16 14:45:19','2026-09-16 14:45:19','',0,'http://mkb-student-app-v20.local/?p=124',0,'response','',0);
INSERT INTO `wp_posts` VALUES (125,2,'2026-09-16 14:48:35','2026-09-16 14:48:35','','Response for Survey #110 by User #2','','publish','closed','closed','','response-for-survey-110-by-user-2','','','2026-09-16 14:48:35','2026-09-16 14:48:35','',0,'http://mkb-student-app-v20.local/?p=125',0,'response','',0);
INSERT INTO `wp_posts` VALUES (126,2,'2026-09-16 14:49:06','2026-09-16 14:49:06','','Response for Survey #108 by User #2','','publish','closed','closed','','response-for-survey-108-by-user-2','','','2026-09-16 14:49:06','2026-09-16 14:49:06','',0,'http://mkb-student-app-v20.local/?p=126',0,'response','',0);
INSERT INTO `wp_posts` VALUES (127,2,'2026-09-16 14:49:37','2026-09-16 14:49:37','','Response for Survey #106 by User #2','','publish','closed','closed','','response-for-survey-106-by-user-2','','','2026-09-16 14:49:37','2026-09-16 14:49:37','',0,'http://mkb-student-app-v20.local/?p=127',0,'response','',0);
INSERT INTO `wp_posts` VALUES (128,2,'2026-09-16 14:50:21','2026-09-16 14:50:21','','Response for Survey #100 by User #2','','publish','closed','closed','','response-for-survey-100-by-user-2','','','2026-09-16 14:50:21','2026-09-16 14:50:21','',0,'http://mkb-student-app-v20.local/?p=128',0,'response','',0);
INSERT INTO `wp_posts` VALUES (129,6,'2026-09-17 05:15:01','2026-09-17 05:15:01','','istockphoto-1211348683-170667a','Golden stamp with ribbons isolated on white background. Luxury seal. Vector design element','inherit','open','closed','','istockphoto-1211348683-170667a','','','2026-09-17 05:15:01','2026-09-17 05:15:01','',0,'http://mkb-student-app-v20.local/wp-content/uploads/2026/09/istockphoto-1211348683-170667a.jpg',0,'attachment','image/jpeg',0);
INSERT INTO `wp_posts` VALUES (130,1,'2026-09-18 09:30:08','0000-00-00 00:00:00','','Auto Draft','','auto-draft','open','open','','','','','2026-09-18 09:30:08','0000-00-00 00:00:00','',0,'http://mkb-student-app-v20.local/?p=130',0,'post','',0);
INSERT INTO `wp_posts` VALUES (131,1,'2026-09-18 09:36:38','2026-09-18 09:36:38','i create this surveys for verifying the aplication','Surveys for checking','','publish','closed','closed','','surveys-for-checking','','','2026-09-18 09:36:38','2026-09-18 09:36:38','',0,'http://mkb-student-app-v20.local/?post_type=survey&#038;p=131',0,'survey','',0);
INSERT INTO `wp_posts` VALUES (132,1,'2026-09-18 09:38:42','2026-09-18 09:38:42','','','','publish','closed','closed','','132','','','2026-09-18 09:38:42','2026-09-18 09:38:42','',0,'http://mkb-student-app-v20.local/?post_type=question&#038;p=132',0,'question','',0);
/*!40000 ALTER TABLE `wp_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_relationships`
--

DROP TABLE IF EXISTS `wp_term_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_relationships` (
  `object_id` bigint unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint unsigned NOT NULL DEFAULT '0',
  `term_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_relationships`
--

LOCK TABLES `wp_term_relationships` WRITE;
/*!40000 ALTER TABLE `wp_term_relationships` DISABLE KEYS */;
INSERT INTO `wp_term_relationships` VALUES (1,1,0);
/*!40000 ALTER TABLE `wp_term_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint unsigned NOT NULL DEFAULT '0',
  `count` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_term_taxonomy`
--

LOCK TABLES `wp_term_taxonomy` WRITE;
/*!40000 ALTER TABLE `wp_term_taxonomy` DISABLE KEYS */;
INSERT INTO `wp_term_taxonomy` VALUES (1,1,'category','',0,1);
/*!40000 ALTER TABLE `wp_term_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_termmeta`
--

DROP TABLE IF EXISTS `wp_termmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_termmeta` (
  `meta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_termmeta`
--

LOCK TABLES `wp_termmeta` WRITE;
/*!40000 ALTER TABLE `wp_termmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_termmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_terms` (
  `term_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_terms`
--

LOCK TABLES `wp_terms` WRITE;
/*!40000 ALTER TABLE `wp_terms` DISABLE KEYS */;
INSERT INTO `wp_terms` VALUES (1,'Uncategorized','uncategorized',0);
/*!40000 ALTER TABLE `wp_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_usermeta`
--

LOCK TABLES `wp_usermeta` WRITE;
/*!40000 ALTER TABLE `wp_usermeta` DISABLE KEYS */;
INSERT INTO `wp_usermeta` VALUES (1,1,'nickname','root');
INSERT INTO `wp_usermeta` VALUES (2,1,'first_name','Admin');
INSERT INTO `wp_usermeta` VALUES (3,1,'last_name','Super Admin');
INSERT INTO `wp_usermeta` VALUES (4,1,'description','');
INSERT INTO `wp_usermeta` VALUES (5,1,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (6,1,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (7,1,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (8,1,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (9,1,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (10,1,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (11,1,'locale','');
INSERT INTO `wp_usermeta` VALUES (12,1,'wp_capabilities','a:1:{s:13:\"administrator\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (13,1,'wp_user_level','10');
INSERT INTO `wp_usermeta` VALUES (14,1,'dismissed_wp_pointers','theme_editor_notice');
INSERT INTO `wp_usermeta` VALUES (15,1,'show_welcome_panel','0');
INSERT INTO `wp_usermeta` VALUES (16,1,'session_tokens','a:2:{s:64:\"6deb8b426dd462b7711f4629f4b35e3a09db7050b874177693b285af7083708a\";a:4:{s:10:\"expiration\";i:1790267476;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:125:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36 Edg/152.0.0.0\";s:5:\"login\";i:1789057876;}s:64:\"ea4e0ea5d0194c0ec61e96465c373c5ff3da637a7a1796eea0537cb2e0f9be73\";a:4:{s:10:\"expiration\";i:1790935671;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:125:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0\";s:5:\"login\";i:1789726071;}}');
INSERT INTO `wp_usermeta` VALUES (17,1,'wp_dashboard_quick_press_last_post_id','130');
INSERT INTO `wp_usermeta` VALUES (18,2,'nickname','Front-End student');
INSERT INTO `wp_usermeta` VALUES (19,2,'first_name','Student Front-End');
INSERT INTO `wp_usermeta` VALUES (20,2,'last_name','MKB Academy');
INSERT INTO `wp_usermeta` VALUES (21,2,'description','');
INSERT INTO `wp_usermeta` VALUES (22,2,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (23,2,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (24,2,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (25,2,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (26,2,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (27,2,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (28,2,'locale','');
INSERT INTO `wp_usermeta` VALUES (29,2,'wp_capabilities','a:1:{s:7:\"student\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (30,2,'wp_user_level','0');
INSERT INTO `wp_usermeta` VALUES (31,2,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (32,3,'nickname','Instructor Back End');
INSERT INTO `wp_usermeta` VALUES (33,3,'first_name','Instructor Back-End');
INSERT INTO `wp_usermeta` VALUES (34,3,'last_name','MKB Academy');
INSERT INTO `wp_usermeta` VALUES (35,3,'description','');
INSERT INTO `wp_usermeta` VALUES (36,3,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (37,3,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (38,3,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (39,3,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (40,3,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (41,3,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (42,3,'locale','');
INSERT INTO `wp_usermeta` VALUES (43,3,'wp_capabilities','a:1:{s:10:\"instructor\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (44,3,'wp_user_level','0');
INSERT INTO `wp_usermeta` VALUES (45,3,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (48,3,'wp_dashboard_quick_press_last_post_id','11');
INSERT INTO `wp_usermeta` VALUES (55,1,'managenav-menuscolumnshidden','a:5:{i:0;s:11:\"link-target\";i:1;s:11:\"css-classes\";i:2;s:3:\"xfn\";i:3;s:11:\"description\";i:4;s:15:\"title-attribute\";}');
INSERT INTO `wp_usermeta` VALUES (56,1,'metaboxhidden_nav-menus','a:2:{i:0;s:20:\"add-post-type-survey\";i:1;s:12:\"add-post_tag\";}');
INSERT INTO `wp_usermeta` VALUES (62,3,'wp_user-settings','libraryContent=browse');
INSERT INTO `wp_usermeta` VALUES (63,3,'wp_user-settings-time','1789391322');
INSERT INTO `wp_usermeta` VALUES (64,1,'wp_user-settings','libraryContent=browse');
INSERT INTO `wp_usermeta` VALUES (65,1,'wp_user-settings-time','1789391841');
INSERT INTO `wp_usermeta` VALUES (66,4,'nickname','Instructor Front-End');
INSERT INTO `wp_usermeta` VALUES (67,4,'first_name','Instructor Front end');
INSERT INTO `wp_usermeta` VALUES (68,4,'last_name','Front-End');
INSERT INTO `wp_usermeta` VALUES (69,4,'description','');
INSERT INTO `wp_usermeta` VALUES (70,4,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (71,4,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (72,4,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (73,4,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (74,4,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (75,4,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (76,4,'locale','');
INSERT INTO `wp_usermeta` VALUES (77,4,'wp_capabilities','a:1:{s:10:\"instructor\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (78,4,'wp_user_level','0');
INSERT INTO `wp_usermeta` VALUES (79,4,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (80,5,'nickname','Deployment student');
INSERT INTO `wp_usermeta` VALUES (81,5,'first_name','Deployment student');
INSERT INTO `wp_usermeta` VALUES (82,5,'last_name','MKB Academy');
INSERT INTO `wp_usermeta` VALUES (83,5,'description','');
INSERT INTO `wp_usermeta` VALUES (84,5,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (85,5,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (86,5,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (87,5,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (88,5,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (89,5,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (90,5,'locale','');
INSERT INTO `wp_usermeta` VALUES (91,5,'wp_capabilities','a:1:{s:7:\"student\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (92,5,'wp_user_level','0');
INSERT INTO `wp_usermeta` VALUES (93,5,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (103,4,'wp_dashboard_quick_press_last_post_id','44');
INSERT INTO `wp_usermeta` VALUES (105,2,'_sslms_profile_phone','+243970005782');
INSERT INTO `wp_usermeta` VALUES (106,2,'_sslms_profile_student_id','STD0000001113');
INSERT INTO `wp_usermeta` VALUES (107,2,'_sslms_profile_roll_number','0000001113');
INSERT INTO `wp_usermeta` VALUES (108,2,'_sslms_profile_program','Cohort 3');
INSERT INTO `wp_usermeta` VALUES (109,2,'_sslms_profile_level','Year 3');
INSERT INTO `wp_usermeta` VALUES (110,2,'_sslms_profile_city','Bukavu');
INSERT INTO `wp_usermeta` VALUES (111,2,'_sslms_profile_country','Congo (DRC)');
INSERT INTO `wp_usermeta` VALUES (112,2,'_sslms_profile_bio','I\'am a passionate Web developper mentor very excited to be part of this');
INSERT INTO `wp_usermeta` VALUES (113,2,'_sslms_profile_photo_id','54');
INSERT INTO `wp_usermeta` VALUES (116,5,'_sslms_profile_phone','+243978494715');
INSERT INTO `wp_usermeta` VALUES (117,5,'_sslms_profile_student_id','STD0000001111');
INSERT INTO `wp_usermeta` VALUES (118,5,'_sslms_profile_roll_number','0000001111');
INSERT INTO `wp_usermeta` VALUES (119,5,'_sslms_profile_program','Cohort 1');
INSERT INTO `wp_usermeta` VALUES (120,5,'_sslms_profile_level','Year 3');
INSERT INTO `wp_usermeta` VALUES (121,5,'_sslms_profile_city','Bukavu');
INSERT INTO `wp_usermeta` VALUES (122,5,'_sslms_profile_country','Congo (DRC)');
INSERT INTO `wp_usermeta` VALUES (123,5,'_sslms_profile_bio','This app is very cool i like it lol ...');
INSERT INTO `wp_usermeta` VALUES (124,5,'_sslms_profile_photo_id','57');
INSERT INTO `wp_usermeta` VALUES (130,1,'wp_persisted_preferences','a:3:{s:4:\"core\";a:1:{s:26:\"isComplementaryAreaVisible\";b:1;}s:14:\"core/edit-post\";a:1:{s:12:\"welcomeGuide\";b:0;}s:9:\"_modified\";s:24:\"2026-09-14T16:54:41.831Z\";}');
INSERT INTO `wp_usermeta` VALUES (133,5,'_sslms_assigned_instructor_id','7');
INSERT INTO `wp_usermeta` VALUES (134,5,'_sslms_student_class','Cohorte 3');
INSERT INTO `wp_usermeta` VALUES (136,2,'_sslms_assigned_instructor_id','4');
INSERT INTO `wp_usermeta` VALUES (137,2,'_sslms_student_class','');
INSERT INTO `wp_usermeta` VALUES (158,6,'nickname','Student Back-end');
INSERT INTO `wp_usermeta` VALUES (159,6,'first_name','Student Back-end');
INSERT INTO `wp_usermeta` VALUES (160,6,'last_name','MKB Academy');
INSERT INTO `wp_usermeta` VALUES (161,6,'description','');
INSERT INTO `wp_usermeta` VALUES (162,6,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (163,6,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (164,6,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (165,6,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (166,6,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (167,6,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (168,6,'locale','');
INSERT INTO `wp_usermeta` VALUES (169,6,'wp_capabilities','a:1:{s:7:\"student\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (170,6,'wp_user_level','0');
INSERT INTO `wp_usermeta` VALUES (171,6,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (172,7,'nickname','Instructor Deployment');
INSERT INTO `wp_usermeta` VALUES (173,7,'first_name','Deployment Teacher');
INSERT INTO `wp_usermeta` VALUES (174,7,'last_name','Teacher Deployment');
INSERT INTO `wp_usermeta` VALUES (175,7,'description','');
INSERT INTO `wp_usermeta` VALUES (176,7,'rich_editing','true');
INSERT INTO `wp_usermeta` VALUES (177,7,'syntax_highlighting','true');
INSERT INTO `wp_usermeta` VALUES (178,7,'comment_shortcuts','false');
INSERT INTO `wp_usermeta` VALUES (179,7,'admin_color','fresh');
INSERT INTO `wp_usermeta` VALUES (180,7,'use_ssl','0');
INSERT INTO `wp_usermeta` VALUES (181,7,'show_admin_bar_front','true');
INSERT INTO `wp_usermeta` VALUES (182,7,'locale','');
INSERT INTO `wp_usermeta` VALUES (183,7,'wp_capabilities','a:1:{s:10:\"instructor\";b:1;}');
INSERT INTO `wp_usermeta` VALUES (184,7,'wp_user_level','0');
INSERT INTO `wp_usermeta` VALUES (185,7,'dismissed_wp_pointers','');
INSERT INTO `wp_usermeta` VALUES (187,6,'_sslms_assigned_instructor_id','3');
INSERT INTO `wp_usermeta` VALUES (188,6,'_sslms_student_class','');
INSERT INTO `wp_usermeta` VALUES (189,6,'_sslms_profile_phone','+243 000 000 000');
INSERT INTO `wp_usermeta` VALUES (190,6,'_sslms_profile_student_id','STD0000001112');
INSERT INTO `wp_usermeta` VALUES (191,6,'_sslms_profile_roll_number','0000001112');
INSERT INTO `wp_usermeta` VALUES (192,6,'_sslms_profile_program','Cohort 2');
INSERT INTO `wp_usermeta` VALUES (193,6,'_sslms_profile_level','Year 2');
INSERT INTO `wp_usermeta` VALUES (194,6,'_sslms_profile_city','Bukavu');
INSERT INTO `wp_usermeta` VALUES (195,6,'_sslms_profile_country','Congo (DRC)');
INSERT INTO `wp_usermeta` VALUES (196,6,'_sslms_profile_bio','');
INSERT INTO `wp_usermeta` VALUES (198,7,'_sslms_profile_phone','');
INSERT INTO `wp_usermeta` VALUES (199,7,'_sslms_profile_country','Congo (DRC)');
INSERT INTO `wp_usermeta` VALUES (200,7,'_sslms_profile_city','bukavu');
INSERT INTO `wp_usermeta` VALUES (201,7,'_sslms_profile_institution','MKB Acadeny');
INSERT INTO `wp_usermeta` VALUES (202,7,'_sslms_profile_program','Deployment AWS');
INSERT INTO `wp_usermeta` VALUES (203,7,'_sslms_profile_bio','I\'m a good teacher and i\'ll be teaching you gys how the deployment process works...');
INSERT INTO `wp_usermeta` VALUES (204,7,'_sslms_profile_photo_id','75');
INSERT INTO `wp_usermeta` VALUES (206,4,'_sslms_profile_phone','');
INSERT INTO `wp_usermeta` VALUES (207,4,'_sslms_profile_country','Congo (DRC)');
INSERT INTO `wp_usermeta` VALUES (208,4,'_sslms_profile_city','Bukavu');
INSERT INTO `wp_usermeta` VALUES (209,4,'_sslms_profile_institution','MKB Acadeny');
INSERT INTO `wp_usermeta` VALUES (210,4,'_sslms_profile_program','Front-END Dev');
INSERT INTO `wp_usermeta` VALUES (211,4,'_sslms_profile_bio','I\'m your Front end dev teach i\'m excited to have you in my class room you\'re all welcome');
INSERT INTO `wp_usermeta` VALUES (212,4,'_sslms_profile_photo_id','76');
INSERT INTO `wp_usermeta` VALUES (214,3,'_sslms_profile_phone','');
INSERT INTO `wp_usermeta` VALUES (215,3,'_sslms_profile_country','Congo (DRC)');
INSERT INTO `wp_usermeta` VALUES (216,3,'_sslms_profile_city','Bukavu');
INSERT INTO `wp_usermeta` VALUES (217,3,'_sslms_profile_institution','MKB Acadeny');
INSERT INTO `wp_usermeta` VALUES (218,3,'_sslms_profile_program','Back-END Dev');
INSERT INTO `wp_usermeta` VALUES (219,3,'_sslms_profile_bio','I\'m your Back-End web dev teacher ... want serious student only...');
INSERT INTO `wp_usermeta` VALUES (220,3,'_sslms_profile_photo_id','77');
INSERT INTO `wp_usermeta` VALUES (230,1,'_sslms_profile_phone','0978494715');
INSERT INTO `wp_usermeta` VALUES (231,1,'_sslms_profile_country','Congo (DRC)');
INSERT INTO `wp_usermeta` VALUES (232,1,'_sslms_profile_city','Bukavu');
INSERT INTO `wp_usermeta` VALUES (233,1,'_sslms_profile_institution','MKB Acadeny');
INSERT INTO `wp_usermeta` VALUES (234,1,'_sslms_profile_program','');
INSERT INTO `wp_usermeta` VALUES (235,1,'_sslms_profile_bio','');
INSERT INTO `wp_usermeta` VALUES (236,1,'_sslms_profile_photo_id','112');
INSERT INTO `wp_usermeta` VALUES (263,6,'_sslms_profile_photo_id','129');
INSERT INTO `wp_usermeta` VALUES (273,6,'session_tokens','a:1:{s:64:\"5faab6afd76aa300f402801fad134498befdbcf23b2b75f040d7413e93c1b0db\";a:4:{s:10:\"expiration\";i:1790935764;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:125:\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0\";s:5:\"login\";i:1789726164;}}');
/*!40000 ALTER TABLE `wp_usermeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wp_users` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_users`
--

LOCK TABLES `wp_users` WRITE;
/*!40000 ALTER TABLE `wp_users` DISABLE KEYS */;
INSERT INTO `wp_users` VALUES (1,'root','$wp$2y$10$4xwwreOVFkOVsanYvvq/..LW6oNAK23cyL8nibWI8D5NbiQxo5X5a','root','gcherubala11@gmail.com','http://mkb-student-app-v20.local','2026-09-10 08:26:58','',0,'Admin Super Admin');
INSERT INTO `wp_users` VALUES (2,'gauthier','$wp$2y$10$fomCWTCjrFiJOOvIDozlJuc2NhCHXt/EA4LfH4j3XhhfEn30nPela','gauthier','gauthiercherubala08@gmail.com','','2026-09-10 08:33:02','',0,'Student Front-End MKB Academy');
INSERT INTO `wp_users` VALUES (3,'Medialephare','$wp$2y$10$fxMovXX.oyoeKQ80R/S1OudN14K7Nvtyy0NRwpZ10s3QN/zsmWKCe','medialephare','medialephare@gmail.com','','2026-09-10 08:33:57','',0,'Instructor Back-End MKB Academy');
INSERT INTO `wp_users` VALUES (4,'Instructor','$wp$2y$10$t/hHY.V9fv00Uu33DGGvcuFT8xlzPRTZlnrWrnxCM9dtSaIUTJoCa','instructor','aaronssuns6@gmail.com','','2026-09-14 13:20:57','',0,'Instructor Front end Front-End');
INSERT INTO `wp_users` VALUES (5,'Student1','$wp$2y$10$wO5Xgs7UyE4BROhWv9dX3uf.ynEPLqlM5CIs3wXcmZ6QgrzQ/ZLAG','student1','leoncenarnolde@gmail.com','','2026-09-14 13:23:16','',0,'Deployment student MKB Academy');
INSERT INTO `wp_users` VALUES (6,'Student 2','$wp$2y$10$Dq0YX.7SzWHZDvI0FD3usOp6KbNCogwwWJeZKqpO5S7R6eJJzKAN6','student-2','lepharebukavu@gmail.com','','2026-09-15 11:21:45','',0,'Student Back-end MKB Academy');
INSERT INTO `wp_users` VALUES (7,'Instructor 2','$wp$2y$10$39JESfn3/S/Lt5QXSNf4ueAe0EnNHJUWIDbhYnfAfweeNzXOsxhOe','instructor-2','lepharebukavumedia@gmail.com','','2026-09-15 11:23:01','',0,'Deployment Teacher');
/*!40000 ALTER TABLE `wp_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-18 12:28:46
