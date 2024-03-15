--26. Stokta bulunmayan ürünlerin ürün listesiyle birlikte tedarikçilerin ismi ve iletişim numarasını (`ProductID`, `ProductName`, `CompanyName`, `Phone`) almak için bir sorgu yazın.
SELECT pr.product_id, pr.product_name, s.company_name, s.phone FROM products AS pr
INNER JOIN suppliers AS s ON pr.supplier_id = s.supplier_id
WHERE units_in_stock = 0;

--27. 1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı
SELECT o.order_id, o.ship_address, e.first_name, e.last_name FROM orders AS o
INNER JOIN employees AS e ON o.employee_id = e.employee_id
WHERE EXTRACT('YEAR' FROM order_date) = 1998
AND EXTRACT('MONTH' FROM order_date) = 3
ORDER BY order_date;

--28. 1997 yılı şubat ayında kaç siparişim var?
SELECT COUNT(*) FROM orders AS o
WHERE EXTRACT('YEAR' FROM order_date) = 1997
AND EXTRACT('MONTH' FROM order_date) = 02;

--29. London şehrinden 1998 yılında kaç siparişim var?
SELECT COUNT(*) FROM orders AS o
WHERE EXTRACT('YEAR' FROM order_date) = 1998
AND ship_city = 'London';

--30. 1997 yılında sipariş veren müşterilerimin contactname ve telefon numarası
SELECT DISTINCT(cs.contact_name), cs.phone FROM orders AS o
INNER JOIN customers AS cs ON o.customer_id = cs.customer_id
WHERE EXTRACT('YEAR' FROM order_date) = 1997;

--31. Taşıma ücreti 40 üzeri olan siparişlerim
SELECT * FROM orders AS o
WHERE freight > 40;

--32. Taşıma ücreti 40 ve üzeri olan siparişlerimin şehri, müşterisinin adı
SELECT DISTINCT(ct.contact_name), o.ship_city FROM orders AS o
INNER JOIN customers AS ct ON o.customer_id = ct.customer_id
WHERE freight >= 40;

--33. 1997 yılında verilen siparişlerin tarihi, şehri, çalışan adı -soyadı ( ad soyad birleşik olacak ve büyük harf),
SELECT o.order_date, o.ship_city, UPPER(e.first_name || ' ' || e.last_name) AS "full_name" FROM orders AS o
INNER JOIN employees AS e ON o.employee_id = e.employee_id
WHERE EXTRACT('YEAR' FROM order_date) = 1997;

--34. 1997 yılında sipariş veren müşterilerin contactname i, ve telefon numaraları ( telefon formatı 2223322 gibi olmalı )
SELECT DISTINCT(cs.contact_name), regexp_replace(phone, '[^0-9]', '', 'g') AS telefon_format FROM orders AS o
INNER JOIN customers AS cs ON o.customer_id = cs.customer_id
WHERE EXTRACT('YEAR' FROM order_date) = 1997;

--35. Sipariş tarihi, müşteri contact name, çalışan ad, çalışan soyad
SELECT o.order_date, cs.contact_name, e.first_name, e.last_name FROM orders AS o
INNER JOIN customers AS cs ON o.customer_id = cs.customer_id
INNER JOIN employees AS e ON o.employee_id = e.employee_id;

--36. Geciken siparişlerim?
SELECT * FROM orders AS o
WHERE shipped_date > required_date;

--37. Geciken siparişlerimin tarihi, müşterisinin adı
SELECT o.order_date, o.shipped_date, cs.contact_name  FROM orders AS o
INNER JOIN customers AS cs ON o.customer_id = cs.customer_id
WHERE shipped_date > required_date;

--38. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi
SELECT pr.product_name, ct.category_name, od.quantity FROM order_details AS od
INNER JOIN products AS pr ON od.product_id = pr.product_id
INNER JOIN categories AS ct ON pr.category_id = ct.category_id
WHERE order_id = 10248;

