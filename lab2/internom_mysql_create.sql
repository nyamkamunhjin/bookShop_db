drop database if exists internom;
create database internom;
use internom;

  CREATE TABLE `customers` (
	`customer_id` int(3) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`gender` enum(male,female) NOT NULL,
	`email` varchar(255) NOT NULL,
	`phone` int(20) NOT NULL,
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE `shipping_addresses` (
	`address_id` int(3) NOT NULL,
	`customer_id` int(3) NOT NULL,
	`ship_address` varchar(255) NOT NULL,
	`ship_city` varchar(50) NOT NULL,
	`ship_region` varchar(50) NOT NULL,
	`postal_code` varchar(50) NOT NULL,
	PRIMARY KEY (`address_id`)
);

CREATE TABLE `branch` (
	`branch_id` int(3) NOT NULL,
	`branch_name` varchar(100) NOT NULL,
	`city` varchar(30) NOT NULL,
	`region` varchar(255) NOT NULL,
	`phone_number` int(20) NOT NULL,
	`schedule` varchar(255) NOT NULL,
	PRIMARY KEY (`branch_id`)
);

CREATE TABLE `product_branch` (
	`product_id` int(3) NOT NULL,
	`branch_id` int(3) NOT NULL,
	`reserved_quantity` int(4) NOT NULL
);

CREATE TABLE `products` (
	`product_id` int(3) NOT NULL,
	`product_name` varchar(255) NOT NULL,
	`author` varchar(255),
	`description` varchar(255) NOT NULL,
	`language` varchar(25) NOT NULL,
	`isbn` bigint(13) NOT NULL,
	`product_type` varchar(50),
	`price` int(10) NOT NULL,
	`published_date` DATETIME NOT NULL,
	`category_id` int(3) NOT NULL,
	`publisher_id` int(3),
	`width` int(4) NOT NULL,
	`height` int(4) NOT NULL,
	`depth` int(4) NOT NULL,
	`total_page_num` int(4) NOT NULL,
	`weight` int(4) NOT NULL,
	`age_range_start` int(2),
	`age_range_end` int(2),
	`reserved_quantity` int(4) NOT NULL,
	PRIMARY KEY (`product_id`)
);

CREATE TABLE `orders` (
	`order_id` int(3) NOT NULL,
	`cart_id` int(3) NOT NULL,
	`order_date` DATETIME,
	`payment_type` int(2) NOT NULL,
	`required_date` DATETIME,
	`total_price` int(10),
	PRIMARY KEY (`order_id`)
);

CREATE TABLE `shopping_cart` (
	`cart_id` int(3) NOT NULL,
	`customer_id` int(3) NOT NULL,
	`product_id` int(3) NOT NULL,
	`address_id` int(3) NOT NULL,
	`quantity` int(5) NOT NULL,
	`isOrdered` tinyint(1) NOT NULL,
	PRIMARY KEY (`cart_id`)
);

CREATE TABLE `shopping_cart_history` (
	`customer_id` int(3) NOT NULL,
	`product_id` int(3) NOT NULL,
	`quantity` int(5) NOT NULL,
	`order_date` DATETIME
);

CREATE TABLE `category` (
	`category_id` int(3) NOT NULL,
	`name` varchar(100) NOT NULL,
	`featured` tinyint(1) NOT NULL,
	PRIMARY KEY (`category_id`)
);

CREATE TABLE `publisher` (
	`publisher_id` int(3) NOT NULL,
	`publisher_name` varchar(100) NOT NULL,
	PRIMARY KEY (`publisher_id`)
);

CREATE TABLE `blog` (
	`blog_id` int(3) NOT NULL,
	`blog_name` varchar(100) NOT NULL,
	`description` varchar(255) NOT NULL,
	`date` DATETIME,
	PRIMARY KEY (`blog_id`)
);

ALTER TABLE `shipping_addresses` ADD CONSTRAINT `shipping_addresses_fk0` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`);

ALTER TABLE `product_branch` ADD CONSTRAINT `product_branch_fk0` FOREIGN KEY (`product_id`) REFERENCES `products`(`product_id`);

ALTER TABLE `product_branch` ADD CONSTRAINT `product_branch_fk1` FOREIGN KEY (`branch_id`) REFERENCES `branch`(`branch_id`);

ALTER TABLE `products` ADD CONSTRAINT `products_fk0` FOREIGN KEY (`category_id`) REFERENCES `category`(`category_id`);

ALTER TABLE `products` ADD CONSTRAINT `products_fk1` FOREIGN KEY (`publisher_id`) REFERENCES `publisher`(`publisher_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk0` FOREIGN KEY (`cart_id`) REFERENCES `shopping_cart`(`cart_id`);

ALTER TABLE `shopping_cart` ADD CONSTRAINT `shopping_cart_fk0` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`);

ALTER TABLE `shopping_cart` ADD CONSTRAINT `shopping_cart_fk1` FOREIGN KEY (`product_id`) REFERENCES `products`(`product_id`);

ALTER TABLE `shopping_cart` ADD CONSTRAINT `shopping_cart_fk2` FOREIGN KEY (`address_id`) REFERENCES `shipping_addresses`(`address_id`);
