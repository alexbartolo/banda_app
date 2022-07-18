import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String titleText;
  const TitleText(this.titleText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(titleText);
  }
}

class RegularText extends StatelessWidget {
  final String titleText;
  const RegularText(this.titleText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(titleText);
  }
}
