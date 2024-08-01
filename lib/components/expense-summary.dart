import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hello_world/data/expense_data.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime awalMingu;
  const ExpenseSummary({super.key, required this.awalMingu});

  double calculateMax(
    ExpenseData value,
    String senin,
    String selasa,
    String rabu,
    String kamis,
    String jumat,
    String sabtu,
    String minggu
  ){
    double? max = 100000;

    List<double> values = [
      value.hitungPengeluaranHarian()[senin] ??0,
      value.hitungPengeluaranHarian()[selasa] ??0,
      value.hitungPengeluaranHarian()[rabu] ??0,
      value.hitungPengeluaranHarian()[kamis] ??0,
      value.hitungPengeluaranHarian()[jumat] ??0,
      value.hitungPengeluaranHarian()[sabtu] ??0,
      value.hitungPengeluaranHarian()[minggu] ??0,
    ];
    values.sort();
    max = values.last * 1.1;

    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
    ExpenseData value,
    String senin,
    String selasa,
    String rabu,
    String kamis,
    String jumat,
    String sabtu,
    String minggu
  ){
    List<double> values = [
      value.hitungPengeluaranHarian()[senin] ??0,
      value.hitungPengeluaranHarian()[selasa] ??0,
      value.hitungPengeluaranHarian()[rabu] ??0,
      value.hitungPengeluaranHarian()[kamis] ??0,
      value.hitungPengeluaranHarian()[jumat] ??0,
      value.hitungPengeluaranHarian()[sabtu] ??0,
      value.hitungPengeluaranHarian()[minggu] ??0,
    ];

    double total = 0;

    for(int i = 0; i < values.length; i++){
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  StringCalcMonthTotal(ExpenseData value, Map<String, double> dailyTotals){
    double total = 0;

    dailyTotals.forEach((day, amount){
      total += amount;
    });

    return total.toStringAsFixed(2);
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}