import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вход')),
      body: Center(
        child: ElevatedButton(
          child: Text('Войти'),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
    );
  }
}