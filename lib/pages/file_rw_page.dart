import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileRWPage extends StatefulWidget {
  const FileRWPage({Key? key}) : super(key: key);

  @override
  _FileRWPageState createState() => _FileRWPageState();
}

class _FileRWPageState extends State<FileRWPage> {
  String _data = '';
  final TextEditingController _controller = TextEditingController();
  File? _file;

  @override
  void initState() {
    super.initState();
    _initFile(); // запускаем при старте
  }

  Future<void> _initFile() async {
    final dir = await getApplicationDocumentsDirectory(); // 📁 Android/data/.../files
    final file = File('${dir.path}/test.txt');
    setState(() {
      _file = file;
    });
    _readFromFile(); // сразу читаем
  }

  Future<void> _writeToFile(String text) async {
    if (_file == null) return;
    await _file!.writeAsString(text);
    _controller.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Сохранено в test.txt')),
    );
  }

  Future<void> _readFromFile() async {
    if (_file == null) return;
    if (await _file!.exists()) {
      final content = await _file!.readAsString();
      setState(() {
        _data = content;
      });
    } else {
      setState(() {
        _data = 'Файл не найден';
      });
    }
  }

  Future<void> _clearFile() async {
    if (_file == null) return;
    await _file!.writeAsString('');
    setState(() {
      _data = '';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🧹 Файл очищен')),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Файл через path_provider'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Введите текст',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _writeToFile(_controller.text),
                    child: const Text('💾 Сохранить'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _readFromFile,
                    child: const Text('📖 Прочитать'),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Очистить файл',
                  onPressed: _clearFile,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Содержимое файла:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _data.isNotEmpty ? _data : 'Файл пуст',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}