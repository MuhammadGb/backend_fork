CREATE TABLE `user` (
  `id` int,
  `user_id` varchar(25),
  `username` varchar(25),
  `password` varchar(25),
  `first_name` varchar(25),
  `last_name` varchar(25),
  `email` varchar(25),
  `phone_number` varchar(25),
  `created_at` datetime,
  `modified_at` datetime,
  PRIMARY KEY (`user_id`)
);

CREATE TABLE `user_payment` (
  `id` int,
  `user_id` varchar(25),
  `payment_type` varchar(25),
  `provider` varchar(25),
  `account_number` varchar(10),
  `expiry` date
);

CREATE TABLE `user_address` (
  `id` int,
  `user_id` varchar(25),
  `address_line1` varchar(15),
  `address_line2` varchar(15),
  `city` varchar(10),
  `postal_code` varchar(10),
  `country` varchar(20),
  `phone_number` varchar(14)
);

CREATE TABLE `admin_type` (
  `id` int,
  `admin_type` varchar(25),
  `permissions` varchar(25),
  `created_at` datetime,
  `modified_at` datetime,
   PRIMARY KEY (`admin_type`)
);

CREATE TABLE `adminuser` (
  `id` int,
  `admin_id` varchar(25),
  `username` varchar(25),
  `password` varchar(25),
  `first_name` varchar(25),
  `last_name` varchar(25),
  `email` varchar(25),
  `admin_type` varchar(25),
  `last_login` datetime,
  `created_at` datetime,
  `modified_at` datetime
);

CREATE TABLE `products` (
  `id` int,
  `name` varchar(25),
  `description` text,
  `price` float,
  `product_image` varchar(255),
  `inventory` int,
  `discount` int,
  `category_name` varchar(25),
  `created_at` datetime,
  `modified_at` datetime,
  `deleted_at` datetime,
   PRIMARY KEY (`name`)
);

CREATE TABLE `products_category` (
  `id` int,
  `category_name` varchar(25),
  `description` text,
  `created_at` datetime,
  `modified_at` datetime,
  `deleted_at` datetime,
   PRIMARY KEY (`category_name`)
);

CREATE TABLE `product_inventory` (
  `id` int,
  `product_name` varchar(25),
  `quantity` int,
  `created_at` datetime,
  `modified_at` datetime,
  `deleted_at` datetime
);

CREATE TABLE `shopping_session` (
  `id` int,
  `user_id` varchar(25),
  `total` decimal,
  `created_at` datetime,
  `modified_at` datetime,
   PRIMARY KEY (`id`)
);

CREATE TABLE `cart_item` (
  `id` int,
  `session_id` int,
  `product_name` varchar(25),
  `quantity` int,
  `created_at` datetime,
  `modified_at` datetime
);

CREATE TABLE `order_details` (
  `id` int,
  `user_id` varchar(25),
  `total` decimal,
  `payment_id` int,
  `created_at` datetime,
  `modified_at` datetime,
   PRIMARY KEY (`id`)
);

CREATE TABLE `order_items` (
  `id` int,
  `order_id` int,
  `product_name` varchar(25),
  `quantity` int,
  `created_at` datetime,
  `modified_at` datetime
);

CREATE TABLE `payment_details` (
  `id` int,
  `order_id` int,
  `amount` decimal,
  `provider` varchar(25),
  `status` varchar(255),
  `created_at` datetime,
  `modified_at` datetime,
   PRIMARY KEY (`id`)
);

CREATE TABLE `order_list` (
  `id` int,
  `order_id` int,
  `payment_id` int,
  `product_name` varchar(25),
  `user_id` varchar(255)
);

ALTER TABLE `user_payment` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `adminuser` ADD FOREIGN KEY (`admin_type`) REFERENCES `admin_type` (`admin_type`);

ALTER TABLE `user_address` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `product_inventory` ADD FOREIGN KEY (`product_name`) REFERENCES `products` (`name`);

ALTER TABLE `products` ADD FOREIGN KEY (`category_name`) REFERENCES `products_category` (`category_name`);

ALTER TABLE `cart_item` ADD FOREIGN KEY (`session_id`) REFERENCES `shopping_session` (`id`);

ALTER TABLE `shopping_session` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `cart_item` ADD FOREIGN KEY (`product_name`) REFERENCES `products` (`name`);

ALTER TABLE `order_details` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `order_details` ADD FOREIGN KEY (`payment_id`) REFERENCES `payment_details` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`product_name`) REFERENCES `products` (`name`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`id`) REFERENCES `order_details` (`id`);

ALTER TABLE `payment_details` ADD FOREIGN KEY (`order_id`) REFERENCES `order_details` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `order_details` (`id`);

ALTER TABLE `order_list` ADD FOREIGN KEY (`payment_id`) REFERENCES `payment_details` (`id`);

ALTER TABLE `order_list` ADD FOREIGN KEY (`order_id`) REFERENCES `order_details` (`id`);

ALTER TABLE `order_list` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

ALTER TABLE `order_list` ADD FOREIGN KEY (`product_name`) REFERENCES `products` (`name`);