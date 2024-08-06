import 'package:flutter/material.dart';
import 'package:hello_world/helper/convert-date.dart';
import 'package:hello_world/models/expense_item.dart';
import 'package:hello_world/data/hive_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> listPengeluaranKeseluruhan = [];
  int _currentPage = 1;
  final int _pageSize = 4; 

  final db = HiveDatabase();

  // Fetch all expense items
  List<ExpenseItem> getAllExpenseList() {
    return listPengeluaranKeseluruhan;
  }

  void prepareData() {
    if (db.readData().isNotEmpty) {
      listPengeluaranKeseluruhan = db.readData();
    }
  }

  // Getter for current page
  int get currentPage => _currentPage;

  // Getter for page size
  int get pageSize => _pageSize;

  void setCurrentPage(int newPage) {
    _currentPage = newPage;
    notifyListeners();
  }

  List<ExpenseItem> getCurrentPageItems() {
    int startIndex = (_currentPage - 1) * _pageSize;
    int endIndex = startIndex + _pageSize;

    return listPengeluaranKeseluruhan.sublist(
      startIndex,
      endIndex > listPengeluaranKeseluruhan.length ? listPengeluaranKeseluruhan.length : endIndex,
    );
  }

  void tambahPengeluaran(ExpenseItem newPengeluaran) {
    listPengeluaranKeseluruhan.add(newPengeluaran);
    notifyListeners();
    db.savedData(listPengeluaranKeseluruhan);
  }

  void hapusPengeluaran(ExpenseItem hapusPengeluaran) {
    listPengeluaranKeseluruhan.remove(hapusPengeluaran);
    notifyListeners();
    db.savedData(listPengeluaranKeseluruhan);
  }

  void updatePengeluaran(ExpenseItem updatedPengeluaran) {
    int index = listPengeluaranKeseluruhan.indexWhere((expense) => expense.id == updatedPengeluaran.id);
    if (index != -1) {
      listPengeluaranKeseluruhan[index] = updatedPengeluaran;
      notifyListeners();
      db.savedData(listPengeluaranKeseluruhan);
    }
  }

  String ambilHari(DateTime hari) {
    switch (hari.weekday) {
      case 1: return 'Sen';
      case 2: return 'Sel';
      case 3: return 'Rab';
      case 4: return 'Kam';
      case 5: return 'Jum';
      case 6: return 'Sab';
      case 7: return 'Min';
      default: return '';
    }
  }

  DateTime awalMingguHari() {
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (ambilHari(today.subtract(Duration(days: i))) == 'Sen') {
        return today.subtract(Duration(days: i));
      }
    }
    return today; 
  }

  Map<String, double> hitungPengeluaranHarian() {
    Map<String, double> rangkumanPengeluaranHarian = {};

    for (var pengeluaran in listPengeluaranKeseluruhan) {
      String tanggalData = convertDateTime(pengeluaran.tanggal).toString();
      double jumlah = double.parse(pengeluaran.jumlah);

      if (rangkumanPengeluaranHarian.containsKey(tanggalData)) {
        rangkumanPengeluaranHarian[tanggalData] = rangkumanPengeluaranHarian[tanggalData]! + jumlah;
      } else {
        rangkumanPengeluaranHarian[tanggalData] = jumlah;
      }
    }

    return rangkumanPengeluaranHarian;
  }
}
