import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'validations.dart';

class TextOutput extends StatelessWidget {
  final String textOutputBody;
  final String textOutputStyle;

  const TextOutput(this.textOutputBody, this.textOutputStyle, {Key? key})
      : super(key: key);

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
      textCapitalization: textInputInformation[inputType]!.textCapitalization,
      inputFormatters: [textInputInformation[inputType]!.textEditingFormatter],
      validator: textInputInformation[inputType]!.validator,
      // controller: textInputInformation[inputType]!.textEditingController,
      keyboardType: textInputInformation[inputType]!.textInputType,
      decoration: InputDecoration(
          labelText: inputName,
          labelStyle: textStyles["Body"],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.0),
            borderRadius: BorderRadius.circular(20),
          )),
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
  "Button": TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
  "test": TextStyle(fontSize: 24)
};

class TextInputInformation {
  final TextInputType textInputType;
  // final TextEditingController textEditingController = TextEditingController();
  late final TextInputFormatter textEditingFormatter;
  late final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;

  TextInputInformation.number(this.textInputType, this.textEditingFormatter,
      [this.validator]) {
    textCapitalization = TextCapitalization.none;
  }
  TextInputInformation.string(this.textInputType, this.textCapitalization,
      [this.validator]) {
    textEditingFormatter = MaskTextInputFormatter();
  }
}

Map<String, TextInputInformation> textInputInformation = {
  "date": TextInputInformation.number(
      TextInputType.datetime,
      MaskTextInputFormatter(
          mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')}),
      validateDate),
  "time": TextInputInformation.number(
      TextInputType.datetime,
      MaskTextInputFormatter(mask: "##:##", filter: {"#": RegExp(r'[0-9]')}),
      validateTime),
  "phone": TextInputInformation.number(
      TextInputType.phone,
      MaskTextInputFormatter(mask: "########", filter: {"#": RegExp(r'[0-9]')}),
      validatePhone),
  "email": TextInputInformation.string(
      TextInputType.emailAddress, TextCapitalization.none, validateEmail),
  "name":
      TextInputInformation.string(TextInputType.name, TextCapitalization.words),
  "normal": TextInputInformation.string(
      TextInputType.text, TextCapitalization.sentences)
};

class CheckboxInput extends StatefulWidget {
  final String checkboxName;
  const CheckboxInput(this.checkboxName, {Key? key}) : super(key: key);

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
          title: TextOutput(widget.checkboxName, "Body"),
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
  final List<String> dropdownOptions;

  const DropdownInput(this.dropdownOptions, {Key? key}) : super(key: key);

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
        // child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          borderRadius: BorderRadius.circular(20),
          decoration: InputDecoration(
            label: const TextOutput("dropdown", "test"),
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
  FormInput(this.formFields, {Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
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

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => print("test"),
        // style: ButtonStyle(
        // shape: OutlineBorder(borderRadius: BorderRadius.circular(20)),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.black, width: 0.0),
        //   borderRadius: BorderRadius.circular(20),
        // ),
        // ),
        child: const TextOutput("button", "Button"));
  }
}