--39. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı
SELECT pr.product_name, s.company_name, s.contact_name FROM orders AS o
INNER JOIN order_details AS od ON o.order_id = od.order_id
INNER JOIN products AS pr ON od.product_id = pr.product_id
INNER JOIN suppliers AS s ON o.ship_via = s.supplier_id
WHERE o.order_id = 10248;

--40. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
SELECT pr.product_name, SUM(quantity) AS "adet" FROM orders AS o
INNER JOIN order_details AS od ON o.order_id = od.order_id
INNER JOIN products AS pr ON od.product_id = pr.product_id
WHERE employee_id = 3
AND EXTRACT('YEAR' FROM order_date) = 1997
GROUP BY pr.product_name;

--41. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "ad_soyad", SUM(Quantity) AS "tek_seferde_toplam_satis" FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.order_id
INNER JOIN employees AS e ON o.employee_id = e.employee_id
WHERE EXTRACT('YEAR' FROM order_date) = 1997
GROUP BY e.employee_id
ORDER BY "tek_seferde_toplam_satis" DESC LIMIT 1;

--42. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "ad_soyad", COUNT(od.order_id) AS "toplam_satis_sayisi" FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.order_id
INNER JOIN employees AS e ON o.employee_id = e.employee_id
WHERE EXTRACT('YEAR' FROM order_date) = 1997
GROUP BY e.employee_id
ORDER BY "toplam_satis_sayisi" DESC
LIMIT 1;

--43. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
SELECT pr.product_name, pr.unit_price, ct.category_name FROM products AS pr
INNER JOIN categories AS ct ON pr.category_id = ct.category_id
ORDER BY unit_price DESC
LIMIT 1;
--43. Alternatif Sub Query
SELECT pr.product_name, pr.unit_price, ct.category_name 
FROM products AS pr 
INNER JOIN categories AS ct ON pr.category_id = ct.category_id 
WHERE pr.unit_price = (SELECT MAX(unit_price) FROM products);

--44. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
SELECT e.first_name, e.last_name, o.order_date, o.order_id FROM orders AS o
INNER JOIN employees AS e ON o.employee_id = e.employee_id
ORDER BY o.order_date;

--45. SON 5 siparişimin ortalama fiyatı ve orderid nedir?
SELECT od.order_id, SUM(od.quantity* od.unit_price) / SUM(od.quantity) AS "avg" FROM orders AS o
INNER JOIN order_details AS od ON o.order_id = od.order_id
GROUP BY od.order_id, o.order_date
ORDER BY o.order_date DESC
LIMIT 5;

--46. Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
SELECT pr.product_name, ct.category_name, SUM(quantity) FROM orders AS o
INNER JOIN order_details AS od ON o.order_id = od.order_id
INNER JOIN products AS pr ON od.product_id = pr.product_id
INNER JOIN categories AS ct ON pr.category_id = ct.category_id
WHERE EXTRACT('MONTH' FROM order_date) = '01'
GROUP BY pr.product_name, ct.category_name;

--47. Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
--Her siparişteki tüm quantity miktarlarını toplayıp onun ortalamasını alarak ortalama satış miktarını buldum.
SELECT * FROM order_details
WHERE quantity > (SELECT AVG(satis_miktar)
				 FROM(SELECT order_id, SUM(quantity) AS satis_miktar
				 FROM order_details
				 GROUP BY order_id));

--48. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
SELECT SUM(quantity) as "adet", pr.product_name, ct.category_name, s.company_name, s.contact_name FROM order_details AS od
INNER JOIN products AS pr ON od.product_id = pr.product_id
INNER JOIN categories AS ct ON pr.category_id = ct.category_id
INNER JOIN suppliers AS s ON pr.supplier_id = s.supplier_id
GROUP BY pr.product_name, ct.category_name, s.company_name, s.contact_name
ORDER BY "adet" DESC
LIMIT 1;

--49. Kaç ülkeden müşterim var
SELECT COUNT(DISTINCT country) AS "country_count" FROM customers;

