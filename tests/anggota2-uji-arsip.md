# Pengujian Anggota 2: Pembuatan Arsip

Penanggung jawab: Muhammad Agung (2510512181). Bukti: `evidence/anggota2-uji-arsip.txt`.

| Item | T04 (positif) | T05 (negatif) |
|---|---|---|
| Tujuan | Arsip terbentuk dan isinya sesuai | Tujuan tidak dapat ditulis, kegagalan dilaporkan |
| Prasyarat | Folder sumber berisi a.txt dan b.txt; folder tujuan dapat ditulis | Folder tujuan diberi izin 555 |
| Langkah | `bash scripts/backup.sh <sumber> <tujuan>` | Sama, dengan tujuan folder izin 555 |
| Hasil diharapkan | Exit 0, arsip izin 600, isi sama dengan sumber | Exit bukan 0, pesan error, tidak ada arsip |
| Hasil aktual | Exit 0, izin `-rw-------`, isi sama (diff) | Exit 1, "Folder tujuan tidak dapat ditulis", tidak ada arsip |
| Status | Lulus | Lulus |
| Pemulihan | Hapus /tmp/uji | `chmod 755` pada folder tujuan |

Catatan: pada T05 kegagalan ditangkap oleh pemeriksaan folder tujuan
sebelum `tar` dijalankan, sehingga cabang kegagalan `tar` tidak diuji.