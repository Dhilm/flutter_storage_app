import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Домашняя страница')),
      body: Center(
        child: Text('Добро пожаловать!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}