

--1) Ürünler(products) tablosundaki yer alan ürünlerden en düþük ürün fiyatýný ve en yüksek
--ürün fiyatýný ekrana listeleyiniz (10p).
select max(list_price) as max, min(list_price) as min from production.products;

--2) Ürünler(products) tablosundaki yer alan ürünlerin toplam sayýsýný, toplam fiyatýný ve
--ortalama fiyatýný ekrana listeleyiniz (10p).
select count (*) as total_products, sum(list_price) as total_price, avg(list_price) as avg_price from production.products;

--3)Baldwin Bikes' maðazasýndan(stores) sipariþ(orders) alan 5 adet çalýþan(staffs) listeleyiniz.
--Ad ve soyad bilgilerini ekrana yazdýrýnýz (
select top 5 first_name, last_name from sales.staffs join sales.orders on staffs.staff_id = orders.staff_id	 join sales.stores on orders.store_id = stores.store_id where store_name = 'Baldwin Bikes' ;


--4)Adýnýn son harfi S ve soyadýnýn üçüncü harfi A olan tüm müþterileri(customers) listeleyiniz.
--Ad ve soyad bilgilerini ekrana yazdýrýnýz (20p).

SELECT first_name, last_name FROM sales.customers WHERE first_name LIKE '%S' AND last_name LIKE '__A%';

--5) Model yýlý 2015 ve 2017 dahil olmak üzere bu yýllar arasýndaki ürünleri(products) sipariþ
--almýþ (order_items & orders) çalýþanlarý(customers) listeleyiniz. Ad ve soyad bilgilerini
--eþsiz olarak ekrana yazdýrýnýz (20p). Bu soruyu gerçekleþtirirken BETWEEN kullanýnýz.
select distinct first_name, last_name from sales.staffs join sales.orders on staffs.staff_id = orders.staff_id join sales.order_items on orders.order_id = order_items.order_id join production.products on order_items.product_id = products.product_id where model_year between 2015 and 2017;


--6) 'Rowlett Bikes' ve 'Baldwin Bikes' maðazalarýndan(stores) sipariþ(orders) alan 10 adet
--çalýþaný(staffs) listeleyiniz (20p). Ad ve soyad bilgilerini ekrana yazdýrýnýz. Bu
--soruyu gerçekleþtirirken IN kullanýnýz.
select top 10 first_name, last_name from sales.staffs join sales.orders on staffs.staff_id = orders.staff_id join sales.stores on orders.store_id = stores.store_id where store_name in ('Rowlett Bikes', 'Baldwin Bikes');