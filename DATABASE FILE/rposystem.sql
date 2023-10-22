-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 22, 2023 at 06:35 AM
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
-- Database: `rposystem`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateOrder` (IN `p_customer_id` INT, IN `p_product_id` INT, IN `p_quantity` INT)   BEGIN
  -- Insert to the order details
  INSERT INTO rpos_orders (customer_id, prod_id, prod_qty, order_status, created_at)
  VALUES (p_customer_id, p_product_id, p_quantity, 'Pending', NOW());

  -- Calculate to the order total and update it
  SET @order_id = LAST_INSERT_ID();
  UPDATE rpos_orders
  SET order_total = (SELECT SUM(prod_price * prod_qty) FROM rpos_orders WHERE order_id = @order_id)
  WHERE order_id = @order_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rpos_admin`
--

CREATE TABLE `rpos_admin` (
  `admin_id` varchar(200) NOT NULL,
  `admin_name` varchar(200) NOT NULL,
  `admin_email` varchar(200) NOT NULL,
  `admin_password` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rpos_admin`
--

INSERT INTO `rpos_admin` (`admin_id`, `admin_name`, `admin_email`, `admin_password`) VALUES
('10e0b6dc958adfb5b094d8935a13aeadbe783c25', 'system Admin', 'ananda@gmail.com', '903b21879b4a60fc9103c3334e4f6f62cf6c3a2d');

-- --------------------------------------------------------

--
-- Table structure for table `rpos_customers`
--

CREATE TABLE `rpos_customers` (
  `customer_id` varchar(200) NOT NULL,
  `customer_name` varchar(200) NOT NULL,
  `customer_phoneno` varchar(200) NOT NULL,
  `customer_email` varchar(200) NOT NULL,
  `customer_password` varchar(200) NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rpos_customers`
--

INSERT INTO `rpos_customers` (`customer_id`, `customer_name`, `customer_phoneno`, `customer_email`, `customer_password`, `created_at`) VALUES
('06549ea58afd', 'Yashod Mendis', '4589698780', 'yashod@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:17:17.950274'),
('1fc1f694985d', 'Wasana Perera', '2145896547', 'wasana@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:14:51.760423'),
('27e4a5bc74c2', 'Malshi Liyanage', '4589654780', 'malshi@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:19:54.214951'),
('29c759d624f9', 'Prasitha Samararachchi', '5896321002', 'Prasitha@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:16:35.663576'),
('35135b319ce3', 'Lahiru Senavirathna', '7412569698', 'lahiru@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:13:18.462103'),
('3859d26cd9a5', 'Pasidu Perera', '7856321000', 'pasindu@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:19:16.394962'),
('57b7541814ed', 'Sarith Fernando', '8745554589', 'sarith@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:24:46.437325'),
('7c8f2100d552', 'Ishanki Nipunika', '3210145550', 'ishanki@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:15:54.085489'),
('9c7fcc067bda', 'Senath Liyanage', '7850001256', 'senath@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:18:15.246955'),
('9f6378b79283', 'Tirosh Menuka', '7145665870', 'tirosh@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:17:44.232593'),
('d0ba61555aee', 'Codeshow Lapz', '4125556587', 'lapz@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:21:04.260264'),
('d7c2db8f6cbf', 'Sanduni Perera', '1458887896', 'sanduni@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 18:48:10.000111'),
('e711dcc579d9', 'Linuka Wikramasinha', '3245557896', 'linuka@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:18:47.926422'),
('fe6bb69bdd29', 'Thevidu Rathnayaka', '1020302055', 'thevindu@mail.com', '83353d597cbad458989f2b1a5c1fa1f9f665c858', '2023-10-21 14:15:26.950250');

-- --------------------------------------------------------

--
-- Table structure for table `rpos_orders`
--

CREATE TABLE `rpos_orders` (
  `order_id` varchar(200) NOT NULL,
  `order_code` varchar(200) NOT NULL,
  `customer_id` varchar(200) NOT NULL,
  `customer_name` varchar(200) NOT NULL,
  `prod_id` varchar(200) NOT NULL,
  `prod_name` varchar(200) NOT NULL,
  `prod_price` varchar(200) NOT NULL,
  `prod_qty` varchar(200) NOT NULL,
  `order_status` varchar(200) NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rpos_orders`
--

INSERT INTO `rpos_orders` (`order_id`, `order_code`, `customer_id`, `customer_name`, `prod_id`, `prod_name`, `prod_price`, `prod_qty`, `order_status`, `created_at`) VALUES
('019661e097', 'AEHM-0653', '06549ea58afd', 'Ana J. Browne', 'bd200ef837', 'Turkish Coffee', '8', '1', 'Paid', '2022-09-03 13:26:00.389027'),
('1ac3828044', 'THZC-4930', '3859d26cd9a5', 'Louise R. Holloman', '06dc36c1be', 'Vegetables', '7', '5', 'Paid', '2023-10-21 15:19:59.305930'),
('251188bcea', 'JNXG-9025', '1fc1f694985d', 'Wasana Perera', '06dc36c1be', 'Vegetables', '270', '5', '', '2023-10-22 03:33:21.378694'),
('49c1bd8086', 'IUSP-9453', 'fe6bb69bdd29', 'Brian S. Boucher', 'd57cd89073', 'Country Fried Steak', '10', '1', 'Paid', '2022-09-03 11:50:40.812796'),
('514ada5047', 'OTEV-8532', '3859d26cd9a5', 'Louise R. Holloman', '0c4b5c0604', 'Spaghetti Bolognese', '15', '1', 'Paid', '2022-09-03 13:13:39.042869'),
('5b855ea8cc', 'RXJG-9867', 'd7c2db8f6cbf', 'Sanduni Perera', '826e6f687f', 'Snacks ', '250', '6', '', '2023-10-22 02:52:29.794407'),
('61c84cebe8', 'QTGK-0217', '57b7541814ed', 'Sarith Fernando', '06dc36c1be', 'Vegetables', '270', '5', '', '2023-10-22 02:51:21.169863'),
('6466fd5ee5', 'COXP-6018', '7c8f2100d552', 'Melody E. Hance', '31dfcc94cf', 'Buffalo Wings', '11', '2', 'Paid', '2022-09-03 12:17:44.680896'),
('80ab270866', 'JFMB-0731', '35135b319ce3', 'Christine Moore', '97972e8d63', 'Irish Coffee', '11', '1', 'Paid', '2022-09-04 16:37:03.716697'),
('8815e7edfc', 'QOEH-8613', '29c759d624f9', 'Trina L. Crowder', '2b976e49a0', 'Cheeseburger', '3', '3', 'Paid', '2022-09-03 12:02:32.985451'),
('a27f1d87be', 'EJKA-4501', '35135b319ce3', 'Christine Moore', 'ec18c5a4f0', 'Corn Dogs', '4', '2', 'Paid', '2022-09-04 16:31:54.581984'),
('a74337db7e', 'ZPXD-6951', 'e711dcc579d9', 'Julie R. Martin', 'a5931158fe', 'Pulled Pork', '8', '2', 'Paid', '2022-09-03 13:12:47.079248'),
('ad8c6131fb', 'PDQX-4028', '35135b319ce3', 'Lahiru Senavirathna', 'f4ce3927bf', 'Stationery', '280', '5', '', '2023-10-21 18:55:00.672945'),
('af52d0022d', 'FNAB-9142', '35135b319ce3', 'Christine Moore', '2fdec9bdfb', 'Jambalaya', '9', '2', 'Paid', '2022-09-04 16:32:14.949302'),
('c051fc38eb', 'ONSY-2465', '57b7541814ed', 'Howard W. Anderson', '826e6f687f', 'Margherita Pizza', '12', '1', 'Paid', '2022-09-03 08:35:50.570496'),
('fc79a55455', 'INHG-0875', '9c7fcc067bda', 'Delbert G. Campbell', '3adfdee116', 'Enchiladas', '10', '1', 'Paid', '2022-09-04 16:35:22.539542');

--
-- Triggers `rpos_orders`
--
DELIMITER $$
CREATE TRIGGER `UpdateProductStockAfterOrder` AFTER INSERT ON `rpos_orders` FOR EACH ROW BEGIN
  UPDATE rpos_products
  SET prod_qty = prod_qty - NEW.prod_qty
  WHERE prod_id = NEW.prod_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UpdateSalesAfterOrderInsert` AFTER INSERT ON `rpos_orders` FOR EACH ROW BEGIN
    -- Update the sales data, e.g., increase total sales, update product stock, etc.
    -- Example: UPDATE rpos_products SET stock = stock - NEW.prod_qty WHERE prod_id = NEW.prod_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rpos_pass_resets`
--

CREATE TABLE `rpos_pass_resets` (
  `reset_id` int(20) NOT NULL,
  `reset_code` varchar(200) NOT NULL,
  `reset_token` varchar(200) NOT NULL,
  `reset_email` varchar(200) NOT NULL,
  `reset_status` varchar(200) NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rpos_pass_resets`
--

INSERT INTO `rpos_pass_resets` (`reset_id`, `reset_code`, `reset_token`, `reset_email`, `reset_status`, `created_at`) VALUES
(1, '63KU9QDGSO', '4ac4cee0a94e82a2aedc311617aa437e218bdf68', 'sysadmin@icofee.org', 'Pending', '2020-08-17 15:20:14.318643');

-- --------------------------------------------------------

--
-- Table structure for table `rpos_payments`
--

CREATE TABLE `rpos_payments` (
  `pay_id` varchar(200) NOT NULL,
  `pay_code` varchar(200) NOT NULL,
  `order_code` varchar(200) NOT NULL,
  `customer_id` varchar(200) NOT NULL,
  `pay_amt` varchar(200) NOT NULL,
  `pay_method` varchar(200) NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rpos_payments`
--

INSERT INTO `rpos_payments` (`pay_id`, `pay_code`, `order_code`, `customer_id`, `pay_amt`, `pay_method`, `created_at`) VALUES
('0bf592', '9UMWLG4BF8', 'EJKA-4501', '35135b319ce3', '8', 'Cash', '2022-09-04 16:31:54.525284'),
('4423d7', 'QWERT0YUZ1', 'JFMB-0731', '35135b319ce3', '11', 'Cash', '2022-09-04 16:37:03.655834'),
('442865', '146XLFSC9V', 'INHG-0875', '9c7fcc067bda', '10', 'Paypal', '2022-09-04 16:35:22.470600'),
('65891b', 'MF2TVJA1PY', 'ZPXD-6951', 'e711dcc579d9', '16', 'Cash', '2022-09-03 13:12:46.959558'),
('75ae21', '1QIKVO69SA', 'IUSP-9453', 'fe6bb69bdd29', '10', 'Cash', '2022-09-03 11:50:40.496625'),
('7d7b39', '184OB2UAWM', 'THZC-4930', '3859d26cd9a5', '35', 'Cash', '2023-10-21 15:19:59.301033'),
('7e1989', 'KLTF3YZHJP', 'QOEH-8613', '29c759d624f9', '9', 'Cash', '2022-09-03 12:02:32.926529'),
('968488', '5E31DQ2NCG', 'COXP-6018', '7c8f2100d552', '22', 'Cash', '2022-09-03 12:17:44.639979'),
('984539', 'LSBNK1WRFU', 'FNAB-9142', '35135b319ce3', '18', 'Paypal', '2022-09-04 16:32:14.852482'),
('9fcee7', 'AZSUNOKEI7', 'OTEV-8532', '3859d26cd9a5', '15', 'Cash', '2022-09-03 13:13:38.855058'),
('c81d2e', 'WERGFCXZSR', 'AEHM-0653', '06549ea58afd', '8', 'Cash', '2022-09-03 13:26:00.331494'),
('e46e29', 'QMCGSNER3T', 'ONSY-2465', '57b7541814ed', '12', 'Cash', '2022-09-03 08:35:50.172062');

-- --------------------------------------------------------

--
-- Table structure for table `rpos_products`
--

CREATE TABLE `rpos_products` (
  `prod_id` varchar(200) NOT NULL,
  `prod_code` varchar(200) NOT NULL,
  `prod_name` varchar(200) NOT NULL,
  `prod_img` varchar(200) NOT NULL,
  `prod_desc` longtext NOT NULL,
  `prod_price` varchar(200) NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rpos_products`
--

INSERT INTO `rpos_products` (`prod_id`, `prod_code`, `prod_name`, `prod_img`, `prod_desc`, `prod_price`, `created_at`) VALUES
('06dc36c1be', 'VEG-0101', 'Vegetables', '1.jpg', 'Vegetables are nutritious, plant-based foods that are a crucial part of a healthy diet. Packed with essential vitamins, minerals, and fiber, they contribute to overall well-being. They come in various colors, shapes, and flavors, offering a diverse range of culinary possibilities while promoting good health.', '270', '2023-10-21 14:27:18.984319'),
('0c4b5c0604', 'FRU-0202', 'Fruits', '2.jpg', 'Fruits are nature\'s sweet and nutritious gifts. They provide a rich source of essential vitamins, minerals, and dietary fiber, promoting a balanced diet and overall health. With a wide variety of flavors and colors, fruits are not only delicious but also a refreshing way to stay healthy and energized.', '180', '2023-10-21 14:28:18.091005'),
('14c7b6370e', 'BAB-0303', 'Baby Products', '3.png', 'Baby products encompass a range of essential items designed to cater to the needs of infants and toddlers. From diapers and baby food to clothing and strollers, these products ensure the well-being and comfort of babies. They are crafted with utmost care and safety to nurture the early stages of life.', '400', '2023-10-21 14:29:13.212218'),
('1e0fa41eee', 'DAI-0404', 'Dairy', '3.jpg', 'Baby dairy products refer to specially formulated milk-based items tailored to meet the nutritional requirements of infants and toddlers. These include baby formula, yogurt, and cheese designed to support healthy growth and development. Baby dairy products provide essential nutrients, such as calcium and protein, vital for a child\'s early stages of life.', '550', '2023-10-21 14:30:30.990107'),
('2b976e49a0', 'BEV-0505', 'Beverages', '4.png', 'Beverages encompass a wide range of liquid refreshments, from classic choices like water, tea, and coffee to soft drinks, juices, and alcoholic drinks. They offer various flavors and nutritional profiles, catering to diverse preferences and occasions. Beverages play a significant role in hydration, enjoyment, and social gatherings.', '350', '2023-10-21 14:31:56.731612'),
('2fdec9bdfb', 'CUP-0606', 'Food Cupboard', '5.jpg', 'The food cupboard category includes essential pantry items that are kitchen staples. It consists of items like canned goods, cooking ingredients, and non-perishable foods that have a long shelf life. These products are fundamental for everyday cooking and meal preparation, ensuring you have the basics on hand for various recipes.', '6500', '2023-10-21 14:33:07.410275'),
('31dfcc94cf', 'HOU-0707', 'Household', '6.jpeg', 'The household category comprises a wide range of everyday items and products essential for maintaining a clean and organized home. This category includes cleaning supplies, kitchenware, home decor, and more. Household products are designed to enhance daily living, ensure hygiene, and create a comfortable and functional living environment for all family members.', '1100', '2023-10-21 14:34:21.791422'),
('3adfdee116', 'COO-0808', 'Cooking Essentials', '7.jpg', 'Cooking Essentials include fundamental ingredients and kitchen staples that form the basis of countless recipes. These items typically include cooking oils, spices, herbs, flour, sugar, and other essentials necessary for preparing a variety of dishes. They are the building blocks of cooking, allowing for the creation of diverse and delicious meals.', '2500', '2023-10-21 14:35:15.332067'),
('3d19e0bf27', 'BAK-0909', 'Bakery', '8.jpg', 'Bakery products encompass a delectable array of baked goods such as bread, pastries, cakes, and cookies. These treats are crafted using a combination of flour, sugar, eggs, and other ingredients, resulting in a wide range of flavors and textures. Bakeries provide delightful options for those with a sweet tooth or a craving for fresh, savory bread.', '80', '2023-10-21 14:41:21.377671'),
('4e68e0dd49', 'MEA-1010', 'Meats', '9.png', 'Meats offer a diverse selection of animal-based protein sources, including beef, poultry, pork, and more. These protein-rich foods can be prepared in various ways, from grilling and roasting to frying and stewing. Meats are a staple in many cuisines, providing essential nutrients and flavors for a wide range of savory dishes.', '1200', '2023-10-21 14:42:17.382798'),
('5d66c79953', 'SEA-1212', 'Seafood', '25.jpeg', 'Seafood encompasses a vast array of aquatic delights, from fish and shellfish to crustaceans. Rich in essential nutrients like omega-3 fatty acids, seafood is not only delicious but also beneficial for heart health. Its versatility allows for grilling, baking, or frying, making it a favorite choice for gourmet dishes worldwide.', '800', '2023-10-21 14:43:33.189008'),
('826e6f687f', 'SNA-1313', 'Snacks & Confectionery', '10.jpg', 'Snacks & Confectionery present an array of tempting treats, from savory chips to sweet confections. These indulgent delights offer instant gratification, ideal for satisfying cravings or enjoying at gatherings. With a wide range of flavors and textures, they provide a quick, delightful escape from the daily routine.', '250', '2023-10-21 14:44:32.365580'),
('97972e8d63', 'RIC-1414', 'Rice', '26.jpg', 'Rice is a staple food that serves as the foundation for countless cuisines worldwide. It comes in various types, such as long-grain, short-grain, and basmati, each offering a distinct flavor and texture. Rice is versatile, complementing dishes from stir-fries to sushi, making it an essential ingredient in many cultures and a source of nourishment and comfort.', '112', '2023-10-21 14:46:00.905994'),
('a419f2ef1c', 'SEE-1515', 'Seeds & Spices', '11.jpeg', 'Seeds & spices are the heart of flavor in global cuisine. These small but mighty ingredients include a diverse array of flavors, from the heat of chili peppers to the warmth of cinnamon. Spices add depth to dishes, while seeds bring unique textures and aromas. Together, they elevate culinary experiences worldwide.', '50', '2023-10-21 14:47:00.945014'),
('a5931158fe', 'DES-1616', 'Desserts & Ingredients', '12.jpeg', 'Desserts & Ingredients encompass the sweet side of gastronomy, offering a delightful array of treats and essential components. From decadent chocolates and syrups to versatile baking ingredients like flour and sugar, these items are the building blocks of confectionery masterpieces. Elevate your dessert game with quality ingredients and creative inspiration.', '120', '2023-10-21 14:48:08.071152'),
('b2f9c250fd', 'TEA-1717', 'Tea & Coffee', '13.jpeg', 'Tea & Coffee, the comforting companions of daily routines. Dive into the world of aromatic brews with a selection ranging from classic black and green teas to specialty coffee blends. Sip and savor the richness of flavors, whether it\'s a morning pick-me-up or a calming evening tea. Start your day right with the perfect cup.', '320', '2023-10-21 14:49:13.133035'),
('bd200ef837', 'PET-1818', 'Pet Products', '14.jpeg', 'Discover a range of pet products to keep your furry friends happy and healthy. From premium pet food to toys, grooming essentials, and cozy beds, we have everything to pamper your pets. Ensure their well-being and bring joy to your home with our selection of pet care items.', '800', '2023-10-21 14:50:06.149544'),
('cff0cb495a', 'AME-1919', 'Americano', '15.jpeg', 'Americano is a popular coffee drink known for its simplicity and bold flavor. Made by diluting a shot of espresso with hot water, it offers a rich and robust coffee experience. With its smooth taste and caffeine kick, the Americano is a go-to choice for coffee lovers who prefer a milder alternative to straight espresso.', '420', '2023-10-21 14:51:09.032386'),
('d57cd89073', 'GIF-2020', 'Gifting', '16.jpeg', 'Gifting is the art of expressing affection and appreciation through thoughtful presents. It\'s a gesture that transcends cultures and occasions, conveying love, gratitude, or celebration. Whether it\'s birthdays, anniversaries, or holidays, finding the perfect gift that resonates with the recipient\'s interests and desires can create lasting memories and strengthen relationships.', '3200', '2023-10-21 14:52:09.829877'),
('d9aed17627', 'PAR-2121', 'Party Shop', '17.jpeg', 'A party shop is a one-stop destination for all your celebration needs. From vibrant decorations and party favors to themed accessories, it offers a wide array of supplies to elevate your gatherings. Whether you\'re planning a birthday bash, a baby shower, or a festive holiday event, the party shop adds color, fun, and convenience to your party planning experience.', '480', '2023-10-21 14:53:06.986573'),
('e2195f8190', 'AUT-2222', 'Auto Care', '19.jpeg', 'Auto care refers to the maintenance and repair services for vehicles, ensuring they run efficiently and safely. These services include oil changes, brake repairs, tire rotations, and more. Regular auto care helps extend a vehicle\'s lifespan and maintains its performance. It also enhances safety on the road, making it an essential aspect of responsible car ownership.', '1600', '2023-10-21 14:54:04.667810'),
('e2af35d095', 'FAS-2323', 'Fashion', '20.jpg', 'Fashion encompasses a dynamic world of clothing and accessories, reflecting personal style and trends. It\'s a form of self-expression, allowing individuals to showcase their unique personalities. The fashion industry continually evolves, offering diverse options for casual wear, formal attire, and everything in between. It\'s an art form that transcends cultures and time, playing a significant role in modern society.', '2700', '2023-10-21 14:55:02.150130'),
('e769e274a3', 'HEA-2424', 'Health & Beauty', '21.png', 'Health & Beauty encompasses a vast realm of products and practices aimed at enhancing well-being and appearance. It includes skincare, cosmetics, hair care, fitness essentials, and more. These products and routines help individuals look and feel their best, promoting self-confidence and a healthy lifestyle. The health and beauty industry is ever-evolving, catering to diverse needs and preferences.', '1800', '2023-10-21 14:57:01.599140'),
('ec18c5a4f0', 'DIG-2525', 'Digital Goods', '22.jpg', 'Digital Goods refer to intangible products or content distributed electronically. This category encompasses various digital items like e-books, software, music, videos, and more. They provide convenient access to entertainment, knowledge, and tools. With the digital age\'s growth, digital goods have become increasingly popular, offering instant downloads and access to a wide array of content and applications.', '400', '2023-10-21 14:57:59.227359'),
('f4ce3927bf', 'STA-2626', 'Stationery', '23.jpg', 'Stationery includes a wide range of office and school supplies like paper, pens, pencils, notepads, and other writing materials. It also comprises items such as envelopes, folders, and office accessories. Stationery products are essential for daily note-taking, writing, and organizing tasks, making them a fundamental part of educational and professional environments. They come in various designs and styles, catering to different preferences and needs.', '280', '2023-10-21 14:59:02.228886'),
('f9c2770a32', 'FRO-2727', 'Frozen Food', '24.jpg', 'Frozen food refers to food products that have been preserved by freezing, maintaining their freshness for an extended period. This category includes a diverse range of items like vegetables, fruits, meats, and ready-to-eat meals. Freezing helps retain nutritional value and flavor. It offers convenience, reducing food waste, and allows consumers to enjoy seasonal produce year-round.', '1600', '2023-10-21 15:00:35.387173');

-- --------------------------------------------------------

--
-- Table structure for table `rpos_staff`
--

CREATE TABLE `rpos_staff` (
  `staff_id` int(20) NOT NULL,
  `staff_name` varchar(200) NOT NULL,
  `staff_number` varchar(200) NOT NULL,
  `staff_email` varchar(200) NOT NULL,
  `staff_password` varchar(200) NOT NULL,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rpos_staff`
--

INSERT INTO `rpos_staff` (`staff_id`, `staff_name`, `staff_number`, `staff_email`, `staff_password`, `created_at`) VALUES
(2, 'Cashier Trevor', 'QEUY-9042', 'cashier@mail.com', '903b21879b4a60fc9103c3334e4f6f62cf6c3a2d', '2022-09-04 16:11:30.581882');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rpos_admin`
--
ALTER TABLE `rpos_admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `rpos_customers`
--
ALTER TABLE `rpos_customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `rpos_orders`
--
ALTER TABLE `rpos_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `CustomerOrder` (`customer_id`),
  ADD KEY `ProductOrder` (`prod_id`);

--
-- Indexes for table `rpos_pass_resets`
--
ALTER TABLE `rpos_pass_resets`
  ADD PRIMARY KEY (`reset_id`);

--
-- Indexes for table `rpos_payments`
--
ALTER TABLE `rpos_payments`
  ADD PRIMARY KEY (`pay_id`),
  ADD KEY `order` (`order_code`);

--
-- Indexes for table `rpos_products`
--
ALTER TABLE `rpos_products`
  ADD PRIMARY KEY (`prod_id`);

--
-- Indexes for table `rpos_staff`
--
ALTER TABLE `rpos_staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rpos_pass_resets`
--
ALTER TABLE `rpos_pass_resets`
  MODIFY `reset_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rpos_staff`
--
ALTER TABLE `rpos_staff`
  MODIFY `staff_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `rpos_orders`
--
ALTER TABLE `rpos_orders`
  ADD CONSTRAINT `CustomerOrder` FOREIGN KEY (`customer_id`) REFERENCES `rpos_customers` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ProductOrder` FOREIGN KEY (`prod_id`) REFERENCES `rpos_products` (`prod_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
