CREATE DATABASE LibraryManagement;

USE LibraryManagement;

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100)
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(100)
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    publication_year YEAR,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100),
    email VARCHAR(255)
);

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

SHOW TABLES;

INSERT INTO authors (author_name)
VALUES
    ('George Orwell'),
    ('Jane Austen');

SELECT * FROM authors;

INSERT INTO genres (genre_name)
VALUES
    ('Dystopian'),
    ('Romance');

SELECT * FROM genres;

INSERT INTO books (title, publication_year, author_id, genre_id)
VALUES
    ('1984', 1949, 1, 1),
    ('Animal Farm', 1945, 1, 1);

SELECT * FROM books;

INSERT INTO users (username, email)
VALUES
    ('anna', 'anna@example.com'),
    ('john', 'john@example.com');

SELECT * FROM users;

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date)
VALUES
    (3, 1, '2026-10-01', '2026-10-10'),
    (4, 2, '2026-10-02', '2026-10-12');

SELECT * FROM borrowed_books;


USE hw03;

SELECT *
FROM order_details od
INNER JOIN orders o
    ON od.order_id = o.id
INNER JOIN customers c
    ON o.customer_id = c.id
INNER JOIN products p
    ON od.product_id = p.id
INNER JOIN categories cat
    ON p.category_id = cat.id
INNER JOIN employees e
    ON o.employee_id = e.employee_id
INNER JOIN shippers sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers s
    ON p.supplier_id = s.id;


SELECT COUNT(*) AS total_rows
FROM order_details od
INNER JOIN orders o
    ON od.order_id = o.id
INNER JOIN customers c
    ON o.customer_id = c.id
INNER JOIN products p
    ON od.product_id = p.id
INNER JOIN categories cat
    ON p.category_id = cat.id
INNER JOIN employees e
    ON o.employee_id = e.employee_id
INNER JOIN shippers sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers s
    ON p.supplier_id = s.id;


SELECT COUNT(*) AS total_rows
FROM order_details od
LEFT JOIN orders o
    ON od.order_id = o.id
LEFT JOIN customers c
    ON o.customer_id = c.id
INNER JOIN products p
    ON od.product_id = p.id
INNER JOIN categories cat
    ON p.category_id = cat.id
INNER JOIN employees e
    ON o.employee_id = e.employee_id
LEFT JOIN shippers sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers s
    ON p.supplier_id = s.id;


SELECT *
FROM order_details od
INNER JOIN orders o
    ON od.order_id = o.id
INNER JOIN customers c
    ON o.customer_id = c.id
INNER JOIN products p
    ON od.product_id = p.id
INNER JOIN categories cat
    ON p.category_id = cat.id
INNER JOIN employees e
    ON o.employee_id = e.employee_id
INNER JOIN shippers sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers s
    ON p.supplier_id = s.id
WHERE o.employee_id > 3
  AND o.employee_id <= 10;


SELECT
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS average_quantity
FROM order_details od
INNER JOIN orders o
    ON od.order_id = o.id
INNER JOIN customers c
    ON o.customer_id = c.id
INNER JOIN products p
    ON od.product_id = p.id
INNER JOIN categories cat
    ON p.category_id = cat.id
INNER JOIN employees e
    ON o.employee_id = e.employee_id
INNER JOIN shippers sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers s
    ON p.supplier_id = s.id
WHERE o.employee_id > 3
  AND o.employee_id <= 10
GROUP BY cat.name;


SELECT
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS average_quantity
FROM order_details od
INNER JOIN orders o
    ON od.order_id = o.id
INNER JOIN customers c
    ON o.customer_id = c.id
INNER JOIN products p
    ON od.product_id = p.id
INNER JOIN categories cat
    ON p.category_id = cat.id
INNER JOIN employees e
    ON o.employee_id = e.employee_id
INNER JOIN shippers sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers s
    ON p.supplier_id = s.id
WHERE o.employee_id > 3
  AND o.employee_id <= 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21;


SELECT
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS average_quantity
FROM order_details od
INNER JOIN orders o
    ON od.order_id = o.id
INNER JOIN customers c
    ON o.customer_id = c.id
INNER JOIN products p
    ON od.product_id = p.id
INNER JOIN categories cat
    ON p.category_id = cat.id
INNER JOIN employees e
    ON o.employee_id = e.employee_id
INNER JOIN shippers sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers s
    ON p.supplier_id = s.id
WHERE o.employee_id > 3
  AND o.employee_id <= 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY row_count DESC;


SELECT
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS average_quantity
FROM order_details od
INNER JOIN orders o
    ON od.order_id = o.id
INNER JOIN customers c
    ON o.customer_id = c.id
INNER JOIN products p
    ON od.product_id = p.id
INNER JOIN categories cat
    ON p.category_id = cat.id
INNER JOIN employees e
    ON o.employee_id = e.employee_id
INNER JOIN shippers sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers s
    ON p.supplier_id = s.id
WHERE o.employee_id > 3
  AND o.employee_id <= 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY row_count DESC
LIMIT 4 OFFSET 1;