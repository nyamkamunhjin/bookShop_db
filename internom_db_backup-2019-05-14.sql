-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: internom
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog` (
  `blog_id` varchar(255) NOT NULL,
  `blog_name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`blog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mj`@`%`*/ /*!50003 trigger blog_id_auto_increment
    before insert on blog
    for each row
    begin
        if((select blog_id from blog limit 1) is null) then
            set new.blog_id = 'bl0';
        else
            if((select blog_name from blog where blog_name = new.blog_name limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This blog already registered';
            else
                set @id = (select max(cast(substring(blog_id, 3, 5) as unsigned)) from blog);

                set new.blog_id = concat('bl', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch` (
  `branch_id` varchar(255) NOT NULL,
  `branch_name` varchar(100) NOT NULL,
  `city` varchar(30) NOT NULL,
  `region` varchar(255) NOT NULL,
  `phone_number` int(20) NOT NULL,
  `schedule` varchar(255) NOT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES ('b0','Shangri-La','UB','Tuv',77777771,'1-7-11-5'),('b1','Sportiin-Tuv','UB','Tuv',77777772,'1-6-10-6');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mj`@`%`*/ /*!50003 trigger branch_id_auto_increment
    before insert on branch
    for each row
    begin
        if((select branch_id from branch limit 1) is null) then
            set new.branch_id = 'b0';
        else
            if((select branch_name from branch where branch_name = new.branch_name limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This branch already registered';
            else
                set @id = (select max(cast(substring(branch_id, 2, 5) as unsigned)) from branch);

                set new.branch_id = concat('b', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `featured` tinyint(1) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'COMPUTING & INFORMATION TECHNOLOGY',0),(2,'LANGUAGE & LINGUISTICS',0),(3,'LIFESTYLE, HOBBIES & LEISURE',0);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `customer_id` varchar(255) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` int(20) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES ('c0','Munkhjin','Nyamdorj','male','nyamkamunhjin@gmail.com',99999991),('c1','dsada','dsadasas','female','dsfsafasassd@gmail.com',2131324);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mj`@`%`*/ /*!50003 trigger customer_id_auto_increment
    before insert on customers
    for each row
    begin
        if((select customer_id from customers limit 1) is null) then
            set new.customer_id = 'c0';
        else
            if((select email from customers where email = new.email limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This email already registered';
            else
                set @id = (select max(cast(substring(customer_id, 2, 5) as unsigned)) from customers);

                set new.customer_id = concat('c', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` varchar(255) NOT NULL,
  `cart_id` varchar(255) NOT NULL,
  `order_date` datetime DEFAULT NULL,
  `payment_type` int(2) NOT NULL,
  `required_date` datetime DEFAULT NULL,
  `total_price` int(10) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_fk0` (`cart_id`),
  CONSTRAINT `orders_fk0` FOREIGN KEY (`cart_id`) REFERENCES `shopping_cart` (`cart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mj`@`%`*/ /*!50003 trigger order_id_auto_increment
    before insert on orders
    for each row
    begin
        if((select order_id from orders limit 1) is null) then
            set new.order_id = 'o0';
        else
            if((select cart_id from orders where cart_id = new.cart_id limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This order already registered';
            else
                set @id = (select max(cast(substring(order_id, 2, 5) as unsigned)) from orders);

                set new.order_id = concat('o', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mj`@`%`*/ /*!50003 trigger order_auto_value
    before insert on orders
    for each row
    begin
        -- create date 
        set new.order_date = now();
        set new.required_date = date_add(now(), interval 3 day);

        set @temp_quantity = (select quantity from shopping_cart where new.cart_id = cart_id);
        -- calculate payment price for order
        set new.total_price = @temp_quantity * (select price from products where product_id = (select product_id from shopping_cart where new.cart_id = cart_id));

        -- subtract ordered quantity of products
        update products
        set reserved_quantity = reserved_quantity - @temp_quantity
        where product_id = (select product_id from shopping_cart where new.cart_id = cart_id);
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product_branch`
--

DROP TABLE IF EXISTS `product_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_branch` (
  `product_id` varchar(255) DEFAULT NULL,
  `branch_id` varchar(255) DEFAULT NULL,
  `reserved_quantity` int(4) NOT NULL,
  KEY `product_branch_fk0` (`product_id`),
  KEY `product_branch_fk1` (`branch_id`),
  CONSTRAINT `product_branch_fk0` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `product_branch_fk1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_branch`
--

LOCK TABLES `product_branch` WRITE;
/*!40000 ALTER TABLE `product_branch` DISABLE KEYS */;
INSERT INTO `product_branch` VALUES ('p0','b0',100),('p0','b1',100);
/*!40000 ALTER TABLE `product_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `product_id` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `language` varchar(25) NOT NULL,
  `isbn` bigint(13) NOT NULL,
  `product_type` varchar(50) DEFAULT NULL,
  `price` int(10) NOT NULL,
  `published_date` datetime NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `publisher_id` varchar(255) DEFAULT NULL,
  `width` int(4) NOT NULL,
  `height` int(4) NOT NULL,
  `depth` int(4) NOT NULL,
  `total_page_num` int(4) NOT NULL,
  `weight` int(4) NOT NULL,
  `age_range_start` int(2) DEFAULT NULL,
  `age_range_end` int(2) DEFAULT NULL,
  `reserved_quantity` int(4) NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `products_fk0` (`category_id`),
  KEY `products_fk1` (`publisher_id`),
  CONSTRAINT `products_fk0` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `products_fk1` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('p0','FOOD YOU CAN FORAGE',NULL,'When you know where to look','english',9781472941206,NULL,40750,'2018-05-14 00:00:00',2,NULL,246,0,189,256,755,NULL,NULL,10);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mj`@`%`*/ /*!50003 trigger product_id_auto_increment
    before insert on products
    for each row
    begin
        if((select product_id from products limit 1) is null) then
            set new.product_id = 'p0';
        else
            if((select product_name from products where product_name = new.product_name limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This product already registered';
            else
                set @id = (select max(cast(substring(product_id, 2, 5) as unsigned)) from products);

                set new.product_id = concat('p', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher` (
  `publisher_id` varchar(255) NOT NULL,
  `publisher_name` varchar(100) NOT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES ('pu0','a'),('pu1','b'),('pu2','c');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mj`@`%`*/ /*!50003 trigger publisher_id_auto_increment
    before insert on publisher
    for each row
    begin
        if((select publisher_id from publisher limit 1) is null) then
            set new.publisher_id = 'pu0';
        else
            if((select publisher_name from publisher where publisher_name = new.publisher_name limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This publisher already registered';
            else
                set @id = (select max(cast(substring(publisher_id, 3, 5) as unsigned)) from publisher);

                set new.publisher_id = concat('pu', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `shipping_addresses`
--

DROP TABLE IF EXISTS `shipping_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipping_addresses` (
  `address_id` varchar(255) NOT NULL,
  `customer_id` varchar(255) DEFAULT NULL,
  `ship_address` varchar(255) NOT NULL,
  `ship_city` varchar(50) NOT NULL,
  `ship_region` varchar(50) NOT NULL,
  `postal_code` varchar(50) NOT NULL,
  PRIMARY KEY (`address_id`),
  KEY `shipping_addresses_fk0` (`customer_id`),
  CONSTRAINT `shipping_addresses_fk0` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_addresses`
--

LOCK TABLES `shipping_addresses` WRITE;
/*!40000 ALTER TABLE `shipping_addresses` DISABLE KEYS */;
INSERT INTO `shipping_addresses` VALUES ('a0','c1','North Hwy 20, P.O 10','Island Park','Idaho','83429');
/*!40000 ALTER TABLE `shipping_addresses` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mj`@`%`*/ /*!50003 trigger address_id_auto_increment
    before insert on shipping_addresses
    for each row
    begin
        if((select address_id from shipping_addresses limit 1) is null) then
            set new.address_id = 'a0';
        else
            if((select ship_address from shipping_addresses where ship_address = new.ship_address limit 1) is not null) then
                signal sqlstate  '45000'
                set message_text = 'This shipping_address already registered';
            else
                set @id = (select max(cast(substring(address_id, 2, 5) as unsigned)) from shipping_addresses);

                set new.address_id = concat('a', (select cast(@id as unsigned) + 1));
            end if;
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `shopping_cart`
--

DROP TABLE IF EXISTS `shopping_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shopping_cart` (
  `cart_id` varchar(255) NOT NULL,
  `customer_id` varchar(255) DEFAULT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  `address_id` varchar(255) DEFAULT NULL,
  `quantity` int(5) NOT NULL,
  `isOrdered` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `shopping_cart_fk0` (`customer_id`),
  KEY `shopping_cart_fk1` (`product_id`),
  KEY `shopping_cart_fk2` (`address_id`),
  CONSTRAINT `shopping_cart_fk0` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `shopping_cart_fk1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `shopping_cart_fk2` FOREIGN KEY (`address_id`) REFERENCES `shipping_addresses` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart`
--

LOCK TABLES `shopping_cart` WRITE;
/*!40000 ALTER TABLE `shopping_cart` DISABLE KEYS */;
INSERT INTO `shopping_cart` VALUES ('s0','c1','p0','a0',5,0),('s1','c0','p0','a0',5,0);
/*!40000 ALTER TABLE `shopping_cart` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mj`@`%`*/ /*!50003 trigger cart_id_auto_increment
    before insert on shopping_cart
    for each row
    begin
        if((select cart_id from shopping_cart limit 1) is null) then
            set new.cart_id = 's0';
            set new.isOrdered = 0;
        else -- if customer adds same product to the cart add quantity 
            set @current_quantity = (select quantity from shopping_cart where customer_id = new.customer_id and product_id = new.product_id and address_id = new.address_id limit 1);

            if(@current_quantity is not null) then
                signal sqlstate  '45000'
                set message_text = 'This item already registered';
            else
                set @id = (select max(cast(substring(cart_id, 2, 5) as unsigned)) from shopping_cart);

                set new.cart_id = concat('s', (select cast(@id as unsigned) + 1));
                set new.isOrdered = 0;
            end if;
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`mj`@`%`*/ /*!50003 trigger order_creater
after update on shopping_cart
for each row
    begin
        if(new.isOrdered = 1) then
            insert into orders(cart_id, payment_type)
            values(new.cart_id, 1);
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `shopping_cart_history`
--

DROP TABLE IF EXISTS `shopping_cart_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shopping_cart_history` (
  `customer_id` varchar(255) DEFAULT NULL,
  `product_id` varchar(255) DEFAULT NULL,
  `quantity` int(5) NOT NULL,
  `order_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart_history`
--

LOCK TABLES `shopping_cart_history` WRITE;
/*!40000 ALTER TABLE `shopping_cart_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `shopping_cart_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-14 10:25:35
