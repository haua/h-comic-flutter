// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:h_comic_flutter/model/ComicModel.dart';

void main() {
  test('Counter increments smoke test', () async {
    List<ComicModel> res = await ComicModel.getPage();

    // Verify that our counter has incremented.
    expect(res.length > 0, true);
  });
}
