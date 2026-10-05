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


/// Halaman utama mahasiswa dengan BottomNavigationBar (4 tab).
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
      ),
      const CheckinPage(),
      const RiwayatPage(),
      const StatistikPage(),
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
  final VoidCallback onKeluar;

  const DashboardMahasiswaPage({
    super.key,
    required this.onCheckin,
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


// =============================================================
// TODO [Nama 2]: ganti isi halaman ini.
// Isi: mockup QR scanner (kotak + ikon QR + tombol Scan -> SnackBar 'Check-in berhasil').
// Data ambil dari ../data/dummy_data.dart
// Kartu: ../widgets/app_card.dart  |  Badge status: ../widgets/status_badge.dart
// =============================================================
class CheckinPage extends StatelessWidget {
  const CheckinPage({super.key});

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
      body: const PlaceholderHalaman(
        icon: Icons.qr_code_scanner_rounded,
        judul: 'Check-in',
      ),
    );
  }
}

// ---------------- pages/riwayat_page.dart ----------------


// =============================================================
// TODO [Nama 2]: ganti isi halaman ini.
// Isi: ListView riwayatKehadiran (tanggal, matkul, jam masuk, status) + filter per matkul.
// Data ambil dari ../data/dummy_data.dart
// Kartu: ../widgets/app_card.dart  |  Badge status: ../widgets/status_badge.dart
// =============================================================
class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const PlaceholderHalaman(
        icon: Icons.history_rounded,
        judul: 'Riwayat Kehadiran',
      ),
    );
  }
}

// ---------------- pages/statistik_page.dart ----------------


// =============================================================
// TODO [Nama 3]: ganti isi halaman ini.
// Isi: kartu Hadir/Izin/Alpa (hitungStatus) + persentase pakai CircularProgressIndicator.
// Data ambil dari ../data/dummy_data.dart
// Kartu: ../widgets/app_card.dart  |  Badge status: ../widgets/status_badge.dart
// =============================================================
class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const PlaceholderHalaman(
        icon: Icons.bar_chart_rounded,
        judul: 'Statistik Kehadiran',
      ),
    );
  }
}

// ---------------- pages/dashboard_dosen_page.dart ----------------


// =============================================================
// TODO [Nama 3]: ganti isi body halaman ini.
// Isi: kartu ringkasan (jumlah mahasiswa, hadir hari ini, dst.)
//      + list kehadiranKelasHariIni (nama, NIM, jam masuk, status).
// Data ambil dari ../data/dummy_data.dart
// Kartu: ../widgets/app_card.dart  |  Badge status: ../widgets/status_badge.dart
// JANGAN hapus parameter onKeluar dan tombol keluar di AppBar.
// =============================================================
class DashboardDosenPage extends StatelessWidget {
  final VoidCallback onKeluar;

  const DashboardDosenPage({super.key, required this.onKeluar});

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
            onPressed: onKeluar,
          ),
        ],
      ),
      body: const PlaceholderHalaman(
        icon: Icons.groups_rounded,
        judul: 'Dashboard Dosen',
      ),
    );
  }
}
