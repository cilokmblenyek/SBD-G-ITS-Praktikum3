-- Pendahuluan 3 Answer
-- SBDG
-- SBDG01
-- Ahmad Fatih Ramadhani 
-- 5025221191


#1 Tampilkan seluruh transaksi yang terjadi dari tanggal 10 Oktober 2023 hingga 20 Oktober 2023! Tampilkan seluruh kolom dari tabel transaksi.
SELECT *
FROM transaksi
WHERE tanggal_transaksi BETWEEN '2023-10-10' AND '2023-10-20';


#2 Hitunglah total harga dari setiap transaksi. Tampilkan id transaksi dan total harga yang berkesesuaian. Untuk mempermudah Mbak Nuri memahami hasil kueri, 
-- maka ubahlah tampilkan total harga dengan nama ‘TOTAL_HARGA’!

SELECT t.id_transaksi,SUM(m.harga_minuman * tm.jumlah_minuman) AS TOTAL_HARGA 
FROM transaksi t
JOIN transaksi_minuman tm ON t.id_transaksi = tm.tm_transaksi_id
JOIN menu_minuman m ON tm.tm_menu_minuman_id = m.id_minuman
GROUP BY
    t.id_transaksi;
    

#3 Hitung total biaya yang pernah dikeluarkan oleh setiap cutsomer pada dari tanggal 3 Oktober 2023 hingga 22 Oktober 2023, 
-- tampilkan semua kolom dari tabel customer dan total biaya dengan tampilan nama kolom “Total_Belanja”. Urutkan berdasarkan nama customer dari A ke Z.

SELECT
    c.*,COALESCE(SUM(mm.harga_minuman * tm.jumlah_minuman), 0) AS Total_Belanja
FROM
    customer c
LEFT JOIN membership mship 
ON c.id_customer = mship.m_id_customer

LEFT JOIN membership m 
ON mship.id_membership = m.id_membership

LEFT JOIN transaksi t 
ON c.id_customer = t.customer_id_customer

LEFT JOIN transaksi_minuman tm 
ON t.id_transaksi = tm.tm_transaksi_id

LEFT JOIN menu_minuman mm 
ON tm.tm_menu_minuman_id = mm.id_minuman

WHERE t.tanggal_transaksi BETWEEN '2023-10-03' AND '2023-10-22'
GROUP BY
    c.id_customer
ORDER BY
    c.nama_customer ASC;
    

#4 Mbak Nuri ingin mengetahui data pegawai yang pernah melayani customer dengan nama Davi Liam, Sisil Triana, atau Hendra Asto

SELECT DISTINCT p.*
FROM pegawai p

JOIN transaksi t 
ON p.nik = t.pegawai_nik

JOIN customer c 
ON t.customer_id_customer = c.id_customer
WHERE
    c.id_customer IN ('CTR003', 'CTR002', 'CTR005');
    

#5 Hitunglah jumlah cup yang terjual pada Kopi Nuri setiap bulannya (perhatikan bulan dan tahunnya)! 
-- Tampilkan kolom bulan, tahun, dan jumlah cup dengan nama ‘BULAN’, ‘TAHUN’, ‘JUMLAH_CUP’. Urutkan berdasarkan tahun dari yang terbesar dan bulan yang terkecil.
-- Hint: gunakan fungsi berikut:
-- MYSQL: MONTH(nama_kolom), YEAR(nama_kolom)

SELECT MONTH(t.tanggal_transaksi) AS BULAN, CAST(YEAR(t.tanggal_transaksi) AS CHAR) AS TAHUN,
    SUM(tm.jumlah_minuman) AS JUMLAH_CUP
FROM transaksi t
JOIN transaksi_minuman tm 
ON t.id_transaksi = tm.tm_transaksi_id

JOIN menu_minuman mm 
ON tm.tm_menu_minuman_id = mm.id_minuman
GROUP BY
    BULAN, TAHUN
ORDER BY
    TAHUN DESC, BULAN ASC;


#6 Berapa nilai rata-rata total belanja transaksi seluruh customer?

SELECT AVG(Total_Belanja) AS rata2_total_belanja 
FROM (SELECT SUM(mm.harga_minuman * tm.jumlah_minuman) AS Total_Belanja 
	 FROM transaksi_minuman tm
	 JOIN menu_minuman mm ON mm.id_minuman = tm.tm_menu_minuman_id
	GROUP BY tm.tm_transaksi_id
) AS TabelRataRataTotalBelanja;


#7 Dapatkan data customer dengan rata-rata total belanja lebih dari rata-rata total belanja seluruh customer. Tampilkan kolom id customer, nama customer, dan total belanja!

SELECT c.id_customer, c.nama_customer, SUM(Belanja_Customer) as Total_Belanja 
FROM (SELECT t.customer_id_customer, SUM(mm.harga_minuman * tm.jumlah_minuman) AS Belanja_Customer 
	 FROM transaksi t
    JOIN transaksi_minuman tm ON tm.tm_transaksi_id = t.id_transaksi
    JOIN menu_minuman mm ON mm.id_minuman = tm.tm_menu_minuman_id
    GROUP BY t.id_transaksi) AS RataRataTotalBelanjaPerTransaksi
    
JOIN customer c ON c.id_customer = RataRataTotalBelanjaPerTransaksi.customer_id_customer
GROUP BY c.id_customer
HAVING AVG(Belanja_Customer) > (
    SELECT AVG(avg_total_belanja) 
	 FROM (SELECT SUM(mm.harga_minuman * tm.jumlah_minuman) AS avg_total_belanja 
		 FROM transaksi_minuman tm
		 JOIN menu_minuman mm ON (mm.id_minuman = tm.tm_menu_minuman_id)
		 GROUP BY (tm.tm_transaksi_id)) AS RataRataKeseluruhan);

    
#8 Tampilkan data customer yang tidak terdaftar sebagai membership!

SELECT *
FROM customer
WHERE id_customer NOT IN (SELECT m_id_customer FROM membership WHERE m_id_customer IS NOT NULL);


#9 Berapakah jumlah customer yang pernah memesan minuman Latte?

SELECT COUNT(DISTINCT c.id_customer) AS jumlah_customer_latte
FROM customer c
JOIN transaksi t ON c.id_customer = t.customer_id_customer
JOIN transaksi_minuman tm ON t.id_transaksi = tm.tm_transaksi_id
JOIN menu_minuman mm ON tm.tm_menu_minuman_id = mm.id_minuman
WHERE mm.id_minuman = 'MNM003';


#10 Mbak Nuri penasaran, dia ingin mengetahui nama customer, menu minuman, dan total jumlah cup menu minuman dari customer dengan nama yang berawalan dengan huruf S!
SELECT c.nama_customer, mm.nama_minuman, SUM(tm.jumlah_minuman) AS total_jumlah_cup
FROM customer c
JOIN transaksi t ON c.id_customer = t.customer_id_customer
JOIN transaksi_minuman tm ON t.id_transaksi = tm.tm_transaksi_id
JOIN menu_minuman mm ON tm.tm_menu_minuman_id = mm.id_minuman
WHERE 
	 c.nama_customer LIKE 'S%'
GROUP BY
	 c.nama_customer, mm.nama_minuman;
          
