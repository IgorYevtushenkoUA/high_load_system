CREATE DATABASE IF NOT EXISTS `shopping`;

USE `shopping`;

DROP TABLE IF EXISTS `stores`;

CREATE TABLE stores (
                        id INT NOT NULL PRIMARY KEY,
                        name VARCHAR(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE '/csv/stores.csv'
    INTO TABLE stores
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

DROP TABLE IF EXISTS `products`;

CREATE TABLE products (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price INT NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE '/csv/products.csv'
    INTO TABLE products
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

DROP TABLE IF EXISTS `orders`;

CREATE TABLE orders (
    id INT NOT NULL PRIMARY KEY,
    store_id INT NOT NULL,
    order_date DATE NOT NULL,
    payment INT NOT NULL,
    CONSTRAINT orders_stores_id_fk FOREIGN KEY (store_id) REFERENCES stores(id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE '/csv/orders.csv'
    INTO TABLE orders
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;


DROP TABLE IF EXISTS `sales`;

CREATE TABLE sales (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    price_per_unit INT NOT NULL,
    quantity INT NOT NULL,
    total_price INT NOT NULL,
    PRIMARY KEY (product_id, order_id),
    CONSTRAINT sales_orders_id_fk FOREIGN KEY (order_id) REFERENCES orders(id),
    CONSTRAINT sales_products_id_fk FOREIGN KEY (product_id) REFERENCES products(id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOAD DATA INFILE '/csv/sales.csv'
    INTO TABLE sales
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
