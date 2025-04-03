import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();

  void _signup(BuildContext context) async {
    if (_password.text == _confirm.text) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _username.text);
      await prefs.setString('password', _password.text);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _username, decoration: InputDecoration(labelText: 'Username')),
            TextField(controller: _password, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            TextField(controller: _confirm, decoration: InputDecoration(labelText: 'Confirm Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _signup(context), child: Text('Create Account')),
          ],
        ),
      ),
    );
  }
}