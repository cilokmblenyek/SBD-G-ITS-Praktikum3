#Bismillah Praktikum3 Sukses

#1 Hitunglah nilai stok terkini dari setiap produk dengan mempertimbangkan carts yang 
-- telah di-checkout. Dengan asumsi bahwa nilai dalam kolom stok produk, merupakan 
-- stok awal sebelum adanya data transaksi.
SELECT idBarang, namaBarang, Stock - terbeli AS nilai_stock_terkini
FROM
(SELECT p.id AS idBarang, p.name AS namaBarang, COUNT(pc.quantity) AS terbeli, p.stock AS Stock, pc.product_id
FROM products p
	 JOIN product_carts pc ON p.id = pc.product_id
	 JOIN carts c ON pc.cart_id = c.id
	 WHERE c.`status` = 'checkout'
	 GROUP BY
	 	pc.product_id) hasil
GROUP BY
 	idBarang,namaBarang
 	
#2 Hitunglah rata-rata jeda waktu antara waktu pemberian feedback dengan waktu 
-- pembuatan order dari setiap order.
SELECT AVG(TIMESTAMPDIFF(DAY, o.created_at, f.created_at)) AS rata_rata_jeda_waktu_dalam_hari, AVG(TIMESTAMPDIFF(HOUR, o.created_at, f.created_at)) AS rata_rata_jeda_waktu_dalam_jam
FROM feedbacks f
JOIN feedback_orders fo ON f.id = fo.feedback_id
JOIN orders o ON fo.order_id = o.id

#3 Buat daftar produk yang memiliki stok kurang dari 5 dan telah terjual setidaknya sekali. 
-- Tampilkan nama produk dan jumlah stok
SELECT idBarang, namaBarang, Stock, ada
FROM
(SELECT DISTINCT p.id AS idBarang, p.name AS namaBarang, p.stock AS Stock, pc.product_id AS ada
	 FROM products p
	 LEFT JOIN product_carts pc ON p.id = pc.product_id) hasil
GROUP BY
 	idBarang
HAVING
	 Stock < 5 
AND  
	 idBarang IN(ada)
	 
#4 Dapatkan jumlah carts, jumlah produk, dan pendapatan (gunakan kolom price dari 
-- product dan quantity) yang didapatkan dari produk di setiap tanggalnya (contoh: '2023-
-- 08-09', '2023-08-25', dst). Urutkan berdasarkan tanggal terbaru.
-- Untuk ekstrak tanggal bisa gunakan DATE() function
SELECT DISTINCT DATE(c.created_at) AS tanggal, COUNT(c.id) AS jumlah_carts, COUNT(DISTINCT pc.product_id) AS jumlah_produk, SUM(pc.quantity * p.price) AS pendapatan
FROM products p
	 JOIN product_carts pc ON p.id = pc.product_id
	 JOIN carts c ON pc.cart_id = c.id
GROUP BY 
	 tanggal

#5 ada suatu hari, Bima Bakery ingin melakukan promosi khusus untuk produkproduknya yang belum pernah mendapatkan ulasan (feedback) dari pelanggan. Dalam 
/* konteks ini, Bima Bakery ingin mengetahui total penjualan (jumlah produk yang 
terjual) dari setiap produk yang belum pernah mendapatkan ulasan. Bantulah Bima 
Bakery untuk membuat query yang dapat memberikan informasi tersebut! Tampilkan 
pula tanggal produk itu terkahir di masukkan dalam keranjang (berdasarkan kolom 
created_at), urutkan data berdasarkan tanggal paling terbaru */

-- yang dibutuhkan:
-- 1. ID Nama Produk
-- 2. Informasi adanya Feedback
-- 3. Informasi tanggal keranjang
SELECT *
FROM products p
LEFT JOIN
(SELECT DISTINCT p.id AS sudah_direview
	FROM products p
	JOIN product_carts pc ON p.id = pc.product_id
	JOIN orders o ON pc.cart_id = o.cart_id
	JOIN feedback_orders fo ON o.id = fo.order_id
	JOIN feedbacks f ON fo.feedback_id = f.id
	GROUP BY p.id) produk_direview ON p.id = sudah_direview
GROUP BY
	 p.id
-- WHERE sudah_direview = NULL;	 

#6 Tampilkan rata-rata total harga order yang telah tervalidasi
-- validated
SELECT SUM(total_price)/COUNT(id) Rata_rata_total_harga_order
FROM orders o
WHERE o.status = 'validated'

#7 Tampilkan customer, product, beserta jumlah product yang masuk dalam keranjang tiap 
-- customer dalam status idle
SELECT cs.name, p.name, pc.quantity
FROM customers cs
	 JOIN carts c ON cs.id = c.customer_id
	 JOIN product_carts pc ON c.id = pc.cart_id
	 JOIN products p ON pc.product_id = p.id
	 WHERE c.`status` = 'idle'
	 GROUP BY
		 cs.name
		 
#8 

	 