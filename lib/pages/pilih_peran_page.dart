import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Halaman pertama: pengguna memilih masuk sebagai Mahasiswa atau Dosen.
class PilihPeranPage extends StatelessWidget {
  final VoidCallback onPilihMahasiswa;
  final VoidCallback onPilihDosen;

  const PilihPeranPage({
    super.key,
    required this.onPilihMahasiswa,
    required this.onPilihDosen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---------- Bagian atas: logo dan judul ----------
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.fact_check_rounded,
                      size: 52,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Absensi Mahasiswa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Catat kehadiran kuliah dengan mudah',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // ---------- Bagian bawah: pilihan peran ----------
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Masuk sebagai',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Pilih peranmu untuk melanjutkan',
                      style: TextStyle(color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 24),
                    _buildKartuPeran(
                      icon: Icons.school_rounded,
                      judul: 'Mahasiswa',
                      deskripsi: 'Check-in kelas dan lihat riwayat kehadiran',
                      onTap: onPilihMahasiswa,
                    ),
                    const SizedBox(height: 16),
                    _buildKartuPeran(
                      icon: Icons.badge_rounded,
                      judul: 'Dosen',
                      deskripsi: 'Pantau kehadiran mahasiswa di kelas',
                      onTap: onPilihDosen,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Kartu pilihan peran yang bisa diketuk.
  Widget _buildKartuPeran({
    required IconData icon,
    required String judul,
    required String deskripsi,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryLight, width: 2),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.primary, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deskripsi,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
