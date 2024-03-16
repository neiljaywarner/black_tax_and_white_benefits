// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_see_text.dart';
import './step/i_see_icon.dart';
import './step/i_tap_icon.dart';
import './step/i_dont_see_text.dart';

void main() {
  group('''Favorites''', () {
    Future<void> bddSetUp(WidgetTester tester) async {
      await theAppIsRunning(tester);
    }
    testWidgets('''Favorites tab is visible''', (tester) async {
      await bddSetUp(tester);
      await iSeeText(tester, 'Favorites');
      await iSeeIcon(tester, Icons.star);
    });
    testWidgets('''Navigate to favorites tab''', (tester) async {
      await bddSetUp(tester);
      await iTapIcon(tester, Icons.star);
      await iDontSeeText(tester, "Article 1");
    });
  });
}
