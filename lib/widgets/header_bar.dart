import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../theme.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  Future<void> _open(
    BuildContext context, {
    required Widget page,
    required String successText,
  }) async {
    final ok = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => page),
    );
    if (ok == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(successText),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Row(
        children: [
          const AppLogo(),
          const Spacer(),
          TextButton(
            onPressed: () => _open(
              context,
              page: const LoginPage(),
              successText: '登录成功',
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            child: const Text(
              '登录',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 4),
          FilledButton(
            onPressed: () => _open(
              context,
              page: const RegisterPage(),
              successText: '注册成功',
            ),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.green,
              foregroundColor: const Color(0xFF07301A),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '注册',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'UP',
            style: TextStyle(
              color: AppColors.cyan,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: -0.6,
              height: 1,
            ),
          ),
          TextSpan(
            text: 'BET',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              letterSpacing: -0.6,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
