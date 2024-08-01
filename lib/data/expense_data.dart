import 'package:flutter/material.dart';
import 'package:hello_world/helper/convert-date.dart';
import 'package:hello_world/models/expense_item.dart';
import 'package:hello_world/data/hive_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> listPengeluaranKeseluruhan = [];

  List<ExpenseItem> getAllExpenseList() {
    return listPengeluaranKeseluruhan;
  }

  final db = HiveDatabase();

  void prepareData() {
    if (db.readData().isNotEmpty) {
      listPengeluaranKeseluruhan = db.readData();
    }
  }

  // tambah pengeluaran
  void tambahPengeluaran(ExpenseItem newPengeluaran) {
    listPengeluaranKeseluruhan.add(newPengeluaran);

    notifyListeners();
    db.savedData(listPengeluaranKeseluruhan);
  }

  // hapus pengeluaran
  void hapusPengeluaran(ExpenseItem hapusPengeluaran) {
    listPengeluaranKeseluruhan.remove(hapusPengeluaran);

    notifyListeners();
    db.savedData(listPengeluaranKeseluruhan);
  }

  // update pengeluaran
  void updatePengeluaran(ExpenseItem updatedPengeluaran) {
    // Find the index of the item to be updated
    int index = listPengeluaranKeseluruhan.indexWhere((expense) => expense.id == updatedPengeluaran.id);

    // Update the item if found
    if (index != -1) {
      listPengeluaranKeseluruhan[index] = updatedPengeluaran;

      notifyListeners();
      db.savedData(listPengeluaranKeseluruhan);
    }
  }

  // ambil hari untuk graph
  String ambilHari(DateTime hari) {
    switch (hari.weekday.toInt()) {
      case 1:
        return 'Sen';
      case 2:
        return 'Sel';
      case 3:
        return 'Rab';
      case 4:
        return 'Kam';
      case 5:
        return 'Jum';
      case 6:
        return 'Sab';
      case 7:
        return 'Min';
      default:
        return '';
    }
  }

  // ambil data untuk awal minggu (Senin)
  DateTime awalMingguHari() {
    DateTime? awalMinggu;
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (ambilHari(today.subtract(Duration(days: i))) == 'Sen') {
        awalMinggu = today.subtract(Duration(days: i));
        break;
      }
    }

    return awalMinggu!;
  }

  // daily spend
  Map<String, double> hitungPengeluaranHarian() {
    Map<String, double> rangkumanPengeluaranHarian = {};

    for (var pengeluaran in listPengeluaranKeseluruhan) {
      String tanggalData = convertDateTime(pengeluaran.tanggal).toString();
      double jumlah = double.parse(pengeluaran.jumlah);

      if (rangkumanPengeluaranHarian.containsKey(tanggalData)) {
        double jumlahSekarang = rangkumanPengeluaranHarian[tanggalData]!;
        jumlahSekarang += jumlah;
        rangkumanPengeluaranHarian[tanggalData] = jumlahSekarang;
      } else {
        rangkumanPengeluaranHarian.addAll({tanggalData: jumlah});
      }
    }

    return rangkumanPengeluaranHarian;
  }
}
