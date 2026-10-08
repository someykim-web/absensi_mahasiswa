// =============================================================
// VERSI DARTPAD (gabungan semua file dalam satu file)
// Hanya untuk dijalankan/preview di dartpad.dev.
// Kode aslinya tetap di project (lib/...), itu yang di-push ke GitHub.
// =============================================================

import 'package:flutter/material.dart';

// ---------------- main.dart ----------------



void main() {
  runApp(const AbsensiApp());
}

class AbsensiApp extends StatelessWidget {
  const AbsensiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: buatTemaAplikasi(),
      home: const AppRoot(),
    );
  }
}

/// AppRoot menentukan halaman yang tampil berdasarkan peran yang dipilih.
/// Perpindahan halaman memakai setState (tanpa Navigator):
///   _peran == ''          -> Halaman Pilih Peran
///   _peran == 'mahasiswa' -> Halaman mahasiswa (dengan BottomNavigationBar)
///   _peran == 'dosen'     -> Dashboard Dosen
class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  String _peran = '';

  void _pilihMahasiswa() {
    setState(() {
      _peran = 'mahasiswa';
    });
  }

  void _pilihDosen() {
    setState(() {
      _peran = 'dosen';
    });
  }

  void _keluar() {
    setState(() {
      _peran = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_peran == 'mahasiswa') {
      return MainNavPage(onKeluar: _keluar);
    }
    if (_peran == 'dosen') {
      return DashboardDosenPage(onKeluar: _keluar);
    }
    return PilihPeranPage(
      onPilihMahasiswa: _pilihMahasiswa,
      onPilihDosen: _pilihDosen,
    );
  }
}

// ---------------- theme/app_theme.dart ----------------


/// Semua warna aplikasi dikumpulkan di sini supaya tampilan
/// tiap halaman konsisten. Pakai AppColors.xxx, jangan tulis
/// kode warna langsung di halaman.
class AppColors {
  // Warna utama
  static const Color primary = Color(0xFF4361EE);
  static const Color primaryLight = Color(0xFFE8ECFD);
  static const Color background = Color(0xFFF5F6FA);

  // Warna teks
  static const Color textDark = Color(0xFF1F2937);
  static const Color textGrey = Color(0xFF6B7280);

  // Warna status kehadiran (teks/ikon) dan latarnya (badge)
  static const Color hadir = Color(0xFF22A06B);
  static const Color hadirBg = Color(0xFFE3F5EC);
  static const Color izin = Color(0xFFE5A100);
  static const Color izinBg = Color(0xFFFFF4D6);
  static const Color alpa = Color(0xFFE5484D);
  static const Color alpaBg = Color(0xFFFDE8E8);

  /// Warna teks/ikon sesuai status: 'Hadir', 'Izin', atau 'Alpa'.
  static Color warnaStatus(String status) {
    if (status == 'Hadir') return hadir;
    if (status == 'Izin') return izin;
    return alpa;
  }

  /// Warna latar (lebih muda) sesuai status.
  static Color warnaLatarStatus(String status) {
    if (status == 'Hadir') return hadirBg;
    if (status == 'Izin') return izinBg;
    return alpaBg;
  }
}

/// Tema utama aplikasi, dipakai di MaterialApp (main.dart).
ThemeData buatTemaAplikasi() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    scaffoldBackgroundColor: AppColors.background,
    useMaterial3: true,
  );
}

// ---------------- data/dummy_data.dart ----------------

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

/// Notifikasi untuk mahasiswa (misal: tidak hadir di kelas).
class Notifikasi {
  final String judul;
  final String pesan;
  final String waktu;
  final String status; // statusHadir / statusIzin / statusAlpa (menentukan warna & ikon)

  const Notifikasi({
    required this.judul,
    required this.pesan,
    required this.waktu,
    required this.status,
  });
}

/// Dipakai di Dashboard Dosen (tampilan Mingguan): rekap satu pertemuan kelas.
class RekapPertemuan {
  final String tanggal;
  final int hadir;
  final int izin;
  final int alpa;

