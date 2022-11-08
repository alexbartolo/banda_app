import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:banda_app/components/output.component.dart';
import 'package:banda_app/components/button.component.dart';
import 'package:banda_app/models/form.model.dart';
import 'package:banda_app/utils/button.utils.dart';
import 'package:banda_app/utils/text.utils.dart';
import 'package:banda_app/utils/validations.utils.dart';

class Input {
  late final FormData data;

  set update(FormData updatedData) => data = updatedData;
}

class TextInput extends StatelessWidget with Input {
  final String inputName;
  final String inputType;
  final Icon? inputIcon;
  late final TextEditingController _textEditingController;
  late final TextInputInformation _textInputInformation;

  TextInput({super.key, required this.inputName, required this.inputType, this.inputIcon}) {
    _textEditingController = TextEditingController();
    _textInputInformation = textInputInformationTypes[inputType] as TextInputInformation;
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: inputIcon,
            labelText: inputName,
            labelStyle: textStyles["Body"],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 0.0),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          controller: _textEditingController,
          keyboardType: _textInputInformation.textInputType,
          textCapitalization: _textInputInformation.textCapitalization as TextCapitalization,
          inputFormatters: [_textInputInformation.textEditingFormatter as TextInputFormatter],
          validator: _textInputInformation.validator,
          onSaved: (newValue) {
            data.update = {inputName: newValue};
          },
        ),
      ),
      if (inputType == "date") DateButton(textEditingController: _textEditingController),
      if (inputType == "time") TimeButton(textEditingController: _textEditingController)
    ]);
  }
}

class CheckboxInput extends StatefulWidget with Input {
  static final GlobalKey<CheckboxInputState> _key = GlobalKey<CheckboxInputState>();
  final String checkboxName;

  CheckboxInput({required this.checkboxName}) : super(key: _key);

  @override
  State<CheckboxInput> createState() => CheckboxInputState();
}

class CheckboxInputState extends State<CheckboxInput> {
  bool _value = false;

  void reset() {
    setState(() => _value = false);
  }

  @override
  Widget build(BuildContext context) {
    widget.data.update = {widget.checkboxName: "false"};
    return Container(
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: CheckboxListTile(
        title: TextOutput(
          textOutputBody: widget.checkboxName,
          textOutputStyle: _value ? "Selected List Item" : "Unselected List Item",
        ),
        controlAffinity: ListTileControlAffinity.leading,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        value: _value,
        onChanged: (bool? value) {
          setState(() => _value = value as bool);
          widget.data.update = {widget.checkboxName: value.toString()};
        },
      ),
    );
  }
}

class DropdownInput extends StatefulWidget with Input {
  final String dropdownName;
  final Icon? dropdownIcon;
  final List<String> dropdownOptions;

  DropdownInput({super.key, required this.dropdownName, required this.dropdownOptions, this.dropdownIcon});

  @override
  State<DropdownInput> createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  // FocusNode? node;

  //TODO: Check how to move items below field, and how to unfocus in case of pressing somewhere else other than item list

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 62,
      child: DropdownButtonFormField(
        borderRadius: BorderRadius.circular(20),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.0),
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: widget.dropdownIcon,
          label: TextOutput(textOutputBody: widget.dropdownName, textOutputStyle: "Body"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        items: widget.dropdownOptions
            .map((String option) => DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
        onChanged: (value) => {}, //required, but not needed
        onSaved: (newValue) => widget.data.update = {widget.dropdownName: newValue as String},
        validator: validateDropdown,
        alignment: Alignment.bottomCenter,
      ),
    );
  }
}

class RadioInput extends StatefulWidget with Input {
  //combine
  final List<String> radioOptions;
  final List<Icon> radioIcons;

  late final String? defaultRadioOption;

  static final GlobalKey<RadioInputState> _key = GlobalKey();

  RadioInput({required this.radioOptions, required this.radioIcons, this.defaultRadioOption}) : super(key: _key) {
    defaultRadioOption ??= radioOptions[0];
  }

  @override
  State<RadioInput> createState() => RadioInputState();
}

class RadioInputState extends State<RadioInput> {
  String chosenRadioValue = "";

  void reset() {
    setState(() => chosenRadioValue = widget.defaultRadioOption as String);
  }

  @override
  void initState() {
    super.initState();
    chosenRadioValue = widget.defaultRadioOption as String;
  }

  void updateRadioValue(String newRadioValue) {
    setState(() {
      chosenRadioValue = newRadioValue;
      widget.data.update = {"radio": chosenRadioValue};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.radioOptions.length; i++) ...{
          RadioOption(
            radioTitle: widget.radioOptions[i],
            radioIcon: widget.radioIcons[i],
            chosenRadio: chosenRadioValue,
            updateRadio: updateRadioValue,
          ),
          const SizedBox(height: 12)
        }
      ],
    );
  }
}

class RadioOption extends StatefulWidget {
  final String radioTitle;
  final Icon radioIcon;
  final String chosenRadio;
  final void Function(String) updateRadio;

  const RadioOption(
      {super.key,
      required this.radioTitle,
      required this.radioIcon,
      required this.chosenRadio,
      required this.updateRadio});

  @override
  State<RadioOption> createState() => RadioOptionState();
}

class RadioOptionState extends State<RadioOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: ListTile(
          title: TextOutput(textOutputBody: widget.radioTitle, textOutputStyle: "Body"),
          leading: widget.radioIcon,
          trailing: widget.radioTitle == widget.chosenRadio
              ? const Icon(Icons.check_circle, color: Colors.blue)
              : const Icon(Icons.radio_button_unchecked),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onTap: () => widget.updateRadio(widget.radioTitle),
        ));
  }
}

class FormInput extends StatelessWidget {
  late final FormData data;

  late final List formFields;
  late final ButtonGroup buttons;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FormInput({super.key, required this.formFields, required this.buttons}) {
    data = FormData.empty(keys: testData);
    for (var formField in formFields) {
      formField.update = data;
    }
  }

  set updateFormFields(List updatedFormFields) {
    formFields = updatedFormFields;
  }

  void addFunctions(BuildContext context) {
    for (Button button in buttons.buttons) {
      button.addParameters({"context": context, "formKey": _formKey, "formFields": formFields, "data": data});
      button.addFunction = () => buttonFunctions[button.buttonType]!(button.buttonActionParameters);
    }
  }


  @override
  Widget build(BuildContext context) {
    addFunctions(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var formField in formFields) ...{
            formField,
            const SizedBox(height: 12)
          },
          buttons
        ],
      ),
    );
  }
}
