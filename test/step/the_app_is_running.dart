import 'package:flutter_test/flutter_test.dart';
import 'package:black_tax_and_white_benefits/main.dart';

import '../mock_posts.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(MyApp(
    posts: fetchMockPosts(),
  ));
  await tester.pump(const Duration(seconds: 1));
}
