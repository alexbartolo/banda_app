import 'dart:convert';

class FormData {
  final String type;
  final List<String> keys;
  late Map<String, dynamic> data;

  FormData.empty({required this.type, required this.keys}) {
    data = {};
  }

  FormData.from({required this.type, required Map<String, dynamic> newData, required this.keys}) {
    bool validFlag = true;

    for (var key in newData.keys) {
      if (!keys.contains(key)) validFlag = false;
    }

    if (validFlag) data = newData;
  }

  set update(Map<String, dynamic> newDataEntries) {
    newDataEntries.forEach((key, value) {
      if (keys.contains(key)) {
        data[key] = value;
      }
    });
  }

  Map<String, dynamic> get getData => data;

  @override
  String toString() => json.encode(data);
}

List<String> testData = ["name", "text", "phone", "time", "date", "email", "checkbox", "dropdown", "radio"];
