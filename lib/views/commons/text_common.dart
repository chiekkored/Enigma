import 'package:flutter/material.dart';

class CustomTextRegular extends StatelessWidget {
  final String text;
  const CustomTextRegular({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.button,
    );
  }
}
