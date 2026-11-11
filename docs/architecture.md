# System Architecture

## Alur Utama

1. Pengguna memberikan parameter backup.
2. Sistem memvalidasi sumber dan tujuan.
3. Lock diperiksa untuk mencegah proses bersamaan.
4. Arsip backup dibuat.
5. Checksum dibuat dan disimpan.
6. Aktivitas dicatat ke log.
7. Laporan backup dihasilkan.

## Recovery

1. Pengguna memilih arsip.
2. Sistem memverifikasi checksum.
3. Arsip rusak ditolak.
4. Arsip valid dipulihkan ke direktori pengujian.
5. Hasil pemulihan diverifikasi.

Detail implementasi akan diperbarui selama development.
