import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/input.component.dart';
import 'global.utils.dart';

enum ButtonType {
  reset(resetScreen),
  adjust(adjustScreen),
  openFullScreen(fullScreen),
  openModalScreen(modalScreen),
  save(saveData);

  const ButtonType(this.function);
  final Function function;
}

Future dateButtonAction(BuildContext context) async {
  return DateFormat('dd/MM/yyy').format(await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1, 12, 31)) as DateTime);
}

Future timeButtonAction(BuildContext context) async {
  return (await showTimePicker(context: context, initialTime: TimeOfDay.now()))
      ?.format(context) as String;
}

void adjustScreen(Map parameters) {
  print("Hello World!");
}

void fullScreen(Map parameters) {
  Navigator.push(parameters['context'],
      MaterialPageRoute(builder: (context) => parameters['screen']));
}

void modalScreen(Map parameters) {
  showModalBottomSheet(
      context: parameters['context'],
      builder: (context) => parameters['screen']);
}

void resetScreen(Map parameters) {
  final FormState? form = parameters['formKey'].currentState;
  form!.reset();
  for (var element in parameters['formFields']) {
    if (element is RadioInput)
      (element.key as GlobalKey<RadioInputState>).currentState?.reset();
    if (element is CheckboxInput)
      (element.key as GlobalKey<CheckboxInputState>).currentState?.reset();
  }
}

void saveData(Map parameters) {
  final FormState? form = parameters['formKey'].currentState;

  if (form!.validate()) {
    form.save();
    storage.updateEntry(
        parameters['data'], parameters['keys'], parameters['type']);
  }
}
