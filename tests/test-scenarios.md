# Test Scenarios

| ID | Pengujian | Expected Result |
|---|---|---|
| T01 | Sumber valid | Diterima |
| T02 | Sumber tidak tersedia | Ditolak |
| T03 | Backup berhasil | Arsip terbentuk |
| T04 | Tujuan tidak dapat ditulis | Gagal dengan benar |
| T05 | Checksum arsip asli | Valid |
| T06 | Arsip diubah | Perubahan terdeteksi |
| T07 | Restore arsip asli | Data sesuai |
| T08 | Restore arsip rusak | Ditolak |
| T09 | Dua proses backup | Konflik dicegah |
| T10 | Docker membaca laporan | Berhasil |
| T11 | Docker menulis laporan | Ditolak |
| T12 | Checksum laporan | Tetap sama |

Semua pengujian harus memiliki:
- Prasyarat
- Langkah pengujian
- Expected result
- Actual result
- Exit status
- Bukti
- Status lulus atau gagal
- Prosedur pemulihan
