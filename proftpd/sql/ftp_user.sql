-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 10.211.55.14
-- Generation Time: 2018-05-16 17:13:45
-- 服务器版本： 5.7.20-log
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dnmp`
--

-- --------------------------------------------------------

--
-- 表的结构 `ftp_user`
--

CREATE TABLE IF NOT EXISTS `ftp_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `userid` varchar(32) NOT NULL DEFAULT '',
  `passwd` varchar(32) NOT NULL DEFAULT '',
  `uid` smallint(6) NOT NULL DEFAULT '82',
  `gid` smallint(6) NOT NULL DEFAULT '82',
  `homedir` varchar(255) NOT NULL DEFAULT '',
  `shell` varchar(16) NOT NULL DEFAULT '/sbin/nologin',
  `count` int(11) NOT NULL DEFAULT '0',
  `accessed` datetime NOT NULL DEFAULT '2018-03-02 13:45:45',
  `modified` datetime NOT NULL DEFAULT '2018-03-02 13:45:45'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='ProFTP user table';

--
-- 转存表中的数据 `ftp_user`
--

INSERT INTO `ftp_user` (`id`, `userid`, `passwd`, `uid`, `gid`, `homedir`, `shell`, `count`, `accessed`, `modified`) VALUES
(1, 'ftpuser', 'tpp7KXHIZOwb2', 82, 82, '/var/www', '/sbin/nologin', 0, '2018-03-02 13:45:45', '2018-03-02 13:45:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ftp_user`
--
ALTER TABLE `ftp_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userid` (`userid`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `ftp_user`
--
ALTER TABLE `ftp_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
