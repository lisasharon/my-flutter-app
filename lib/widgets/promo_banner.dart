import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
        height: 80,
          child: Stack(
            children: [
              const Positioned.fill(child: CustomPaint(painter: _BannerPainter())),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 5, 10, 5),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.orangeDeep, AppColors.orange],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.orange.withValues(alpha: 0.35),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.card_giftcard, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '首存赠送 ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'MX\$20.00',
                        style: TextStyle(
                          color: Color(0xFFFFE08A),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerPainter extends CustomPainter {
  const _BannerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFFE7C2),
            Color(0xFFF3C48A),
            Color(0xFFE88A5A),
            Color(0xFFD45A45),
          ],
        ).createShader(rect),
    );

    // Distant mountains.
    final mountain = Path()
      ..moveTo(0, size.height * 0.62)
      ..quadraticBezierTo(
        size.width * 0.18,
        size.height * 0.18,
        size.width * 0.38,
        size.height * 0.48,
      )
      ..quadraticBezierTo(
        size.width * 0.52,
        size.height * 0.12,
        size.width * 0.72,
        size.height * 0.42,
      )
      ..lineTo(size.width, size.height * 0.55)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      mountain,
      Paint()..color = const Color(0x66C45A3A),
    );

    _drawFan(canvas, Offset(size.width * 0.16, size.height * 0.58), 34, -0.35);
    _drawFan(canvas, Offset(size.width * 0.30, size.height * 0.70), 28, 0.2);

    final wave = Paint()
      ..color = const Color(0x88FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (var i = 0; i < 3; i++) {
      final path = Path();
      final y = size.height * 0.72 + i * 8;
      path.moveTo(size.width * 0.42, y);
      for (var x = size.width * 0.42; x < size.width; x += 18) {
        path.quadraticBezierTo(x + 6, y - 5, x + 12, y);
        path.quadraticBezierTo(x + 15, y + 4, x + 18, y);
      }
      canvas.drawPath(path, wave);
    }

    // Soft clouds.
    final cloud = Paint()..color = const Color(0x55FFFFFF);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.78, size.height * 0.28),
        width: 70,
        height: 22,
      ),
      cloud,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.58, size.height * 0.22),
        width: 50,
        height: 16,
      ),
      cloud,
    );
  }

  void _drawFan(Canvas canvas, Offset center, double radius, double tilt) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(tilt);
    final fill = Paint()
      ..shader = SweepGradient(
        startAngle: math.pi,
        endAngle: math.pi * 2,
        colors: const [
          Color(0xFFE23B2E),
          Color(0xFFFFD27A),
          Color(0xFFE23B2E),
          Color(0xFFFFF1C8),
          Color(0xFFE23B2E),
        ],
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: radius));
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: radius),
      math.pi * 1.05,
      math.pi * 0.9,
      true,
      fill,
    );
    final rib = Paint()
      ..color = const Color(0xAA7A2018)
      ..strokeWidth = 1;
    for (var i = 0; i <= 8; i++) {
      final a = math.pi * 1.05 + math.pi * 0.9 * i / 8;
      canvas.drawLine(
        Offset.zero,
        Offset(math.cos(a) * radius, math.sin(a) * radius),
        rib,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
