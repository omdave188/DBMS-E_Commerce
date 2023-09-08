CREATE TABLE user_detail (email VARCHAR(255) PRIMARY KEY,name VARCHAR(255) NOT NULL, password VARCHAR(30) NOT NULL);

CREATE TABLE contact_detail (user_email VARCHAR(255) PRIMARY KEY, address_id VARCHAR(255), street VARCHAR(255) NOT NULL,state VARCHAR(50) NOT NULL,
            country VARCHAR(50) NOT NULL,pincode INT NOT NULL,phone VARCHAR(20) NOT NULL);

CREATE TABLE card_detail (
    card_id       INTEGER PRIMARY KEY,
    card_nO   INT NOT NULL,
    expiry_date   DATE NOT NULL,
    cvv           INT NOT NULL,
    buyer_id      VARCHAR(255) NOT NULL
);

CREATE TABLE buyer (
    buyer_id            VARCHAR(255) PRIMARY KEY,
    is_premium_user           INT DEFAULT 0,
    premium_expiry_date   DATE
);

CREATE TABLE seller (
    seller_id        VARCHAR(255) PRIMARY KEY,
    company_name     VARCHAR(255) NOT NULL,
    description      VARCHAR(255),
    rating           DECIMAL(3, 1) DEFAULT 2.5,
    rating_count     INTEGER DEFAULT 0
);

CREATE TABLE category (
    category_id     INTEGER PRIMARY KEY,
    category_title   VARCHAR(255) NOT NULL
);

CREATE TABLE product (
    product_id         INTEGER PRIMARY KEY,
    product_name       VARCHAR(255) NOT NULL,
    seller_id          VARCHAR(255) NOT NULL,
    price              DECIMAL(10, 2) NOT NULL,
    rating             DECIMAL(2, 1),
    category_id        INTEGER,
    product_description VARCHAR(255),
    available_units    INTEGER,
    color              VARCHAR(30),
    porter_id          INTEGER,
    review_count       INTEGER DEFAULT 0
);

CREATE TABLE product_image (
    product_id   INTEGER,
    image_url    VARCHAR(255),
    PRIMARY KEY ( product_id,
                  image_url )
);

CREATE TABLE shopping_cart (
    buyer_id     VARCHAR(255),
    date_added   DATE
);

CREATE TABLE product_shoppingcart (
    product_id   INTEGER,
    buyer_id     VARCHAR(255),
    PRIMARY KEY ( product_id,
                  buyer_id )
);

CREATE TABLE wish_list (
    buyer_id     VARCHAR(255),
    date_added   DATE,
    product_id   INTEGER,
    PRIMARY KEY ( product_id,
                  buyer_id )
);

CREATE TABLE order_detail (
    order_id          INTEGER PRIMARY KEY,
    buyer_id          VARCHAR(255) NOT NULL,
    card_id           INTEGER NOT NULL,
    total_price       DECIMAL(10, 2),
    order_date        DATE,
    delivery_charge   DECIMAL(4, 2) DEFAULT 10,
    delivery_address  VARCHAR(255),
    delivery_date     DATE,
    order_status      CHAR(1) NOT NULL,
    quantity          INTEGER NOT NULL,
    user_email        VARCHAR(255)
);

CREATE TABLE order_product (
    order_id     INTEGER,
    product_id   INTEGER,
    PRIMARY KEY ( order_id,
                  product_id )
);

CREATE TABLE review (
    review_id     INTEGER PRIMARY KEY,
    product_id    INTEGER NOT NULL,
    buyer_id      VARCHAR(255) NOT NULL,
    rating        DECIMAL(2, 1),
    review_date   DATE
);

CREATE TABLE porter (
    porter_id      INTEGER PRIMARY KEY,
    porter_name    VARCHAR(255) NOT NULL,
    porter_phone   DECIMAL(10) NOT NULL
);

ALTER TABLE contact_detail
    ADD CONSTRAINT contact_detail_user_id_fk FOREIGN KEY ( user_email )
        REFERENCES user_detail ( email )
            ON DELETE CASCADE;

ALTER TABLE card_detail
    ADD CONSTRAINT card_info_buyer_id_fk FOREIGN KEY ( buyer_id )
        REFERENCES buyer ( buyer_id )
            ON DELETE CASCADE;

