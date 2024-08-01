import 'package:hello_world/theme/theme-provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/navbar/navbar.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.center,
              child: Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Theme.of(context).colorScheme.inversePrimary
            ),
          )),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Align(
        alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 380,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.nightlight_round,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Night Mode", style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary),),
                                        Text("Change Application Theme", style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary),),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Switch(
                                      value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, 
                                      onChanged: (value) =>  Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                                      activeColor: Colors.grey,
                                      inactiveTrackColor: Colors.white,
                                      inactiveThumbColor: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      height: 128 ,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        children: [
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Theme.of(context).colorScheme.surface,
                          shadowColor: Colors.transparent,
                          child: InkWell(
                            hoverColor: Colors.black,
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/about');
                            },
                            child: Container(
                              color: Theme.of(context).colorScheme.surface,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.lightbulb_outline, color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("About App",
                                        style: TextStyle(decoration: TextDecoration.none, color: Theme.of(context)
                                                    .colorScheme
                                                    .inversePrimary),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.inversePrimary)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Theme.of(context).colorScheme.surface,
                          shadowColor: Colors.transparent,
                          child: InkWell(
                            hoverColor: Colors.black,
                            onTap: () {
                              SystemNavigator.pop();
                            },
                            child: Container(
                              color: Theme.of(context).colorScheme.surface,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.logout, color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Exit App",
                                        style: TextStyle(decoration: TextDecoration.none, color: Theme.of(context)
                                                    .colorScheme
                                                    .inversePrimary),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Icon(Icons.keyboard_arrow_right, color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        
      ),
      bottomNavigationBar: BottomNav(selectedItem: 1),
    );
  }
}
