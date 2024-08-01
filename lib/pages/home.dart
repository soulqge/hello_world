import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top:20),
            child: Center(
              child: Text(
                '${DateFormat('EEEE, MMMM, d, y').format(DateTime.now())}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.inversePrimary ),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButton: FloatingActionButton(
            onPressed: (){},
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            foregroundColor: Theme.of(context).colorScheme.background,
            child: Icon(Icons.add),
            ),
          body: Padding(
            padding: EdgeInsets.all(8),
            child: ListView(
              children: [
              
              ],
            ),
          ),
      )
    );
    
  }
}