--50. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
--Son ocak ayından'ı veriler içindeki son ocak ayı olarak düşünüp o yılın ocak ayından dahil ve sonraki yılların hepsini aldım.
SELECT SUM(od.quantity * od.unit_price) AS "total" FROM orders AS o
INNER JOIN order_details od ON o.order_id = od.order_id
WHERE employee_id = 3
AND EXTRACT('YEAR' FROM order_date) >= (SELECT EXTRACT('YEAR' FROM MAX(order_date)) FROM orders)
AND EXTRACT('MONTH' FROM order_date) >= '01';

--51. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi
SELECT pr.product_name, ct.category_name, od.quantity FROM order_details AS od
INNER JOIN products AS pr ON od.product_id = pr.product_id
INNER JOIN categories AS ct ON pr.category_id = ct.category_id
WHERE order_id = 10248;

--52. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı
SELECT pr.product_name, s.company_name, s.contact_name FROM orders AS o
INNER JOIN order_details AS od ON o.order_id = od.order_id
INNER JOIN products AS pr ON od.product_id = pr.product_id
INNER JOIN suppliers AS s ON o.ship_via = s.supplier_id
WHERE o.order_id = 10248;

--53. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
SELECT pr.product_name, SUM(quantity) AS "adet" FROM orders AS o
INNER JOIN order_details AS od ON o.order_id = od.order_id
INNER JOIN products AS pr ON od.product_id = pr.product_id
WHERE employee_id = 3
AND EXTRACT('YEAR' FROM order_date) = 1997
GROUP BY pr.product_name;

--54. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "ad_soyad", SUM(Quantity) AS "tek_seferde_toplam_satis" FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.order_id
INNER JOIN employees AS e ON o.employee_id = e.employee_id
WHERE EXTRACT('YEAR' FROM order_date) = 1997
GROUP BY e.employee_id
ORDER BY "tek_seferde_toplam_satis" DESC LIMIT 1;

--55. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "ad_soyad", COUNT(od.order_id) AS "toplam_satis_sayisi" FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.order_id
INNER JOIN employees AS e ON o.employee_id = e.employee_id
WHERE EXTRACT('YEAR' FROM order_date) = 1997
GROUP BY e.employee_id
ORDER BY "toplam_satis_sayisi" DESC
LIMIT 1;

--56. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
SELECT pr.product_name, pr.unit_price, ct.category_name FROM products AS pr
INNER JOIN categories AS ct ON pr.category_id = ct.category_id
ORDER BY unit_price DESC
LIMIT 1;
--Alternatif Sub Query
SELECT pr.product_name, pr.unit_price, ct.category_name 
FROM products AS pr 
INNER JOIN categories AS ct ON pr.category_id = ct.category_id 
WHERE pr.unit_price = (SELECT MAX(unit_price) FROM products);

--57. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
SELECT e.first_name, e.last_name, o.order_date, o.order_id FROM orders AS o
INNER JOIN employees AS e ON o.employee_id = e.employee_id
ORDER BY o.order_date;

--58. SON 5 siparişimin ortalama fiyatı ve orderid nedir?
SELECT od.order_id, SUM(od.quantity* od.unit_price) / SUM(od.quantity) AS "avg" FROM orders AS o
INNER JOIN order_details AS od ON o.order_id = od.order_id
GROUP BY od.order_id, o.order_date
ORDER BY o.order_date DESC
LIMIT 5;

--59. Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
SELECT pr.product_name, ct.category_name, SUM(quantity) FROM orders AS o
INNER JOIN order_details AS od ON o.order_id = od.order_id
INNER JOIN products AS pr ON od.product_id = pr.product_id
INNER JOIN categories AS ct ON pr.category_id = ct.category_id
WHERE EXTRACT('MONTH' FROM order_date) = '01'
GROUP BY pr.product_name, ct.category_name;

--60. Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
--Her siparişteki tüm quantity miktarlarını toplayıp onun ortalamasını alarak ortalama satış miktarını buldum.
SELECT * FROM order_details
WHERE quantity > (SELECT AVG(satis_miktar)
				 FROM(SELECT order_id, SUM(quantity) AS satis_miktar
				 FROM order_details
				 GROUP BY order_id));

