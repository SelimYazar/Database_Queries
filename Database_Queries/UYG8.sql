--Soru 1:
--Bir m��teri silindi�inde bu m��teriye ait t�m sipari�lerin otomatik olarak silinmesini
--sa�layan tetikleyici kodunu yaz�n�z ( �lgili tetikleyici kodunu test eden SQL sorgular�n�
--yaz�n�z
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
-- (Test i�in �nce bir m��teri ekleyip sonra silebilirsiniz.)
INSERT INTO sales.customers (first_name, last_name, email) VALUES ('John', 'Doe', 'john.doe@example.com');
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id) VALUES (1, 1, GETDATE(), GETDATE(), 1, 1);

-- Silme i�lemi
DELETE FROM sales.customers WHERE customer_id = 1;

-- Kontrol Sorgusu
SELECT * FROM sales.orders ORDER BY customer_id;




--Soru 2:
--Bir sipari� kalemi eklenirken ilgili �r�n�n stok miktar�n�n otomatik olarak azalt�lmas�n�
--sa�layarak sipari� i�lemi ger�ekle�ti�inde stok seviyelerini ger�ek zamanl� olarak g�ncelleyen
--tetikleyici kodunu yaz�n�z ( �lgili tetikleyici kodunu test eden SQL sorgular�n� yaz�n�z

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
-- (Test i�in �nce bir sipari� olu�turup sonra kontrol edebilirsiniz.)
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id) VALUES (1, 1, GETDATE(), GETDATE(), 1, 1);
INSERT INTO sales.order_items (order_id, product_id, quantity, list_price) VALUES (1, 1, 2, 50.00);

-- Kontrol Sorgusu
SELECT * FROM production.stocks;




--Soru 3: Bir �r�n silindi�inde bu �r�ne ait stok bilgilerinin de otomatik olarak silinmesini
--sa�layan tetikleyici kodunu yaz�n�z ( �lgili tetikleyici kodunu test eden SQL sorgular�n�
--yaz�n�z

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
-- (Test i�in �nce bir �r�n ekleyip sonra silebilirsiniz.)
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('ProductX', 1, 1, 2022, 100.00);
INSERT INTO production.stocks (store_id, product_id, quantity) VALUES (1, 1, 50);

-- Silme i�lemi
DELETE FROM production.products WHERE product_id = 1;

-- Kontrol Sorgusu
SELECT * FROM production.stocks ;




--Soru 4:
--Yeni bir �r�n ekledi�inizde t�m ma�azalarda stok kayd� olu�turan tetikleyici kodunu
--yaz�n�z ( �lgili tetikleyici kodunu test eden SQL sorgular�n� yaz�n�z .
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
-- (Test i�in �nce bir �r�n ekleyip sonra kontrol edebilirsiniz.)
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('ProductY', 1, 1, 2022, 120.00);

-- Kontrol Sorgusu
SELECT * FROM production.stocks;





--Soru 5:
--Bir kategori silindi�inde, silinen kategoriye ait �r�nlerin kategori bilgilerini NULL
--olarak g�ncelleyen tetikleyici kodunu yaz�n�z ( �lgili tetikleyici kodunu test eden SQL
--sorgular�n� yaz�n�z)
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
-- (Test i�in �nce bir kategori ekleyip sonra �r�n ekleyip sonra kontrol edebilirsiniz.)
INSERT INTO production.categories (category_name) VALUES ('Electronics');
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('Laptop', 1, 1, 2022, 800.00);

-- Silme i�lemi
DELETE FROM production.categories WHERE category_id = 1;

-- Kontrol Sorgusu
SELECT * FROM production.products;
