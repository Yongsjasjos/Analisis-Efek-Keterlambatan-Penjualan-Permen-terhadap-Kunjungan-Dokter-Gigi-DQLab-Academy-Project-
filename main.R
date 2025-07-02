# 1. Install ggplot2 jika belum pernah di-install (jalankan sekali saja di Console)
#install.packages("ggplot2")

# 2. Muat library yang dibutuhkan
library(dplyr)
library(ggplot2)

# 3. Baca data dari URL
penjualan_permen <- read.csv(
  "https://storage.googleapis.com/dqlab-dataset/tingkat_penjualan_kota_x_dqlab.tsv",
  header = TRUE, sep = "\t"
)

kunjungan_dokter <- read.csv(
  "https://storage.googleapis.com/dqlab-dataset/kunjungan_dokter_gigi_kota_x_dqlab.tsv",
  header = TRUE, sep = "\t"
)

# 4. Gabungkan kedua dataset berdasarkan Bulan dan Tahun
data_gabungan <- merge(
  kunjungan_dokter, penjualan_permen,
  by = c("Bulan", "Tahun"),
  sort = FALSE
)

# 5. Tampilkan ringkasan statistik variabel penting
cat("Ringkasan Statistik:\n")
summary_vars <- c("tingkat.kunjungan.ke.dokter.gigi", "penjualan.permen", 
                  "penjualan.sereal", "penjualan.buah.pisang")
for (var in summary_vars) {
  cat(paste0("\nSummary untuk ", var, ":\n"))
  print(summary(data_gabungan[[var]]))
}

# 6. Buat dataframe dengan efek delay (lag)
lag_max <- 6
data_delayed_effect <- data_gabungan %>%
  transmute(
    month = Bulan,
    year = Tahun,
    kunjungan_dokter = tingkat.kunjungan.ke.dokter.gigi,
    penjualan_permen = penjualan.permen,
    !!!setNames(
      lapply(1:lag_max, function(i) lag(penjualan.permen, i)),
      paste0("penjualan_permen_", 1:lag_max)
    )
  )

# 7. Fungsi untuk membuat plot relasi kunjungan dokter vs penjualan permen
plot_relationship <- function(data, lag = 0) {
  x <- data$kunjungan_dokter
  y_col <- if (lag == 0) "penjualan_permen" else paste0("penjualan_permen_", lag)
  y <- data[[y_col]]
  
  title <- if (lag == 0) {
    "Kunjungan Dokter vs Penjualan Permen"
  } else {
    paste("Kunjungan Dokter vs Penjualan Permen (Delay", lag, "Bulan)")
  }
  
  ggplot(data, aes(x = x, y = y)) +
    geom_point(color = "blue", size = 2) +
    labs(
      title = title,
      x = "Kunjungan Dokter",
      y = "Penjualan Permen"
    ) +
    theme_minimal()
}

# 8. Tampilkan semua plot dari delay 0 sampai 6 bulan
for (i in 0:lag_max) {
  print(plot_relationship(data_delayed_effect, lag = i))
}
