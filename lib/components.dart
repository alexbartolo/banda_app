import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextOutput extends StatelessWidget {
  final String textOutputBody;
  final String textOutputStyle;

  const TextOutput(this.textOutputBody, this.textOutputStyle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(textOutputBody, style: textStyles[textOutputStyle]);
  }
}

class TextInput extends StatelessWidget {
  final String inputName;
  // final Icon inputIcon;
  final String inputType;

//this.inputIcon,
  const TextInput(this.inputName, this.inputType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [textInputInformation[inputType]!.textEditingFormatter],
      controller: textInputInformation[inputType]!.textEditingController,
      keyboardType: textInputInformation[inputType]!.textInputType,
      decoration: InputDecoration(
        labelText: inputName
      ),
    );
  }
}

const Map<String, TextStyle> textStyles = {
  "Page Title": TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
  "Title": TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
  "Subtitle": TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
  "Body": TextStyle(fontSize: 24),
  "Selected List Item": TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  "Unselected List Item": TextStyle(fontSize: 28),
  "Button": TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
};

class TextInputInformation {
  final TextInputType textInputType;
  final TextEditingController textEditingController = TextEditingController();
  late final TextInputFormatter textEditingFormatter;

  TextInputInformation.withFormatter(this.textInputType, this.textEditingFormatter);
  TextInputInformation.withoutFormatter(this.textInputType) {textEditingFormatter = MaskTextInputFormatter();}
}

Map<String, TextInputInformation> textInputInformation = {
  "date": TextInputInformation.withFormatter(TextInputType.datetime, MaskTextInputFormatter(mask: "##/##/####", filter: { "#": RegExp(r'[0-9]')})),
  "time": TextInputInformation.withFormatter(TextInputType.datetime, MaskTextInputFormatter(mask: "##:##", filter: { "#": RegExp(r'[0-9]')})),
  "email": TextInputInformation.withoutFormatter(TextInputType.emailAddress),
  "phone": TextInputInformation.withoutFormatter(TextInputType.phone),
  "name": TextInputInformation.withoutFormatter(TextInputType.name), //check
  "normal": TextInputInformation.withoutFormatter(TextInputType.text)
};
