import 'package:flutter/material.dart';

class TextOutput extends StatelessWidget {
  final String textOutputBody;
  final String textOutputStyle;
  const TextOutput(this.textOutputBody, this.textOutputStyle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(textOutputBody, style: textStyles[textOutputStyle]);
  }
}

class Input extends StatelessWidget {
  final String inputName;
  final Icon inputIcon;
  final TextEditingController inputController;
  const Input(this.inputName, this.inputIcon, this.inputController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField();
  }
}

class TextInput extends Input {
  const TextInput(inputName, inputIcon, inputController, {Key? key}) : super(inputName, inputIcon, inputController, key:key);

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

