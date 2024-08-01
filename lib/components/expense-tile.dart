import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class ExpenseTile extends StatelessWidget {
  final String nama;
  final String jumlah;
  final DateTime tanggal;
  void Function(BuildContext)? deleteTapped;
  void Function(BuildContext)? editTapped;

  ExpenseTile({super.key, required this.nama, required this.jumlah, required this.tanggal, required this.deleteTapped, required this.editTapped});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(), 
        children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(4),
            padding: EdgeInsets.all(8),
          ),
          SizedBox(width: 10,),
          SlidableAction(
            onPressed: editTapped,
            icon: Icons.edit,
            backgroundColor: Colors.grey,
            borderRadius: BorderRadius.circular(4),
            padding: EdgeInsets.all(8),
          ),
        ]
      ),
      child: ListTile(
        title: Text(nama,
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        subtitle: Text(tanggal.day.toString() + "/" + tanggal.month.toString() + "/" + tanggal.year.toString(),
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        trailing: Text('Rp. ' + jumlah,
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary) ,
        ),
      ),
    );
  }
}