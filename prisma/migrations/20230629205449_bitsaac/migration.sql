-- CreateTable
CREATE TABLE `cartItem` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sessionId` INTEGER NULL,
    `productName` VARCHAR(25) NULL,
    `quantity` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NOT NULL,

    INDEX `productName`(`productName`),
    INDEX `sessionId`(`sessionId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orderDetails` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` VARCHAR(25) NULL,
    `total` DECIMAL(10, 0) NULL,
    `paymentId` INTEGER NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NULL,

    INDEX `userId`(`userId`),
    INDEX `orderDetails_ibfk_2`(`paymentId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orderItems` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `orderId` INTEGER NULL,
    `productName` VARCHAR(25) NULL,
    `quantity` INTEGER NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NULL,

    INDEX `productName`(`productName`),
    INDEX `fk_orderItems_orderDetails`(`orderId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orderList` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `orderId` INTEGER NULL,
    `paymentId` INTEGER NULL,
    `productName` VARCHAR(25) NULL,
    `userId` VARCHAR(255) NULL,

    INDEX `orderId`(`orderId`),
    INDEX `userId`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `paymentDetails` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `orderId` INTEGER NULL,
    `amount` DECIMAL(10, 0) NULL,
    `provider` VARCHAR(25) NULL,
    `status` VARCHAR(255) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NULL,

    INDEX `fk_paymentDetails_orderDetails`(`orderId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `productInventory` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `productName` VARCHAR(25) NULL,
    `quantity` INTEGER NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(0) NULL,

    INDEX `productName`(`productName`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `products` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(25) NOT NULL,
    `description` TEXT NULL,
    `price` FLOAT NULL,
    `productImage` VARCHAR(255) NULL,
    `inventory` INTEGER NULL,
    `discount` INTEGER NULL,
    `categoryName` VARCHAR(25) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(0) NULL,

    UNIQUE INDEX `id`(`id`),
    INDEX `categoryName`(`categoryName`),
    PRIMARY KEY (`name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `productsCategory` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `categoryName` VARCHAR(25) NOT NULL,
    `description` TEXT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NULL,
    `deletedAt` DATETIME(0) NULL,

    UNIQUE INDEX `id`(`id`),
    PRIMARY KEY (`categoryName`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shoppingSession` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` VARCHAR(25) NULL,
    `total` DECIMAL(10, 0) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NULL,

    INDEX `userId`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `roles` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `roles_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` VARCHAR(25) NOT NULL,
    `password` VARCHAR(225) NOT NULL,
    `fullName` VARCHAR(25) NULL,
    `email` VARCHAR(25) NOT NULL,
    `phoneNumber` VARCHAR(25) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NULL,
    `rolesId` INTEGER NULL,

    UNIQUE INDEX `id`(`id`),
    UNIQUE INDEX `userId`(`userId`),
    UNIQUE INDEX `email`(`email`),
    UNIQUE INDEX `phoneNumber`(`phoneNumber`),
    INDEX `id_Index`(`id`),
    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `userAddress` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` VARCHAR(25) NULL,
    `addressLine1` VARCHAR(15) NULL,
    `addressLine2` VARCHAR(15) NULL,
    `city` VARCHAR(10) NULL,
    `postalCode` VARCHAR(10) NULL,
    `country` VARCHAR(20) NULL,
    `phoneNumber` VARCHAR(14) NULL,

    INDEX `userId`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `userPayment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` VARCHAR(25) NULL,
    `paymentType` VARCHAR(25) NULL,
    `provider` VARCHAR(25) NULL,
    `accountNumber` VARCHAR(10) NULL,
    `expiry` DATE NULL,

    UNIQUE INDEX `accountNumber`(`accountNumber`),
    INDEX `userId`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `adminType` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `adminType` VARCHAR(25) NOT NULL,
    `permissions` VARCHAR(25) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `id`(`id`),
    PRIMARY KEY (`adminType`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `adminUser` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `adminId` VARCHAR(25) NOT NULL,
    `username` VARCHAR(25) NOT NULL,
    `password` VARCHAR(25) NOT NULL,
    `firstName` VARCHAR(25) NOT NULL,
    `lastName` VARCHAR(25) NOT NULL,
    `email` VARCHAR(25) NOT NULL,
    `adminType` VARCHAR(25) NOT NULL,
    `lastLogin` DATETIME(0) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `modifiedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `adminId`(`adminId`),
    UNIQUE INDEX `email`(`email`),
    INDEX `adminType`(`adminType`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `cartItem` ADD CONSTRAINT `cartItem_ibfk_1` FOREIGN KEY (`sessionId`) REFERENCES `shoppingSession`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `cartItem` ADD CONSTRAINT `cartItem_ibfk_2` FOREIGN KEY (`productName`) REFERENCES `products`(`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `orderDetails` ADD CONSTRAINT `orderDetails_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `orderDetails` ADD CONSTRAINT `orderDetails_ibfk_2` FOREIGN KEY (`paymentId`) REFERENCES `paymentDetails`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `orderItems` ADD CONSTRAINT `orderItems_ibfk_1` FOREIGN KEY (`productName`) REFERENCES `products`(`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `orderList` ADD CONSTRAINT `orderList_ibfk_1` FOREIGN KEY (`paymentId`) REFERENCES `paymentDetails`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `orderList` ADD CONSTRAINT `orderList_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `orderList` ADD CONSTRAINT `orderList_ibfk_4` FOREIGN KEY (`productName`) REFERENCES `products`(`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `productInventory` ADD CONSTRAINT `productInventory_ibfk_1` FOREIGN KEY (`productName`) REFERENCES `products`(`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `products` ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`categoryName`) REFERENCES `productsCategory`(`categoryName`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shoppingSession` ADD CONSTRAINT `shoppingSession_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_rolesId_fkey` FOREIGN KEY (`rolesId`) REFERENCES `roles`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `userAddress` ADD CONSTRAINT `userAddress_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `userPayment` ADD CONSTRAINT `userPayment_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
