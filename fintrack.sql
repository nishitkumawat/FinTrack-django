-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 19, 2025 at 02:26 PM
-- Server version: 11.6.2-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fintrack`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(2, 'pbkdf2_sha256$870000$87dsglc4yhGSIttF6hjwmi$6NXk8L4ZJ7bna2LRpKgC6UBVg7AwiJZhi1h1zZPn9lk=', '2025-01-22 17:11:46.064534', 0, 'chamundasteels', '', '', 'fahfh@gm.c', 0, 1, '2025-01-22 13:06:53.447742'),
(3, 'pbkdf2_sha256$870000$fpWxAcNSWRE9XRlHik3W6V$rFFvuEHfimRhqF2RUr/2KrdJiKmK1paWPLmpMCOaw44=', '2025-01-23 15:54:57.905980', 0, 'ad', '', '', 'ad@gmail.com', 0, 1, '2025-01-22 17:13:17.893759'),
(8, 'pbkdf2_sha256$870000$BYoJ5udFPmo6QDMCI6vH9n$sIITBBnGOYUGR7f8tiyC2X0WIUL1T83JwZXChcrFXGg=', '2025-01-23 16:16:25.489187', 0, 'nk6', '', '', 'nishit10124657760@gmail.com', 0, 1, '2025-01-23 16:16:15.393204'),
(9, 'pbkdf2_sha256$870000$yXdK2ICBVnEL0RLEIOxk15$C9DYqe4ggfVP102UZwaBhE9jc36FWMzGYlW1Bf4aX+M=', '2025-02-01 19:10:01.258694', 1, 'admin', '', '', 'admin@as.co', 1, 1, '2025-01-23 16:21:07.325913'),
(10, 'pbkdf2_sha256$870000$dIlzFrW38Wk0H43PEwf5w9$LjIU2kUz1SWVXRr+HWwK4VM/VNxvIVl/pMOn0Y2CTOA=', '2025-01-23 16:23:06.934283', 0, 'nk2', '', '', 'nishit1060@gmail.com0', 0, 1, '2025-01-23 16:22:36.433630'),
(11, 'pbkdf2_sha256$870000$eFrQqh8oqGHX1UeUvlwUq0$IRoTL8//z1dfajdeF0UeqUJB+aVVQechWkOlRtUYRk8=', '2025-02-19 13:25:01.638834', 0, 'nishit', '', '', 'nishi00t1060@gmail.com', 0, 1, '2025-01-30 04:36:59.055232'),
(12, 'pbkdf2_sha256$870000$PUQsIml5TEFdFX5XiWNmsA$DgILa8eKryTR2HLvqlrx2fScwTo3hSX+5onp+WBMVu0=', '2025-02-04 16:17:49.837870', 0, 'ad1', '', '', 'ni3shit1060@gmail.com', 0, 1, '2025-02-04 16:17:40.280624'),
(13, 'pbkdf2_sha256$870000$Ue2Z0OoE4APIRuEjqGLwYF$EIoz+in1WhSR0KZzb606ifQWXW8iqxn15wdSd3HDWvY=', '2025-02-11 16:57:46.157234', 0, 'chamunda', '', '', 'chamundas@gmail.com', 0, 1, '2025-02-11 16:50:58.591159'),
(14, 'pbkdf2_sha256$870000$MGjgbmSb3zRNR8WxUdhknf$5LPfZmIy2qMAUd6+9dq5nb9KRmUa5GdveQ6pPYRG7xc=', '2025-02-11 16:59:06.274483', 0, 'kmm', '', '', 'kmm@gmail.com', 0, 1, '2025-02-11 16:58:55.578658'),
(15, 'pbkdf2_sha256$870000$U94YcFL7iC5CTjzLumOE79$yZYFc6BywXat0MsmPnqTg5FOkpdB+TVvHzxZepFxW6U=', '2025-02-11 17:01:59.956223', 0, 'abcorg', '', '', 'abc@gmail.com', 0, 1, '2025-02-11 17:01:45.520712'),
(16, 'pbkdf2_sha256$870000$QEhtzKYe9jNYWQaAIXooML$HG9UGO6ps2I3UxWxFLBlcC6UNBxcd8bVxsX3I3OlpoM=', NULL, 0, 'ergsdva', '', '', 'nishit1060@gmail.com', 0, 1, '2025-02-11 17:08:53.513017'),
(17, 'pbkdf2_sha256$870000$tuDn4Q3GXA9wJkXyeoGp8v$xtuTS1XwpaQn9tZnYW9wOklR2ar3YaNFSWIINtzDhrk=', '2025-02-11 17:10:07.560079', 1, 'nk123', '', '', 'nk123@gmail.com', 1, 1, '2025-02-11 17:09:48.428317'),
(18, 'pbkdf2_sha256$870000$858WH3R1YWaMMQi9Z27EUK$ZXKQnm2RI38NELT2jINFxp2oiXU3U3bhcuiP+ACeJ30=', '2025-02-13 13:02:44.943829', 0, 'fist', '', '', 'fist@gmail.com', 0, 1, '2025-02-13 13:02:37.769215'),
(19, 'pbkdf2_sha256$870000$c1RQtMPwtzVNXMREAOvFKg$Z1EO6j2mLfjLvdZXrEN7VQX+p22i5lOQ9kge74ICEPo=', NULL, 0, 'chamundasteels1111', '', '', 'nishit@gmail.com', 0, 1, '2025-02-19 13:08:53.695757'),
(20, 'pbkdf2_sha256$870000$44pGEugOdfdmDh2k03fz5n$uQ8YWkh46LPqUhJvtZtHHeRu75VEeNXCw3/VFGSQ9tk=', '2025-02-19 13:25:16.150331', 0, 'chamundasteels123', '', '', 'nishit1354564@gmail.com', 0, 1, '2025-02-19 13:09:48.371038');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-01-23 16:22:07.226242', '1', 'nk2', 3, '', 4, 9),
(2, '2025-01-23 16:22:07.226242', '5', 'nk3', 3, '', 4, 9),
(3, '2025-01-23 16:22:07.226242', '6', 'nk4', 3, '', 4, 9),
(4, '2025-01-23 16:22:07.226242', '7', 'nk5', 3, '', 4, 9),
(5, '2025-01-23 16:22:07.226242', '4', 'yk', 3, '', 4, 9);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-01-22 12:25:49.579998'),
(2, 'auth', '0001_initial', '2025-01-22 12:25:49.968529'),
(3, 'admin', '0001_initial', '2025-01-22 12:25:50.041591'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-01-22 12:25:50.048591'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-01-22 12:25:50.057638'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-01-22 12:25:50.155552'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-01-22 12:25:50.185261'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-01-22 12:25:50.211614'),
(9, 'auth', '0004_alter_user_username_opts', '2025-01-22 12:25:50.220332'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-01-22 12:25:50.254220'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-01-22 12:25:50.255916'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-01-22 12:25:50.264015'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-01-22 12:25:50.288466'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-01-22 12:25:50.311156'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-01-22 12:25:50.331694'),
(16, 'auth', '0011_update_proxy_permissions', '2025-01-22 12:25:50.340320'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-01-22 12:25:50.368175'),
(18, 'sessions', '0001_initial', '2025-01-22 12:25:50.401714');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('1f7y4f3ji463qcvofnmjjawoed2q1mpx', '.eJxVjDsOwyAQBe9CHSE-xkDK9D4DWnYhOImwZOwqyt2DJRdJOzPvvVmAfSthb2kNM7Erk5JdfmEEfKZ6GHpAvS8cl7qtc-RHwk_b-LRQet3O9u-gQCt97YW2LosBpAaffBoVWMSsROowjhkHp7QyAESCXJZWgzC9U1ITGfTs8wUIbjha:1tizvo:yQMCx8jQO2ZVuyODzaHrUb8HwIeEEtcv_ss9Y2mbSNQ', '2025-02-28 17:56:52.913906'),
('2v7qm4zbm9czs7uq6su9mvae5oaex1bx', '.eJxVjDsOwyAQBe9CHSE-xkDK9D4DWnYhOImwZOwqyt2DJRdJOzPvvVmAfSthb2kNM7Erk5JdfmEEfKZ6GHpAvS8cl7qtc-RHwk_b-LRQet3O9u-gQCt97YW2LosBpAaffBoVWMSsROowjhkHp7QyAESCXJZWgzC9U1ITGfTs8wUIbjha:1tgooA:Tz7nlq7kLywldcSk0X5ULdBsB5zO3ub4XufByoghGk0', '2025-02-22 17:39:58.429969'),
('gotnr23wftsbtk2uvoxdqao9zungw2ku', '.eJxVjDsOwyAQBe9CHSE-xkDK9D4DWnYhOImwZOwqyt2DJRdJOzPvvVmAfSthb2kNM7Erk5JdfmEEfKZ6GHpAvS8cl7qtc-RHwk_b-LRQet3O9u-gQCt97YW2LosBpAaffBoVWMSsROowjhkHp7QyAESCXJZWgzC9U1ITGfTs8wUIbjha:1tiYs5:YL4_A_EOhESfMAjVVECXpXQ1YOaofOg8-fNZ2mBwmew', '2025-02-27 13:03:13.753137'),
('ypfqe5ahr4vbsjxl826avuh3i3dnal86', '.eJxVjEsOwjAMBe-SNYpiJ3FSluw5QxXbgRZQK_WzQtydVuoCtjPz3tu0ZV26dp3r1PZqzgadOf1CLvKsw270UYb7aGUclqlnuyf2sLO9jlpfl6P9O-jK3G1rTsmXWDm6KIGg8aCZCNihchBqQH0gf8OMAoLssXAVwGZDkBMF8_kC7A83Lw:1tkk4i:kTiSip6Yn71xu5zsxXQ8pmjaaoFWbJXZrgx8z5ad4cA', '2025-03-05 13:25:16.160404');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `company_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_name` varchar(300) NOT NULL,
  `item_quantity` int(11) NOT NULL,
  `item_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`company_id`, `item_id`, `item_name`, `item_quantity`, `item_price`) VALUES
