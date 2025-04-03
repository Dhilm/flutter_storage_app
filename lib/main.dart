import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/file_rw_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storage App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(), // Стартовая страница — логин
      routes: {
        '/signup': (context) => SignupPage(),
        '/file': (context) => FileRWPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}