# Rancangan Arsitektur Sistem

## Komponen utama

1. **Validasi:** memeriksa sumber, tujuan, parameter, dan izin akses sebelum operasi backup.
2. **Lock:** mencegah dua proses backup berjalan bersamaan pada bagian kritis.
3. **Pembuatan arsip:** mengemas data sumber ke dalam arsip dengan identitas waktu.
4. **Pembatasan akses:** mengatur kepemilikan dan izin akses arsip backup agar hanya akun yang berwenang dapat mengaksesnya.
5. **Verifikasi integritas:** membuat dan memeriksa checksum SHA-256.
6. **Pemulihan:** memeriksa arsip sebelum mengekstrak data ke direktori pengujian.
7. **Pencatatan dan laporan:** menyimpan hasil operasi, nama arsip, waktu, dan status verifikasi.
8. **Monitoring:** mengamati PID proses backup serta penggunaan CPU dan memori pada beban uji yang aman.
9. **Docker:** membaca berkas laporan dari host melalui bind mount read-only.

## Alur backup

1. Pengguna menjalankan perintah dengan parameter sumber dan tujuan.
2. Modul validasi memeriksa parameter, sumber, tujuan, dan izin yang diperlukan.
3. Sistem mengambil lock. Jika lock sedang digunakan, proses backup kedua ditolak atau dihentikan dengan pesan yang jelas.
4. Modul backup membuat arsip dengan identitas waktu.
5. Arsip disimpan dengan izin akses yang dibatasi.
6. Modul verifikasi membuat checksum dan memeriksa hasilnya.
7. Aktivitas dan hasil operasi dicatat ke log.
8. Laporan berisi nama arsip, waktu, dan hasil verifikasi dihasilkan.

## Alur pemulihan

1. Pengguna memilih arsip yang akan dipulihkan.
2. Sistem memeriksa keberadaan arsip dan checksum-nya.
3. Arsip yang tidak lolos verifikasi ditolak sebelum proses ekstraksi.
4. Arsip yang valid dipulihkan ke direktori pengujian, bukan menimpa sumber asli.
5. Isi hasil pemulihan dibandingkan dengan data sumber atau data acuan.
6. Hasil pemulihan dicatat dalam log dan laporan.

## Data uji dan pengamatan sumber daya

Data uji menggunakan berkas dummy pada direktori khusus proyek. Jumlah berkas dan ukuran data dicatat agar kondisi pengujian dapat diulang. Pengamatan CPU, memori, dan proses dilakukan ketika backup berjalan, dengan mencatat kondisi awal, metode pengamatan, serta hasil aktual.

## Aktivitas Docker

Container hanya diberi akses ke direktori laporan melalui bind mount read-only. Pengujian positif membuktikan laporan dapat dibaca. Pengujian negatif membuktikan penulisan ditolak dan checksum berkas laporan pada host tetap sama.

## Catatan rancangan

Rancangan ini merupakan gambaran awal. Detail antarmuka perintah, nama berkas konfigurasi, format log, dan mekanisme pemulihan akan ditetapkan ketika modul mulai diimplementasikan.
