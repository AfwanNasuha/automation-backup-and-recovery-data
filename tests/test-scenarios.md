# Skenario Pengujian

Setiap pengujian harus mencatat prasyarat, langkah, hasil yang diharapkan, hasil aktual, exit status, bukti, status lulus/gagal, dan prosedur pemulihan jika diperlukan.

| ID | Penanggung jawab | Pengujian | Hasil yang diharapkan |
|---|---|---|---|
| T01 | Afwan | Sumber valid dan dapat dibaca | Diterima oleh modul validasi |
| T02 | Afwan | Sumber tidak tersedia | Ditolak dengan pesan dan exit status yang sesuai |
| T03 | Afwan | Parameter wajib tidak diberikan | Ditolak sebelum proses backup |
| T04 | Agung | Pembuatan backup dengan sumber valid | Arsip terbentuk dan isinya sesuai |
| T05 | Agung | Direktori tujuan tidak dapat ditulis | Kegagalan dilaporkan dan tidak dinyatakan berhasil |
| T06 | Afaf | Verifikasi arsip asli | Checksum cocok dan arsip lolos verifikasi |
| T07 | Afaf | Arsip diubah setelah checksum dibuat | Perubahan terdeteksi karena checksum tidak cocok |
| T08 | Panggi | Pemulihan arsip yang valid | Data dipulihkan ke direktori pengujian dan isinya sesuai |
| T09 | Panggi | Pemulihan arsip rusak atau tidak lolos verifikasi | Arsip ditolak sebelum restore dinyatakan berhasil |
| T10 | Izzul | Dua proses backup dijalankan bersamaan | Lock mencegah proses berjalan bersamaan secara tidak terkendali |
| T11 | Izzul | Pencatatan hasil backup | Log mencatat aktivitas dan hasil operasi |
| T12 | Izzul | Pembuatan laporan backup | Laporan memuat nama arsip, waktu, dan hasil verifikasi |
| T13 | Izzul | Container membaca laporan melalui mount read-only | Laporan tampil dan perintah berakhir dengan exit status 0 |
| T14 | Izzul | Container mencoba menulis ke laporan melalui mount read-only | Penulisan ditolak, exit status bukan nol, dan checksum laporan host tetap sama |
| T15 | Rafif | Monitoring ketika proses backup berjalan | PID proses dan penggunaan CPU serta memori dapat diamati dan dicatat |
| T16 | Rafif | Monitoring menggunakan PID yang tidak valid | Kondisi ditangani dengan pesan yang jelas tanpa menghasilkan data palsu |
| T17 | Agung, dibantu Rafif | Akun berwenang mengakses arsip backup | Akses diberikan sesuai izin yang ditetapkan |
| T18 | Agung, dibantu Rafif | Akun tidak berwenang mencoba mengakses arsip backup | Akses ditolak |

## Data uji

Data uji harus berupa berkas dummy pada direktori khusus proyek. Catat jumlah berkas, ukuran data, dan susunan direktori yang digunakan. Gunakan data uji yang sama ketika membandingkan hasil backup dan restore.

## Pengujian kelompok yang wajib

Pengujian dua proses backup bersamaan tetap wajib dibuktikan dalam laporan kelompok, meskipun tidak seluruhnya ditampilkan dalam demonstrasi individu.
