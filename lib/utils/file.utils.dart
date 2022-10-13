import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;

    return File('$path/$fileName.obj');
  }

  Future<File> write(String data, String fileName) async {
    final file = await _localFile(fileName);

    return file.writeAsBytes(utf8.encode(data));
  }

  Future<String> read(String fileName) async {
    try {
      final file = await _localFile(fileName);

      return utf8.decode(await file.readAsBytes());
    } catch (error) {
      return "[]";
    }
  }
}
