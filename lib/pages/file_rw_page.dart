import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileRWPage extends StatefulWidget {
  @override
  _FileRWPageState createState() => _FileRWPageState();
}

class _FileRWPageState extends State<FileRWPage> {
  String _data = '';

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/test.txt';
  }

  Future<void> _writeToFile(String text) async {
    final path = await _getFilePath();
    final file = File(path);
    await file.writeAsString(text);
  }

  Future<void> _readFromFile() async {
    final path = await _getFilePath();
    final file = File(path);
    String content = await file.readAsString();
    setState(() {
      _data = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Read/Write')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _writeToFile("Hello: ${DateTime.now()}"),
              child: Text('Write to File'),
            ),
            ElevatedButton(
              onPressed: _readFromFile,
              child: Text('Read from File'),
            ),
            SizedBox(height: 20),
            Text(_data, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}