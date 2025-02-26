
--Soru 1:
--Ürünler tablosundan model yýlý 2016 olan tüm ürünlerin adýný, marka kimliðini ve liste fiyatýný listelemek için bir SELECT sorgusu yazýnýz.
SELECT product_name ,brand_id,list_price  FROM production.products where model_year=2016
--Soru 2:
--Ürünler tablosundaki kategorisi 6 olan tüm benzersiz marka numaralarýný listeleyiniz
SELECT DISTINCT brand_id FROM production.products where category_id=6
--Soru 3:
--Þipariþler tablosunda, sipariþ durumu 'Tamamlanmýþ' (4) olan veya 'Reddedilmiþ' (3) olan sipariþlerin sipariþ numarasýný, müþteri kimliðini ve sipariþ durumunu listeleyiniz.
SELECT order_id,customer_id,order_status   FROM sales.orders where order_status=3 OR order_status=4
--Soru 4:
--Maðazalar tablosuna yeni bir maðaza ekleyin. Maðaza adý 'New Store', e-posta adresi 'newstore@email.com' ancak telefon numarasý ve adres bilgileri olmadan.
INSERT INTO sales.stores (store_name,email) VALUES('New Store', 'newstore@email.com')
--Soru 5:
--a) Ürünler tablosunda, ürün adý 'NewProductName' olan ve model yýlý 2016 olan ürünün liste fiyatýný '3500' olarak güncelleyiniz.
UPDATE production.products
SET list_price = 3500
WHERE product_name = 'NewProductName' AND model_year = 2016
--b) Maðazalar tablosuna yeni eklenen maðazayý siliniz. Maðaza adý 'New Store', e-posta adresi 'newstore@email.com', sonra ürün listesini SELECT sorgusu ile çekiniz.
DELETE FROM sales.stores
WHERE store_name = 'New Store' AND email = 'newstore@email.com'
SELECT * FROM production.products;


