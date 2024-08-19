-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 19, 2024 at 10:00 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `adminws`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_sell`
--

CREATE TABLE `detail_sell` (
  `id_Dsell` int(11) NOT NULL,
  `invoice_Dsell` varchar(255) NOT NULL,
  `idproduct_Dsell` int(11) NOT NULL,
  `sellPrice_Dsell` double NOT NULL DEFAULT 0,
  `buyPrice_Dsell` double NOT NULL DEFAULT 0,
  `qtyproduct_Dsell` int(11) NOT NULL DEFAULT 0,
  `subtotal_Dsell` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `detail_sell`
--
DELIMITER $$
CREATE TRIGGER `trigger_delete_detailSell` AFTER DELETE ON `detail_sell` FOR EACH ROW UPDATE product SET stock_product = stock_product + old.qtyproduct_Dsell WHERE id_product = old.idproduct_Dsell
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_insertTo_detailSell` BEFORE INSERT ON `detail_sell` FOR EACH ROW UPDATE product
SET stock_product = stock_product - new.qtyproduct_Dsell
WHERE id_product = new.idproduct_Dsell
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_update_detailSell` BEFORE UPDATE ON `detail_sell` FOR EACH ROW UPDATE product 
SET stock_product = (stock_product + old.qtyproduct_Dsell) - new.qtyproduct_Dsell 
WHERE id_product = new.idproduct_Dsell
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `level`
--

CREATE TABLE `level` (
  `id_level` int(11) NOT NULL,
  `name_level` varchar(255) NOT NULL,
  `desc_level` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`id_level`, `name_level`, `desc_level`) VALUES
(1, 'None', 'Tidak memiliki jabatan'),
(2, 'Cashier', 'Pegawai Kasir'),
(3, 'Owner', 'Pemilik Usaha'),
(4, 'Administrator', 'Admin Program');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id_product` int(11) NOT NULL,
  `name_product` varchar(255) NOT NULL,
  `qr_product` varchar(255) DEFAULT NULL,
  `stock_product` int(11) NOT NULL DEFAULT 0,
  `sellPrice_product` double NOT NULL DEFAULT 0,
  `purchasePrice_product` double NOT NULL DEFAULT 0,
  `image_product` varchar(255) NOT NULL,
  `supplier_product` int(255) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sell`
--

CREATE TABLE `sell` (
  `invoice_sell` varchar(255) NOT NULL,
  `date_sell` datetime NOT NULL DEFAULT current_timestamp(),
  `sig_sell` int(11) NOT NULL,
  `percentdisc_sell` double NOT NULL DEFAULT 0,
  `nominaldisc_sell` double NOT NULL DEFAULT 0,
  `totalprice_sell` double NOT NULL DEFAULT 0,
  `totalpay_sell` double NOT NULL DEFAULT 0,
  `pay_sell` double NOT NULL DEFAULT 0,
  `change_sell` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` int(11) NOT NULL,
  `name_supplier` varchar(255) NOT NULL,
  `phone_supplier` varchar(15) DEFAULT NULL,
  `address_supplier` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `name_supplier`, `phone_supplier`, `address_supplier`) VALUES
(7, 'Pt Indo', NULL, ' Jl Merdeka'),
(8, 'Pt Indo', NULL, ' Jl Merdeka'),
(9, 'Pt Malay', NULL, 'Jakara');

-- --------------------------------------------------------

--
-- Table structure for table `temp_sell`
--

