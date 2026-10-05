import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/placeholder_halaman.dart';

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
