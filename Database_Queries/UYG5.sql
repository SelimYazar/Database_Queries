use BikeStores

/*2016 model yılına a൴t olan ve l൴st f൴yatı 500'den fazla olan tüm ürünler൴, bunların marka ve
kategor൴ ൴s൴mler൴yle b൴rl൴kte l൴steleyen b൴r SQL sorgusu yazın. INNER JOIN kullanarak
marka ve kategor൴ b൴lg൴ler൴n൴ de dah൴l ed൴n. (10p)
*/
SELECT production.products.product_name, production.brands.brand_name, categories.category_name
FROM production.products 
INNER JOIN production.brands 
ON production.products.brand_id = production.brands.brand_id
INNER JOIN production.categories 
ON  production.products.category_id = production.categories.category_id
WHERE  production.products.model_year = 2016 AND  production.products.list_price > 500;


--2. H൴ç s൴par൴ş ed൴lmem൴ş ürünler൴n sayısını bulunuz. (left jo൴n) (20p)
SELECT COUNT( production.products.product_id) AS siparis_edilmemis_urunn_sayisi
FROM  production.products
LEFT JOIN sales.order_items 
ON Products.product_id = order_items.product_id
WHERE sales.order_items.product_id IS NULL;


--3. 'Mercy Brown' adlı müşter൴n൴n verd൴ğ൴ en yüksek s൴par൴ş tutarını bulunuz. (r൴ght jo൴n) (20p)
SELECT MAX(sales.order_items.list_price * sales.order_items.quantity) as max_siparis_ucreti
FROM sales.order_items
RIGHT JOIN sales.orders 
ON sales.order_items.order_id = sales.orders.order_id
RIGHT JOIN sales.customers 
ON sales.orders.customer_id = sales.customers.customer_id
WHERE sales.customers.first_name = 'Mercy' and sales.customers.last_name = 'Brown';


--4. H൴çb൴r satışta adı geçmeyen mağazaların l൴stes൴n൴ bulunuz. (full jo൴n) (20p)
SELECT sales.stores.store_name
FROM sales.stores
FULL JOIN sales.orders
ON Stores.store_id = orders.store_id
WHERE orders.order_id IS NULL;


--5. 'Cru൴sers B൴cycles' kategor൴s൴ndek൴ farklı ürünler൴n adlarını bulunuz. (self jo൴n) (20p)
SELECT DISTINCT(p1.product_name)
FROM production.products p1
JOIN production.products p2 
ON p1.category_id = p2.category_id
WHERE p1.product_name <> p2.product_name 
AND p1.category_id = (SELECT category_id FROM production.categories WHERE category_name = 'Cruisers Bicycles');


--6. 'Trek' markasının toplam kaç farklı ürünü olduğunu bulunuz. (10p) 
SELECT COUNT(DISTINCT production.products.product_id) AS toplam_trek
FROM production.products
WHERE brand_id = (SELECT brand_id FROM production.brands WHERE brand_name = 'Trek');
