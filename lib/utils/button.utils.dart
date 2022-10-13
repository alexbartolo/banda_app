import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future dateButtonAction(BuildContext context) async {
  return DateFormat('dd/MM/yyy').format(await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1, 12, 31)) as DateTime);
}

Future timeButtonAction(BuildContext context) async {
  return (await showTimePicker(context: context, initialTime: TimeOfDay.now()))?.format(context) as String;
}
