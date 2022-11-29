import 'package:flutter/material.dart';
import 'package:banda_app/utils/validations.utils.dart';

enum TextDesign {
  pageTitle(TextStyle(fontSize: 48, fontWeight: FontWeight.w700)),
  title(TextStyle(fontSize: 40, fontWeight: FontWeight.w600)),
  subtitle(TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
  header(TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
  body(TextStyle(fontSize: 24)),
  selectedListItem(TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  unselectedListItem(TextStyle(fontSize: 24)),
  button(TextStyle(fontSize: 24, fontWeight: FontWeight.bold));

  const TextDesign(this.style);
  final TextStyle style;
}

enum InputType {
  date.number(textInputType: TextInputType.datetime, textEditingMask: "##/##/####", validator: validateDate),
  time.number(textInputType: TextInputType.datetime, textEditingMask: "##:##", validator: validateTime),
  phone.number(textInputType: TextInputType.phone, textEditingMask: "########", validator: validatePhone),
  email.string(textInputType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none, validator: validateEmail),
  name.string(textInputType: TextInputType.name, textCapitalization: TextCapitalization.words, validator: validateName),
  text.string(textInputType: TextInputType.text, textCapitalization: TextCapitalization.sentences, validator: validateText);

  const InputType.number({required this.textInputType, required this.textEditingMask, required this.validator, this.textCapitalization = TextCapitalization.none});
  const InputType.string({required this.textInputType, required this.textCapitalization, required this.validator, this.textEditingMask = ""});

  final TextInputType textInputType;
  final String textEditingMask;
  final TextCapitalization? textCapitalization;
  final String? Function(String?) validator;
}
