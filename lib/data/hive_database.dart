
import 'dart:math';

import 'package:hello_world/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase{
  final _myBox = Hive.box("expense_database");

  void savedData(List<ExpenseItem> allExpense){
    
    List<List<dynamic>> allExpensesFormated = [];


    //Convert To List
    for (var expense in allExpense){
      List<dynamic> expenseFormatted = [
        expense.nama,
        expense.jumlah,
        expense.tanggal
      ];
      allExpensesFormated.add(expenseFormatted);
    }

    _myBox.put("ALL_EXPENSES", allExpensesFormated);

  }

  //Read Data
  List<ExpenseItem> readData(){
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for(int i = 0; i < savedExpenses.length; i++){
      String nama = savedExpenses [i][0];
      String jumlah = savedExpenses [i][1];
      DateTime tanggal = savedExpenses [i][2];

      ExpenseItem expense = ExpenseItem(
        nama: nama, 
        jumlah: jumlah, 
        tanggal: tanggal
      );

      allExpenses.add(expense);
    }

    return allExpenses;
  }
}