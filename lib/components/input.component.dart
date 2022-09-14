import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:banda_app/components/output.component.dart';
import 'package:banda_app/components/button.component.dart';
import 'package:banda_app/utils/text.utils.dart';

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
        textCapitalization: textInputInformationTypes[inputType]
            ?.textCapitalization as TextCapitalization,
        inputFormatters: [
          textInputInformationTypes[inputType]?.textEditingFormatter
              as TextInputFormatter
        ],
        controller: textInputInformationTypes[inputType]?.textEditingController,
        validator: textInputInformationTypes[inputType]?.validator,
        keyboardType: textInputInformationTypes[inputType]?.textInputType,
        decoration: InputDecoration(
            labelText: inputName,
            labelStyle: textStyles["Body"],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.0),
              borderRadius: BorderRadius.circular(20),
            )),
      )),
      if (inputType == "date")
        DateOrTimeButton.date(
            textEditingController: textInputInformationTypes[inputType]
                ?.textEditingController as TextEditingController),
      if (inputType == "time")
        DateOrTimeButton.time(
            textEditingController: textInputInformationTypes[inputType]
                ?.textEditingController as TextEditingController)
    ]);
  }
}

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
  FormInput({Key? key, required this.formFields, this.context})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState? form = _formKey.currentState;

    ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
      content: form!.validate()
          ? const Text("Form is valid")
          : const Text("Form is invalid"),
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
