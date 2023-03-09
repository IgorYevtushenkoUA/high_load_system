CREATE SCHEMA IF NOT EXISTS shopping;

SET SCHEMA shopping;

CREATE TABLE stores (
                        id INT NOT NULL PRIMARY KEY,
                        name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
                          id INT NOT NULL PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          price INT NOT NULL
);

CREATE TABLE orders (
                        id INT NOT NULL PRIMARY KEY,
                        store_id INT NOT NULL,
                        order_date DATE NOT NULL,
                        payment INT NOT NULL,
                        CONSTRAINT orders_stores_id_fk FOREIGN KEY (store_id) REFERENCES stores(id)
);

CREATE TABLE sales (
                       order_id INT NOT NULL,
                       product_id INT NOT NULL,
                       price_per_unit INT NOT NULL,
                       quantity INT NOT NULL,
                       total_price INT NOT NULL,
                       PRIMARY KEY (product_id, order_id),
                       CONSTRAINT sales_orders_id_fk FOREIGN KEY (order_id) REFERENCES orders(id),
                       CONSTRAINT sales_products_id_fk FOREIGN KEY (product_id) REFERENCES products(id)
);
