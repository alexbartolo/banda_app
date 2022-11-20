import 'dart:convert';

import 'package:banda_app/models/form.model.dart';
import 'package:banda_app/utils/button.utils.dart';
import 'package:banda_app/utils/file.utils.dart';
import 'package:flutter/material.dart';
import 'package:banda_app/components/button.component.dart';
import 'package:banda_app/components/input.component.dart';
import 'package:banda_app/components/output.component.dart';
import 'utils/global.utils.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: "Product Sans",
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Components Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // bool success = false;
  @override
  void initState() {
    super.initState();

    storage.read("test").then((value) => setState(() => storage.addNewEntry = value));
    // setState;

    // .then((value) {
    //   setState(() {
    //     // if (value != "[]") {
    //       data["test"] = value
    //           // json.decode(json.decode(value))
    //           .map<FormData>(
    //             (testValue) => FormData.from(type: 'test',
    //               newData: testValue,
    //               keys: testData,
    //             ),
    //           )
    //           .toList();
    //     // }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FormInput(
                formFields: [
                  TextInput(inputName: "name", inputType: "name", inputIcon: const Icon(Icons.face)),
                  TextInput(inputName: "text", inputType: "text", inputIcon: const Icon(Icons.text_fields)),
                  TextInput(inputName: "phone", inputType: "phone", inputIcon: const Icon(Icons.phone)),
                  TextInput(inputName: "time", inputType: "time", inputIcon: const Icon(Icons.access_time)),
                  TextInput(inputName: "date", inputType: "date", inputIcon: const Icon(Icons.calendar_month)),
                  TextInput(inputName: "email", inputType: "email", inputIcon: const Icon(Icons.email_outlined)),
                  CheckboxInput(checkboxName: "checkbox"),
                  DropdownInput(
                    dropdownName: "dropdown",
                    dropdownOptions: const ["test1", "test2", "test3", "test4"],
                    dropdownIcon: const Icon(Icons.water_drop_outlined),
                  ),
                  RadioInput(
                    radioOptions: const ["radioOption 1", "radioOption 2"],
                    radioIcons: const [Icon(Icons.dangerous), Icon(Icons.face)],
                    defaultRadioOption: "radioOption 2",
                  )
                ],
                buttons: ButtonGroup(
                  buttons: [
                    SecondaryButton(
                        buttonName: "Modal",
                        buttonType: ButtonType.openModalScreen,
                        buttonActionParameters: {
                          "screen": FormOutput(
                              testForm: storage.getEntryIndex('test') != -1
                                  ? storage.dataEntries[storage.getEntryIndex('test')].data.isNotEmpty
                                      ? storage.dataEntries[storage.getEntryIndex('test')].data.first
                                      : FormData.empty(type: "test", keys: testData)
                                  : FormData.empty(type: "test", keys: testData)) as dynamic
                        }),
                    PrimaryButton(
                      buttonName: "Save",
                      buttonType: ButtonType.save,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
