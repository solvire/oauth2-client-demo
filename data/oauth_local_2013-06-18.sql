# ************************************************************
# Sequel Pro SQL dump
# Version 4004
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: stevevm (MySQL 5.0.95)
# Database: oauth_local
# Generation Time: 2013-06-18 22:17:47 -0700
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cas_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cas_user`;

CREATE TABLE `cas_user` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `username` varchar(25) character set utf8 NOT NULL default '',
  `password` varchar(45) character set utf8 NOT NULL default '',
  `firstname` varchar(25) character set utf8 default NULL,
  `lastname` varchar(25) character set utf8 default NULL,
  `email` varchar(45) character set utf8 default NULL,
  `created` datetime default NULL,
  `updated` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `cas_user` WRITE;
/*!40000 ALTER TABLE `cas_user` DISABLE KEYS */;

INSERT INTO `cas_user` (`id`, `username`, `password`, `firstname`, `lastname`, `email`, `created`, `updated`)
VALUES
	(1,'test','test','jack','squash','test@test.com','2013-03-01 00:00:00','2013-03-01 00:00:00'),
	(2,'steve','test123','steve','smith','steven@usamp.com','2013-03-01 00:00:00','2013-03-01 00:00:00');

/*!40000 ALTER TABLE `cas_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oauth_client_endpoints
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_client_endpoints`;

CREATE TABLE `oauth_client_endpoints` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `client_id` char(40) NOT NULL,
  `redirect_uri` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `i_oaclen_clid` (`client_id`),
  CONSTRAINT `f_oaclen_clid` FOREIGN KEY (`client_id`) REFERENCES `oauth_clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `oauth_client_endpoints` WRITE;
/*!40000 ALTER TABLE `oauth_client_endpoints` DISABLE KEYS */;

INSERT INTO `oauth_client_endpoints` (`id`, `client_id`, `redirect_uri`)
VALUES
	(1,'az10','http://www.p.surveyhead.com/z/public/login/oauth');

/*!40000 ALTER TABLE `oauth_client_endpoints` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oauth_clients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_clients`;

CREATE TABLE `oauth_clients` (
  `id` char(40) NOT NULL,
  `secret` char(40) NOT NULL,
  `name` varchar(255) NOT NULL,
  `auto_approve` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `u_oacl_clse_clid` (`secret`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;

INSERT INTO `oauth_clients` (`id`, `secret`, `name`, `auto_approve`)
VALUES
	('az10','client-0-test','client0',1);

/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table oauth_scopes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_scopes`;

CREATE TABLE `oauth_scopes` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `scope` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `u_oasc_sc` (`scope`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table oauth_session_access_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_session_access_tokens`;

CREATE TABLE `oauth_session_access_tokens` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `session_id` int(10) unsigned NOT NULL,
  `access_token` char(40) NOT NULL,
  `access_token_expires` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `u_oaseacto_acto_seid` (`access_token`,`session_id`),
  KEY `f_oaseto_seid` (`session_id`),
  CONSTRAINT `f_oaseto_seid` FOREIGN KEY (`session_id`) REFERENCES `oauth_sessions` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table oauth_session_authcode_scopes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_session_authcode_scopes`;

CREATE TABLE `oauth_session_authcode_scopes` (
  `oauth_session_authcode_id` int(10) unsigned NOT NULL,
  `scope_id` smallint(5) unsigned NOT NULL,
  KEY `oauth_session_authcode_id` (`oauth_session_authcode_id`),
  KEY `scope_id` (`scope_id`),
  CONSTRAINT `oauth_session_authcode_scopes_ibfk_2` FOREIGN KEY (`scope_id`) REFERENCES `oauth_scopes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth_session_authcode_scopes_ibfk_1` FOREIGN KEY (`oauth_session_authcode_id`) REFERENCES `oauth_session_authcodes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table oauth_session_authcodes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_session_authcodes`;

CREATE TABLE `oauth_session_authcodes` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `session_id` int(10) unsigned NOT NULL,
  `auth_code` char(40) NOT NULL,
  `auth_code_expires` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `oauth_session_authcodes_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `oauth_sessions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table oauth_session_redirects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_session_redirects`;

CREATE TABLE `oauth_session_redirects` (
  `session_id` int(10) unsigned NOT NULL,
  `redirect_uri` varchar(255) NOT NULL,
  PRIMARY KEY  (`session_id`),
  CONSTRAINT `f_oasere_seid` FOREIGN KEY (`session_id`) REFERENCES `oauth_sessions` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table oauth_session_refresh_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_session_refresh_tokens`;

CREATE TABLE `oauth_session_refresh_tokens` (
  `session_access_token_id` int(10) unsigned NOT NULL,
  `refresh_token` char(40) NOT NULL,
  `refresh_token_expires` int(10) unsigned NOT NULL,
  `client_id` char(40) NOT NULL,
  PRIMARY KEY  (`session_access_token_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `oauth_session_refresh_tokens_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `oauth_clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `f_oasetore_setoid` FOREIGN KEY (`session_access_token_id`) REFERENCES `oauth_session_access_tokens` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table oauth_session_token_scopes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_session_token_scopes`;

CREATE TABLE `oauth_session_token_scopes` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `session_access_token_id` int(10) unsigned default NULL,
  `scope_id` smallint(5) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `u_setosc_setoid_scid` (`session_access_token_id`,`scope_id`),
  KEY `f_oasetosc_scid` (`scope_id`),
  CONSTRAINT `f_oasetosc_scid` FOREIGN KEY (`scope_id`) REFERENCES `oauth_scopes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `f_oasetosc_setoid` FOREIGN KEY (`session_access_token_id`) REFERENCES `oauth_session_access_tokens` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table oauth_sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `oauth_sessions`;

CREATE TABLE `oauth_sessions` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `client_id` char(40) NOT NULL,
  `owner_type` enum('user','client') NOT NULL default 'user',
  `owner_id` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `i_uase_clid_owty_owid` (`client_id`,`owner_type`,`owner_id`),
  CONSTRAINT `f_oase_clid` FOREIGN KEY (`client_id`) REFERENCES `oauth_clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