ALTER TABLE product
    ADD CONSTRAINT product_seller_id_fk FOREIGN KEY ( seller_id )
        REFERENCES seller ( seller_id )
            ON DELETE CASCADE;

ALTER TABLE product
    ADD CONSTRAINT product_category_id_fk FOREIGN KEY ( category_id )
        REFERENCES category ( category_id )
            ON DELETE CASCADE;

ALTER TABLE product
    ADD CONSTRAINT product_carrier_id_fk FOREIGN KEY ( porter_id )
        REFERENCES porter ( porter_id )
            ON DELETE CASCADE;

ALTER TABLE product_image
    ADD CONSTRAINT product_image_product_id_fk FOREIGN KEY ( product_id )
        REFERENCES product ( product_id )
            ON DELETE CASCADE;

ALTER TABLE shopping_cart
    ADD CONSTRAINT shopping_cart_buyer_id_fk FOREIGN KEY ( buyer_id )
        REFERENCES buyer ( buyer_id )
            ON DELETE CASCADE;

ALTER TABLE product_shoppingcart
    ADD CONSTRAINT product_sc_buyer_id_fk FOREIGN KEY ( buyer_id )
        REFERENCES buyer ( buyer_id )
            ON DELETE CASCADE;

ALTER TABLE product_shoppingcart
    ADD CONSTRAINT product_sc_product_id_fk FOREIGN KEY ( product_id )
        REFERENCES product ( product_id )
            ON DELETE CASCADE;

ALTER TABLE wish_list
    ADD CONSTRAINT wishlist_buyer_id_fk FOREIGN KEY ( buyer_id )
        REFERENCES buyer ( buyer_id )
            ON DELETE CASCADE;

ALTER TABLE wish_list
    ADD CONSTRAINT wishlist_product_id_fk FOREIGN KEY ( product_id )
        REFERENCES product ( product_id )
            ON DELETE CASCADE;

ALTER TABLE order_detail
    ADD CONSTRAINT order_buyer_id_fk FOREIGN KEY ( buyer_id )
        REFERENCES buyer ( buyer_id )
            ON DELETE CASCADE;

ALTER TABLE order_detail
    ADD CONSTRAINT order_card_id_fk FOREIGN KEY ( card_id )
        REFERENCES card_detail ( card_id )
            ON DELETE CASCADE;

ALTER TABLE order_detail
    ADD CONSTRAINT order_delivery_address_id_fk FOREIGN KEY ( user_email)
        REFERENCES contact_detail (user_email)
            ON DELETE CASCADE;

ALTER TABLE order_product
    ADD CONSTRAINT order_product_order_id_fk FOREIGN KEY ( order_id )
        REFERENCES order_detail ( order_id )
            ON DELETE CASCADE;

ALTER TABLE order_product
    ADD CONSTRAINT order_product_product_id_fk FOREIGN KEY ( product_id )
        REFERENCES product ( product_id )
            ON DELETE CASCADE;

ALTER TABLE review
    ADD CONSTRAINT review_product_id_fk FOREIGN KEY ( product_id )
        REFERENCES product ( product_id )
            ON DELETE CASCADE;

ALTER TABLE review
    ADD CONSTRAINT review_buyer_id_fk FOREIGN KEY ( buyer_id )
        REFERENCES buyer ( buyer_id )
            ON DELETE CASCADE;

--------------------------------------------------------------------------------------------

DELIMITER //
CREATE OR REPLACE PROCEDURE register_buyer (
    IN email VARCHAR(255),
    IN name VARCHAR(255),
    IN password VARCHAR(255)
)
BEGIN
    INSERT INTO user_detail (email, name, password) VALUES (email, name, password);

    INSERT INTO buyer (buyer_id, is_premium_user, premium_expiry_date) VALUES (email, 0, NULL);
END //
DELIMITER ;


--------------------------------------------------------------------------------------------

DELIMITER //

CREATE OR REPLACE PROCEDURE register_seller (
    IN email        VARCHAR(255),
    IN name         VARCHAR(255),
    IN password     VARCHAR(255),
    IN company_name VARCHAR(255),
    IN description  VARCHAR(255)
)
BEGIN
    INSERT INTO user_detail (email, name, password)
    VALUES (email, name, password);

    INSERT INTO seller (seller_id, company_name, description, rating, rating_count)
    VALUES (email, company_name, description, 2.5, 1);
