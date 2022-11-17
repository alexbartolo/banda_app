import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/input.component.dart';
import '../models/form.model.dart';
import 'global.utils.dart';

enum ButtonType { reset, adjust, openFullScreen, openModalScreen, save }

Map<ButtonType, Function> buttonFunctions = {
  ButtonType.adjust: adjust,
  ButtonType.openFullScreen: openFullScreen,
  ButtonType.openModalScreen: openModalScreen,
  ButtonType.reset: resetScreen,
  ButtonType.save: save
};

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

void adjust(Map parameters) {
  print("Hello World!");
}

void openFullScreen(Map parameters) {
  Navigator.push(parameters['context'],
      MaterialPageRoute(builder: (context) => parameters['screen']));
}

void openModalScreen(Map parameters) {
  showModalBottomSheet(
      context: parameters['context'],
      builder: (context) => parameters['screen']);
}

void resetScreen(Map parameters) {
  final FormState? form = parameters['formKey'].currentState;
  form!.reset();
  for (var element in parameters['formFields']) {
    if (element is RadioInput) (element.key as GlobalKey<RadioInputState>).currentState?.reset();
    if (element is CheckboxInput) (element.key as GlobalKey<CheckboxInputState>).currentState?.reset();
  }
}

void save(Map parameters) {
  final FormState? form = parameters['formKey'].currentState;

  if (form!.validate()) {
    form.save();
    storage.update(parameters['data']);
  }
}
