CREATE DATABASE IF NOT EXISTS decantix_db;
USE decantix_db;

CREATE TABLE fragrances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    name VARCHAR(150) NOT NULL,
    concentration VARCHAR(50),
    season VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fragrance_id INT UNIQUE NOT NULL,
    initial_capacity_ml INT NOT NULL,
    available_ml INT NOT NULL,
    FOREIGN KEY (fragrance_id) REFERENCES fragrances(id) ON DELETE CASCADE,
    CONSTRAINT chk_positive_stock CHECK (available_ml >= 0) 
) ENGINE=InnoDB;

CREATE TABLE decant_prices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fragrance_id INT NOT NULL,
    size_ml INT NOT NULL, -- 2, 5, 10
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (fragrance_id) REFERENCES fragrances(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stripe_session_id VARCHAR(255) UNIQUE,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('PENDING', 'COMPLETED', 'FAILED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO fragrances (brand, name, concentration, season) VALUES 
('Azzaro', 'The Most Wanted Intense', 'EDP', 'Fall/Winter'),
('Yves Saint Laurent', 'Y', 'EDP', 'Spring/Summer');

INSERT INTO inventory (fragrance_id, initial_capacity_ml, available_ml) VALUES 
(1, 100, 100), 
(2, 100, 100); 

INSERT INTO decant_prices (fragrance_id, size_ml, price) VALUES 
(1, 5, 10.00), (1, 10, 18.00),
(2, 5, 12.00), (2, 10, 22.00);
