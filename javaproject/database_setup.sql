-- Create the database
CREATE DATABASE IF NOT EXISTS onlinespareparts;

-- Use the database
USE onlinespareparts;

-- Create user table
CREATE TABLE IF NOT EXISTS user (
    username VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    password VARCHAR(100) NOT NULL,
    type VARCHAR(20) DEFAULT 'customer'
);

-- Create product table
CREATE TABLE IF NOT EXISTS product (
    idproduct INT AUTO_INCREMENT PRIMARY KEY,
    pname VARCHAR(100) NOT NULL,
    producttype VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    description TEXT,
    image VARCHAR(255),
    usrname VARCHAR(50),
    FOREIGN KEY (usrname) REFERENCES user(username)
);

-- Create cart table
CREATE TABLE IF NOT EXISTS cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idproduct INT,
    username VARCHAR(50),
    image VARCHAR(255),
    description TEXT,
    totalamount DECIMAL(10,2),
    quantity INT,
    FOREIGN KEY (idproduct) REFERENCES product(idproduct),
    FOREIGN KEY (username) REFERENCES user(username)
);

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    orderid INT AUTO_INCREMENT PRIMARY KEY,
    productid INT,
    pname VARCHAR(100),
    price DECIMAL(10,2),
    quantity INT,
    address VARCHAR(255),
    username VARCHAR(50),
    image VARCHAR(255),
    status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (productid) REFERENCES product(idproduct),
    FOREIGN KEY (username) REFERENCES user(username)
);

-- Create suggestion/feedback table
CREATE TABLE IF NOT EXISTS suggestion (
    suggestionid INT AUTO_INCREMENT PRIMARY KEY,
    suggestiontype VARCHAR(50),
    feedback TEXT,
    image VARCHAR(255),
    email VARCHAR(100),
    username VARCHAR(50),
    reply TEXT,
    FOREIGN KEY (username) REFERENCES user(username)
);

-- Create card table for payment details
CREATE TABLE IF NOT EXISTS card (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    cname VARCHAR(100),
    cardnumber VARCHAR(20),
    cvv VARCHAR(5),
    expmonth VARCHAR(10),
    expyear VARCHAR(10),
    FOREIGN KEY (username) REFERENCES user(username)
);

-- Insert admin user
INSERT INTO user (username, name, address, dob, gender, email, phone, password, type)
VALUES ('admin', 'Administrator', 'Admin Address', '2000-01-01', 'Male', 'admin@spareparts.com', '1234567890', 'admin123', 'admin');

-- Insert computer parts product categories
INSERT INTO product (pname, producttype, price, quantity, description, image, usrname)
VALUES 
('Gaming Monitor', 'Monitor', 299.99, 20, 'High-refresh rate gaming monitor with HDR support', 'gaming_monitor.jpg', 'admin'),
('Mechanical Keyboard', 'Keyboard', 89.99, 35, 'Premium mechanical keyboard with RGB lighting', 'mechanical_keyboard.jpg', 'admin'),
('Graphics Card', 'Graphic Card', 499.99, 15, 'High-performance graphics card for gaming and content creation', 'graphics_card.jpg', 'admin'),
('SSD Drive', 'Storage', 129.99, 40, 'Fast SSD storage for improved system performance', 'ssd_drive.jpg', 'admin'),
('CPU Processor', 'Processor', 349.99, 25, 'High-performance multi-core processor for gaming and productivity', 'cpu_processor.jpg', 'admin'),
('RAM Memory', 'Memory', 79.99, 50, '16GB DDR4 high-speed memory modules', 'ram_memory.jpg', 'admin'),
('Gaming Mouse', 'Mouse', 59.99, 30, 'Precision gaming mouse with adjustable DPI and programmable buttons', 'gaming_mouse.jpg', 'admin'),
('CPU Cooler', 'Cooler', 69.99, 15, 'Silent liquid cooling system for CPU temperature control', 'cpu_cooler.jpg', 'admin');

-- Add sample order status data (will only apply if there are existing orders)
UPDATE orders SET status = 'Processing' WHERE productid % 4 = 0;
UPDATE orders SET status = 'Shipped' WHERE productid % 4 = 1;
UPDATE orders SET status = 'Delivered' WHERE productid % 4 = 2;
-- Others will remain with default 'Pending' status