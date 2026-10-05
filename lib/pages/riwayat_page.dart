import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/placeholder_halaman.dart';

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