(5, 1, 'bike', 94, 1000),
(5, 2, 'car', 44, 555),
(5, 3, 'ABC', 47, 100),
(5, 4, 'Fruits', 50, 68),
(5, 5, 'shoes', 50, 500),
(13, 1, 'boots', 50, 550),
(13, 2, 'socks', 490, 200);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `company_id` int(11) NOT NULL,
  `invoice_no` int(11) NOT NULL,
  `biller_name` varchar(100) NOT NULL,
  `biller_address` varchar(300) NOT NULL,
  `biller_phoneno` varchar(30) NOT NULL,
  `date` varchar(30) NOT NULL,
  `payment_mode` varchar(30) NOT NULL,
  `selected_items` varchar(30) NOT NULL,
  `total` float NOT NULL,
  `grand_total` float NOT NULL,
  `biller_gst_no` varchar(30) NOT NULL,
  `buyer_order_no` int(11) NOT NULL,
  `eWay_bill_number` varchar(30) NOT NULL,
  `eWay_bill_date` varchar(30) NOT NULL,
  `bill_of_lading` varchar(100) NOT NULL,
  `motor_vechile_number` varchar(30) NOT NULL,
  `ref_no` varchar(30) NOT NULL,
  `other_ref` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`company_id`, `invoice_no`, `biller_name`, `biller_address`, `biller_phoneno`, `date`, `payment_mode`, `selected_items`, `total`, `grand_total`, `biller_gst_no`, `buyer_order_no`, `eWay_bill_number`, `eWay_bill_date`, `bill_of_lading`, `motor_vechile_number`, `ref_no`, `other_ref`) VALUES
