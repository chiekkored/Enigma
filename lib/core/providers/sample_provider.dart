import 'package:enigma/core/models/sample_model.dart';
import 'package:flutter/material.dart';

class SampleProvider extends ChangeNotifier {
  final SampleModel _testData = SampleModel(test1: "", test2: "");

  SampleModel get getTestData => _testData;

  void setTestData(String newTest1, String newTest2) {
    _testData.test1 = newTest1;
    _testData.test2 = newTest2;

    // Change value to widget(s) that listens to test1 or test2
    // If NO widget(s) listening to test1 or test2 values, no need to use
    notifyListeners();
  }
}
