import 'package:flutter/material.dart';

/// Semua warna aplikasi dikumpulkan di sini supaya tampilan
/// tiap halaman konsisten. Pakai AppColors.xxx, jangan tulis
/// kode warna langsung di halaman.
class AppColors {
  // Warna utama
  static const Color primary = Color(0xFF4361EE);
  static const Color primaryLight = Color(0xFFE8ECFD);
  static const Color background = Color(0xFFF5F6FA);

  // Warna teks
  static const Color textDark = Color(0xFF1F2937);
  static const Color textGrey = Color(0xFF6B7280);

  // Warna status kehadiran (teks/ikon) dan latarnya (badge)
  static const Color hadir = Color(0xFF22A06B);
  static const Color hadirBg = Color(0xFFE3F5EC);
  static const Color izin = Color(0xFFE5A100);
  static const Color izinBg = Color(0xFFFFF4D6);
  static const Color alpa = Color(0xFFE5484D);
  static const Color alpaBg = Color(0xFFFDE8E8);

  /// Warna teks/ikon sesuai status: 'Hadir', 'Izin', atau 'Alpa'.
  static Color warnaStatus(String status) {
    if (status == 'Hadir') return hadir;
    if (status == 'Izin') return izin;
    return alpa;
  }

  /// Warna latar (lebih muda) sesuai status.
  static Color warnaLatarStatus(String status) {
    if (status == 'Hadir') return hadirBg;
    if (status == 'Izin') return izinBg;
    return alpaBg;
  }
}

/// Tema utama aplikasi, dipakai di MaterialApp (main.dart).
ThemeData buatTemaAplikasi() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    scaffoldBackgroundColor: AppColors.background,
    useMaterial3: true,
  );
}