END //

DELIMITER ;

---------------------------------------------------------------------------------------------

DELIMITER //

CREATE OR REPLACE PROCEDURE add_contact_details (
    IN user_email VARCHAR(255),
    IN address_id INT,
    IN street VARCHAR(255),
    IN state VARCHAR(50),
    IN country VARCHAR(50),
    IN pincode INT,
    IN phone VARCHAR(20)
)
BEGIN
    INSERT INTO contact_detail (user_email, address_id, street, state, country, pincode, phone) 
    VALUES (user_email, address_id, street, state, country, pincode, phone);
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE OR REPLACE PROCEDURE add_card_info (
    IN buyer_id VARCHAR(255),
    IN card_id INT,
    IN card_nO DECIMAL(30),
    IN expiry_date DATE,
    IN cvv INT
)
BEGIN
    INSERT INTO card_detail (card_id, card_nO, expiry_date, cvv, buyer_id) 
    VALUES (card_id, card_nO, expiry_date, cvv, buyer_id);
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE OR REPLACE PROCEDURE add_product (
    IN product_id INT,
    IN product_name VARCHAR(255),
    IN seller_id VARCHAR(255),
    IN price DECIMAL(10,2),
    IN rating INT,
    IN category_id INT,
    IN product_description TEXT,
    IN available_units INT,
    IN color VARCHAR(255),
    IN porter_id INT,
    IN review_count INT,
    IN image_url VARCHAR(255)
)
BEGIN
    INSERT INTO product (product_id, product_name, seller_id, price, rating, category_id, product_description, available_units, color, porter_id, review_count) 
    VALUES (product_id, product_name, seller_id, price, rating, category_id, product_description, available_units, color, porter_id, review_count);

    INSERT INTO product_image (product_id, image_url) 
    VALUES (product_id, image_url);
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE add_to_shopping_cart (
    IN buyer_id VARCHAR(255),
    IN product_id INT
)
BEGIN
    INSERT INTO shopping_cart (buyer_id, date_added)
    VALUES (buyer_id, DATE_FORMAT(CURDATE(), '%Y-%m-%d'));

    INSERT INTO product_shoppingcart (product_id, buyer_id)
    VALUES (product_id, buyer_id);
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE add_to_wish_list (
    IN buyer_id VARCHAR(255),
    IN product_id INT
)
BEGIN
    INSERT INTO wish_list (buyer_id, date_added, product_id)
    VALUES (buyer_id, DATE_FORMAT(CURDATE(), '%Y-%m-%d'), product_id);
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE give_review (
    IN review_id INT,
    IN product_id INT,
    IN buyer_id VARCHAR(255),
    IN rating DECIMAL(10, 2),
    IN review_date DATE
)
BEGIN
    INSERT INTO review (review_id, product_id, buyer_id, rating, review_date)
    VALUES (review_id, product_id, buyer_id, rating, review_date);
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE OR REPLACE PROCEDURE login_procedure()
BEGIN
    DECLARE message VARCHAR(255);
    IF NEW.email = 'user_email' AND NEW.password = 'user_password' THEN
        SET message = 'User logged in successfully';
        INSERT INTO user_login (user_id, message) VALUES (NEW.id, message);
    END IF;
END//

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //
CREATE OR REPLACE TRIGGER tr_category_auto_increment
BEFORE INSERT ON category FOR EACH ROW
BEGIN
    SET NEW.category_id = (SELECT COALESCE(MAX(category_id), 0) + 1 FROM category);
