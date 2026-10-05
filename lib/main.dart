import 'package:flutter/material.dart';

import 'pages/dashboard_dosen_page.dart';
import 'pages/main_nav_page.dart';
import 'pages/pilih_peran_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AbsensiApp());
}

class AbsensiApp extends StatelessWidget {
  const AbsensiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: buatTemaAplikasi(),
      home: const AppRoot(),
    );
  }
}

/// AppRoot menentukan halaman yang tampil berdasarkan peran yang dipilih.
/// Perpindahan halaman memakai setState (tanpa Navigator):
///   _peran == ''          -> Halaman Pilih Peran
///   _peran == 'mahasiswa' -> Halaman mahasiswa (dengan BottomNavigationBar)
///   _peran == 'dosen'     -> Dashboard Dosen
class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  String _peran = '';

  void _pilihMahasiswa() {
    setState(() {
      _peran = 'mahasiswa';
    });
  }

  void _pilihDosen() {
    setState(() {
      _peran = 'dosen';
    });
  }

  void _keluar() {
    setState(() {
      _peran = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_peran == 'mahasiswa') {
      return MainNavPage(onKeluar: _keluar);
    }
    if (_peran == 'dosen') {
      return DashboardDosenPage(onKeluar: _keluar);
    }
    return PilihPeranPage(
      onPilihMahasiswa: _pilihMahasiswa,
      onPilihDosen: _pilihDosen,
    );
  }
}
