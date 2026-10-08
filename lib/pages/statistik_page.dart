import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';

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
