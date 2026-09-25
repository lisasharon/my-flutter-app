import 'package:flutter/material.dart';

class Session extends ChangeNotifier {
  bool loggedIn = false;

  void signIn() {
    if (loggedIn) return;
    loggedIn = true;
    notifyListeners();
  }
}

class SessionScope extends InheritedNotifier<Session> {
  const SessionScope({
    super.key,
    required Session session,
    required super.child,
  }) : super(notifier: session);

  static Session of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SessionScope>();
    assert(scope != null, 'SessionScope not found');
    return scope!.notifier!;
  }
}
