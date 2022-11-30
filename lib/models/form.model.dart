import 'dart:convert';

import 'package:flutter_guid/flutter_guid.dart';

class FormData {
  late Guid id;
  late Map<String, dynamic> data;

  FormData.empty() {
    data = {};
  }

  FormData.from({required Map<String, dynamic> newData, required List<String> keys}) {
    bool validFlag = true;

    for (var key in newData.keys) {
      if (!keys.contains(key)) validFlag = false;
    }

    if (validFlag) data = newData;
    id = Guid.newGuid;
  }

  set update(Map<String, dynamic> newDataEntries) {
    newDataEntries.forEach((key, value) {
      data[key] = value;
    });
  }

  Map<String, dynamic> get getData => data;

  @override
  String toString() => json.encode(data);
}

List<String> testData = ["name", "text", "phone", "time", "date", "email", "checkbox", "dropdown", "radio"];
