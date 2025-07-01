# DQLab Academy Project: Analisis Kunjungan Dokter Gigi dan Penjualan Permen

## Deskripsi
Project ini menganalisis hubungan antara tingkat kunjungan dokter gigi dan penjualan permen di Kota X menggunakan data bulanan. Dua dataset digabung berdasarkan bulan dan tahun, lalu dianalisis dengan mempertimbangkan efek delay (lag) penjualan permen hingga 6 bulan. Visualisasi scatter plot dibuat untuk mengamati pola korelasi dan pengaruh penjualan terhadap kunjungan dokter.

## Dataset
- **penjualan_permen**: Data penjualan permen, sereal, dan buah pisang.
- **kunjungan_dokter**: Data tingkat kunjungan ke dokter gigi.

Datasets diambil dari URL:
- https://storage.googleapis.com/dqlab-dataset/tingkat_penjualan_kota_x_dqlab.tsv
- https://storage.googleapis.com/dqlab-dataset/kunjungan_dokter_gigi_kota_x_dqlab.tsv

## Langkah Analisis
1. Import library `dplyr` dan `ggplot2`.
2. Membaca dan menggabungkan dataset berdasarkan Bulan dan Tahun.
3. Menampilkan ringkasan statistik variabel penting.
4. Membuat data dengan efek delay penjualan permen sampai 6 bulan.
5. Membuat scatter plot hubungan kunjungan dokter vs penjualan permen dengan berbagai delay.

## Cara Menjalankan
1. Pastikan R sudah terinstall.
2. Jalankan script di RStudio atau console R.
3. Install `ggplot2` jika belum ada:  
   ```R
   install.packages("ggplot2")
