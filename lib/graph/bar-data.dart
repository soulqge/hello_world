import 'package:hello_world/graph/individual-bar.dart';

class BarData{
    final double jSen;
    final double jSel;
    final double jRab;
    final double jKam;
    final double jJum;
    final double jSab;
    final double jMin;

    BarData({required this.jSen, required this.jSel, required this.jRab, required this.jKam, required this.jJum, required this.jSab, required this.jMin});

    List<IndividualBar> barData = [];  

    //init
    void initBarData(){
      barData = [
        IndividualBar(x: 0, y: jSen),
        IndividualBar(x: 1, y: jSel),
        IndividualBar(x: 2, y: jRab),
        IndividualBar(x: 3, y: jKam),
        IndividualBar(x: 4, y: jJum),
        IndividualBar(x: 5, y: jSab),
        IndividualBar(x: 6, y: jMin),
      ];
    }
}
