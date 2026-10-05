import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/placeholder_halaman.dart';

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