--61. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
SELECT SUM(quantity) as "adet", pr.product_name, ct.category_name, s.company_name, s.contact_name FROM order_details AS od
INNER JOIN products AS pr ON od.product_id = pr.product_id
INNER JOIN categories AS ct ON pr.category_id = ct.category_id
INNER JOIN suppliers AS s ON pr.supplier_id = s.supplier_id
GROUP BY pr.product_name, ct.category_name, s.company_name, s.contact_name
ORDER BY "adet" DESC
LIMIT 1;

--62. Kaç ülkeden müşterim var
SELECT COUNT(DISTINCT country) AS "country_count" FROM customers;

--63. Hangi ülkeden kaç müşterimiz var
SELECT country, COUNT(*) FROM customers
GROUP BY country;

--64. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
--Son ocak ayından'ı veriler içindeki son ocak ayı olarak düşünüp o yılın ocak ayından dahil ve sonraki yılların hepsini aldım.
SELECT SUM(od.quantity * od.unit_price) AS "total" FROM orders AS o
INNER JOIN order_details od ON o.order_id = od.order_id
WHERE employee_id = 3
AND EXTRACT('YEAR' FROM order_date) >= (SELECT EXTRACT('YEAR' FROM MAX(order_date)) FROM orders)
AND EXTRACT('MONTH' FROM order_date) >= '01';

--65. 10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?
--Veriler içindeki son 3 ay kapsayacak şekilde hesapladım.
SELECT SUM(od.unit_price * od.quantity) AS "Ciro" FROM orders AS o
INNER JOIN order_details AS od ON o.order_id = od.order_id
WHERE product_id = 10
AND o.order_date >= (SELECT DATE_TRUNC('MONTH', MAX(order_date) - INTERVAL '2 MONTHS') FROM orders)
AND o.order_date <= (SELECT DATE_TRUNC('MONTH', MAX(order_date)) FROM orders);
									   
--66. Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?
SELECT o.employee_id, e.first_name || ' ' || e.last_name AS "employee_full_name", COUNT(*) AS "order_count" FROM orders AS o
INNER JOIN employees AS e ON o.employee_id = e.employee_id
GROUP BY o.employee_id, "employee_full_name"
ORDER BY "employee_full_name";

--67. 91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
SELECT * FROM customers AS ct
LEFT JOIN orders AS o ON ct.customer_id = o.customer_id
WHERE order_id IS NULL;

--68. Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
SELECT company_name, contact_name, address, city, region, postal_code, country FROM customers
WHERE country IN('Brazil');

--69. Brezilya’da olmayan müşteriler
SELECT * FROM customers
WHERE country NOT IN('Brazil');

--70. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
SELECT * FROM customers
WHERE country IN('Spain','France','Germany');

--71. Faks numarasını bilmediğim müşteriler
SELECT * FROM customers
WHERE fax IS NULL;

--72. Londra’da ya da Paris’de bulunan müşterilerim
SELECT * FROM customers
WHERE city IN('London','Paris');

--73. Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
SELECT * FROM customers
WHERE city = 'México D.F.'
AND contact_title = 'Owner';

--74. C ile başlayan ürünlerimin isimleri ve fiyatları
SELECT product_name, unit_price FROM products
WHERE product_name LIKE 'C%';

--75. Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
SELECT first_name, last_name, birth_date FROM employees
WHERE first_name LIKE 'A%';

--76. İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
SELECT * FROM customers
WHERE company_name LIKE '%Restaurant%';

--77. 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
SELECT product_name, unit_price || '$' AS "Price" FROM products
WHERE unit_price BETWEEN 50 AND 100;

--78. 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri
SELECT order_id, order_date FROM orders
WHERE order_date BETWEEN '1996-07-01' AND '1996-12-31';

--79. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
SELECT * FROM customers
WHERE country = 'Spain' OR country = 'France' OR country = 'Germany';

--80. Faks numarasını bilmediğim müşteriler
SELECT * FROM customers
WHERE FAX IS NULL;

--81. Müşterilerimi ülkeye göre sıralıyorum:
SELECT * FROM customers
ORDER BY country;

