// =============================================================
// DATA DUMMY BERSAMA
// Semua halaman mengambil data dari file ini supaya konsisten.
// Kalau mau mengubah/menambah data, kabari kelompok dulu ya.
// =============================================================

// ---------- Konstanta status kehadiran ----------
const String statusHadir = 'Hadir';
const String statusIzin = 'Izin';
const String statusAlpa = 'Alpa';

// ---------- Model data ----------

class Mahasiswa {
  final String nama;
  final String nim;
  final String prodi;

  const Mahasiswa({
    required this.nama,
    required this.nim,
    required this.prodi,
  });
}

class MataKuliah {
  final String kode;
  final String nama;
  final String dosen;
  final String hari;
  final String jam;
  final String ruang;

  const MataKuliah({
    required this.kode,
    required this.nama,
    required this.dosen,
    required this.hari,
    required this.jam,
    required this.ruang,
  });
}

class Kehadiran {
  final String tanggal;
  final String kodeMatkul;
  final String namaMatkul;
  final String jamMasuk; // '-' kalau tidak check-in
  final String status; // statusHadir / statusIzin / statusAlpa

  const Kehadiran({
    required this.tanggal,
    required this.kodeMatkul,
    required this.namaMatkul,
    required this.jamMasuk,
    required this.status,
  });
}

/// Dipakai di Dashboard Dosen: status kehadiran mahasiswa di kelas hari ini.
class KehadiranKelas {
  final String nama;
  final String nim;
  final String jamMasuk;
  final String status;

  const KehadiranKelas({
    required this.nama,
    required this.nim,
    required this.jamMasuk,
    required this.status,
  });
}

// ---------- Data mahasiswa yang sedang login ----------

const Mahasiswa mahasiswaLogin = Mahasiswa(
  nama: 'Chetrin Fransisca',
  nim: '825230185',
  prodi: 'Sistem Informasi',
);

const String tanggalHariIni = 'Senin, 12 Oktober 2026';

// ---------- Daftar mata kuliah ----------

const List<MataKuliah> daftarMataKuliah = [
  MataKuliah(
    kode: 'SI34006',
    nama: 'Mobile Programming',
    dosen: 'Budi Santoso, M.T.',
    hari: 'Senin',
    jam: '08.00 - 10.30',
    ruang: 'Lab Komputer 3',
  ),
  MataKuliah(
    kode: 'SI34002',
    nama: 'Basis Data Lanjut',
    dosen: 'Dewi Lestari, M.Kom.',
    hari: 'Selasa',
    jam: '10.30 - 13.00',
    ruang: 'R. 402',
  ),
  MataKuliah(
    kode: 'SI34004',
    nama: 'Analisis Proses Bisnis',
    dosen: 'Andi Wijaya, M.M.',
    hari: 'Rabu',
    jam: '13.00 - 15.30',
    ruang: 'R. 305',
  ),
  MataKuliah(
    kode: 'SI34008',
    nama: 'Manajemen Proyek SI',
    dosen: 'Rina Kartika, M.T.',
    hari: 'Kamis',
    jam: '08.00 - 10.30',
    ruang: 'R. 401',
  ),
  MataKuliah(
    kode: 'SI34010',
    nama: 'Interaksi Manusia & Komputer',
    dosen: 'Hendra Gunawan, M.Kom.',
    hari: 'Jumat',
    jam: '09.00 - 11.30',
    ruang: 'Lab Komputer 1',
  ),
];

/// Kelas yang jadwalnya hari ini (ditampilkan di Dashboard & Check-in).
const MataKuliah kelasHariIni = MataKuliah(
  kode: 'SI34006',
  nama: 'Mobile Programming',
  dosen: 'Budi Santoso, M.T.',
  hari: 'Senin',
  jam: '08.00 - 10.30',
  ruang: 'Lab Komputer 3',
);

// ---------- Riwayat kehadiran (terbaru di atas) ----------

