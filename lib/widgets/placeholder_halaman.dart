import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

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
