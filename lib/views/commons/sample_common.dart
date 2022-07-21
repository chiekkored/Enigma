import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

/// Sample Button
///
/// @param sampleText If data is passed in a widget, list here
/// @param sampleImage Put description here
class SampleButton extends StatelessWidget {
  final String sampleText;
  final String sampleImage;
  const SampleButton(
      {Key? key, required this.sampleText, required this.sampleImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SampleButtonTransparent extends StatelessWidget {
  const SampleButtonTransparent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
