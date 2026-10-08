import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';

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
