import 'package:flutter/material.dart';
import 'package:banda_app/models/form.model.dart';
import 'package:banda_app/utils/text.utils.dart';

class TextOutput extends StatelessWidget {
  final String textOutputBody;
  final String textOutputStyle;

  const TextOutput(
      {Key? key, required this.textOutputBody, required this.textOutputStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(textOutputBody, style: textStyles[textOutputStyle]);
  }
}

class FormOutput extends StatelessWidget {
  final TestForm testForm;
  const FormOutput({Key? key, required this.testForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (var i in testForm.toJson().entries) ...{
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextOutput(textOutputBody: i.key, textOutputStyle: "Header"),
            TextOutput(textOutputBody: i.value, textOutputStyle: "Body"),
            const SizedBox(height: 12)
          ],
        ),
      }
    ]);
  }
}