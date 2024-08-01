import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/data/expense_data.dart';
import 'package:hello_world/graph/bar-graph-week.dart';
import 'package:hello_world/helper/convert-date.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime awalMinggu;
  const ExpenseSummary({super.key, required this.awalMinggu});

  double calculateMax(
    ExpenseData value, 
    String senin,
    String selasa,
    String rabu,
    String kamis,
    String jumat,
    String sabtu,
    String minggu,
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
    String minggu,
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

  String calculateMonthTotal(ExpenseData value, Map<String, double> dailyTotals){
  double total = 0;

  dailyTotals.forEach((day, amount) {
    total += amount;
  });

  return total.toStringAsFixed(2);
}


  @override
  Widget build(BuildContext context) {
    String senin = convertDateTime(awalMinggu.add(const Duration(days: 0)));
    String selasa = convertDateTime(awalMinggu.add(const Duration(days: 1)));
    String rabu = convertDateTime(awalMinggu.add(const Duration(days: 2)));
    String kamis = convertDateTime(awalMinggu.add(const Duration(days: 3)));
    String jumat = convertDateTime(awalMinggu.add(const Duration(days: 4)));
    String sabtu = convertDateTime(awalMinggu.add(const Duration(days: 5)));
    String minggu = convertDateTime(awalMinggu.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 25.0, bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                Text("Weekly Total: ", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.inversePrimary),),
                Text("\Rp. "+ calculateWeekTotal(value, senin, selasa, rabu, kamis, jumat, sabtu, minggu), style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                ],
            ),
          ),
          SizedBox(
            height: 200,
            child: BarGraph(
              maxY: 100000,
              jSen: value.hitungPengeluaranHarian()[senin] ?? 0, 
              jSel: value.hitungPengeluaranHarian()[selasa] ?? 0, 
              jRab: value.hitungPengeluaranHarian()[rabu] ?? 0, 
              jKam: value.hitungPengeluaranHarian()[kamis] ?? 0, 
              jJum: value.hitungPengeluaranHarian()[jumat] ?? 0, 
              jSab: value.hitungPengeluaranHarian()[sabtu] ?? 0, 
              jMin: value.hitungPengeluaranHarian()[minggu] ?? 0,
              ),
          ),
        ],
      ),
    );
  }
}