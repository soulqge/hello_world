import 'package:flutter/material.dart';
import 'package:hello_world/pages/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      if (username == 'al' && password == '310307') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 302,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.surface),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green
                                          ), // Change this to your desired color for focused state
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary)),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green
                                          ),
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.background),
                            ),
                            onPressed: _login,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
