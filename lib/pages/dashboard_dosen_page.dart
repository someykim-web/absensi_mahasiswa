import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/placeholder_halaman.dart';

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
