# Analisis Konsep Sistem Operasi: Anggota 2 (Pembuatan Arsip)

Penanggung jawab: Muhammad Agung (2510512181)
Modul: `scripts/backup.sh`. Skenario: T04, T05 (T17, T18 bersama anggota 6).
Bukti: `evidence/anggota2-uji-arsip.txt`, `tests/anggota2-uji-arsip.md`.

## 1. Sistem berkas dan I/O

**Pemeriksaan tujuan.** Skrip memastikan folder tujuan ada (`[ -d ]`), lalu
membuat berkas sementara dengan `mktemp` dan menghapusnya. Pemeriksaan
dengan menulis langsung lebih andal daripada hanya membaca bit izin, karena
kemampuan menulis ditentukan sistem berkas dan kernel: izin pemilik, grup,
status mount read-only, dan ruang kosong. Pada T05, `mktemp` menerima
kode kesalahan EACCES (`Permission denied`, errno 13) dari kernel ketika
folder berizin `555`. Kegagalan itu diterjemahkan skrip menjadi pesan
yang jelas dan exit status 1.

**Pembuatan arsip.** `tar -czf` membaca berkas sumber (I/O baca), memampatkan
aliran data dengan gzip, lalu menulis satu berkas `.tar.gz` (I/O tulis).
`-C "$(dirname "$SOURCE")"` membuat jalur di dalam arsip bersifat relatif
(`data/a.txt`), sehingga arsip tidak membawa jalur absolut host dan dapat
dipulihkan ke direktori mana pun.

**Identitas arsip.** Nama berisi stempel waktu dan PID skrip (`$$`):
`backup_20261112_140253_6130.tar.gz`. Stempel waktu mengurutkan arsip,
dan PID mencegah dua proses pada detik yang sama menulis ke berkas
yang sama.

**Validasi.** `[ -s ]` memastikan arsip tidak kosong, dan `tar -tzf` membaca
seluruh arsip untuk memastikan strukturnya utuh. Validasi ini membuktikan
arsip dapat dibaca, bukan bahwa isinya tidak diubah. Itu tugas checksum
(Anggota 3).

## 2. Proteksi

Linux memakai izin tiga kelompok: pemilik, grup, dan lainnya. Arsip backup
dapat memuat data sensitif, sehingga diberi izin `600` (`rw-------`): hanya
pemilik yang dapat membaca dan menulis, grup dan akun lain tidak punya akses.

**Dua lapis.** `umask 077` di awal skrip membuat semua berkas baru langsung
berizin tanpa akses grup/lainnya. `chmod 600` memastikan izin akhir secara
eksplisit, dan kegagalannya ditangani: arsip dihapus dan skrip berhenti
dengan exit status 1.

**Kendala yang dialami.** Pada versi awal, `tar` membuat arsip dengan izin
bawaan (dipengaruhi `umask` akun, umumnya `664`) dan `chmod 600` baru
berjalan sesudahnya. Ada jeda singkat saat arsip masih dapat dibaca
akun lain. Penyelesaiannya adalah `umask 077`, sehingga arsip berizin
`600` sejak dibuat.

**Batas proteksi.** Izin `600` tidak menghalangi `root`, yang melewati
pemeriksaan izin biasa. Izin ini juga tidak mengenkripsi isi arsip:
siapa pun yang memperoleh berkasnya dari sumber lain dapat membacanya.

## 3. Penanganan kesalahan dan exit status

| Kondisi | Exit status |
|---|---|
| Jumlah argumen salah | 2 |
| Sumber/tujuan tidak ditemukan, tujuan tidak dapat ditulis, `tar` atau `chmod` gagal, arsip tidak valid | 1 |
| Backup berhasil dan arsip valid | 0 |

`set -Eeuo pipefail` menghentikan skrip pada kesalahan yang tidak
tertangani. Saat `tar` atau validasi gagal, arsip setengah jadi dihapus
supaya tidak ada berkas yang tampak seperti backup sah.

## 4. Keterbatasan

- Pada T05, kegagalan ditangkap oleh pemeriksaan tujuan sebelum `tar`
  dijalankan, sehingga cabang kegagalan `tar` (misalnya disk penuh di tengah
  proses) belum diuji.
- Nama arsip memakai stempel waktu detik dan PID. Dua proses pada detik yang
  sama tetap aman karena PID berbeda, tetapi pencegahan backup bersamaan
  adalah tugas lock (Anggota 5), bukan modul ini.
- Pemeriksaan tujuan (`mktemp`) dan pembuatan arsip tidak atomik: kondisi
  folder bisa berubah di antara keduanya (celah TOCTOU), walau kecil pada
  penggunaan praktikum.
- Uji akses dengan akun berbeda (T17, T18) belum dilakukan pada draf ini.