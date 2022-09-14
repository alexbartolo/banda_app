import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:banda_app/components/output.component.dart';

class DateOrTimeButton extends StatelessWidget {
  final TextEditingController textEditingController;
  Widget? buttonIcon;
  Future Function(BuildContext)? value;

  DateOrTimeButton.date(
      {Key? key, required this.textEditingController})
      : super(key: key) {
    buttonIcon = const Icon(Icons.calendar_month);
    value = (context) async {
      return DateFormat('dd/MM/yyy').format(await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1, 12, 31)) as DateTime)
          as String Function();
    };
  }

  DateOrTimeButton.time(
      {Key? key, required this.textEditingController})
      : super(key: key) {
    buttonIcon = const Icon(Icons.access_time_filled);
    value = (context) async {
      return (await showTimePicker(
              context: context, initialTime: TimeOfDay.now()))
          ?.format(context) as String;
    };
  }

  // void test = () async {
  //   switch (type) {
  //     case "date":
  //       textEditingController.text = DateFormat('dd/MM/yyy').format(
  //           await showDatePicker(
  //                   context: context,
  //                   initialDate: DateTime.now(),
  //                   firstDate: DateTime.now(),
  //                   lastDate: DateTime(DateTime.now().year + 1, 12, 31))
  //               as DateTime);
  //       break;

  //     case "time":
  //       textEditingController.text = (await showTimePicker(
  //               context: context, initialTime: TimeOfDay.now()))
  //           ?.format(context) as String;
  //       break;
  //   }
  // };

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: SizedBox(
            height: 62,
            width: 62,
            child: IconButton(
                onPressed: () async {textEditingController.text = value!(context) as String;},
                style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    side: const BorderSide(color: Colors.grey)),
                icon: buttonIcon as Widget)));
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
