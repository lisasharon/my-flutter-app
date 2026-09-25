import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app/main.dart';
import 'package:my_app/pages/search_page.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MyApp());
  }

  testWidgets('renders lobby home', (tester) async {
    await pumpApp(tester);

    expect(find.widgetWithText(TextButton, '登录'), findsOneWidget);
    expect(find.text('注册'), findsOneWidget);
    expect(find.text('搜索游戏'), findsOneWidget);
    expect(find.text('锦标赛'), findsOneWidget);
    expect(find.text('热门游戏'), findsOneWidget);
    expect(find.text('详细'), findsOneWidget);
    expect(find.text('娱乐城'), findsOneWidget);
  });

  testWidgets('login navigates and can go back', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.widgetWithText(TextButton, '登录'));
    await tester.pumpAndSettle();

    expect(find.text('忘记密码？'), findsWidgets);
    expect(find.text('邮箱/手机号/用户名'), findsWidgets);

    await tester.tap(find.byTooltip('关闭登录').last);
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

  testWidgets('search bar opens hot search page', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('搜索游戏'));
    await tester.pumpAndSettle();

    expect(find.text('热门搜索'), findsOneWidget);
    expect(
      find.descendant(of: find.byType(SearchPage), matching: find.text('登录')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(SearchPage), matching: find.text('注册')),
      findsOneWidget,
    );
    expect(find.text('0.00'), findsNothing);
    expect(find.text('哼哼哼'), findsOneWidget);
    expect(find.text('埃及绿宝石'), findsOneWidget);

    await tester.tap(find.byTooltip('关闭搜索'));
    await tester.pumpAndSettle();

    expect(find.text('热门搜索'), findsNothing);
    expect(find.text('锦标赛'), findsOneWidget);
  });

  testWidgets('profile tab shows login until signed in', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('我的'));
    await tester.pumpAndSettle();

    expect(find.text('忘记密码？'), findsOneWidget);
    expect(find.text('创建账号'), findsOneWidget);
    expect(find.text('或'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'demo');
    await tester.enterText(find.byType(TextField).at(1), 'secret');
    await tester.tap(find.widgetWithText(FilledButton, '登录'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();

    expect(find.text('忘记密码？'), findsNothing);
    expect(find.text('我的'), findsWidgets);
  });
}
