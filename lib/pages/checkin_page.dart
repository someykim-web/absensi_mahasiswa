import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/status_badge.dart';

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
