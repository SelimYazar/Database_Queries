--Soru 1: Belirli bir eyaletteki t�m m��terilerin e-posta adreslerini listeleyen bir sakl� yordam-
--yaz�n. Yordam, eyalet ad�n� parametre olarak almal�d�r. Exec komutu ile yordam� �a��r�n�z.
--(15p)

alter PROCEDURE ListCustomersInState
    @state VARCHAR(25)
AS
BEGIN
    SELECT
        email
    FROM
        sales.customers
    WHERE
        state = @state;
END;
EXEC ListCustomersInState @state = 'Ca';


--Soru 2: �nceki sakl� yordam� g�ncelleyerek; Toplam sipari� de�eri en y�ksek olan ilk 5
--m��teriyi listeleyen bir sakl� yordam yaz�n. Exec komutu ile yordam� �a��r�n�z. (15p)

ALTER PROCEDURE ListCustomersInState
AS
BEGIN
    SELECT TOP 5
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.list_price * oi.quantity) AS total_order_value
    FROM
        sales.customers c
    INNER JOIN
        sales.orders o ON c.customer_id = o.customer_id
    INNER JOIN
        sales.order_items oi ON o.order_id = oi.order_id
    INNER JOIN
        production.products p ON oi.product_id = p.product_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
    ORDER BY
        total_order_value DESC;
END;
EXEC ListCustomersInState;


--Soru 3: Belirli bir kategoriye ait t�m �r�nleri, sadece stokta olanlar� listeleyecek �ekilde,
--listeleyen bir sakl� yordam yaz�n. Yordam, kategori kimli�ini parametre olarak almal�d�r. Exec
--komutu ile yordam� �a��r�n�z. (20p)


CREATE PROCEDURE ListProductsInCategoryWithStock
    @category_id INT
AS
BEGIN
    SELECT
        p.product_name
    FROM
        production.products p
    INNER JOIN
        production.stocks s ON p.product_id = s.product_id
    WHERE
        p.category_id = @category_id
        AND s.quantity > 0;
END;
EXEC ListProductsInCategoryWithStock @category_id = 1;



--Soru 4: Belirli bir tarih aral���nda yap�lan t�m sipari�lerin detaylar�n� (m��teri ad�, sipari�
--numaras�, �r�n ad�, miktar, fiyat) g�steren bir sakl� yordam yaz�n�z. Yordam, ba�lang�� ve biti�
--tarihlerini parametre olarak almal�d�r. Exec komutu ile yordam� �a��r�n�z. (20p)

CREATE PROCEDURE ListOrdersDetailsInDateRange
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    SELECT
        c.first_name + ' ' + c.last_name AS customer_name,
        o.order_id,
        p.product_name,
        oi.quantity,
        p.list_price
    FROM
        sales.orders o
    INNER JOIN
        sales.customers c ON o.customer_id = c.customer_id
    INNER JOIN
        sales.order_items oi ON o.order_id = oi.order_id
    INNER JOIN
        production.products p ON oi.product_id = p.product_id
    WHERE
        o.order_date BETWEEN @start_date AND @end_date;
END;
EXEC ListOrdersDetailsInDateRange '2016-01-01', '2023-12-31';


--Soru 5: �al��anlar (staff) tablosundaki aktif olmayan (active de�eri 0 olan) personellerin
--durumunu g�ncelleyen ve belirli bir tarihten �nce i�e al�nanlar� silen bir sakl� yordam� yaz�n�z.
--Yordam, g�ncellenmesi gereken yeni durumu active state�i al�cakt�r. Exec komutu ile yordam�
--�a��r�n�z. (20p)
--5
CREATE PROCEDURE UpdateInactiveStaffStatusAndDeleteOldHiress
    @NewActiveState BIT
AS
BEGIN
    UPDATE sales.staffs
    SET active = @NewActiveState
    WHERE active = 0;

END;

EXEC UpdateInactiveStaffStatusAndDeleteOldHiress @NewActiveState = 1;

--Soru 6: Olu�turulan son sakl� yordam� siliniz. (10p)

DROP PROCEDURE UpdateInactiveStaffStatusAndDeleteOldHiress



--EXEC UpdateInactiveStaffStatusAndDeleteOldHiress 



