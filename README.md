# Linux Backup and Recovery Automation

Project Akhir Sistem Operasi
S1 Sistem Informasi - UPN Veteran Jakarta

## Deskripsi

Sistem otomasi backup dan pemulihan data Linux
menggunakan Shell Script.

Sistem dirancang untuk membuat arsip backup,
memverifikasi integritas data, dan melakukan
pemulihan ketika data hilang atau berubah.

## Fitur Utama

1. Validasi sumber dan tujuan.
2. Pembuatan arsip backup bertanggal.
3. Verifikasi integritas menggunakan checksum.
4. Pemulihan data ke direktori pengujian.
5. Lock, logging, dan laporan.
6. Pembatasan akses backup.

## Struktur Repository

- config/: konfigurasi proyek
- scripts/: shell script
- tests/: skenario pengujian
- docs/: dokumentasi teknis
- evidence/: bukti implementasi dan pengujian

## Lingkungan

- Linux
- Bash
- GNU Tar
- SHA-256
- Flock
- Docker untuk aktivitas tambahan

## Status

Development belum dimulai.
