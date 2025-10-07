-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 07, 2025 lúc 07:51 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `coffee_t2k`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `account`
--

CREATE TABLE `account` (
  `ID_Account` int(11) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `pass_word` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `reward_points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `account`
--

INSERT INTO `account` (`ID_Account`, `user_name`, `full_name`, `pass_word`, `phone`, `address`, `image`, `role`, `status`, `reward_points`) VALUES
(1, 'admin', 'Administrator', '$2a$10$NXb9dHUeU6yUi4eqAd67duV9qk.YevINgDJ4aOJ4qt0KhGSn7q3D2', '0987654321', 'Hồ Chí Minh', '/uploads/images/avatar/1_6843e4f2-8230-4a14-a769-e6bce933c0f3.jpg', 'Admin', 'active', 0),
(2, 'staff', 'Staff User', '$2a$10$ScNU8wWQIOZ9hNKw9jCAvuyerlmVyQnymbaEJ5fkm8rTNkREQGlte', '023627622', 'Hồ Chí Minh', '/uploads/images/avatar/2_a31e573e-da56-422c-b5e7-b91a29c62a86.png', 'Staff', 'active', 0),
(34, 'C', 'Phạm Thắng', '$2a$10$vn1D9xn.HHKZokuT/okGjO.DilI87ExT6DZmEbxL6kjjgdCzw3E7C', '0326314436', 'Ho Chi Minh', NULL, 'CUSTOMER', 'active', 333);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cafeorder`
--

CREATE TABLE `cafeorder` (
  `ID_Order` int(11) NOT NULL,
  `ID_Table` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `order_time` datetime(6) DEFAULT NULL,
  `total_amount` decimal(38,2) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `ID_Account` int(11) DEFAULT NULL,
  `ID_Promotion` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `cafeorder`
--

INSERT INTO `cafeorder` (`ID_Order`, `ID_Table`, `Quantity`, `order_time`, `total_amount`, `note`, `ID_Account`, `ID_Promotion`, `status`) VALUES
(514, 1, NULL, '2025-06-04 20:04:38.397000', 98000.00, 'nhiều đá', NULL, NULL, 'completed'),
(515, NULL, NULL, '2025-06-04 20:05:14.259000', 253000.00, 'cà phê ít sữa', NULL, NULL, 'completed'),
(516, 2, NULL, '2025-06-04 20:07:03.756000', 91500.00, 'nhiều đá nha', 34, NULL, 'completed'),
(517, NULL, NULL, '2025-06-04 20:07:37.975000', 134100.00, '', 34, NULL, 'completed'),
(518, 3, NULL, '2025-06-04 20:08:22.760000', 165000.00, '', 34, NULL, 'cancelled'),
(528, NULL, NULL, '2025-09-28 00:00:14.000000', 70000.00, 'dfgdfg', 34, NULL, 'COMPLETED'),
(529, NULL, NULL, '2025-09-28 00:03:06.000000', 70000.00, NULL, 34, NULL, 'COMPLETED'),
(530, NULL, NULL, '2025-09-28 00:03:30.000000', 135000.00, NULL, 34, NULL, 'READY'),
(531, NULL, NULL, '2025-09-28 00:09:12.000000', 40000.00, '', NULL, NULL, 'READY'),
(532, NULL, NULL, '2025-09-28 00:17:32.000000', 210000.00, 'jhjkhkhjkl', 34, NULL, 'READY'),
(533, NULL, NULL, '2025-09-28 00:33:32.000000', 35000.00, NULL, 34, NULL, 'PREPARING'),
(534, NULL, NULL, '2025-09-28 01:15:36.000000', 35000.00, '', NULL, NULL, 'PREPARING'),
(535, NULL, NULL, '2025-09-28 01:28:14.000000', 70000.00, NULL, 34, NULL, 'READY'),
(536, NULL, NULL, '2025-09-28 01:54:05.000000', 340000.00, 'nhu a', 34, NULL, 'READY'),
(537, NULL, NULL, '2025-09-28 02:02:00.000000', 210000.00, 'faertere', 34, NULL, 'completed'),
(538, NULL, NULL, '2025-09-28 02:05:16.000000', 200000.00, 'fawew', 34, NULL, 'PREPARING'),
(539, NULL, NULL, '2025-09-28 02:08:13.000000', 120000.00, NULL, 34, NULL, 'processing'),
(540, NULL, NULL, '2025-09-28 02:20:59.000000', 35000.00, NULL, 34, NULL, 'processing'),
(541, NULL, NULL, '2025-09-28 02:23:42.000000', 40000.00, NULL, 34, NULL, 'processing'),
(542, NULL, NULL, '2025-09-28 02:29:19.000000', 105000.00, NULL, 34, NULL, 'processing'),
(543, NULL, NULL, '2025-09-28 02:33:36.000000', 75000.00, NULL, 34, NULL, 'processing'),
(544, NULL, NULL, '2025-09-28 02:35:35.000000', 40000.00, NULL, 34, NULL, 'processing'),
(545, NULL, NULL, '2025-09-28 02:44:03.000000', 100000.00, 'chan vccl', 34, NULL, 'processing'),
(546, NULL, NULL, '2025-09-28 02:52:44.000000', 35000.00, 'erfer', 34, NULL, 'processing'),
(547, NULL, NULL, '2025-09-28 02:57:19.000000', 105000.00, NULL, 34, NULL, 'processing'),
(548, NULL, NULL, '2025-09-28 03:04:06.000000', 70000.00, NULL, 34, NULL, 'processing'),
(549, NULL, NULL, '2025-09-28 03:06:22.000000', 175000.00, NULL, 34, NULL, 'processing'),
(550, NULL, NULL, '2025-09-28 03:09:55.000000', 40000.00, NULL, 34, NULL, 'processing'),
(551, NULL, NULL, '2025-09-28 03:11:43.000000', 40000.00, NULL, 34, NULL, 'processing'),
(552, NULL, NULL, '2025-09-28 03:14:22.000000', 70000.00, NULL, 34, NULL, 'processing'),
(553, NULL, NULL, '2025-09-28 03:17:39.000000', 70000.00, NULL, 34, NULL, 'processing'),
(554, NULL, NULL, '2025-09-28 03:18:46.000000', 175000.00, NULL, 34, NULL, 'processing'),
(555, NULL, NULL, '2025-09-28 03:27:56.000000', 35000.00, NULL, 34, NULL, 'processing'),
(556, NULL, NULL, '2025-09-28 03:37:14.000000', 70000.00, NULL, 34, NULL, 'completed'),
(557, NULL, NULL, '2025-09-28 03:38:34.000000', 35000.00, NULL, 34, NULL, 'processing'),
(558, NULL, NULL, '2025-09-28 03:41:47.000000', 70000.00, NULL, 34, NULL, 'processing'),
(559, NULL, NULL, '2025-09-28 03:42:32.000000', 35000.00, NULL, 34, NULL, 'processing'),
(560, NULL, NULL, '2025-09-28 04:20:11.000000', 40000.00, NULL, 34, NULL, 'processing'),
(561, NULL, NULL, '2025-09-28 04:24:25.000000', 70000.00, NULL, 34, NULL, 'processing'),
(562, NULL, NULL, '2025-09-28 04:26:26.000000', 40000.00, NULL, 34, NULL, 'completed'),
(563, NULL, NULL, '2025-09-28 14:19:56.000000', 70000.00, NULL, 34, NULL, 'processing');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cafetable`
--

CREATE TABLE `cafetable` (
  `ID_Table` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `Capacity` int(11) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `table_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `cafetable`
--

INSERT INTO `cafetable` (`ID_Table`, `status`, `Capacity`, `location`, `table_number`) VALUES
(1, 'Available', 5, 'Outdoor', 1),
(2, 'Occupied', 2, 'First Floor', 2),
(3, 'Occupied', 4, 'Ground Floor', 3),
(4, 'Available', 4, 'Ground Floor', 4),
(5, 'Available', 7, 'Ground Floor', 5),
(6, 'Available', 2, 'First Floor', 6),
(7, 'Available', 4, 'First Floor', 7),
(8, 'Available', 8, 'First Floor', 8),
(9, 'Available', 2, 'Outdoor', 9),
(10, 'Available', 4, 'Outdoor', 10),
(11, 'Available', 3, 'First Floor', 11),
(12, 'Available', 6, 'Ground Floor', 12),
(13, 'Available', 8, 'Ground Floor', 13),
(18, 'Available', 10, 'Ground Floor', 14),
(19, 'Available', 7, 'Ground Floor', 15);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

CREATE TABLE `category` (
  `ID_Category` int(11) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`ID_Category`, `category_name`, `description`) VALUES
(1, 'Cà Phê', 'Các loại cà phê nóng và lạnh'),
(2, 'Trà', 'Các loại trà thơm ngon'),
(3, 'Bánh', 'Các loại bánh mì và bánh ngọt'),
(4, 'Tráng Miệng', 'Các loại tráng miệng ngọt ngào'),
(5, 'Sinh Tố', 'Các loại sinh tố mát lạnh');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_detail`
--

CREATE TABLE `order_detail` (
  `ID_Product` int(11) NOT NULL,
  `ID_Order` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `unit_price` decimal(38,2) DEFAULT NULL,
  `subtotal` decimal(38,2) DEFAULT NULL,
  `size` varchar(5) DEFAULT 'S',
  `ice_percent` varchar(10) DEFAULT '100',
  `sugar_percent` varchar(10) DEFAULT '100',
  `toppings` varchar(255) DEFAULT NULL,
  `additional_price` decimal(10,2) DEFAULT 0.00,
  `variant_note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `order_detail`
--

INSERT INTO `order_detail` (`ID_Product`, `ID_Order`, `Quantity`, `unit_price`, `subtotal`, `size`, `ice_percent`, `sugar_percent`, `toppings`, `additional_price`, `variant_note`) VALUES
(1, 514, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 516, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 528, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 533, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 535, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 537, 6, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 543, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 545, 2, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 546, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 547, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 548, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 549, 2, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 553, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 554, 2, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 555, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 556, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 557, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 558, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 561, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(1, 563, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 514, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 516, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 528, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 530, 3, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 534, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 535, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 540, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 542, 3, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 547, 2, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 548, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 549, 3, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 553, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 554, 3, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 556, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 558, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 559, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 561, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(2, 563, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 514, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 515, 2, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 529, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 531, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 536, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 538, 5, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 541, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 543, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 544, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 550, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 551, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 552, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 560, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(3, 562, 1, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(4, 514, 1, 30000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(4, 529, 1, 30000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(4, 530, 1, 30000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(4, 532, 7, 30000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(4, 536, 10, 30000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(4, 539, 4, 30000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(4, 545, 1, 30000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(4, 552, 1, 30000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(7, 515, 3, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(8, 518, 2, 30000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(18, 517, 2, 40000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(20, 517, 2, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(44, 516, 1, 52000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(46, 515, 2, 34000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(47, 518, 2, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(48, 518, 1, 35000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL),
(62, 517, 1, 30000.00, NULL, 'S', '100', '100', NULL, 0.00, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payment`
--

CREATE TABLE `payment` (
  `ID_Payment` int(11) NOT NULL,
  `ID_Order` int(11) DEFAULT NULL,
  `create_at` datetime(6) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `payment`
--

INSERT INTO `payment` (`ID_Payment`, `ID_Order`, `create_at`, `payment_method`, `payment_status`) VALUES
(303, 514, '2025-06-04 20:04:38.397000', 'cash', 'completed'),
(304, 515, '2025-06-04 20:05:14.259000', 'transfer', 'completed'),
(305, 516, '2025-06-04 20:07:03.757000', 'transfer', 'completed'),
(306, 517, '2025-06-04 20:07:37.976000', 'transfer', 'completed'),
(307, 518, '2025-06-04 20:08:22.761000', 'cash', 'completed'),
(308, 528, '2025-09-28 00:00:14.000000', 'cash', 'completed'),
(309, 529, '2025-09-28 00:03:06.000000', 'cash', 'completed'),
(310, 530, '2025-09-28 00:03:30.000000', 'cash', 'completed'),
(311, 531, '2025-09-28 00:09:12.000000', 'cash', 'completed'),
(312, 532, '2025-09-28 00:17:32.000000', 'cash', 'completed'),
(313, 533, '2025-09-28 00:33:32.000000', 'cash', 'completed'),
(314, 534, '2025-09-28 01:15:36.000000', 'cash', 'completed'),
(315, 535, '2025-09-28 01:28:14.000000', 'cash', 'completed'),
(316, 536, '2025-09-28 01:54:05.000000', 'cash', 'completed'),
(317, 537, '2025-09-28 02:02:00.000000', 'cash', 'completed'),
(318, 538, '2025-09-28 02:05:16.000000', 'cash', 'completed'),
(319, 539, '2025-09-28 02:08:13.000000', 'cash', 'completed'),
(320, 540, '2025-09-28 02:20:59.000000', 'cash', 'completed'),
(321, 541, '2025-09-28 02:23:42.000000', 'cash', 'completed'),
(322, 542, '2025-09-28 02:29:19.000000', 'cash', 'completed'),
(323, 543, '2025-09-28 02:33:36.000000', 'cash', 'completed'),
(324, 544, '2025-09-28 02:35:35.000000', 'transfer', 'completed'),
(325, 545, '2025-09-28 02:44:03.000000', 'cash', 'completed'),
(326, 546, '2025-09-28 02:52:44.000000', 'cash', 'completed'),
(327, 547, '2025-09-28 02:57:19.000000', 'cash', 'completed'),
(328, 548, '2025-09-28 03:04:06.000000', 'cash', 'completed'),
(329, 549, '2025-09-28 03:06:22.000000', 'cash', 'completed'),
(330, 550, '2025-09-28 03:09:55.000000', 'cash', 'completed'),
(331, 551, '2025-09-28 03:11:43.000000', 'cash', 'completed'),
(332, 552, '2025-09-28 03:14:22.000000', 'cash', 'completed'),
(333, 553, '2025-09-28 03:17:39.000000', 'cash', 'completed'),
(334, 554, '2025-09-28 03:18:46.000000', 'cash', 'completed'),
(335, 555, '2025-09-28 03:27:56.000000', 'cash', 'completed'),
(336, 556, '2025-09-28 03:37:14.000000', 'cash', 'completed'),
(337, 557, '2025-09-28 03:38:34.000000', 'cash', 'completed'),
(338, 558, '2025-09-28 03:41:47.000000', 'cash', 'completed'),
(339, 559, '2025-09-28 03:42:32.000000', 'transfer', 'completed'),
(340, 560, '2025-09-28 04:20:11.000000', 'cash', 'completed'),
(341, 561, '2025-09-28 04:24:25.000000', 'cash', 'completed'),
(342, 562, '2025-09-28 04:26:26.000000', 'cash', 'completed'),
(343, 563, '2025-09-28 14:19:56.000000', 'cash', 'completed');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `ID_Product` int(11) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `Is_Available` tinyint(1) DEFAULT 1,
  `ID_Category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`ID_Product`, `product_name`, `price`, `description`, `image`, `Is_Available`, `ID_Category`) VALUES
(1, 'Espresso', 35000, 'Cà phê đậm đặc pha bằng cách ép nước qua hạt cà phê xay mịn', '1_a572645e-1c86-45ff-b251-d1f15e6e8011.jpg', 1, 1),
(2, 'Cappuccino', 35000, 'Cà phê Espresso trộn với sữa nóng và bọt sữa', '2_64cd49bb-4469-475a-bc82-4fd0da357cd7.jpg', 1, 1),
(3, 'Latte', 40000, 'Cà phê Espresso với nhiều sữa nóng và một ít bọt sữa', '3_827b8004-689e-419b-b8d1-dcca842a30c0.jpg', 1, 1),
(4, 'Americano', 30000, 'Cà phê Espresso pha loãng với nước nóng', '4_a6266c21-f539-4efd-a5ef-327e42d80bf6.jpg', 1, 1),
(5, 'Mocha', 45000, 'Cà phê Espresso với sữa nóng, socola và bọt sữa', '5_d33183bf-adec-4a43-ad15-f8a7ff23cdc1.jpg', 1, 1),
(7, 'Trà đào', 35000, 'Trà đen pha với đào tươi và siro đào', '7_40099dde-5664-46c2-9e68-a17c12fafbc5.jpg', 1, 2),
(8, 'Trà sữa', 30000, 'Trà sữa kem muối', '8_0088d818-ab60-4b4b-8727-bc5b29bec263.jpg', 1, 2),
(11, 'Bánh Mousse Gấu', 32000, 'Bánh mì giòn với pate gan', '11_9d3a325f-c73a-4a70-bdf3-5dab1f2e5669.jpg', 1, 3),
(12, 'Croissant', 25000, 'Bánh croissant bơ truyền thống', '12_3e4810c1-ebda-4202-a936-becb3d01eed2.jpg', 1, 3),
(14, 'Croissant trứng muối', 32000, 'Bánh Croissant thơm ngon', '14_47b1d9a2-55db-442d-8c7d-dff82711b316.jpg', 1, 3),
(17, 'Tiramisu', 45000, 'Bánh tiramisu với cà phê và phô mai mascarpone', '17_84a40fd2-4fb0-4523-aa07-abacde51ea33.jpg', 1, 4),
(18, 'Cheesecake', 40000, 'Bánh phô mai mịn với đế bánh giòn', '18_7e602351-6ce9-4de4-a570-b30265aceb69.jpg', 1, 4),
(20, 'Panna Cotta', 35000, 'Tráng miệng Ý với kem tươi và sốt dâu', '20_f927acbf-fc6b-4d56-b81b-b818e3b9a365.png', 1, 4),
(21, 'Sinh tố xoài', 35000, 'Sinh tố xoài mát lạnh', '21_c2c3141e-f101-4a19-ba19-9d4c633cd148.jpg', 1, 5),
(22, 'Sinh tố dâu', 40000, 'Sinh tố dâu tây tươi ngon', '22_76b1ef27-7b7d-48f6-8f78-09e7a7e7f718.jpg', 1, 5),
(23, 'Sinh tố bơ', 45000, 'Sinh tố bơ béo ngậy', '23_5687bf72-d8ca-4e7c-a6f4-8269feb6e5f9.avif', 1, 5),
(30, 'Frosty Caramel Arabica', 30000, 'Ngonn', '30_9a317ad8-000e-4750-92f9-2c3103638ea9.jpg', 1, 4),
(31, 'Frosty Trà Xanh', 32000, 'Ngonn', '31_54133549-7a10-4756-8672-0e0ae02ba9e7.jpg', 1, 4),
(44, 'Bạc xỉu nóng', 32000, 'Cà phê siêu thơm ngon', '44_b3e603d7-15af-4788-a97e-fc2d4b026083.jpg', 1, 1),
(46, 'Cà phê bơ', 34000, 'Cà phê đen kết hợp bơ dẻo siêu ngon', '46_bd23839f-b0de-4095-a37c-a4fd86a28356.jpg', 1, 1),
(47, 'Trà ô long tứ quý', 35000, 'Trà Oolong thượng hạng', '47_40d3832c-b2f4-413c-9749-c63c62496db2.jpg', 1, 2),
(48, 'Trà Olong tứ quý', 35000, 'Trà ô long tứ quý với những hạt chân châu giòn', '48_18fefc72-23ce-4b85-a471-e8757b984475.jpg', 1, 2),
(49, 'Chà bông phô mai', 32000, 'Bánh chà bông thơm ngon kết hợp chà bông mặn ngọt', '49_31f9ef15-39e1-4312-a377-709fd603636e.jpg', 1, 3),
(62, 'Sinh tố dưa hấu', 30000, 'Sinh tố quốc dân', '62_2d7b5503-857f-47e6-aedb-9e85a758631d.png', 1, 5);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_variants`
--

CREATE TABLE `product_variants` (
  `id_variant` int(11) NOT NULL,
  `additional_price` double DEFAULT NULL,
  `display_order` int(11) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  `variant_name` varchar(255) NOT NULL,
  `variant_type` varchar(255) NOT NULL,
  `variant_value` varchar(255) NOT NULL,
  `id_category` int(11) DEFAULT NULL,
  `id_product` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `product_variants`
--

INSERT INTO `product_variants` (`id_variant`, `additional_price`, `display_order`, `is_default`, `variant_name`, `variant_type`, `variant_value`, `id_category`, `id_product`) VALUES
(1, 0, 1, 1, 'Size S', 'size', 'S', 1, NULL),
(2, 5000, 2, 0, 'Size M', 'size', 'M', 1, NULL),
(3, 10000, 3, 0, 'Size L', 'size', 'L', 1, NULL),
(4, 0, 1, 1, '100% đá', 'ice', '100', 1, NULL),
(5, 0, 2, 0, '70% đá', 'ice', '70', 1, NULL),
(6, 0, 3, 0, 'Không đá', 'ice', '0', 1, NULL),
(7, 0, 1, 1, '100% đường', 'sugar', '100', 1, NULL),
(8, 0, 2, 0, '50% đường', 'sugar', '50', 1, NULL),
(9, 0, 3, 0, 'Không đường', 'sugar', '0', 1, NULL),
(10, 10000, 1, 0, 'Trân châu đen', 'topping', 'tranchau', 1, NULL),
(11, 15000, 2, 0, 'Bánh flan', 'topping', 'flan', 1, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `promotion`
--

CREATE TABLE `promotion` (
  `ID_Promotion` int(11) NOT NULL,
  `Name_Promotion` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  `Is_Active` tinyint(1) DEFAULT 1,
  `discount_type` varchar(255) DEFAULT NULL,
  `discount_value` decimal(38,2) DEFAULT NULL,
  `minimum_order_amount` decimal(38,2) DEFAULT NULL,
  `maximum_discount` decimal(38,2) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `promotion`
--

INSERT INTO `promotion` (`ID_Promotion`, `Name_Promotion`, `code`, `Start_Date`, `End_Date`, `Is_Active`, `discount_type`, `discount_value`, `minimum_order_amount`, `maximum_discount`, `description`) VALUES
(1, 'Khuyễn mãi đặc biệt hè', 'SUMMER23', '2025-05-07', '2026-05-09', 1, 'PERCENT', 25.00, 30000.00, NULL, NULL),
(2, 'Giảm giá 25% cho các loại đồ uống', 'THAGA25', '2025-05-07', '2025-06-09', 1, 'PERCENT', 30.00, 20000.00, NULL, NULL),
(3, 'Khách Hàng Mới', 'BANMOI', '2025-05-07', '2025-05-09', 0, 'PERCENT', 80.00, 50000.00, NULL, NULL),
(4, 'DAC BIET THANG 5', 'DACBIET', '2025-05-11', '2025-06-10', 1, 'PERCENT', 99.00, NULL, NULL, NULL),
(5, 'Khuyễn mãi hè 2025', 'HESOIDONG', '2025-05-13', '2026-06-13', 1, 'FIXED', 25000.00, 50000.00, NULL, NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`ID_Account`);

--
-- Chỉ mục cho bảng `cafeorder`
--
ALTER TABLE `cafeorder`
  ADD PRIMARY KEY (`ID_Order`),
  ADD KEY `idx_cafeorder_table` (`ID_Table`),
  ADD KEY `idx_cafeorder_account` (`ID_Account`),
  ADD KEY `idx_cafeorder_promo` (`ID_Promotion`);

--
-- Chỉ mục cho bảng `cafetable`
--
ALTER TABLE `cafetable`
  ADD PRIMARY KEY (`ID_Table`);

--
-- Chỉ mục cho bảng `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`ID_Category`);

--
-- Chỉ mục cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`ID_Product`,`ID_Order`),
  ADD KEY `idx_od_order` (`ID_Order`);

--
-- Chỉ mục cho bảng `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`ID_Payment`),
  ADD UNIQUE KEY `UK_payment_order` (`ID_Order`),
  ADD KEY `idx_payment_order` (`ID_Order`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ID_Product`),
  ADD KEY `ID_Category` (`ID_Category`);

--
-- Chỉ mục cho bảng `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id_variant`),
  ADD KEY `pv_fk_category` (`id_category`),
  ADD KEY `pv_fk_product` (`id_product`);

--
-- Chỉ mục cho bảng `promotion`
--
ALTER TABLE `promotion`
  ADD PRIMARY KEY (`ID_Promotion`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `account`
--
ALTER TABLE `account`
  MODIFY `ID_Account` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT cho bảng `cafeorder`
--
ALTER TABLE `cafeorder`
  MODIFY `ID_Order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=564;

--
-- AUTO_INCREMENT cho bảng `cafetable`
--
ALTER TABLE `cafetable`
  MODIFY `ID_Table` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `category`
--
ALTER TABLE `category`
  MODIFY `ID_Category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `payment`
--
ALTER TABLE `payment`
  MODIFY `ID_Payment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=344;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `ID_Product` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT cho bảng `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id_variant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `promotion`
--
ALTER TABLE `promotion`
  MODIFY `ID_Promotion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `cafeorder`
--
ALTER TABLE `cafeorder`
  ADD CONSTRAINT `cafeorder_fk_account` FOREIGN KEY (`ID_Account`) REFERENCES `account` (`ID_Account`) ON DELETE SET NULL,
  ADD CONSTRAINT `cafeorder_fk_promo` FOREIGN KEY (`ID_Promotion`) REFERENCES `promotion` (`ID_Promotion`) ON DELETE SET NULL,
  ADD CONSTRAINT `cafeorder_fk_table` FOREIGN KEY (`ID_Table`) REFERENCES `cafetable` (`ID_Table`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_fk_order` FOREIGN KEY (`ID_Order`) REFERENCES `cafeorder` (`ID_Order`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_detail_fk_product` FOREIGN KEY (`ID_Product`) REFERENCES `product` (`ID_Product`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_fk_order` FOREIGN KEY (`ID_Order`) REFERENCES `cafeorder` (`ID_Order`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_fk_category` FOREIGN KEY (`ID_Category`) REFERENCES `category` (`ID_Category`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `product_variants`
--
ALTER TABLE `product_variants`
  ADD CONSTRAINT `pv_fk_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`ID_Category`) ON DELETE SET NULL,
  ADD CONSTRAINT `pv_fk_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`ID_Product`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
