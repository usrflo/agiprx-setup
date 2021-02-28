-- Table Structure

CREATE TABLE `api_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(60) NOT NULL,
  `agiprx_permission` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `backend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `label` varchar(16) NOT NULL,
  `fullname` varchar(60) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `port` int(6) NOT NULL,
  `params` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`,`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `backend_container` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `backend_id` int(11) NOT NULL,
  `container_id` int(11) NOT NULL,
  `params` varchar(100) DEFAULT NULL COMMENT 'HAProxy params, e.g. check fall 3 rise 2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `bcke_cntr` (`backend_id`,`container_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

ALTER TABLE `backend_container` ADD INDEX(`container_id`);
ALTER TABLE `backend_container` ADD INDEX(`backend_id`);

CREATE TABLE `container` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `label` varchar(60) NOT NULL,
  `fullname` varchar(60) DEFAULT NULL,
  `host_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `ipv6` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`,`host_id`,`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `container_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `container_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission` varchar(16) NOT NULL COMMENT 'Technical username to grant access to',
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission` (`container_id`,`user_id`,`permission`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `domain` varchar(100) NOT NULL,
  `backend_id` int(11) NOT NULL,
  `certprovided` tinyint(1) NOT NULL,
  `letsencrypt` tinyint(1) NOT NULL,
  `redirect_to_url` varchar(250) DEFAULT NULL COMMENT 'redirect target url',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

ALTER TABLE `domain` ADD INDEX(`backend_id`);
ALTER TABLE `domain` ADD INDEX(`certprovided`);
ALTER TABLE `domain` ADD INDEX(`letsencrypt`);

CREATE TABLE `host` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `hostname` varchar(50) NOT NULL,
  `ipv6` varchar(40) NOT NULL,
  `admin_password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  UNIQUE KEY `ipv6` (`ipv6`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `label` varchar(16) NOT NULL,
  `fullname` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `fullname` varchar(50) NOT NULL,
  `email` varchar(60) NOT NULL,
  `ssh_public_key` text NOT NULL,
  `role` varchar(10) NOT NULL COMMENT 'user role type: ADMIN or USER',
  `default_permission` varchar(100) NOT NULL COMMENT 'Comma separated technical users',
  `agiprx_permission` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- Optimistic Lock Checks

DELIMITER $$
DROP PROCEDURE IF EXISTS optlock_check$$
CREATE DEFINER=root@localhost PROCEDURE optlock_check (IN oldversion INT, INOUT newversion INT)
BEGIN
  IF oldversion > newversion THEN
    signal sqlstate '45000' set message_text = 'Optimistic Lock';
  END IF;
  
  SET newversion = newversion+1;
END;$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS `host_optlock_check`$$
CREATE DEFINER=root@localhost TRIGGER `host_optlock_check` BEFORE UPDATE ON `host`
FOR EACH ROW
BEGIN
	CALL optlock_check(OLD.version, NEW.version);
END;$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS `user_optlock_check`$$
CREATE DEFINER=root@localhost TRIGGER `user_optlock_check` BEFORE UPDATE ON `user`
FOR EACH ROW
BEGIN
	CALL optlock_check(OLD.version, NEW.version);
END;$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS `project_optlock_check`$$
CREATE DEFINER=root@localhost TRIGGER `project_optlock_check` BEFORE UPDATE ON `project`
FOR EACH ROW
BEGIN
	CALL optlock_check(OLD.version, NEW.version);
END;$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS `container_optlock_check`$$
CREATE DEFINER=root@localhost TRIGGER `container_optlock_check` BEFORE UPDATE ON `container`
FOR EACH ROW
BEGIN
	CALL optlock_check(OLD.version, NEW.version);
END;$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS `container_permission_optlock_check`$$
CREATE DEFINER=root@localhost TRIGGER `container_permission_optlock_check` BEFORE UPDATE ON `container_permission`
FOR EACH ROW
BEGIN
	CALL optlock_check(OLD.version, NEW.version);
END;$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS `backend_optlock_check`$$
CREATE DEFINER=root@localhost TRIGGER `backend_optlock_check` BEFORE UPDATE ON `backend`
FOR EACH ROW
BEGIN
	CALL optlock_check(OLD.version, NEW.version);
END;$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS `backend_container_optlock_check`$$
CREATE DEFINER=root@localhost TRIGGER `backend_container_optlock_check` BEFORE UPDATE ON `backend_container`
FOR EACH ROW
BEGIN
	CALL optlock_check(OLD.version, NEW.version);
END;$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS `domain_optlock_check`$$
CREATE DEFINER=root@localhost TRIGGER `domain_optlock_check` BEFORE UPDATE ON `domain`
FOR EACH ROW
BEGIN
	CALL optlock_check(OLD.version, NEW.version);
END;$$
DELIMITER ;
