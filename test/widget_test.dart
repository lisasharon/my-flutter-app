import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/main.dart';

void main() {
  testWidgets('renders lobby home', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());

    expect(find.text('登录'), findsOneWidget);
    expect(find.text('注册'), findsOneWidget);
    expect(find.text('搜索游戏'), findsOneWidget);
    expect(find.text('锦标赛'), findsOneWidget);
    expect(find.text('热门游戏'), findsOneWidget);
    expect(find.text('详细'), findsOneWidget);
    expect(find.text('娱乐城'), findsOneWidget);
  });
}
