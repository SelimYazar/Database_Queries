
--Soru 1:
--�r�nler tablosundan model y�l� 2016 olan t�m �r�nlerin ad�n�, marka kimli�ini ve liste fiyat�n� listelemek i�in bir SELECT sorgusu yaz�n�z.
SELECT product_name ,brand_id,list_price  FROM production.products where model_year=2016
--Soru 2:
--�r�nler tablosundaki kategorisi 6 olan t�m benzersiz marka numaralar�n� listeleyiniz
SELECT DISTINCT brand_id FROM production.products where category_id=6
--Soru 3:
--�ipari�ler tablosunda, sipari� durumu 'Tamamlanm��' (4) olan veya 'Reddedilmi�' (3) olan sipari�lerin sipari� numaras�n�, m��teri kimli�ini ve sipari� durumunu listeleyiniz.
SELECT order_id,customer_id,order_status   FROM sales.orders where order_status=3 OR order_status=4
--Soru 4:
--Ma�azalar tablosuna yeni bir ma�aza ekleyin. Ma�aza ad� 'New Store', e-posta adresi 'newstore@email.com' ancak telefon numaras� ve adres bilgileri olmadan.
INSERT INTO sales.stores (store_name,email) VALUES('New Store', 'newstore@email.com')
--Soru 5:
--a) �r�nler tablosunda, �r�n ad� 'NewProductName' olan ve model y�l� 2016 olan �r�n�n liste fiyat�n� '3500' olarak g�ncelleyiniz.
UPDATE production.products
SET list_price = 3500
WHERE product_name = 'NewProductName' AND model_year = 2016
--b) Ma�azalar tablosuna yeni eklenen ma�azay� siliniz. Ma�aza ad� 'New Store', e-posta adresi 'newstore@email.com', sonra �r�n listesini SELECT sorgusu ile �ekiniz.
DELETE FROM sales.stores
WHERE store_name = 'New Store' AND email = 'newstore@email.com'
SELECT * FROM production.products;


