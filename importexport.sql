

create database importexportsystem;

use importexportsystem;

-- Consumer Table
CREATE TABLE consumer_port (
port_id INT PRIMARY KEY NOT NULL,
role VARCHAR(50) NOT NULL,
password VARCHAR(255) NOT NULL,
location VARCHAR(255) NOT NULL
);

-- Triggers for consumer_port
DELIMITER //
CREATE TRIGGER consumer_port_insert AFTER INSERT ON consumer_port
FOR EACH ROW BEGIN
    INSERT INTO consumer_port_backup VALUES (NEW.port_id, NEW.role, NEW.password, NEW.location);
END //

CREATE TRIGGER consumer_port_update AFTER UPDATE ON consumer_port
FOR EACH ROW BEGIN
    UPDATE consumer_port_backup SET role = NEW.role, password = NEW.password, location = NEW.location WHERE port_id = OLD.port_id;
END //

CREATE TRIGGER consumer_port_delete AFTER DELETE ON consumer_port
FOR EACH ROW BEGIN
    DELETE FROM consumer_port_backup WHERE port_id = OLD.port_id;
END $$
DELIMITER ;

-- ----------------------------------------------------------


-- Seller Table
CREATE TABLE seller_port (
    port_id INT PRIMARY KEY NOT NULL,
    password VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    role VARCHAR(50)
);


-- Triggers for seller_port
DELIMITER //
CREATE TRIGGER seller_port_insert AFTER INSERT ON seller_port
FOR EACH ROW BEGIN
    INSERT INTO seller_port_backup VALUES (NEW.port_id, NEW.password, NEW.location, NEW.role);
END //

CREATE TRIGGER seller_port_update AFTER UPDATE ON seller_port
FOR EACH ROW BEGIN
    UPDATE seller_port_backup SET password = NEW.password, location = NEW.location, role = NEW.role WHERE port_id = OLD.port_id;
END //

CREATE TRIGGER seller_port_delete AFTER DELETE ON seller_port
FOR EACH ROW BEGIN
    DELETE FROM seller_port_backup WHERE port_id = OLD.port_id;
END //
DELIMITER ;


-- ----------------------------------------------------------

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY auto_increment,
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    seller_id INT NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES seller_port(port_id)
);



-- Triggers for products
DELIMITER //
CREATE TRIGGER products_insert AFTER INSERT ON products
FOR EACH ROW BEGIN
    INSERT INTO products_backup VALUES (NEW.product_id, NEW.product_name, NEW.quantity, NEW.price, NEW.seller_id);
END //

CREATE TRIGGER products_update AFTER UPDATE ON products
FOR EACH ROW BEGIN
    UPDATE products_backup SET product_name = NEW.product_name, quantity = NEW.quantity, price = NEW.price, seller_id = NEW.seller_id WHERE product_id = OLD.product_id;
END //

CREATE TRIGGER products_delete AFTER DELETE ON products
FOR EACH ROW BEGIN
    DELETE FROM products_backup WHERE product_id = OLD.product_id;
END //
DELIMITER ;


-- ----------------------------------------------------------


