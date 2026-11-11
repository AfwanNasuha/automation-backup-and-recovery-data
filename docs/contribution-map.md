# Peta Kontribusi Anggota

| Anggota | Nama | Tanggung jawab |
|---|---|---|
| 1 | Afwan | Validasi sumber dan parameter |
| 2 | Agung | Pembuatan arsip backup dan penerapan izin akses arsip |
| 3 | Afaf | Verifikasi integritas |
| 4 | Panggi | Pemulihan data |
| 5 | Izzul | Lock, pencatatan log, laporan, dan Docker |
| 6 | Rafif | Pengelolaan data uji serta monitoring CPU, memori, dan proses |

## Batas tanggung jawab dan hasil kerja

- **Afwan:** memeriksa parameter, keberadaan sumber, jenis sumber, dan izin baca sebelum proses backup diteruskan.
- **Agung:** membuat arsip backup dengan identitas waktu, memeriksa hasil arsip, dan menerapkan pembatasan akses pada arsip yang dihasilkan. Pengujian akses akun dilakukan bersama anggota yang menyiapkan data uji.
- **Afaf:** membuat checksum dan membuktikan bahwa perubahan pada arsip dapat terdeteksi.
- **Panggi:** memverifikasi arsip sebelum pemulihan, menolak arsip rusak, dan memeriksa kesesuaian hasil pemulihan.
- **Izzul:** mengelola lock, pencatatan aktivitas, laporan, serta demonstrasi Docker read-only.
- **Rafif:** menyiapkan data dummy yang terukur dan mengamati proses, penggunaan CPU, serta memori pada kondisi pengujian yang aman.

## Ketentuan kontribusi individu

Setiap anggota wajib memiliki:
1. Kontribusi teknis yang dapat ditelusuri melalui commit atau pull request.
2. Bagian analisis konsep Sistem Operasi yang sesuai dengan pekerjaannya.
3. Satu paket skenario demonstrasi yang mencakup kondisi positif dan negatif.
4. Bukti hasil implementasi dan pengujian.
5. Penjelasan mengenai kendala, penyelesaian, serta batasan modul yang dikerjakan.

## Catatan penyesuaian kelompok

Panduan draft dosen menempatkan proyek 5A untuk kelompok lima mahasiswa. Pembagian menjadi enam anggota pada dokumen ini merupakan usulan internal kelompok dan perlu mendapat persetujuan dosen. Pembagian tambahan tidak menggantikan fitur minimum maupun pengujian wajib kelompok.
