import 'package:flutter/material.dart';
import 'package:banda_app/models/form.model.dart';
import 'package:banda_app/utils/text.utils.dart';

class TextOutput extends StatelessWidget {
  final String textOutputBody;
  final TextDesign textOutputStyle;

  const TextOutput({super.key, required this.textOutputBody, required this.textOutputStyle});

  @override
  Widget build(BuildContext context) {
    return Text(textOutputBody, style: textOutputStyle.style);
  }
}

class FormOutput extends StatelessWidget {
  final FormData testForm;
  const FormOutput({super.key, required this.testForm});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (var data in testForm.getData.entries) ...{
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextOutput(textOutputBody: data.key, textOutputStyle: TextDesign.header),
            TextOutput(textOutputBody: data.value, textOutputStyle: TextDesign.body),
            const SizedBox(height: 12)
          ],
        ),
      },
      const Divider(color: Colors.black, thickness: 2)
    ]);
  }
}
