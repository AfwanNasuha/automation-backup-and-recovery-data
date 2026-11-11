# Daftar Script

Direktori ini berisi Shell Script untuk menjalankan setiap bagian sistem.

| Nama file | Penanggung jawab | Fungsi |
|---|---|---|
| `validation.sh` | Afwan | Memvalidasi sumber, tujuan, dan parameter sebelum backup dijalankan. |
| `backup.sh` | Agung | Membuat arsip backup bertanggal dan menerapkan pembatasan akses pada arsip. |
| `verify.sh` | Afaf | Membuat dan memeriksa checksum arsip. |
| `restore.sh` | Panggi | Memeriksa arsip dan memulihkan data ke direktori pengujian. |
| `lock.sh` | Izzul | Mengelola lock agar proses backup bersamaan tidak saling bertabrakan. |
| `report.sh` | Izzul | Mencatat aktivitas dan menghasilkan laporan backup. |
| `monitoring.sh` | Rafif | Mengamati proses serta penggunaan CPU dan memori saat pengujian. |

## Ketentuan pengembangan

1. Setiap anggota mengerjakan modul yang menjadi tanggung jawabnya pada branch Git masing-masing.
2. Perubahan dikirim melalui commit dan pull request ke repository utama.
3. Fungsi bersama boleh ditempatkan pada `common.sh` setelah disepakati anggota yang terkait.
4. Jangan menyalin password, token, atau data sensitif ke dalam script maupun repository.
5. Script harus menangani kegagalan dengan pesan yang jelas dan exit status yang sesuai.
