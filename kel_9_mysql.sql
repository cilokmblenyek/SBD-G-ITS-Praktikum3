
CREATE TABLE `carts` (
  `id` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `total_price` int NOT NULL DEFAULT '0',
  `status` enum('idle','checkout','success') NOT NULL DEFAULT 'idle',
  `customer_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_customer_id_idx` (`customer_id`)
);

CREATE TABLE `customers` (
  `id` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_username_unique` (`username`),
  UNIQUE KEY `customers_email_unique` (`email`)
);

CREATE TABLE `feedback_orders` (
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `order_id` varchar(191) NOT NULL,
  `feedback_id` varchar(191) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`order_id`,`feedback_id`),
  KEY `feedback_orders_order_id_idx` (`order_id`),
  KEY `feedback_orders_feedback_id_idx` (`feedback_id`)
);

CREATE TABLE `feedbacks` (
  `id` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `feedback` varchar(255) NOT NULL,
  `rating` int NOT NULL,
  `product_id` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `feedbacks_product_id_idx` (`product_id`)
);

CREATE TABLE `orders` (
  `id` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `total_product` int NOT NULL,
  `total_price` int NOT NULL,
  `status` enum('pending','payment','validated','rejected','complete') NOT NULL DEFAULT 'pending',
  `address` varchar(255) NOT NULL,
  `courier` varchar(255) NOT NULL,
  `payment_proof` varchar(255) DEFAULT NULL,
  `validated_by` varchar(255) DEFAULT NULL,
  `cart_id` varchar(191) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `payment_method` enum('ITS_BANK','COD') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_cart_id_idx` (`cart_id`),
  KEY `orders_customer_id_idx` (`customer_id`)
);

