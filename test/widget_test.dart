import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/main.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MyApp());
  }

  testWidgets('renders lobby home', (tester) async {
    await pumpApp(tester);

    expect(find.text('登录'), findsOneWidget);
    expect(find.text('注册'), findsOneWidget);
    expect(find.text('搜索游戏'), findsOneWidget);
    expect(find.text('锦标赛'), findsOneWidget);
    expect(find.text('热门游戏'), findsOneWidget);
    expect(find.text('详细'), findsOneWidget);
    expect(find.text('娱乐城'), findsOneWidget);
  });

  testWidgets('login navigates and can go back', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('登录'));
    await tester.pumpAndSettle();

    expect(find.text('欢迎回来'), findsOneWidget);
    expect(find.text('账号'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.text('搜索游戏'), findsOneWidget);
  });

  testWidgets('detail button opens a dialog', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('详细'));
    await tester.pumpAndSettle();

    expect(find.text('锦标赛详情'), findsOneWidget);

    await tester.tap(find.text('关闭'));
    await tester.pumpAndSettle();

    expect(find.text('锦标赛详情'), findsNothing);
  });
}