-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY auto_increment,  
    order_date DATE NOT NULL DEFAULT (CURDATE()),
    order_placed BOOLEAN NOT NULL DEFAULT false,
    shipped BOOLEAN NOT NULL DEFAULT FALSE,
    out_for_delivery BOOLEAN NOT NULL DEFAULT FALSE,
    delivered BOOLEAN NOT NULL DEFAULT FALSE,
    quantity INT NOT NULL,
    product_id INT NOT NULL,
    consumer_port_id INT NULL,
    FOREIGN KEY (consumer_port_id) REFERENCES consumer_port(port_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Triggers for orders
DELIMITER //
CREATE TRIGGER orders_insert AFTER INSERT ON orders
FOR EACH ROW BEGIN
    INSERT INTO orders_backup VALUES (NEW.order_id, NEW.order_date, NEW.order_placed, NEW.shipped, NEW.out_for_delivery, NEW.delivered, NEW.quantity, NEW.product_id, NEW.consumer_port_id);
END //

CREATE TRIGGER orders_update AFTER UPDATE ON orders
FOR EACH ROW BEGIN
    UPDATE orders_backup SET order_date = NEW.order_date, order_placed = NEW.order_placed, shipped = NEW.shipped, out_for_delivery = NEW.out_for_delivery, delivered = NEW.delivered, quantity = NEW.quantity, product_id = NEW.product_id, consumer_port_id = NEW.consumer_port_id WHERE order_id = OLD.order_id;
END //

CREATE TRIGGER orders_delete AFTER DELETE ON orders
FOR EACH ROW BEGIN
    DELETE FROM orders_backup WHERE order_id = OLD.order_id;
END //

DELIMITER ;  

-- --------------------------wwww--------------------------------

-- Reported Products Table
CREATE TABLE reported_products (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    issue_type VARCHAR(50) NOT NULL,
    report_date DATE NOT NULL DEFAULT (CURDATE()),
    solution VARCHAR(255) DEFAULT 'pending',  -- Default to 'pending', allow longer text for solution
    product_id INT NOT NULL,
    consumer_port_id INT NOT NULL,
    FOREIGN KEY (consumer_port_id) REFERENCES consumer_port(port_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);



-- Triggers for reported_products
DELIMITER //
CREATE TRIGGER reported_products_insert AFTER INSERT ON reported_products
FOR EACH ROW BEGIN
    INSERT INTO reported_products_backup VALUES (NEW.report_id, NEW.issue_type, NEW.report_date, NEW.solution, NEW.product_id, NEW.consumer_port_id);
END //

CREATE TRIGGER reported_products_update AFTER UPDATE ON reported_products
FOR EACH ROW BEGIN
    UPDATE reported_products_backup SET issue_type = NEW.issue_type, report_date = NEW.report_date, solution = NEW.solution, product_id = NEW.product_id, consumer_port_id = NEW.consumer_port_id WHERE report_id = OLD.report_id;
END //

CREATE TRIGGER reported_products_delete AFTER DELETE ON reported_products
FOR EACH ROW BEGIN
    DELETE FROM reported_products_backup WHERE report_id = OLD.report_id;
END //
DELIMITER ;


-- ----------------------------www------------------------------

-- Backup Tables
-- Create Backup Tables
CREATE TABLE consumer_port_backup LIKE consumer_port;
CREATE TABLE seller_port_backup LIKE seller_port;
CREATE TABLE products_backup LIKE products;
CREATE TABLE orders_backup LIKE orders;
CREATE TABLE reported_products_backup LIKE reported_products;

-- ---------------------------www-------------------------------
DELIMITER //

-- Procedure to Register User
CREATE PROCEDURE register_user(
    IN p_port_id INT,
    IN p_password VARCHAR(255),
    IN p_confirm_password VARCHAR(255),
    IN p_role ENUM('Consumer', 'Seller'),
    IN p_location VARCHAR(255)
)
BEGIN
    IF p_password = p_confirm_password THEN
        SET p_password = SHA2(p_password, 256);

        IF p_role = 'Consumer' THEN
            -- Check ONLY in consumer_port
            IF NOT EXISTS (SELECT 1 FROM consumer_port WHERE port_id = p_port_id) THEN  -- Key change
                INSERT INTO consumer_port (port_id, role, password, location)
                VALUES (p_port_id, p_role, p_password, p_location);
                SELECT CONCAT('Consumer Registration successful. Your Port ID is: ', p_port_id) AS Message;
            ELSE
                SELECT 'Consumer Port ID is already taken. Please choose a different one.' AS Message;
            END IF;
        ELSEIF p_role = 'Seller' THEN
            -- Check ONLY in seller_port
            IF NOT EXISTS (SELECT 1 FROM seller_port WHERE port_id = p_port_id) THEN -- Key change
                INSERT INTO seller_port (port_id, role, password, location)
                VALUES (p_port_id, p_role, p_password, p_location);
                SELECT CONCAT('Seller Registration successful. Your Port ID is: ', p_port_id) AS Message;
            ELSE
                SELECT 'Seller Port ID is already taken. Please choose a different one.' AS Message;
            END IF;
        END IF;
    ELSE
        SELECT 'Passwords do not match. Registration failed.' AS Message;
    END IF;
END //

DELIMITER ;

-- ----------------------www------------------------------------

-- Login Procedure
DELIMITER //

CREATE PROCEDURE login_user(
    IN p_port_id INT,
    IN p_password VARCHAR(255),
    IN p_role ENUM('Consumer', 'Seller')
)
BEGIN
    DECLARE user_count INT;
    SET p_password = SHA2(p_password, 256);

    IF p_role = 'Consumer' THEN
        SELECT COUNT(*) INTO user_count
        FROM consumer_port
        WHERE port_id = p_port_id AND password = p_password;

        IF user_count = 1 THEN
            SELECT 'Login successful. Redirect to Consumer Dashboard' AS Message;
            CALL ViewConsumerDashboard(p_port_id);
        ELSE
            SELECT 'Invalid Credentials' AS Message;
        END IF;
    ELSEIF p_role = 'Seller' THEN
        SELECT COUNT(*) INTO user_count
        FROM seller_port
        WHERE port_id = p_port_id AND password = p_password;

        IF user_count = 1 THEN
            SELECT 'Login successful. Redirect to Seller Dashboard' AS Message;
            CALL ViewSellerDashboard(p_port_id);
        ELSE
            SELECT 'Invalid Credentials' AS Message;
        END IF;
    END IF;
END //

DELIMITER ;





-- -------------------------www---------------------------------


-- View Consumer Dashboard
DELIMITER //
CREATE PROCEDURE ViewConsumerDashboard(IN consumerID INT)
BEGIN
    CALL ViewAvailableProducts(consumerID);  
    CALL ViewCartItems(consumerID);      
    CALL ViewConsumerOrders(consumerID);
CALL ViewReportedIssues(consumerID, 'Consumer');
   
END //
DELIMITER ;

-- View Available Products (New Procedure)
DELIMITER //
CREATE PROCEDURE ViewAvailableProducts(IN consumerID INT)
BEGIN
    SELECT product_id, product_name, quantity, price
    FROM products
    WHERE quantity > 0; -- Only show products with quantity > 0
END //
DELIMITER ;

-- -------------------------www---------------------------------

DELIMITER //

CREATE PROCEDURE UpdateUserInfo(
    IN p_port_id INT,
    IN p_role ENUM('Consumer', 'Seller'),
    IN p_old_password VARCHAR(255),
    IN p_new_password VARCHAR(255),  
    IN p_confirm_password VARCHAR(255),
    IN p_new_location VARCHAR(255)    
)
BEGIN
    DECLARE v_existing_password VARCHAR(255);
    DECLARE v_user_count INT;

    -- Check if the user exists
    IF p_role = 'Consumer' THEN
        SELECT COUNT(*) INTO v_user_count
        FROM consumer_port
        WHERE port_id = p_port_id;
    ELSEIF p_role = 'Seller' THEN
        SELECT COUNT(*) INTO v_user_count
        FROM seller_port
        WHERE port_id = p_port_id;
    END IF;

    IF v_user_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found';
    END IF;

    -- Password Update Logic (Only if old password is provided)
    IF p_old_password IS NOT NULL AND p_old_password <> '' THEN
        -- Hash the old password for verification
        SET p_old_password = SHA2(p_old_password, 256);

        -- Get the existing password
        IF p_role = 'Consumer' THEN
            SELECT password INTO v_existing_password
            FROM consumer_port
            WHERE port_id = p_port_id;
        ELSEIF p_role = 'Seller' THEN
            SELECT password INTO v_existing_password
            FROM seller_port
            WHERE port_id = p_port_id;
        END IF;

        -- Check if old password matches
        IF v_existing_password <> p_old_password THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Incorrect old password';
        END IF;

        -- Check new password and update
        IF p_new_password IS NOT NULL AND p_new_password <> '' THEN
            IF p_new_password <> p_confirm_password THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'New passwords do not match';
            END IF;

            SET p_new_password = SHA2(p_new_password, 256);

            IF p_role = 'Consumer' THEN
                UPDATE consumer_port
                SET password = p_new_password
                WHERE port_id = p_port_id;
            ELSEIF p_role = 'Seller' THEN
                UPDATE seller_port
                SET password = p_new_password
                WHERE port_id = p_port_id;
            END IF;
        END IF;  -- End of new password check
    END IF;  -- End of old password check


    -- Location Update Logic (Always allowed, independent of password)
    IF p_new_location IS NOT NULL AND p_new_location <> '' THEN
        IF p_role = 'Consumer' THEN
            UPDATE consumer_port
            SET location = p_new_location
            WHERE port_id = p_port_id;
        ELSEIF p_role = 'Seller' THEN
            UPDATE seller_port
            SET location = p_new_location
            WHERE port_id = p_port_id;
        END IF;
    END IF;

    SELECT 'User information updated successfully' AS Message;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE DeleteUser(
    IN p_port_id INT,
    IN p_role ENUM('Consumer', 'Seller'),
    IN p_password VARCHAR(255)  -- Require password for deletion for security
)
BEGIN
    DECLARE v_existing_password VARCHAR(255);
    DECLARE v_user_count INT;

    -- Check if the user exists and get the existing password
    IF p_role = 'Consumer' THEN
        SELECT COUNT(*), password INTO v_user_count, v_existing_password
        FROM consumer_port
        WHERE port_id = p_port_id;
    ELSEIF p_role = 'Seller' THEN
        SELECT COUNT(*), password INTO v_user_count, v_existing_password
        FROM seller_port
        WHERE port_id = p_port_id;
    END IF;

    IF v_user_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found';
    END IF;

   
    SET p_password = SHA2(p_password, 256);

   
    IF v_existing_password <> p_password THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Incorrect password for deletion';
    END IF;

   
    START TRANSACTION;

    IF p_role = 'Consumer' THEN
        DELETE FROM consumer_port
        WHERE port_id = p_port_id;
    ELSEIF p_role = 'Seller' THEN
        DELETE FROM seller_port
        WHERE port_id = p_port_id;
    END IF;

   
    IF ROW_COUNT() > 0 THEN  
        COMMIT;  
        SELECT 'User deleted successfully' AS Message;
    ELSE
        ROLLBACK;  -- Rollback transaction if delete failed
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User deletion failed (possibly due to constraints)'; -- More specific error
    END IF;

END //

DELIMITER ;


-- --------------------------www--------------------------------  


-- Procedure to add a product to the cart (in the orders table)
DELIMITER //

CREATE PROCEDURE AddToCart(
IN p_consumer_id INT,
IN p_product_id INT,
IN p_quantity INT
)
BEGIN
DECLARE v_stock INT;
DECLARE v_price DECIMAL(10,2);
DECLARE v_existing_quantity INT;

-- ... (Stock check logic remains the same) ...

SELECT quantity INTO v_existing_quantity
FROM orders
WHERE consumer_port_id = p_consumer_id AND product_id = p_product_id AND order_placed = FALSE;

IF v_existing_quantity IS NOT NULL THEN
  -- ... (Update logic remains the same, but for order_placed = FALSE) ...
UPDATE orders
SET quantity = quantity + p_quantity
WHERE consumer_port_id = p_consumer_id AND product_id = p_product_id AND order_placed = FALSE;
ELSE
INSERT INTO orders (order_date, order_placed, shipped, out_for_delivery, delivered, quantity, product_id, consumer_port_id)
VALUES (CURDATE(), FALSE, FALSE, FALSE, FALSE, p_quantity, p_product_id, p_consumer_id); -- order_placed = FALSE

SELECT 'Product added to the cart.' AS Message;
END IF;

END //

DELIMITER ;

--remove from cart
DELIMITER //

CREATE PROCEDURE RemoveFromCart(
IN p_consumer_id INT,
IN p_product_id INT
)
BEGIN
DELETE FROM orders
WHERE consumer_port_id = p_consumer_id AND product_id = p_product_id AND order_placed = FALSE;

SELECT 'Product removed from cart.' AS Message;
END //

DELIMITER ;

-- ---------------------------www-------------------------------


-- View Cart Items (New Procedure)
DELIMITER //

CREATE PROCEDURE ViewCartItems(IN consumerID INT)
BEGIN

SELECT
p.product_id,
p.product_name,
o.quantity,
p.price,
(o.quantity * p.price) AS subtotal
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.consumer_port_id = consumerID AND o.order_placed = FALSE;

SELECT SUM(o.quantity * p.price) AS total_price
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.consumer_port_id = consumerID AND o.order_placed = FALSE;

END //

DELIMITER ;
-- --------------------------www--------------------------------


-- orders part
-- Procedure to place an order
DELIMITER //

CREATE PROCEDURE PlaceOrder(
    IN p_consumer_id INT
)
BEGIN
    DECLARE v_order_id INT;  -- You'll need to handle this differently

    START TRANSACTION;

    UPDATE orders
    SET order_placed = TRUE  -- Mark cart items as ordered
    WHERE consumer_port_id = p_consumer_id AND order_placed = FALSE;

    SET v_order_id = LAST_INSERT_ID(); -- This might not be useful; see below

    COMMIT;

    SELECT v_order_id AS order_id; --  Handle order IDs carefully (see below)
END //

DELIMITER ;

-- ---------------------------www-------------------------------


--Reduce product quantity after an order --
DELIMITER //
CREATE TRIGGER reduce_quantity_after_order
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.order_placed = TRUE AND OLD.order_placed = FALSE THEN
        UPDATE products
        SET quantity = quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END //


-- -----------------------------------------------------------
-- View Consumer Orders with Status Updates (Unchanged)
DELIMITER //
CREATE PROCEDURE ViewConsumerOrders(IN consumerID INT)
BEGIN
    SELECT
        o.order_id,
        o.order_date,
        p.product_name,
        o.quantity,
        p.price,
        o.order_placed,
        o.shipped,
        o.out_for_delivery,
        o.delivered,
        CASE
            WHEN o.delivered = TRUE THEN 'Delivered'
            WHEN o.out_for_delivery = TRUE THEN 'Out for Delivery'
            WHEN o.shipped = TRUE THEN 'Shipped'
            WHEN o.order_placed = TRUE THEN 'Order Placed'
            ELSE 'Pending'
        END AS order_status
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE o.consumer_port_id = consumerID;
END //
DELIMITER ;

-- Update Order Status Function (Updated)
DELIMITER //

CREATE FUNCTION UpdateOrderStatusFunction(
    p_order_id INT,
    p_status ENUM('shipped', 'out_for_delivery', 'delivered', 'order_placed')
)
RETURNS BOOLEAN
BEGIN
    DECLARE current_order_placed BOOLEAN;
    DECLARE current_shipped BOOLEAN;
    DECLARE current_out_for_delivery BOOLEAN;
    DECLARE current_delivered BOOLEAN;
    DECLARE update_successful BOOLEAN DEFAULT FALSE;

    SELECT order_placed, shipped, out_for_delivery, delivered
    INTO current_order_placed, current_shipped, current_out_for_delivery, current_delivered
    FROM orders
    WHERE order_id = p_order_id;

    IF current_order_placed IS NULL THEN
        RETURN FALSE;
    END IF;

    IF p_status = 'shipped' THEN
        UPDATE orders
        SET shipped = TRUE
        WHERE order_id = p_order_id;
        IF ROW_COUNT() > 0 THEN SET update_successful = TRUE; END IF;
    ELSEIF p_status = 'out_for_delivery' THEN
        UPDATE orders
        SET out_for_delivery = TRUE
        WHERE order_id = p_order_id;
        IF ROW_COUNT() > 0 THEN SET update_successful = TRUE; END IF;
    ELSEIF p_status = 'delivered' THEN
        UPDATE orders
        SET delivered = TRUE
        WHERE order_id = p_order_id;
        IF ROW_COUNT() > 0 THEN SET update_successful = TRUE; END IF;
    ELSEIF p_status = 'order_placed' THEN
        UPDATE orders
        SET order_placed = TRUE
        WHERE order_id = p_order_id;
        IF ROW_COUNT() > 0 THEN SET update_successful = TRUE; END IF;
    END IF;

    RETURN update_successful;

END //

DELIMITER ;



-- ---------------------www--------------------------------------

-- report issue
-- Procedure to Report an Issue
DELIMITER //
CREATE PROCEDURE ReportIssue(
    IN prod_id INT,
    IN cons_port_id INT,
    IN issue ENUM('damage', 'wrong product', 'delayed', 'still not received', 'missing', 'custom')
)
BEGIN
    INSERT INTO reported_products (product_id, consumer_port_id, report_date, issue_type)
    VALUES (prod_id, cons_port_id, CURDATE(), issue);
END //
DELIMITER ;

-- -------------------------------------------------------------------------------------www------------------------------------------------------------------------------------------------


-- View Seller Dashboard
DELIMITER //
CREATE PROCEDURE ViewSellerDashboard(IN sellerID INT)
BEGIN
    CALL ViewProducts(sellerID);
    CALL ViewOrders(sellerID);
    CALL ViewReportedIssues(sellerID, 'Seller');
    CALL MonthlySalesReport(sellerID, MONTH(CURDATE()), YEAR(CURDATE()));
    CALL AnnualSalesReport(sellerID, YEAR(CURDATE()));
   
END //
DELIMITER ;

-- -----------------------------------------------------------
-- view products
DELIMITER //
CREATE PROCEDURE ViewProducts(IN sellerID INT)
BEGIN
    SELECT product_id, product_name, price, quantity
    FROM products
    WHERE seller_id = sellerID;
END //
DELIMITER ;

-- Procedure to add a new product
DELIMITER //

CREATE PROCEDURE AddProduct(
    IN sellerID INT,
    IN productName VARCHAR(100),
    IN productPrice DECIMAL(10, 2),
    IN productQuantity INT
)
BEGIN
    DECLARE existingProductID INT;
    DECLARE existingQuantity INT;  -- Corrected: Added semicolon here

    -- Check if a product with the same seller, name, and price already exists
    SELECT product_id, quantity INTO existingProductID, existingQuantity
    FROM products
    WHERE seller_id = sellerID AND product_name = productName AND price = productPrice;

    IF existingProductID IS NOT NULL THEN
        -- Product already exists, update the quantity
        UPDATE products
        SET quantity = quantity + productQuantity
        WHERE product_id = existingProductID;

    ELSE
        -- Product does not exist, insert a new row
        INSERT INTO products (product_name, price, quantity, seller_id)
        VALUES (productName, productPrice, productQuantity, sellerID);
    END IF;

END //

DELIMITER ;
-- -----------------------------------------------------------

-- Procedure to update product details
DELIMITER //

CREATE PROCEDURE UpdateProduct(
    IN productID INT,
    IN newName VARCHAR(100),
    IN newPrice DECIMAL(10, 2),
    IN newQuantity INT
)
BEGIN
    UPDATE products
    SET
        product_name = COALESCE(NULLIF(newName, ''), product_name),
        price = COALESCE(newPrice, price),
        quantity = COALESCE(newQuantity, quantity)
    WHERE product_id = productID;

    SELECT product_name, price, quantity
    FROM products
    WHERE product_id = productID;
END //

DELIMITER ;

-- -----------------------------------------------------------

-- Procedure to remove a product
DELIMITER //
CREATE PROCEDURE RemoveProduct(IN productID INT)
BEGIN
    DELETE FROM products WHERE product_id = productID;
END //
DELIMITER ;

-- -----------------------------------------------------------


-- View Orders
DELIMITER //
CREATE PROCEDURE ViewOrders(IN sellerID INT)
BEGIN
    SELECT o.order_id, o.order_date, o.quantity, p.product_name, o.consumer_port_id
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE p.seller_id = sellerID;
END //
DELIMITER ;

-- -----------------------------------------------------------


-- View Reported Issues

-- View Reported Issues (Updated for both Consumer and Seller)


DELIMITER //
CREATE PROCEDURE ViewReportedIssues(IN userID INT, IN userRole VARCHAR(50))  -- Add userRole parameter
BEGIN
    IF userRole = 'Seller' THEN
        SELECT
            rp.report_id,
            rp.issue_type,
            rp.report_date,
            rp.solution,
            p.product_name,
            c.port_id AS consumer_id
        FROM reported_products rp
        JOIN products p ON rp.product_id = p.product_id
        JOIN consumer_port c ON rp.consumer_port_id = c.port_id
        WHERE p.seller_id = (SELECT port_id FROM seller_port WHERE port_id = userID); -- Filter by seller
    ELSEIF userRole = 'Consumer' THEN
        SELECT
            rp.report_id,
            rp.issue_type,
            rp.report_date,
            rp.solution,
            p.product_name,
            s.port_id AS seller_id -- Add seller ID for consumer view
        FROM reported_products rp
        JOIN products p ON rp.product_id = p.product_id
        JOIN seller_port s ON p.seller_id = s.port_id  -- Join with seller_port
        WHERE rp.consumer_port_id = userID; -- Filter by consumer
    END IF;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateReportedProductStatus(
    IN reportID INT,
    IN newStatus ENUM('solved', 'pending')
)
BEGIN
    DECLARE product_name VARCHAR(255);
    DECLARE issue_type_val VARCHAR(50); -- Store the issue type

    UPDATE reported_products
    SET solution = newStatus
    WHERE report_id = reportID;

    IF newStatus = 'solved' THEN
        SELECT p.product_name, rp.issue_type INTO product_name, issue_type_val
        FROM reported_products rp
        JOIN products p ON rp.product_id = p.product_id
        WHERE rp.report_id = reportID;

        -- Construct the solution message based on issue type.
        CASE issue_type_val
            WHEN 'damage' THEN
                SET @solution_message = CONCAT('Solved: We have investigated the reported damage to the ', product_name, ' and have issued a refund/replacement. Please allow 5-7 business days for processing.');
            WHEN 'wrong product' THEN
                SET @solution_message = CONCAT('Solved: We apologize for the error with the ', product_name, '. The correct product has been shipped to you. Please allow 3-5 business days for delivery.');
            WHEN 'delayed' THEN
                SET @solution_message = CONCAT('Solved: We apologize for the delay with your ', product_name, '. The package is currently in transit and is expected to arrive within 2 business days.');
            WHEN 'still not received' THEN
                SET @solution_message = CONCAT('Solved: We are investigating why your ', product_name, ' order has not arrived. We will contact you within 24 hours with an update.');
            WHEN 'missing' THEN
                SET @solution_message = CONCAT('Solved: We are investigating the missing ', product_name, ' and will ship the missing item to you. It will arrive within 3-5 business days.');
            WHEN 'custom' THEN  -- Handle 'custom' issues
                SET @solution_message = CONCAT('Solved: Your custom issue regarding the ', product_name, ' has been resolved. We appreciate your patience.');
            ELSE  -- Default case for any other issue types
                SET @solution_message = CONCAT('Solved: Your issue regarding the ', product_name, ' has been resolved. We appreciate your patience.');
        END CASE;


        UPDATE reported_products
        SET solution = @solution_message
        WHERE report_id = reportID;

    END IF;

    SELECT solution FROM reported_products WHERE report_id = reportID;

END //

DELIMITER ;


-- -----------------------------------------------------------

-- Monthly Sales Report (with Month Name)
DELIMITER //
CREATE PROCEDURE MonthlySalesReport(IN sellerID INT, IN reportMonth INT, IN reportYear INT)
BEGIN
    SELECT
        SUM(o.quantity * p.price) AS monthly_sales,
        MONTHNAME(o.order_date) AS sales_month  -- Get the month name
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE p.seller_id = sellerID AND MONTH(o.order_date) = reportMonth AND YEAR(o.order_date) = reportYear
    GROUP BY sales_month; -- Group by month to avoid multiple rows if there are multiple orders in the same month
END //
DELIMITER ;

-- Annual Sales Report (with Year)
DELIMITER //
CREATE PROCEDURE AnnualSalesReport(IN sellerID INT, IN reportYear INT)
BEGIN
    SELECT
        SUM(o.quantity * p.price) AS annual_sales,
        YEAR(o.order_date) AS sales_year -- Include the year
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE p.seller_id = sellerID AND YEAR(o.order_date) = reportYear
    GROUP BY sales_year; -- Group by year
END //
DELIMITER ;
-- ---------------------------------------------wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww--------------

-- 1. Register User
-- Valid Consumer Registration
CALL register_user(101, 'password123', 'password123', 'Consumer', 'Dahanu');
-- Valid Seller Registration
CALL register_user(201, 'securepass', 'securepass', 'Seller', 'Mumbai');
-- Mismatched Passwords
CALL register_user(102, 'pass1', 'pass2', 'Consumer', 'Pune');
-- Duplicate Port ID (Consumer)
CALL register_user(101, 'newpass', 'newpass', 'Consumer', 'Goa');
-- Duplicate Port ID (Seller)
CALL register_user(201, 'anotherpass', 'anotherpass', 'Seller', 'Nashik');

-- 2. Login User
-- Valid Consumer Login
CALL login_user(101, 'password123', 'Consumer');
-- Valid Seller Login
CALL login_user(201, 'securepass', 'Seller');
-- Invalid Password
CALL login_user(101, 'wrongpass', 'Consumer');
-- Invalid Port ID
CALL login_user(103, 'password123', 'Consumer');
-- Wrong Role
CALL login_user(201, 'securepass', 'Consumer');

-- 3. View Consumer Dashboard
CALL ViewConsumerDashboard(101);

-- 4. View Available Products
CALL ViewAvailableProducts(101);

-- 5. Update User Info
-- Update Consumer Password and Location
CALL UpdateUserInfo(101, 'Consumer', 'password123', 'newpass123', 'newpass123', 'Vapi');
-- Update Seller Location
CALL UpdateUserInfo(201, 'Seller', NULL, NULL, NULL, 'Surat');
-- Incorrect Old Password
CALL UpdateUserInfo(101, 'Consumer', 'wrongoldpass', 'newpass123', 'newpass123', 'Vapi');
-- User Not Found
CALL UpdateUserInfo(104, 'Consumer', 'password', 'newpass', 'newpass', 'Dahanu');

-- 6. Delete User
-- Delete Consumer
CALL DeleteUser(101, 'Consumer', 'newpass123');  -- Assuming password was updated
-- Delete Seller
CALL DeleteUser(201, 'Seller', 'securepass');
-- Incorrect Password for Deletion
CALL DeleteUser(102, 'Consumer', 'wrongpass');
-- User Not Found
CALL DeleteUser(105, 'Consumer', 'password');

-- 7. Add To Cart
-- Add Product to Cart (First Time)
CALL AddToCart(101, 1, 2);  -- Assuming product ID 1 exists and has sufficient stock
-- Add More of Same Product to Cart
CALL AddToCart(101, 1, 3);
-- Add Different Product to Cart
CALL AddToCart(101, 2, 1); -- Assuming product ID 2 exists
-- Insufficient Stock
CALL AddToCart(101, 1, 100); -- Assuming stock of product 1 is less than 100
-- Product Does not exist
CALL AddToCart(101, 5, 2);

-- 8. Remove From Cart
CALL RemoveFromCart(101, 1);
CALL RemoveFromCart(101, 5);

-- 9. View Cart Items
CALL ViewCartItems(101);

-- 10. Place Order
CALL PlaceOrder(101);

-- 11. View Consumer Orders
CALL ViewConsumerOrders(101);

-- 12. Update Order Status Function
SELECT UpdateOrderStatusFunction(1, 'shipped');
SELECT UpdateOrderStatusFunction(1, 'out_for_delivery');
SELECT UpdateOrderStatusFunction(1, 'delivered');
SELECT UpdateOrderStatusFunction(1, 'order_placed');
SELECT UpdateOrderStatusFunction(5, 'shipped'); -- Invalid Order ID


-- 13. Report Issue
CALL ReportIssue(1, 101, 'damage');
CALL ReportIssue(2, 101, 'wrong product');
CALL ReportIssue(1, 101, 'custom');

-- 14. View Seller Dashboard
CALL ViewSellerDashboard(201);

-- 15. View Products (Seller)
CALL ViewProducts(201);

-- 16. Add Product (Seller)
CALL AddProduct(201, 'Laptop', 80000.00, 10);
CALL AddProduct(201, 'Laptop', 80000.00, 10); -- Add more of same product
CALL AddProduct(201, 'Mouse', 1000.00, 20);

-- 17. Update Product (Seller)
CALL UpdateProduct(1, 'Gaming Laptop', 90000.00, 5);
CALL UpdateProduct(1, NULL, NULL, 15);
CALL UpdateProduct(1, 'Laptop', NULL, NULL);

-- 18. Remove Product (Seller)
CALL RemoveProduct(1);

-- 19. View Orders (Seller)
CALL ViewOrders(201);

-- 20. View Reported Issues (Seller)
CALL ViewReportedIssues(201, 'Seller');
CALL ViewReportedIssues(101, 'Consumer');

-- 21. Update Reported Product Status
CALL UpdateReportedProductStatus(1, 'solved');
CALL UpdateReportedProductStatus(2, 'solved');

-- 22. Monthly Sales Report
CALL MonthlySalesReport(201, MONTH(CURDATE()), YEAR(CURDATE()));
CALL MonthlySalesReport(201, 1, 2023);

-- 23. Annual Sales Report
CALL AnnualSalesReport(201, YEAR(CURDATE()));
CALL AnnualSalesReport(201, 2023);

-- 24. Delete product which is in cart
-- Add to cart
CALL AddToCart(101, 2, 2);
-- Try to delete product which is in cart
CALL RemoveProduct(2);
-- Remove product from cart
CALL RemoveFromCart(101, 2);
-- Delete product
CALL RemoveProduct(2);

-- 25. Delete user who has placed order
-- Add to cart
CALL AddToCart(101, 3, 2);
-- Place order
CALL PlaceOrder(101);
-- Try to delete user
CALL DeleteUser(101, 'Consumer', 'newpass123');


