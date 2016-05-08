SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `sikolin`;
CREATE DATABASE `sikolin` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `sikolin`;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `credits` int(10) NOT NULL DEFAULT '0',
  `role` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `jenis` int(1) NOT NULL,
  `harga` int(10) NOT NULL,
  `foto` longblob NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `id_seller` int(10) NOT NULL,
  `total_rating` float NOT NULL DEFAULT '0',
  `jumlah_rate` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_seller` (`id_seller`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`id_seller`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `form`;
CREATE TABLE `form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(10) NOT NULL,
  `created at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `form_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `pesanan`;
CREATE TABLE `pesanan` (
  `id` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `id_form` int(11) NOT NULL,
  `jumlah` int(2) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `status` int(1) NOT NULL,
  KEY `id_menu` (`id_menu`),
  KEY `id_form` (`id_form`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`id_form`) REFERENCES `form` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
