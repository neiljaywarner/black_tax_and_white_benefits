// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_see_text.dart';

void main() {
  group('''Home''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAppIsRunning(tester);
    }
    testWidgets('''Home screen appears''', (tester) async {
      await bddSetUp(tester);
      await iSeeText(tester, 'Home');
      await iSeeText(tester, 'Black Tax White Benefits');
    });
    testWidgets('''Posts load''', (tester) async {
      await bddSetUp(tester);
      await iSeeText(tester, 'Article 1');
      await iSeeText(tester, 'Article 2');
    });
  });
}
