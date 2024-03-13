// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_tap_text.dart';
import './step/i_see_icon.dart';
import './step/i_see_text.dart';

void main() {
  group('''Post''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAppIsRunning(tester);
    }
    testWidgets('''Article loads''', (tester) async {
      await bddSetUp(tester);
      await iTapText(tester, 'Article 1');
      await iSeeIcon(tester, Icons.share);
      await iSeeIcon(tester, Icons.star_border);
      await iSeeText(tester, 'Something big happened');
    });
  });
}
