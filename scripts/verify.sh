#!/bin/bash

# Script pembuatan dan verifikasi checksum arsip backup
# Anggota 3 - Proyek Sistem Operasi 5A

set -Eeuo pipefail

# Berkas checksum baru hanya dapat diakses pemilik (izin 600)
umask 077

usage() {
    echo "Penggunaan:"
    echo "  $0 generate <file_arsip>   Membuat file checksum SHA-256"
    echo "  $0 verify <file_arsip>     Memverifikasi integritas arsip terhadap checksum"
    echo "  $0 <file_arsip>            Shortcut untuk mode verify"
}

# Validasi jumlah parameter
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    usage
    exit 2
fi

if [ "$#" -eq 1 ]; then
    MODE="verify"
    ARCHIVE="$1"
else
    MODE="$1"
    ARCHIVE="$2"
fi

if [ -z "$ARCHIVE" ]; then
    echo "ERROR: Path file arsip tidak boleh kosong."
    exit 2
fi

if [ ! -f "$ARCHIVE" ]; then
    echo "ERROR: File arsip tidak ditemukan: $ARCHIVE"
    exit 1
fi

CHECKSUM_FILE="${ARCHIVE}.sha256"

case "$MODE" in
    generate|create)
        echo "Membuat checksum SHA-256 untuk: $ARCHIVE"
        HASH_VALUE=$(sha256sum -- "$ARCHIVE" | awk '{print $1}')
        printf "%s  %s\n" "$HASH_VALUE" "$(basename "$ARCHIVE")" > "$CHECKSUM_FILE"

        if ! chmod 600 -- "$CHECKSUM_FILE"; then
            echo "ERROR: Gagal mengatur izin akses file checksum."
            rm -f -- "$CHECKSUM_FILE"
            exit 1
        fi

        echo "=========================================="
        echo "CHECKSUM BERHASIL DIBUAT!"
        echo "File Checksum : $CHECKSUM_FILE"
        echo "SHA-256       : $HASH_VALUE"
        echo "=========================================="
        exit 0
        ;;

    verify|check)
        if [ ! -f "$CHECKSUM_FILE" ]; then
            echo "ERROR: File checksum tidak ditemukan: $CHECKSUM_FILE"
            exit 1
        fi

        if [ ! -r "$ARCHIVE" ] || [ ! -r "$CHECKSUM_FILE" ]; then
            echo "ERROR: File arsip atau file checksum tidak dapat dibaca (izin ditolak)."
            exit 1
        fi

        EXPECTED_HASH=$(awk 'NR==1 {print $1}' "$CHECKSUM_FILE" | tr -d '[:space:]')
        if [ -z "$EXPECTED_HASH" ]; then
            echo "ERROR: Isi file checksum kosong atau tidak valid: $CHECKSUM_FILE"
            exit 1
        fi

        ACTUAL_HASH=$(sha256sum -- "$ARCHIVE" | awk '{print $1}')

        echo "Memverifikasi integritas arsip: $ARCHIVE"
        echo "Checksum Acuan  : $EXPECTED_HASH"
        echo "Checksum Aktual : $ACTUAL_HASH"

        if [ "$EXPECTED_HASH" = "$ACTUAL_HASH" ]; then
            echo "=========================================="
            echo "VERIFIKASI BERHASIL! Checksum cocok."
            echo "=========================================="
            exit 0
        else
            echo "=========================================="
            echo "VERIFIKASI GAGAL! Checksum tidak cocok (arsip berubah/rusak)."
            echo "=========================================="
            exit 1
        fi
        ;;

    *)
        echo "ERROR: Mode tidak dikenal: $MODE"
        usage
        exit 2
        ;;
esac
