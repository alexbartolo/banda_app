// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:banda_app/components/output.component.dart';
import 'package:banda_app/utils/button.utils.dart';

abstract class Button extends StatelessWidget {
  final String buttonName;
  final ButtonType buttonType;
  late Function()? buttonAction = () {};
  Map<String, dynamic>? buttonActionParameters;

  set addFunction(Function() action) => buttonAction = action;

  void addParameters(Map<String, dynamic> parameters) => buttonActionParameters?.addAll(parameters);

  Button({super.key, required this.buttonName, required this.buttonType, this.buttonActionParameters});

  Widget buttonDesign(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left: 4), child: SizedBox(height: 48, child: buttonDesign(context)));
  }
}

class PrimaryButton extends Button {
  PrimaryButton({super.key, required super.buttonName, required super.buttonType, super.buttonActionParameters});

  @override
  Widget buttonDesign(BuildContext context) {
    return ElevatedButton(
        onPressed: buttonAction,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.only(left: 24, right: 24)),
        child: TextOutput(textOutputBody: buttonName, textOutputStyle: "Button"));
  }
}

class SecondaryButton extends Button {
  SecondaryButton({super.key,required super.buttonName, required super.buttonType, super.buttonActionParameters});

  @override
  Widget buttonDesign(BuildContext context) {
    return OutlinedButton(
        onPressed: buttonAction,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blue), padding: const EdgeInsets.only(left: 24, right: 24)),
        child: TextOutput(textOutputBody: buttonName, textOutputStyle: "Button"));
  }
}

class ButtonGroup extends StatelessWidget {
  final List<Button> buttons;

  const ButtonGroup({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: [
      for (Button button in buttons) ...{button}
    ]);
  }
}

class SquareIconButton extends StatelessWidget {
  final TextEditingController textEditingController;
  final Widget buttonIcon;
  final Future Function(BuildContext) buttonAction;

  const SquareIconButton(
      {super.key, required this.textEditingController, required this.buttonIcon, required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 4),
        child: SizedBox(
            height: 62,
            width: 62,
            child: IconButton(
                onPressed: () async {
                  textEditingController.text = await buttonAction(context);
                },
                style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    side: const BorderSide(color: Colors.grey)),
                icon: buttonIcon)));
  }
}

class DateButton extends SquareIconButton {
  const DateButton(
      {super.key,
      super.buttonIcon = const Icon(Icons.calendar_month),
      required super.textEditingController,
      super.buttonAction = dateButtonAction});
}

class TimeButton extends SquareIconButton {
  const TimeButton(
      {super.key,
      super.buttonIcon = const Icon(Icons.access_time_filled),
      required super.textEditingController,
      super.buttonAction = timeButtonAction});
}