CREATE TABLE `temp_sell` (
  `sellId_temp` int(11) NOT NULL,
  `sellinvoice_temp` varchar(255) NOT NULL,
  `sellProduct_temp` int(11) NOT NULL,
  `sellQr_temp` varchar(255) NOT NULL,
  `sellPrice_temp` double DEFAULT 0,
  `buyPrice_temp` double NOT NULL DEFAULT 0,
  `sellQty_temp` int(11) NOT NULL DEFAULT 0,
  `sellSubtotal_temp` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `temp_sell`
--
DELIMITER $$
CREATE TRIGGER `trigger_deleteFrom_tempSell` AFTER DELETE ON `temp_sell` FOR EACH ROW UPDATE product
SET stock_product = stock_product + old.sellQty_temp
WHERE id_product = old.sellProduct_temp
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_insertTo_tempSell` AFTER INSERT ON `temp_sell` FOR EACH ROW UPDATE product
SET stock_product = stock_product - new.sellQty_temp
WHERE id_product = new.sellProduct_temp
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_update_tempSell` AFTER UPDATE ON `temp_sell` FOR EACH ROW UPDATE product
SET 
stock_product = (stock_product + old.sellQty_temp) - new.sellQty_temp
WHERE id_product = new.sellProduct_temp
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `trans_stock`
--

CREATE TABLE `trans_stock` (
  `id_trans` int(11) NOT NULL,
  `product_trans` int(11) NOT NULL,
  `type_trans` enum('In','Out') NOT NULL,
  `detail_trans` varchar(255) NOT NULL,
  `supplier_trans` int(11) NOT NULL,
  `qty_trans` int(11) NOT NULL,
  `date_trans` date NOT NULL,
  `totalpay_trans` double NOT NULL,
  `sig_trans` int(10) NOT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(31) NOT NULL,
  `name` varchar(255) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `phone` varchar(15) NOT NULL DEFAULT '-',
  `email` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL DEFAULT '-',
  `password` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'assets/upload/profile/default.png',
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `updated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `name`, `level`, `phone`, `email`, `address`, `password`, `image`, `created`, `updated`) VALUES
('andreas', 'Andreas Permana Putra', 4, '-', 'andreas@email.com', '-', '', 'assets/upload/profile/default.png', '2024-08-07 09:59:05', '2024-08-07 10:31:43'),
('owner', 'Owner', 3, '0823408432', 'owner@email.com', '-', '$2y$10$1WENHE4iNiN3sIvuY4nwbeVq7dVuhj4Y3/Bn5NPcld8JJ8/oGXp8C', 'assets/upload/profile/default.png', '2024-08-07 10:04:28', '2024-08-18 22:21:00'),
('user', 'user', 1, '-', 'user@gmail.com', '-', '$2y$10$QNfpnwCPsLXXRhprinwi2O9EgZ1m9wRN/E9TrmJ4xOXgDOpea9UBO', 'assets/upload/profile/default.png', '2024-08-19 00:39:27', '2024-08-19 00:39:27'),
('kasir', 'kasir', 2, '081232223312', 'kasir@gmail.com', '-', '$2y$10$/Y7j0x2eohav8mTqIjDFJelYLpDa362ohNiWSZHHUC2txN7CKES8S', 'assets/upload/profile/default.png', '2024-08-19 01:16:52', '2024-08-19 01:17:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_sell`
--
ALTER TABLE `detail_sell`
  ADD PRIMARY KEY (`id_Dsell`),
  ADD KEY `invoicefk` (`invoice_Dsell`),
  ADD KEY `idproductfk` (`idproduct_Dsell`);

--
-- Indexes for table `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`id_level`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id_product`),
  ADD UNIQUE KEY `qr_product` (`qr_product`),
  ADD KEY `supplierfk` (`supplier_product`);

--
-- Indexes for table `sell`
--
ALTER TABLE `sell`
  ADD PRIMARY KEY (`invoice_sell`),
  ADD KEY `userfk` (`sig_sell`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`),
  ADD UNIQUE KEY `phone_supplier` (`phone_supplier`);

--
-- Indexes for table `temp_sell`
--
ALTER TABLE `temp_sell`
  ADD PRIMARY KEY (`sellId_temp`);

--
-- Indexes for table `trans_stock`
--
ALTER TABLE `trans_stock`
  ADD PRIMARY KEY (`id_trans`),
  ADD KEY `sig_trans` (`sig_trans`),
  ADD KEY `supplier_trans` (`supplier_trans`),
  ADD KEY `product_trans` (`product_trans`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `levelfk` (`level`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_sell`
--
ALTER TABLE `detail_sell`
  MODIFY `id_Dsell` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id_supplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `temp_sell`
--
ALTER TABLE `temp_sell`
  MODIFY `sellId_temp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=165;

--
-- AUTO_INCREMENT for table `trans_stock`
--
ALTER TABLE `trans_stock`
  MODIFY `id_trans` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_sell`
--
ALTER TABLE `detail_sell`
  ADD CONSTRAINT `idproductfk` FOREIGN KEY (`idproduct_Dsell`) REFERENCES `product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `invoicefk` FOREIGN KEY (`invoice_Dsell`) REFERENCES `sell` (`invoice_sell`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `supplierfk` FOREIGN KEY (`supplier_product`) REFERENCES `supplier` (`id_supplier`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sell`
--
ALTER TABLE `sell`
  ADD CONSTRAINT `userfk` FOREIGN KEY (`sig_sell`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `trans_stock`
--
ALTER TABLE `trans_stock`
  ADD CONSTRAINT `trans_stock_ibfk_1` FOREIGN KEY (`sig_trans`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `trans_stock_ibfk_2` FOREIGN KEY (`supplier_trans`) REFERENCES `supplier` (`id_supplier`),
  ADD CONSTRAINT `trans_stock_ibfk_3` FOREIGN KEY (`product_trans`) REFERENCES `product` (`id_product`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `levelfk` FOREIGN KEY (`level`) REFERENCES `level` (`id_level`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
