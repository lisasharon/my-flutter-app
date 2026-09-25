import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/header_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.onSuccess, this.onClose});

  /// 嵌在个人中心里时传入。成功后更新登录状态，不再弹出本页。
  final VoidCallback? onSuccess;
  final VoidCallback? onClose;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _account = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _account.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_account.text.trim().isEmpty || _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入账号和密码')),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text('确认登录', style: TextStyle(color: Colors.white)),
          content: Text(
            '使用 ${_account.text.trim()} 登录？',
            style: const TextStyle(color: AppColors.muted),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消', style: TextStyle(color: AppColors.muted)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('确定', style: TextStyle(color: AppColors.green)),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      final onSuccess = widget.onSuccess;
      if (onSuccess != null) {
        onSuccess();
      } else {
        Navigator.pop(context, true);
      }
    }
  }

  void _close() {
    final onClose = widget.onClose;
    if (onClose != null) {
      onClose();
    } else {
      Navigator.pop(context);
    }
  }

  void _soon(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _openRegister() async {
    final ok = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
    if (ok == true && mounted) {
      final onSuccess = widget.onSuccess;
      if (onSuccess != null) {
        onSuccess();
      } else {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Row(
                children: [
                  const AppLogo(),
                  const Spacer(),
                  IconButton(
                    tooltip: '客服',
                    onPressed: () => _soon('客服暂未开放'),
                    icon: const Icon(Icons.headset_mic_outlined, color: Colors.white),
                  ),
                  IconButton(
                    tooltip: '关闭登录',
                    onPressed: _close,
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 148,
            width: double.infinity,
            child: CustomPaint(painter: _CasinoBannerPainter()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '登录',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                _AuthField(
                  controller: _account,
                  hint: '邮箱/手机号/用户名',
                ),
                const SizedBox(height: 12),
                _AuthField(
                  controller: _password,
                  hint: '请输入登录密码',
                  obscure: _obscure,
                  suffix: IconButton(
                    tooltip: _obscure ? '显示密码' : '隐藏密码',
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(
                      _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.muted,
                      size: 20,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _soon('忘记密码暂未开放'),
                    child: const Text(
                      '忘记密码？',
                      style: TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                  ),
                ),
                _LoginGradientButton(onPressed: _submit),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Text(
                      '还没有账号？',
                      style: TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                    TextButton(
                      onPressed: _openRegister,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        '创建账号',
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => _soon('解锁暂未开放'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        '解锁',
                        style: TextStyle(color: AppColors.muted, fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xFF243646))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('或', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                    ),
                    Expanded(child: Divider(color: Color(0xFF243646))),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(
                      tooltip: 'Facebook 登录',
                      color: const Color(0xFF1877F2),
                      child: const Text(
                        'f',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      onPressed: () => _soon('Facebook 登录暂未开放'),
                    ),
                    const SizedBox(width: 16),
                    _SocialButton(
                      tooltip: 'Google 登录',
                      color: const Color(0xFF1C2A36),
                      child: const Text(
                        'G',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      onPressed: () => _soon('Google 登录暂未开放'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginGradientButton extends StatelessWidget {
  const _LoginGradientButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E9B45), Color(0xFF8BE36A)],
        ),
      ),
      child: SizedBox(
        height: 46,
        width: double.infinity,
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: const Color(0xFF102416),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: const Text(
            '登录',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _account = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _account.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_account.text.trim().isEmpty || _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请填写账号和密码')),
      );
      return;
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('注册'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          const Text(
            '创建账号',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '填写信息后即可完成注册',
            style: TextStyle(color: AppColors.muted, fontSize: 13),
          ),
          const SizedBox(height: 28),
          _AuthField(controller: _account, hint: '账号'),
          const SizedBox(height: 12),
          _AuthField(controller: _password, hint: '密码', obscure: true),
          const SizedBox(height: 24),
          _AuthButton(label: '注册', onPressed: _submit),
        ],
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.suffix,
  });

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.muted),
        filled: true,
        fillColor: const Color(0xFF10202C),
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  const _AuthButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.green,
          foregroundColor: const Color(0xFF07301A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.tooltip,
    required this.color,
    required this.child,
    required this.onPressed,
  });

  final String tooltip;
  final Color color;
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(width: 54, height: 44, child: Center(child: child)),
        ),
      ),
    );
  }
}

class _CasinoBannerPainter extends CustomPainter {
  const _CasinoBannerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A2430), Color(0xFF0C2A22), Color(0xFF07141E)],
        ).createShader(rect),
    );

    final felt = Paint()..color = const Color(0xFF0E6B45);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.72),
        width: size.width * 0.92,
        height: size.height * 0.55,
      ),
      felt,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.72),
        width: size.width * 0.72,
        height: size.height * 0.34,
      ),
      Paint()..color = const Color(0xFF14945C),
    );

    final rail = Paint()
      ..color = const Color(0xFF8A5A32)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.72),
        width: size.width * 0.92,
        height: size.height * 0.55,
      ),
      rail,
    );

    final dealer = Paint()..color = const Color(0xFFD7C4A3);
    canvas.drawCircle(Offset(size.width * 0.62, size.height * 0.28), 14, dealer);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.62, size.height * 0.52),
          width: 36,
          height: 42,
        ),
        const Radius.circular(8),
      ),
      Paint()..color = const Color(0xFF1E1E1E),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