END;
//
DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE TRIGGER update_product_rating
AFTER INSERT ON review FOR EACH ROW
BEGIN
    DECLARE new_rating DECIMAL(2, 1);
    DECLARE review_count_old INT;

    SELECT review_count INTO review_count_old
    FROM product
    WHERE product_id = NEW.product_id;

    SET new_rating = NEW.rating;
    UPDATE product
    SET rating = ((rating * review_count_old) + new_rating) / (review_count_old + 1),
        review_count = review_count_old + 1
    WHERE product_id = NEW.product_id;
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE TRIGGER update_seller_rating
AFTER INSERT ON review FOR EACH ROW
BEGIN
    DECLARE new_rating DECIMAL(2, 1);
    DECLARE seller_id_to_update VARCHAR(255);

    SET new_rating = NEW.rating;
    SELECT seller_id INTO seller_id_to_update
    FROM product
    WHERE product_id = NEW.product_id;

    UPDATE seller
    SET rating = ((rating * rating_count) + new_rating) / (rating_count + 1),
        rating_count = rating_count + 1
    WHERE seller_id = seller_id_to_update;
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE update_membership (IN buyer_id_input VARCHAR(255))
BEGIN
    UPDATE buyer
    SET
        is_premium_user = 1,
        premium_expiry_date = DATE_ADD(DATE_FORMAT(CURDATE(), '%Y-%m-%d'), INTERVAL 12 MONTH)
    WHERE
        buyer_id = buyer_id_input;
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE cancel_membership(IN buyer_id_input VARCHAR(255))
BEGIN
    UPDATE buyer
    SET
        is_premium_user = 0,
        premium_expiry_date = NULL
    WHERE
        buyer_id = buyer_id_input;
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //

CREATE OR REPLACE PROCEDURE place_order(IN order_id INT, IN buyer_id_var VARCHAR(255))
BEGIN
    DECLARE card_id_var INT;
    DECLARE address_id_var INT;
    DECLARE total_price_var DECIMAL(10, 2) DEFAULT 0;
    DECLARE total_qty_var DECIMAL(10, 2) DEFAULT 0;
    DECLARE available_units_var DECIMAL(10, 2);
    DECLARE delivery_charge_var DECIMAL(10, 2) DEFAULT 10;
    DECLARE is_premium_user_var INT DEFAULT 0;
    DECLARE product_id_var INT;
    
    DECLARE products_cur CURSOR FOR
        SELECT product_id
        FROM product_shoppingcart
        WHERE buyer_id = buyer_id_var;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @done = TRUE;

    OPEN products_cur;
    SET @done = FALSE;
    
    read_loop: LOOP
        FETCH products_cur INTO product_id_var;
        IF @done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT
            price,
            available_units
        INTO
            total_price_var,
            available_units_var
        FROM
            product
        WHERE
            product_id = product_id_var;

        IF available_units_var > 0 THEN
            SET total_price_var := total_price_var + 0;
            SET total_qty_var := total_qty_var + 1;
            INSERT INTO order_product VALUES (
                order_id,
                product_id_var
            );
        END IF;
    END LOOP;
    
    CLOSE products_cur;

    SELECT
        is_premium_user
    INTO is_premium_user_var
    FROM
        buyer
    WHERE
        buyer_id = buyer_id_var;

    IF is_premium_user_var = 1 THEN
        SET delivery_charge_var := 0;
    END IF;

    SELECT
        card_id
    INTO card_id_var
    FROM
        card_detail
    WHERE
        buyer_id = buyer_id_var;

    SELECT
        address_id
    INTO address_id_var
    FROM
        contact_detail
    WHERE
        user_email = buyer_id_var;

    SET total_price_var := total_price_var + delivery_charge_var + 10;
END //

DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //
CREATE OR REPLACE PROCEDURE insert_order_detail (IN order_id INT, IN buyer_id VARCHAR(255), IN card_id INT, IN total_price DECIMAL(10,2), IN order_date DATE, IN delivery_charge DECIMAL(4,2),
IN delivery_address VARCHAR(255), IN delivery_date DATE, IN order_status CHAR(1), IN quantity INT, IN user_email VARCHAR(255))
BEGIN
    INSERT INTO order_detail (order_id, buyer_id, card_id, total_price, order_date, delivery_charge, delivery_address, delivery_date, order_status, quantity, user_email) 
    VALUES (order_id, buyer_id, card_id, total_price, order_date, COALESCE(delivery_charge, 10), COALESCE(delivery_address, NULL), COALESCE(delivery_date, NULL), 
    COALESCE(order_status, 'C'), quantity, user_email);
END //
DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //
CREATE OR REPLACE PROCEDURE product_category()
BEGIN
    INSERT INTO category (category_title) VALUES ('Fashion and Beauty');
    INSERT INTO category (category_title) VALUES ('Health and Personal Care');
    INSERT INTO category (category_title) VALUES ('Electronics');
