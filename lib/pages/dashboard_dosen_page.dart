import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/status_badge.dart';

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
