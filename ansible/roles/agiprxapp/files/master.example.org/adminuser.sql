--
-- Informative table DDL; update INSERT statement below accordingly:
--
-- CREATE TABLE `user` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `version` int(11) DEFAULT NULL,
--   `fullname` varchar(50) NOT NULL,
--   `email` varchar(60) NOT NULL,
--   `ssh_public_key` text NOT NULL,
--   `role` varchar(10) NOT NULL COMMENT 'user role type: ADMIN or USER',
--   `default_permission` varchar(100) NOT NULL COMMENT 'Comma separated technical users',
--   `agiprx_permission` varchar(200) DEFAULT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `email` (`email`)
-- ) ENGINE=InnoDB CHARSET=utf8;

INSERT INTO `user` VALUES (
1,
1,
'Admin',
'webmaster@example.org',
'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqf917ZJr8YWFQh9t5odrwKUPrAgkLiD+0J0cSeUvQdS1AOMQ9I5vTkuQ5apxx7NKjKM1nDuH72M9N/EuZ+nPJP8IM3zpnm+IHtBJYntfWVvLpBSZY0OTWeRegHfZhI6SBJOcku2BRMs6zqxRD1T3pu3SXE99NwZxd8YJHt0HqxAJ+Kesf70y0J/YrEcn2je56kzRwxm8lih+KRD+dvWIp1xopZKALskI+8fnA6t36XMxvlzKyLOc1jZ97kp/u8/iXyLFKOSDfI9omzcrSDH3LEKGXCklNgiSPIad+QrTIRYyEwvLGDXOL2GrEucOi6Z2aR9OXFTAimrDQmnbF/4eL webmaster@example.org',
'ADMIN',
'www-data,root',
NULL);
