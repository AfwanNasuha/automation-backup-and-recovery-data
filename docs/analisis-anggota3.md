# Analisis Konsep Sistem Operasi — Modul Verifikasi Integritas 
**Penanggung Jawab:** Muhammad Afaf Kafabillah (2510512175)  
**Komponen:** `scripts/verify.sh`

## 1. Sistem Berkas dan Operasi I/O
Proses pembuatan dan verifikasi *checksum* pada `scripts/verify.sh` bergantung pada utilitas GNU Coreutils `sha256sum`. Ketika perintah dijalankan, kernel Linux membuka deskriptor berkas (*file descriptor*) arsip `.tar.gz` melalui *system call* `openat()` dan membaca potongan blok data dari perangkat penyimpanan (*disk* / *page cache*) ke buffer memori ruang pengguna (*user space*) menggunakan *system call* `read()` secara berulang hingga mencapai *End-of-File* (EOF). 

Pendekatan pembacaan berurutan (*sequential I/O*) ini memastikan seluruh isi *payload* biner arsip ikut dihitung ke dalam fungsi hash SHA-256, bukan sekadar memeriksa metadata nama atau ukuran berkas. Jika terjadi kerusakan media penyimpanan (*bit rot*) atau penyisipan data ilegal pada arsip, perbedaan satu bit saja akan memicu *avalanche effect* yang menghasilkan string hash 256-bit yang sama sekali berbeda.

## 2. Proteksi dan Manajemen Hak Akses
Mekanisme verifikasi integritas akan kehilangan efektivitasnya apabila pengguna yang tidak berwenang dapat mengubah berkas arsip sekaligus menimpa nilai pada berkas `.sha256`. Oleh karena itu, `scripts/verify.sh` menerapkan prinsip *least privilege* melalui:
- **`umask 077` dan `chmod 600`:** Setiap berkas `.sha256` yang baru dibuat otomatis diatur agar hanya dapat dibaca dan ditulis oleh pemilik (*owner*) yang menjalankan proses backup, sementara grup lain dan pengguna umum (*others*) tidak memiliki izin baca maupun tulis.
- **Validasi Izin Baca (`[ ! -r "$ARCHIVE" ]`):** Sebelum proses hashing dieksekusi, skrip memeriksa hak baca pada berkas target sehingga kegagalan izin akses ditangani secara terkendali dengan pesan eror eksplisit dan *exit status* `1`.

## 3. Manajemen Proses dan Komunikasi Antar-Modul (Exit Status)
Saat `scripts/verify.sh` dieksekusi, shell membuat *child process* untuk menjalankan `sha256sum`, `awk`, dan `tr`. Setelah perbandingan string selesai, `verify.sh` mengembalikan kode status keluar (*exit status*) ke proses pemanggilnya sesuai standar POSIX:
- **`exit 0`:** Integritas arsip terverifikasi valid.
- **`exit 1`:** Berkas tidak ditemukan, izin ditolak, atau *checksum* tidak cocok (arsip korup/diubah).
- **`exit 2`:** Kesalahan sintaks atau jumlah argumen perintah.

Mekanisme *exit status* ini menjadi penghubung antar-proses dengan modul pemulihan (`scripts/restore.sh` milik Anggota 4), di mana proses pemulihan hanya boleh dilanjutkan apabila subproses `verify.sh` berakhir dengan status `0`.

## 4. Batasan Modul
- Modul `verify.sh` memverifikasi integritas berkas secara statis pada saat perintah dipanggil (*on-demand*), bukan pemantauan *real-time* di latar belakang (*daemon*).
- Keamanan berkas `.sha256` mengandalkan isolasi kepemilikan akun Linux; pengguna dengan hak akses penuh administrator (`root`) tetap dapat memodifikasi berkas `.sha256` di dalam sistem host yang sama.