const List<Kehadiran> riwayatKehadiran = [
  Kehadiran(tanggal: 'Jum, 9 Okt 2026', kodeMatkul: 'SI34010', namaMatkul: 'Interaksi Manusia & Komputer', jamMasuk: '08.55', status: statusHadir),
  Kehadiran(tanggal: 'Kam, 8 Okt 2026', kodeMatkul: 'SI34008', namaMatkul: 'Manajemen Proyek SI', jamMasuk: '07.58', status: statusHadir),
  Kehadiran(tanggal: 'Rab, 7 Okt 2026', kodeMatkul: 'SI34004', namaMatkul: 'Analisis Proses Bisnis', jamMasuk: '-', status: statusIzin),
  Kehadiran(tanggal: 'Sel, 6 Okt 2026', kodeMatkul: 'SI34002', namaMatkul: 'Basis Data Lanjut', jamMasuk: '10.25', status: statusHadir),
  Kehadiran(tanggal: 'Sen, 5 Okt 2026', kodeMatkul: 'SI34006', namaMatkul: 'Mobile Programming', jamMasuk: '07.52', status: statusHadir),
  Kehadiran(tanggal: 'Jum, 2 Okt 2026', kodeMatkul: 'SI34010', namaMatkul: 'Interaksi Manusia & Komputer', jamMasuk: '09.02', status: statusHadir),
  Kehadiran(tanggal: 'Kam, 1 Okt 2026', kodeMatkul: 'SI34008', namaMatkul: 'Manajemen Proyek SI', jamMasuk: '-', status: statusAlpa),
  Kehadiran(tanggal: 'Rab, 30 Sep 2026', kodeMatkul: 'SI34004', namaMatkul: 'Analisis Proses Bisnis', jamMasuk: '12.57', status: statusHadir),
  Kehadiran(tanggal: 'Sel, 29 Sep 2026', kodeMatkul: 'SI34002', namaMatkul: 'Basis Data Lanjut', jamMasuk: '10.31', status: statusHadir),
  Kehadiran(tanggal: 'Sen, 28 Sep 2026', kodeMatkul: 'SI34006', namaMatkul: 'Mobile Programming', jamMasuk: '07.55', status: statusHadir),
  Kehadiran(tanggal: 'Jum, 25 Sep 2026', kodeMatkul: 'SI34010', namaMatkul: 'Interaksi Manusia & Komputer', jamMasuk: '-', status: statusIzin),
  Kehadiran(tanggal: 'Kam, 24 Sep 2026', kodeMatkul: 'SI34008', namaMatkul: 'Manajemen Proyek SI', jamMasuk: '08.03', status: statusHadir),
  Kehadiran(tanggal: 'Rab, 23 Sep 2026', kodeMatkul: 'SI34004', namaMatkul: 'Analisis Proses Bisnis', jamMasuk: '12.59', status: statusHadir),
  Kehadiran(tanggal: 'Sel, 22 Sep 2026', kodeMatkul: 'SI34002', namaMatkul: 'Basis Data Lanjut', jamMasuk: '10.28', status: statusHadir),
  Kehadiran(tanggal: 'Sen, 21 Sep 2026', kodeMatkul: 'SI34006', namaMatkul: 'Mobile Programming', jamMasuk: '-', status: statusAlpa),
];

// ---------- Data untuk Dashboard Dosen (kelas Mobile Programming hari ini) ----------

const int jumlahMahasiswaKelas = 10;

const List<KehadiranKelas> kehadiranKelasHariIni = [
  KehadiranKelas(nama: 'Chetrin Fransisca', nim: '825230185', jamMasuk: '07.52', status: statusHadir),
  KehadiranKelas(nama: 'Andre Pratama', nim: '825230101', jamMasuk: '07.48', status: statusHadir),
  KehadiranKelas(nama: 'Bella Anggraini', nim: '825230112', jamMasuk: '07.59', status: statusHadir),
  KehadiranKelas(nama: 'Calvin Wijaya', nim: '825230120', jamMasuk: '-', status: statusIzin),
  KehadiranKelas(nama: 'Dinda Maharani', nim: '825230133', jamMasuk: '08.04', status: statusHadir),
  KehadiranKelas(nama: 'Evan Saputra', nim: '825230141', jamMasuk: '-', status: statusAlpa),
  KehadiranKelas(nama: 'Felicia Tan', nim: '825230150', jamMasuk: '07.56', status: statusHadir),
  KehadiranKelas(nama: 'Gilang Ramadhan', nim: '825230162', jamMasuk: '07.51', status: statusHadir),
  KehadiranKelas(nama: 'Hana Putri', nim: '825230177', jamMasuk: '08.01', status: statusHadir),
  KehadiranKelas(nama: 'Ivan Kurniawan', nim: '825230190', jamMasuk: '-', status: statusAlpa),
];

// ---------- Fungsi bantu (boleh dipakai di halaman mana saja) ----------

/// Menghitung jumlah riwayat dengan status tertentu, misal hitungStatus(statusHadir).
int hitungStatus(String status) {
  int jumlah = 0;
  for (int i = 0; i < riwayatKehadiran.length; i++) {
    if (riwayatKehadiran[i].status == status) {
      jumlah++;
    }
  }
  return jumlah;
}

/// Mengambil riwayat kehadiran untuk satu mata kuliah.
List<Kehadiran> kehadiranPerMatkul(String kodeMatkul) {
  List<Kehadiran> hasil = [];
  for (int i = 0; i < riwayatKehadiran.length; i++) {
    if (riwayatKehadiran[i].kodeMatkul == kodeMatkul) {
      hasil.add(riwayatKehadiran[i]);
    }
  }
  return hasil;
}

/// Persentase hadir (0-100) untuk satu mata kuliah.
int persenHadirMatkul(String kodeMatkul) {
  List<Kehadiran> data = kehadiranPerMatkul(kodeMatkul);
  if (data.isEmpty) return 0;

  int hadir = 0;
  for (int i = 0; i < data.length; i++) {
    if (data[i].status == statusHadir) {
      hadir++;
    }
  }
  return (hadir * 100) ~/ data.length;
}

/// Status pertemuan terakhir untuk satu mata kuliah ('-' kalau belum ada).
String statusTerakhirMatkul(String kodeMatkul) {
  List<Kehadiran> data = kehadiranPerMatkul(kodeMatkul);
  if (data.isEmpty) return '-';
  return data[0].status; // data sudah urut dari yang terbaru
}
