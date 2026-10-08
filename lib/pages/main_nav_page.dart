import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'checkin_page.dart';
import 'dashboard_mahasiswa_page.dart';
import 'notifikasi_page.dart';
import 'riwayat_page.dart';
import 'statistik_page.dart';

/// Halaman utama mahasiswa dengan BottomNavigationBar (5 tab).
class MainNavPage extends StatefulWidget {
  final VoidCallback onKeluar;

  const MainNavPage({super.key, required this.onKeluar});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Urutan harus sama dengan urutan item di BottomNavigationBar
    final List<Widget> halaman = [
      DashboardMahasiswaPage(
        onKeluar: widget.onKeluar,
        onCheckin: () => _onNavTap(1), // tombol "Check-in Sekarang" pindah ke tab Check-in
        onNotifikasi: () => _onNavTap(4), // ikon lonceng pindah ke tab Notifikasi
      ),
      const CheckinPage(),
      const RiwayatPage(),
      const StatistikPage(),
      const NotifikasiPage(),
    ];

    return Scaffold(
      body: halaman[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner_rounded), label: 'Check-in'),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Statistik'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded), label: 'Notifikasi'),
        ],
      ),
    );
  }
}
