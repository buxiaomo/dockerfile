CREATE DATABASE xbclub_wp CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL ON xbclub_wp.* TO 'xbclub_1520067296'@'%' IDENTIFIED BY '2sXnxngHjY2xGnz';

CREATE DATABASE wuxin_wp CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL ON wuxin_wp.* TO 'wuxin_1520067296'@'%' IDENTIFIED BY 'aef0b100b4';
FLUSH PRIVILEGES;

CREATE DATABASE proftpd;
GRANT ALL ON proftpd.* TO 'proftpd'@'%' IDENTIFIED BY '5dDokSAJtIzpnVv';
USE proftpd;
CREATE TABLE IF NOT EXISTS `ftpgroup` (
  `groupname` varchar(16) COLLATE utf8_general_ci NOT NULL,
  `gid` smallint(6) NOT NULL DEFAULT '82',
  `members` varchar(16) COLLATE utf8_general_ci NOT NULL,
  KEY `groupname` (`groupname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ProFTP group table';

CREATE TABLE IF NOT EXISTS `ftpuser` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `passwd` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `uid` smallint(6) NOT NULL DEFAULT '82',
  `gid` smallint(6) NOT NULL DEFAULT '82',
  `homedir` varchar(255) COLLATE utf8_general_ci NOT NUL DEFAULT '',
  `shell` varchar(16) COLLATE utf8_general_ci NOT NULL DEFAULT '/sbin/nologin',
  `count` int(11) NOT NULL DEFAULT '0',
  `accessed` datetime NOT NULL DEFAULT '2018-03-02 13:45:45',
  `modified` datetime NOT NULL DEFAULT '2018-03-02 13:45:45',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ProFTP user table';

INSERT INTO `ftpgroup` (`groupname`, `gid`, `members`) VALUES ('www-data', 82, 'www-data');
INSERT INTO `ftpuser` (`userid`, `passwd`, `uid`, `gid`, `homedir`, `shell`, `count`) VALUES ('wuxin', ENCRYPT('GHZb5WkBOcjoM5Y'), 82, 82, '/var/www/wuxin/www', '/sbin/nologin', 0);

INSERT INTO `ftpuser` (`userid`, `passwd`, `uid`, `gid`, `homedir`, `shell`, `count`) VALUES ('xbclub', ENCRYPT('xbclub'), 82, 82, '/var/www/wuxin/www', '/sbin/nologin', 0);


CREATE DATABASE zblog CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL ON zblog.* TO 'zblog'@'%' IDENTIFIED BY '2sXnxngHjY2xGnz';

use information_schema;
select concat(round(sum(data_length/1024/1024),2),'MB') as data from tables;

select concat(round(sum(data_length/1024/1024),2),'MB') as data from tables where table_schema='proftpd';

select (sum(DATA_LENGTH) + sum(INDEX_LENGTH) % 1024 % 1024) as datasize from information_schema.tables
where table_schema='proftpd';


# All Databases Size
SELECT concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') AS Size From TABLES;
# test Databases Size
SELECT concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') AS Size From TABLES WHERE table_schema='wuxin_wp';


#######################
echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse" > /etc/apt/sources.list

CREATE TABLE ftp_group (
  groupname varchar(16) NOT NULL default '',
  gid smallint(6) NOT NULL default '82',
  members varchar(16) NOT NULL default '',
  KEY groupname (groupname)
) ENGINE=MyISAM COMMENT='ProFTP group table';

CREATE TABLE ftp_user (
  id int(10) unsigned NOT NULL auto_increment,
  userid varchar(32) NOT NULL default '',
  passwd varchar(32) NOT NULL default '',
  uid smallint(6) NOT NULL default '82',
  gid smallint(6) NOT NULL default '82',
  homedir varchar(255) NOT NULL default '',
  shell varchar(16) NOT NULL default '/sbin/nologin',
  count int(11) NOT NULL default '0',
  accessed datetime NOT NULL DEFAULT '2018-03-02 13:45:45',
  modified datetime NOT NULL DEFAULT '2018-03-02 13:45:45',
  PRIMARY KEY (id),
  UNIQUE KEY userid (userid)
) ENGINE=MyISAM COMMENT='ProFTP user table';

CREATE INDEX groups_gid_idx ON ftp_group (gid);

INSERT INTO `ftp_group` (`groupname`, `gid`, `members`) VALUES ('www-data', 82, 'ftpuser')
INSERT INTO `ftp_user` (`userid`, `passwd`, `uid`, `gid`, `homedir`, `shell`, `count`, `accessed`, `modified`) VALUES ('ftpuser', ENCRYPT('ftppassword'), 82, 82, '/var/www', '/sbin/nologin', 0, '2018-03-02 13:45:45', '2018-03-02 13:45:45')