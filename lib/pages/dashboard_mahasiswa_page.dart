import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/status_badge.dart';

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
