

--1) �r�nler(products) tablosundaki yer alan �r�nlerden en d���k �r�n fiyat�n� ve en y�ksek
--�r�n fiyat�n� ekrana listeleyiniz (10p).
select max(list_price) as max, min(list_price) as min from production.products;

--2) �r�nler(products) tablosundaki yer alan �r�nlerin toplam say�s�n�, toplam fiyat�n� ve
--ortalama fiyat�n� ekrana listeleyiniz (10p).
select count (*) as total_products, sum(list_price) as total_price, avg(list_price) as avg_price from production.products;

--3)Baldwin Bikes' ma�azas�ndan(stores) sipari�(orders) alan 5 adet �al��an(staffs) listeleyiniz.
--Ad ve soyad bilgilerini ekrana yazd�r�n�z (
select top 5 first_name, last_name from sales.staffs join sales.orders on staffs.staff_id = orders.staff_id	 join sales.stores on orders.store_id = stores.store_id where store_name = 'Baldwin Bikes' ;


--4)Ad�n�n son harfi S ve soyad�n�n ���nc� harfi A olan t�m m��terileri(customers) listeleyiniz.
--Ad ve soyad bilgilerini ekrana yazd�r�n�z (20p).

SELECT first_name, last_name FROM sales.customers WHERE first_name LIKE '%S' AND last_name LIKE '__A%';

--5) Model y�l� 2015 ve 2017 dahil olmak �zere bu y�llar aras�ndaki �r�nleri(products) sipari�
--alm�� (order_items & orders) �al��anlar�(customers) listeleyiniz. Ad ve soyad bilgilerini
--e�siz olarak ekrana yazd�r�n�z (20p). Bu soruyu ger�ekle�tirirken BETWEEN kullan�n�z.
select distinct first_name, last_name from sales.staffs join sales.orders on staffs.staff_id = orders.staff_id join sales.order_items on orders.order_id = order_items.order_id join production.products on order_items.product_id = products.product_id where model_year between 2015 and 2017;


--6) 'Rowlett Bikes' ve 'Baldwin Bikes' ma�azalar�ndan(stores) sipari�(orders) alan 10 adet
--�al��an�(staffs) listeleyiniz (20p). Ad ve soyad bilgilerini ekrana yazd�r�n�z. Bu
--soruyu ger�ekle�tirirken IN kullan�n�z.
select top 10 first_name, last_name from sales.staffs join sales.orders on staffs.staff_id = orders.staff_id join sales.stores on orders.store_id = stores.store_id where store_name in ('Rowlett Bikes', 'Baldwin Bikes');