(5, 1, 'sad', 'asd', '31432', '2025-02-08', 'Cash', '[{\"id\": \"5\", \"name\": \"qwdqe\", ', 10, 10, '', 0, '', '', '', '', '', ''),
(5, 2, 'ascas', 'dsf', '31432', '2025-02-08', 'UPI', '[{\"id\": \"3\", \"name\": \"car\", \"q', 5660, 6678.8, '', 0, '', '', '', '', '', ''),
(5, 3, 'sad', 'asd', '31432', '2025-02-08', 'Bank Transfer', '[{\"id\": \"1\", \"name\": \"sgr\", \"q', 110, 129.8, '', 0, '', '', '', '', '', ''),
(5, 4, 'sbd', 'fbd', 'fbgdf', '2025-02-15', 'UPI', '[{\"id\": \"3\", \"name\": \"ABC\", \"q', 8000, 8000, '', 0, '', '', '', '', '', ''),
(5, 5, 'Kunal', '77', '9104513411', '2025-02-19', 'Cash', '[{\"id\": \"2\", \"name\": \"car\", \"q', 2000, 2360, '', 0, '', '', '', '', '', ''),
(5, 6, 'Kunj', '56454', '989743411', '2025-02-19', 'Check', '[{\"id\": \"4\", \"name\": \"Fruits\",', 100, 118, '', 0, '', '', '', '', '', ''),
(5, 7, 'sad', '56', '465', '2025-02-19', 'Bank Transfer', '[{\"id\": \"1\", \"name\": \"bike\", \"', 46, 46, '', 0, '', '', '', '', '', ''),
(5, 8, '12e', 'sfd', '31432', '2025-02-19', 'UPI', '[{\"id\": \"4\", \"name\": \"Fruits\",', 888, 888, '', 0, '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `sell`
--

CREATE TABLE `sell` (
  `company_id` int(11) NOT NULL,
  `invoice_no` int(11) NOT NULL,
  `sell_id` int(11) NOT NULL,
  `buyer_name` varchar(100) NOT NULL,
  `buyer_phone` varchar(30) NOT NULL,
  `buyer_gst` varchar(30) NOT NULL,
  `date` varchar(30) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `item_purchase_price` float NOT NULL,
  `item_rate` double NOT NULL,
  `item_quantity` double NOT NULL,
  `item_amount` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sell`
--

INSERT INTO `sell` (`company_id`, `invoice_no`, `sell_id`, `buyer_name`, `buyer_phone`, `buyer_gst`, `date`, `item_name`, `item_purchase_price`, `item_rate`, `item_quantity`, `item_amount`) VALUES
(5, 4, 13, 'sbd', 'fbgdf', '', '2025-02-15', 'ABC', 100, 2000, 2, 4000),
(5, 4, 14, 'sbd', 'fbgdf', '', '2025-02-15', 'car', 555, 2000, 2, 4000),
(5, 5, 15, 'Kunal', '9104513411', '', '2025-02-19', 'car', 555, 500, 2, 1000),
(5, 5, 16, 'Kunal', '9104513411', '', '2025-02-19', 'bike', 1000, 500, 2, 1000),
(5, 6, 17, 'Kunj', '989743411', '', '2025-02-19', 'Fruits', 68, 50, 1, 50),
(5, 6, 18, 'Kunj', '989743411', '', '2025-02-19', 'bike', 1000, 50, 1, 50),
(5, 7, 19, 'sad', '465', '', '2025-02-19', 'bike', 1000, 23, 1, 23),
(5, 7, 20, 'sad', '465', '', '2025-02-19', 'car', 555, 23, 1, 23),
(5, 8, 21, '12e', '31432', '', '2025-02-19', 'Fruits', 68, 222, 2, 444),
(5, 8, 22, '12e', '31432', '', '2025-02-19', 'bike', 1000, 222, 2, 444),
(13, 1, 23, 'Nishit', '91004513411', '', '2025-02-19', 'socks', 200, 250, 10, 2500);

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE `user_info` (
  `company_id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(30) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `company_name` varchar(300) NOT NULL,
  `company_address` varchar(300) NOT NULL,
  `gst_no` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_info`
--

INSERT INTO `user_info` (`company_id`, `username`, `email`, `password`, `phone`, `company_name`, `company_address`, `gst_no`) VALUES
(1, 'chamundasteels', 'nishittk@gmail.com', '12345', '9638527410', 'Chamunda Steels', 'dwdwevfdsvvrfdc', '24BVMP3162K'),
(2, 'ad', 'ad@gmail.com', '12345', '0910451341', 'Adidas', '\r\nk', 'wqeqwq123'),
(3, 'nk6', 'nishit10124657760@gmail.com', '123', '7104513411', 'Fastrack', '72 KRISHNADHAM ASSN OPP MAHESHWARI NAGAR\r\nTaxshila School', 'wqeqwq123'),
(4, 'nk2', 'nishit1060@gmail.com0', '12345', '', '', '', ''),
(5, 'nishit', 'nishi00t1060@gmail.com', '12', '0910451341', 'FASTRACK', '72 KRISHNADHAM ASSN OPP MAHESHWARI NAGAR\r\nTaxshila School', 'asfasdf'),
(7, 'ad1', 'ni3shit1060@gmail.com', '12', '0910451341', 'rw', 'Jsjsj\r\nJjsjsj', 'wqeqwq1232'),
(8, 'chamunda', 'chamundas@gmail.com', 'abc123', '0910451341', 'Fastrack', 'Jsjsj\r\nJjsjsj', 'asfasdf'),
(9, 'kmm', 'kmm@gmail.com', 'abc123', '0910451341', 'KMM', 'Jsjsj\r\nJjsjsj', 'bsefdevd'),
(10, 'abcorg', 'abc@gmail.com', 'abc123', '0910451341', 'ABC\\', '72 KRISHNADHAM ASSN OPP MAHESHWARI NAGAR\r\nTaxshila School', 'wqeqwq123'),
(11, 'fist', 'fist@gmail.com', '123', 'dsfs', 'FIST', 'gasedv\r\n', 'dsf'),
(13, 'chamundasteels123', 'nishit1354564@gmail.com', '12', '0910451341', 'Adidas', '72 KRISHNADHAM ASSN OPP MAHESHWARI NAGAR\r\nTaxshila School', 'wqeqwq1232'),
(14, '', '', '', '', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoice_no`);

--
-- Indexes for table `sell`
--
ALTER TABLE `sell`
  ADD PRIMARY KEY (`sell_id`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`company_id`),
  ADD UNIQUE KEY `username` (`username`,`email`,`phone`,`gst_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `sell`
--
ALTER TABLE `sell`
  MODIFY `sell_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
