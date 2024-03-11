--1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
SELECT product_name, quantity_per_unit FROM products;

--2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
SELECT product_id, product_name FROM products WHERE discontinued = 1;

--3. Durdurulmayan (`Discontinued`) Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
SELECT product_id, product_name FROM products WHERE discontinued = 0;

--4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
SELECT product_id, product_name, unit_price FROM products WHERE unit_price < 20;

--5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
--5. Between
SELECT product_id, product_name, unit_price FROM products WHERE unit_price BETWEEN 15 AND 25;
--5. Where - And
SELECT product_id, product_name, unit_price FROM products WHERE unit_price >= 15 AND unit_price <= 25;

--6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
SELECT product_name, units_on_order, units_in_stock FROM products WHERE units_in_stock < units_on_order;

--7. İsmi `a` ile başlayan ürünleri listeleyeniz.
SELECT * FROM products WHERE product_name LIKE 'a%';

--8. İsmi `i` ile biten ürünleri listeleyeniz.
SELECT * FROM products WHERE product_name LIKE '%i';

--9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
SELECT product_name, unit_price, unit_price * 1.18 as Unit_Price_KDV FROM products;

--10. Fiyatı 30 dan büyük kaç ürün var?
SELECT COUNT(*) FROM products WHERE unit_price > 30;

--11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
SELECT LOWER(product_name), unit_price FROM products ORDER BY unit_price DESC;

--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
--12. Concat Operator
SELECT first_name || ' ' || last_name AS full_name FROM employees;
--12. Concat Function
SELECT CONCAT(first_name,' ',last_name) AS full_name FROM employees;

--13. Region alanı NULL olan kaç tedarikçim var?
SELECT COUNT(*) AS suppliers_region_null_count FROM suppliers WHERE region IS NULL;

--14. a. Null olmayanlar?
SELECT COUNT(*) AS suppliers_region_not_null_count FROM suppliers WHERE region IS NOT NULL; 

--15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
--15. Concat Operator
SELECT UPPER('TR' || product_name) FROM products;
--15. Concat Function
SELECT UPPER(CONCAT('TR',product_name)) FROM products;

--16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
SELECT
CASE WHEN unit_price < 20 THEN 'TR' || product_name
ELSE product_name
END AS product_name
FROM products;

--17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price FROM products ORDER BY unit_price DESC;

--18. En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price FROM products ORDER BY unit_price DESC LIMIT 10;

--19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name, unit_price FROM products WHERE unit_price > (select AVG(unit_price) FROM products);

--20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
SELECT SUM(unit_price * units_in_stock) FROM products;

--21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
SELECT discontinued, COUNT(*) FROM products GROUP BY discontinued;

--22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
--22. Where ile
SELECT product_name, category_name FROM products AS p, categories AS c
WHERE p.category_id = c.category_id;
--22. Inner join ile
SELECT product_name, category_name FROM products AS p
INNER JOIN categories AS c ON c.category_id = p.category_id; 

--23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
SELECT c.category_name, AVG(unit_price) AS "Category Average Price" FROM products AS p
INNER JOIN categories AS c ON c.category_id = p.category_id
GROUP BY c.category_name;

--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
--24. Soru inner join - limit kullanarak
SELECT product_name, unit_price, category_name FROM products AS p
INNER JOIN categories AS c ON c.category_id = p.category_id
ORDER BY unit_price DESC LIMIT 1;
--24. Soru where sub query ile.
SELECT product_name, unit_price, category_name FROM products AS p, categories AS c
WHERE c.category_id = p.category_id AND
p.unit_price = (SELECT MAX(unit_price) from products);

--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
--En çok satılan ürünü GROUP BY yardımı ile her product'ın tüm satış quantity miktarının toplamı ile buldum.
SELECT p.product_id, p.product_name, category_name, s.company_name, SUM(quantity) AS sale_amount FROM order_details AS od
INNER JOIN products AS p ON p.product_id = od.product_id
INNER JOIN categories AS c ON c.category_id = p.category_id
INNER JOIN suppliers AS s ON s.supplier_id = p.supplier_id
GROUP BY p.product_id, c.category_name, s.company_name
ORDER BY sale_amount DESC LIMIT 1;