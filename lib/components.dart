import 'package:banda_app/models/form.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'validations.dart';

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

class TextInput extends StatelessWidget {
  //TODO: Add possible icon?
  final String inputName;
  final String inputType;

  const TextInput({Key? key, required this.inputName, required this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: TextFormField(
        textCapitalization: textInputInformation[inputType]?.textCapitalization
            as TextCapitalization,
        inputFormatters: [
          textInputInformation[inputType]?.textEditingFormatter
              as TextInputFormatter
        ],
        controller: textInputInformation[inputType]?.textEditingController,
        validator: textInputInformation[inputType]?.validator,
        keyboardType: textInputInformation[inputType]?.textInputType,
        decoration: InputDecoration(
            labelText: inputName,
            labelStyle: textStyles["Body"],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.0),
              borderRadius: BorderRadius.circular(20),
            )),
      )),
      if (inputType == "date" || inputType == "time")
        dateOrTimeButton(
            context: context,
            type: inputType,
            textEditingController: textInputInformation[inputType]
                ?.textEditingController as TextEditingController)
    ]);
  }
}

Widget dateOrTimeButton(
    {required BuildContext context,
    required String type,
    required TextEditingController textEditingController}) {
  return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SizedBox(
          height: 62,
          width: 62,
          child: IconButton(
              onPressed: () async {
                switch (type) {
                  case "date":
                    textEditingController.text = DateFormat('dd/MM/yyy').format(
                        await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime(DateTime.now().year + 1, 12, 31))
                            as DateTime);
                    break;

                  case "time":
                    textEditingController.text = (await showTimePicker(
                            context: context, initialTime: TimeOfDay.now()))
                        ?.format(context) as String;
                    break;
                }
              },
              style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  side: const BorderSide(color: Colors.grey)),
              icon: type == "date"
                  ? const Icon(Icons.calendar_month)
                  : const Icon(Icons.access_time_filled))));
}

const Map<String, TextStyle> textStyles = {
  "Page Title": TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
  "Title": TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
  "Subtitle": TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
  "Body": TextStyle(fontSize: 24),
  "Selected List Item": TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  "Unselected List Item": TextStyle(fontSize: 24),
  "Button": TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
};

class TextInputInformation {
  final TextInputType textInputType;
  TextInputFormatter? textEditingFormatter;
  TextCapitalization? textCapitalization;
  TextEditingController textEditingController = TextEditingController();
  final String? Function(String?)? validator;

  TextInputInformation.number(
      {required this.textInputType,
      required this.textEditingFormatter,
      required this.validator}) {
    textCapitalization = TextCapitalization.none;
  }

  TextInputInformation.string(
      {required this.textInputType,
      required this.textCapitalization,
      this.validator}) {
    textEditingFormatter = MaskTextInputFormatter();
  }
}

Map<String, TextInputInformation> textInputInformation = {
  "date": TextInputInformation.number(
      textInputType: TextInputType.datetime,
      textEditingFormatter: MaskTextInputFormatter(
          mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')}),
      validator: validateDate),
  "time": TextInputInformation.number(
      textInputType: TextInputType.datetime,
      textEditingFormatter: MaskTextInputFormatter(
          mask: "##:##", filter: {"#": RegExp(r'[0-9]')}),
      validator: validateTime),
  "phone": TextInputInformation.number(
      textInputType: TextInputType.phone,
      textEditingFormatter: MaskTextInputFormatter(
          mask: "########", filter: {"#": RegExp(r'[0-9]')}),
      validator: validatePhone),
  "email": TextInputInformation.string(
      textInputType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      validator: validateEmail),
  "name": TextInputInformation.string(
      textInputType: TextInputType.name,
      textCapitalization: TextCapitalization.words),
  "normal": TextInputInformation.string(
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences)
};

class CheckboxInput extends StatefulWidget {
  final String checkboxName;
  const CheckboxInput({Key? key, required this.checkboxName}) : super(key: key);

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

class _CheckboxInputState extends State<CheckboxInput> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: CheckboxListTile(
          title: TextOutput(
              textOutputBody: widget.checkboxName,
              textOutputStyle:
                  _value ? "Selected List Item" : "Unselected List Item"),
          controlAffinity: ListTileControlAffinity.leading,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onChanged: (bool? value) {
            setState(() => _value = value as bool);
          },
          value: _value,
        ));
  }
}

class DropdownInput extends StatefulWidget {
  final String dropdownName;
  final List<String> dropdownOptions;

  const DropdownInput(
      {Key? key, required this.dropdownName, required this.dropdownOptions})
      : super(key: key);

  @override
  State<DropdownInput> createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  String? _selectedDropdownOption;
  FocusNode? node;

  //TODO: Check how to move items below field, and how to unfocus in case of pressing somewhere else other than item list

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 62,
        child: DropdownButtonFormField(
          borderRadius: BorderRadius.circular(20),
          decoration: InputDecoration(
            label: TextOutput(
                textOutputBody: widget.dropdownName, textOutputStyle: "Body"),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.0),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          items: widget.dropdownOptions
              .map((String option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: (value) => setState(() => (value as String).isNotEmpty
              ? _selectedDropdownOption = value
              : null),
          alignment: Alignment.bottomCenter,
          value: _selectedDropdownOption,
        ));
  }
}

class FormInput extends StatelessWidget {
  final List formFields;
  final BuildContext? context;
  FormInput({Key? key, required this.formFields, this.context}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState? form = _formKey.currentState;

    ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
      content: form!.validate() ? const Text("Form is valid") : const Text("Form is invalid"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var formField in formFields) ...{
            formField,
            const SizedBox(height: 12)
          },
          TextButton(
            onPressed: validateAndSave,
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}

class FormOutput extends StatelessWidget {
  final TestForm testForm;
  const FormOutput({Key? key, required this.testForm}): super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

}

class SecondaryButton extends StatelessWidget {
  final String buttonName;

  const SecondaryButton({Key? key, required this.buttonName}) : super(key: key);

  //TODO: Add function for onPressed as parameter?
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 4),
        child: SizedBox(
            height: 48,
            child: OutlinedButton(
                onPressed: () => {},
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                    padding: const EdgeInsets.only(left: 24, right: 24)),
                child: TextOutput(
                    textOutputBody: buttonName, textOutputStyle: "Button"))));
  }
}

class PrimaryButton extends StatelessWidget {
  final String buttonName;

  const PrimaryButton({Key? key, required this.buttonName}) : super(key: key);

  //TODO: Add function for onPressed as parameter?
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 4),
        child: SizedBox(
            height: 48,
            child: ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.only(left: 24, right: 24)),
                child: TextOutput(
                    textOutputBody: buttonName, textOutputStyle: "Button"))));
  }
}

class ButtonGroup extends StatelessWidget {
  final List buttons;

  const ButtonGroup({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          for (var button in buttons) ...{button}
        ]);
  }
}
