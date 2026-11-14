
## Kasus Uji T06 — Verifikasi Arsip Asli (Kondisi Positif)
- **ID Pengujian:** T06
- **Penanggung Jawab:** Muhammad Afaf Kafabillah (2510512175)
- **Tujuan:** Memastikan skrip `scripts/verify.sh` mampu menghitung ulang nilai hash SHA-256 pada arsip asli yang utuh dan menyatakan verifikasi berhasil.
- **Prasyarat:**
  - Akun operator memiliki izin baca dan eksekusi pada `scripts/verify.sh`.
  - Berkas arsip dummy `backup_uji.tar.gz` dan berkas pendamping `backup_uji.tar.gz.sha256` (izin `600`) tersedia di direktori pengujian sementara `/tmp/uji_afaf/arsip/`.
- **Langkah Pengujian:**
  1. Jalankan `./scripts/verify.sh verify /tmp/uji_afaf/arsip/backup_uji.tar.gz`.
  2. Periksa keluaran terminal dan nilai *exit status* menggunakan `echo $?`.
- **Hasil yang Diharapkan:** Checksum aktual cocok dengan checksum acuan, muncul pesan `VERIFIKASI BERHASIL! Checksum cocok.`, dan *exit status* bernilai `0`.
- **Hasil Aktual:** Checksum acuan dan aktual identik (`a019235b4a1e8132e9b60566c17b39a7904297b07c38d1a68c704923f6494a9e`), pesan berhasil tampil, dan *exit status* `0`.
- **Status:** Lulus
- **Lokasi Bukti:** `evidence/anggota3-verifikasi.txt`
- **Prosedur Pemulihan:** Tidak ada perubahan pada data sumber; arsip asli tetap utuh untuk pengujian lanjutan.
- **Pembahasan Konsep SO:** Utilitas `sha256sum` melakukan pembacaan blok data secara berurutan (*sequential read*) dari sistem berkas ke ruang memori pengguna melalui *system call* `read()`. Karena tidak ada perubahan byte pada blok arsip, fungsi hash kriptografis menghasilkan nilai digest yang identik.

---

## Kasus Uji T07 — Deteksi Perubahan Arsip Setelah Checksum Dibuat (Kondisi Negatif)
- **ID Pengujian:** T07
- **Penanggung Jawab:** Muhammad Afaf Kafabillah (2510512175)
- **Tujuan:** Memastikan skrip `scripts/verify.sh` mendeteksi perubahan isi pada arsip setelah berkas `.sha256` dibuat dan menolak arsip tersebut sebelum proses *restore*.
- **Prasyarat:**
  - Salinan arsip `backup_rusak.tar.gz` beserta salinan checksum asli `backup_rusak.tar.gz.sha256` disiapkan agar tidak merusak berkas acuan utama.
- **Langkah Pengujian:**
  1. Sisipkan data tambahan ke akhir berkas salinan arsip menggunakan `printf "modifikasi_ilegal" >> /tmp/uji_afaf/arsip/backup_rusak.tar.gz`.
  2. Jalankan `./scripts/verify.sh verify /tmp/uji_afaf/arsip/backup_rusak.tar.gz`.
  3. Periksa keluaran terminal dan nilai *exit status* menggunakan `echo $?`.
- **Hasil yang Diharapkan:** Checksum aktual berbeda dari checksum acuan, muncul pesan `VERIFIKASI GAGAL! Checksum tidak cocok (arsip berubah/rusak).`, dan *exit status* bernilai bukan nol (`1`).
- **Hasil Aktual:** Checksum aktual berubah menjadi `9b855514af8bb19308ca4253d50be4c0ece6ea8ca007700d693a830bfaf60f03`, sistem menolak arsip dengan pesan gagal, dan *exit status* bernilai `1`.
- **Status:** Lulus
- **Lokasi Bukti:** `evidence/anggota3-verifikasi.txt`
- **Prosedur Pemulihan:** Hapus direktori sementara `/tmp/uji_afaf` (`rm -rf /tmp/uji_afaf`) setelah pengujian selesai agar lingkungan kembali bersih.
- **Pembahasan Konsep SO:** Modifikasi data pada sistem berkas mengubah struktur byte pada *inode* dan blok data berkas arsip. Sifat *avalanche effect* pada SHA-256 menyebabkan perubahan sekecil apa pun mengubah seluruh bit keluaran hash, sehingga *exit status* non-nol (`1`) dapat dimanfaatkan modul pemulihan (`restore.sh`) untuk membatalkan ekstraksi data korup.
