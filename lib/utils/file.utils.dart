import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:banda_app/models/form.model.dart';

class DataEntry {
  late String type;
  late List<String> keys;
  late List<FormData> data;

  DataEntry({
    required this.type,
    required this.keys,
    required this.data,
  });

  DataEntry.fromMap({required Map test}) {
    type = test["type"];
    keys = test['keys'] as List<String>;
    data = test['data'] as List<FormData>;
  }

  @override
  String toString() {
    return "{\"type\": \"$type\", \"keys\": ${json.encode(keys)}, \"data\": ${data.toString()}}";
  }
}

class Storage {
  // Map<String, List<FormData>> data = {};
  List<DataEntry> data = <DataEntry>[];

  int getElement(String type) =>
      data.indexWhere((element) => element.type == type);

  void update(FormData newData) {
    if (getElement(newData.type) != -1) {
      data[getElement(newData.type)].data.add(newData);
    } else {
      data.add(
          DataEntry(type: newData.type, keys: newData.keys, data: [newData]));
    }
    // data.update(newData.type, ((previous) {
    //   previous.add(newData);
    //   return previous;
    // }), ifAbsent: (() => {newData}.toList()));

    write(newData.type);
  }

  set add(DataEntry test) => data.add(test);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;

    return File('$path/$fileName.obj');
  }

  Future<File> write(String fileName) async {
    final file = await _localFile(fileName);

    return file
        .writeAsBytes(utf8.encode(data[getElement(fileName)].toString()));
  }

  Future<dynamic> read(String fileName) async {
    try {
      final file = await _localFile(fileName);
      String fileContent = utf8.decode(await file.readAsBytes());

      Map filess = json.decode(fileContent);
      // data[fileName]

      // return filess.map<DataEntry>((value) => DataEntry(type: value, keys: keys, data: data));
      // .map<FormData>(
      //   (testValue) => FormData.from(
      //     type: fileName,
      //     newData: testValue,
      //     keys: testData,
      //   ),
      // )
      // .toList();

      return DataEntry(
          type: filess["type"],
          keys:
              (filess["keys"] as List).map<String>((e) => e as String).toList(),
          data: (filess["data"] as List)
              .map<FormData>(
                (e) => FormData.from(
                  type: fileName,
                  newData: e,
                  keys: testData,
                ),
              )
              .toList());
    } catch (error) {
      // return false;
      return [];
    }
  }
}
