import 'package:flutter/material.dart';

import '../../session.dart';
import '../../theme.dart';
import '../login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.onClose});

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final session = SessionScope.of(context);
    if (!session.loggedIn) {
      return LoginPage(onSuccess: session.signIn, onClose: onClose);
    }

    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_outline, size: 42, color: AppColors.muted),
          SizedBox(height: 10),
          Text(
            '我的',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
