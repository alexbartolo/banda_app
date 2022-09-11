import 'package:flutter/material.dart';
import './components.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              FormInput(formFields: const [
                TextInput(inputName: "phone", inputType: "phone"),
                TextInput(inputName: "time", inputType: "time"),
                TextInput(inputName: "date", inputType: "date"),
                TextInput(inputName: "email", inputType: "email"),
                CheckboxInput(checkboxName: "checkbox"),
                DropdownInput(
                    dropdownName: "dropdown",
                    dropdownOptions: ["test1", "test2", "test3", "test4"]),
              ],
              context: context,),
              const ButtonGroup(buttons: [
                SecondaryButton(buttonName: "test"),
                PrimaryButton(buttonName: "primaryy")
              ])
            ])));
  }
}
