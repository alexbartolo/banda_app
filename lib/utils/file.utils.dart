import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:banda_app/models/form.model.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> _localFile(String fileName) async {
  final path = await _localPath;

  return File('$path/$fileName.obj');
}

class DataEntry {
  late String type;
  late List<String> keys;
  late List<FormData> data;

  DataEntry({
    required this.type,
    required this.keys,
    required this.data,
  });

  DataEntry.empty();

  @override
  String toString() {
    return '{"type": "$type", "keys": ${json.encode(keys)}, "data": ${data.toString()}}';
  }
}

class Storage {
  List<DataEntry> dataEntries = <DataEntry>[];

  int getEntryIndex(String type) =>
      dataEntries.indexWhere((entry) => entry.type == type);

  set addNewEntry(DataEntry dataEntry) => dataEntries.add(dataEntry);

  void updateEntry(FormData newData, List<String> keys, String type) {
    var entryIndex = getEntryIndex(type);

    entryIndex != -1
        ? dataEntries[entryIndex].data.add(newData)
        : addNewEntry = DataEntry(type: type, keys: keys, data: [newData]);

    write(type);
  }

  Future<File> write(String fileName) async {
    final file = await _localFile(fileName);

    return file.writeAsBytes(
        utf8.encode(dataEntries[getEntryIndex(fileName)].toString()));
  }

  Future<DataEntry> read(String fileName) async {
    try {
      final file = await _localFile(fileName);
      String fileContent = utf8.decode(await file.readAsBytes());

      Map dataEntry = json.decode(fileContent);
      List<String> keys = (dataEntry["keys"] as List)
          .map<String>((key) => key as String)
          .toList();

      return DataEntry(
          type: dataEntry["type"],
          keys: keys,
          data: (dataEntry["data"] as List).map<FormData>((data) => FormData.from(newData: data, keys: keys)).toList());
    } catch (error) {
      return DataEntry.empty();
    }
  }
}
