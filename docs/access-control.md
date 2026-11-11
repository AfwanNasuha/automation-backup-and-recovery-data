# Pembatasan Akses Arsip Backup

## Tujuan

Membatasi akses terhadap direktori dan arsip backup agar hanya akun yang berwenang dapat membaca atau mengelolanya. Pengujian harus menggunakan akun yang berbeda sesuai hak akses, bukan seluruhnya melalui administrator.

## Ruang lingkup

1. Menentukan akun dan group yang berwenang mengakses arsip backup.
2. Menentukan kepemilikan direktori penyimpanan backup.
3. Mengatur permission direktori dan arsip sesuai kebutuhan.
4. Memastikan akun yang tidak berwenang tidak dapat membaca atau mengubah arsip.
5. Mencatat hasil pengujian akses.

## Pembagian pekerjaan

- **Agung:** menerapkan pembatasan akses pada arsip dan lokasi penyimpanan sebagai bagian dari proses pembuatan backup.
- **Rafif:** membantu menyiapkan data uji dan akun pengujian yang diperlukan.
- **Pengujian kelompok:** memastikan akun berwenang diterima dan akun tidak berwenang ditolak.

## Bukti yang dikumpulkan

- Identitas akun yang digunakan saat pengujian.
- Kepemilikan dan permission direktori serta arsip.
- Perintah dan hasil akses oleh akun berwenang.
- Perintah dan hasil penolakan akses oleh akun tidak berwenang.
- Log atau catatan hasil pengujian.

Nilai permission dan rancangan user/group final ditetapkan pada tahap implementasi setelah struktur direktori dan kebutuhan akses disepakati. Jangan menggunakan data pribadi, password, atau rahasia dalam bukti maupun repository.
