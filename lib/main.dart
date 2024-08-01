import 'package:flutter/material.dart';
import 'package:hello_world/data/expense_data.dart';
import 'package:hello_world/pages/home.dart';
import 'package:hello_world/splash/splash.dart';
import 'package:hello_world/theme/theme-provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';


void main() async {
  await Hive.initFlutter();

  await Hive.openBox("expense_database");

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ExpenseData()),
      ChangeNotifierProvider(create: (context) => ThemeProvider())
    ],
    child: Builder(
      builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          initialRoute: '/home',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          routes: {
            '/splash': (context) => SplashScreen(),
            '/home': (context) => Home()
          },
        );
      },
    ),
    )
  );
}



