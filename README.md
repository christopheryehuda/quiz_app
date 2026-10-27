# QuizMaster

##  A. Identitas Mahasiswa
Nama : Christopher Yehuda Panjaitan
NIM : 241401118
Lab : 2 

## B. Informasi Aplikasi

### Nama Aplikasi
QuizMaster

### Deskripsi Singkat Aplikasi
QuizMaster adalah aplikasi kuis pilihan ganda. Pengguna memasukkan nama, menjawab 10 pertanyaan satu per satu, lalu melihat skor akhir beserta namanya.

### Fitur
- Input nama (tidak boleh kosong, minimal 2 karakter).
- 10 pertanyaan pilihan ganda dari data dummy lokal dalam satu list (tanpa database).
- Posisi pilihan jawaban diacak setiap kuis dimulai atau diulang.
- Umpan balik langsung: jawaban benar ditandai hijau, jawaban salah merah, dan jawaban terkunci setelah dipilih.
- Progress bar dan penomoran soal.
- Halaman skor: nama pengguna, persentase animasi, jumlah benar/salah, dan pesan sesuai nilai.
- Main lagi dan kembali ke beranda tanpa kehilangan nama.
- Konfirmasi saat keluar di tengah kuis.
- State management dengan Provider: progres dan nama tidak hilang saat layar dirotasi atau pindah halaman.
- **Bonus:** dual-theme (Light/Dark) dengan tombol ganti manual dan default mengikuti sistem.
- **Bonus:** tampilan adaptif dan responsif untuk ponsel (portrait/landscape), tablet, dan web (layout dua kolom pada layar lebar).

### Teknologi
Flutter, Dart, Provider, font Poppins.

## Dokumentasi

### Credit Aset
- **Font Poppins**: Indian Type Foundry, melalui [Google Fonts](https://fonts.google.com/specimen/Poppins), lisensi SIL Open Font License.
- **Logo, trophy, ikon correct/wrong**: dibuat sendiri (desain orisinal dengan bantuan AI).
- **Package Provider**: [pub.dev/packages/provider](https://pub.dev/packages/provider).
- **Pertanyaan kuis**: ditulis sendiri.

### Screenshot
| Home (Light) | Home (Dark)                                      |
|---|--------------------------------------------------|
| ![Home Light](docs/screenshots/01-home-light.jpeg) | ![Home Dark](docs/screenshots/02-home-dark.jpeg) |

| Kuis                                   | Kuis (dijawab) |
|----------------------------------------|---|
| ![Kuis](docs/screenshots/03-quiz.jpeg) | ![Kuis dijawab](docs/screenshots/04-quiz-answered.png) |

| Hasil | Tampilan Tablet/Web |
|---|---|
| ![Hasil](docs/screenshots/05-result.png) | ![Tablet Web](docs/screenshots/06-web.png) |

### Mockup / Prototype
[Lihat di Figma](ISI_LINK_FIGMA)