import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/status_badge.dart';

/// Riwayat Kehadiran: daftar kehadiran mahasiswa + filter per mata kuliah.
class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  // Kode mata kuliah yang dipilih. '' berarti "Semua".
  String _kodeTerpilih = '';

  List<Kehadiran> _ambilDataTampil() {
    if (_kodeTerpilih == '') {
      return riwayatKehadiran;
    }
    return kehadiranPerMatkul(_kodeTerpilih);
  }

  @override
  Widget build(BuildContext context) {
    List<Kehadiran> data = _ambilDataTampil();

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
      body: Column(
        children: [
          _buildFilter(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menampilkan ${data.length} pertemuan',
                style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
              ),
            ),
          ),
          Expanded(
            child: data.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada riwayat kehadiran.',
                      style: TextStyle(color: AppColors.textGrey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: data.length,
                    itemBuilder: (context, i) => _buildKartuRiwayat(data[i]),
                  ),
          ),
        ],
      ),
    );
  }

  // ---------- Filter per mata kuliah (chip yang bisa digeser) ----------
  Widget _buildFilter() {
    List<Widget> chips = [];
    chips.add(_buildChip('Semua', ''));
    for (int i = 0; i < daftarMataKuliah.length; i++) {
      chips.add(_buildChip(daftarMataKuliah[i].nama, daftarMataKuliah[i].kode));
    }

    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: chips,
      ),
    );
  }

  Widget _buildChip(String label, String kode) {
    bool terpilih = _kodeTerpilih == kode;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: terpilih,
        showCheckmark: false,
        selectedColor: AppColors.primary,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 13,
          color: terpilih ? Colors.white : AppColors.textDark,
        ),
        onSelected: (_) {
          setState(() {
            _kodeTerpilih = kode;
          });
        },
      ),
    );
  }

  // ---------- Kartu satu pertemuan ----------
  Widget _buildKartuRiwayat(Kehadiran item) {
    String keteranganJam = 'Tidak check-in';
    if (item.jamMasuk != '-') {
      keteranganJam = 'Masuk ${item.jamMasuk}';
    }

    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.warnaLatarStatus(item.status),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.event_available_rounded,
              color: AppColors.warnaStatus(item.status),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.namaMatkul,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.tanggal,
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppColors.textGrey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      keteranganJam,
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          StatusBadge(status: item.status),
        ],
      ),
    );
  }
}