END //
DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //
CREATE OR REPLACE TRIGGER porter_auto_increment
BEFORE INSERT ON porter FOR EACH ROW
BEGIN
    DECLARE last_id INT;
    SET last_id = (SELECT MAX(porter_id) FROM porter);
    SET NEW.porter_id = COALESCE(last_id, 0) + 1;
END;
//
DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //
CREATE OR REPLACE PROCEDURE porter_info()
BEGIN
    INSERT INTO porter (porter_name, porter_phone) VALUES (
        'Delhivery',
        1234567890
    );

    INSERT INTO porter (porter_name, porter_phone) VALUES (
        'Fedex',
        1234567890
    );

    INSERT INTO porter (porter_name, porter_phone) VALUES (
        'Blue Dart',
        1212121212
    );

END //
DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //
CREATE TRIGGER update_available_units AFTER INSERT ON order_detail FOR EACH ROW
BEGIN
    DECLARE product_id_var INT;
    DECLARE available_units_var INT;
    DECLARE done INT DEFAULT 0;
    DECLARE products_cur CURSOR FOR
        SELECT product_id FROM order_product WHERE order_id = NEW.order_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN products_cur;

    read_loop: LOOP
        FETCH products_cur INTO product_id_var;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT available_units INTO available_units_var FROM product WHERE product_id = product_id_var;

        IF available_units_var >= 2 THEN
            UPDATE product SET available_units = available_units - 1 WHERE product_id = product_id_var;
        ELSEIF available_units_var = 1 THEN
            UPDATE product SET available_units = available_units - 1 WHERE product_id = product_id_var;
        END IF;
    END LOOP;

    CLOSE products_cur;
END;
//
DELIMITER ;

--------------------------------------------------------------------------------------------

DELIMITER //
CREATE TRIGGER remove_items_from_cart AFTER INSERT ON order_detail FOR EACH ROW
BEGIN
    DELETE FROM shopping_cart WHERE buyer_id = NEW.buyer_id;
    DELETE FROM product_shoppingcart WHERE buyer_id = NEW.buyer_id;
END;
//
DELIMITER ;

--------------------------------------------------------------------------------------------

CALL register_buyer('charmidesai@gmail.com', 'Charmi', '123abc');
CALL register_buyer('riyapatel@gmail.com', 'Riya', '123abc');
CALL register_buyer('khwahishpatel@gmail.com', 'Khwahish', '123abc');


CALL register_seller('kushagradar@gmail.com', 'kushagra', '123abc', 'kushagra Co and Co', 'company of shoes');
CALL register_seller('ruchisingh@gmail.com', 'ruchi', '123abc', 'ruchi Co and Co', 'company of metals');
CALL register_seller('anantprakash@gmail.com', 'anant', '123abc', 'anant Co and Co', 'company of iphones');

CALL add_contact_details('charmidesai@gmail.com', 1, 'Bhattha', 'Gujarat', 'India', 380007, 7777777777);
CALL add_contact_details('khwahishpatel@gmail.com', 2, 'Satellite', 'Gujarat', 'India', 380015, 8888888888);
CALL add_contact_details('riyapatel@gmail.com', 3, 'Lalbaug', 'Gujarat', 'India', 380026, 6969696969);

CALL add_card_info('khwahishpatel@gmail.com', 1, 1234123412341234, STR_TO_DATE('2025-06-23', '%Y-%m-%d'), 696);
CALL add_card_info('riyapatel@gmail.com', 2, 4567456745674567, STR_TO_DATE('2024-04-10', '%Y-%m-%d'), 123);
CALL add_card_info('charmidesai@gmail.com', 3, 6987698769876987, STR_TO_DATE('2023-12-09', '%Y-%m-%d'), 444);

DELIMITER //

CREATE OR REPLACE PROCEDURE my_procedure()
BEGIN
    CALL product_category();
    CALL porter_info();
END //

DELIMITER ;

CALL add_product(1, 'OnePlus Nord CE', 'kushagradar@gmail.com', 400, 2, 3,
                'Best Phone', 3, 'Black', 2, 5,
                'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/71V--WZVUIL._SL1500_.jpg');

