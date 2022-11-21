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
    return "{\"type\": \"$type\", \"keys\": ${json.encode(keys)}, \"data\": ${data.toString()}}";
  }
}

class Storage {
  List<DataEntry> dataEntries = <DataEntry>[];

  int getEntryIndex(String type) => dataEntries.indexWhere((element) => element.type == type);

  set addNewEntry(DataEntry test) => dataEntries.add(test);

  void updateEntry(FormData newData, List<String> keys, String type) {
    var element = getEntryIndex(type);

    element != -1
        ? dataEntries[element].data.add(newData)
        : addNewEntry = DataEntry(type: type, keys: keys, data: [newData]);

    write(type);
  }

  Future<File> write(String fileName) async {
    final file = await _localFile(fileName);

    return file.writeAsBytes(utf8.encode(dataEntries[getEntryIndex(fileName)].toString()));
  }

  Future<DataEntry> read(String fileName) async {
    try {
      final file = await _localFile(fileName);
      String fileContent = utf8.decode(await file.readAsBytes());

      Map dataEntry = json.decode(fileContent);

      return DataEntry(
          type: dataEntry["type"],
          keys: (dataEntry["keys"] as List).map<String>((key) => key as String).toList(),
          data: (dataEntry["data"] as List)
              .map<FormData>(
                (data) => FormData.from(
                  newData: data,
                  keys: testData,
                ),
              )
              .toList());
    } catch (error) {
      return DataEntry.empty();
    }
  }
}