CREATE TABLE `product_carts` (
  `product_id` varchar(191) NOT NULL,
  `cart_id` varchar(191) NOT NULL,
  `quantity` int NOT NULL,
  `total_price` int NOT NULL,
  `is_reviewed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`cart_id`),
  KEY `product_carts_product_id_idx` (`product_id`),
  KEY `product_carts_cart_id_idx` (`cart_id`)
);

CREATE TABLE `products` (
  `id` varchar(191) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` int NOT NULL,
  `stock` int NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `customers` (`id`, `created_at`, `updated_at`, `username`, `name`, `email`, `address`, `phone`) VALUES
('user_2SBnTvctgkDSXSWThUnG3xDoShY', '2023-08-09 17:28:24', '2023-08-09 17:28:24', 'mrevanzak', 'Mochamad Revanza Kurniawan', 'mrevanzak@gmail.com', 'telaga harapan', '081234567890');

INSERT INTO `carts` (`id`, `created_at`, `updated_at`, `deleted_at`, `total_price`, `status`, `customer_id`) VALUES
('11bdd12a-9f8e-4548-ab89-7f34705b39c6', '2023-08-10 02:56:25', '2023-08-10 05:31:31', NULL, 22000, 'checkout', 'user_2SBnTvctgkDSXSWThUnG3xDoShY'),
('187c6f89-a500-4b7f-b9ba-d5b7c4f0c97d', '2023-08-19 07:41:45', '2023-08-19 07:42:20', NULL, 49500, 'checkout', 'user_2SBnTvctgkDSXSWThUnG3xDoShY'),
('354b6d43-74c1-40f8-9eb4-e81afdab61f3', '2023-08-09 17:28:24', '2023-08-09 17:30:39', NULL, 19000, 'checkout', 'user_2SBnTvctgkDSXSWThUnG3xDoShY'),
('65977b88-5daa-4576-9e6e-acd0b3205416', '2023-08-19 07:45:55', '2023-08-19 07:46:39', NULL, 10000, 'checkout', 'user_2SBnTvctgkDSXSWThUnG3xDoShY'),
('889923f8-40ac-4413-afe1-b17c0560b41d', '2023-08-25 11:45:08', '2023-08-25 11:45:14', NULL, 12000, 'checkout', 'user_2SBnTvctgkDSXSWThUnG3xDoShY'),
('aded61d9-d673-47a9-8588-2bf5a8d10d36', '2023-08-26 05:21:49', '2023-08-26 05:21:50', NULL, 9000, 'idle', 'user_2SBnTvctgkDSXSWThUnG3xDoShY'),
('aeb42f3b-680e-416d-adf9-a863aaa07975', '2023-08-25 11:41:10', '2023-08-25 11:41:36', NULL, 19000, 'checkout', 'user_2SBnTvctgkDSXSWThUnG3xDoShY'),
('f41ec975-c068-4eb1-a7cd-20fcb06afc2d', '2023-08-09 18:02:25', '2023-08-10 02:46:36', NULL, 62000, 'checkout', 'user_2SBnTvctgkDSXSWThUnG3xDoShY'),
('f697c314-130b-4f72-9e58-4106ab268d65', '2023-08-09 17:30:41', '2023-08-09 17:56:40', NULL, 10000, 'checkout', 'user_2SBnTvctgkDSXSWThUnG3xDoShY');

INSERT INTO `feedback_orders` (`date`, `order_id`, `feedback_id`, `username`) VALUES
('2023-08-20 10:29:37', '1dc1363c-8ff9-43be-b199-4371816da4fb', '3ccde815-976d-40d9-8887-95b2b3afaf3a', 'mrevanzak'),
('2023-08-26 05:49:18', '719aed2c-2b55-42e4-9535-eddc42b6e196', '27be5e6a-b684-4ad3-b11b-330f622cfa4e', 'mrevanzak');

INSERT INTO `feedbacks` (`id`, `created_at`, `updated_at`, `deleted_at`, `feedback`, `rating`, `product_id`) VALUES
('27be5e6a-b684-4ad3-b11b-330f622cfa4e', '2023-08-26 05:49:18', '2023-08-26 05:49:18', NULL, 'will repeat order', 5, 'aff23cc5-1c05-11ee-833a-2a09fb34a66a'),
('3ccde815-976d-40d9-8887-95b2b3afaf3a', '2023-08-20 10:29:37', '2023-08-20 10:29:37', NULL, 'wenakkkkkkk', 5, 'aff23cc5-1c05-11ee-833a-2a09fb34a66a');

INSERT INTO `orders` (`id`, `created_at`, `updated_at`, `deleted_at`, `total_product`, `total_price`, `status`, `address`, `courier`, `payment_proof`, `validated_by`, `cart_id`, `customer_id`, `payment_method`) VALUES
('1dc1363c-8ff9-43be-b199-4371816da4fb', '2023-08-09 17:56:39', '2023-08-10 05:28:03', NULL, 1, 10000, 'validated', 'telaga harapan', 'ITS-JEK', 'payment_1dc1363c-8ff9-43be-b199-4371816da4fb_idt-weekly-photo_1689319640816.png', NULL, 'f697c314-130b-4f72-9e58-4106ab268d65', 'user_2SBnTvctgkDSXSWThUnG3xDoShY', 'ITS_BANK'),
('488777cf-453a-4a77-8b4a-d90f83275f4b', '2023-08-19 07:46:39', '2023-08-19 08:04:16', NULL, 1, 10000, 'validated', 'telaga harapan', 'ITS-JEK', 'payment_488777cf-453a-4a77-8b4a-d90f83275f4b.png', 'user_2SBx7KFiISoSFI0cEiBt3Uh7uXT', '65977b88-5daa-4576-9e6e-acd0b3205416', 'user_2SBnTvctgkDSXSWThUnG3xDoShY', 'ITS_BANK'),
('6be52d26-4855-4562-982a-cc588cfd58f5', '2023-08-19 07:42:20', '2023-08-25 11:22:56', NULL, 5, 49500, 'validated', 'telaga harapan', 'ITS-EXPRESS', 'payment_6be52d26-4855-4562-982a-cc588cfd58f5.jpg', 'user_2SBx7KFiISoSFI0cEiBt3Uh7uXT', '187c6f89-a500-4b7f-b9ba-d5b7c4f0c97d', 'user_2SBnTvctgkDSXSWThUnG3xDoShY', 'ITS_BANK'),
('719aed2c-2b55-42e4-9535-eddc42b6e196', '2023-08-25 11:41:36', '2023-08-25 11:43:12', NULL, 2, 19000, 'validated', 'telaga harapan', 'ITS-JEK', 'payment_719aed2c-2b55-42e4-9535-eddc42b6e196.png', 'user_2SBx7KFiISoSFI0cEiBt3Uh7uXT', 'aeb42f3b-680e-416d-adf9-a863aaa07975', 'user_2SBnTvctgkDSXSWThUnG3xDoShY', 'ITS_BANK'),
('79ea99b7-1f28-470f-8fa0-5b59f4ca06a2', '2023-08-09 17:30:38', '2023-08-10 05:29:43', NULL, 2, 19000, 'rejected', 'telaga harapan', 'ITS-JEK', 'payment_79ea99b7-1f28-470f-8fa0-5b59f4ca06a2.png', NULL, '354b6d43-74c1-40f8-9eb4-e81afdab61f3', 'user_2SBnTvctgkDSXSWThUnG3xDoShY', 'ITS_BANK'),
('a020699e-86b7-411e-a571-966c5105c05f', '2023-08-25 11:45:14', '2023-08-25 11:45:22', NULL, 1, 12000, 'payment', 'telaga harapan', 'ITS-JEK', 'payment_a020699e-86b7-411e-a571-966c5105c05f.png', NULL, '889923f8-40ac-4413-afe1-b17c0560b41d', 'user_2SBnTvctgkDSXSWThUnG3xDoShY', 'ITS_BANK'),
('bc0b5b1f-4da4-445d-8665-61e2bced4980', '2023-08-10 05:31:30', '2023-08-10 05:31:30', NULL, 2, 22000, 'pending', 'telaga harapan', 'ITS-JEK', NULL, NULL, '11bdd12a-9f8e-4548-ab89-7f34705b39c6', 'user_2SBnTvctgkDSXSWThUnG3xDoShY', 'ITS_BANK'),
('d0c3ff27-dfa7-46ca-a786-4069499be16f', '2023-08-10 02:46:35', '2023-08-25 11:38:00', NULL, 3, 62000, 'validated', 'telaga harapan', 'ITS-JEK', 'payment_d0c3ff27-dfa7-46ca-a786-4069499be16f.png', 'user_2SBx7KFiISoSFI0cEiBt3Uh7uXT', 'f41ec975-c068-4eb1-a7cd-20fcb06afc2d', 'user_2SBnTvctgkDSXSWThUnG3xDoShY', 'ITS_BANK');

INSERT INTO `product_carts` (`product_id`, `cart_id`, `quantity`, `total_price`, `is_reviewed`) VALUES
('aff23cc5-1c05-11ee-833a-2a09fb34a66a', '11bdd12a-9f8e-4548-ab89-7f34705b39c6', 1, 10000, 0),
('aff23cc5-1c05-11ee-833a-2a09fb34a66a', '187c6f89-a500-4b7f-b9ba-d5b7c4f0c97d', 1, 10000, 0),
('aff23cc5-1c05-11ee-833a-2a09fb34a66a', '354b6d43-74c1-40f8-9eb4-e81afdab61f3', 1, 10000, 0),
('aff23cc5-1c05-11ee-833a-2a09fb34a66a', '65977b88-5daa-4576-9e6e-acd0b3205416', 1, 10000, 0),
('aff23cc5-1c05-11ee-833a-2a09fb34a66a', 'aeb42f3b-680e-416d-adf9-a863aaa07975', 1, 10000, 1),
('aff23cc5-1c05-11ee-833a-2a09fb34a66a', 'f41ec975-c068-4eb1-a7cd-20fcb06afc2d', 1, 10000, 0),
('aff23cc5-1c05-11ee-833a-2a09fb34a66a', 'f697c314-130b-4f72-9e58-4106ab268d65', 1, 10000, 1),
('aff242e1-1c05-11ee-833a-2a09fb34a66a', '187c6f89-a500-4b7f-b9ba-d5b7c4f0c97d', 1, 9000, 0),
('aff242e1-1c05-11ee-833a-2a09fb34a66a', '354b6d43-74c1-40f8-9eb4-e81afdab61f3', 1, 9000, 0),
('aff242e1-1c05-11ee-833a-2a09fb34a66a', 'aded61d9-d673-47a9-8588-2bf5a8d10d36', 1, 9000, 0),
('aff242e1-1c05-11ee-833a-2a09fb34a66a', 'aeb42f3b-680e-416d-adf9-a863aaa07975', 1, 9000, 0),
('aff26517-1c05-11ee-833a-2a09fb34a66a', '11bdd12a-9f8e-4548-ab89-7f34705b39c6', 1, 12000, 0),
('aff26517-1c05-11ee-833a-2a09fb34a66a', '187c6f89-a500-4b7f-b9ba-d5b7c4f0c97d', 1, 12000, 0),
('aff26517-1c05-11ee-833a-2a09fb34a66a', '889923f8-40ac-4413-afe1-b17c0560b41d', 1, 12000, 0),
('aff26517-1c05-11ee-833a-2a09fb34a66a', 'f41ec975-c068-4eb1-a7cd-20fcb06afc2d', 1, 12000, 0),
('aff265e0-1c05-11ee-833a-2a09fb34a66a', 'f41ec975-c068-4eb1-a7cd-20fcb06afc2d', 1, 40000, 0),
('aff26777-1c05-11ee-833a-2a09fb34a66a', '187c6f89-a500-4b7f-b9ba-d5b7c4f0c97d', 1, 6500, 0),
('aff26833-1c05-11ee-833a-2a09fb34a66a', '187c6f89-a500-4b7f-b9ba-d5b7c4f0c97d', 1, 12000, 0);

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `image`, `created_at`, `updated_at`, `deleted_at`) VALUES
('aff23cc5-1c05-11ee-833a-2a09fb34a66a', 'Original Bima Bread', 'Original Bima Bread with signature flavor and scent', 10000, 13, 'https://i.ibb.co/MCWDqy9/Original-Bima-Bread.jpg', '2023-07-06 14:02:04', '2023-07-13 13:09:21', NULL),
('aff242e1-1c05-11ee-833a-2a09fb34a66a', 'Baguette Bread', 'Our Baguette Signature Bread with long and thin type of bread of French origin. that is commonly made from basic lean dough (the dough, though not the shape, is defined by French law). It is distinguishable by its length and crisp crust.', 9000, 5, 'https://i.ibb.co/4RPNWSB/Baguette-Bread.jpg', '2023-07-06 14:02:04', NULL, NULL),
('aff243ac-1c05-11ee-833a-2a09fb34a66a', 'Biscuit Flower Branch', 'Our Signature Biscuit with flower branch shape and with the lavender scent', 5000, 0, 'https://i.ibb.co/hFXyMSC/Biscuit-Flower-Branch.jpg', '2023-07-06 14:02:04', NULL, NULL),
('aff26517-1c05-11ee-833a-2a09fb34a66a', 'Black Bread', 'Our Signature Black Bread with coffee flavor', 12000, 4, 'https://i.ibb.co/bN6rVX8/Black-Bread.jpg', '2023-07-06 14:02:04', NULL, NULL),
('aff265e0-1c05-11ee-833a-2a09fb34a66a', 'Chocolate Brownies', 'Our Signature Chocolate Brownies with special premium chocolate, you can also buy this brownies with one package with 20 pieces', 40000, 2, 'https://i.ibb.co/0ypmckF/Chocolate-Brownies.jpg', '2023-07-06 14:02:04', NULL, NULL),
('aff2666e-1c05-11ee-833a-2a09fb34a66a', 'Chocolate Cookies', 'Delicious Chocolate Cookies with our signature flavor', 6000, 8, 'https://i.ibb.co/qdyfLc5/Chocolate-Cookies.jpg', '2023-07-06 14:02:04', NULL, NULL),
('aff266ee-1c05-11ee-833a-2a09fb34a66a', 'Circle Pastry', 'Our signature pastry with circle shape with Bima Bakery signature taste', 9500, 0, 'https://i.ibb.co/3Y1LzdC/Circle-Pastry.jpg', '2023-07-06 14:02:04', NULL, NULL),
('aff26777-1c05-11ee-833a-2a09fb34a66a', 'Cookies with Jam', 'Delicious cookies with strawberry jam and signature Bima Bakery taste', 6500, 5, 'https://i.ibb.co/YjyGfjd/Cookies-with-Jam.jpg', '2023-07-06 14:02:04', NULL, NULL),
('aff26833-1c05-11ee-833a-2a09fb34a66a', 'Croissant Bread', 'Delicious cookies with strawberry jam and signature Bima Bakery taste', 12000, 13, 'https://i.ibb.co/zrK2njP/Croissant-Bread.jpg', '2023-07-06 14:02:04', NULL, NULL);