--82. Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
SELECT product_name, unit_price FROM products
ORDER BY unit_price DESC;

--83. Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz
SELECT product_name, unit_price, units_in_stock FROM products
ORDER BY unit_price DESC, units_in_stock ASC;

--84. 1 Numaralı kategoride kaç ürün vardır..?
SELECT COUNT(*) FROM products WHERE category_id = 1;

--85. Kaç farklı ülkeye ihracat yapıyorum..?
SELECT COUNT(DISTINCT ship_country) FROM orders;

--86. a.Bu ülkeler hangileri..?
SELECT DISTINCT ship_country FROM orders;

--87. En Pahalı 5 ürün
SELECT * FROM products
ORDER BY unit_price DESC
LIMIT 5;

--88. ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
SELECT COUNT(*) FROM orders
WHERE customer_id = 'ALFKI';
--88. Alternatif
SELECT COUNT(*) FROM orders
WHERE LOWER(customer_id) = 'alfki';

--89. Ürünlerimin toplam maliyeti
SELECT SUM(unit_price * units_in_stock) FROM products;

--90. Şirketim, şimdiye kadar ne kadar ciro yapmış..?
SELECT SUM(unit_price * quantity) AS "ciro" FROM order_details;
--90. ciroya indirim dahil edersek.
SELECT SUM(unit_price * quantity * (1 - discount)) AS "ciro" FROM order_details;

--91. Ortalama Ürün Fiyatım
SELECT AVG(unit_price) AS "ortalama_ürün_fiyatı" FROM products;

--92. En Pahalı Ürünün Adı
SELECT product_name FROM products
ORDER BY unit_price DESC
LIMIT 1;

--93. En az kazandıran sipariş
SELECT order_id, SUM(unit_price * quantity) AS "kazanç" FROM order_details AS od
GROUP BY order_id
ORDER BY "kazanç"
LIMIT 1;
--93. İndirim hesaba katılırsa:
SELECT order_id, SUM(unit_price * quantity * (1 - discount)) AS "kazanç" FROM order_details AS od
GROUP BY order_id
ORDER BY "kazanç"
LIMIT 1;

--94. Müşterilerimin içinde en uzun isimli müşteri
--94. müşteri firma ismi
SELECT company_name FROM customers
ORDER BY LENGTH(company_name) DESC
LIMIT 1;
--94. Müşteri contact_name
SELECT contact_name FROM customers
ORDER BY LENGTH(contact_name) DESC
LIMIT 1;

--95. Çalışanlarımın Ad, Soyad ve Yaşları
SELECT first_name, last_name, DATE_PART('YEAR', AGE(birth_date)) AS "age"
FROM employees;

--96. Hangi üründen toplam kaç adet alınmış..?
SELECT pr.product_name, SUM(Quantity) FROM order_details AS od
INNER JOIN products AS pr ON od.product_id = pr.product_id
GROUP BY pr.product_name;

--97. Hangi siparişte toplam ne kadar kazanmışım..?
SELECT order_id, SUM(unit_price * quantity) AS "kazanç", SUM(unit_price * quantity * (1 - discount)) AS "indirimli_kazanç" FROM order_details AS od
GROUP BY order_id;

--98. Hangi kategoride toplam kaç adet ürün bulunuyor..?
SELECT ct.category_name, COUNT(*) FROM products AS pr
INNER JOIN categories AS ct ON pr.category_id = ct.category_id
GROUP BY ct.category_name;

--99. 1000 Adetten fazla satılan ürünler?
SELECT pr.product_name, SUM(Quantity) AS "satis_adeti" FROM order_details AS od
INNER JOIN products AS pr ON od.product_id = pr.product_id
GROUP BY pr.product_name
HAVING SUM(Quantity) > 1000;

--100. Hangi Müşterilerim hiç sipariş vermemiş..?
SELECT cs.customer_id, cs.company_name
FROM customers AS cs
LEFT JOIN orders AS o ON cs.customer_id = o.customer_id
WHERE o.order_id IS NULL;