--Soru 1:
--Bir müþteri silindiðinde bu müþteriye ait tüm sipariþlerin otomatik olarak silinmesini
--saðlayan tetikleyici kodunu yazýnýz ( Ýlgili tetikleyici kodunu test eden SQL sorgularýný
--yazýnýz
-- Tetikleyici Kodu
-- Tetikleyici Kodu
CREATE TRIGGER trg_DeleteCustomer
ON sales.customers
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM sales.orders
    WHERE customer_id IN (SELECT customer_id FROM deleted);
END;

-- Tetikleyiciyi Test Eden SQL Sorgusu
-- (Test için önce bir müþteri ekleyip sonra silebilirsiniz.)
INSERT INTO sales.customers (first_name, last_name, email) VALUES ('John', 'Doe', 'john.doe@example.com');
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id) VALUES (1, 1, GETDATE(), GETDATE(), 1, 1);

-- Silme iþlemi
DELETE FROM sales.customers WHERE customer_id = 1;

-- Kontrol Sorgusu
SELECT * FROM sales.orders ORDER BY customer_id;




--Soru 2:
--Bir sipariþ kalemi eklenirken ilgili ürünün stok miktarýnýn otomatik olarak azaltýlmasýný
--saðlayarak sipariþ iþlemi gerçekleþtiðinde stok seviyelerini gerçek zamanlý olarak güncelleyen
--tetikleyici kodunu yazýnýz ( Ýlgili tetikleyici kodunu test eden SQL sorgularýný yazýnýz

-- Tetikleyici Kodu
CREATE TRIGGER trg_UpdateStockOnOrder
ON sales.order_items
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE production.stocks
    SET quantity = stocks.quantity - i.quantity
    FROM inserted i
    WHERE production.stocks.product_id = i.product_id
      AND production.stocks.store_id = (SELECT store_id FROM sales.orders WHERE order_id = i.order_id);
END;

-- Tetikleyiciyi Test Eden SQL Sorgusu
-- (Test için önce bir sipariþ oluþturup sonra kontrol edebilirsiniz.)
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id) VALUES (1, 1, GETDATE(), GETDATE(), 1, 1);
INSERT INTO sales.order_items (order_id, product_id, quantity, list_price) VALUES (1, 1, 2, 50.00);

-- Kontrol Sorgusu
SELECT * FROM production.stocks;




--Soru 3: Bir ürün silindiðinde bu ürüne ait stok bilgilerinin de otomatik olarak silinmesini
--saðlayan tetikleyici kodunu yazýnýz ( Ýlgili tetikleyici kodunu test eden SQL sorgularýný
--yazýnýz

-- Tetikleyici Kodu
CREATE TRIGGER trg_DeleteProductStock
ON production.products
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM production.stocks
    WHERE product_id IN (SELECT product_id FROM deleted);
END;

-- Tetikleyiciyi Test Eden SQL Sorgusu
-- (Test için önce bir ürün ekleyip sonra silebilirsiniz.)
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('ProductX', 1, 1, 2022, 100.00);
INSERT INTO production.stocks (store_id, product_id, quantity) VALUES (1, 1, 50);

-- Silme iþlemi
DELETE FROM production.products WHERE product_id = 1;

-- Kontrol Sorgusu
SELECT * FROM production.stocks ;




--Soru 4:
--Yeni bir ürün eklediðinizde tüm maðazalarda stok kaydý oluþturan tetikleyici kodunu
--yazýnýz ( Ýlgili tetikleyici kodunu test eden SQL sorgularýný yazýnýz .
-- Tetikleyici Kodu
CREATE TRIGGER trg_InsertProductStock
ON production.products
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @newProductId INT;
    SELECT @newProductId = product_id FROM inserted;

    INSERT INTO production.stocks (store_id, product_id, quantity)
    SELECT store_id, @newProductId, 0
    FROM sales.stores;
END;

-- Tetikleyiciyi Test Eden SQL Sorgusu
-- (Test için önce bir ürün ekleyip sonra kontrol edebilirsiniz.)
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('ProductY', 1, 1, 2022, 120.00);

-- Kontrol Sorgusu
SELECT * FROM production.stocks;





--Soru 5:
--Bir kategori silindiðinde, silinen kategoriye ait ürünlerin kategori bilgilerini NULL
--olarak güncelleyen tetikleyici kodunu yazýnýz ( Ýlgili tetikleyici kodunu test eden SQL
--sorgularýný yazýnýz)
-- Tetikleyici Kodu
CREATE TRIGGER trg_UpdateCategoryOnProductDelete
ON production.categories
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE production.products
    SET category_id = NULL
    WHERE category_id IN (SELECT category_id FROM deleted);
END;

-- Tetikleyiciyi Test Eden SQL Sorgusu
-- (Test için önce bir kategori ekleyip sonra ürün ekleyip sonra kontrol edebilirsiniz.)
INSERT INTO production.categories (category_name) VALUES ('Electronics');
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('Laptop', 1, 1, 2022, 800.00);

-- Silme iþlemi
DELETE FROM production.categories WHERE category_id = 1;

-- Kontrol Sorgusu
SELECT * FROM production.products;
