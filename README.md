# Sistem Otomasi Backup dan Pemulihan Data Linux

Proyek Akhir Mata Kuliah Sistem Operasi  
S1 Sistem Informasi – UPN Veteran Jakarta

## Deskripsi

Proyek ini mengembangkan sistem otomasi pencadangan dan pemulihan data pada Linux menggunakan Shell Script.

Sistem dirancang untuk memvalidasi sumber dan tujuan, membuat arsip backup dengan identitas waktu, memeriksa integritas arsip menggunakan checksum, serta memulihkan data ke direktori pengujian. Aktivitas sistem juga dicatat dalam log dan dirangkum dalam laporan.

## Fitur utama

1. Validasi sumber dan parameter.
2. Pembuatan arsip backup dengan identitas waktu.
3. Verifikasi integritas menggunakan checksum SHA-256.
4. Pemulihan data ke direktori pengujian.
5. Pencegahan proses backup bersamaan menggunakan lock.
6. Pencatatan aktivitas dan pembuatan laporan.
7. Pembatasan akses terhadap arsip backup.
8. Pengamatan proses serta penggunaan CPU dan memori.
9. Aktivitas Docker untuk membaca laporan melalui bind mount read-only.

## Struktur repository

- `config/`: contoh dan dokumentasi konfigurasi.
- `scripts/`: Shell Script untuk setiap modul.
- `tests/`: skenario pengujian dan data uji.
- `docs/`: rancangan, pembagian kontribusi, dan analisis teknis.
- `evidence/`: bukti implementasi dan pengujian.

## Lingkungan pengembangan

- Linux pada mesin virtual.
- Bash.
- GNU Tar dan gzip.
- SHA-256 melalui `sha256sum`.
- `flock` untuk penguncian proses.
- Docker untuk aktivitas tambahan membaca laporan.

Distribusi Linux, versi, dan spesifikasi mesin virtual yang benar-benar digunakan akan dicatat pada dokumentasi lingkungan.

## Pembagian anggota

Pembagian tugas enam anggota tercantum pada [`docs/contribution-map.md`](docs/contribution-map.md). Penyesuaian jumlah anggota dari ketentuan draft dosen perlu dikonfirmasi kepada dosen pengampu.

## Status pengerjaan

Tahap persiapan struktur repository dan rancangan awal. Fitur belum diimplementasikan.
