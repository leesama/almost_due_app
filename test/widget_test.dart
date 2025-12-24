// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:almost_due_app/app/app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Shows home header and empty state', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    GoogleFonts.config.allowRuntimeFetching = false;
    await tester.pumpWidget(const ProviderScope(child: AlmostDueApp()));
    await tester.pumpAndSettle();

    expect(find.text('快到期啦'), findsOneWidget);
    expect(find.text('物品列表'), findsOneWidget);
    expect(find.text('还没有物品哦'), findsOneWidget);
  });
}