CALL add_product(2, 'Lipstick', 'ruchisingh@gmail.com', 15, 3, 1,
                'Best matt Lipstick', 4, 'Red', 3, 3,
                'https://images-static.nykaa.com/media/catalog/product/f/6/f6a87bc8904207500689_1.jpg');

CALL add_product(3, 'Nike Jordan Shoes', 'anantprakash@gmail.com', 50, 5, 1,
                'Best shoes', 1, 'red', 1, 1,
                'https://financesonline.com/uploads/2018/01/Air-Jordan-V.jpg');

CALL add_product(4, 'I phone 13', 'anantprakash@gmail.com', 500, 4, 3,
                'Better than android', 3, 'Rose gold', 2, 2,
                'https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone13_hero_09142021_inline.jpg.large.jpg');

CALL add_product(5, 'Sanitary Napkins', 'ruchisingh@gmail.com', 20, 4, 2,
                'Best sanitary napkins', 12, 'Blue', 1, 1,
                'https://www.jiomart.com/images/product/original/492172032/stayfree-secure-nights-cottony-soft-comfort-sanitary-napkin-20-pads-product-images-o492172032-p590361094-0-202203150315.jpg');

CALL add_to_wish_list('charmidesai@gmail.com', 1);
CALL add_to_wish_list('charmidesai@gmail.com', 4);
CALL add_to_wish_list('riyapatel@gmail.com', 3);
CALL add_to_wish_list('khwahishpatel@gmail.com', 5);

CALL add_to_shopping_cart('riyapatel@gmail.com', 1);
CALL add_to_shopping_cart('charmidesai@gmail.com', 3);
CALL add_to_shopping_cart('khwahishpatel@gmail.com', 2);
CALL add_to_shopping_cart('khwahishpatel@gmail.com', 4);

CALL update_membership('khwahishpatel@gmail.com');

CALL insert_order_detail(1, 'riyapatel@gmail.com', 2, 50.00, DATE(SYSDATE()), 10.00, 'Lalbaug', DATE(DATE_ADD(SYSDATE(), INTERVAL 1 MONTH)), 'C', 
                        3, 'riyapatel@gmail.com');
CALL insert_order_detail(2, 'charmidesai@gmail.com', 3, 100.00, DATE(SYSDATE()), 10.00, 'Bhattha', DATE(DATE_ADD(SYSDATE(), INTERVAL 1 MONTH)), 'C', 
                        2, 'charmidesai@gmail.com');


CALL place_order(1, 'riyapatel@gmail.com');
CALL place_order(2, 'charmidesai@gmail.com');

CALL give_review(1, 1, 'charmidesai@gmail.com', 1, DATE_FORMAT(NOW(), '%Y-%m-%d'));
CALL give_review(2, 3, 'charmidesai@gmail.com', 3, DATE_FORMAT(NOW(), '%Y-%m-%d'));
CALL give_review(3, 2, 'riyapatel@gmail.com', 3.5, DATE_FORMAT(NOW(), '%Y-%m-%d'));
CALL give_review(4, 1, 'khwahishpatel@gmail.com', 3, DATE_FORMAT(NOW(), '%Y-%m-%d'));
CALL give_review(5, 5, 'riyapatel@gmail.com', 1, DATE_FORMAT(NOW(), '%Y-%m-%d'));
CALL give_review(6, 5, 'khwahishpatel@gmail.com', 4, DATE_FORMAT(NOW(), '%Y-%m-%d'));

DELIMITER //

CREATE PROCEDURE remove_wishlist (
    IN buyer_id VARCHAR(255),
    IN product_id INT
)
BEGIN
    DELETE FROM wish_list 
    WHERE buyer_id = buyer_id AND product_id = product_id
    ORDER BY date_added ASC
    LIMIT 1;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE remove_shopping_cart (
    IN buyer_id VARCHAR(255),
    IN product_id INT
)
BEGIN
    DELETE FROM product_shoppingcart 
    WHERE buyer_id = buyer_id AND product_id = product_id
    LIMIT 1;

    DELETE FROM shopping_cart 
    WHERE buyer_id = buyer_id 
    AND NOT EXISTS (
        SELECT * FROM product_shoppingcart 
        WHERE product_shoppingcart.buyer_id = shopping_cart.buyer_id
    );
END //

DELIMITER ;


