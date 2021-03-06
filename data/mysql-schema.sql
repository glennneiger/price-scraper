-- TET Price Comparator Database Schema

SET FOREIGN_KEY_CHECKS=0;

START TRANSACTION;

DROP TABLE IF EXISTS site;
CREATE TABLE site (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    country_id VARCHAR(2) NOT NULL DEFAULT "ES",
    domain VARCHAR(60) NOT NULL,
    factor DOUBLE NOT NULL DEFAULT 1,
    spider VARCHAR(20),
    active INT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UNIQ_SITE_NAME` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS page;
CREATE TABLE page (
    id INT(11) NOT NULL AUTO_INCREMENT, 
    site_id INT(11) NOT NULL, 
    url VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UNIQ_PAGE_URL` (`url`),
    CONSTRAINT `FK_PAGE_SITE` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS product;
CREATE TABLE product (
    id INT(11) NOT NULL AUTO_INCREMENT, 
    ean VARCHAR(20) NOT NULL, 
    brand VARCHAR(20) NOT NULL,
    name VARCHAR(60),
    animal VARCHAR(10) NOT NULL,
    speciality VARCHAR(20) NOT NULL,
    format VARCHAR(10),
    color VARCHAR(10),
    size VARCHAR(10),
    PRIMARY KEY (`id`),
    UNIQUE KEY `UNIQ_PRODUCT_EAN` (`ean`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS page_product;
CREATE TABLE page_product (
    product_id INT(11) NOT NULL,
    page_id INT(11) NOT NULL,
    UNIQUE KEY `UNIQ_PAGE_PRODUCT` (`page_id`, `product_id`),
    CONSTRAINT `FK_PAGE_PRODUCT_PRODUCT` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
    CONSTRAINT `FK_PAGE_PRODUCT_PAGE` FOREIGN KEY (`page_id`) REFERENCES `page` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS price;
CREATE TABLE price (
    id INT(11) NOT NULL AUTO_INCREMENT,
    product_id INT(11) NOT NULL,
    site_id INT(11) NOT NULL,
    datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    qty INT(4) NOT NULL DEFAULT 1,
    price DOUBLE NOT NULL,
    special_price DOUBLE,
    PRIMARY KEY (`id`),
    CONSTRAINT `FK_RESULTS_PRODUCT` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
    CONSTRAINT `FK_RESULTS_SITE` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

COMMIT;

SET FOREIGN_KEY_CHECKS=1;
