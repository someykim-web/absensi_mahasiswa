import 'package:flutter_test/flutter_test.dart';

import 'package:absensi_mahasiswa/main.dart';

void main() {
  testWidgets('Halaman Pilih Peran tampil dan bisa masuk sebagai mahasiswa',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AbsensiApp());

    expect(find.text('Masuk sebagai'), findsOneWidget);
    expect(find.text('Mahasiswa'), findsOneWidget);
    expect(find.text('Dosen'), findsOneWidget);

    await tester.tap(find.text('Mahasiswa'));
    await tester.pump();

    expect(find.text('Kelas Hari Ini'), findsOneWidget);
  });
}
