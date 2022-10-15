import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:banda_app/utils/validations.utils.dart';

const Map<String, TextStyle> textStyles = {
  "Page Title": TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
  "Title": TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
  "Subtitle": TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
  "Header": TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
  "Body": TextStyle(fontSize: 24),
  "Selected List Item": TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  "Unselected List Item": TextStyle(fontSize: 24),
  "Button": TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
};

class TextInputInformation {
  final TextInputType textInputType;
  TextInputFormatter? textEditingFormatter;
  TextCapitalization? textCapitalization;
  final String? Function(String?)? validator;

  TextInputInformation.number(
      {required this.textInputType, required this.textEditingFormatter, required this.validator}) {
    textCapitalization = TextCapitalization.none;
  }

  TextInputInformation.string({required this.textInputType, required this.textCapitalization, this.validator}) {
    textEditingFormatter = MaskTextInputFormatter();
  }
}

Map<String, TextInputInformation> textInputInformationTypes = {
  "date": TextInputInformation.number(
      textInputType: TextInputType.datetime,
      textEditingFormatter: MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')}),
      validator: validateDate),
  "time": TextInputInformation.number(
      textInputType: TextInputType.datetime,
      textEditingFormatter: MaskTextInputFormatter(mask: "##:##", filter: {"#": RegExp(r'[0-9]')}),
      validator: validateTime),
  "phone": TextInputInformation.number(
      textInputType: TextInputType.phone,
      textEditingFormatter: MaskTextInputFormatter(mask: "########", filter: {"#": RegExp(r'[0-9]')}),
      validator: validatePhone),
  "email": TextInputInformation.string(
      textInputType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none, validator: validateEmail),
  "name": TextInputInformation.string(textInputType: TextInputType.name, textCapitalization: TextCapitalization.words),
  "normal":
      TextInputInformation.string(textInputType: TextInputType.text, textCapitalization: TextCapitalization.sentences)
};
