import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUser = prefs.getString('username');
    String? savedPass = prefs.getString('password');

    if (_username.text == savedUser && _password.text == savedPass) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful!')));
      Navigator.pushNamed(context, '/file');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _username, decoration: InputDecoration(labelText: 'Username')),
            TextField(controller: _password, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _login(context), child: Text('Login')),
            TextButton(onPressed: () => Navigator.pushNamed(context, '/signup'), child: Text('Sign Up')),
          ],
        ),
      ),
    );
  }
}