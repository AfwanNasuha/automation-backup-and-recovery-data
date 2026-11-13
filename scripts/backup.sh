#!/bin/bash

# Script pembuatan arsip backup
# Anggota 2 - Proyek Sistem Operasi 5A

set -Eeuo pipefail

# Berkas baru hanya dapat diakses pemilik (arsip langsung berizin 600)
umask 077

# Memeriksa jumlah parameter
if [ "$#" -ne 2 ]; then
    echo "Penggunaan: $0 <folder_sumber> <folder_tujuan>"
    exit 2
fi

SOURCE="${1%/}"
DEST="${2%/}"

# Memeriksa folder sumber
if [ ! -d "$SOURCE" ]; then
    echo "ERROR: Folder sumber tidak ditemukan: $SOURCE"
    exit 1
fi

# Memeriksa folder tujuan
if [ ! -d "$DEST" ]; then
    echo "ERROR: Folder tujuan tidak ditemukan: $DEST"
    exit 1
fi

# Menguji apakah folder tujuan bisa ditulis
TEST_FILE=$(mktemp "$DEST/.write-test.XXXXXX") || {
    echo "ERROR: Folder tujuan tidak dapat ditulis: $DEST"
    exit 1
}
rm -f -- "$TEST_FILE"

# Membuat nama arsip berdasarkan waktu
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE="$DEST/backup_${TIMESTAMP}_$$.tar.gz"

echo "Memulai proses backup..."
echo "Sumber  : $SOURCE"
echo "Tujuan  : $DEST"

# Membuat arsip
if tar -czf "$ARCHIVE" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"; then

    # Membatasi akses arsip hanya untuk pemilik file
    if ! chmod 600 -- "$ARCHIVE"; then
        echo "ERROR: Gagal mengatur izin akses arsip."
        rm -f -- "$ARCHIVE"
        exit 1
    fi
    
    # Memeriksa keberadaan dan validitas arsip
    if [ -s "$ARCHIVE" ] && tar -tzf "$ARCHIVE" > /dev/null; then
        echo "================================"
        echo "BACKUP BERHASIL!"
        echo "Arsip: $ARCHIVE"
        echo "================================"
        exit 0
    else
        echo "ERROR: Arsip tidak valid."
        rm -f -- "$ARCHIVE"
        exit 1
    fi

else
    echo "ERROR: Proses pembuatan arsip gagal."
    rm -f -- "$ARCHIVE"
    exit 1
fi
