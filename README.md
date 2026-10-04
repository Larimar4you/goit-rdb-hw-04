# Домашнє завдання до Теми 4

## DML та DDL команди. Складні SQL вирази

## Завдання 1. Створення бази даних LibraryManagement

````sql
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


Перевірка створених таблиць:
SHOW TABLES;

Створено таблиці:

- authors
- books
- borrowed_books
- genres
- users
  Завдання 2. Заповнення таблиць тестовими даними
  authors
  INSERT INTO authors (author_name)
  VALUES
  ('George Orwell'),
  ('Jane Austen');

Перевірка:
SELECT \* FROM authors;

genres
INSERT INTO genres (genre_name)
VALUES
('Dystopian'),
('Romance');

Перевірка:
SELECT \* FROM genres;

books
INSERT INTO books (title, publication_year, author_id, genre_id)
VALUES
('1984', 1949, 1, 1),
('Animal Farm', 1945, 1, 1);

Перевірка:
SELECT \* FROM books;

users
INSERT INTO users (username, email)
VALUES
('anna', 'anna@example.com'),
('john', 'john@example.com');

Перевірка:
SELECT \* FROM users;

borrowed_books
У таблиці books значення book_id у моєму результаті були 3 та 4, тому саме вони були використані як зовнішні ключі.
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date)
VALUES
(3, 1, '2026-10-01', '2026-10-10'),
(4, 2, '2026-10-02', '2026-10-12');

Перевірка:
SELECT \* FROM borrowed_books;

Завдання 3. Об’єднання всіх таблиць за допомогою INNER JOIN
Для виконання завдання використано базу даних hw03.
USE hw03;

Запит:
SELECT \*
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

У результаті отримано:
518 рядків
Завдання 4
4.1. Визначення кількості рядків
SELECT COUNT(\*) AS total_rows
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

Результат:
518 рядків
4.2. Заміна INNER JOIN на LEFT JOIN
SELECT COUNT(\*) AS total_rows
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

Результат:
518 рядків
Висновок
Після заміни декількох INNER JOIN на LEFT JOIN кількість рядків не змінилася і залишилася 518, оскільки для всіх рядків існують відповідні записи у пов’язаних таблицях.
4.3. Фільтрація за employee_id
Потрібно вибрати тільки ті рядки, де:

- employee_id > 3
- employee_id <= 10
  SELECT \*
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

Результат:
317 рядків
4.4. Групування за назвою категорії
Потрібно згрупувати рядки за назвою категорії, порахувати кількість рядків у кожній групі та середню кількість товару.


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

Для кожної категорії було обчислено:
- кількість рядків — COUNT(*)
- середню кількість товару — AVG(od.quantity)

4.5. Фільтрація за середньою кількістю товару
Потрібно залишити тільки ті групи, де середня кількість товару більша за 21.

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

HAVING використовується для фільтрації результатів після GROUP BY.

4.6. Сортування за спаданням кількості рядків

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

Сортування виконується за спаданням значення row_count.

4.7. Виведення чотирьох рядків із пропуском першого

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

LIMIT 4 — виводить чотири рядки.
OFFSET 1 — пропускає перший рядок.
Отримано:
- Dairy Products
- Confections
- Seafood
- Meat/Poultry


```text
goit-rdb-hw-04/
│
├── README.md
├── hw_04.sql
├── p1_1_tables.png
├── p2_1_authors.png
├── p2_2_genres.png
├── p2_3_books.png
├── p2_4_users.png
├── p2_5_borrowed_books.png
├── p3_1_join.png
├── p4_1_count.png
├── p4_2_left_join.png
├── p4_3_employee_filter.png
├── p4_4_group_by.png
├── p4_5_having.png
├── p4_6_order_by.png
└── p4_7_limit_offset.png








````