  const RekapPertemuan({
    required this.tanggal,
    required this.hadir,
    required this.izin,
    required this.alpa,
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
    dosen: 'Novario Jaya Perdana, S.Kom., M.T.',
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
  dosen: 'Novario Jaya Perdana, S.Kom., M.T.',
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

// ---------- Notifikasi mahasiswa (terbaru di atas) ----------

const List<Notifikasi> daftarNotifikasi = [
  Notifikasi(
    judul: 'Izin Tercatat',
    pesan: 'Izin kamu di Analisis Proses Bisnis pada Rab, 7 Okt 2026 sudah dicatat oleh dosen.',
    waktu: 'Rab, 7 Okt 2026 • 13.10',
    status: statusIzin,
  ),
  Notifikasi(
    judul: 'Kamu Tidak Hadir',
    pesan: 'Kamu tidak hadir di Manajemen Proyek SI pada Kam, 1 Okt 2026. Hubungi dosen jika ada kendala.',
    waktu: 'Kam, 1 Okt 2026 • 10.45',
    status: statusAlpa,
  ),
  Notifikasi(
    judul: 'Izin Tercatat',
    pesan: 'Izin kamu di Interaksi Manusia & Komputer pada Jum, 25 Sep 2026 sudah dicatat oleh dosen.',
    waktu: 'Jum, 25 Sep 2026 • 11.40',
    status: statusIzin,
  ),
  Notifikasi(
    judul: 'Kamu Tidak Hadir',
    pesan: 'Kamu tidak hadir di Mobile Programming pada Sen, 21 Sep 2026. Hubungi dosen jika ada kendala.',
    waktu: 'Sen, 21 Sep 2026 • 10.40',
    status: statusAlpa,
  ),
];

// ---------- Rekap per pertemuan kelas Mobile Programming (terbaru di atas) ----------
// Tiap pertemuan jumlahnya 10 mahasiswa (hadir + izin + alpa).

const List<RekapPertemuan> rekapMingguanKelas = [
  RekapPertemuan(tanggal: 'Sen, 12 Okt 2026', hadir: 7, izin: 1, alpa: 2),
  RekapPertemuan(tanggal: 'Sen, 5 Okt 2026', hadir: 9, izin: 0, alpa: 1),
  RekapPertemuan(tanggal: 'Sen, 28 Sep 2026', hadir: 10, izin: 0, alpa: 0),
  RekapPertemuan(tanggal: 'Sen, 21 Sep 2026', hadir: 8, izin: 1, alpa: 1),
  RekapPertemuan(tanggal: 'Sen, 14 Sep 2026', hadir: 9, izin: 1, alpa: 0),
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

// ---------------- widgets/app_card.dart ----------------


/// Kartu putih dengan sudut membulat dan bayangan tipis.
/// Pakai ini untuk semua kartu supaya tampilannya seragam.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000), // hitam transparan 5%
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ---------------- widgets/status_badge.dart ----------------



/// Label kecil berwarna untuk status kehadiran.
/// Contoh: StatusBadge(status: 'Hadir')
class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.warnaLatarStatus(status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: AppColors.warnaStatus(status),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ---------------- widgets/placeholder_halaman.dart ----------------



/// Tampilan sementara untuk halaman yang belum dikerjakan.
/// Hapus pemakaiannya kalau halamanmu sudah jadi.
class PlaceholderHalaman extends StatelessWidget {
  final IconData icon;
  final String judul;

  const PlaceholderHalaman({
    super.key,
    required this.icon,
    required this.judul,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              judul,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Halaman ini sedang dikerjakan.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- pages/pilih_peran_page.dart ----------------



/// Halaman pertama: pengguna memilih masuk sebagai Mahasiswa atau Dosen.
class PilihPeranPage extends StatelessWidget {
  final VoidCallback onPilihMahasiswa;
  final VoidCallback onPilihDosen;

  const PilihPeranPage({
    super.key,
    required this.onPilihMahasiswa,
    required this.onPilihDosen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---------- Bagian atas: logo dan judul ----------
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.fact_check_rounded,
                      size: 52,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Absensi Mahasiswa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Catat kehadiran kuliah dengan mudah',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // ---------- Bagian bawah: pilihan peran ----------
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Masuk sebagai',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Pilih peranmu untuk melanjutkan',
                      style: TextStyle(color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 24),
                    _buildKartuPeran(
                      icon: Icons.school_rounded,
                      judul: 'Mahasiswa',
                      deskripsi: 'Check-in kelas dan lihat riwayat kehadiran',
                      onTap: onPilihMahasiswa,
                    ),
                    const SizedBox(height: 16),
                    _buildKartuPeran(
                      icon: Icons.badge_rounded,
                      judul: 'Dosen',
                      deskripsi: 'Pantau kehadiran mahasiswa di kelas',
                      onTap: onPilihDosen,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Kartu pilihan peran yang bisa diketuk.
  Widget _buildKartuPeran({
    required IconData icon,
    required String judul,
    required String deskripsi,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryLight, width: 2),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.primary, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deskripsi,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}

// ---------------- pages/main_nav_page.dart ----------------



/// Halaman utama mahasiswa dengan BottomNavigationBar (5 tab).
class MainNavPage extends StatefulWidget {
  final VoidCallback onKeluar;

  const MainNavPage({super.key, required this.onKeluar});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Urutan harus sama dengan urutan item di BottomNavigationBar
    final List<Widget> halaman = [
      DashboardMahasiswaPage(
        onKeluar: widget.onKeluar,
        onCheckin: () => _onNavTap(1), // tombol "Check-in Sekarang" pindah ke tab Check-in
        onNotifikasi: () => _onNavTap(4), // ikon lonceng pindah ke tab Notifikasi
      ),
      const CheckinPage(),
      const RiwayatPage(),
      const StatistikPage(),
      const NotifikasiPage(),
    ];

    return Scaffold(
      body: halaman[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner_rounded), label: 'Check-in'),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Statistik'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded), label: 'Notifikasi'),
        ],
      ),
    );
  }
}

// ---------------- pages/dashboard_mahasiswa_page.dart ----------------



/// Dashboard Mahasiswa: sapaan, kelas hari ini, ringkasan kehadiran,
/// dan daftar mata kuliah beserta status kehadirannya.
class DashboardMahasiswaPage extends StatelessWidget {
  final VoidCallback onCheckin;
  final VoidCallback onNotifikasi;
  final VoidCallback onKeluar;

  const DashboardMahasiswaPage({
    super.key,
    required this.onCheckin,
    required this.onNotifikasi,
    required this.onKeluar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Beranda',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Badge(
              label: Text('${daftarNotifikasi.length}'),
              child: const Icon(Icons.notifications_rounded),
            ),
            tooltip: 'Notifikasi',
            onPressed: onNotifikasi,
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Keluar',
            onPressed: onKeluar,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildKelasHariIni(),
                  const SizedBox(height: 24),
                  _buildJudulBagian('Ringkasan Kehadiran'),
                  const SizedBox(height: 12),
                  _buildRingkasan(),
                  const SizedBox(height: 24),
                  _buildJudulBagian('Mata Kuliah Saya'),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true, // supaya bisa di dalam SingleChildScrollView
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: daftarMataKuliah.length,
                    itemBuilder: (context, i) => _buildKartuMatkul(daftarMataKuliah[i]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Header biru: foto (inisial), nama, NIM ----------
  Widget _buildHeader() {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: Text(
                  'CF',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, ${mahasiswaLogin.nama}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${mahasiswaLogin.nim} • ${mahasiswaLogin.prodi}',
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Icon(Icons.calendar_today_rounded, color: Colors.white70, size: 16),
              SizedBox(width: 6),
              Text(
                tanggalHariIni,
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- Kartu "Kelas Hari Ini" + tombol Check-in ----------
  Widget _buildKelasHariIni() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Kelas Hari Ini',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.access_time_rounded, size: 16, color: AppColors.textGrey),
              const SizedBox(width: 4),
              Text(
                kelasHariIni.jam,
                style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            kelasHariIni.nama,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoBaris(Icons.person_outline_rounded, kelasHariIni.dosen),
          const SizedBox(height: 4),
          _buildInfoBaris(Icons.location_on_outlined, kelasHariIni.ruang),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onCheckin,
              icon: const Icon(Icons.qr_code_scanner_rounded, size: 20),
              label: const Text('Check-in Sekarang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBaris(IconData icon, String teks) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textGrey),
        const SizedBox(width: 6),
        Text(teks, style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
      ],
    );
  }

  // ---------- Ringkasan jumlah Hadir / Izin / Alpa ----------
  Widget _buildRingkasan() {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(child: _StatItem(jumlah: hitungStatus(statusHadir), label: 'Hadir', warna: AppColors.hadir)),
          const _GarisVertikal(),
          Expanded(child: _StatItem(jumlah: hitungStatus(statusIzin), label: 'Izin', warna: AppColors.izin)),
          const _GarisVertikal(),
          Expanded(child: _StatItem(jumlah: hitungStatus(statusAlpa), label: 'Alpa', warna: AppColors.alpa)),
        ],
      ),
    );
  }

  // ---------- Kartu per mata kuliah ----------
  Widget _buildKartuMatkul(MataKuliah matkul) {
    int persen = persenHadirMatkul(matkul.kode);
    String statusTerakhir = statusTerakhirMatkul(matkul.kode);

    // Warna persentase: >= 80% hijau, >= 60% kuning, di bawahnya merah
    Color warnaPersen = AppColors.alpa;
    if (persen >= 80) {
      warnaPersen = AppColors.hadir;
    } else if (persen >= 60) {
      warnaPersen = AppColors.izin;
    }

    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.menu_book_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  matkul.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  matkul.dosen,
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  '${matkul.hari}, ${matkul.jam}',
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Pertemuan terakhir: ',
                      style: TextStyle(color: AppColors.textGrey, fontSize: 12),
                    ),
                    StatusBadge(status: statusTerakhir),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(
                '$persen%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: warnaPersen,
                ),
              ),
              const Text(
                'hadir',
                style: TextStyle(color: AppColors.textGrey, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJudulBagian(String judul) {
    return Text(
      judul,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    );
  }
}

/// Satu angka statistik (dipakai di kartu Ringkasan).
class _StatItem extends StatelessWidget {
  final int jumlah;
  final String label;
  final Color warna;

  const _StatItem({
    required this.jumlah,
    required this.label,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$jumlah',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: warna,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
      ],
    );
  }
}

/// Garis pemisah tipis antar angka statistik.
class _GarisVertikal extends StatelessWidget {
  const _GarisVertikal();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}

// ---------------- pages/checkin_page.dart ----------------



/// Halaman Check-in: mockup QR scanner untuk absensi kelas hari ini.
/// Scanner dan lokasi hanya tampilan (tidak benar-benar berfungsi).
class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  bool _sudahCheckin = false;

  // Jam check-in dummy (hanya mockup, bukan waktu sebenarnya)
  static const String _jamCheckin = '07.55';

  void _onScan() {
    setState(() {
      _sudahCheckin = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Check-in berhasil'),
        backgroundColor: AppColors.hadir,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Check-in',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoKelas(),
            const SizedBox(height: 24),
            _buildScanner(),
            const SizedBox(height: 24),
            _buildLokasi(),
            const SizedBox(height: 20),
            _buildTombolScan(),
            if (_sudahCheckin) ...[
              const SizedBox(height: 16),
              _buildHasilCheckin(),
            ],
          ],
        ),
      ),
    );
  }

  // ---------- Info kelas yang akan di-check-in ----------
  Widget _buildInfoKelas() {
    return AppCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.menu_book_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kelasHariIni.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  kelasHariIni.dosen,
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  '${kelasHariIni.jam} • ${kelasHariIni.ruang}',
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Kotak mockup QR scanner ----------
  Widget _buildScanner() {
    Color warna = _sudahCheckin ? AppColors.hadir : AppColors.primary;

    return Column(
      children: [
        Container(
          width: 240,
          height: 240,
          decoration: BoxDecoration(
            color: AppColors.textDark,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: warna, width: 3),
          ),
          child: Icon(
            _sudahCheckin
                ? Icons.check_circle_rounded
                : Icons.qr_code_scanner_rounded,
            size: 120,
            color: _sudahCheckin ? AppColors.hadir : Colors.white54,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _sudahCheckin
              ? 'Kehadiran kamu sudah tercatat'
              : 'Arahkan kamera ke QR Code yang ditampilkan dosen',
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
        ),
      ],
    );
  }

  // ---------- Kartu lokasi (mockup GPS) ----------
  Widget _buildLokasi() {
    return AppCard(
      child: Row(
        children: [
          const Icon(Icons.location_on_rounded, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lokasi Terdeteksi',
                  style: TextStyle(color: AppColors.textGrey, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(
                  kelasHariIni.ruang,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.hadirBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Sesuai',
              style: TextStyle(
                color: AppColors.hadir,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Tombol Scan ----------
  Widget _buildTombolScan() {
    return ElevatedButton.icon(
      onPressed: _sudahCheckin ? null : _onScan,
      icon: const Icon(Icons.qr_code_scanner_rounded, size: 20),
      label: Text(_sudahCheckin ? 'Sudah Check-in' : 'Scan QR Code'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey.shade300,
        disabledForegroundColor: Colors.grey.shade600,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ---------- Ringkasan setelah check-in ----------
  Widget _buildHasilCheckin() {
    return AppCard(
      child: Column(
        children: [
          _buildBarisHasil('Status', const StatusBadge(status: statusHadir)),
          const Divider(height: 24),
          _buildBarisHasil(
            'Jam masuk',
            const Text(
              _jamCheckin,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          const Divider(height: 24),
          _buildBarisHasil(
            'Tanggal',
            const Text(
              tanggalHariIni,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarisHasil(String label, Widget nilai) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textGrey)),
        nilai,
      ],
    );
  }
}

// ---------------- pages/riwayat_page.dart ----------------



/// Riwayat Kehadiran: daftar kehadiran mahasiswa + filter per mata kuliah.
class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  // Kode mata kuliah yang dipilih. '' berarti "Semua".
  String _kodeTerpilih = '';

  List<Kehadiran> _ambilDataTampil() {
    if (_kodeTerpilih == '') {
      return riwayatKehadiran;
    }
    return kehadiranPerMatkul(_kodeTerpilih);
  }

  @override
  Widget build(BuildContext context) {
    List<Kehadiran> data = _ambilDataTampil();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Riwayat Kehadiran',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          _buildFilter(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menampilkan ${data.length} pertemuan',
                style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
              ),
            ),
          ),
          Expanded(
            child: data.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada riwayat kehadiran.',
                      style: TextStyle(color: AppColors.textGrey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: data.length,
                    itemBuilder: (context, i) => _buildKartuRiwayat(data[i]),
                  ),
          ),
        ],
      ),
    );
  }

  // ---------- Filter per mata kuliah (chip yang bisa digeser) ----------
  Widget _buildFilter() {
    List<Widget> chips = [];
    chips.add(_buildChip('Semua', ''));
    for (int i = 0; i < daftarMataKuliah.length; i++) {
      chips.add(_buildChip(daftarMataKuliah[i].nama, daftarMataKuliah[i].kode));
    }

    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: chips,
      ),
    );
  }

  Widget _buildChip(String label, String kode) {
    bool terpilih = _kodeTerpilih == kode;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: terpilih,
        showCheckmark: false,
        selectedColor: AppColors.primary,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 13,
          color: terpilih ? Colors.white : AppColors.textDark,
        ),
        onSelected: (_) {
          setState(() {
            _kodeTerpilih = kode;
          });
        },
      ),
    );
  }

  // ---------- Kartu satu pertemuan ----------
  Widget _buildKartuRiwayat(Kehadiran item) {
    String keteranganJam = 'Tidak check-in';
    if (item.jamMasuk != '-') {
      keteranganJam = 'Masuk ${item.jamMasuk}';
    }

    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.warnaLatarStatus(item.status),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.event_available_rounded,
              color: AppColors.warnaStatus(item.status),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.namaMatkul,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.tanggal,
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppColors.textGrey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      keteranganJam,
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          StatusBadge(status: item.status),
        ],
      ),
    );
  }
}

// ---------------- pages/statistik_page.dart ----------------



/// Statistik Kehadiran: persentase hadir, jumlah dan persentase
/// Hadir/Izin/Alpa, serta persentase kehadiran per mata kuliah.
class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  // Batas minimal kehadiran (dummy) untuk pesan peringatan
  static const int _batasMinimal = 75;

  // Warna persentase: >= 80% hijau, >= 60% kuning, di bawahnya merah
  Color _warnaPersen(int persen) {
    if (persen >= 80) return AppColors.hadir;
    if (persen >= 60) return AppColors.izin;
    return AppColors.alpa;
  }

  @override
  Widget build(BuildContext context) {
    int total = riwayatKehadiran.length;
    int persen = 0;
    if (total > 0) {
      persen = (hitungStatus(statusHadir) * 100) ~/ total;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Statistik Kehadiran',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLingkaranPersen(persen, total),
            const SizedBox(height: 16),
            _buildPesan(persen),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildKartuStatus(
                    statusHadir,
                    Icons.check_circle_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildKartuStatus(
                    statusIzin,
                    Icons.info_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildKartuStatus(
                    statusAlpa,
                    Icons.cancel_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Kehadiran per Mata Kuliah',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true, // supaya bisa di dalam SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(),
              itemCount: daftarMataKuliah.length,
              itemBuilder: (context, i) => _buildBarMatkul(daftarMataKuliah[i]),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Lingkaran persentase kehadiran ----------
  Widget _buildLingkaranPersen(int persen, int total) {
    Color warna = _warnaPersen(persen);

    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          SizedBox(
            width: 140,
            height: 140,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: persen / 100,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey.shade200,
                    color: warna,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$persen%',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: warna,
                      ),
                    ),
                    const Text(
                      'Kehadiran',
                      style: TextStyle(color: AppColors.textGrey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Dari $total pertemuan',
            style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // ---------- Pesan aman / peringatan kehadiran ----------
  Widget _buildPesan(int persen) {
    bool aman = persen >= _batasMinimal;
    Color warna = aman ? AppColors.hadir : AppColors.izin;
    Color warnaLatar = aman ? AppColors.hadirBg : AppColors.izinBg;
    String pesan = aman
        ? 'Kehadiran kamu sudah memenuhi batas minimal $_batasMinimal%.'
        : 'Kehadiran kamu di bawah batas minimal $_batasMinimal%. Tingkatkan kehadiran ya!';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: warnaLatar,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            aman ? Icons.thumb_up_rounded : Icons.warning_amber_rounded,
            color: warna,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              pesan,
              style: const TextStyle(color: AppColors.textDark, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Kartu jumlah per status ----------
  Widget _buildKartuStatus(String status, IconData icon) {
    int total = riwayatKehadiran.length;
    int persen = 0;
    if (total > 0) {
      persen = (hitungStatus(status) * 100) ~/ total;
    }

    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Icon(icon, color: AppColors.warnaStatus(status), size: 28),
          const SizedBox(height: 8),
          Text(
            '${hitungStatus(status)}',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.warnaStatus(status),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            status,
            style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            '$persen%',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.warnaStatus(status),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Bar persentase per mata kuliah ----------
  Widget _buildBarMatkul(MataKuliah matkul) {
    int persen = persenHadirMatkul(matkul.kode);
    Color warna = _warnaPersen(persen);

    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  matkul.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Text(
                '$persen%',
                style: TextStyle(fontWeight: FontWeight.bold, color: warna),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: persen / 100,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: warna,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- pages/notifikasi_page.dart ----------------



/// Notifikasi untuk mahasiswa, misalnya pemberitahuan tidak hadir
/// atau izin yang sudah dicatat dosen.
class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  // Ikon sesuai status notifikasi
  IconData _ikonStatus(String status) {
    if (status == statusHadir) return Icons.check_circle_rounded;
    if (status == statusIzin) return Icons.info_rounded;
    return Icons.cancel_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifikasi',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: daftarNotifikasi.isEmpty
          ? const Center(
              child: Text(
                'Belum ada notifikasi.',
                style: TextStyle(color: AppColors.textGrey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: daftarNotifikasi.length,
              itemBuilder: (context, i) => _buildKartuNotifikasi(daftarNotifikasi[i]),
            ),
    );
  }

  Widget _buildKartuNotifikasi(Notifikasi item) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.warnaLatarStatus(item.status),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _ikonStatus(item.status),
              color: AppColors.warnaStatus(item.status),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.judul,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.pesan,
                  style: const TextStyle(color: AppColors.textDark, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  item.waktu,
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- pages/dashboard_dosen_page.dart ----------------



/// Dashboard Dosen: ringkasan kehadiran kelas dengan dua tampilan:
///   Harian   -> kehadiran tiap mahasiswa di kelas hari ini
///   Mingguan -> rekap kehadiran per pertemuan (minggu)
class DashboardDosenPage extends StatefulWidget {
  final VoidCallback onKeluar;

  const DashboardDosenPage({super.key, required this.onKeluar});

  @override
  State<DashboardDosenPage> createState() => _DashboardDosenPageState();
}

class _DashboardDosenPageState extends State<DashboardDosenPage> {
  // 'harian' atau 'mingguan'
  String _mode = 'harian';

  /// Menghitung jumlah mahasiswa di kelas hari ini dengan status tertentu.
  int _hitungKelas(String status) {
    int jumlah = 0;
    for (int i = 0; i < kehadiranKelasHariIni.length; i++) {
      if (kehadiranKelasHariIni[i].status == status) {
        jumlah++;
      }
    }
    return jumlah;
  }

  // Warna persentase: >= 80% hijau, >= 60% kuning, di bawahnya merah
  Color _warnaPersen(int persen) {
    if (persen >= 80) return AppColors.hadir;
    if (persen >= 60) return AppColors.izin;
    return AppColors.alpa;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Dashboard Dosen',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Keluar',
            onPressed: widget.onKeluar,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildPilihanMode(),
                  const SizedBox(height: 16),
                  _mode == 'harian' ? _buildHarian() : _buildMingguan(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Header biru: sapaan dosen + info kelas ----------
  Widget _buildHeader() {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: Icon(Icons.person_rounded, color: AppColors.primary, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, ${kelasHariIni.dosen}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${kelasHariIni.nama} • ${kelasHariIni.kode}',
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Icon(Icons.calendar_today_rounded, color: Colors.white70, size: 16),
              SizedBox(width: 6),
              Text(
                tanggalHariIni,
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Text(
                '${kelasHariIni.jam} • ${kelasHariIni.ruang}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- Pilihan tampilan: Harian / Mingguan ----------
  Widget _buildPilihanMode() {
    return Row(
      children: [
        _buildChipMode('Harian', 'harian'),
        const SizedBox(width: 8),
        _buildChipMode('Mingguan', 'mingguan'),
      ],
    );
  }

  Widget _buildChipMode(String label, String nilai) {
    bool terpilih = _mode == nilai;

    return ChoiceChip(
      label: Text(label),
      selected: terpilih,
      showCheckmark: false,
      selectedColor: AppColors.primary,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        fontSize: 13,
        color: terpilih ? Colors.white : AppColors.textDark,
      ),
      onSelected: (_) {
        setState(() {
          _mode = nilai;
        });
      },
    );
  }

  Widget _buildJudulBagian(String judul) {
    return Text(
      judul,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      ),
    );
  }

  // =============================================================
  // TAMPILAN HARIAN
  // =============================================================
  Widget _buildHarian() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRingkasan(),
        const SizedBox(height: 24),
        _buildJudulBagian('Kehadiran Mahasiswa Hari Ini'),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true, // supaya bisa di dalam SingleChildScrollView
          physics: const NeverScrollableScrollPhysics(),
          itemCount: kehadiranKelasHariIni.length,
          itemBuilder: (context, i) =>
              _buildKartuMahasiswa(kehadiranKelasHariIni[i]),
        ),
      ],
    );
  }

  // ---------- Kartu ringkasan: total, persen hadir, Hadir/Izin/Alpa ----------
  Widget _buildRingkasan() {
    int hadir = _hitungKelas(statusHadir);
    int persen = 0;
    if (jumlahMahasiswaKelas > 0) {
      persen = (hadir * 100) ~/ jumlahMahasiswaKelas;
    }

    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.groups_rounded, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Mahasiswa',
                      style: TextStyle(color: AppColors.textGrey, fontSize: 12),
                    ),
                    Text(
                      '$jumlahMahasiswaKelas mahasiswa',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$persen%',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _warnaPersen(persen),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: persen / 100,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: _warnaPersen(persen),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _AngkaKelas(
                  jumlah: hadir,
                  label: 'Hadir',
                  warna: AppColors.hadir,
                ),
              ),
              const _PemisahVertikal(),
              Expanded(
                child: _AngkaKelas(
                  jumlah: _hitungKelas(statusIzin),
                  label: 'Izin',
                  warna: AppColors.izin,
                ),
              ),
              const _PemisahVertikal(),
              Expanded(
                child: _AngkaKelas(
                  jumlah: _hitungKelas(statusAlpa),
                  label: 'Alpa',
                  warna: AppColors.alpa,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- Kartu satu mahasiswa ----------
  Widget _buildKartuMahasiswa(KehadiranKelas item) {
    String keteranganJam = 'Belum check-in';
    if (item.jamMasuk != '-') {
      keteranganJam = 'Masuk ${item.jamMasuk}';
    }

    return AppCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryLight,
            child: Text(
              item.nama.substring(0, 1),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.nim} • $keteranganJam',
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          StatusBadge(status: item.status),
        ],
      ),
    );
  }

  // =============================================================
  // TAMPILAN MINGGUAN
  // =============================================================
  Widget _buildMingguan() {
    // Rata-rata persen hadir dari semua pertemuan yang ada di rekap
    int totalHadir = 0;
    for (int i = 0; i < rekapMingguanKelas.length; i++) {
      totalHadir += rekapMingguanKelas[i].hadir;
    }
    int totalKursi = jumlahMahasiswaKelas * rekapMingguanKelas.length;
    int rataRata = 0;
    if (totalKursi > 0) {
      rataRata = (totalHadir * 100) ~/ totalKursi;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_view_week_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rata-rata Kehadiran',
                      style: TextStyle(color: AppColors.textGrey, fontSize: 12),
                    ),
                    Text(
                      '${rekapMingguanKelas.length} pertemuan terakhir',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$rataRata%',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _warnaPersen(rataRata),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildJudulBagian('Rekap per Pertemuan'),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true, // supaya bisa di dalam SingleChildScrollView
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rekapMingguanKelas.length,
          itemBuilder: (context, i) => _buildKartuRekap(rekapMingguanKelas[i], i == 0),
        ),
      ],
    );
  }

  // ---------- Kartu rekap satu pertemuan ----------
  Widget _buildKartuRekap(RekapPertemuan rekap, bool hariIni) {
    int persen = 0;
    if (jumlahMahasiswaKelas > 0) {
      persen = (rekap.hadir * 100) ~/ jumlahMahasiswaKelas;
    }
    Color warna = _warnaPersen(persen);

    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        rekap.tanggal,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    if (hariIni) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Hari ini',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Text(
                '$persen%',
                style: TextStyle(fontWeight: FontWeight.bold, color: warna),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: persen / 100,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: warna,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _AngkaKelas(
                  jumlah: rekap.hadir,
                  label: 'Hadir',
                  warna: AppColors.hadir,
                ),
              ),
              const _PemisahVertikal(),
              Expanded(
                child: _AngkaKelas(
                  jumlah: rekap.izin,
                  label: 'Izin',
                  warna: AppColors.izin,
                ),
              ),
              const _PemisahVertikal(),
              Expanded(
                child: _AngkaKelas(
                  jumlah: rekap.alpa,
                  label: 'Alpa',
                  warna: AppColors.alpa,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Satu angka statistik kelas (dipakai di kartu ringkasan & rekap).
class _AngkaKelas extends StatelessWidget {
  final int jumlah;
  final String label;
  final Color warna;

  const _AngkaKelas({
    required this.jumlah,
    required this.label,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$jumlah',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: warna,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
      ],
    );
  }
}

/// Garis pemisah tipis antar angka statistik.
class _PemisahVertikal extends StatelessWidget {
  const _PemisahVertikal();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}

